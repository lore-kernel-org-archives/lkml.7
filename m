Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1A5C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCCB2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0nFVrNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfHTAT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:19:58 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:55359 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfHTATD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:19:03 -0400
Received: by mail-pg1-f202.google.com with SMTP id g126so3475364pgc.22
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kSndO1IyWL1budUByV+82z7IsO0BZXBN4MJZqcoLXQw=;
        b=j0nFVrNervC7I3BR+Z1QC81XmRIe2YmnXC7Cqwcn2E6D7xAhmPHmV+aT8y5rQpX9ad
         teINQ1HOSeqytN25tzMSG78dJkJYoNQdiYzoZhea3biYu46tS6p4cx3RtVoQp98SvwZi
         kfexMErcC5TovudQyU3zvN2BZbfwNhm0swRqHXfo28A7gW2byAyNbmIkiL3tftU+9FD2
         Q7qQF0vRWQ+JwjjXM25yPwXV2ShaoYk7tlc45AR+1U8GomtEwFT0KNiCSQA5+nvNMOsG
         z2ZefRwY/v8btpHc9LUXrQdvd5dC3zl/57/AcBfDfHvWpd+wPZ5uoRK/Z58dbY1F/LAx
         IMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kSndO1IyWL1budUByV+82z7IsO0BZXBN4MJZqcoLXQw=;
        b=fXtJDrJ5H3p7e4Uaj4V9NaCH54TnoZJ+qML4hbmmc/g0iboY03Dl62MiJpkC3hT/AO
         grGL2gHgMK68itHDlK0gTUQ0DAoqAcNJpyjZ7r2U4U5TUNwRvqEce0l5RnzzlzNESioc
         MxQbYi/bZZ6NHpHpGgiJr3NaX9s9DWfHQE4C1bqk0zc8dvGFCfYG48mBepfl36SniJUH
         CDyadB+LeraxqYAJcSsOtUDkALjntSYayULv+3/NbK2dpu2xuymn+HY1a6o/c/G/6JEQ
         MqpAg+3WGqaFEEAdSB+sguqmT6taTkURhuAPMIsu+sr20HjkDzC85OjoVaTd1IZHk9/J
         DVtQ==
X-Gm-Message-State: APjAAAWu83sDGAQBlSCu65gkasI7TXO1MtE0yydrfLvA9N/p+360eX3n
        IEAS3dTyqxcalxoB/BFSRPHTnQ7KbiJ+r9USByjRiQ==
X-Google-Smtp-Source: APXvYqx2IjLAlfgRjoYilTBJqfl4V5Oq/ObnV9HcoK+9uqcvTL/Xf31s34HePw8QjRwYhZztTZ9RPHRA1BfCmqeqlSMN5Q==
X-Received: by 2002:a65:534c:: with SMTP id w12mr22332444pgr.51.1566260342057;
 Mon, 19 Aug 2019 17:19:02 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:56 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-21-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 20/29] x86/mmiotrace: Lock down the testmmiotrace module
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Garrett <mjg59@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The testmmiotrace module shouldn't be permitted when the kernel is locked
down as it can be used to arbitrarily read and write MMIO space. This is
a runtime check rather than buildtime in order to allow configurations
where the same kernel may be run in both locked down or permissive modes
depending on local policy.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Howells <dhowells@redhat.com
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: Thomas Gleixner <tglx@linutronix.de>
cc: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@kernel.org>
cc: "H. Peter Anvin" <hpa@zytor.com>
cc: x86@kernel.org
Signed-off-by: James Morris <jmorris@namei.org>
---
 arch/x86/mm/testmmiotrace.c  | 5 +++++
 include/linux/security.h     | 1 +
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
index 0881e1ff1e58..a8bd952e136d 100644
--- a/arch/x86/mm/testmmiotrace.c
+++ b/arch/x86/mm/testmmiotrace.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/mmiotrace.h>
+#include <linux/security.h>
 
 static unsigned long mmio_address;
 module_param_hw(mmio_address, ulong, iomem, 0);
@@ -115,6 +116,10 @@ static void do_test_bulk_ioremapping(void)
 static int __init init(void)
 {
 	unsigned long size = (read_far) ? (8 << 20) : (16 << 10);
+	int ret = security_locked_down(LOCKDOWN_MMIOTRACE);
+
+	if (ret)
+		return ret;
 
 	if (mmio_address == 0) {
 		pr_err("you have to use the module argument mmio_address.\n");
diff --git a/include/linux/security.h b/include/linux/security.h
index 1a3404f9c060..d8db7ea4c4bf 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -114,6 +114,7 @@ enum lockdown_reason {
 	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_TIOCSSERIAL,
 	LOCKDOWN_MODULE_PARAMETERS,
+	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 0fa434294667..2eadbe0667e7 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -29,6 +29,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
 	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
+	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.23.0.rc1.153.gdeed80330f-goog

