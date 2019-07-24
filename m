Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0ECC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A888721873
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998200;
	bh=hygfxUnhRRRgvEitfN/Wq1MohQdribeKFPo944sF2GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LlyNTHZ/PBqO7HwDlhlN0E/DHbejtzwEqa/Vmwj2O8Fjhu4tQhtQL32HH01PYWfmW
	 eezfNxj3cn2ov61ud1yR6yHGI4LcvZJV7Z6hpH7i+Te8k8JITts4kxgMOu7JhxnQPX
	 2icXwpU3j+BW92SSuW14nhbgqP0R6KeF38nYHh8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404681AbfGXT4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404404AbfGXT4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:56:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B789921873;
        Wed, 24 Jul 2019 19:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998196;
        bh=hygfxUnhRRRgvEitfN/Wq1MohQdribeKFPo944sF2GE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1/3Fv9nMZC6vAPaBnudM4WzUY/Dj405juMg6fS+8bsY2A8QwPsnXeGCHvYG7zWOhY
         QkbxmBCoZzbbUAVm4h1+NYhgHRgoee64aJPPKqVE8lYnisJP8D7wRgRmX3qN6GtpxD
         FBSQiQpjUSM07CNpnUkS7TQM0uqhZ3cSfioEsXdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 5.1 280/371] pnfs/flexfiles: Fix PTR_ERR() dereferences in ff_layout_track_ds_error
Date:   Wed, 24 Jul 2019 21:20:32 +0200
Message-Id: <20190724191745.348396406@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
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


