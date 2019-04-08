Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1218AC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EBC21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqffKZL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfDHNgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:36:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39107 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDHNgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:36:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so14750779wmk.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 06:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=Qk2fMRtYmpCq5rJZR/nxALRtNbM0JfGQc9cEPfreLgk=;
        b=RqffKZL4Lh3Fdyul4KC7h/d4hGdjvVaHs6MrLgmTVYX+VFq6CyHdir1trp8pPuQArM
         7ssPOdtAKRzVTc+Dx8DbuR12jE7jQ0RHMIl3wIu/MMP2kT37TtWtwvj6GwzQF70Qmvcs
         z8AcjFjm3lQmyVg5F7R6cZGNfjH4gumFL0TjlDmIWZakswM5tXx+c3CVVAv+SiXR2Ovq
         g2plZhnI8bm+Scby7s1iWD6nNTqiCCPVLLoqrCkLwa8x2dEiMREck8hygiT7zwgjDzPq
         FydueSGESkSBl9+ZHcB0qsC2YqtS+IvsbRQ+bJ8rnAAR9w5cE58aoDXL2Dv1t709WM1U
         kong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Qk2fMRtYmpCq5rJZR/nxALRtNbM0JfGQc9cEPfreLgk=;
        b=tZPg0w5e2Ym/9LNLHxUHNMdRPxaIdUZxfkQd/wrtC3Zh+nL3aBtnlpW8U1o4Uw+ZpE
         VnAc1tgyKjM3u/abBN0dba6qU2RbpXzLUu8jFTgnTAno/5oR0fpFnjetBV3fkoUFVy/M
         LffuWSzzc/+LgSbYLg8jx5go5ycA7LiGMgv4t/rYaRZpcxs3plKT91HewsJnwi83OQqw
         Y0YZbmFNpV9iyhnaLOlXu6HgSPCTnfVFJkASMBnNvcJ96JN/WPaTnkkBegm0hREsGKOB
         JcpFBipbUVf4LXSpgjptBYdL9UQprkQoFlAOqPzTlfRvwoP4VzFpHjp03foAs+L8riO/
         78Tg==
X-Gm-Message-State: APjAAAWb9fuvel87TWacVoZS0WNGtCt7Yjq706D/KJafzGHvTBhTyHdj
        X+UsAaumVOavPCAD8QmrNSP/zVaY6iALI+DPlMQ=
X-Google-Smtp-Source: APXvYqwKdkYETm+n7suxlY+QKu276FytyQ0CchNskKM9uiNtyEJTq7fC+u4LWu2a2NdYWCz8CVVHaGM+3U8hH4duaxs=
X-Received: by 2002:a1c:7611:: with SMTP id r17mr17379544wmc.98.1554730593078;
 Mon, 08 Apr 2019 06:36:33 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Apr 2019 15:36:22 +0200
Message-ID: <CA+icZUVW2X6G=qukJTrZuUevcnrOiuShJGxnxVaqyONNxv+RYg@mail.gmail.com>
Subject: CBL issue #431: lld: x86_64: sysfs: cannot create duplicate filename $module/.rodata.cst{16,32}
To:     Denys Vlasenko <dvlasenk@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denys,

I fell over your commit "crypto: x86 - make constants readonly, allow
linker to merge them" [1] while digging into ClangBuiltLinux issue 431
[0].

I see the following in my dmesg-log:

$ grep sysfs: dmesg_5.0.4-rc1-1-amd64-cbl-asmgoto.txt
[Fri Mar 22 10:32:09 2019] sysfs: cannot create duplicate filename
'/module/usbcore/sections/.rodata.cst16'
[Fri Mar 22 10:32:18 2019] sysfs: cannot create duplicate filename
'/module/nfsd/sections/.rodata.cst32'
[Fri Mar 22 10:32:18 2019] sysfs: cannot create duplicate filename
'/module/iwlwifi/sections/.rodata.cst16'
[Fri Mar 22 10:32:18 2019] sysfs: cannot create duplicate filename
'/module/i915/sections/.rodata.cst32'
[Fri Mar 22 10:32:18 2019] sysfs: cannot create duplicate filename
'/module/mac80211/sections/.rodata.cst32'
[Fri Mar 22 10:32:18 2019] sysfs: cannot create duplicate filename
'/module/iwlmvm/sections/.rodata.cst16'
[Fri Mar 22 10:32:20 2019] sysfs: cannot create duplicate filename
'/module/bluetooth/sections/.rodata.cst16'

Above modules have dependencies to stuff from arch/x86/crypto (see below P.S.).

Looks like LLD defaults to -ffunction-sections and -fdata-sections.
Do you happen to know what the defaults are for BFD linker?

LLD maintainers suggest me to put -fdata-sections.
But where?

I tried to put it into arch/86/Makefile:

KBUILD_CFLAGS_MODULE += -fdata-sections

No success.
Not sure if I need also to activate -ffunction-sections in this line.

Unsure if this is too aggressive...

diff --git a/Makefile b/Makefile
index ac29cd533d55..08bd1946e182 100644
--- a/Makefile
+++ b/Makefile
@@ -815,6 +815,8 @@ ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
 KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
 LDFLAGS_vmlinux += --gc-sections
 endif
+KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
+KBUILD_CFLAGS_MODULE += -ffunction-sections -fdata-sections

 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)

...and what about the correlation with this setting init/Makefile...

ccflags-y := -fno-function-sections -fno-data-sections

More details see [0].

Maybe you have an idea?
If you need further informations, please let me know.

Thanks in advance.

Regards,
- Sedat -

[0] https://github.com/ClangBuiltLinux/linux/issues/431
[1] https://git.kernel.org/linus/e183914af00e15eb41ae666d44e323bfa154be13

P.S.: arch/x86/crypto dependencies

$ git grep -E 'rodata.cst16|rodata.cst32' | grep arch/x86
arch/x86/crypto/aegis128-aesni-asm.S:.section
.rodata.cst16.aegis128_const, "aM", @progbits, 32
arch/x86/crypto/aegis128-aesni-asm.S:.section
.rodata.cst16.aegis128_counter, "aM", @progbits, 16
arch/x86/crypto/aegis128l-aesni-asm.S:.section
.rodata.cst16.aegis128l_const, "aM", @progbits, 32
arch/x86/crypto/aegis128l-aesni-asm.S:.section
.rodata.cst16.aegis128l_counter, "aM", @progbits, 16
arch/x86/crypto/aegis256-aesni-asm.S:.section
.rodata.cst16.aegis256_const, "aM", @progbits, 32
arch/x86/crypto/aegis256-aesni-asm.S:.section
.rodata.cst16.aegis256_counter, "aM", @progbits, 16
arch/x86/crypto/aesni-intel_asm.S:.section
.rodata.cst16.gf128mul_x_ble_mask, "aM", @progbits, 16
arch/x86/crypto/aesni-intel_asm.S:.section      .rodata.cst16.POLY,
"aM", @progbits, 16
arch/x86/crypto/aesni-intel_asm.S:.section      .rodata.cst16.TWOONE,
"aM", @progbits, 16
arch/x86/crypto/aesni-intel_asm.S:.section
.rodata.cst16.SHUF_MASK, "aM", @progbits, 16
arch/x86/crypto/aesni-intel_asm.S:.section      .rodata.cst16.MASK1,
"aM", @progbits, 16
arch/x86/crypto/aesni-intel_asm.S:.section      .rodata.cst16.MASK2,
"aM", @progbits, 16
arch/x86/crypto/aesni-intel_asm.S:.section      .rodata.cst16.ONE,
"aM", @progbits, 16
arch/x86/crypto/aesni-intel_asm.S:.section
.rodata.cst16.F_MIN_MASK, "aM", @progbits, 16
arch/x86/crypto/aesni-intel_asm.S:.section      .rodata.cst16.dec,
"aM", @progbits, 16
arch/x86/crypto/aesni-intel_asm.S:.section      .rodata.cst16.enc,
"aM", @progbits, 16
arch/x86/crypto/aesni-intel_avx-x86_64.S:.section
.rodata.cst16.POLY, "aM", @progbits, 16
arch/x86/crypto/aesni-intel_avx-x86_64.S:.section
.rodata.cst16.POLY2, "aM", @progbits, 16
arch/x86/crypto/aesni-intel_avx-x86_64.S:.section
.rodata.cst16.TWOONE, "aM", @progbits, 16
arch/x86/crypto/aesni-intel_avx-x86_64.S:.section
.rodata.cst16.SHUF_MASK, "aM", @progbits, 16
arch/x86/crypto/aesni-intel_avx-x86_64.S:.section
.rodata.cst16.ONE, "aM", @progbits, 16
arch/x86/crypto/aesni-intel_avx-x86_64.S:.section
.rodata.cst16.ONEf, "aM", @progbits, 16
arch/x86/crypto/camellia-aesni-avx-asm_64.S:.section    .rodata.cst16,
"aM", @progbits, 16
arch/x86/crypto/camellia-aesni-avx2-asm_64.S:.section
.rodata.cst32.shufb_16x16b, "aM", @progbits, 32
arch/x86/crypto/camellia-aesni-avx2-asm_64.S:.section
.rodata.cst32.pack_bswap, "aM", @progbits, 32
arch/x86/crypto/camellia-aesni-avx2-asm_64.S:.section   .rodata.cst16,
"aM", @progbits, 16
arch/x86/crypto/cast5-avx-x86_64-asm_64.S:.section
.rodata.cst16.bswap_mask, "aM", @progbits, 16
arch/x86/crypto/cast5-avx-x86_64-asm_64.S:.section
.rodata.cst16.bswap128_mask, "aM", @progbits, 16
arch/x86/crypto/cast5-avx-x86_64-asm_64.S:.section
.rodata.cst16.bswap_iv_mask, "aM", @progbits, 16
arch/x86/crypto/cast6-avx-x86_64-asm_64.S:.section      .rodata.cst16,
"aM", @progbits, 16
arch/x86/crypto/chacha-avx2-x86_64.S:.section   .rodata.cst32.ROT8,
"aM", @progbits, 32
arch/x86/crypto/chacha-avx2-x86_64.S:.section   .rodata.cst32.ROT16,
"aM", @progbits, 32
arch/x86/crypto/chacha-avx2-x86_64.S:.section   .rodata.cst32.CTRINC,
"aM", @progbits, 32
arch/x86/crypto/chacha-avx2-x86_64.S:.section   .rodata.cst32.CTR2BL,
"aM", @progbits, 32
arch/x86/crypto/chacha-avx2-x86_64.S:.section   .rodata.cst32.CTR4BL,
"aM", @progbits, 32
arch/x86/crypto/chacha-avx512vl-x86_64.S:.section
.rodata.cst32.CTR2BL, "aM", @progbits, 32
arch/x86/crypto/chacha-avx512vl-x86_64.S:.section
.rodata.cst32.CTR4BL, "aM", @progbits, 32
arch/x86/crypto/chacha-avx512vl-x86_64.S:.section
.rodata.cst32.CTR8BL, "aM", @progbits, 32
arch/x86/crypto/chacha-ssse3-x86_64.S:.section  .rodata.cst16.ROT8,
"aM", @progbits, 16
arch/x86/crypto/chacha-ssse3-x86_64.S:.section  .rodata.cst16.ROT16,
"aM", @progbits, 16
arch/x86/crypto/chacha-ssse3-x86_64.S:.section  .rodata.cst16.CTRINC,
"aM", @progbits, 16
arch/x86/crypto/crct10dif-pcl-asm_64.S:.section .rodata.cst16.mask1,
"aM", @progbits, 16
arch/x86/crypto/crct10dif-pcl-asm_64.S:.section .rodata.cst16.mask2,
"aM", @progbits, 16
arch/x86/crypto/crct10dif-pcl-asm_64.S:.section
.rodata.cst16.SHUF_MASK, "aM", @progbits, 16
arch/x86/crypto/crct10dif-pcl-asm_64.S:.section
.rodata.cst32.pshufb_shf_table, "aM", @progbits, 32
arch/x86/crypto/ghash-clmulni-intel_asm.S:.section
.rodata.cst16.bswap_mask, "aM", @progbits, 16
arch/x86/crypto/morus1280-avx2-asm.S:.section
.rodata.cst32.morus1280_const, "aM", @progbits, 32
arch/x86/crypto/morus1280-avx2-asm.S:.section
.rodata.cst32.morus1280_counter, "aM", @progbits, 32
arch/x86/crypto/morus1280-sse2-asm.S:.section
.rodata.cst16.morus640_const, "aM", @progbits, 16
arch/x86/crypto/morus1280-sse2-asm.S:.section
.rodata.cst16.morus640_counter, "aM", @progbits, 16
arch/x86/crypto/morus640-sse2-asm.S:.section
.rodata.cst16.morus640_const, "aM", @progbits, 32
arch/x86/crypto/morus640-sse2-asm.S:.section
.rodata.cst16.morus640_counter, "aM", @progbits, 16
arch/x86/crypto/poly1305-avx2-x86_64.S:.section .rodata.cst32.ANMASK,
"aM", @progbits, 32
arch/x86/crypto/poly1305-avx2-x86_64.S:.section .rodata.cst32.ORMASK,
"aM", @progbits, 32
arch/x86/crypto/poly1305-sse2-x86_64.S:.section .rodata.cst16.ANMASK,
"aM", @progbits, 16
arch/x86/crypto/poly1305-sse2-x86_64.S:.section .rodata.cst16.ORMASK,
"aM", @progbits, 16
arch/x86/crypto/serpent-avx-x86_64-asm_64.S:.section
.rodata.cst16.bswap128_mask, "aM", @progbits, 16
arch/x86/crypto/serpent-avx-x86_64-asm_64.S:.section
.rodata.cst16.xts_gf128mul_and_shl1_mask, "aM", @progbits, 16
arch/x86/crypto/serpent-avx2-asm_64.S:.section
.rodata.cst16.bswap128_mask, "aM", @progbits, 16
arch/x86/crypto/serpent-avx2-asm_64.S:.section
.rodata.cst16.xts_gf128mul_and_shl1_mask_0, "aM", @progbits, 16
arch/x86/crypto/serpent-avx2-asm_64.S:.section
.rodata.cst16.xts_gf128mul_and_shl1_mask_1, "aM", @progbits, 16
arch/x86/crypto/sha1_ni_asm.S:.section
.rodata.cst16.PSHUFFLE_BYTE_FLIP_MASK, "aM", @progbits, 16
arch/x86/crypto/sha1_ni_asm.S:.section  .rodata.cst16.UPPER_WORD_MASK,
"aM", @progbits, 16
arch/x86/crypto/sha256-avx-asm.S:.section
.rodata.cst16.PSHUFFLE_BYTE_FLIP_MASK, "aM", @progbits, 16
arch/x86/crypto/sha256-avx-asm.S:.section
.rodata.cst16._SHUF_00BA, "aM", @progbits, 16
arch/x86/crypto/sha256-avx-asm.S:.section
.rodata.cst16._SHUF_DC00, "aM", @progbits, 16
arch/x86/crypto/sha256-avx2-asm.S:.section
.rodata.cst32.PSHUFFLE_BYTE_FLIP_MASK, "aM", @progbits, 32
arch/x86/crypto/sha256-avx2-asm.S:.section
.rodata.cst32._SHUF_00BA, "aM", @progbits, 32
arch/x86/crypto/sha256-avx2-asm.S:.section
.rodata.cst32._SHUF_DC00, "aM", @progbits, 32
arch/x86/crypto/sha256-ssse3-asm.S:.section
.rodata.cst16.PSHUFFLE_BYTE_FLIP_MASK, "aM", @progbits, 16
arch/x86/crypto/sha256-ssse3-asm.S:.section
.rodata.cst16._SHUF_00BA, "aM", @progbits, 16
arch/x86/crypto/sha256-ssse3-asm.S:.section
.rodata.cst16._SHUF_DC00, "aM", @progbits, 16
arch/x86/crypto/sha256_ni_asm.S:.section
.rodata.cst16.PSHUFFLE_BYTE_FLIP_MASK, "aM", @progbits, 16
arch/x86/crypto/sha512-avx-asm.S:.section
.rodata.cst16.XMM_QWORD_BSWAP, "aM", @progbits, 16
arch/x86/crypto/sha512-avx2-asm.S:.section
.rodata.cst32.PSHUFFLE_BYTE_FLIP_MASK, "aM", @progbits, 32
arch/x86/crypto/sha512-avx2-asm.S:.section
.rodata.cst32.MASK_YMM_LO, "aM", @progbits, 32
arch/x86/crypto/sha512-ssse3-asm.S:.section
.rodata.cst16.XMM_QWORD_BSWAP, "aM", @progbits, 16
arch/x86/crypto/twofish-avx-x86_64-asm_64.S:.section
.rodata.cst16.bswap128_mask, "aM", @progbits, 16
arch/x86/crypto/twofish-avx-x86_64-asm_64.S:.section
.rodata.cst16.xts_gf128mul_and_shl1_mask, "aM", @progbits, 16
- EOT -
