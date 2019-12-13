Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC50C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4EE227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="frhyqHYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbfLMAIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:08:37 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35363 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731699AbfLMAIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id s10so397445plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uLaSb+04RH7uaNmurK2bND0CZp19b8gTSTxLObfuai8=;
        b=frhyqHYJ9l7cWgiM4jYZNt73/j/pL2ztPi9n4Onm+5/RPj5dQEamFfPP+w3fhcB0n4
         KjH5enTCM/ZrA1N4MGOGvEKO8MECNE1Sw2ytoWTl6JFFmsChiB3zKhbvTikolsouILnV
         yYjbCN6UfLWbo4xNHunxDujkkNYHmoJRkefPc0TCCt/Rw8jA1oO6WlSp+76SUk/QeCdm
         OBt3h9acwRkWGw6wuRQsVMGKrXj03ptIZZzQtew+1SCqajaOCIJK+/I/3PYfFVgAKtNO
         rFBWOND0O9F5PSBLr/cjMWhAsktSukCfyjeoPBXF6UESeN/JR+uwvyFZBLPnMr7SUZLU
         OB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLaSb+04RH7uaNmurK2bND0CZp19b8gTSTxLObfuai8=;
        b=Jjk4T5Rz/nqLPRGuiTy3JvDlahEDJV2bNSIsDtYNVpE8snyq9oNJnmiCo4paE3RDth
         3eePGy0ieRRVoiEzM6VHQYNuRmPBokHXLTMZFESTvb90sXOmS4+j8Iivvy6mBYAw+WR4
         C74hHqihEvY5fF3vDtqizDCJR/rDspY3/0ZDLfYynhSeoZsjs5D6Gi0wBiz+WggpfEVV
         Qw9kyglePDcgSIRsAs4p8tXvq05i3G1x02RHE3SzqYCSjAXdijbzT4dxTD0oKNPT81rE
         eyMLDt9gKDlDkMERdYWrwk/d634KC6H96gqIA4LUeA8CbMyo91N3NDpBsRkvRMUjiUIt
         VwYg==
X-Gm-Message-State: APjAAAV+3Z5M4VO2FHF/RF3qRKVqLekDi4nCTYrfxH+zlVxl1wcjVS83
        g0sl9zLNN8uMGjWFtNZLRKSjv15lI4k=
X-Google-Smtp-Source: APXvYqxf/s+KfE+mWbXDwevNvIA11XGgWQIi4HzM+v3BtwcfvzlBYxpnYV9c9Z+0BLeRcMTXAJdlrg==
X-Received: by 2002:a17:902:7b91:: with SMTP id w17mr12983685pll.158.1576195711016;
        Thu, 12 Dec 2019 16:08:31 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:30 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 26/58] tty/serial: Migrate mux to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:25 +0000
Message-Id: <20191213000657.931618-27-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SUPPORT_SYSRQ ifdeffery is not nice as:
- May create misunderstanding about sizeof(struct uart_port) between
  different objects
- Prevents moving functions from serial_core.h
- Reduces readability (well, it's ifdeffery - it's hard to follow)

In order to remove SUPPORT_SYSRQ, has_sysrq variable has been added.
Initialise it in driver's probe and remove ifdeffery.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/mux.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 00ce31e8d19a..2a9953211a2a 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -25,11 +25,7 @@
 #include <asm/irq.h>
 #include <asm/parisc-device.h>
 
-#if defined(CONFIG_SERIAL_MUX_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #include <linux/sysrq.h>
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/serial_core.h>
 
 #define MUX_OFFSET 0x800
@@ -483,6 +479,7 @@ static int __init mux_probe(struct parisc_device *dev)
 		port->ops	= &mux_pops;
 		port->flags	= UPF_BOOT_AUTOCONF;
 		port->line	= port_cnt;
+		port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MUX_CONSOLE);
 
 		/* The port->timeout needs to match what is present in
 		 * uart_wait_until_sent in serial_core.c.  Otherwise
-- 
2.24.0

