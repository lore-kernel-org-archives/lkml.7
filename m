Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A124C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 14:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FAA020854
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 14:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd2Jm8GW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391903AbfIGOVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 10:21:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36598 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388238AbfIGOVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 10:21:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so6445793pfr.3;
        Sat, 07 Sep 2019 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=37f65CGSJoP5CdiEV3OM1izP7iVH496FryBwntyj2lE=;
        b=kd2Jm8GWBwhE0xBsXqluIUDsHy3ux5Uah19P8x1QssYTZ7XOIo2cgdBen3lsB4iAzi
         GxzL7vD+k2SFNpg1arMm994weRfs2X6FMIquW6W4ydxo4q9yoYfSMZRtfQ6M+oS/u/vF
         kADroW4mHS/N7l1mDDls1fsTnUAhLurplEoMWKDmVj6jeiwDf8kxztNLbFqXfs5aI9tV
         q8Fxs8UsewZLwzQ+YBW3v4wqD1vxOKLpYYiUkWi0od/uDfyqY++qRzWmRxYmGDI+1RkX
         iNzbAD07V+680gKbBNMTKfFxmsFIaZIXUmoVpQADvYJpGS1rHpA8XK7GXf5huN9sBncC
         1KeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=37f65CGSJoP5CdiEV3OM1izP7iVH496FryBwntyj2lE=;
        b=WmCuccGGgdKaPQ3+lq3O59rPt1SDB6IlkF/rFaJNemhO/h5h0iBrEWvvUun+TfJOeI
         2T3kc0Xzg+SwOrblVFf9SE2G3yhZSxF3ImIkDmJ7ERBOxmRxBC532WsGq2S2zfNSdFE9
         Fz1K7TEgWCwa6fQiVsFeGLdrtWAPXCTxds21fZbYCKz6DZLvumm1iFc5fQwqV4pIXi7N
         SGEwgp1aYSqaPBcCM+BvxKnrig4vsiSXc0DQcseJyk1P7MNdd32Ae/CrwjWLbFpL2IV0
         yPKGITuEWWmlzMc4JVLFWq3nE/Oe0w+wS5WMzHrZicqEKBusKvAb007WUdWcSOgao+v/
         6gPA==
X-Gm-Message-State: APjAAAWXei9c48QIWOhCR+Np1Y1RrJRQAXz0288zCe0RVQzDCcv3GvTk
        /h+FyqTO8yUSIMzbwCY8YmK9IkqGkkI=
X-Google-Smtp-Source: APXvYqyQ8yChFWgK1RcParrAaabjchntsUg1BuEJKCxSZHEr5B5JusC6goDwYFQpBhcT+SahP2PZgA==
X-Received: by 2002:a63:ee04:: with SMTP id e4mr12741439pgi.53.1567866103127;
        Sat, 07 Sep 2019 07:21:43 -0700 (PDT)
Received: from nishad ([106.51.235.3])
        by smtp.gmail.com with ESMTPSA id i9sm25547693pgo.46.2019.09.07.07.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Sep 2019 07:21:42 -0700 (PDT)
Date:   Sat, 7 Sep 2019 19:51:36 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: xilinx: Use the correct style for SPDX License
 Identifier
Message-ID: <20190907142132.GA7166@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in header files related to Video drivers for Xilinx devices.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/media/platform/xilinx/xilinx-dma.h  | 2 +-
 drivers/media/platform/xilinx/xilinx-vip.h  | 2 +-
 drivers/media/platform/xilinx/xilinx-vipp.h | 2 +-
 drivers/media/platform/xilinx/xilinx-vtc.h  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/xilinx/xilinx-dma.h b/drivers/media/platform/xilinx/xilinx-dma.h
index 5aec4d17eb21..2378bdae57ae 100644
--- a/drivers/media/platform/xilinx/xilinx-dma.h
+++ b/drivers/media/platform/xilinx/xilinx-dma.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Xilinx Video DMA
  *
diff --git a/drivers/media/platform/xilinx/xilinx-vip.h b/drivers/media/platform/xilinx/xilinx-vip.h
index f71e2b650453..a528a32ea1dc 100644
--- a/drivers/media/platform/xilinx/xilinx-vip.h
+++ b/drivers/media/platform/xilinx/xilinx-vip.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Xilinx Video IP Core
  *
diff --git a/drivers/media/platform/xilinx/xilinx-vipp.h b/drivers/media/platform/xilinx/xilinx-vipp.h
index e65fce9538f9..cc52c1854dbd 100644
--- a/drivers/media/platform/xilinx/xilinx-vipp.h
+++ b/drivers/media/platform/xilinx/xilinx-vipp.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Xilinx Video IP Composite Device
  *
diff --git a/drivers/media/platform/xilinx/xilinx-vtc.h b/drivers/media/platform/xilinx/xilinx-vtc.h
index 90cf44245283..855845911ffc 100644
--- a/drivers/media/platform/xilinx/xilinx-vtc.h
+++ b/drivers/media/platform/xilinx/xilinx-vtc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Xilinx Video Timing Controller
  *
-- 
2.17.1

