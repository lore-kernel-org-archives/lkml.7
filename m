Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD7DC32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C90B21873
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 00:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNie7NtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389697AbfHHAIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 20:08:15 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:43006 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389676AbfHHAIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 20:08:11 -0400
Received: by mail-pl1-f201.google.com with SMTP id x1so11876533plm.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 17:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AYLtZ41z1RHlFpOZnl+JGLaHaK4EJ2Av6xB01tUKIjQ=;
        b=FNie7NtBIlaKsZ9JeO4UTZvAADr/vOE4ouDpyC2J7cEuR+3Dd/thtyVqfU90wTT+vo
         T2vvtkEsWxarn40J0aEfSMXiYfObRgMgqgUgztiu8Pbe2q9fbtQaVJDwuCKjphmzsbbu
         JbJkPaTR92GhnTqg0cTjlFVEFW6JZ7kS8ZiskcbWTBawHqcXTOa8Z343LCuIJ6yj0R25
         V7/fCrcTcBuY7DZS3uJDAarNM8aLzi9UzpZfgm5Z/kVfBv+wML+duudHMtsnSKnUQlfZ
         SuGJqzbsl7PWKVlBli8s9iWfhiCI5LxLmCzHHNaoKngqFkY8nLlLoeC8/0cL0Snf9wd0
         NkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AYLtZ41z1RHlFpOZnl+JGLaHaK4EJ2Av6xB01tUKIjQ=;
        b=UCaqLFcMuUj9/4m7uowEBmo3Bs5nGiUJDsdzvNTU1i7OBlD6hSft6tzx1g7XYqWcZ6
         h+fuMpTD0rNPrX9GhQ9vR/q20+/HEOkZO4kYJGh0AA9UW63TJOd8K6Qde34WnrapQIMh
         2stFJhonZ9CDZQF3Lj10QxpIRg67SnF0tYImBJTRHkCun7fq6qetjwbsDJhnrMGdID3k
         I9Pbc4LY+KTkHC3HNeKKtRQsg7NfIT0T/Y1xJt3hGWZXGA7hlkXAOxg08BElxi9wKA97
         ZqYkldAI7831absizsX60ffmtDTmvVFlxHovQb78NJTY7Ad/ynqwhr+rcS9t7VoAfuAG
         0VUQ==
X-Gm-Message-State: APjAAAX8vF3p0MTl0xNYCuRrV+Zd/981Iu5xJSqBxahMChIPFy5fVjHc
        dqbNpW46t7vGsH0bVVd6B7EEEMCnMD3MuY08KE6BYw==
X-Google-Smtp-Source: APXvYqyY4hPQ+uSwpXLxD3x3XBZHACPHGjdsgDh7wMOUzCkOt1SqtErX3QclbGkE3NIJReG0NbtaFtOgSRkBHvVk1R4mAA==
X-Received: by 2002:a63:1b56:: with SMTP id b22mr9896383pgm.265.1565222890522;
 Wed, 07 Aug 2019 17:08:10 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:10 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 18/29] Lock down TIOCSSERIAL
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

