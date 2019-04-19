Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBC7C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D9D20663
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfDSUOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:14:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33699 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfDSUOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:14:17 -0400
Received: by mail-io1-f68.google.com with SMTP id b6so5266908iog.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSKP6/llLeXcjb5HjAkjCZEo96B+F7GsqsxPcntXPBA=;
        b=csJr4+prfD9kndSpE1bdkoNMJ/36XI+MWhS4le/40iiBrZV3kEUpswN+6NfsEjnhmb
         mpN1bsyQTpsY7eC/3z36XOf1yGP53WBFSl2mk/JB4UQnaNb6VHE72088qvU1ioNGHyIM
         54dBLGZJogZf/UlwHqKFjKRMZHumZIiRhEmx3pP5lsuwEEev81jqY2ZLGrglDUR8wUKu
         WTeoQ5aZbHY7VahGdL4kInE0TreHxRx1s6lv0sHqbSHfZhrLuQegbf9vMJvxzTQDDo6x
         CDhrgcPtYs7DGy618zNEfy68YLHxLwGLOwbWX1WztP6Gzu5Iz7nQ0smqsq+Y7/MCmI+V
         Lw7g==
X-Gm-Message-State: APjAAAVunjmnFBhouZja9snYRR+UwZ5BLXbREfF3e3njFrRrTDRDcNeZ
        qKxEb6MJOoUEwUvBe02yVCjl57UyREK9HsTWbziyzSw5ro3NzqlE
X-Google-Smtp-Source: APXvYqzmiGnk6EjSHFR9BiO+Ucc4peYYFjrzjrluWGPZzkbINl94j0knTdXXm4aDZHO1jOnLSkUjBzDrWSpdfGHL1K0=
X-Received: by 2002:a6b:6509:: with SMTP id z9mr2153247iob.43.1555672817379;
 Fri, 19 Apr 2019 04:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190419101733.GA10324@zn.tnic> <20190419105014.GE11060@MiWiFi-R3L-srv>
In-Reply-To: <20190419105014.GE11060@MiWiFi-R3L-srv>
From:   Kairui Song <kasong@redhat.com>
Date:   Fri, 19 Apr 2019 19:20:06 +0800
Message-ID: <CACPcB9fwvxmVcD4ttP8p9X0=J+Oev9RUrgNzuu6LZFQCZ7AS1w@mail.gmail.com>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
To:     Baoquan He <bhe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
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

 On Fri, Apr 19, 2019 at 6:50 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 04/19/19 at 12:17pm, Borislav Petkov wrote:
> > Breaking thread because this one got too big.
> >
> > On Fri, Apr 19, 2019 at 04:34:58PM +0800, Kairui Song wrote:
> > > There are two approach to fix it, detect if the systab is mapped, and
> > > avoid reading it if not.
> >
> > Ok, so tglx and I discussed this situation which is slowly getting out
> > of hand with all the tinkering.
> >
> > So, here's what we should do - scream loudly now if some of this doesn't
> > make any sense.
> >
> > 1. Junichi's patch should get the systab check above added and sent to
> > 5.1 so that at least some EFI kexecing can work with 5.1
>
> Talked with Kairui privately just now. Seems Junichi's patch need add
> this systab mapping. Since the systab region is not mapped on some
> machines. Those machine don't have this issue because they got systab
> region luckily coverred by 1 GB page mapping in 1st kernel before
> kexec jumping.
>
> This issue should happen whether it is KASLR kernel or not KASLR kernel.

Thanks for the declaration Bao, I can verify on the machine I have,
the issue still exist without kaslr. Currently, we read rsdp in early
code and fill in boot_params unconditional, so it will read from the
systab anyway.

>
> >
> > 2. Then, the fact whether the kernel has been kexec'ed and which
> > addresses it should use early, should all be passed through boot_params
> > which is either setup by kexec(1) or by the first kernel itself, in the
> > kexec_file_load() case.
>
> Seems no better way to check if it's kexec-ed kernel, except of the
> setup data checking of kexec-ed kernel.
>
> It may happen in both kexec_load or kexec_file_load, since we build
> ident mapping of kexec for RAM in 1st kernel.

For kexec_file_load newer kernel will fill in the acpi_rsdp in
boot_params so it bypassed the kexec_get_rsdp_addr (which will read
from systab). The problem is not fixed, systab mapping still missing,
but not likely to happen with kexec_file_load on newer kernel.

>
> >
> > > the systab region is not mapped by the identity mapping provided by
> > > kexec.
> >
> > 3. Then that needs to be fixed in the first kernel as it is a
> > shortcoming of us starting to parse systab very early. It is the kexec
> > setup code's problem not the early compressed stage's problem that the
> > EFI systab is not mapped.
>
> Yeah, adding the systab mapping looks good. Kairui put it in
> decompressing stage just because he wants to cover the case in which the
> old kernel kexec jumping to 2nd kernel. Now it seems not very
> reasonable, we also have the new kernel kexec jumping to old 1nd kernel.

Yes, kexec only cover RAM in the ident map it prepared for second
kernel, but the systab could be in reserved region, so if it didn't
fall into the 1G padding by accident it will fail when reading from
it. Fix in early code could make sure 2nd kernel always work. Or
should we treat it specially in kexec mapping prepare code?

>
> Thanks
> Baoquan
--
Best Regards,
Kairui Song
