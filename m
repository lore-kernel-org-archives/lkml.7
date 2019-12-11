Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9C8C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D4A20836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079921;
	bh=pVBuCuaPElvOO28i5x9YeOhkvZD/mwC1UK4HUXmlsAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B0fI+8dlFdnlYZdO6tA+DA0niODTXT/X10ATgOsBXdx7yMNXUp01svTlrbwBtLWL+
	 Brm9pQzTM6DpBLvKuR6q3w7lO3aA18jEyazgKi34v+bPBIWrWmAz2TK/grzPZi4sfE
	 LkiOmMj6+jYOclvP1E9f81C/t6JY3Vhl9xhOwD4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbfLKP6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:58:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730925AbfLKPOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:14:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15E1D24691;
        Wed, 11 Dec 2019 15:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077255;
        bh=pVBuCuaPElvOO28i5x9YeOhkvZD/mwC1UK4HUXmlsAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=twbLLzCDWIMYbq4nrY+NHUX7w4TdRtnEF9gAje4rOPsxBlksv731xoZ0Xz4PZM6WH
         HsUvhBRC6Imp89YPvNP0k7wb6YEOiYnttEM2VtCjqLuznvEfGdKKvS/r2a25QzcJ6R
         9LfKofL14xmNsb3Q92I5AolkfHtONeqIjuNwOYIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 5.3 074/105] drm/i810: Prevent underflow in ioctl
Date:   Wed, 11 Dec 2019 16:06:03 +0100
Message-Id: <20191211150253.249313601@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.153659747@linuxfoundation.org>
References: <20191211150221.153659747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 4f69851fbaa26b155330be35ce8ac393e93e7442 upstream.

The "used" variables here come from the user in the ioctl and it can be
negative.  It could result in an out of bounds write.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20191004102251.GC823@mwanda
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i810/i810_dma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i810/i810_dma.c
+++ b/drivers/gpu/drm/i810/i810_dma.c
@@ -721,7 +721,7 @@ static void i810_dma_dispatch_vertex(str
 	if (nbox > I810_NR_SAREA_CLIPRECTS)
 		nbox = I810_NR_SAREA_CLIPRECTS;
 
-	if (used > 4 * 1024)
+	if (used < 0 || used > 4 * 1024)
 		used = 0;
 
 	if (sarea_priv->dirty)
@@ -1041,7 +1041,7 @@ static void i810_dma_dispatch_mc(struct
 	if (u != I810_BUF_CLIENT)
 		DRM_DEBUG("MC found buffer that isn't mine!\n");
 
-	if (used > 4 * 1024)
+	if (used < 0 || used > 4 * 1024)
 		used = 0;
 
 	sarea_priv->dirty = 0x7f;


