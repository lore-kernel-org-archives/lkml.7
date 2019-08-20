Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4F3C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4CD22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mhh4cPNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfHTATF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:19:05 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:35708 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbfHTATA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:19:00 -0400
Received: by mail-vk1-f201.google.com with SMTP id y187so2388076vkf.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WRMzqxGXLNI0SsBdZY8cEvaiXgaE0VA439c0Hio6O3c=;
        b=Mhh4cPNkmy8sQQ8Xxa6AAQ9jY+vx5NznNoSQsXjJgvPnFoVdCPwv1xnIxLGy8wXOGa
         Y+QauLaf0LDbBMzar7QnmBa5VhZCshx710U0wHANb09ggoNAPyH9zceRsKiRbEGz0qlu
         QvTXKIWp1YhLEhIVJ+uBGGcUZsogr6LaPafLxs4ZMANGUX6XfXwcbGuGD0umHIP0TbIE
         ykMq+1ZXLAn6HbdHiF4uA4bH4kYP3p2OcaBjMtd6lwrj/dSTbS6ccppsiSHGxtEyegpB
         aDdOBJexX3QW8dhwf9EjxMlcSOXlKXlVj4ox4W2c39ULGab0VcK2dYwnTYmdPBPhuzBs
         xM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WRMzqxGXLNI0SsBdZY8cEvaiXgaE0VA439c0Hio6O3c=;
        b=EtJBtYs64R/+wZaRqs7nsnXXxVQAbJcywqd8M/NzhDeX6Nl5Eo7qU4U1CXFKadgrvH
         7eqzP9KPSmymJicYZHE/VRD++jde5J72b/rqaatXuIgH+eHAzdq0fMooRhwxyqo7MQEh
         XdJ8cqMA9Rztb6PipG2/HkQ1bVphVqvEvbhY4RJ9metl2fGQHhCVWNZXMTj7/FNIwtjy
         2UVBeLcwnnCM4Z/zc1qXa7iSVpB66hmOWtpSt40wTFek7l7dNuHMhNtr0qRh9DoMjTOO
         MdHZj2fj0CPS1obT/vEAJD1ctPCAa0Lf2JbBXHSQyqQCtQCoyLNFXztUaIfrrj33ZdfV
         KbmQ==
X-Gm-Message-State: APjAAAXt5roDDmBTXz+STuGP/xoUk9ffLhEdAOCPrV5OhNEgl8Tf/Ofx
        HRqwXpI6CfrU3GRQAwLWZGDP3TsWW5w3ctX56WU+JA==
X-Google-Smtp-Source: APXvYqyV4Kgwvl5pQht/U4WWNO2ngHwajMUTquOJOpL/jf7OovZEbp24SlhZhz06vIk33GR7iA5I4Do0Ql2vGMvUJiqKbA==
X-Received: by 2002:a1f:1654:: with SMTP id 81mr9237922vkw.49.1566260339513;
 Mon, 19 Aug 2019 17:18:59 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:55 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-20-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 19/29] lockdown: Lock down module params that specify
 hardware parameters (eg. ioport)
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Provided an annotation for module parameters that specify hardware
parameters (such as io ports, iomem addresses, irqs, dma channels, fixed
dma buffers and other types).

Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Jessica Yu <jeyu@kernel.org>
Signed-off-by: James Morris <jmorris@namei.org>
---
 include/linux/security.h     |  1 +
 kernel/params.c              | 21 ++++++++++++++++-----
 security/lockdown/lockdown.c |  1 +
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index b4a85badb03a..1a3404f9c060 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -113,6 +113,7 @@ enum lockdown_reason {
 	LOCKDOWN_ACPI_TABLES,
 	LOCKDOWN_PCMCIA_CIS,
 	LOCKDOWN_TIOCSSERIAL,
+	LOCKDOWN_MODULE_PARAMETERS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
diff --git a/kernel/params.c b/kernel/params.c
index cf448785d058..8e56f8b12d8f 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
+#include <linux/security.h>
 
 #ifdef CONFIG_SYSFS
 /* Protects all built-in parameters, modules use their own param_lock */
@@ -96,13 +97,19 @@ bool parameq(const char *a, const char *b)
 	return parameqn(a, b, strlen(a)+1);
 }
 
-static void param_check_unsafe(const struct kernel_param *kp)
+static bool param_check_unsafe(const struct kernel_param *kp)
 {
+	if (kp->flags & KERNEL_PARAM_FL_HWPARAM &&
+	    security_locked_down(LOCKDOWN_MODULE_PARAMETERS))
+		return false;
+
 	if (kp->flags & KERNEL_PARAM_FL_UNSAFE) {
 		pr_notice("Setting dangerous option %s - tainting kernel\n",
 			  kp->name);
 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
 	}
+
+	return true;
 }
 
 static int parse_one(char *param,
@@ -132,8 +139,10 @@ static int parse_one(char *param,
 			pr_debug("handling %s with %p\n", param,
 				params[i].ops->set);
 			kernel_param_lock(params[i].mod);
-			param_check_unsafe(&params[i]);
-			err = params[i].ops->set(val, &params[i]);
+			if (param_check_unsafe(&params[i]))
+				err = params[i].ops->set(val, &params[i]);
+			else
+				err = -EPERM;
 			kernel_param_unlock(params[i].mod);
 			return err;
 		}
@@ -553,8 +562,10 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
 		return -EPERM;
 
 	kernel_param_lock(mk->mod);
-	param_check_unsafe(attribute->param);
-	err = attribute->param->ops->set(buf, attribute->param);
+	if (param_check_unsafe(attribute->param))
+		err = attribute->param->ops->set(buf, attribute->param);
+	else
+		err = -EPERM;
 	kernel_param_unlock(mk->mod);
 	if (!err)
 		return len;
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 771c77f9c04a..0fa434294667 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -28,6 +28,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
 	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
+	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
-- 
2.23.0.rc1.153.gdeed80330f-goog

