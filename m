Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD37C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41632073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Vt/6D1lS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfLDQBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:01:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42176 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbfLDP73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:59:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so9220911wrf.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HHgoLgFHf2KTo5tf1P+Sd12YWIyt1YcyhSjGYkb4R8=;
        b=Vt/6D1lS08tFWOArLQbOP8E/WEJ+/7lyTXHQCXBXklKYAc1dmvCjy97Idok02qrp+G
         /iRmBekwSuOk5CHDHIX0jvI9QPjRJWcHhJaALqciMpbsAKzJdeoitRdEQwyUY1vktAar
         VPIXLw0dRbLHP+AQ1WhHMfRB4wUZg0DUwOIAyaT4lNRu80JU/Zg8cJ7ElWh8qU6QzG0U
         lmTPo0OKpqHTbbTFqeHv5gxwoVkigvqAzTDv4FJARCSJIQjwo7GRlGUMzmXyc5/41yoh
         ZLBsvPTo+mcBLkasVIMGfTcYaaSvjx3JNS9np3G5L2MjiL5jLggwH3vYd+I84iv4PmrZ
         HfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HHgoLgFHf2KTo5tf1P+Sd12YWIyt1YcyhSjGYkb4R8=;
        b=fPw8LcEhdG2v7yVIoIfIYVR0Jci13yimtHi9TPtpE5KgeXiZANt9bzkZtukWUl1MCO
         B9mjx1OH9FRwJTNACp1/53O+HzIOT8RfuyVEEUXzjsxuZUo5gmV9uBrgQ5KJ9o2UfEif
         zC9vQF2abzY39YR/X5Vjy01JgKSVqWtkjJEfVh4EfX8MtQQMZZi0GsqgG65YnXP46FLQ
         YbWtYodQMJifffdv3LgjGvCCq8bJisEQvbwgrgi2lGwGZWPn7PRrXEK6PsinS53RxutW
         3VkHa+jZxGNr4pet3+pL5z2F0v17PCBcjkEbCy2azgBC+Toj9cObKaDJUgIGDd1PTHt/
         oLFA==
X-Gm-Message-State: APjAAAU32JEgfbCnzBF387JN06+LWsJip3KHiCmYoaIrnjT09nvXf4bu
        tamwpDnLdPpYs6jVEDf2XbjW5g==
X-Google-Smtp-Source: APXvYqx45bZ9826Rs8lcmtiIU4mfdZWsykH+a2xcXPaHAxKIcIt36IpO8A21JvhcrlmQ6H6Rwr5GQw==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr4904521wrn.5.1575475168318;
        Wed, 04 Dec 2019 07:59:28 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id u18sm8640508wrt.26.2019.12.04.07.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:59:27 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 08/11] gpiolib: emit a debug message when adding events to a full kfifo
Date:   Wed,  4 Dec 2019 16:59:11 +0100
Message-Id: <20191204155912.17590-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191204155912.17590-1-brgl@bgdev.pl>
References: <20191204155912.17590-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently if the line-event kfifo is full, we just silently drop any new
events. Add a ratelimited debug message so that we at least have some
trace in the kernel log of event overflow.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 43f90eca6d45..c89d297da270 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -975,6 +975,9 @@ static irqreturn_t lineevent_irq_thread(int irq, void *p)
 	ret = kfifo_in_spinlocked(&le->events, &ge, 1, &le->wait.lock);
 	if (ret)
 		wake_up_poll(&le->wait, EPOLLIN);
+	else
+		pr_debug_ratelimited(
+			"%s: event FIFO is full - event dropped\n", __func__);
 
 	return IRQ_HANDLED;
 }
-- 
2.23.0

