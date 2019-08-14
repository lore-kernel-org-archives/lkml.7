Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA019C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFA520843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aprA4MX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfHNIYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:24:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36774 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbfHNIYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:24:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id w2so2325928pfi.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 01:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LKUTmfxWju3JH0UYdXaX0ZmxM1v34X/CQR0cjWXAdV0=;
        b=aprA4MX8fFP42+7Kfj2VmM2auYXDJcnW8YzO6vnSgXZD4MuPEx8PnT719qHFqIr/8n
         QmbZ0QuY/hdaPVLq5Qw9zGc+lgBmz54nZxOVLVk/a6ciHKcZKGRIPSumxAOoQa+lFXMg
         Z4uMvEByYuk/s/C8PNQittEjIb+K5+DyAfQ6cEBZ/zDoQd5MGztJ4aOzq10agMJA7UiN
         FDqQTgG0lMxnF4XDCJNHNKvx7sAok8gbO5bys2VzvMgT+AmDci9oOg+AHhe05JKeg2zn
         0209fn6vu9pR/FoCbx1lMxKN4l+zwrkJSq8FNq7tY10dmn+tm2v/q4XkIMFQCz5Jcn91
         Xm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LKUTmfxWju3JH0UYdXaX0ZmxM1v34X/CQR0cjWXAdV0=;
        b=fuCwZ3Hd58aI9G1k0Ie0zRfNMMVhPMUE83u6GBbZJKJM7x+cG8xDs5sB1WnmdScsQl
         OLwLZNkOn7DyrtFcWSwMBI+foD+3ek935cdmtl5yzf/R9B/9eDnYT6Eg5ywKEC23WNz3
         GUEV6pBBVAlyqXh4r6ayHBNphNkpLZJQJH8vHMVfXY9lBFhqpoBJz2/2UTF3x+O3J4nW
         eipdX0agvrpGnXU1ywUQDKQWNXN6XMTuMl6VYbA5uFmgQlCqk3JFIdM4r8lzsfsnA2ol
         wncekpVe03at5VjQZo7hP59wxvQ2jizz074N/Fea8ZsGTB+ZaPia5Z2AyhOOCf4M238v
         /vXQ==
X-Gm-Message-State: APjAAAWhyN/p78NvMZp+qOPIkNip9nI48xQtEjNfEMkh6/JedpkRu5V0
        XwqvV1z0F+7qTnk9QJ8eDPU4zg==
X-Google-Smtp-Source: APXvYqyF7XbbwdZczu0+BTGt6EYKJY4ia695LRy4XRq7P8Im2pJg5qZNWSLmNfYr09pro/ZO5lhd3A==
X-Received: by 2002:a17:90a:ad86:: with SMTP id s6mr4822761pjq.42.1565771040942;
        Wed, 14 Aug 2019 01:24:00 -0700 (PDT)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id f205sm12359152pfa.161.2019.08.14.01.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Aug 2019 01:24:00 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincent Chen <vincent.chen@sifive.com>,
        linux-stable <stable@vger.kernel.org>
Subject: [PATCH v2 2/2] riscv: Make __fstate_clean() work correctly.
Date:   Wed, 14 Aug 2019 16:23:53 +0800
Message-Id: <1565771033-1831-3-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565771033-1831-1-git-send-email-vincent.chen@sifive.com>
References: <1565771033-1831-1-git-send-email-vincent.chen@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the __fstate_clean() function correctly set the
state of sstatus.FS in pt_regs to SR_FS_CLEAN.

Fixes: 7db91e5 ("RISC-V: Task implementation")
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>

---
 arch/riscv/include/asm/switch_to.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 0575b8a..0aa5b94 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -16,7 +16,7 @@ extern void __fstate_restore(struct task_struct *restore_from);
 
 static inline void __fstate_clean(struct pt_regs *regs)
 {
-	regs->sstatus |= (regs->sstatus & ~(SR_FS)) | SR_FS_CLEAN;
+	regs->sstatus = (regs->sstatus & ~SR_FS) | SR_FS_CLEAN;
 }
 
 static inline void fstate_off(struct task_struct *task,
-- 
2.7.4

