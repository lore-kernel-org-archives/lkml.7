Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4445C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940882082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255115;
	bh=sM0NgIw2v9EHs41AbeK96Viv0Vv5pi6P6bVSzy6Z4yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=naKZHHtemx0UswikTRYEOMf7589WreuoiAu2QsVwI/FW+p+tUrVl7bxQJ25qkrwRZ
	 t6qD3vqKx6vuiOhh+T/jWbk+7FFLN2Uv/xgpF0B/ZjceungOGPh/hhIxpgYqWXV0lx
	 jlTq+4chb0e0ZZnjCyVPxM2fdGsh2YTskLPC3dUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbfCVLpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731010AbfCVLpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:45:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63E3721934;
        Fri, 22 Mar 2019 11:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255109;
        bh=sM0NgIw2v9EHs41AbeK96Viv0Vv5pi6P6bVSzy6Z4yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lyD45Lq0mePpnIU12biAGAKONJaeJkIBCYbtDwTYmCGNWMlNLJo7LdJ5TLbuzplDA
         B+qQRj2jX6QSidbP5ozMWgkVuhfaxGaJFCOJKnMwpIo1I76SfgxOKBMMZn1rvWCPTD
         rllm+K8jQdXUuslzyT+BVw274u3GSuTPIF+bCmxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.9 101/118] NFS: Fix I/O request leakages
Date:   Fri, 22 Mar 2019 12:16:13 +0100
Message-Id: <20190322111223.506026668@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -975,6 +975,17 @@ static void nfs_pageio_doio(struct nfs_p
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
@@ -1012,10 +1023,8 @@ static int __nfs_pageio_add_request(stru
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
 			nfs_page_group_lock(req, false);
 			continue;
@@ -1048,6 +1057,10 @@ err_ptr:
 	desc->pg_error = PTR_ERR(subreq);
 	nfs_page_group_unlock(req);
 	return 0;
+out_cleanup_subreq:
+	if (req != subreq)
+		nfs_pageio_cleanup_request(desc, subreq);
+	return 0;
 }
 
 static int nfs_do_recoalesce(struct nfs_pageio_descriptor *desc)
@@ -1141,11 +1154,14 @@ int nfs_pageio_add_request(struct nfs_pa
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
 	/*
 	 * We might have failed before sending any reqs over wire.


