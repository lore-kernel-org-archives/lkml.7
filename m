Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000EAC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C440220881
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FN6rV7g1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfFVAEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:04:49 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:44797 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfFVAEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:04:46 -0400
Received: by mail-vk1-f201.google.com with SMTP id m1so3033829vkl.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D0cR1P9fRxl7I0Frc/NTBEIf+XZBbF2jRPFJwWOLz+E=;
        b=FN6rV7g1wI/cQULj1NeHY25dTFSqkhZVIJO87pMC8h34LSqiJQhwzDrpYiiyO8S5jK
         5WuO9AZdivmx/IHth4tUCWQsu6aK1fXCa5IPsW5FyAyGqhS8o7SCfRLNWeyr907mEW59
         BAJPQagNPHWoiAygcQ0WsleyxggB3QLnTgAO+0Zr4NToG2qapy/zD98DVHT5+cl8/EFi
         akZMCzlatqaUHLdwExao4rabh18Lcd6oOW0GtIjJk38zWfTVsXKKAKOuzq3RsSad3pYx
         ZB4xF7cn+5hEak/ocAoFV8txF3GMIWM+p7k63J35lWdSBGYy+9L8ZWheJ2dRmhfe0fOx
         k6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D0cR1P9fRxl7I0Frc/NTBEIf+XZBbF2jRPFJwWOLz+E=;
        b=eZ+wVwZYXNeIMQZlMpJPRhcy27q1v0S/Y8XUEJANo1zkk6ELE4fJnKpKAPDNeuh7h4
         v1H/OF067pobCKQsftUnnj4ST7nn7TWoYaKmO2CGaRpfxokCibITGMRsIN3tD8r7ak4r
         N60prHq2cQ+FzKjqL7l+IE7NYmNJovkxSUQoTCMBP0qW3gxiHWrq8rg0u9WxdPiAnAPZ
         yGBJXwR1gf+RYpn9sZnVbcknh8VCI+3kcqPtv9X7R89mc4/NwFjc4WO4Y9v0j4FKiill
         hwjCv8aa9wHsI+w7ZwIio4jQ79HdpArefBNSjdQU0CdlV2rMzXrcu7xpG531b3zgIZ9H
         a3iA==
X-Gm-Message-State: APjAAAUd+0GPsSUMCjGY/W7HxdkozT/goTRmdZIvPGcIMRIkRP6siPDz
        DYfhVvrNTrZouq5kGLuWjtpLUYrAFSlBzllbnLhKGg==
X-Google-Smtp-Source: APXvYqw4d96MTv19mVO5YEXSxlhDKP6hJERH9aHPkctv1fha/0XtsJ8LHhcPxfrH3Kta8gdSMFY016WdHwGhe4DrOfdB7Q==
X-Received: by 2002:ab0:7618:: with SMTP id o24mr14156916uap.39.1561161885166;
 Fri, 21 Jun 2019 17:04:45 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:46 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-18-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 17/29] Prohibit PCMCIA CIS storage when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Prohibit replacement of the PCMCIA Card Information Structure when the
kernel is locked down.

Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 drivers/pcmcia/cistpl.c      | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index ac0672b8dfca..379c53610102 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -24,6 +24,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
+#include <linux/security.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
@@ -1578,6 +1579,10 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	struct pcmcia_socket *s;
 	int error;
 
+	error = security_locked_down(LOCKDOWN_PCMCIA_CIS);
+	if (error)
+		return error;
+
 	s = to_socket(container_of(kobj, struct device, kobj));
 
 	if (off)
diff --git a/include/linux/security.h b/include/linux/security.h
index cc2b5ee4cadd..03c125b277ca 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -90,6 +90,7 @@ enum lockdown_reason {
 	LOCKDOWN_IOPORT,
 	LOCKDOWN_MSR,
 	LOCKDOWN_ACPI_TABLES,
+	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 1725224f0024..7be3e8fb5847 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -26,6 +26,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
+	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.22.0.410.gd8fdbe21b5-goog

