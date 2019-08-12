Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E193C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E88C2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCcbdR00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfHLVws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:52:48 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:44555 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfHLVwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:52:45 -0400
Received: by mail-pg1-f202.google.com with SMTP id i134so28150615pgd.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 14:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G35OOE0sSfMuupCpgKQ0U4p9HFNylMt7P/lVbiGjqC0=;
        b=qCcbdR00iqgqZ/gG+jyOtF9Vncm844UkTWidc/xDIrreYwf0T8fY8OG5dIQRuiIxUe
         FzmJOT/4MTg94OWbw0D9mWByCs1880fYzbD8pk0R6AkDeFsG731eVhxBT+J45lFhFbwf
         mlOlBZtSLGRqW7vKpUirVuKzaLN7Rjm4AfAx434gpgHK8OnXp1izWDswYuMTZaX7/v+k
         E5rmfQINbPC0sfjRL04ILiNYMQYE/0nCRU4hiRjda6N7E6/6+GyHD0Ng7d2h3RK1UWj6
         dgszycG/x5ZESFf+qAorMsQgsHnfLzNx5F9k2KWcorwNp2pin4MzhBg34i9DY6K23R8/
         UIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G35OOE0sSfMuupCpgKQ0U4p9HFNylMt7P/lVbiGjqC0=;
        b=ZM2MNputIBFTu1usw4X2aT27ICmPIAzh9/U+KwWtkQ9H//4ECESaBYHWnVWuY2ShXk
         eMIprFI4aZEJTEvWujTYBw0RSYdj8bNMqev0NZiUR8dTTVM00u+qnuAagtNITWVN6S2a
         /kUxI7YCehWGfrWNJQAp1+a6YVFz7CHfhVIk7N/20xWnLUmRxeLrVlOxRYoD7sKZ/7eN
         blZvKclKa7P6lfFYPfJywAAcb4b6KIDD112bKVsj9nrdqAVlPSdluQdKA7AFfEQ+Du6m
         TPgfEx3l/jmQj2Cx4XrXSRuvpASbDGIrRsH18OyDpaMY3RpqxwbnGwA19l13j9EL6MYm
         85/A==
X-Gm-Message-State: APjAAAVBfKPrkpPjhrT0eXWSfcLiXF7gTX+H/1onl0XFQTJuI3vWY26h
        5SG/T2ToyVtI7h1yB4CG7Y8Dv8Swy98R00Xkjl4=
X-Google-Smtp-Source: APXvYqxLWMFYSVfr9/WeBe4JYuK0mMWVB3QFQmdMAe16b4tQpW2+ajfgokDvaDbjaNDG0XIPT7kh9+HxxjG7h46tDzs=
X-Received: by 2002:a65:6114:: with SMTP id z20mr32341554pgu.141.1565646764247;
 Mon, 12 Aug 2019 14:52:44 -0700 (PDT)
Date:   Mon, 12 Aug 2019 14:50:45 -0700
In-Reply-To: <20190812215052.71840-1-ndesaulniers@google.com>
Message-Id: <20190812215052.71840-12-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190812215052.71840-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 12/16] arm64: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     sedat.dilek@gmail.com, jpoimboe@redhat.com, yhs@fb.com,
        miguel.ojeda.sandonis@gmail.com,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm64/include/asm/cache.h     | 2 +-
 arch/arm64/kernel/smp_spin_table.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 64eeaa41e7ca..43da6dd29592 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -78,7 +78,7 @@ static inline u32 cache_type_cwg(void)
 	return (read_cpuid_cachetype() >> CTR_CWG_SHIFT) & CTR_CWG_MASK;
 }
 
-#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+#define __read_mostly __section(.data..read_mostly)
 
 static inline int cache_line_size_of_cpu(void)
 {
diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 76c2739ba8a4..c8a3fee00c11 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -19,7 +19,7 @@
 #include <asm/smp_plat.h>
 
 extern void secondary_holding_pen(void);
-volatile unsigned long __section(".mmuoff.data.read")
+volatile unsigned long __section(.mmuoff.data.read)
 secondary_holding_pen_release = INVALID_HWID;
 
 static phys_addr_t cpu_release_addr[NR_CPUS];
-- 
2.23.0.rc1.153.gdeed80330f-goog

