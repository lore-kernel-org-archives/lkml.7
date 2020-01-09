Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0EBC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D8A2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SiG6Cc1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgAILuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:50:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33995 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbgAILuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:50:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id w5so1868564wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 03:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wytPjSbZC28y5B3ceuqDy/iL3OfZmgStcvzlcuSAif8=;
        b=SiG6Cc1mpyfMT5NEAFeiRHSAjH7YMxA0RJXmD2ag9L8ctusuYKlQSObVqcCCaOwWNt
         N2XW1vYZ0qoUhc/03DANw2+Cm5eYlHweiiNHoztAoAkIV5EcvNVUhrHdERDaoxc9ThgN
         SeZf7mikebIAimCQD7yapsaO3XzWoQql83r1pqpuICz28x0Q7eaCQIBCc4pS7KqbuyWg
         pj45NMA+10OnXE8EtzGjmUylKCdnj5ax8ygZ5ZaLycyg2bHkcloAzvdWEi1j2pVdU21f
         uxR/0UOPeoJBjeMRBHjp5hm73gtCn/bA/fV5Jtk9sXyKWQw3JYh4YOiFY2nhzzMIopS0
         r7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wytPjSbZC28y5B3ceuqDy/iL3OfZmgStcvzlcuSAif8=;
        b=lpEx78dduENke89urEgq0b2wuFc4L1gieK8BeVpZpLee6jfCcPVwos6zd2uY6R6ZAU
         EnG2BKzLBBOP2loG1cf83WLnZNSWoshR+OfhJkSMBUHrXBPdfIsi9UKTujs/i+pwsRgi
         Xg0bq1uIBn623o96iVcRAG0dPyWTKzBwalVf5c26cwJIIe8YDvakCkCQq2RyseKHHwv/
         3JKnxXzXzrey/k7fLoSIXaazt3CyKf45F1r6Qq+PVyNbRK5KOmI3Db7jtpSZAwQ8giTO
         DSRWXLjAw9IlMjlHjN4x+DdKK9n2tRwYGJoK+Top2mpE5dAJkp9vnTtak567LlJEHQ9Z
         veKw==
X-Gm-Message-State: APjAAAV9nqgiAKap2nMQC2Ru+KTZfBC5GzfdyyrQzINNwbaAg2jFnO8W
        uowoLJQvSbBhAd1x4QuKttQegg==
X-Google-Smtp-Source: APXvYqxSQ+7PJMz4DdsMYc5/fITw4V/NE80DtX2NZJzUz1MXy41a9JHFdcfTuyjSTQfEDe1VIBhRRQ==
X-Received: by 2002:a1c:7901:: with SMTP id l1mr4334899wme.67.1578570619482;
        Thu, 09 Jan 2020 03:50:19 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id u16sm2574979wmj.41.2020.01.09.03.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 03:50:19 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 4/7] gpiolib: emit a debug message when adding events to a full kfifo
Date:   Thu,  9 Jan 2020 12:50:07 +0100
Message-Id: <20200109115010.27814-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200109115010.27814-1-brgl@bgdev.pl>
References: <20200109115010.27814-1-brgl@bgdev.pl>
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
 drivers/gpio/gpiolib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 43c96e7cdc48..6b5d102dfb13 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -987,6 +987,8 @@ static irqreturn_t lineevent_irq_thread(int irq, void *p)
 					    1, &le->wait.lock);
 	if (ret)
 		wake_up_poll(&le->wait, EPOLLIN);
+	else
+		pr_debug_ratelimited("event FIFO is full - event dropped\n");
 
 	return IRQ_HANDLED;
 }
-- 
2.23.0

