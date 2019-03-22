Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98005C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661EE218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257302;
	bh=cbfvLIGZ+jVcCOxilYEZdGUuZsDK4epX1dvDpz0ZjV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k2EqTp0Ayl0Uf+zJUnqjTisClCec0QnfKAkWQOiJjdOfp/KLAPrRf5L0nXiab7Pnk
	 IVKy2w2iC9sXFNVqLVYnwumnPlsuZCBQGTHh+MI88R2rI3T6ZsmoF/8AXrocxX4zqK
	 7znHWsbEy79guaKvVd42MaNcKhXzLSTZ7SCqhbX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390898AbfCVMVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390890AbfCVMVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:21:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E856B2054F;
        Fri, 22 Mar 2019 12:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257296;
        bh=cbfvLIGZ+jVcCOxilYEZdGUuZsDK4epX1dvDpz0ZjV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cAdRwKPjRa8aLm1uZY6+sBmyYXJ0i4nHaSQ6Hn3Wq8lMCFMl+zfbX/E6VBpf5y1xi
         NdhEnGriJe1nAR6r2qozmRpOa1UgtlDllqlUm2uUqDlidb0EKvQuiPjXly3twkU2SG
         kRd8rsZG2qoUjTdiIKYu6zenLDO0WIVt7IiJjpjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 5.0 188/238] nfsd: fix memory corruption caused by readdir
Date:   Fri, 22 Mar 2019 12:16:47 +0100
Message-Id: <20190322111309.327041880@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -463,8 +463,19 @@ nfsd3_proc_readdir(struct svc_rqst *rqst
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
@@ -533,6 +544,7 @@ nfsd3_proc_readdirplus(struct svc_rqst *
 		} else {
 			xdr_encode_hyper(resp->offset, offset);
 		}
+		resp->offset = NULL;
 	}
 
 	RETURN_STATUS(nfserr);
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -921,6 +921,7 @@ encode_entry(struct readdir_cd *ccd, con
 		} else {
 			xdr_encode_hyper(cd->offset, offset64);
 		}
+		cd->offset = NULL;
 	}
 
 	/*


