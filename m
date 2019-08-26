Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5FAC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CF02173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4eliHwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbfHZH3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:29:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36553 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbfHZH3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:29:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id w2so11236988pfi.3;
        Mon, 26 Aug 2019 00:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gICdPQsIaTjTwUfJWho+jc+GHx6tokQahaBmVhNvwDM=;
        b=E4eliHwychozfMNfOj07MuJmETtFDVWMV9iFqTlqVue8NR8AKGqEmncm8GpGsk5s/G
         UFvrFoFeHbXcdI3bV3xJSjH76wjBxtjgebzaN0CkLDpGgo1A2f6Qgc+jE97TdEwHV8Fy
         QZAc5gMD9ALm+H2Z59k6R3EpoSJT5eIuangAiRexD3l4btgddD6gl6tOhGkLXTj8D/+k
         zTi6yn7eQvAg/8cu/exKqvpDj7m7b+sfebWqbtqWnpbnMoszBYO9aiL36GsEMN87VyJ1
         JTCPEtb5YO2VmXPxhOwZq4pscUy0LTa8XnTeSI6S+3UhdfwRdwsVgos5jBUCdpnmUm5y
         ZEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gICdPQsIaTjTwUfJWho+jc+GHx6tokQahaBmVhNvwDM=;
        b=lDyzX338y9JZ+nrhOLKZRET+g+YhcgEEWI83LzLsdU+OkUoEBi0C6d2dddB2UW7SlT
         WDU3wP90xV8BuuA8ehotmyIxHL/zuSB9ARC2ya60VpJCVbwYkD2qVRMz/BC82GhhfXxs
         CXGgs3bQEqxcHV+3vGCzCscIMw7qUBtNTnChIg4h207C8wqa+Ksq/mllufvcLrcXC5GC
         PWEjB4xaiErpUxhg76DzQRN17/TZ41IQtLtt/jVUTrVlUCkSN4IW+hl2Hr4ywdN41yQv
         08hSOHNDWwRVMwn2V/lV+y2WxxkXEX0KtRRvBev4VT3tj7+neu+GoLpxfL4bVDBfH8KD
         Ivog==
X-Gm-Message-State: APjAAAUT4NwsZ28uNKt5jQUgI15GYiG+sQv746DZbASjtpIxsGtUVZZj
        r+qf2d41LAV+6lAq09aExRs=
X-Google-Smtp-Source: APXvYqyUshJJ/N7ekbELyD/0XC7quwj1v43OoPlJqRGF0nDUkPg4Z1RHMMRI3kbs6z3a+iD02k6rNg==
X-Received: by 2002:a17:90a:9f4b:: with SMTP id q11mr18114285pjv.105.1566804589288;
        Mon, 26 Aug 2019 00:29:49 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p90sm11195670pjp.7.2019.08.26.00.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 00:29:48 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 2/3] serial: sprd: add console_initcall in sprd's uart driver
Date:   Mon, 26 Aug 2019 15:29:28 +0800
Message-Id: <20190826072929.7696-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826072929.7696-1-zhang.lyra@gmail.com>
References: <20190826072929.7696-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Use console_initcall to save the console index we selected on the
command line to sprd_console before probe finished. Thus we can
make different processes to the uart devices during initialization
according to whether it is used for console.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/tty/serial/sprd_serial.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index a3be4e2dd019..aead823c650b 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1008,6 +1008,13 @@ static struct console sprd_console = {
 	.data = &sprd_uart_driver,
 };
 
+static int __init sprd_serial_console_init(void)
+{
+	register_console(&sprd_console);
+	return 0;
+}
+console_initcall(sprd_serial_console_init);
+
 #define SPRD_CONSOLE	(&sprd_console)
 
 /* Support for earlycon */
-- 
2.20.1

