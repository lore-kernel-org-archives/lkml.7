Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4497C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA592184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK3gojgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfCNIen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:34:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38261 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfCNIem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:34:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id n125so3342907pfn.5;
        Thu, 14 Mar 2019 01:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aWZ1JVXj++uDOUKvVDEtu2GehhY5L/Xv5922NsUkHC4=;
        b=RK3gojgJil3PqQEfzj8+9Dp3ajLUqBb+4Pmq/LQvsyJuTdb0EWreuvcgwJnidfJLWD
         nAZzSZ7di/JFiPNC5F8ybTvfk3plhY6mkShP8PQg27tLYwWbYHHzKiDaMf8QnW4+jAag
         ctphT8SG4pJpmvwfBvC9mU70cAL2+a1s19MqndKEqKUCa8Mv9lf/grzU09tmQYpYKQFs
         a2WkOb16oEYzC9feGBzfFbQSdwqzO2tT9eJXxjvHFuFPceedaNXyDyCyBlwpTvVwm/gU
         dlBRuOfZWZx5jVKnZzJxmL9J1FOr2Lw6XQg2q0cOvAILs0waI5WVZ/W71NC1PdXkNCOV
         vyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aWZ1JVXj++uDOUKvVDEtu2GehhY5L/Xv5922NsUkHC4=;
        b=kOvheAvPRtPnSESHE5cARWx8eZPUULULSCUcklmhxgJDVkWGLKaQ7CBofz1HTPg2le
         0XSXZ4BTvwV5ED+BZRk5QnMVNPJnu39J7telPzrOEdgt93V7ykXNvrMcytPaiKBk/Yn8
         tVZv5N9u56BFXinZbeqOYrJht+8TXWx/CiKXmhi3lQzXaLMfRyDa7YwNHYoQgXY7M5Wg
         0t6w6G1w6p2/9lkip/EYPXpOqf6KV6dpOsnPoJYCiz3UUZO6dd7uczE3qNJMWAgFcpK7
         UPzEJ4WfI4SLasIaioyWjFaCCrMSiwNPCFKxvMvLBsbJ03NvKzSh4EEYsY2TcILoSkeD
         O3qw==
X-Gm-Message-State: APjAAAUO5sHnvVE7FfRCboYToBjfYwBhNZIzUeaXbLvRh8lY/5vRlYhM
        HSGi5JjtFeY4Tk54FnL2EuA=
X-Google-Smtp-Source: APXvYqywgfYOrp5Enlt/ikajjwvue3RZbSxshdMCwdjanFOzv2Qo/GXhNB47/Pt45M+VxZu++I8aHg==
X-Received: by 2002:a17:902:7b92:: with SMTP id w18mr2281674pll.237.1552552481608;
        Thu, 14 Mar 2019 01:34:41 -0700 (PDT)
Received: from localhost.localdomain ([175.223.23.218])
        by smtp.gmail.com with ESMTPSA id y37sm22983884pgk.78.2019.03.14.01.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 01:34:40 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] usb: gadget: do not use __constant_cpu_to_le16
Date:   Thu, 14 Mar 2019 17:34:33 +0900
Message-Id: <20190314083433.23989-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial patch.

cpu_to_le16() is capable enough to detect __builtin_constant_p()
and to use an appropriate compile time ___constant_swahbXX()
function.

So we can use cpu_to_le16() instead of __constant_cpu_to_le16().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/usb/gadget/function/f_uac1_legacy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 24c086bcdeaa..6677ae932de0 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -54,8 +54,8 @@ static struct uac1_ac_header_descriptor_1 ac_header_desc = {
 	.bLength =		UAC_DT_AC_HEADER_LENGTH,
 	.bDescriptorType =	USB_DT_CS_INTERFACE,
 	.bDescriptorSubtype =	UAC_HEADER,
-	.bcdADC =		__constant_cpu_to_le16(0x0100),
-	.wTotalLength =		__constant_cpu_to_le16(UAC_DT_TOTAL_LENGTH),
+	.bcdADC =		cpu_to_le16(0x0100),
+	.wTotalLength =		cpu_to_le16(UAC_DT_TOTAL_LENGTH),
 	.bInCollection =	F_AUDIO_NUM_INTERFACES,
 	.baInterfaceNr = {
 	/* Interface number of the first AudioStream interface */
@@ -183,7 +183,7 @@ static struct uac_iso_endpoint_descriptor as_iso_out_desc = {
 	.bDescriptorSubtype =	UAC_EP_GENERAL,
 	.bmAttributes = 	1,
 	.bLockDelayUnits =	1,
-	.wLockDelay =		__constant_cpu_to_le16(1),
+	.wLockDelay =		cpu_to_le16(1),
 };
 
 static struct usb_descriptor_header *f_audio_desc[] = {
-- 
2.21.0

