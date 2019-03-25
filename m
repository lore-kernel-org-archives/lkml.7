Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10F0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B119E20879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LKDtQH3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbfCYWKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:32 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:37319 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730971AbfCYWKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:30 -0400
Received: by mail-qk1-f201.google.com with SMTP id f196so9966186qke.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X6Y9rMN4d7Ni/+gDAGhZZery08YVnWjdvZABIqrFXus=;
        b=LKDtQH3sTINmIHbUCB0iCeSNdNVfCPCiR/gdwGOJ9VGHpyESnabxsI6T5JdopVkytc
         rta7c6THcAqSYuieUe6En0Sal75bQ8Pe1TjoXjuV7CgLtMFTNuOKo82zGN/IuTjyVUsH
         S+O505e/+xrAB6M8XuHPCZVm9U7g7w1Ti/ngyH8w5BrjZ2cBPtEAYdhJdz7SuvGQAT3O
         yxJWocXTenVNZpPLhpPCDpt6TuGkQbE6e0BGEWVEMw3OF2fPtwh60ajUqxkRnQW7OgEO
         NZbrtnfEmiaV0IcoLOvZoPfk2lXw/0cKkRIXVkBYXD4etYbRGCgWoL8Z52K0LC27xPch
         JUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X6Y9rMN4d7Ni/+gDAGhZZery08YVnWjdvZABIqrFXus=;
        b=HX+Oe5x3DTXvw3uM5473pR6IlMS5kAzmXrZGiIBwxng+/hznwm5zyerL/gP58Cip2G
         vWLq8V57KshYbduYCzs0P+A9an5zu3p0LVXlnQa8Ih75Cqi9hbs+UgJEBCWBk/Azh4nQ
         /gtLk8aI/mi6UtBeJaVjVVlrPImXGDeK+a1oiOekhkSUn/wLs8W4h3a/dabEZReRL64Q
         ar47RbxNuBBo/npbzacncciFb1vGTBjvntYDbBHLcUtsJS7KfvZlDPcTP9q3Syg92uMZ
         nuf54o26u9oprvQR5UmUUniCDprQoJ3TuXSM5vDaDQxAJvw2n4aFnAr3JLvyDkQTjMj9
         FksA==
X-Gm-Message-State: APjAAAXrgYMLsdDiRUof/DA4CARpYI2atUObaX55FBIHgatfF06D1ryt
        pcD0v9lznuuRbrD44sdGDP2dcJNFTQfGTe/wOQ6Rqw==
X-Google-Smtp-Source: APXvYqzdUtz5Gx36/UdEYYKDuhLU2x74e9CV9FTm/rJEs7XSKh22438Jm/2dKgLJLnTdtiHv8PVnyJ2VYXp4UDYxAlqcqw==
X-Received: by 2002:a0c:8a54:: with SMTP id 20mr22892221qvu.167.1553551829340;
 Mon, 25 Mar 2019 15:10:29 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:39 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-13-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 12/27] x86/msr: Restrict MSR access when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Matthew Garrett <matthewgarrett@google.com>
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
cc: x86@kernel.org
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
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
2.21.0.392.gf8f6787159e-goog

