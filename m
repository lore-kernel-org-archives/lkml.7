Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB4CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87EA22464
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575988670;
	bh=m0lB1KBJGzLu2Nv3nVszKTS5oGkAmP6KPGxbx0TkchY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IhaTanMxhyfFD+Ll6OF/CfUJHrFoYeeQAnxuuzcCItx0O76esH/uAy7AuyS3JVoM1
	 CuzP+Sf5Ab3X4rAg0P6Vn/V8mAgk7Ijx3DxB2s4p9Mh7LWUxmDJf7lQaE6jEO6fPyc
	 Y5rbfSdmxtC1EUdTZQafz6VbWR4TjDpQm0S6sSRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfLJOhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:37:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfLJOhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:37:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06D2820637;
        Tue, 10 Dec 2019 14:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575988654;
        bh=m0lB1KBJGzLu2Nv3nVszKTS5oGkAmP6KPGxbx0TkchY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rpq0Zs/7e7NoILu4ColZzLYhfZzEd3sFr1/aWWHRgaH5ksnQdphGu+sua3vSTG7Rh
         ypoO0EVmxl9grJgZR5qsY2Q4apTxJF2+2ZwM1IL/QtQfo2T65qW6RY7hhrlOge8zAR
         uJ/IwUKnibVLAqcoREo4koHaQySPAUjr+sT7FXHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] tty: serial: samsung_tty: use 'unsigned int' not 'unsigned'
Date:   Tue, 10 Dec 2019 15:37:04 +0100
Message-Id: <20191210143706.3928480-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function uart_console_write() expects an unsigned int, so use that
variable type, not 'unsigned', which is generally frowned apon in the
kernel now.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hyunki Koo <kkoos00@naver.com>
Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
Cc: Shinbeom Choi <sbeom.choi@samsung.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung_tty.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 12f6b2872076..3dfb4f37ec69 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2613,7 +2613,8 @@ static void samsung_early_putc(struct uart_port *port, int c)
 	writeb(c, port->membase + S3C2410_UTXH);
 }
 
-static void samsung_early_write(struct console *con, const char *s, unsigned n)
+static void samsung_early_write(struct console *con, const char *s,
+				unsigned int n)
 {
 	struct earlycon_device *dev = con->data;
 
-- 
2.24.0

