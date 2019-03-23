Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2205C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 08:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722A921900
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 08:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfCWI0o convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 04:26:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:57429 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfCWI0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 04:26:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44RDC462qgz9vCyN;
        Sat, 23 Mar 2019 09:26:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id VNlVHoa45lz0; Sat, 23 Mar 2019 09:26:40 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44RDC44wjLz9vCyM;
        Sat, 23 Mar 2019 09:26:40 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 5157B437; Sat, 23 Mar 2019 09:26:40 +0100 (CET)
Received: from arouen-653-1-146-8.w82-126.abo.wanadoo.fr
 (arouen-653-1-146-8.w82-126.abo.wanadoo.fr [82.126.129.8]) by
 messagerie.si.c-s.fr (Horde Framework) with HTTP; Sat, 23 Mar 2019 09:26:40
 +0100
Date:   Sat, 23 Mar 2019 09:26:40 +0100
Message-ID: <20190323092640.Horde.2lm4u26aZox5ialxuIRcYw2@messagerie.si.c-s.fr>
From:   LEROY Christophe <christophe.leroy@c-s.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Burton <paul.burton@mips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave@sr71.net>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
 <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
In-Reply-To: <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> a écrit :

> On Wed, Mar 20, 2019 at 10:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> I've added your patch to my randconfig test setup and will let you
>> know if I see anything noticeable. I'm currently testing clang-arm32,
>> clang-arm64 and gcc-x86.
>
> This is the only additional bug that has come up so far:
>
> `.exit.text' referenced in section `.alt.smp.init' of
> drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section
> `exit.text' of drivers/char/ipmi/ipmi_msghandler.o

Wouldn't it be useful to activate -Winline gcc warning to ease finding  
out problematic usage of inline keyword ?

Christophe

>
> diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
> index 201100226301..84b12e33104d 100644
> --- a/arch/arm/kernel/atags.h
> +++ b/arch/arm/kernel/atags.h
> @@ -5,7 +5,7 @@ void convert_to_tag_list(struct tag *tags);
>  const struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer,
>         unsigned int machine_nr);
>  #else
> -static inline const struct machine_desc *
> +static __always_inline const struct machine_desc *
>  setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
>  {
>         early_print("no ATAGS support: can't continue\n");


