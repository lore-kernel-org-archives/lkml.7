Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4140CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1350C20665
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fVAVkCOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389361AbfISMji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:39:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41494 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbfISMji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:39:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so2914814wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/9nzlO3catDpxNdlSs/iGbOfKBBKO21YP3lcrEeeoEQ=;
        b=fVAVkCOq71OXtZ7J4EkZQGbxKZNZc4L2c8WJZFECgaG3XjO3lNrIVHVYVh9IMMO4ZA
         AEMbIHHCpAmXbRHlDLww47nqyk/M6i4cvDy2bdZBbYNq1s5u4q00FU+zNh0S2Yp1nA4n
         SvkzakdSSmj8vYi6Ar6il9zvKCLbJwaDHnshr78mjr3P0x17Z3CufbcLB/mZSwXDj5EH
         /WplZOw3NE8LiOTVDf9UUFR/qqmcmWBsXas8QqUU6xk9S92tLgHQizN88RYDhuMS65aT
         U2bmsscollEChMPqNqFdZhT/EgQWz1m084k/kjn+s2p5SWl+QjVtuJHXpfpNQYdksxaA
         DOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/9nzlO3catDpxNdlSs/iGbOfKBBKO21YP3lcrEeeoEQ=;
        b=opSASUzijd7mcxYJT61GGbOWf2lZzd5lVtZhPh7msxGxilo+IYO3VFOeA/j0OVWD3e
         FLSZWN9lTfXzeADhE0MmMPAZgMLyhsSs35z+TSrajjyybFoSAhsoS0Eb28eEbmNFKVhg
         oTKVIlgJQqEw8LfUuqLU1pauNa2IMtBK3HYPcJ0w3OtJSw5h3aGmf/RhaqniwVmUSdL4
         La/5ArywqatNi1E2ksMrv5j8hUGBrph0A2dNgrcch31jzZY3OXHTMRrkp9GZtvdBK3WR
         w29n1/YDi8G80f0L+PWsBLWDrtyRkXK1Tv4QqPtGd2dCKuZV+2gG9WUbMWpWV193wvHk
         bLUg==
X-Gm-Message-State: APjAAAVh73XAmjpAAVs/89+GXDdSHT0T7LHC3J0HPSOtj4SK4Th3l5xH
        48Km3nZGrX8MZwh4jrTY9fFOsg==
X-Google-Smtp-Source: APXvYqyLGBWany8mv0R6G9JKWZdXIcvLmproKvbB56WPUT5EotusdST4NAJsi4Wf0JYw0isKvhYwOg==
X-Received: by 2002:adf:db06:: with SMTP id s6mr4131222wri.41.1568896775939;
        Thu, 19 Sep 2019 05:39:35 -0700 (PDT)
Received: from localhost ([109.190.253.11])
        by smtp.gmail.com with ESMTPSA id d193sm8966640wmd.0.2019.09.19.05.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 05:39:35 -0700 (PDT)
Date:   Thu, 19 Sep 2019 05:39:33 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <Anup.Patel@wdc.com>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Graf <graf@amazon.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 03/21] RISC-V: Export few kernel symbols
In-Reply-To: <20190904161245.111924-5-anup.patel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1909190537410.12151@viisi.sifive.com>
References: <20190904161245.111924-1-anup.patel@wdc.com> <20190904161245.111924-5-anup.patel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019, Anup Patel wrote:

> From: Atish Patra <atish.patra@wdc.com>
> 
> Export few symbols used by kvm module. Without this, kvm cannot
> be compiled as a module.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Alexander Graf <graf@amazon.com>

Thanks, have updated this patch to apply and to clarify the patch title 
and have queued the following for v5.4-rc.


- Paul

From: Atish Patra <atish.patra@wdc.com>
Date: Wed, 4 Sep 2019 16:14:06 +0000
Subject: [PATCH] RISC-V: Export kernel symbols for kvm

Export few symbols used by kvm module. Without this, kvm cannot
be compiled as a module.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Anup Patel <anup.patel@wdc.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alexander Graf <graf@amazon.com>
[paul.walmsley@sifive.com: updated to apply; clarified short patch 
 description]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/kernel/smp.c  | 1 +
 arch/riscv/kernel/time.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index d70e3c0ee983..f849a2480600 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -210,3 +210,4 @@ void smp_send_reschedule(int cpu)
 {
 	send_ipi_single(cpu, IPI_RESCHEDULE);
 }
+EXPORT_SYMBOL_GPL(smp_send_reschedule);
diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 517d2153a933..8a25d1e440ca 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -9,6 +9,7 @@
 #include <asm/processor.h>
 
 unsigned long riscv_timebase;
+EXPORT_SYMBOL_GPL(riscv_timebase);
 
 void __init time_init(void)
 {
-- 
2.23.0

