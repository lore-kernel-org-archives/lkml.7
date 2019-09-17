Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0DEC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14851214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568746935;
	bh=cUDiv55an1AA9o+yDPmf4cuZbCg5YEDXQwd8TaXyAHo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0BR6WVr4RfuA8MX6CZplSd1MC8FHowslYBczs0tkB1JAUUhSoFzx0iMXMSb9U66UI
	 NmRLn3pxuXjiawsj5DAKSWGuWzLjaAQqdEtavkiSpnGIq5AjvrVTPWozfxfArZ+yZs
	 /MbFPrzBp5QP+FErLM0+BWwbexykK13eARqg5Scc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbfIQTCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 15:02:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35941 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfIQTCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 15:02:13 -0400
Received: by mail-lf1-f67.google.com with SMTP id x80so3766530lff.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 12:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4nyFrfksn/ckDRFnuSHI4kQ9RSLvNMthcyYxVLLZak=;
        b=VSuVQIieSfEp5JFwd7tZrWWIBJ4LwfwTxE0Ub/VmEK1cwTIfP5sVKkc9dyfQgHAJ+4
         cJZvjFThFoq77xre7XHyx4jWNkICWB057EJEuroOUJQCc0BlytaiEcCKMdB1K87PdVvA
         z4AUP/5I8NHnMa51MPJr6xiGHlZ/iZxRL3Ayc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4nyFrfksn/ckDRFnuSHI4kQ9RSLvNMthcyYxVLLZak=;
        b=QWjLmxvOaqhqV0dO9LjfcZhQl84JD86EJSt9MyyobI90OJ8IUGey2In3gamgdEa5FR
         vHFLHKllsFGp/xzwA4mPZ9hEB1rIwyrDNwivI8tqzfX1lk9eI/E9Lubd9zwh73J48hp+
         aADwGvPpRrgZ+XQOJN0irMsjowduDVVxbwAa+Pwp+z3jLcNBjt/hxsZTzNCPrDEBr8l7
         q/DQef44HFIvaS4zrQ5sGfTgSUA7mFQRKFdYNMJwy5adb8I/F62GgrHdEgkurCRBkCna
         gGKetjLefd1j9ZsTzlmeMU35JIlt0XenAA/h8b7ZIekuEKb2F8PTkQ4pejmd8t/qfQb2
         6PGg==
X-Gm-Message-State: APjAAAVUkq1LwieXjcBTcOwZGjguATfJpB+DfZ0Sl1+11QRRNTi1m77a
        9wAkZdPBFIhfF8ouulxm9eVf1YgbHyw=
X-Google-Smtp-Source: APXvYqzx4Dn2Z/nGpELVPSy9EwypgOmUkrMibfInaHlbK/RU8xbxhGkNcuPaxBTYZyVURpV1aI+qOA==
X-Received: by 2002:ac2:5633:: with SMTP id b19mr2890723lff.103.1568746931030;
        Tue, 17 Sep 2019 12:02:11 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id j5sm546075lfj.77.2019.09.17.12.02.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 12:02:10 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id w6so3768438lfl.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 12:02:09 -0700 (PDT)
X-Received: by 2002:a19:741a:: with SMTP id v26mr2893996lfe.79.1568746929576;
 Tue, 17 Sep 2019 12:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
 <156864062019.3407.14798418565580024723.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjQJaNbQe3fmFU19_wawkx-WT9Sv=h5mWCA9=LL34g_3Q@mail.gmail.com> <CDB07BE3-6491-4159-89E7-FBA1631A01C3@fb.com>
In-Reply-To: <CDB07BE3-6491-4159-89E7-FBA1631A01C3@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Sep 2019 12:01:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbOhAmc3FEhnEkdM9AXFuKM+964r+uzzm_Q9qFaxTC7g@mail.gmail.com>
Message-ID: <CAHk-=whbOhAmc3FEhnEkdM9AXFuKM+964r+uzzm_Q9qFaxTC7g@mail.gmail.com>
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

On Tue, Sep 17, 2019 at 11:49 AM Song Liu <songliubraving@fb.com> wrote:
>
> I guess we need something like the following?
>
> diff --git i/arch/x86/mm/pti.c w/arch/x86/mm/pti.c
> index b196524759ec..7846916c3bcd 100644
> --- i/arch/x86/mm/pti.c
> +++ w/arch/x86/mm/pti.c
> @@ -306,6 +306,8 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
>  {
>         unsigned long addr;
>
> +       if (WARN_ON_ONCE(start & ~PAGE_MASK))
> +               return;

I don't think we ever care about the low bits of the address below the
page mask, so this one probably wouldn't make any difference.

To match the other cases, I'd make it just a plain

        WARN_ON_ONCE(start & ~PAGE_MASK));

and leave it at that. The existing commit added the warning, but then
just made the code work despite it all.  I'd continue that same logic.

>                 if (pmd_large(*pmd) || level == PTI_CLONE_PMD) {
> +                       if (WARN_ON_ONCE(addr & ~PMD_MASK))
> +                               return;
>                         target_pmd = pti_user_pagetable_walk_pmd(addr);
>                         if (WARN_ON(!target_pmd))
>                                 return;

Again, I think to match the other cases, I'd just do

-                       addr += PMD_SIZE;
+                       WARN_ON_ONCE(addr & ~PMD_MASK);
+                       addr = round_up(addr + 1, PMD_SIZE);

which now admittedly clones too much, but _does_ clone the requested range.

But maybe it really doesn't matter, since this condition just
shouldn't happen in the first place.

And arguably, the "clone more than requested" issue is true, and maybe
your "warn and refuse to clone by returning" is the right thing to do.

So I have very few strong opinions in this area, I just reacted to
looking at the patch that it didn't seem to cover all the cases.

> > Also, it would have been lovely to have some background on how this
> > was even noticed. The link in the commit message goes to the
> > development thread, but that one doesn't have the original report from
> > Song either.
>
> I didn't really notice any issue. I was debugging an increase in iTLB
> miss rate, which was caused by splitting of kernel text page table,
> and was fixed by Thomas in:
>
> https://lore.kernel.org/lkml/alpine.DEB.2.21.1908282355340.1938@nanos.tec.linutronix.de/
>
> I mistakenly suspected the issue was caused by the pti code, and
> mistakenly proposed the first patch here. It turned out to be useful,
> but it is not related to the original issue.

Ok, thanks for the explanation.

              Linus
