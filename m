Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FC6C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78245217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="P6xquQre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438361AbfFLLPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:15:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44538 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438272AbfFLLOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:14:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id b17so16432089wrq.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 04:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pL4z/swoTMwbTbMm+CZTE8PZN5IahPwWK1oKgA44Jw8=;
        b=P6xquQrececmcvLrvYX6swykHVbte7Nk4tMjJVlxC/IGkE5po85UR/FmEjTmBnjHBN
         7UXsptqBv4hijV+N6F7edAiOxTf+ZQZme0r0cEUHESbi9S7GOm+OyYpIq+HZMZ7IMpaq
         6ch1uIpSIvD6d0ZiSPH22yyqoPcWc7c9wkfkEyGcRJ60ehHz5PhiMhayyoZbvOGsBrxQ
         bZ2LzFT48JTUjjm41S5ZNe7RbvRK+iVQuVV4NibXS0K6W/FVhfanPVOkDruhGfEIqS47
         1jK4ZdVTE3QhZyH/G2nPRAGWdjbcedgLKigKS00FyWB3fRstKP6kgEUlfiNPaDWDxIQB
         SlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=pL4z/swoTMwbTbMm+CZTE8PZN5IahPwWK1oKgA44Jw8=;
        b=DbxOVMDVYgXh03fpWYfb0DgQy63jtZvupOLS6FJ87AFWgvd2yPBFDfy7eFd9pIvThL
         1SS7rPXJBWE6LQsyO4MJG0tgC9WTYCsllJ0uVfK/E9rI7eYozCy9ZKIsZx5PK5IdThU6
         b4caNGHsOI6KbhZwAO2D2pu8bU8ru34mbPOtb8HNu9LCYtrJY5vJIZ6+DgBUEYdTjBj4
         M0u0ExdI7GpSqhHGUz20MIp8uMkXEHqCqR7AQjcwK9sgHlZTcs0yvwUFoQktX1nOnzDq
         vfy8FI8a2lxBRJ3YL+blB/vJ7KmclFi5ldxaWzSk+TkOs3QjIm3dl1HoNhz1LfFujK9U
         3yBQ==
X-Gm-Message-State: APjAAAU2r+P5M6rqMQF69+lbdAUxen7Ldlo+zMgkNEvPHuppb2C34FD1
        dgMNmOv22N3SJ7IcCqmTu2hpOg==
X-Google-Smtp-Source: APXvYqwF+qopOc/h+NW4uHI2iFfpMRXvQ05mIybiixrrOldDG1ljO4J1jrhB5kuhJ/jptlEuRoQ9rg==
X-Received: by 2002:a5d:4ac1:: with SMTP id y1mr1818664wrs.183.1560338091629;
        Wed, 12 Jun 2019 04:14:51 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id y2sm17676131wrl.4.2019.06.12.04.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 04:14:51 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/6] serial: uartps: Use octal permission for module_param()
Date:   Wed, 12 Jun 2019 13:14:39 +0200
Message-Id: <159139864be4ab81e75f20f7fdad604ce270f8cf.1560338079.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

Octal permission is preffered compare to symbolic one.

This patch fixes checkpatch warnings:
Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal
permissions '0444'.

Fixes: 85baf542d54e ("tty: xuartps: support 64 byte FIFO size")
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Split patch from v1
- Fixes second S_IRUGO usage
- Add Fixes tag

 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 9dcc4d855ddd..c84db82bdaab 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -35,12 +35,12 @@
 /* Rx Trigger level */
 static int rx_trigger_level = 56;
 static int uartps_major;
-module_param(rx_trigger_level, uint, S_IRUGO);
+module_param(rx_trigger_level, uint, 0444);
 MODULE_PARM_DESC(rx_trigger_level, "Rx trigger level, 1-63 bytes");
 
 /* Rx Timeout */
 static int rx_timeout = 10;
-module_param(rx_timeout, uint, S_IRUGO);
+module_param(rx_timeout, uint, 0444);
 MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
 
 /* Register offsets for the UART. */
-- 
2.17.1

