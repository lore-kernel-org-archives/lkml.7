Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE52C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F73C2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="ONC6lkQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfKYMuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:50:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36723 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKYMuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:50:03 -0500
Received: by mail-pl1-f194.google.com with SMTP id d7so6483215pls.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 04:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=4Dyj3TFAf2a0awBxIC0/58dYWGnIo6wfhRywN+QDFMQ=;
        b=ONC6lkQj3zxvkiT8BAl0ZtYPE2RQWpupKsSqjfd0JT/qhrTqFTrCvq3oko/FbJYxRg
         KHy20N2dQM5C8Pm1VfafoBnw0NqjuX7y6rbporwQnSWUHrA0UE31Md3/CpAzhsyHT6km
         qkcqXt0L5/7o7kfyM84gWC5LPmIjVBtl1xM4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4Dyj3TFAf2a0awBxIC0/58dYWGnIo6wfhRywN+QDFMQ=;
        b=gD5zbnFRrf8mtE+Vx388k9hzOUOmkKSiRWC6r0ir399Yux4iCd61cWyUpDGmcgsCIi
         /JTwXuSorwcegxJZw453VT7R3H14E04r5xaiMVnPhynfyNscg+P2h6+SCSmTbh7AHdyZ
         lQ1a7jvQgu2u9PJbpg0AVRJQ3NggRapt7w3enGZheIOro4DDqhwnKef4yEADPuCm/9FZ
         wVcnOOjBEGKW14AKT8IYjYsBhqeVG6qfEl82VBV0BxcTxkdhbFNdFsq4BqEbIDertjEY
         KlJyIL21+tc1uxqYwHHXXHQL23O9L47xEzIgsM5Q7ljlJ3fprdYRTpECkiN8AWG60c4y
         XMRQ==
X-Gm-Message-State: APjAAAVh7QCaXvMrj9xLqES6W2dzGW7x8IQPS68YxG+tpp6BPafWOu7j
        Y49zPVqO6vB1m9eSj6mtwUeYKg==
X-Google-Smtp-Source: APXvYqx+hG30RzYfSJHZPM5tJ9YTXat/yYcK7hJJWoGFjjL2MnTwx3SjA/GCJdbj/Z0fnE/MlFImcw==
X-Received: by 2002:a17:90a:c385:: with SMTP id h5mr39051342pjt.95.1574686203240;
        Mon, 25 Nov 2019 04:50:03 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-f00e-a399-4df8-3035.static.ipv6.internode.on.net. [2001:44b8:1113:6700:f00e:a399:4df8:3035])
        by smtp.gmail.com with ESMTPSA id q41sm8433576pja.20.2019.11.25.04.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 04:50:02 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Michael Ellerman <michael@ellerman.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bart Van Assche <bvanassche@acm.org>, Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep warning while booting POWER9 PowerNV
In-Reply-To: <EA225D34-2394-4C77-B989-38C275818590@ellerman.id.au>
References: <1567199630.5576.39.camel@lca.pw> <9b8b287a-4ae1-ca9b-cff1-6d93672b6893@acm.org> <87ef0vpfbc.fsf@mpe.ellerman.id.au> <87v9r8g3oe.fsf@dja-thinkpad.axtens.net> <EA225D34-2394-4C77-B989-38C275818590@ellerman.id.au>
Date:   Mon, 25 Nov 2019 23:49:57 +1100
Message-ID: <87lfs4f7d6.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc: define arch_is_kernel_initmem_freed() for lockdep

Under certain circumstances, we hit a warning in lockdep_register_key:

        if (WARN_ON_ONCE(static_obj(key)))
                return;

This occurs when the key falls into initmem that has since been freed
and can now be reused. This has been observed on boot, and under memory
pressure.

Define arch_is_kernel_initmem_freed(), which allows lockdep to correctly
identify this memory as dynamic.

This fixes a bug picked up by the powerpc64 syzkaller instance where we
hit the WARN via alloc_netdev_mqs.

Link: https://github.com/linuxppc/issues/issues/284
Link: https://lore.kernel.org/linuxppc-dev/87ef0vpfbc.fsf@mpe.ellerman.id.au/
Reported-by: Qian Cai <cai@lca.pw>
Reported-by: ppc syzbot c/o Andrew Donnellan <ajd@linux.ibm.com>
Commit-message-by: Daniel Axtens <dja@axtens.net>
<mpe signoff here>

---

The ppc64 syzkaller link is probably not stable enough to go into
the git history forever, but fwiw:
https://syzkaller-ppc64.appspot.com/bug?id=cfdf75cd985012d0124cd41e6fa095d33e7d0f6b

---
 arch/powerpc/include/asm/sections.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
index 5a9b6eb651b6..d19871763ed4 100644
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

