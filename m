Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF957C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FC020883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixEaPcnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfDIORx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:17:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42954 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIORv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:17:51 -0400
Received: by mail-qt1-f193.google.com with SMTP id p20so19892818qtc.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BOY7b3ixcZMLoSJtc9ZGmY0/2QOhLWSIjKgPHYduv0U=;
        b=ixEaPcnfz5KltXhpZSKjRRTGQ1NtZTgpx+ygpp64YavZ/wiPhXpRf2fokReSxiSy4D
         Mn0YOydKuzxtEz/4f5p6B3e/9d2jqNvmwx5Ij8v+SbFR2BRCOwAqEp98TWwMLpBx3IvH
         zz9D/fCoCiO3BxriIhiuqLE1SV9kRYb+QHahL8sS5LtVpj/uPoy1ArlvxqprmxpUu96b
         U1VhQi9wqYN/qa7J01S3Rx1B4xWluo72Wb0t9gim3Uay1BDFhZsGXKU2mshf1U2Mk9Kn
         ZMnG77QE494BT1iCo+zuQOW2rE5B/m/xqsUExZnNKgwlcPQX86OIVZJQQxAYkeQko5vs
         NB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BOY7b3ixcZMLoSJtc9ZGmY0/2QOhLWSIjKgPHYduv0U=;
        b=VMMRKGS2riiMKYlYqWDDZqG/+XQcFD7+P7WE060/DSv3/8JXWTsgyqvKH65kYHcddx
         KPBGIFp6IKAXReFR+DdIzS02X88/GkqIcHfflGMs5+A2gWqyEKDSxp3B1x6/OVXZdiJo
         8EPb27YhDsgz687BmVB/7KnzyCmWA+YxfUKbnnffxS/kzyiLPsnUDzwgNnCqGtlv4P67
         TAIk1pfJDz0lHYfRzMGQBw7Oc/s+bX14kV3gcbZXMR4d6HDHEy1Xu14+GARIxCgRLPFY
         W7OlrfXgI4CElphvSZ2ursG4IQkcnJILeu5pWSv2v0C7zNVVnWvq6/+b5POH9GaO+/Ro
         YPNQ==
X-Gm-Message-State: APjAAAU6xpVVaujebiEm6ypyFgna+60UFPWzLNhfe3i0H0Aj4wNzgWGX
        0zWsPCHEvIV4uFTmzdLbxP8oDts0uOU1GKXFQ9vEJaIV0A==
X-Google-Smtp-Source: APXvYqwDySmthzDo+evAvQlgOVN2S3vOzs90Z8wbjsbrbtffGYHxdy11VaZvA6SjTOVuiLvroKw4DaidBWoeYt85GvI=
X-Received: by 2002:a0c:b4a2:: with SMTP id c34mr29440939qve.209.1554819470510;
 Tue, 09 Apr 2019 07:17:50 -0700 (PDT)
MIME-Version: 1.0
From:   Jinyoung Park <gt.jypark@gmail.com>
Date:   Tue, 9 Apr 2019 23:17:14 +0900
Message-ID: <CAMfhKb-PNYrEqc6S=AJKRvfwUU61x4La6dM-1EsxoCa69et6eQ@mail.gmail.com>
Subject: [PATCH 1/1] arch: arm64: process: Unlock console after SMP stopped
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Ketan Patil <ketanp@nvidia.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the console lock is held by other CPU running while the system is
restarting or shutting down, the Kernel messages in the printk log buffer
can not be printed out to the console drivers. The Kernel messages can be
lost or messed up.
This change calls console_unlock after SMP stopped to flush the kernel
messages in the printk log buffer to the console drivers.

Signed-off-by: Jinyoung Park <jinyoungp@nvidia.com>
---
 arch/arm64/kernel/process.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 3767fb21a5b8..d629a75c7602 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -49,6 +49,7 @@
 #include <trace/events/power.h>
 #include <linux/percpu.h>
 #include <linux/thread_info.h>
+#include <linux/console.h>

 #include <asm/alternative.h>
 #include <asm/arch_gicv3.h>
@@ -164,6 +165,7 @@ void machine_halt(void)
 {
  local_irq_disable();
  smp_send_stop();
+ console_unlock();
  while (1);
 }

@@ -177,6 +179,7 @@ void machine_power_off(void)
 {
  local_irq_disable();
  smp_send_stop();
+ console_unlock();
  if (pm_power_off)
  pm_power_off();
 }
@@ -195,6 +198,7 @@ void machine_restart(char *cmd)
  /* Disable interrupts first */
  local_irq_disable();
  smp_send_stop();
+ console_unlock();

  /*
  * UpdateCapsule() depends on the system being reset via
-- 
2.19.0
