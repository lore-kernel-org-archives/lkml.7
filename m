Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B5DC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2942A20644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh4yIitz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfEHNaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:30:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40784 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfEHNaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:30:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so9936137plr.7;
        Wed, 08 May 2019 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMRDG203T8q7M0bbQTE+pNkcaQpfwdTEmlYiIWZnOxY=;
        b=Dh4yIitzet2cNdBx6KmCJGUWgtxkMjhd8Hkwn1DRmID4+m2U9Q54I+GA2fwl5sSmCQ
         si4mSg74qhsrZ7v3CbBxbyU5w79kuOpphCWdrRVTaRTJ11DslyDvJAs1KL2r41h0UhOl
         KCcWkTcb5aW0JXqQ16iQQUa0LAtDYzMS1YQwWxtcwYEMeKY2Cw9diKlQ+9CVqGKpMqLG
         jrp0nkRJjk7QXuv3wWbHs9aJEIzNSMJ9xRE+8Ieo0YtH04QWp1HxOu6TlSZCHvS9vNPU
         EmPCdmVQh0Z7+Gc0He91jrhkJO8/CWp3uTPg0NjMUAzK/UMjxFkQHmgf9DqIUisRhpcx
         obHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMRDG203T8q7M0bbQTE+pNkcaQpfwdTEmlYiIWZnOxY=;
        b=Hy8kdCeDuMDvBeBWq17wtMd25s7+nJ736+NXt1esDRqI0cKEEN+2AV/W35B1ucrDHM
         CJ3+ORFpEQO0EuCkN9edsUMDpexi0Ksw6jhI1kbRkhQ5z5Ux5v1Ao2mVl4/qhqp3CSnk
         lo0jzvLUlIrFZBkVOXor1f0a5SiuM2RsImuDzIMAJ02gdlTZmiWZbNro8REDK+FvPCX4
         yhqX/bcbXXELrRpHcP7sQxV3uJPvdBkW+krMA1EtDzYnqpHe/MNsaKEBdTc6emyZpd4g
         SAZxg9FbCowFW+7QqSq8kbwmihSXVRhu7bF/auQ/RENmClWWpUNeaclrYKea7KrhMEe1
         Hb+A==
X-Gm-Message-State: APjAAAXuxnUecb25JVucrAp+6iseH7qwbcvcyk5yj97joIfXhWpgAdjq
        ip53M4lNAYZugnW6jSLQ18zrIybm5Gm2uxZ7O8nQTEqzvII=
X-Google-Smtp-Source: APXvYqxvxeM/20XZxLDEFFhFqPaHS+19EckDaqq36S8JJZWuhUDEWzLNBIXMo7fsvcv1Qqi+gHRutTWKWQOYHTFUWWA=
X-Received: by 2002:a17:902:758b:: with SMTP id j11mr48101865pll.87.1557322214365;
 Wed, 08 May 2019 06:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com> <5e1a56c3-0448-a648-e331-a2e1d0421b56@gmail.com>
In-Reply-To: <5e1a56c3-0448-a648-e331-a2e1d0421b56@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 May 2019 16:30:03 +0300
Message-ID: <CAHp75Ve0MrS2_ROzo4_o9oTjTvs+GSfUn=2CRQx1L_W+5JR6Vw@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] platform/x86: asus-wmi: Increase the input
 buffer size of WMI methods
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 1:07 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
>
> The asus-nb-wmi driver is matched by WMI alias but fails to load on TUF
> Gaming series laptops producing multiple ACPI errors in the kernel log.
>
> The input buffer for WMI method invocation size is 2 dwords, whereas
> 3 are expected by this model.
>
> FX505GM:
> ..
> Method (WMNB, 3, Serialized)
> {
>     P8XH (Zero, 0x11)
>     CreateDWordField (Arg2, Zero, IIA0)
>     CreateDWordField (Arg2, 0x04, IIA1)
>     CreateDWordField (Arg2, 0x08, IIA2)
>     Local0 = (Arg1 & 0xFFFFFFFF)
>     ...
>
> Compare with older K54C:
> ...
> Method (WMNB, 3, NotSerialized)
> {
>     CreateDWordField (Arg2, 0x00, IIA0)
>     CreateDWordField (Arg2, 0x04, IIA1)
>     Local0 = (Arg1 & 0xFFFFFFFF)
>     ...
>
> Increase buffer size to 3 dwords. No negative consequences of this change
> are expected, as the input buffer size is not verified. The original
> function is replaced by a wrapper for a new method passing value 0 for the
> last parameter. The new function will be used to control RGB keyboard
> backlight.


> -int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1, u32 *retval)
> +static int asus_wmi_evaluate_method_3dw(u32 method_id, u32 arg0, u32 arg1,
> +               u32 arg2, u32 *retval)

I would name as "..._method3" and move arg2 to previous line

>  {
>         struct bios_args args = {
>                 .arg0 = arg0,
>                 .arg1 = arg1,
> +               .arg2 = arg2

Keep comma, it will help in the future, like above helped you here.

--
With Best Regards,
Andy Shevchenko
