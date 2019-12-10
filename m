Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4028DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138CF208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575988650;
	bh=AfgQHmivDdTuEN8MKPB6tww4q8kLioJrSg5tZrRmIlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dWwdlTGn/yJ7ffVYBGX4qrYhRdwn9nkGnkT5PkUWHhXhVH8TjMcevK984YQRZWvwb
	 bIJfSAHXKA2wS0trAXwjwPN1yJcFHoOdTl0K5OWbvVOOf/DxUlS9RKbCO9X4BNDYd2
	 gFYc+m5VcbGPgI7WeOvRRP1zgCy5QUGsrBpda52M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfLJOh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:37:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfLJOhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:37:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1FB320836;
        Tue, 10 Dec 2019 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575988645;
        bh=AfgQHmivDdTuEN8MKPB6tww4q8kLioJrSg5tZrRmIlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LvSG/BfevEmOGk8+22QtkwRVC/b6x1ybdF2TmDjSgck4tR/3XQkdm+HMOLObBriSR
         1024ozY5z9k+hnveU/8won1uKLivOeipi8o/nuAYYmljmYO1O3HbXP4TRk6Vg2k/nL
         y18O1vYYTA8mtfFJrMtIH5MytMS3ZnlPw+kEgYwY=
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
Subject: [PATCH 04/10] tty: serial: samsung.h: remove reset_port callback from struct s3c24xx_uart_info
Date:   Tue, 10 Dec 2019 15:37:00 +0100
Message-Id: <20191210143706.3928480-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callback was never set, nor called, so remove the pointer entirely
from struct s3c24xx_uart_info.

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
 drivers/tty/serial/samsung.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index cdfd53acead3..7255ef287857 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -29,9 +29,6 @@ struct s3c24xx_uart_info {
 	/* uart port features */
 
 	unsigned int		has_divslot:1;
-
-	/* uart controls */
-	int (*reset_port)(struct uart_port *, struct s3c2410_uartcfg *);
 };
 
 struct s3c24xx_serial_drv_data {
-- 
2.24.0

