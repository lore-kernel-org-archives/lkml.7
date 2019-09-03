Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D9AC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570E622D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHgBr9Kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfICHBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:01:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41108 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfICHBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:01:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so8587944pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 00:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ATcsitRpTyb5wI6PMkB6H6IJliZcFvf7R0g9NfFMg9A=;
        b=EHgBr9KfYik5R6FusPDhu53l+J3bX9l8zy+rd7KHjP5eJpWMJBDrvwknS9Pt9RsCsr
         1AhNQzcmCHH9hqmZxFEi9bKhZfz9UiEgVdHOCOBb26fxtUWMRm90Wpehtn/bqoHFE7bB
         goOWVwvsODaia2BAUb32k0QYR4cWSFXHHeaHp4RuK6nDFMiUZQTYFCPSUBW3MDWQApv+
         Y9SP5AXKkI1/kJsVfCFyEsbDGeymtrlHCMxAg8nB/8sVoLY/KFIw1Gm2GH7Q42O2mWqv
         I0cFnHbxAmjHo51uvaqpSr6CFedJhzS1ZJp8PYutClpWHQYPWbz8ASS6WgRUtQJyZchn
         SUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ATcsitRpTyb5wI6PMkB6H6IJliZcFvf7R0g9NfFMg9A=;
        b=H1eR4k3RuOD6+njHnSx7/tZTdiEmPyAyVRKMXcp6kBAShPSR39YTBA+T3ct12cG94c
         KbmP5l9bEY6R+O0CH4xTtg0A2TJNVf6NNDHFbYej3NdR52HNwga/Pt3g0auMSNL7bsck
         G+jiWSdsgiCZlnte2ldM5kPMbAruFRoAn40hSoR/5gyufBBVExIr7QEGqcYKAVDDDC5N
         EftT6bGnHALieC4ZOPnsFArk2Nmijnp3mk+pfKgbGDzeqhuMTZ4F+sKssr2kLkZ25PkY
         pvb7LAh5BrKaXRwBVcXdfFezXLjtXSQr4VjEKlg0RXn/MToLbF81df5OsYjOfeCZkz1x
         p7eg==
X-Gm-Message-State: APjAAAWyJFVdBW2w4pu7tK+qN0+2aDBJiRg+YXJ0PJvd7PeJQlSgYwWW
        yzkaBCHwfoIlXV8KnYNZaoCqFg==
X-Google-Smtp-Source: APXvYqz7PqAPPuwHi9KNmY1wXWO+7XyHpi9GIfgIFWwbvr3Uy0dMS/qxpicDH9bsKAIcPc8znEA9iA==
X-Received: by 2002:a65:690f:: with SMTP id s15mr27939370pgq.432.1567494114841;
        Tue, 03 Sep 2019 00:01:54 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 19sm16471892pjc.25.2019.09.03.00.01.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Sep 2019 00:01:54 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     lanqing.liu@unisoc.com, linux-serial@vger.kernel.org,
        arnd@arndb.de, baolin.wang@linaro.org, orsonzhai@gmail.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.14.y 8/8] serial: sprd: Modify the baud rate calculation formula
Date:   Tue,  3 Sep 2019 15:01:25 +0800
Message-Id: <b72268635867cb643912bd842f4980c5d24cb2df.1567492316.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1567492316.git.baolin.wang@linaro.org>
References: <cover.1567492316.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lanqing Liu <lanqing.liu@unisoc.com>

When the source clock is not divisible by the expected baud rate and
the remainder is not less than half of the expected baud rate, the old
formular will round up the frequency division coefficient. This will
make the actual baud rate less than the expected value and can not meet
the external transmission requirements.

Thus this patch modifies the baud rate calculation formula to support
the serial controller output the maximum baud rate.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/tty/serial/sprd_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index e902494..72e96ab8 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -380,7 +380,7 @@ static void sprd_set_termios(struct uart_port *port,
 	/* ask the core to calculate the divisor for us */
 	baud = uart_get_baud_rate(port, termios, old, 0, SPRD_BAUD_IO_LIMIT);
 
-	quot = (unsigned int)((port->uartclk + baud / 2) / baud);
+	quot = port->uartclk / baud;
 
 	/* set data length */
 	switch (termios->c_cflag & CSIZE) {
-- 
1.7.9.5

