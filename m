Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE239C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B3420870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="oYMK8rZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfDHGAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:00:42 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38813 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfDHGAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 02:00:41 -0400
Received: by mail-vs1-f68.google.com with SMTP id s2so6882905vsi.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 23:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ceow9Kpb34qDt2aDmbMOWfiag3sBsLRqN1Tc1/CJTcQ=;
        b=oYMK8rZTl+tyGBbB4LvAhRJNhT+gCel7rYEOqeKkBvE/WNMP1e5t4F6ggTJYZ9WORa
         /lWF6/+bJyT3KLQBWATAgsc9+Kmk00jmxtEIOl2zKvbwx+MeiBf4buFW2hIJU+TNbpVr
         VcvZswTd9hXzAPE714dzhZIEBysb0jUqoWn2xUxpY1KqkkaYMk+9h8cxHvW/lV3nkJ+h
         hxleMGagV81qJGLsBRoMKdvssXXssD3pErPrvEEO1Qi+aiXNUZFDqlYMYTSAT9oQuYY/
         WQIxgtqOH/GWQySOaX/IZqNQfgS6J4YriPGAYQf37v8L/PuyQI8VelYZJ4IOmknI/thL
         +v5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ceow9Kpb34qDt2aDmbMOWfiag3sBsLRqN1Tc1/CJTcQ=;
        b=kQMzhwvO8jTgTz2JWMXA6U0rOvNwBm7nHSZViEPtEXy3cyxNAmJsA/lOnGdceSd6G6
         cM7S6hJNRGJM1EPbI8SMg4NueqkoPEPdJq6ZY5iUwYG7XL3STde8TkND2cZUwjgl4gS7
         egotKZVku2LAKuWwG1NBmNZcXal4sLpain6SqUNIECZkdOhOZNFyLh6evRV0bqPL4kuG
         89XfxQYuM4RgV97tE9tbwlyF3xeotKKsnnU2i+CVGJBhZgXkoKe09IxPaW/mKXQRW35Q
         VX43xrcsWzd670hOtCwZrGCMSzIw2WdvzvLaRRvtRY4AaESx3zE7k1ctz3XKy6VWzWxa
         ZkOg==
X-Gm-Message-State: APjAAAWJF9V/THhbF3uz5Gd6UasSJH59oF8xECsvP/H4EyHkjRfszVIe
        IkLbFboRUSfLazVfERHEI17/pQ5Vpxo98llCk5dtpA==
X-Google-Smtp-Source: APXvYqwqMEJWCjpgFE5jd5DeyJxwrinEp42wrEz81VRVwJNWVaoU5mjm25yjpLpWARVNLHdUUcSOlLLnIu+gpe2DDuI=
X-Received: by 2002:a67:f402:: with SMTP id p2mr15491656vsn.130.1554703240519;
 Sun, 07 Apr 2019 23:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190401073514.2785-1-jian-hong@endlessm.com> <alpine.DEB.2.21.1904052311370.1802@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904052311370.1802@nanos.tec.linutronix.de>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Mon, 8 Apr 2019 14:02:14 +0800
Message-ID: <CAPpJ_edx2J6RyH2MuysXhE4hM61mWn+Th83HNeQtsFLF1K_mzA@mail.gmail.com>
Subject: Re: [PATCH] x86/reboot: Use efi reboot for Acer TravelMate X514-51T
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> =E6=96=BC 2019=E5=B9=B44=E6=9C=886=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=885:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 1 Apr 2019, Jian-Hong Pan wrote:
> > +/*
> > + * Some machines require the "reboot=3De" commandline options
> > + */
> > +static int __init set_efi_reboot(const struct dmi_system_id *d)
> > +{
> > +     if (reboot_type !=3D BOOT_EFI) {
> > +             reboot_type =3D BOOT_EFI;
>
> So if EFI is disabled in the kernel this will fall through to BOOT_BIOS. =
Is
> that intended behaviour?

If not choose EFI as the reboot type, system will use APCI reboot type
on Acer TravelMate X514-51T.
If the reboot type is set as BIOS by appending "reboot=3Db", system
cannot reboot and hangs up when shutdown.

> > +             pr_info("%s series board detected. Selecting %s-method fo=
r reboot.\n",
> > +                     d->ident, "EFI");
>
> Is thee a reason not to write "EFI" in the string itself?

Just simply follow the format like functions: set_acpi_reboot, set_bios_reb=
oot
https://elixir.bootlin.com/linux/v5.1-rc4/source/arch/x86/kernel/reboot.c#L=
60

BR,
Jian-Hong Pan
