Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EFEC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9A7206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 23:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568763368;
	bh=SFlO3K88GQ5/KjsjGwJaMf59sIFuaTxQR4jVB/FIWqk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G88pKKdccp7SBPcDyNDE4wDeHdZ9q+gZ2WIADnI0FXGlBhHaRl8zVxV/Q02m78uZT
	 xRbf10aQXDHiGtz0mzXq7VT2pV6PqE9GVL1ypqqvZZ3YY+mG2/i92N/u2LQ5OFKzjj
	 t3a2A8YS1b14Ytsn4dJUnRPVQxBOC1Lq3do3ACx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfIQXgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 19:36:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43555 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfIQXgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 19:36:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id d5so5263830lja.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 16:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sehrhagUbzhgXbjTR8qVaFgoPczCVRVTJPCT+/xzLMA=;
        b=cjdPTRCTiuw4aA+w1j39Hmcx6fIPQiBjKApo6z5+Jl5YhqJEmxXDvXReN7A0GWmBX9
         190yy/7yfDosn7NCugaAo5xnqZ+8H6IAs1lrgMJ0jD071y1MD58YzeCYCWopQAWShfiy
         upbOQmxa7tMZ4djvQhcSmmIVchcbJfieT2U/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sehrhagUbzhgXbjTR8qVaFgoPczCVRVTJPCT+/xzLMA=;
        b=g8cLxiyDKv2C0m4HYUJtHuBzQEYojjOW5LmkqI14DgmwhipVNgwR5pzQJNVKtYKfSy
         63dmgoBY9qp/OwnhH1S2rm/pD+ZFDP8zempvYAYr+mbEn+uHaN4z0W/23oTLa27Oz9hw
         hzdgsDEdJ9ZZWwzpqyY0IuUeALNtB+A/GX3BK9grEwLmPydUFXvqoaHh2Xh+kHesrkuJ
         e9bgyP/m/Glmgm2NUbOcvmoFziyGN8y1+lgxM3gurtv3ShJGlQy8rnfk3txwmLkRFjPl
         MiNiGvUxpEBDGHcKqbQpd+tyI0n4pMvg7hJl9Og4AarH8b9ordJWSOGraGb0PxWM2s1J
         aXRg==
X-Gm-Message-State: APjAAAWQUrFBJDT8ocmRUpegJLd8vjHxnuqe7KllWVMQgZiZ4n+Ko5qT
        AQZ+PkpRWY+JZ3Nx5ri+GxtzX+g38fw=
X-Google-Smtp-Source: APXvYqwTGufq6LABp0MFGBwIhI7o7Whr1gMshAtHhdlwjXhocxEuCtz28n6Xym2ULPFLvQ6tQcplsQ==
X-Received: by 2002:a2e:9ac4:: with SMTP id p4mr435426ljj.206.1568763363928;
        Tue, 17 Sep 2019 16:36:03 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 202sm702404ljf.75.2019.09.17.16.36.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 16:36:03 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id l21so3569409lje.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 16:36:02 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr474166ljs.156.1568763362554;
 Tue, 17 Sep 2019 16:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
 <156864062019.3407.14798418565580024723.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjQJaNbQe3fmFU19_wawkx-WT9Sv=h5mWCA9=LL34g_3Q@mail.gmail.com>
 <CDB07BE3-6491-4159-89E7-FBA1631A01C3@fb.com> <CAHk-=whbOhAmc3FEhnEkdM9AXFuKM+964r+uzzm_Q9qFaxTC7g@mail.gmail.com>
 <E4AF8E4C-A307-4AE7-85AA-F579D5BFDBDD@fb.com>
In-Reply-To: <E4AF8E4C-A307-4AE7-85AA-F579D5BFDBDD@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Sep 2019 16:35:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wisZfwwJo57BRigT5X_uWs6Jw4K3ezPSwCSMBHSeJTHzg@mail.gmail.com>
Message-ID: <CAHk-=wisZfwwJo57BRigT5X_uWs6Jw4K3ezPSwCSMBHSeJTHzg@mail.gmail.com>
Subject: Re: [GIT pull] x86/pti for 5.4-rc1
To:     Song Liu <songliubraving@fb.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 4:29 PM Song Liu <songliubraving@fb.com> wrote:
>
> How about we just do:
>
> diff --git i/arch/x86/mm/pti.c w/arch/x86/mm/pti.c
> index b196524759ec..0437f65250db 100644
> --- i/arch/x86/mm/pti.c
> +++ w/arch/x86/mm/pti.c
> @@ -341,6 +341,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
>                 }
>
>                 if (pmd_large(*pmd) || level == PTI_CLONE_PMD) {
> +                       WARN_ON_ONCE(addr & ~PMD_MASK);
>                         target_pmd = pti_user_pagetable_walk_pmd(addr);
>                         if (WARN_ON(!target_pmd))
>                                 return;
>
> So it is a "warn and continue" check just for unaligned PMD address.

The problem there is that the "continue" part can be wrong.

Admittedly it requires a pretty crazy setup: you first hit a
pmd_large() entry, but the *next* pmd is regular, so you start doing
the per-page cloning.

And that per-page cloning will be wrong, because it will start in the
middle of the next pmd, because addr wasn't aligned, and the previous
pmd-only clone did

                        addr += PMD_SIZE;

to go to the next case.

See?

Can this happen right now? I'd certainly hope not. But if we're
hardening this code against odd cases that can't currently happen, it
surely is such an odd case.

            Linus
