Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DF2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A746A218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254027;
	bh=LjjXYsu0PWOUfAgeTCYH9hX5gxdmY10x7Dp7firFYiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d72X24Hxol4hjDlYeaNCnkpsjWfvxLv9FZPeP8OP0L1XiKn3qJBDj36s0G43Oc4wb
	 FHd09MqC0QyW9LBJVnjAzAHROs1afZJE2G9g0W2k5cN/Y+7xwKmQvf69HH+plNYCJa
	 LYA9380YGKxLYmFvcyUb7RRyywqdGV3h6TGcS7w4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfCVL1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729497AbfCVL1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:27:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7B5C20657;
        Fri, 22 Mar 2019 11:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254022;
        bh=LjjXYsu0PWOUfAgeTCYH9hX5gxdmY10x7Dp7firFYiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0qnJLnhvM3/Kih41yZKHyLdrkfgQI5pID9Z67W7vcjR1zXr8uUzeKAbkJuHuQaSqA
         e196sTZr2xousC1rqgMM5OuBxfa2Mabnzoldlk3xEEc6egoJTEIxVf7YIPAXRClP3x
         QNBFB4tgxRdwS/BJyzzy3DNr822oJKxwK71pzvbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 3.18 129/134] nfsd: fix memory corruption caused by readdir
Date:   Fri, 22 Mar 2019 12:15:42 +0100
Message-Id: <20190322111219.860961453@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -892,6 +892,7 @@ encode_entry(struct readdir_cd *ccd, con
 		} else {
 			xdr_encode_hyper(cd->offset, offset64);
 		}
+		cd->offset = NULL;
 	}
 
 	/*


