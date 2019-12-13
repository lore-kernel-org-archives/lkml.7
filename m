Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719ECC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40577214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="EajhwHVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbfLMAIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:08:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35386 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731736AbfLMAIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id s10so397924plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFqw+HPsj+UvL3ErVQQmLmN+s/+CgB/NwHLHlutjOiw=;
        b=EajhwHVdE3viF6OTqFPMh/mMhJda3aVHtZVSvDfWNRga5xkSjsM3jyQK1O7FKTOWKp
         FA9x5OeKeLVn7IZoFwXwdis4MujSaLsdJFTb4AIJD23KP+5XJC2e3yD1aqBCz0iP9Pix
         3ziyudM3CqRn6mEK9owgMvbHihbvnA8MwB331cPepfB1KWUAkq/5dflShGPRrQUAUb0W
         FWWV8Bq8N6vgVXZCkMJrET3VPLaG5o/goCy9AMbnVa6bpGtq0IHlQw0W1ByEHiqG749V
         W0E5uCm68XlrEo4WAWw77o8nYomafrEjUNyszlsN7japK9WeUqT4aHzWeauSRydNtSRT
         p/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFqw+HPsj+UvL3ErVQQmLmN+s/+CgB/NwHLHlutjOiw=;
        b=klZrsNRhwPnK2CXTwuW0m1AqzDbkZ2pMj5KNIJ4foGfqrhovahRxkuTnMOdo3ty8vf
         5agY17kGy6fVBNr/GnfHpIcnZN16nMrB7aq6WopSekzkEKeu2VeeYKsk2X5pn0rLCDeP
         RC3Xjf379aDk7zC9fI/x1mxkNeGpfP+heeDb5nJfLl+iy/0FAHJPrT/3X7aK1xo09DHk
         5G98hEqonuK64K6lfyazosJ9hAYFT29ZzbTodp+rSx9LKbNHkm2CdqUszBfXqWffGcW5
         /JzE1GMvbAlIk1nM+l2XQZpG55Di993elwKRgU4Ytosy5m8Q4ZIi6gfPLjFrI3/V4OeM
         /hHg==
X-Gm-Message-State: APjAAAW95cZ8qkdZYFGk9GOutnHKFUj6sKzOMESdYvYv05wrW+kU6Xp3
        aFeLmZ6kLPZ9BA0uR988szE+VNwC+3c=
X-Google-Smtp-Source: APXvYqyF6KmCyw2+4DGZMs1GewyAV9nRslaYtpLZSwxmJE8Eo7U1bhbKpvG5tJ/6K6I51waBc+InfQ==
X-Received: by 2002:a17:90a:2223:: with SMTP id c32mr13646956pje.15.1576195726336;
        Thu, 12 Dec 2019 16:08:46 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:45 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 31/58] tty/serial: Migrate pmac_zilog to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:30 +0000
Message-Id: <20191213000657.931618-32-dima@arista.com>
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

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/pmac_zilog.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index bcb5bf70534e..ba65a3bbd72a 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -61,10 +61,6 @@
 #define of_machine_is_compatible(x) (0)
 #endif
 
-#if defined (CONFIG_SERIAL_PMACZILOG_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 
@@ -1721,6 +1717,7 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
 	uap->control_reg   = uap->port.membase;
 	uap->data_reg      = uap->control_reg + 4;
 	uap->port_type     = 0;
+	uap->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_PMACZILOG_CONSOLE);
 
 	pmz_convert_to_zs(uap, CS8, 0, 9600);
 
-- 
2.24.0

