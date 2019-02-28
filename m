Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9A7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352AE218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxgH7GKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387537AbfB1XMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:12:41 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:45046 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387827AbfB1XMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:12:38 -0500
Received: by mail-qt1-f201.google.com with SMTP id c9so19960201qte.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VhmO31ASaR5AbbhJWKJOBB028OwydePZqKoH4vU4z54=;
        b=VxgH7GKWv5U4pP/baW0EyNSMJWfYR8gz/BNo9nVnFnEbb7Wbl++IfRu+fPTJW+sC+t
         abIrkqtE/EIbIUcTRr00QmRoWKgu6q69FQ2LLvQPHXNRek+QGxuYUXxmcjQvTQ+NZnm/
         xyWgVAEFG4KKloh3LwEDipU9xFX9B/8XIFCDbJ9pQHU9bvru88IxfktsGmYgZxc8nE1k
         F6u5QdZr+olLTyOkzOs2Wpa26v6gRZ/WJRWB3zElt/pKkmJQs6kA3UsNRuJxcKJbeEpO
         +26QhH7uKevD/pI+FR64cPIcixbS0Q8nN5JMztze+qS2V1T3dkpySufI0b05e0UCmT87
         Khhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VhmO31ASaR5AbbhJWKJOBB028OwydePZqKoH4vU4z54=;
        b=fEl1vQxbM5RcCnUgbVSC8N1XQc+jTMPPnSQY0/w23eq07Z2T/8fOBubsSRU/evhKwE
         hDJNmSpDJ6MjWPGA/FQTIocsYD+opr7n6d68sATH5tWZLYqA7L3xisJmvTKN7G/RYwhm
         7QUdyjO55h9h4UvNt7Un74vaNqOEvm+HaRg3Noh0OWAHib7XhYuXVSp9g1MWvU9lIx6X
         aFBFHDxo328KEX07DOmn6DRl5JWp5Lj9VLYQmDVLQsXrB/hfeu0bKtSvUdDJo21Ks8L6
         9xYDbXy04dCFqIyunxXcsmpIph0QH6eSo7Ho+Sy6USjlrifqAhst4OzGWIDpYkA4ImmP
         HVbA==
X-Gm-Message-State: APjAAAXdio2c280iOVHzdcmD6ngCQAaTVnns/45OC+yop7um/mxtPMhI
        6PORUCjDdXt1KrhMTgoE8FJDyU4rDvKcqAtfvzRGAQ==
X-Google-Smtp-Source: APXvYqwE+a/HZDk/gA/G8rVtk8wnZBlVTQ2ZhFr0hyf1V4T3NaXl8KqqxOcmV3++fmWncM37Zw7w9b2jhx2y0c15fmxNkQ==
X-Received: by 2002:a0c:af6c:: with SMTP id j41mr1093756qvc.29.1551395557856;
 Thu, 28 Feb 2019 15:12:37 -0800 (PST)
Date:   Thu, 28 Feb 2019 15:11:49 -0800
In-Reply-To: <20190228231203.212359-1-matthewgarrett@google.com>
Message-Id: <20190228231203.212359-13-matthewgarrett@google.com>
Mime-Version: 1.0
References: <CACdnJuvW47m3JvEcuEX1bsr+L2Ht9LDn_iCuPbHLOoaohOFW4Q@mail.gmail.com>
 <20190228231203.212359-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH 13/27] x86/msr: Restrict MSR access when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

Writing to MSRs should not be allowed if the kernel is locked down, since
it could lead to execution of arbitrary code in kernel mode.  Based on a
patch by Kees Cook.

MSR accesses are logged for the purposes of building up a whitelist as per
Alan Cox's suggestion.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
cc: x86@kernel.org
---
 arch/x86/kernel/msr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 4588414e2561..f5a2cf07972f 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -84,6 +84,11 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 	int err = 0;
 	ssize_t bytes = 0;
 
+	if (kernel_is_locked_down("Direct MSR access")) {
+		pr_info("Direct access to MSR %x\n", reg);
+		return -EPERM;
+	}
+
 	if (count % 8)
 		return -EINVAL;	/* Invalid chunk size */
 
@@ -135,6 +140,11 @@ static long msr_ioctl(struct file *file, unsigned int ioc, unsigned long arg)
 			err = -EFAULT;
 			break;
 		}
+		if (kernel_is_locked_down("Direct MSR access")) {
+			pr_info("Direct access to MSR %x\n", regs[1]); /* Display %ecx */
+			err = -EPERM;
+			break;
+		}
 		err = wrmsr_safe_regs_on_cpu(cpu, regs);
 		if (err)
 			break;
-- 
2.21.0.352.gf09ad66450-goog

