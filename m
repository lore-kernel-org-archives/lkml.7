Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0411C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C552171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 21:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="CpPA4mWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfDLVSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 17:18:17 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37779 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfDLVSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 17:18:16 -0400
Received: by mail-ot1-f66.google.com with SMTP id c16so9641059otn.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 14:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSYdXQwXFMvtOr6Dgey5dpsg1Jt+p+pd4Kjm1MAHBlg=;
        b=CpPA4mWjn5Wwi7DueLKKjAsuxnTirFBORCnXE6boZrQxKM3E/TTqoe896Byq0hHm2T
         6jov1XfageLx35B9+i3H8QK8R+hsTq5YPKPrwPk1xn4zzhU7nrAwqxhAJ9JxzL0yot9b
         Hdc+HS6xd/2bs8y6FlvLaPsoHQfeaZ+Ts3Of20yfi9EFWEsSgMj1nrXsrXJFcIBJiDiK
         1BcEGOEacKfajqXU+rCOwGm1g57ZEhIAj3cZgDl/FxMUb1CvERYE55pHrdbeFkRj0bB0
         JWr5RHAZ2OsxP54/2JpIiGyprffaF6xYl/N+M6kSrAmJ2rFXE2cLB5+mdP1msvU+0RX3
         /qHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSYdXQwXFMvtOr6Dgey5dpsg1Jt+p+pd4Kjm1MAHBlg=;
        b=WxhtkR1jW7QB0ZPKB/vi+opuLKyhtnkwzupPdCrCV5r7DtPAjoQp4+t6piJg1Md/C/
         oGez90VD4aXqCGmXmzOgF6YKFIxRAaoz6OKNp5lDY4tzsVJhN8PfvaoIBh9EkRHin6Ov
         riwjwD9PAlO+DjzqqpCrMiUDAn2uQYNYqQiGyP833Gn1U2nBloq5rmdDWgdeS8+hyx5y
         3CbY3pXovTus1Y091QRAt4uT2bJEz+WDN1H4pcWcvEgK6BtPTggyuMU6XOhsZ3QCqkhU
         rbM9GkNzFNJ8PzlWOt/4LQ56QqOFhijFP6cpW3HEtzN8wtf5uXc6jOjnWv4g+qGXcTVe
         0B2Q==
X-Gm-Message-State: APjAAAVTBxpjPv2HJKqJuXseZA0+AqGKV0LIO7DOYP6u2Ha9gbf8nq4Z
        XKo0n3rhfI2CsEgYG9waCVFO4xhhdD7ZPi5ogZJbNw==
X-Google-Smtp-Source: APXvYqw3O9GRmPoSzcYlK/K4WQaRLyoxuZvWrS4GIiXl0P9+RFBhPrKh5sAdJRD7oKKEp7fk6rKWQ3oDQcy+M3vWCvw=
X-Received: by 2002:a9d:5c86:: with SMTP id a6mr36945551oti.118.1555103895409;
 Fri, 12 Apr 2019 14:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <155440490809.3190322.15060922240602775809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155440491334.3190322.44013027330479237.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu8ocQGxTAapfjb5WufhL=Qj54LythHcPHsyy+wUnVBnfA@mail.gmail.com>
 <CAPcyv4gUL8j+EaAZ556_NKXLgva++HgPBOeeAUNHN+DAWaewaQ@mail.gmail.com>
 <CAKv+Gu_M-V-3ahHTj10iyx=eC2pBzFg027NmdBX1x7nXrpqK7g@mail.gmail.com>
 <CAA9_cmeRqr=b-hmaxA0aLZE98YGS9hF8h8JGGp9K6c_qhLK3AQ@mail.gmail.com> <CAKv+Gu_gzHH7onY4WUWV8SAYeVXfMK-W3CaxYZ706sPo6ATZpA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_gzHH7onY4WUWV8SAYeVXfMK-W3CaxYZ706sPo6ATZpA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 12 Apr 2019 14:18:03 -0700
Message-ID: <CAPcyv4gtD=h-z_b5k3XTWsiPVv0NY=+Gycr8TJoTMCfcM3RL_A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] efi: Detect UEFI 2.8 Special Purpose Memory
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 1:44 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
[..]
> > > I don't think this policy should dictate whether we pretend that the
> > > attribute doesn't exist in the first place. We should just wire up the
> > > bit fully, and only apply this policy at the very end.
> >
> > The bit is just a policy hint, if the kernel is not implementing any
> > of the policy why even check for the bit?
> >
>
> Because I would like things like the EFI memory map dumping code etc
> to report the bit regardless of whether we are honoring it or not.

Ok, I'll split it out just for reporting purposes, and come up with a
different mechanism to indicate whether the OS might not be honoring
the expectations of the attribute.

[..]
> Because not taking a hint is not the same thing as pretending it isn't
> there to begin with.

True, and I was missing the enabling to go update where the kernel
goes to report attributes, but for the applications that care they
will still want to debug when the kernel may be placing unwanted
allocations in the "special purpose" range.

> > > > Moreover, the interface for platform firmware to indicate that a
> > > > memory range should never be treated as ordinary memory is simply the
> > > > existing "reserved" memory type, not this attribute. That's the
> > > > mechanism to use when platform firmware knows that a driver is needed
> > > > for a given mmio resource.
> > > >
> > >
> > > Reserved memory is memory that simply should never touched at all by
> > > the OS, and on ARM, we take care never to map it anywhere.
> >
> > That's not a guarantee, at least on x86. Some shipping persistent
> > memory platforms describe it as reserved and then the ACPI NFIT
> > further describes what that reserved memory contains and how the OS
> > can use it. See commit af1996ef59db "ACPI: Change NFIT driver to
> > insert new resource".
>
> The UEFI spec is pretty clear about the fact that reserved memory
> shouldn't ever be touched by the OS. The fact that x86 platforms exist
> that violate this doesn't mean we should abuse it in other ways as
> well.

I think we're talking about 2 different "reserved" memory types, and
it was my fault for not being precise enough. The e820 reserved memory
type has been used for things like PCI memory-mapped I/O or other
memory ranges for which the OS should expect a device-driver to claim.
So when I said EFI_RESERVED_TYPE is safe to use as driver memory I
literally meant this interpretation from do_add_efi_memmap():

                default:
                        /*
                         * EFI_RESERVED_TYPE EFI_RUNTIME_SERVICES_CODE
                         * EFI_RUNTIME_SERVICES_DATA EFI_MEMORY_MAPPED_IO
                         * EFI_MEMORY_MAPPED_IO_PORT_SPACE EFI_PAL_CODE
                         */
                        e820_type = E820_TYPE_RESERVED;
                        break;

...where EFI_RESERVED_TYPE is identical to EFI_MEMORY_MAPPED_IO
relative to E820_TYPE_RESERVED.

The policy taken by these patches is that EFI_CONVENTIONAL_MEMORY
marked with the EFI_MEMORY_SP attribute is treated as
E820_TYPE_RESERVED by default and given to the device-dax driver with
the option to hotplug it as E820_TYPE_RAM at a later time with its own
numa description.

I'm generally pushing back on the argument that EFI_MEMORY_SP ==
EFI_RESERVED_TYPE, especially when the type is explicitly set to
EFI_CONVENTIONAL_MEMORY.
