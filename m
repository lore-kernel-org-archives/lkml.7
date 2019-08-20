Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38172C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B10D22CF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzYoJdIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfHTAS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:18:57 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:41379 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbfHTASz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:18:55 -0400
Received: by mail-qt1-f202.google.com with SMTP id c22so5493054qta.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=35n/myhIkZARa/uZ5q4gPGoePbBU8ZNX2O/3CkYF71I=;
        b=JzYoJdIQZVqEBD5V6Z09iglYOVrptulOchSxI38Va5W+5i7yu7JjEQ1tfyAcjGsfjk
         Ujys/43RkAwNlA3IBcLbJZL3Kteqr25AqiPpGRePZ/fHZyJWmUaF2Y6bgihwhUCEULS7
         tFdTRxF0bBH9K623IwD11d+QXIP8+MWxTbMp4/QnSpnTF+APBAmnlNLnjRpeHs2yMZPU
         4QSmDpNc1brfw2EYa68be4okFH9MC0rcFxw6yTNP3RX6zxoutvJg08xlkwgp3FnLvkQ8
         JyjOy4+stN62QQ4hjASilJPpH0bVJ3aZhbGQmRxbfF5l5YQPXQALMqpaHWLVawVQ6A7Y
         Ds4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=35n/myhIkZARa/uZ5q4gPGoePbBU8ZNX2O/3CkYF71I=;
        b=AYE+/VRrMdNNRCKSs7l6CaZs+NXl8E+9DbtadevZJVuJ0nbjFESxJee5HUoaMBW/Qx
         KFRIn5TkD5S6+cLYAwvDJIpR8KPNQiVf6QnpdS50rdAgHJPWXYCOPj5yODf/Feci5LUa
         OGATLgaCcs6qJp7FwvM+wuMVh1J2t7UdSQ5YhfT8imyY8QfEb0q34DWyT/WlD0zCunqL
         J0CYbOzpsLW65lq11E0Sk/WpjYdFC85zNMLTaOAKUwOCGDMDvKQU9IJundBmSjoJEd76
         8+pHNw+Hk6877N3fsz7bTQyRpRgKx5fHtgdNAZqF4vxEpED6aGy5+V3T8xPc4MdYO3Jr
         BAbg==
X-Gm-Message-State: APjAAAVqD77nfhjQhKbzvE3YJNrLV0AsmO1C6P8j3DFgjwvE9xTuAnmE
        Q+/E0nqLoX2VCHtmrmlYARpb+ik8aIClqKu8GkjH/g==
X-Google-Smtp-Source: APXvYqwgFJReeNBSQsxX68hmXsAE1XGrgus1KCE19suNs39UH8IvwU8aXND2CXO25Nm5Epvyyk03cPBQ9jbtpGvtwhfY2A==
X-Received: by 2002:ae9:e916:: with SMTP id x22mr13987177qkf.296.1566260334505;
 Mon, 19 Aug 2019 17:18:54 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:53 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-18-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 17/29] lockdown: Prohibit PCMCIA CIS storage when the
 kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: James Morris <jmorris@namei.org>
---
 drivers/pcmcia/cistpl.c      | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index abd029945cc8..629359fe3513 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -21,6 +21,7 @@
 #include <linux/pci.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
+#include <linux/security.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
@@ -1575,6 +1576,10 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 	struct pcmcia_socket *s;
 	int error;
 
+	error = security_locked_down(LOCKDOWN_PCMCIA_CIS);
+	if (error)
+		return error;
+
 	s = to_socket(container_of(kobj, struct device, kobj));
 
 	if (off)
diff --git a/include/linux/security.h b/include/linux/security.h
index 390e39395112..683f0607e6f2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -111,6 +111,7 @@ enum lockdown_reason {
 	LOCKDOWN_IOPORT,
 	LOCKDOWN_MSR,
 	LOCKDOWN_ACPI_TABLES,
+	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 6d44db0ddffa..db3477585972 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -26,6 +26,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_IOPORT] = "raw io port access",
 	[LOCKDOWN_MSR] = "raw MSR access",
 	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
+	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.23.0.rc1.153.gdeed80330f-goog

