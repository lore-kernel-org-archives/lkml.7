Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D270EC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD27205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012549;
	bh=V+vvRML/SZghVHDbOg+jjdRXMepQC3mzOMs2iv2J2Dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0HCXyEardnwBlH7TTNIrP8D9W5MFFNmXPBd61s+MDbOo2Ob+H7Z0xH+fyZffXsBU8
	 9ry6b8HStWRk2X3bVn7F/zr/4LQI9R6wOPx2ZPZMdEVJuUFlbRNh7lMIsowfXfy3IN
	 AiveiuCL3+s/IMUmbGu+yxTnoyCiS87qM1vUmVJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfLJVNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:13:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729298AbfLJVNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:13:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84AE12077B;
        Tue, 10 Dec 2019 21:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012402;
        bh=V+vvRML/SZghVHDbOg+jjdRXMepQC3mzOMs2iv2J2Dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnEGJDfuJCzGFwb+YLJoHTIwYzeddXQW6q1wJfTiyXuqCautXgmMYUBME6jNN/ZBi
         1E+cpzdWsFmzZ72N4oD83e2A91JBbL3YeQBjxwhfzMXXPyP+JUI6SQ4NUS8XveXiDC
         e3v7rI0RiMwCN8YMhFdTVDaZEaaBChHWfWnhEiSQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.4 321/350] fbtft: Make sure string is NULL terminated
Date:   Tue, 10 Dec 2019 16:07:06 -0500
Message-Id: <20191210210735.9077-282-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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
index a0a67aa517f0e..61f0286fb157e 100644
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

