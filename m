Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA36C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC08C2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfG1XDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 19:03:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37545 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfG1XDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:03:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so34675875wrr.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 16:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHmOVMZ+hgbl6glGrYbyUU8RJ/uLOzhuRxz4ckuaKpY=;
        b=A8jUPsoILm/+J0RiKgmFuqt2ufSHjjfl3cXOLi9bpUly/RQA3ODGaLWWcI9LWZNpOE
         OOi7nF7RdPb/xqr1jZ6ieLL7uuTm0qw8vpvOSG62zJShghvbilulXFLlKNmRHVIiFdr3
         WyMR1A1k5OC8A43xMaNn/OFtJos7tH6l8qOo1R2MfWUSAKNQAVFsWiH2xfRJmiol51+8
         CcWxt21e30gjaI2izfokDjYlsI82VzsfQ/Hh76rwJQGMJiNnwGQizreKMb/4CPZomzKc
         Abtf0FjysDA8zih6YBwIuDgnC4NsQNJkx79B0IeHoF5JjtzLbgdQXS/YK+mOZ2qv4QpY
         GOYw==
X-Gm-Message-State: APjAAAWIEKCp5reiik2jCFkOFhloTyk3ad9MbFgGxeBdDu8n97G3+HON
        Rd85gTqc44rCx4hP6c+ln+Uv0Q==
X-Google-Smtp-Source: APXvYqxmxi7OfpyaSbmUwwwfjLMUedXKpYPEq+qCCzw11VozDSYV1iAQnIiLCMRLbrHIaznWEibpiQ==
X-Received: by 2002:a5d:4e08:: with SMTP id p8mr39699881wrt.20.1564354993194;
        Sun, 28 Jul 2019 16:03:13 -0700 (PDT)
Received: from mcroce-redhat.homenet.telecomitalia.it (host221-208-dynamic.27-79-r.retail.telecomitalia.it. [79.27.208.221])
        by smtp.gmail.com with ESMTPSA id v65sm66144369wme.31.2019.07.28.16.03.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 16:03:12 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: mark expected switch fall-through
Date:   Mon, 29 Jul 2019 01:03:10 +0200
Message-Id: <20190728230310.5924-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the "fallthrough" comment just because the case keyword,
fixes the following warning:

In file included from ./include/linux/kernel.h:15,
                 from ./include/linux/list.h:9,
                 from ./include/linux/kobject.h:19,
                 from ./include/linux/of.h:17,
                 from ./include/linux/irqdomain.h:35,
                 from ./include/linux/acpi.h:13,
                 from arch/arm64/kernel/smp.c:9:
arch/arm64/kernel/smp.c: In function ‘__cpu_up’:
./include/linux/printk.h:302:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/arm64/kernel/smp.c:156:4: note: in expansion of macro ‘pr_crit’
    pr_crit("CPU%u: may not have shut down cleanly\n", cpu);
    ^~~~~~~
arch/arm64/kernel/smp.c:157:3: note: here
   case CPU_STUCK_IN_KERNEL:
   ^~~~

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index ea90d3bd9253..018a33e01b0e 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -152,8 +152,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 				pr_crit("CPU%u: died during early boot\n", cpu);
 				break;
 			}
-			/* Fall through */
 			pr_crit("CPU%u: may not have shut down cleanly\n", cpu);
+			/* Fall through */
 		case CPU_STUCK_IN_KERNEL:
 			pr_crit("CPU%u: is stuck in kernel\n", cpu);
 			if (status & CPU_STUCK_REASON_52_BIT_VA)
-- 
2.21.0

