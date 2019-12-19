Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B04C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EDC24672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781171;
	bh=ukK3tZ03T2ojLubsfuqKbVnsJ0LNvG8yLEX+MReaYbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z0pcRDCnNA0o763XYlfNdoprg3CBM5VVObPTGfvg0BlU3Fpa1KZny4z5mFTRm+yEq
	 fXhwTXFUdb12jrlxvq/cAGPqiJDRXXz9FylrCt+TqEX+U6gsUwuVq1YmYuDJrB5CjD
	 c9tOoH3YidoqQffhdxyakLxjG4KqTnlxqrgYA9ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfLSSqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbfLSSqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:46:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D74C24679;
        Thu, 19 Dec 2019 18:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781167;
        bh=ukK3tZ03T2ojLubsfuqKbVnsJ0LNvG8yLEX+MReaYbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yK41FEhz4nKRO3f+vM7R9xTsiVvsVEIyJKRTxUQydM+H0B2imLYbWQAEeZlauMkjQ
         m13LiCqZdDtH7ygnhTuuTx9sb5F/FzEQk+KT3q7b599BTwiy5OxgtqgKru8aevbMYy
         1QxwofepZNy/yNZJsO6e7ZGFzqvvm/l2eQHruUrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 4.9 083/199] drm/i810: Prevent underflow in ioctl
Date:   Thu, 19 Dec 2019 19:32:45 +0100
Message-Id: <20191219183219.549159529@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
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
@@ -723,7 +723,7 @@ static void i810_dma_dispatch_vertex(str
 	if (nbox > I810_NR_SAREA_CLIPRECTS)
 		nbox = I810_NR_SAREA_CLIPRECTS;
 
-	if (used > 4 * 1024)
+	if (used < 0 || used > 4 * 1024)
 		used = 0;
 
 	if (sarea_priv->dirty)
@@ -1043,7 +1043,7 @@ static void i810_dma_dispatch_mc(struct
 	if (u != I810_BUF_CLIENT)
 		DRM_DEBUG("MC found buffer that isn't mine!\n");
 
-	if (used > 4 * 1024)
+	if (used < 0 || used > 4 * 1024)
 		used = 0;
 
 	sarea_priv->dirty = 0x7f;


