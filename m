Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CCDC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6B9218FC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTANTI43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfDWWtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:49:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34151 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbfDWWtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:49:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id h5so13027069lfm.1;
        Tue, 23 Apr 2019 15:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W583DLuATb7569DJlQOwhhtkLZ1xhL86KTFMSp+wLl8=;
        b=XTANTI43m3AqXZ4watOgFQeVz3GWMCysvKAZ0BfLNAThnGYXFOUOqXPbpHlZ/b5mWF
         SxrGA7+nbNZj1x/pfWHhkJgxchG8jbokMXfnPvGcl5DWTPJ5TDsfnGehXJg2ibXkmGgX
         iVFNCL1BhDKT0FQNIMe3a23an6wwHEWm5qqpfs641NYNrpKZ5gSrtPSpqeQWjbk0T4lL
         DNNC596STlOWBaGvH6oOGVUAA5/xi1V0Be0f6biL51DarZiWJrqeUBhCnBQ23q+1gzS5
         pppQo9LWICIxLxGfV7ncQ25IdC8ybOv5uDt1CTojMOsHdl1pPxpDXbRMVdZlh6qZlNbp
         ERIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W583DLuATb7569DJlQOwhhtkLZ1xhL86KTFMSp+wLl8=;
        b=Kykzn8KtXue4xJm7VEhEBgqk2hHVC9UXmXZVd6AdwVaiZydYM5yMjfrwzQgjoheH0v
         zk17oTccMiUMV9fGS7uGM7VX4xNfXDaUoMGhF3a4J0Z60k6BKBNYjA+t1gRC+jnaufOM
         HaQmFzf7Kks53JG3yKEVhbLMiKuTd+5ufXikNM5MgwbRhtq6pUJ4JLA71oTTSvJkp7eH
         UzcdiSOqP6hebC4XKL9N4bnVzq6HrLLwqeVh40MlMN3mbQ1h6F7omhVM9zchKcgK6PNq
         y02Tp1kxONQF8rkUHUYF0BJEzDLWU9pJYQu6gbsnSMuzNuSRm5cXvymkBk+HDhDn/loo
         4gXQ==
X-Gm-Message-State: APjAAAV151/GmvpiorYEKDpFLv93ilPBY9SRGVkPeckedoUixCyHpbMv
        8MWMTcICWVUyRLC67ZokqVM=
X-Google-Smtp-Source: APXvYqwnO9pXPqQ9DzSRJfPbh+83mSvQndOn/tiKT0UkXAkjkZULPQWfg5M6vmofbJom3WJnp5GDBA==
X-Received: by 2002:ac2:51d9:: with SMTP id u25mr4013003lfm.91.1556059781008;
        Tue, 23 Apr 2019 15:49:41 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id w2sm4904722lfa.63.2019.04.23.15.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:49:40 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Juergen Gross <jgross@suse.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 12/12] mips: Enable OF_RESERVED_MEM config
Date:   Wed, 24 Apr 2019 01:47:48 +0300
Message-Id: <20190423224748.3765-13-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423224748.3765-1-fancer.lancer@gmail.com>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since memblock-patchset was introduced the reserved-memory nodes are
supported being declared in dt-files. So these nodes are actually parsed
during the arch setup procedure when the early_init_fdt_scan_reserved_mem()
method is called. But some of the features like private reserved memory
pools aren't available at the moment, since OF_RESERVED_MEM isn't enabled
for the MIPS platform. Lets fix it by enabling the config.

But due to the arch-specific boot mem_map container utilization we need
to manually call the fdt_init_reserved_mem() method after all the available
and reserved memory has been moved to memblock. The function call performed
before bootmem_init() fails due to the lack of any memblock memory regions
to allocate from at that stage.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/Kconfig        | 1 +
 arch/mips/kernel/setup.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4a5f5b0ee9a9..0bf9e89e4023 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2988,6 +2988,7 @@ config USE_OF
 	bool
 	select OF
 	select OF_EARLY_FLATTREE
+	select OF_RESERVED_MEM
 	select IRQ_DOMAIN
 
 config UHI_BOOT
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index fbd216b4e929..ab349d2381c3 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -27,6 +27,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/decompress/generic.h>
 #include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
@@ -825,6 +826,8 @@ static void __init arch_mem_init(char **cmdline_p)
 	memblock_reserve(__pa_symbol(&__nosave_begin),
 		__pa_symbol(&__nosave_end) - __pa_symbol(&__nosave_begin));
 
+	fdt_init_reserved_mem();
+
 	memblock_dump_all();
 
 	early_memtest(PFN_PHYS(min_low_pfn), PFN_PHYS(max_low_pfn));
-- 
2.21.0

