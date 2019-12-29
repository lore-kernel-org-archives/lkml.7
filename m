Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBB0C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E335320748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642094;
	bh=AlCnrEr3npurhfSBtdCdt/G29onv/y6kh+UyFeovWpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Eir3FDSr63SqxL+tzX7MhlYlyKG5tyQkUGSUScbE+chaVqEXPB4hZdO5xLQ73G/dS
	 BcOCFyySKuwxoj7hywrxN7ZjSIxiQL5qBI1KkaA2TDLruo5gOKXyVWWfDVWlcwpS+K
	 lRLpIemuKO59f18MAgl5CmJApgG5sdf356QpG43Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732814AbfL2Ryx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:54:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732782AbfL2Ryt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:54:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94DB7206DB;
        Sun, 29 Dec 2019 17:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642089;
        bh=AlCnrEr3npurhfSBtdCdt/G29onv/y6kh+UyFeovWpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ez62fREi/r4DVFGQ4Og18/TZniPFLu+LoFbFZapK9pmiLNcP/Km5CXFmJqZwov73i
         yMFW5C8FHegCtrOMuvfNOXvBzrr09iLPdJz+Owr5d21mMY4NZO5G/E/0djsxcytPIB
         K9IXs2SHnpYlr/UJWqn+XNL+ErVOB0n7TTYwMx7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 338/434] fbtft: Make sure string is NULL terminated
Date:   Sun, 29 Dec 2019 18:26:31 +0100
Message-Id: <20191229172724.420527344@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 21f585480deb4bcf0d92b08879c35d066dfee030 ]

New GCC warns about inappropriate use of strncpy():

drivers/staging/fbtft/fbtft-core.c: In function ‘fbtft_framebuffer_alloc’:
drivers/staging/fbtft/fbtft-core.c:665:2: warning: ‘strncpy’ specified bound 16 equals destination size [-Wstringop-truncation]
  665 |  strncpy(info->fix.id, dev->driver->name, 16);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Later on the copy is being used with the assumption to be NULL terminated.
Make sure string is NULL terminated by switching to snprintf().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20191120095716.26628-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/fbtft/fbtft-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index a0a67aa517f0..61f0286fb157 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -666,7 +666,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	fbdefio->deferred_io =     fbtft_deferred_io;
 	fb_deferred_io_init(info);
 
-	strncpy(info->fix.id, dev->driver->name, 16);
+	snprintf(info->fix.id, sizeof(info->fix.id), "%s", dev->driver->name);
 	info->fix.type =           FB_TYPE_PACKED_PIXELS;
 	info->fix.visual =         FB_VISUAL_TRUECOLOR;
 	info->fix.xpanstep =	   0;
-- 
2.20.1



