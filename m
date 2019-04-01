Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022FA2070D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554142216;
	bh=7V0wIAu3WQot+uP4Pc1VVrFe6UV8mkWY1cxtCyhmonU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yq+1bB4O0S3TBTTRVa2C9eiMGYch9vUjHTwPxTYHu2+7bkzLQwLTrNZJeXqa5A7Un
	 N2r1+CGelurY2a9GdK/hVuFhdX/aUbouN08qQg9jFEAifRLoxt40iwYrFtNh+LDiJP
	 X+uGZwFcWCSlP9+5SX/IZOhEgIzG76iqwNwFG00U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbfDASKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728911AbfDARIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:08:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30C462192C;
        Mon,  1 Apr 2019 17:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138493;
        bh=7V0wIAu3WQot+uP4Pc1VVrFe6UV8mkWY1cxtCyhmonU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kE2W7hKS3oZCMF5alRV70AFEPcrH6b4oiMg2RInRChXU/wF9Q3H9OxKBk52y47Mi7
         o89yUhkypuj06wtDwCygYrxvs4FkSYPbPAovknt0P8vzftSRjcOeKcU9q+QhdzICH1
         N3KInngpQRkY8kbjJOLuHmek2fYF6Acj5q8eo8xo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 5.0 081/146] tty: serial: qcom_geni_serial: Initialize baud in qcom_geni_console_setup
Date:   Mon,  1 Apr 2019 19:01:33 +0200
Message-Id: <20190401170055.724027348@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1117,7 +1117,7 @@ static int __init qcom_geni_console_setu
 {
 	struct uart_port *uport;
 	struct qcom_geni_serial_port *port;
-	int baud;
+	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';


