Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D618FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C782192B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255715;
	bh=6Ud9GoHjksqmxqkpATUdaPiIW+zzRBrT2GaLSAcVQh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nR6ynCZsT2gt/1xcP1LnD62+cWaB0CI9IfQ+/v9elpaGZce+jXzZRnV79mGAloAug
	 zndzWYpz7s0DDqoa0SbLVFWAdC9jgFYyoPC5jwwiQcJrOXra9yOU8H0FMnwPBSikgk
	 kpcF8pow3nvgcwTK+8dZX161IxXKcbaN+zeGlbpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733286AbfCVLzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733270AbfCVLzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:55:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B9522192C;
        Fri, 22 Mar 2019 11:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255711;
        bh=6Ud9GoHjksqmxqkpATUdaPiIW+zzRBrT2GaLSAcVQh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gKbpcv7CDIRwTAQOyf3BAlB8a0afHblBd3Svutapj1pgXryDEIyKjznBiI5r34I4W
         aSvK1ZeR4teZZ8NgVYCxuV/TyfoyUSKZ/6uKmvdDUA0H4IqZRWjyhSQPtOLHaEa8p2
         dwe2NcYnZCBulOe7PwLuFxJyMFY6wfPL9gIdcgwE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.14 157/183] nfsd: fix memory corruption caused by readdir
Date:   Fri, 22 Mar 2019 12:16:25 +0100
Message-Id: <20190322111253.279785399@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -446,8 +446,19 @@ nfsd3_proc_readdir(struct svc_rqst *rqst
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
@@ -516,6 +527,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *
 		} else {
 			xdr_encode_hyper(resp->offset, offset);
 		}
+		resp->offset = NULL;
 	}
 
 	RETURN_STATUS(nfserr);
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -922,6 +922,7 @@ encode_entry(struct readdir_cd *ccd, con
 		} else {
 			xdr_encode_hyper(cd->offset, offset64);
 		}
+		cd->offset = NULL;
 	}
 
 	/*


