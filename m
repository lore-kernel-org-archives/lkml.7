Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85917C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 03:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6496320820
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 03:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfIEDzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 23:55:41 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58377 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbfIEDzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 23:55:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46P6Kk1PQwz9s3Z;
        Thu,  5 Sep 2019 13:55:38 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Bart Van Assche <bvanassche@acm.org>, Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep warning while booting POWER9 PowerNV
In-Reply-To: <9b8b287a-4ae1-ca9b-cff1-6d93672b6893@acm.org>
References: <1567199630.5576.39.camel@lca.pw> <9b8b287a-4ae1-ca9b-cff1-6d93672b6893@acm.org>
Date:   Thu, 05 Sep 2019 13:55:35 +1000
Message-ID: <87ef0vpfbc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Van Assche <bvanassche@acm.org> writes:
> On 8/30/19 2:13 PM, Qian Cai wrote:
>> https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
>> 
>> Once in a while, booting an IBM POWER9 PowerNV system (8335-GTH) would generate
>> a warning in lockdep_register_key() at,
>> 
>> if (WARN_ON_ONCE(static_obj(key)))
>> 
>> because
>> 
>> key = 0xc0000000019ad118
>> &_stext = 0xc000000000000000
>> &_end = 0xc0000000049d0000
>> 
>> i.e., it will cause static_obj() returns 1.
>
> (back from a trip)
>
> Hi Qian,
>
> Does this mean that on POWER9 it can happen that a dynamically allocated 
> object has an address that falls between &_stext and &_end?

I thought that was true on all arches due to initmem, but seems not.

I guess we have the same problem as s390 and we need to define
arch_is_kernel_initmem_freed().

Qian, can you try this:

diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index 4a1664a8658d..616b1b7b7e52 100644
--- a/arch/powerpc/include/asm/sections.h
+++ b/arch/powerpc/include/asm/sections.h
@@ -5,8 +5,22 @@
 
 #include <linux/elf.h>
 #include <linux/uaccess.h>
+
+#define arch_is_kernel_initmem_freed arch_is_kernel_initmem_freed
+
 #include <asm-generic/sections.h>
 
+extern bool init_mem_is_free;
+
+static inline int arch_is_kernel_initmem_freed(unsigned long addr)
+{
+	if (!init_mem_is_free)
+		return 0;
+
+	return addr >= (unsigned long)__init_begin &&
+		addr < (unsigned long)__init_end;
+}
+
 extern char __head_end[];
 
 #ifdef __powerpc64__


cheers
