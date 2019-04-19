Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DC5C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA433217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfDSTaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:30:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41150 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfDSTaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:30:05 -0400
Received: by mail-io1-f66.google.com with SMTP id r10so1240142ioc.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xwv2Jj5H9ECcT4qbxSkUQgVfTdS9O7FoHlMXAykRFg=;
        b=kdaNN5mgYMQZGMGxtHKxOcKX9Rf9lUlXGOtNUX5cN6BSBOjCgt+wNsBMW5wSWF7U8N
         vkXBcYYWtZ21yQmQHwXNnQSRk5xzg4ZgY+v1OigqojcIvf2Fkn5FBLF+3pHwddmcXaVz
         +ZXfrw2gc67hpW98jCiwTSZBM9HmeiDxFhgSXX+TWpK7SQYsb/dFi4igBrzfoE6Jm3lr
         YjNJ9+RQWgS4uplZJcSLL1E1y7P4SoTKzyJ87I8w9aTZ/xdeZ69b5+6170b4yehI73a7
         zdwxiVx4rBdOhX447e+L6hjyjJJOmYfEyuAWrF6JGarLRP7OWSmQRzbACAxyk/wUeaXp
         Pa5w==
X-Gm-Message-State: APjAAAUFkcWQhHN8FlQ8d0DyrfBdOZXRVpfUr6rptEZ9k3qNH4OcXM4i
        uOqqwyed9+wLIU+cs/DWAn536GA6CPBtk5Vie9VfZQCYy5IZ/A==
X-Google-Smtp-Source: APXvYqxJU4jabMXs2quoLxiuDEmfwJLQZ/jqEI/9JC7kBX2DGvEuVhw6w6HtZktScplNIykPyR7wyrbhrTu6MWAdHko=
X-Received: by 2002:a6b:6509:: with SMTP id z9mr2215896iob.43.1555674629051;
 Fri, 19 Apr 2019 04:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190419101733.GA10324@zn.tnic> <20190419105014.GE11060@MiWiFi-R3L-srv>
 <CACPcB9fwvxmVcD4ttP8p9X0=J+Oev9RUrgNzuu6LZFQCZ7AS1w@mail.gmail.com> <20190419113413.GC10324@zn.tnic>
In-Reply-To: <20190419113413.GC10324@zn.tnic>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 19 Apr 2019 19:50:17 +0800
Message-ID: <CACPcB9emLPEWCvpdExGvD_S_b3RWrrgK2uCx07HZjj5yUh6Y_g@mail.gmail.com>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
To:     Borislav Petkov <bp@alien8.de>
Cc:     Baoquan He <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 7:34 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Apr 19, 2019 at 07:20:06PM +0800, Kairui Song wrote:
> > Thanks for the declaration Bao, I can verify on the machine I have,
> > the issue still exist without kaslr. Currently, we read rsdp in early
> > code and fill in boot_params unconditional, so it will read from the
> > systab anyway.
>
> Yes, and in the future, info required by the kexec'ed kernel - like the
> EFI systab address or even whether the kernel has been kexec'ed or comes
> from cold boot - should be passed in boot_params. So that we don't have
> to do all that ugly dancing in early code.
>
> > Yes, kexec only cover RAM in the ident map it prepared for second
> > kernel, but the systab could be in reserved region, so if it didn't
> > fall into the 1G padding by accident it will fail when reading from
> > it. Fix in early code could make sure 2nd kernel always work. Or
> > should we treat it specially in kexec mapping prepare code?
>
> Yes, we should. As I said, this is not early boot code's problem but the
> kexec setup code's problem.
>
> If the new kernel cannot get RSDP that early, then it should fail the
> same way it failed before. That early RDSP parsing was added for the
> movable regions thing working with KASLR.
>
> If it can't get a RDSP for whatever reason, then if KASLR selects
> a region overlapping with the movable regions, then it is the old
> behavior.
>
> Ok?
>

OK. And then fix the mapping issue in 1st kernel is the right way,
I'll skip the update for the early code mapping thing.


--
Best Regards,
Kairui Song
