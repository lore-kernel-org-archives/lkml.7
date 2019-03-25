Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D6A206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfCYGpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:45:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46397 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729373AbfCYGpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:45:17 -0400
Received: by mail-io1-f68.google.com with SMTP id b9so6661032iot.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 23:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enF9DflGLDQAPbNv0/xls8CGSRcf4jR4fLMKq/Nio+I=;
        b=AZKlPb4b8H60sEqnt02OzSn0kXeH+Mo4SWI6VfnpxOFUWnTB24IiAHfwVWSd2yW7jm
         OGn1L7Bw4XEJMeE3EtEZi/7q9P9Jeo6LphQ63OkADu9ZlrXc5e2ZmvSkdbj8YdUDQzi9
         5I4e1XwwFCDIYx0K6TIvTKBnL3Don5ZbefWTooHmTjO8+ZBrDRLJbw2orHiPy8jQ1/Rv
         NYy4PiDvN41RvJrGXBIngyxNsLiQgSf0O9o7Hj7TmtGSGsXSAeGX0pTYSE0MdVzm4H0V
         8ztYp2n7QQN4AwcT1A6HHOkWiUfHOF10f3rtrNjrCFimVtH/42ux47KzZOBTTuj2tsns
         dd0Q==
X-Gm-Message-State: APjAAAUKhURU7yjCIwhdfD+nmFt0+ZtinfqB6WnwM0afMt2mJaFUt8Ri
        u7vgH/WO1rxVwwqEEHmtMiBWuQpNHyM/byixD2d5BQ==
X-Google-Smtp-Source: APXvYqxH/JAIEId79AcqE+RX+jMIccqMIsLdQlY8kBpLlz9XI3FB28XRXxW/37FrKUClyVe0KQj6L68uiJpz01ENUjA=
X-Received: by 2002:a6b:7e04:: with SMTP id i4mr15778384iom.137.1553496316204;
 Sun, 24 Mar 2019 23:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp>
 <20190322152328.GD12472@zn.tnic> <20190325002740.GA6637@jeru.linux.bs1.fc.nec.co.jp>
 <20190325060128.GB9385@dhcp-128-65.nay.redhat.com> <20190325061929.GC9385@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190325061929.GC9385@dhcp-128-65.nay.redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Mon, 25 Mar 2019 14:45:04 +0800
Message-ID: <CACPcB9eWuWzS-+-qZ6EP0h08+c_x2w+_Cm-+WrDZR96X_WKSUQ@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Use EFI setup data if provided
To:     Dave Young <dyoung@redhat.com>
Cc:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, "bp@suse.de" <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 2:20 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 03/25/19 at 02:01pm, Dave Young wrote:
> > On 03/25/19 at 12:27am, Junichi Nomura wrote:
> > > On Fri, Mar 22, 2019 at 04:23:28PM +0100, Borislav Petkov wrote:
> > > > On Fri, Mar 22, 2019 at 11:03:43AM +0000, Junichi Nomura wrote:
> > > > > Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
> > > > > boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
> > > > > in the early parsing code tries to search RSDP from EFI table but
> > > > > whose address is virtual.
> > > > >
> > > > > Since kexec(1) provides physical address of config_table via boot_params,
> > > > > efi_get_rsdp_addr() should look for setup_data in the same way as
> > > > > efi_systab_init() in arch/x86/platform/efi/efi.c does.
> > > >
> > > > If the kexec kernel should continue to use efi_systab_init() then you
> > > > should make efi_get_rsdp_addr() exit early in the kexec-ed kernel.
> > >
> > > I'm not sure which way kexec devel is going. Added kexec list.
> > > Here is the version that exits early in efi_get_rsdp_addr().
> > >
> > > [PATCH] x86/boot: Don't try to search RSDP from EFI when kexec-booted
> > >
> > > Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
> > > boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
> > > in the early parsing code tries to search RSDP from EFI table but
> > > whose address is virtual.
> > >
> > > Normally kexec(1) provides physical address of config_table via boot_params
> > > and EFI code uses that during initialization.
> > > For the early boot code, we just exit efi_get_rsdp_addr() early if the kernel
> > > is booted by kexec.
> > >
> > > Fixes: 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in boot_params")
> > > Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
> > > Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> > > Cc: Borislav Petkov <bp@suse.de>
> > >
> > > diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> > > index 0ef4ad5..1cefc43 100644
> > > --- a/arch/x86/boot/compressed/acpi.c
> > > +++ b/arch/x86/boot/compressed/acpi.c
> > > @@ -44,6 +44,24 @@ static acpi_physical_address get_acpi_rsdp(void)
> > >     return addr;
> > >  }
> > >
> > > +static bool is_kexec_booted(void)
> > > +{
> > > +   struct setup_data *data;
> > > +
> > > +   /*
> > > +    * kexec-tools provides EFI setup data so that kexec-ed kernel
> > > +    * can find proper tables.
> > > +    */
> > > +   data = (struct setup_data *) boot_params->hdr.setup_data;
> > > +   while (data) {
> > > +           if (data->type == SETUP_EFI)
> > > +                   return true;
> > > +           data = (struct setup_data *) data->next;
> > > +   }
> > > +
> > > +   return false;
> > > +}
> > > +
> > >  /* Search EFI system tables for RSDP. */
> > >  static acpi_physical_address efi_get_rsdp_addr(void)
> > >  {
> > > @@ -57,6 +75,10 @@ static acpi_physical_address efi_get_rsdp_addr(void)
> > >     int size, i;
> > >     char *sig;
> > >
> > > +   /* If the system is kexec-booted, poking EFI systab may not work. */
> > > +   if (is_kexec_booted())
> > > +           return 0;
> > > +
> > >     ei = &boot_params->efi_info;
> > >     sig = (char *)&ei->efi_loader_signature;
> > >
> > >
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> >
> > Good catch, this way looks good to me.  But the function
> > is_kexec_booted can be compiled when #ifdef CONFIG_EFI
> >
> > Otherwise:
> >
> > Acked-by: Dave Young <dyoung@redhat.com>
> >
>
> Hold on, I replied too quick.  One question is does the above patch
> passed your test?   It can workaround and skip the wrong phys addr
> issue, but the acpi early parsing still fails because efi_get_rsdp_addr
> return 0?
>
> If this is the case you may need go with your old patch.
>
> I think normally people do not see this bug, because kernel will set the
> rsdp in boot_params->acpi_rsdp_addr.  Maybe you are testing with
> different kernel versions, eg.
>
> old kernel kexec to new kernel.
>
> And the old kernel does not set boot_params->acpi_rsdp_addr
>
> Is this correct?
>
> Thanks
> Dave

Hi Dave, actually only kexec_file_load will always set the
boot_params->acpi_rsdp_addr. Can't guarantee how user space tools will
prepare the boot_prams if kexec_load is used, so it's should very
likely to happen.

And for the patch, I also think the first patch looks better, if we
just return 0 early in efi_get_rsdp_addr aren't we still failing to
parse the rsdp in early code?

-- 
Best Regards,
Kairui Song
