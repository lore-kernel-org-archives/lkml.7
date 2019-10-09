Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAA2ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 05:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BFF20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 05:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDuJJlQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfJIF7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 01:59:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42861 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfJIF7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 01:59:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id f16so1118015qkl.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 22:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QP9COoIo3B5n4ZVc/Ae6X1MjkUee4h2WyLXSB8IqAg4=;
        b=DDuJJlQ7O/wq2X7NYrL2Dyt3r3ProJp9keBPOqyFlW53u0BQ7Dqnm/NdV/1ih3i6HB
         AFAU1ri4+NGJzZVE0oe5Pvm9N8DUpgWuhKloQxnAvSSXM0+Nn7pAbnKOh/U0byPf9xOV
         Z18IwZyBi+ks4ytrAYSEMkK+zTsCrhf3CNNGaKpxH+S4NVi9y6UTsM//n7TkkVlv1jdy
         +9/euRTcFsU7NTl9UnnusyWXwH8B+ti/MWJHCocIUOCFf882zVwjlwoKHl+uILM8f3xV
         XbgWh2f9xFiI3LglFDCtZF4+mjyGsBmKP/UsQczDJREBRq9a4lKNAdnkO/5uA48MV5JC
         aYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QP9COoIo3B5n4ZVc/Ae6X1MjkUee4h2WyLXSB8IqAg4=;
        b=a1WBO5ARs8687Gj8OIDU/WJWVIVFamdpAak7FU0JIu8xE0GMv17P1B6+OzCs/opcur
         dL9iqfKBfpnBnn8Sxd73Dxp1YlsdKL7/IPmaV5gE0f4ncrOO+KItWv3/QLwuu5g0Wl0O
         fB9mzHtXAY3EVq4yD4l7iT8HeocKMgMmW84XbWSMq54VyjqPbTHrqKKa6zAUEPOgKE+R
         4cj2EKaHSP1RE/UpeIAEmRy5HR8iRkLHfx1lb/zYriDzKVwcze2KnTJ9zB/C81LfB1Ru
         KiZzl3x6R9jwEYf2A46kcBm60LStNHW07250GbfuinCgwgjbp7HpFSfsWfNUksTuH1OF
         YDWg==
X-Gm-Message-State: APjAAAVJ9JNSrqVYPcFX2Gdw6YySS8F68gzuXS6cyK9S8MzY6OHWQWVq
        JMyYVsO2vVaL0OPIXUlBjRPcJePry2p7eWJueQk=
X-Google-Smtp-Source: APXvYqwHv3qx96Q9TYazL2MzGf2DtjcHslsu2IVQn1IS+gt0W53MyC9hQkbkjlNN9T2no+E9Y58pQoc86Bvy2xk0cTs=
X-Received: by 2002:a37:bbc5:: with SMTP id l188mr1964517qkf.118.1570600746816;
 Tue, 08 Oct 2019 22:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190829091232.15065-1-kai.heng.feng@canonical.com>
In-Reply-To: <20190829091232.15065-1-kai.heng.feng@canonical.com>
From:   Feng Tang <feng.79.tang@gmail.com>
Date:   Wed, 9 Oct 2019 13:58:55 +0800
Message-ID: <CA++bM2tb_twW_cF9dRx2KaQezXgqZ==Qw3bP-+7D5CnRzgFu6w@mail.gmail.com>
Subject: Re: [PATCH] x86/hpet: Disable HPET on Intel Coffe Lake
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, harry.pan@intel.com, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        feng.tang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng,

On Thu, Aug 29, 2019 at 5:14 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Some Coffee Lake platforms have skewed HPET timer once the SoCs entered
> PC10, and marked TSC as unstable clocksource as result.
>
> Harry Pan identified it's a firmware bug [1].
>
> To prevent creating a circular dependency between HPET and TSC, let's
> disable HPET on affected platforms.

Sorry for chiming late.

We have disabled the HPET for Baytrail platforms in
 commit 62187910b0fc : x86/intel: Add quirk to disable HPET for the
Baytrail platform

Which added a quirk in
@@ -567,6 +577,12 @@ static struct chipset early_qrk[] __initdata = {
+       /*
+        * HPET on current version of Baytrail platform has accuracy
+        * problems, disable it for now:
+        */
+       { PCI_VENDOR_ID_INTEL, 0x0f00,
+               PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},

So maybe we can unify the method to disable HPET. (btw, I have no idea
about the healthy info of HPET for Kabylake, just want to comment
on the disabling method).

Thanks,
Feng

>
> [1]: https://lore.kernel.org/lkml/20190516090651.1396-1-harry.pan@intel.com/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203183
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  arch/x86/kernel/hpet.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
> index c6f791bc481e..07e9ec6f85b6 100644
> --- a/arch/x86/kernel/hpet.c
> +++ b/arch/x86/kernel/hpet.c
> @@ -7,7 +7,9 @@
>  #include <linux/cpu.h>
>  #include <linux/irq.h>
>
> +#include <asm/cpu_device_id.h>
>  #include <asm/hpet.h>
> +#include <asm/intel-family.h>
>  #include <asm/time.h>
>
>  #undef  pr_fmt
> @@ -806,6 +808,12 @@ static bool __init hpet_counting(void)
>         return false;
>  }
>
> +static const struct x86_cpu_id hpet_blacklist[] __initconst = {
> +       { X86_VENDOR_INTEL, 6, INTEL_FAM6_KABYLAKE_MOBILE },
> +       { X86_VENDOR_INTEL, 6, INTEL_FAM6_KABYLAKE_DESKTOP },
> +       { }
> +};
> +
>  /**
>   * hpet_enable - Try to setup the HPET timer. Returns 1 on success.
>   */
> @@ -819,6 +827,9 @@ int __init hpet_enable(void)
>         if (!is_hpet_capable())
>                 return 0;
>
> +       if (!hpet_force_user && x86_match_cpu(hpet_blacklist))
> +               return 0;
> +
>         hpet_set_mapping();
>         if (!hpet_virt_address)
>                 return 0;
> --
> 2.17.1
>
