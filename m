Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2FFC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6615620665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997064;
	bh=hygfxUnhRRRgvEitfN/Wq1MohQdribeKFPo944sF2GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d1aUVkG3/SCt1T5aWCF9cXEWTPpIQeeSuEqnoiPHuL1b0Sf36SHH0z8P9BXK3BdSv
	 JyGLjFykJ5I6XrqHjv2DZGOFEY58A8WUr2yGnBOtZyGiAK7IHk7GLhF34VspCeSCAg
	 TIAxW+mAf42tXCA3WvxrbfWi2Nn3DIySeKCy3i6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389494AbfGXThi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389477AbfGXThe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:37:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0466229F3;
        Wed, 24 Jul 2019 19:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997054;
        bh=hygfxUnhRRRgvEitfN/Wq1MohQdribeKFPo944sF2GE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ivZmCURQLzTWKUk9UJ5BqUOKGdu0kAlei7jksCWZJ9TVezQ1erGPvqw7ZTtz8zbcE
         XbOhh7k3HkHIABvn090UGq9XPPU+0PFgZGMuU3FBWTNphOAmEskYQg9lkaRxISzEu4
         nAI0ii+SzoHvar6x6muWg8eUUAwJNJ0TrrFpNpSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.2 306/413] pnfs/flexfiles: Fix PTR_ERR() dereferences in ff_layout_track_ds_error
Date:   Wed, 24 Jul 2019 21:19:57 +0200
Message-Id: <20190724191757.683583639@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 8e04fdfadda75a849c649f7e50fe7d97772e1fcb upstream.

mirror->mirror_ds can be NULL if uninitialised, but can contain
a PTR_ERR() if call to GETDEVICEINFO failed.

Fixes: 65990d1afbd2 ("pNFS/flexfiles: Fix a deadlock on LAYOUTGET")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # 4.10+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -257,7 +257,7 @@ int ff_layout_track_ds_error(struct nfs4
 	if (status == 0)
 		return 0;
 
-	if (mirror->mirror_ds == NULL)
+	if (IS_ERR_OR_NULL(mirror->mirror_ds))
 		return -EINVAL;
 
 	dserr = kmalloc(sizeof(*dserr), gfp_flags);


