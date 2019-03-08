Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECFAC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A432F20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/lM95Td"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfCHSiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:38:11 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42240 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfCHSiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:38:11 -0500
Received: by mail-ed1-f66.google.com with SMTP id j89so17157452edb.9;
        Fri, 08 Mar 2019 10:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wt+O5UaCrZbKm+nRjiKljnxRQKYymyB2uCwa3tzp6RY=;
        b=U/lM95TdDfDHCIKPDT4k5LMctaNswiziesYbuaJL98B4kzfZXesvVARfILXz1uJ3Wi
         BZdU8g62MkQvy4jmva1mXNgdbN6RScGSgrLIjT8quX9NChD3cBc6Q+IiDDGlc5o/EP0N
         7QRbMRZXWWrMulGXzIBEl91XWo9y4rkcwHwe2DV+id0JzP1zp6DGHmNSyDPpZNe3jAer
         Orte54BA9/1RYwjazQJO+GmVXkP+9T8LPKyDv0wVVvgAMGjo6SrD+VOGyOPxVRJ98fjt
         t05cX/wnVB5Af4q5lxqHZVCopEU9hCZw08gRAC5Tik9YryN5vZDR2hd+aECqM/w08wOv
         X40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wt+O5UaCrZbKm+nRjiKljnxRQKYymyB2uCwa3tzp6RY=;
        b=eG2tXH6WOV3ycwtKxqVTHITtqRjlUJzLYbak4XZkwB1FFkrvurbM1sGZOb3bQIkm2+
         LKHXW8vP3vGtxeH0komcHtIOYM/nx845T8l8V5C6plSceM1xwuCblx+d/Fo4uOQWV9KO
         UQ4t2w7oFyzXEA/xQla8IcQNQkYNGmSHoqkqDmKsw++tzjJKmAwofHuqHdmUKckeZ3E+
         JG75j+b6/hiWvkAfnr8UAnyF7SfT1NZivKwp2XGdAjhuLPWoKMQUSn8/jQ5JzzN9vjQm
         p/pFColGtjVklfGcWuUIaCaNtJlfRWxANK7KRdUx0mqOtdy1i1js16d/Yf9El7LBcnMw
         4H6Q==
X-Gm-Message-State: APjAAAVessU9Bnd1Yqt+nlVIf7Rq5XBlSvgvIgV+xTcrs69z+BrJGuMq
        9JVxKSJ0mjGiKJfibet8YTY=
X-Google-Smtp-Source: APXvYqyBQtJ3YePQzQEKQqKD/c3R/hn36dtkzfw/eLa913UJEXoql5dIRgsu9Kz574HXRQCEuZf8pg==
X-Received: by 2002:a17:906:4599:: with SMTP id t25mr584666ejq.125.1552070288850;
        Fri, 08 Mar 2019 10:38:08 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id s24sm2354750edd.23.2019.03.08.10.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 10:38:08 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] tty: serial: qcom_geni_serial: Initialize baud in qcom_geni_console_setup
Date:   Fri,  8 Mar 2019 11:37:44 -0700
Message-Id: <20190308183743.11145-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308084022.GA31474@kroah.com>
References: <20190308084022.GA31474@kroah.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/tty/serial/qcom_geni_serial.c:1079:6: warning: variable 'baud'
is used uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]

It's not wrong; when options is NULL, baud has no default value. Use
9600 as that is a sane default.

Link: https://github.com/ClangBuiltLinux/linux/issues/395
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3bcec1c20219..35e5f9c5d5be 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1050,7 +1050,7 @@ static int __init qcom_geni_console_setup(struct console *co, char *options)
 {
 	struct uart_port *uport;
 	struct qcom_geni_serial_port *port;
-	int baud;
+	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
-- 
2.21.0

