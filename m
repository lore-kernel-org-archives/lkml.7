Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A919C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3F4217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vvpeXRKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbfGaWRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:17:17 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:33107 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731329AbfGaWRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:17:12 -0400
Received: by mail-pl1-f202.google.com with SMTP id f2so38311460plr.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AYLtZ41z1RHlFpOZnl+JGLaHaK4EJ2Av6xB01tUKIjQ=;
        b=vvpeXRKyc5OhHv4Gr/tukOYbwIwjOYYXtqIP/Io9iIGtPO3Kve6jw/W7bz2rF/pLv1
         RlW5o4cGWbTXLPdROo8nSoKA3X7rpN7sDIwV1d/Fkm3vpj5fFKlODN732XeUwRiYz3Ke
         TW9ChBbAGCWNTBdcbOZ73xw4f5kes2Emo/1AT/+3MfhQ8BoEcrnKZHlAFFwFtqt85uMv
         Hrp+989qk4cKlnGSLSV1ao/ObzrMwaeocP0iHhwU4p9uXakErgQiaqLm3O0VzWsyNNyY
         9CqLjrTvWM8AjYlNkYT/fe066FOTrmczakFGWc6cjFSFGLsLIYYWVoFByBrYFECbZTDO
         MNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AYLtZ41z1RHlFpOZnl+JGLaHaK4EJ2Av6xB01tUKIjQ=;
        b=AgRH1n59gKOqnkX+PAfkgZowwbiCGcZ/qSERu7RAan3H426QfPCoOM4u+hx+sh11UI
         WH5pOTteYjHMBcH+pFAmn03LgmtT3aHv/+q/d9m5uuPXbym0ZM804P5ED4aK8FFZK+lb
         6iwGJEfkpnf5SHUKI1ifmY49uBxaz85+6b4QnN12I/m6p8ocmKC4B8jrb9NRx0dQyaGo
         VX84YTh6aGhJfiiUDqMQRPmRjM7CWD3pn1bcXcsm+gzY6F7jyhdQ/dkzUEi/Uhz0pOOn
         vC5A42KhvVHDgOyEHwC69DPRyLM7ZBbFDhPwY9KFZBiYOq4vKSbD1uGLG69p0drib6dZ
         zkPA==
X-Gm-Message-State: APjAAAUBYZnCoFAwbGe3S8aDQ+AozdZCZMhDr5WUaXHdg6PPkRpAglO0
        82mUjAgGO2LIk7gJWsnooS91oAosJ1+z10iQ6dizpA==
X-Google-Smtp-Source: APXvYqzkiW7uEdQQUtaZ0YHcWPNEQQcr9wR/H4mTJIlJ8xEUbv8Q5RP5zNIsLLGkfkAO0eul945srgorH4QzlUVn11pgkg==
X-Received: by 2002:a63:5402:: with SMTP id i2mr88751122pgb.414.1564611431661;
 Wed, 31 Jul 2019 15:17:11 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:16:06 -0700
In-Reply-To: <20190731221617.234725-1-matthewgarrett@google.com>
Message-Id: <20190731221617.234725-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190731221617.234725-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V37 18/29] Lock down TIOCSSERIAL
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Lock down TIOCSSERIAL as that can be used to change the ioport and irq
settings on a serial port.  This only appears to be an issue for the serial
drivers that use the core serial code.  All other drivers seem to either
ignore attempts to change port/irq or give an error.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/serial_core.c | 5 +++++
 include/linux/security.h         | 1 +
 security/lockdown/lockdown.c     | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4223cb496764..6e713be1d4e9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -22,6 +22,7 @@
 #include <linux/serial_core.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/security.h>
 
 #include <linux/irq.h>
 #include <linux/uaccess.h>
@@ -862,6 +863,10 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 		goto check_and_exit;
 	}
 
+	retval = security_locked_down(LOCKDOWN_TIOCSSERIAL);
+	if (retval && (change_irq || change_port))
+		goto exit;
+
 	/*
 	 * Ask the low level driver to verify the settings.
 	 */
diff --git a/include/linux/security.h b/include/linux/security.h
index 3773ad09b831..8f7048395114 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -112,6 +112,7 @@ enum lockdown_reason {
 	LOCKDOWN_MSR,
 	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_PCMCIA_CIS,
+	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 22482e1b9a77..00a3a6438dd2 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -27,6 +27,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
+	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.770.g0f2c4a37fd-goog

