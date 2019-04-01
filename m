Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8ECC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45A320856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138993;
	bh=BLJyqNnDBYD4q0Qwi1z7/IlyT6hD50uyN7Rsu6TPPIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F+TpoRuvPoJul42ckqe1pJBkI+ZxLguLrB77ahoGQuy2buicHTAGE8gdbSpkFI1ac
	 F/p2kVg/Syai9r+CJbHCXErM8NAoE3UZNSSmpRhTndJae6Ojx1J2FUxBjUI9/qJiqd
	 JD/oOkx3ZgDw2DyW7aqNUKGsYG1sCPKHhii1+d0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfDARQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730857AbfDARQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:16:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7505A20883;
        Mon,  1 Apr 2019 17:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138986;
        bh=BLJyqNnDBYD4q0Qwi1z7/IlyT6hD50uyN7Rsu6TPPIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YbbaNN2jEryzDHNeisE0IxovPRsXlaCaN+iUdIQv+YEi+6If37jYUnNPLBORi1MBc
         A0xDiD3kJo0XJZRrFZWQU21BI33bcTEGQiIOdEOAXzF1N+BTWS3N9+0jCqOJmcOQET
         shnRGVm4DEISF0gqaSXfeuiFZsd5P8q3BXRW5uwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.19 080/134] tty: serial: qcom_geni_serial: Initialize baud in qcom_geni_console_setup
Date:   Mon,  1 Apr 2019 19:01:56 +0200
Message-Id: <20190401170051.839788433@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <natechancellor@gmail.com>

commit c5cbc78acf693f5605d4a85b1327fa7933daf092 upstream.

When building with -Wsometimes-uninitialized, Clang warns:

drivers/tty/serial/qcom_geni_serial.c:1079:6: warning: variable 'baud'
is used uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]

It's not wrong; when options is NULL, baud has no default value. Use
9600 as that is a sane default.

Link: https://github.com/ClangBuiltLinux/linux/issues/395
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/qcom_geni_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1052,7 +1052,7 @@ static int __init qcom_geni_console_setu
 {
 	struct uart_port *uport;
 	struct qcom_geni_serial_port *port;
-	int baud;
+	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';


