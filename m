Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9BAC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC0A222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004576;
	bh=p7bx/iD+rCzGI/0M9/xMq3g1/19HHaOl80YIcp5EvN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gjzNun7k+iGvEIBeVZmP+bhbZPKjvcXrPf7FJq9hV6Fh5OKkbif/miWo6yZ3LkLuC
	 PHzaROXTW/SoQBggcUJnWKymzsUyjrz2v0XJjWtM/B9QjD5zldz5Yuo2MeRcdMuadc
	 iVyXANFMxgdxomX+FhCPNdtvSqy16dAvpQjoDkiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbgABWgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:36:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbgABWgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:36:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 405B920863;
        Thu,  2 Jan 2020 22:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004566;
        bh=p7bx/iD+rCzGI/0M9/xMq3g1/19HHaOl80YIcp5EvN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDFAc6xACRxb8x2KZyRJxzUJ8/ybc4OwCj1vxJO0F/CobiCfz1Kr6H8EMozm4BO1o
         FjEZKy6rPzGhQvMnt512jG+9IjYrkYPL6NehMdOvhKH64iZ+bFnvEvJIjpEtd7t2EX
         aOvcdR6zfvoJKKUPseVylpFQGGntf14mKsG+klCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 061/137] fbtft: Make sure string is NULL terminated
Date:   Thu,  2 Jan 2020 23:07:14 +0100
Message-Id: <20200102220554.697963357@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
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
index 15937e0ef4d9..36bf71989637 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -765,7 +765,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	fbdefio->deferred_io =     fbtft_deferred_io;
 	fb_deferred_io_init(info);
 
-	strncpy(info->fix.id, dev->driver->name, 16);
+	snprintf(info->fix.id, sizeof(info->fix.id), "%s", dev->driver->name);
 	info->fix.type =           FB_TYPE_PACKED_PIXELS;
 	info->fix.visual =         FB_VISUAL_TRUECOLOR;
 	info->fix.xpanstep =	   0;
-- 
2.20.1



