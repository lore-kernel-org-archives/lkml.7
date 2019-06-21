Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D03C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7CD2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WyOmpA9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfFUBUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:20:43 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:56048 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfFUBUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:20:33 -0400
Received: by mail-pg1-f201.google.com with SMTP id b10so2949803pgb.22
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=21zVfVQIgxs18frGEjlMaz6K2O9ZtjPmBWXUPVoOvcs=;
        b=WyOmpA9QtPvqxVTlHFAr1aYSi9expt/Y60JFM3suEeorE0t0yy/GrUS6vGGOUzScpn
         JWZAFEuq63FT1Mk6EFCTu9MKkPJwkf6/tNKBPo/ySXxusxtXZjsaTBT6xs8DpkhwinQ5
         FTZ2Sxvb8IZVoca4y42ewg/D89PAQq98EgQWP4Nv/z2yRE6dIbskvmYmpCRgKGY17NII
         SxM05/6NL1lIjhSm9Fc/EvF6I9txsfx6UkmcI2qGr0BzsfKJ35bbQYacXol/JRRmPs9r
         F4qDUqadiASSdMEkkd/udpLqwhtA7xlA60IhnZSY0xQ/cN6d/wGSp+5h8Lo/i0xiMjM8
         qLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=21zVfVQIgxs18frGEjlMaz6K2O9ZtjPmBWXUPVoOvcs=;
        b=qT3WRlmF2PJAJQSfsImD6+tM2dYZfhy5IeSzDWnNziuA5shpy/uD18C+3S+PExg4An
         lFjyzTA8FWxvwaTk2z66dQZYTzEz71Fr4zYS9ewK5REic298OPiFUAziJhSvVzIa0YTO
         jH8LNyuF9QoTQgvNjK+S1DeW2HBo99aFj1ZCfWHbeRXtzpkJHykCKxE0FkSfmnXhA2Fn
         rt4Njy78S7ST9TRR03rushnprsFxBq1wi9doqB5q1JjfVxbjoeJ9gl5B1QeysoJSJh02
         H83ZXqfYul7t/IndPKQufjrmTM9aGZRcs+99eypt3wg4GgZff220h4pkpw4gRxnupLTU
         llew==
X-Gm-Message-State: APjAAAVJ24u0aRUfxg4vxhNrjuX4RsWMrIaGnUG6RCtk6fip5GS+6iCa
        NBYxQPI4goNIC8DTrAgq8a/aqqZzFyEywdbSTMBl2Q==
X-Google-Smtp-Source: APXvYqwEzCwIrRjE59rfKIbX5unImEXqInpU7egqI3leYK2BXnc2J7PTQq9FXUBiEv6Uf3x9yvCNNc7wrzJ3FCaAgld2Ug==
X-Received: by 2002:a63:5152:: with SMTP id r18mr15484090pgl.324.1561080032751;
 Thu, 20 Jun 2019 18:20:32 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:29 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-19-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 18/30] Prohibit PCMCIA CIS storage when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
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
 drivers/pcmcia/cistpl.c      | 4 ++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index ac0672b8dfca..fb54e262578c 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -24,6 +24,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
+#include <linux/security.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
@@ -1578,6 +1579,9 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	struct pcmcia_socket *s;
 	int error;
 
+	if (security_is_locked_down(LOCKDOWN_PCMCIA_CIS))
+		return -EPERM;
+
 	s = to_socket(container_of(kobj, struct device, kobj));
 
 	if (off)
diff --git a/include/linux/security.h b/include/linux/security.h
index 88d0f5d0cd87..87c433f1e7db 100644
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
index bfc0e088aa85..ced4ddbb36b4 100644
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

