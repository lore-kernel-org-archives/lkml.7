Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D6AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210DA21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256611;
	bh=5WWqjiJKXtuyWsMBdJ4wOWzPdTFUmozNWhPIasFC9T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0UQGZF/u9xNOeHB3mp/MXKOByowQwDbYse99omF/P8+6zaXuj6ZXa20ru+IbwOfrI
	 yzsoKA5PLLYEKiRtGPEA8NiLoomg+Nj3IJuwJ2Fv6TIbZefNU7ccxr2YrAcWfDCD3u
	 NVG3+vqrn9CUSnfbdMFmf7+atIWi4MMCTJRgHghs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389394AbfCVMKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388044AbfCVMKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:10:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEBBE21929;
        Fri, 22 Mar 2019 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256606;
        bh=5WWqjiJKXtuyWsMBdJ4wOWzPdTFUmozNWhPIasFC9T0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0x/YtRdSYnDPTFh280BdPNHz1kwaF9OYtLKqyePYjwcRrPgtnFx3fTGti3+BWjFtK
         Jorb4bM6TW9tjJ40yNaR/rpZG9vwevh51uvro8Qq6Q6XywuYjjDboPEAlare8B5wbS
         UA+Zv+vufPwm2+p/SI0wSgONWi8NHvX/AydM3kkU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.19 240/280] NFS: Fix I/O request leakages
Date:   Fri, 22 Mar 2019 12:16:33 +0100
Message-Id: <20190322111339.254405600@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit f57dcf4c72113c745d83f1c65f7291299f65c14f upstream.

When we fail to add the request to the I/O queue, we currently leave it
to the caller to free the failed request. However since some of the
requests that fail are actually created by nfs_pageio_add_request()
itself, and are not passed back the caller, this leads to a leakage
issue, which can again cause page locks to leak.

This commit addresses the leakage by freeing the created requests on
error, using desc->pg_completion_ops->error_cleanup()

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Fixes: a7d42ddb30997 ("nfs: add mirroring support to pgio layer")
Cc: stable@vger.kernel.org # v4.0: c18b96a1b862: nfs: clean up rest of reqs
Cc: stable@vger.kernel.org # v4.0: d600ad1f2bdb: NFS41: pop some layoutget
Cc: stable@vger.kernel.org # v4.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/pagelist.c |   26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -989,6 +989,17 @@ static void nfs_pageio_doio(struct nfs_p
 	}
 }
 
+static void
+nfs_pageio_cleanup_request(struct nfs_pageio_descriptor *desc,
+		struct nfs_page *req)
+{
+	LIST_HEAD(head);
+
+	nfs_list_remove_request(req);
+	nfs_list_add_request(req, &head);
+	desc->pg_completion_ops->error_cleanup(&head);
+}
+
 /**
  * nfs_pageio_add_request - Attempt to coalesce a request into a page list.
  * @desc: destination io descriptor
@@ -1026,10 +1037,8 @@ static int __nfs_pageio_add_request(stru
 			nfs_page_group_unlock(req);
 			desc->pg_moreio = 1;
 			nfs_pageio_doio(desc);
-			if (desc->pg_error < 0)
-				return 0;
-			if (mirror->pg_recoalesce)
-				return 0;
+			if (desc->pg_error < 0 || mirror->pg_recoalesce)
+				goto out_cleanup_subreq;
 			/* retry add_request for this subreq */
 			nfs_page_group_lock(req);
 			continue;
@@ -1062,6 +1071,10 @@ err_ptr:
 	desc->pg_error = PTR_ERR(subreq);
 	nfs_page_group_unlock(req);
 	return 0;
+out_cleanup_subreq:
+	if (req != subreq)
+		nfs_pageio_cleanup_request(desc, subreq);
+	return 0;
 }
 
 static int nfs_do_recoalesce(struct nfs_pageio_descriptor *desc)
@@ -1169,11 +1182,14 @@ int nfs_pageio_add_request(struct nfs_pa
 		if (nfs_pgio_has_mirroring(desc))
 			desc->pg_mirror_idx = midx;
 		if (!nfs_pageio_add_request_mirror(desc, dupreq))
-			goto out_failed;
+			goto out_cleanup_subreq;
 	}
 
 	return 1;
 
+out_cleanup_subreq:
+	if (req != dupreq)
+		nfs_pageio_cleanup_request(desc, dupreq);
 out_failed:
 	/* remember fatal errors */
 	if (nfs_error_is_fatal(desc->pg_error))


