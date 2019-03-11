Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F307CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD542084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfCKOew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:34:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38121 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKOev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:34:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id z3so2805371qkf.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oK2+PdVKHrzl5KsU0CubhYYaSIsPJ2+otgMPFjFMvKk=;
        b=XeTCUFWpxf00EQMKJuBYoxMBYy/gipsV1C6Fea68qODzfVtJBnxhiCePZrDoddsZkN
         o3hL8YF83U51oMvsaUlf2dqDMH6tvXrpm4rN1PQsgWIfqBSSCITYR0ECVvPusFW74jrE
         gVqxb3WfAofCDeXlTQLBPXpc5zA45N2db2eOa/79AQOt5BzGnV5U9BMU3Q0pByVeO04d
         OSwOBPrq2TLIMYJMUsA819amDP3iOqedaW/e8wmYzQPjweKG36+o/OYB9giRIUzwkPyS
         lG0aAp8CbudPlct1cfqyHxhUiv/HPMFOAfhpueyF6G0U7HlN4tT867M12oVaB1DgD8TQ
         PRdA==
X-Gm-Message-State: APjAAAUNwTQh30svTrh5qjnMsiO5Ih4nyodNFw2eumEv+/fwtIkoP0oZ
        SzRVdqLzheCUci1NlP+cDrFflMCR719NzK+bLYQ=
X-Google-Smtp-Source: APXvYqxt0lOzLIocYujgxTCL1ITMZTLFzEnadagTOy7tc+d+JH1PvlOqw31xsgmu6814dwSkbHRaAX3c+XM73UHAOOk=
X-Received: by 2002:a05:620a:158c:: with SMTP id d12mr8047772qkk.173.1552314890231;
 Mon, 11 Mar 2019 07:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <20190307091514.2489338-2-arnd@arndb.de>
 <CAKwvOdk=9j2HvtWOpdOEw9sm0Nh2oU3c1c6+hJJ5WMweAM=4EQ@mail.gmail.com>
 <20190307234850.nsbpkfcit3lnmytu@shell.armlinux.org.uk> <CAKv+Gu9VM2Vs3Q8+bPLsnt08dOmba6j54gnhiHkk=AHRzG8tVA@mail.gmail.com>
 <20190308095308.hjjrzdp4fzbbtnnv@shell.armlinux.org.uk> <CAKv+Gu_szWgw-KJASLYGJ6hJXh5K8WxnUn+UQkm7jUup=rqG6w@mail.gmail.com>
 <20190308103429.ycasmpt6tcpsoqps@shell.armlinux.org.uk> <CAKv+Gu_9=G3U6Yaw8fLfTP3QT38WdwrFaC-BqLTCr2NihWA2ZA@mail.gmail.com>
 <20190308105835.tovswk5rwxusmxdu@shell.armlinux.org.uk> <CAKv+Gu-Od+hBosThTWFooz9FMKnu3g0oNh_2hmidetbB-_YyjQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu-Od+hBosThTWFooz9FMKnu3g0oNh_2hmidetbB-_YyjQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Mar 2019 15:34:31 +0100
Message-ID: <CAK8P3a1ECw_g1AqsVavD8hhVEGqNk6Kcx_U0L=0d29eu561NhA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: futex: make futex_detect_cmpxchg more reliable
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 12:56 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On Fri, 8 Mar 2019 at 11:58, Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:
> > On Fri, Mar 08, 2019 at 11:45:21AM +0100, Ard Biesheuvel wrote:

>
> Perhaps. So let me summarize what I do understand.
>
> 1) if futex_atomic_cmpxchg_inatomic() is instantiated *and executed*
> with the same compile time constant value of 0x0 for newval and uaddr,
> we end up with an opcode for the STRT instruction that is CONSTRAINED
> UNPREDICTABLE, but we will never execute it since the preceding load
> will fault and enter the fixup handler.
> 2) such occurrences of futex_atomic_cmpxchg_inatomic() are unlikely to
> occur in the code, but may be instantiated by the compiler when doing
> constant propagation (like in the ilog2() case I quoted), but these
> instantiations will never be called
> 3) both clang and gcc may map different inline asm input operands onto
> the same register if the value is guaranteed to be the same (i.e.,
> they are both compile time constants)
>
> My statement about uaddr was slightly misguided, in the sense that our
> invocation of STRT does use the post-index variant, but with an
> increment of zero, so the value written back to the register equals
> the original value. But it does explain why this opcode is CONSTRAINED
> UNPREDICTABLE in the first place.
>
> Given 2) above, I wonder if anyone could confirm whether adding
> 'BUG_ON(__builtin_constant_p(uaddr))' silences the warning as well.

Like this?

diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 0a46676b4245..e6e9b403cd61 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -57,6 +57,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
        /* Prefetching cannot fault */
        prefetchw(uaddr);
        __ua_flags = uaccess_save_and_enable();
+       BUG_ON(__builtin_constant_p(uaddr) || !uaddr);
        __asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
        "1:     ldrex   %1, [%4]\n"
        "       teq     %1, %2\n"

This had no effect here.

My first attempt (before finding the original patch from Mikael Pettersson)
was to change the probe to pass '1' as the value instead of '0', that
worked fine.

     Arnd
