Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3547DC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126292075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfE1Lxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 07:53:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50285 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfE1Lxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:53:50 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hVafq-0003mE-N3; Tue, 28 May 2019 13:53:46 +0200
Date:   Tue, 28 May 2019 13:53:46 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <ynorov@marvell.com>,
        Andrew Morton <akpm@linux-foundation.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: LZ4 decompressor broken on ARM due to missing strchrnul() string
 traverse in cpumask_parse"
Message-ID: <20190528115346.f5a7kn3hdnuf5rts@linutronix.de>
References: <20190528110412.gg66fl67yahtwb6i@linutronix.de>
 <ffc779fe-3735-9665-8ee2-6a3ff1a7dd83@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ffc779fe-3735-9665-8ee2-6a3ff1a7dd83@rasmusvillemoes.dk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-28 13:33:12 [+0200], Rasmus Villemoes wrote:
> > How do we deal with this one?
> 
> Urgh. The problem is really in arch/arm/boot/compressed/decompress.c
> which does
> 
> #define _LINUX_STRING_H_
> 
> preventing linux/string.h from providing strchrnul. It also #includes
> asm/string.h, which for arm has a declaration of strchr(), explaining
> why this didn't use to fail.
> 
> However, the solution is also in the same file, it already has a section
> 
> /* Not needed, but used in some headers pulled in by decompressors */
> extern char * strstr(const char * s1, const char *s2);
> extern size_t strlen(const char *s);
> extern int memcmp(const void *cs, const void *ct, size_t count);
> 
> so just add another declaration to that list - I strongly assume we
> won't get a link failure since I find it hard to believe the
> decompressor would actually call cpumask_parse...

The hunk at the bottom of this mail compiles. Care to send to formal
patch?

> I'm wondering why this wasn't caught by 0day and/or while in -next?

must be related to lz4 usage in the configs tested :) A few set
XZ/LZO/LZMA. Majority falls back to GZIP.

> Rasmus

diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index c16c1829a5e4f..05814c2b382a3 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -32,6 +32,7 @@
 extern char * strstr(const char * s1, const char *s2);
 extern size_t strlen(const char *s);
 extern int memcmp(const void *cs, const void *ct, size_t count);
+extern char * strchrnul(const char *,int);
 
 #ifdef CONFIG_KERNEL_GZIP
 #include "../../../../lib/decompress_inflate.c"

Sebastian
