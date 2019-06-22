Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADD6C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C07720656
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YbOGu6X3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfFVAEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:04:52 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33602 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfFVAEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:48 -0400
Received: by mail-pf1-f201.google.com with SMTP id d190so5328402pfa.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7XUJQ2WWQgV+58iwM6R5lnhVlgjpfti3qggxZNIjvHc=;
        b=YbOGu6X3QdBGGGe8faHuFUYcFb8svwX0Yxl+CKZAFfrIXqI87gpdCYLkBy1RaGPta6
         yrXHUhg6AvScoTY4m1Odo+/d3z9d7LUQVs7GrNeE9mFjrvxC0jFRRG0WFDmeARdHINoL
         9EcWj34vMERn+3r+itQyO16RcWcpEpm9Lf6JNPHsvRDe46Q5sI5yk8mvHp3AbTMt9oeY
         Eovet+DRjjFBtgQyhhJsO/zVZP74OIBcPT7f8KuZ2LtAAHjxLB0tATATujAR/MbaUZZ4
         Pm/32Y/fZlVXUWXMUQoLA+3vWhjjyHix9KSTINraPHgkYVJQZgEicVTLVGsYT3pskJn6
         egvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7XUJQ2WWQgV+58iwM6R5lnhVlgjpfti3qggxZNIjvHc=;
        b=c21PGiSzi82Z1HUmOypLnYpTNVr6KPZRAz+A/Bj9/fEFpkf56xDtzxfW79GHCSD1/d
         opmRozo8JCNqmFz+KePb4udkxTg4uc9C5Zp7/ebAWsEtXaRz59QU7ahtCcN2+WelMU68
         NY1pTqKDsLukY3JY8u/XX0fgNXoNpdej1o2GMn7+vHq4B2MApc3Hjp26rvWYXJoC4SKS
         +0lhO7NvvU7ZfLT57DMVHT2Vztyp/CwyhXT+q/A1/0c1JExc0brRI7d0uYILdXHacUtW
         CxTdTBSDd/uK6G+mXh1Qyl0OWbtkKEXPFTxBGBmBEk2IiC4E81IGQ+c2aBd0d5vb6Ea/
         MOAw==
X-Gm-Message-State: APjAAAVQ+tjDJeBOKXxD9kWmHi544dPdyoEQ74lNx4cvbkcxzm7O8Byx
        klY4+EGa16CVapt9nSoUs9j6YmYy0LS0uPPppIvRbQ==
X-Google-Smtp-Source: APXvYqwX0BWadWUzKD1pGC6iismXRYFWPwCnDuU+HcsvZA1gPfoXYPu6NOPQ3UQf1f2qQnXsIVTWV1ab1WpwKnLIpbDK9g==
X-Received: by 2002:a63:f70b:: with SMTP id x11mr21395458pgh.212.1561161887383;
 Fri, 21 Jun 2019 17:04:47 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:47 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 18/29] Lock down TIOCSSERIAL
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Garrett <mjg59@google.com>,
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
cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/serial_core.c | 5 +++++
 include/linux/security.h         | 1 +
 security/lockdown/lockdown.c     | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 351843f847c0..a84f231a5df4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -22,6 +22,7 @@
 #include <linux/serial_core.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/security.h>
 
 #include <linux/irq.h>
 #include <linux/uaccess.h>
@@ -852,6 +853,10 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	new_flags = (__force upf_t)new_info->flags;
 	old_custom_divisor = uport->custom_divisor;
 
+	retval = security_locked_down(LOCKDOWN_TIOCSSERIAL);
+	if (retval && (change_port || change_irq))
+		goto exit;
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		retval = -EPERM;
 		if (change_irq || change_port ||
diff --git a/include/linux/security.h b/include/linux/security.h
index 03c125b277ca..61e3f4a62d16 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -91,6 +91,7 @@ enum lockdown_reason {
 	LOCKDOWN_MSR,
 	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_PCMCIA_CIS,
+	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 7be3e8fb5847..c89046dc2155 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -27,6 +27,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
+	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

