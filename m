Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1B7C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D763620674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbfDQGAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:00:53 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34590 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfDQGAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:00:53 -0400
Received: by mail-io1-f68.google.com with SMTP id n11so19645566ioh.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 23:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L7/SDybR+mTe0fM+YdP8FNuPT9/z0sB/mdxWUehWMf4=;
        b=Xk28J1Dxb7FvRuY9ilX+KytBsYCLo0bGQFeZI9+NIEFRZixvy7m8XOi7wiLKWao5V3
         i2iSTQnr72PlT/WhrSxHbzjvv+eoCvD8ubG6KbkFmWleuBjrJmsQPNdJtGycMptCqUOk
         hKHl8UidE6rY5asjJxsq0IMbY+WNUDget6xoMSw/tGb9fHe+811ElgqkPVhy54y7BwWf
         VKwYGFrH+skNZPBeZQb9s/x8X0uPqGgjQ8BqC+yC6ClIEIKhOuWkMJ0o5kRq3ClgeoiW
         tmeLG24zkZBjkd7CYA3m5MvtHi9VXThw8LDKcNX8ZcaB0uE9IQn2aJdIS7HX1Q/q7eo4
         +5MQ==
X-Gm-Message-State: APjAAAX+RvRM42+8dbtnUkMa91FSuLGGzhNHfijYk2/aB7ceFwceYalX
        evwenJRBVk/Y+c01P3Wn5ZEs8B/qKsIu+EB94fYvWg==
X-Google-Smtp-Source: APXvYqz6/vrHm3lkailSAuT0n4NUSXe82n8QiLFNkQE50e54UVh8sQMUApt+L1LduRRXAyb8WOTgvfKlzIsx5Trjs7g=
X-Received: by 2002:a6b:d119:: with SMTP id l25mr27778777iob.278.1555480852510;
 Tue, 16 Apr 2019 23:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190412133528.GD19808@zn.tnic> <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic> <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com> <20190416094024.GE27892@zn.tnic>
 <20190416095209.GG27892@zn.tnic> <20190416114133.GA7541@dhcp-128-65.nay.redhat.com>
 <20190416132253.GE31772@zn.tnic> <20190417013838.GA8411@dhcp-128-65.nay.redhat.com>
 <20190417045447.GB8411@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190417045447.GB8411@dhcp-128-65.nay.redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 17 Apr 2019 14:00:41 +0800
Message-ID: <CACPcB9cf0dtXFF+kpzBYXm3nvvG3uPDf81P1fa19+D37H9BaEg@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernels
To:     Dave Young <dyoung@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 12:57 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 04/17/19 at 09:38am, Dave Young wrote:
> > On 04/16/19 at 03:22pm, Borislav Petkov wrote:
> > > On Tue, Apr 16, 2019 at 07:41:33PM +0800, Dave Young wrote:
> > > > On 04/16/19 at 11:52am, Borislav Petkov wrote:
> > > > > I'll queue the below in the next days if there are no more complaints:
> > > >
> > > > As for the kexec breakage, even with the V3 patch, kexec still hangs on
> > > > a Lenovo T420 laptop.  Kairui also reproduced the problem. So can we
> > > > wait a few days see if we can make some progress to find the cause?
> > >
> > > How is applying this patch going to change anything?
> > >
> > > I was told that the breakage is there even without it...
> >
> > Without this patch, the bug happens in the efi_get_rsdp.. function, this
> > patch tries to fix that by adding kexec_get.. but the new introduced
> > kexec_* function does not work on some laptops, so it is not a 100% good
> > fix, I hoped we can get it working for all known issues.  But if we can
> > not do it eg. within one week we can go with this version and leave the
> > laptop issue as a known issue.
> >
>
> Latest debugging status:
>
> Kexec boot works with commenting out some code like below, so the guid
> cmp (memcmp) caused a system reset), still need to find out why:
>
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index d9f9abd63c68..13e7a23ae94c 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -95,10 +95,12 @@ __efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
>                         table = tbl->table;
>                 }
>
> +/*
>                 if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
>                         rsdp_addr = table;
>                 else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
>                         return table;
> +*/
>         }
>
>         return rsdp_addr;
> @@ -291,9 +293,10 @@ acpi_physical_address get_rsdp_addr(void)
>         if (!pa)
>                 pa = kexec_get_rsdp_addr();
>
> +/*
>         if (!pa)
>                 pa = efi_get_rsdp_addr();
> -
> +*/
>         if (!pa)
>                 pa = bios_get_rsdp_addr();
>
>

Hi Dave, for this case I think it's just because GCC will found the
loop does nothing, and optimize out the whole loop in
__efi_get_rsdp_addr and will no longer read the actual nr_table value.

I can fix the boot error on T420 with your patch, but if I add
anything, like a hardcode value assignment with the right value for
acpi_rsdp in the loop, it will reset the machine. But set acpi_rsdp
with a right initial value out side the loop works fine.
If the loop condition is false, then there should be no difference
between just comment out the line you mentioned and add an assignment.
Else it just assign the value multiple times, not very reasonable but
shouldn't fail.

And, I inspected the generated ASM code also suggest the same thing.
So still, access the systab memory is the cause of the system reset on
certain machines.

-- 
Best Regards,
Kairui Song
