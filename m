Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F2FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A049C23405
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 01:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbfHWBzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 21:55:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33655 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388350AbfHWBz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 21:55:29 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0ynW-0000hL-BE; Fri, 23 Aug 2019 03:55:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 004471C07E4;
        Fri, 23 Aug 2019 03:55:26 +0200 (CEST)
Date:   Fri, 23 Aug 2019 01:55:25 -0000
From:   tip-bot2 for Heiner Kallweit <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Improve definition of VECTOR_SHUTDOWN et al
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <146835e8-c086-4e85-7ece-bcba6795e6db@gmail.com>
References: <146835e8-c086-4e85-7ece-bcba6795e6db@gmail.com>
MIME-Version: 1.0
Message-ID: <156652532593.10819.2719583901865384301.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     e30c44e2e59c98023997632815cbc5e273991c25
Gitweb:        https://git.kernel.org/tip/e30c44e2e59c98023997632815cbc5e273991c25
Author:        Heiner Kallweit <hkallweit1@gmail.com>
AuthorDate:    Mon, 19 Aug 2019 21:34:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Aug 2019 23:19:06 +02:00

x86/irq: Improve definition of VECTOR_SHUTDOWN et al

These values are used with IS_ERR(), so it's more intuitive to define
them like a standard PTR_ERR() of a negative errno.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/146835e8-c086-4e85-7ece-bcba6795e6db@gmail.com

---
 arch/x86/include/asm/hw_irq.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index cbd97e2..4154bc5 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -153,8 +153,8 @@ extern char irq_entries_start[];
 extern char spurious_entries_start[];
 
 #define VECTOR_UNUSED		NULL
-#define VECTOR_SHUTDOWN		((void *)~0UL)
-#define VECTOR_RETRIGGERED	((void *)~1UL)
+#define VECTOR_SHUTDOWN		((void *)-1L)
+#define VECTOR_RETRIGGERED	((void *)-2L)
 
 typedef struct irq_desc* vector_irq_t[NR_VECTORS];
 DECLARE_PER_CPU(vector_irq_t, vector_irq);
