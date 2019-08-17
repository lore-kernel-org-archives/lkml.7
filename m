Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1FBC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 06:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2832121019
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 06:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfHQGPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 02:15:06 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40525 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfHQGPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 02:15:05 -0400
Received: by mail-yw1-f66.google.com with SMTP id z64so2486655ywe.7;
        Fri, 16 Aug 2019 23:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nSWcGHQFcez4uU+PGD8SyJWHkgtSsyU9F5EbfdiRyOY=;
        b=GVbeND+VuCVsfCqmm1wM4PSvX7el6yjkvwS6KzIL56Xl4yqGHe+yY1n1xDAcJY5nDs
         EvJgTJrT3xrouThCnnY6lwbEOOtU6NnNXvO8b5Be1fBNio6+gwB0zeUgWmchalrB9TcK
         FUES05ADHO+2JIETLEGCso29eT2r+U/W3HSac+QjTvE6NzGhlspeXMjjFgWGVI2Yk2Fv
         xr8frR4XiAr/T8jNn56UOKukmFXRlQQw43iaNVcnr2QPS7av1xdOLI7Y7OCiAgdA99NM
         LuhKQluuD26lSal/LnNosCMk6NadrRBiYmCYh/f4ZvFAiLPm02OdBklVrCtSi9kMjkN9
         9a6w==
X-Gm-Message-State: APjAAAWfpjIP6wPdIyFARX2068dG0VNLaIHTHdBmh6m3GZwRBxsg2Vp7
        Gth2uVBh9OsyE2jxSX0MsMg=
X-Google-Smtp-Source: APXvYqyS/jAzmGnlQPDV9uzKPPB0ykdf9ZoWYve2vEeCZ+LPu5F46hL2uOA17Yg3PWXbARZodLlwHg==
X-Received: by 2002:a81:6286:: with SMTP id w128mr8746846ywb.272.1566022504556;
        Fri, 16 Aug 2019 23:15:04 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id g3sm1334310ywk.15.2019.08.16.23.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Aug 2019 23:15:03 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] media: usb: cx231xx-417: fix a memory leak bug
Date:   Sat, 17 Aug 2019 01:14:54 -0500
Message-Id: <1566022496-4425-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cx231xx_load_firmware(), 'p_buffer' is allocated through vmalloc() to
hold the firmware. However, after the usage, it is not deallocated, leading
to a memory leak bug.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/media/usb/cx231xx/cx231xx-417.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/cx231xx/cx231xx-417.c b/drivers/media/usb/cx231xx/cx231xx-417.c
index 2475f69..5e2e1fd 100644
--- a/drivers/media/usb/cx231xx/cx231xx-417.c
+++ b/drivers/media/usb/cx231xx/cx231xx-417.c
@@ -1051,6 +1051,7 @@ static int cx231xx_load_firmware(struct cx231xx *dev)
 	p_current_fw = p_fw;
 	vfree(p_current_fw);
 	p_current_fw = NULL;
+	vfree(p_buffer);
 	uninitGPIO(dev);
 	release_firmware(firmware);
 	dprintk(1, "Firmware upload successful.\n");
-- 
2.7.4

