Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D744DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08A62146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dmG4jldJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfCMU0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:26:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39435 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfCMU0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:26:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so2699914edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EHLai3k2Wn6n/KDvlbsgby/PgsqnNVvXCgww5aPDvj0=;
        b=dmG4jldJdQuYJWQFCzTm3r5HvcKJLPai9ojEE39RQyMAsx6dkAutk4TsYTLI4JJrqp
         Y87BMDeY/U8hv8cW0sYwmwSF14kUBhfKRKgZtBH406+6gkp9WbpF7oztWaSSNqpnEwdD
         kTSCuu+BtmFPsZx0kzrolqIceaLxxzx6E+ra0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EHLai3k2Wn6n/KDvlbsgby/PgsqnNVvXCgww5aPDvj0=;
        b=MUrZWYazHF7f+Dk+S6ZM/qMAFR+LjgoLRSg8QAMWYVs0Wx8ZB3ie/IuoQDzt/ZQUX4
         PSF932dDHwVMmwcHyBwDIGOOmJGCbXznFzh8NZoickkPIoUWjrayxRcrDJjl/wWdunPa
         cHd++IvVLaCZKdNvmFJE5cMuQdDUNZyPknBewU9daln9VDcAIxV8qX0sbSylmOdtuvaB
         A0obmiU1VhRyGQoOxr2PId9RCNGf8428df7LFby+rbfSpre4F/cu9uAPfkG5pbppjeu9
         O/0WsxkN/TJUpAucc9w4SpW0BXkp1gAL8cp7dg4RlUJGhVuO6xXyPuRG1ZTXbb7X2VLK
         atIA==
X-Gm-Message-State: APjAAAXfL1vUOw7GcgY+fU9uBAzIhUgtCVu4lv62WYaLpIU38xmBPq6T
        dhbAi38RlSQn+sRlAdMaQKesGA==
X-Google-Smtp-Source: APXvYqx48wITaGCFpEN2lwt/uT26JqisBqYPqnczSKpGauVtRxyzEtIG+DF06hPD4doPGGkgZl1jDg==
X-Received: by 2002:a50:9938:: with SMTP id k53mr8952505edb.134.1552508779641;
        Wed, 13 Mar 2019 13:26:19 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-119-202.cgn.fibianet.dk. [5.186.119.202])
        by smtp.gmail.com with ESMTPSA id m32sm940170edc.17.2019.03.13.13.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 13:26:19 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-leds@vger.kernel.org
Subject: [PATCH 1/4] leds: netdev trigger: use memcpy in device_name_store
Date:   Wed, 13 Mar 2019 21:26:12 +0100
Message-Id: <20190313202615.22883-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If userspace doesn't end the input with a newline (which can easily
happen if the write happens from a C program that does write(fd,
iface, strlen(iface))), we may end up including garbage from a
previous, longer value in the device_name. For example

# cat device_name

# printf 'eth12' > device_name
# cat device_name
eth12
# printf 'eth3' > device_name
# cat device_name
eth32

I highly doubt anybody is relying on this behaviour, so switch to
simply copying the bytes (we've already checked that size is <
IFNAMSIZ) and unconditionally zero-terminate it; of course, we also
still have to strip a trailing newline.

This is also preparation for future patches.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/leds/trigger/ledtrig-netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 3dd3ed46d473..ddc2b90ad7ec 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -122,7 +122,8 @@ static ssize_t device_name_store(struct device *dev,
 		trigger_data->net_dev = NULL;
 	}
 
-	strncpy(trigger_data->device_name, buf, size);
+	memcpy(trigger_data->device_name, buf, size);
+	trigger_data->device_name[size] = '\0';
 	if (size > 0 && trigger_data->device_name[size - 1] == '\n')
 		trigger_data->device_name[size - 1] = 0;
 
-- 
2.20.1

