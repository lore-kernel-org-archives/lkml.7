Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148FCC28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E164C20684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfeSAnTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfFFCyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:54:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38362 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfFFCyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:54:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id a186so543383pfa.5;
        Wed, 05 Jun 2019 19:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yl9bICfQdMFLxb1DttR8RqORrTiqyN8JdwYLjgX91/U=;
        b=AfeSAnTeQRCB0nQnwoi0e2piWSTUtDfJENIhV6jJu2HPPJpQ0mkit5uQyY5cEGeRTF
         uoAviqx/roHxPu8k39BFpM+Wyasp5tDLVRAjFHj5M9PpfhAGjU3OaGBEpywiV0GnY7Iq
         qh5J7HFukS/axAwtTyNsyjKLg4oJEMmQHhPtTi2r9w57DHj5VcMFTaMFznE4M4bqvi3l
         Ah2AbuWfDNMorXQtTbZ10vyYOK05Om6Wa4trmyLmZOy2MBaqXEXWQesvmpXtrZW2nOIr
         gbwbC9ZFOEhq7XzMC2L7rkBXTRQ5PjbHfST3veO5Kt+aZ/iLwVzzQ+VQnAbVFp2N4VqI
         tmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yl9bICfQdMFLxb1DttR8RqORrTiqyN8JdwYLjgX91/U=;
        b=mRtM0LmkxYapXROvhKi/0mPKhku6QhYLNPd76UGXEMa7P3CUzO8ainX7XN+gBtiw0v
         oy4tSig737bXTHksm8nWM+WhVJ9/oe6r7xrHG6Ua/pvRxGkumFvv135ExZbDQ+ZGDUB7
         rvxhsU/EsyqJcNgg0oVmuXEcDxG4+Nod5zvGHNpZfstHRghqAc3ywRDLgGIyabQobLyX
         rEAbCCs53GhBvwwUtTx5cwf6mJpQz5DuZuybLQ30lhG/x/tAKvOIGu56wiMvVRAIp0p9
         e+xNBWug8TRXCjK8tc0sFVIjxM8iqyhxC8RMQLEmPT1hkgBozfj2PWGQS8FXWNEyW8+V
         EhHQ==
X-Gm-Message-State: APjAAAUd9qOAr2iNWvddxXR6HWJ8gZGa5y5TdcTV2AeCew+RbYtKmP24
        +IGHqkvJ6ubIw13s7AOEvOM=
X-Google-Smtp-Source: APXvYqy2rUstADv8drRPFZ9GFWCTnuXiSrB7oUOQdtpkib17Pl/1rxa61EWeJO9oresXcW7yuYU3oQ==
X-Received: by 2002:a63:161b:: with SMTP id w27mr1091510pgl.338.1559789686950;
        Wed, 05 Jun 2019 19:54:46 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id n21sm294331pff.92.2019.06.05.19.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 19:54:46 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V1 4/6] USB: serial: f81232: Add tx_empty function
Date:   Thu,  6 Jun 2019 10:54:14 +0800
Message-Id: <1559789656-15847-5-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tx_empty() function for F81232 & F81534A series.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/usb/serial/f81232.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index e9470fb0d691..7d1ec8f9d168 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -850,6 +850,24 @@ static void f81232_dtr_rts(struct usb_serial_port *port, int on)
 		f81232_set_mctrl(port, 0, TIOCM_DTR | TIOCM_RTS);
 }
 
+static bool f81232_tx_empty(struct usb_serial_port *port)
+{
+	int status;
+	u8 tmp;
+	u8 both_empty = UART_LSR_TEMT | UART_LSR_THRE;
+
+	status = f81232_get_register(port, LINE_STATUS_REGISTER, &tmp);
+	if (status) {
+		dev_err(&port->dev, "get LSR status failed: %d\n", status);
+		return false;
+	}
+
+	if ((tmp & both_empty) != both_empty)
+		return false;
+
+	return true;
+}
+
 static int f81232_carrier_raised(struct usb_serial_port *port)
 {
 	u8 msr;
@@ -1279,6 +1297,7 @@ static struct usb_serial_driver f81232_device = {
 	.tiocmget =		f81232_tiocmget,
 	.tiocmset =		f81232_tiocmset,
 	.tiocmiwait =		usb_serial_generic_tiocmiwait,
+	.tx_empty =		f81232_tx_empty,
 	.process_read_urb =	f81232_read_urb_proxy,
 	.read_int_callback =	f81232_read_int_callback,
 	.port_probe =		f81232_port_probe,
-- 
2.7.4

