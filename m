Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530B7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2465D2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254728;
	bh=yhzijB6uv78EPi1NSOj5avCXEiMuEgGBnsZQuERjaLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vdTsop3BI8PfusvezM5gOf98EHqqtCbxxLvBO+oXn7GcKsN0Fnhw4LDJkGVdg3ZyR
	 rVMWwXmdd6+RrJDREhFCvmtgFiA1P/2jSjYEC5Iq8ZHlHzjHODTQ/C31/hQSYmRKxu
	 aEvovppH1ofZGs0iMy/HXn12RnMe9FbQEs7AJWww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbfCVLip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730452AbfCVLio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:38:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20EA82082C;
        Fri, 22 Mar 2019 11:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254722;
        bh=yhzijB6uv78EPi1NSOj5avCXEiMuEgGBnsZQuERjaLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KNChdOFIOL0IlCO7AgSbV4oTU8+22ezku8kH1czOIJQDcXAJH7tQ5IfbpuRG4f7mM
         9LNO1T3bgSfuJ+X3O4EOEMXAlxElrSlRI3AkzE8H9Xcisif+ArP/FCEQb1UOycclit
         yx3E+Z3sIPlYTpv3xc5vT989yJVVZLP3A+9P4QkI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.4 222/230] nfsd: fix memory corruption caused by readdir
Date:   Fri, 22 Mar 2019 12:16:00 +0100
Message-Id: <20190322111252.494344395@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>

commit b602345da6cbb135ba68cf042df8ec9a73da7981 upstream.

If the result of an NFSv3 readdir{,plus} request results in the
"offset" on one entry having to be split across 2 pages, and is sized
so that the next directory entry doesn't fit in the requested size,
then memory corruption can happen.

When encode_entry() is called after encoding the last entry that fits,
it notices that ->offset and ->offset1 are set, and so stores the
offset value in the two pages as required.  It clears ->offset1 but
*does not* clear ->offset.

Normally this omission doesn't matter as encode_entry_baggage() will
be called, and will set ->offset to a suitable value (not on a page
boundary).
But in the case where cd->buflen < elen and nfserr_toosmall is
returned, ->offset is not reset.

This means that nfsd3proc_readdirplus will see ->offset with a value 4
bytes before the end of a page, and ->offset1 set to NULL.
It will try to write 8bytes to ->offset.
If we are lucky, the next page will be read-only, and the system will
  BUG: unable to handle kernel paging request at...

If we are unlucky, some innocent page will have the first 4 bytes
corrupted.

nfsd3proc_readdir() doesn't even check for ->offset1, it just blindly
writes 8 bytes to the offset wherever it is.

Fix this by clearing ->offset after it is used, and copying the
->offset handling code from nfsd3_proc_readdirplus into
nfsd3_proc_readdir.

(Note that the commit hash in the Fixes tag is from the 'history'
 tree - this bug predates git).

Fixes: 0b1d57cf7654 ("[PATCH] kNFSd: Fix nfs3 dentry encoding")
Fixes-URL: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=0b1d57cf7654
Cc: stable@vger.kernel.org (v2.6.12+)
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfs3proc.c |   16 ++++++++++++++--
 fs/nfsd/nfs3xdr.c  |    1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -430,8 +430,19 @@ nfsd3_proc_readdir(struct svc_rqst *rqst
 					&resp->common, nfs3svc_encode_entry);
 	memcpy(resp->verf, argp->verf, 8);
 	resp->count = resp->buffer - argp->buffer;
-	if (resp->offset)
-		xdr_encode_hyper(resp->offset, argp->cookie);
+	if (resp->offset) {
+		loff_t offset = argp->cookie;
+
+		if (unlikely(resp->offset1)) {
+			/* we ended up with offset on a page boundary */
+			*resp->offset = htonl(offset >> 32);
+			*resp->offset1 = htonl(offset & 0xffffffff);
+			resp->offset1 = NULL;
+		} else {
+			xdr_encode_hyper(resp->offset, offset);
+		}
+		resp->offset = NULL;
+	}
 
 	RETURN_STATUS(nfserr);
 }
@@ -499,6 +510,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *
 		} else {
 			xdr_encode_hyper(resp->offset, offset);
 		}
+		resp->offset = NULL;
 	}
 
 	RETURN_STATUS(nfserr);
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -898,6 +898,7 @@ encode_entry(struct readdir_cd *ccd, con
 		} else {
 			xdr_encode_hyper(cd->offset, offset64);
 		}
+		cd->offset = NULL;
 	}
 
 	/*


