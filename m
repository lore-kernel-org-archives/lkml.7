Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECE7C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BBF2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="WUNG9GwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfDLHsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:48:30 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46248 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfDLHs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:48:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id s81so5084588qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 00:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IBQ5DzS+vfkyaqBmbKuUDNLBk30lD5ZF6ldxaX+pNLY=;
        b=WUNG9GwYGn29tJa+mTdQ6JScOKQHorfVIzlQFf632u84PW92UcpIpniNS9bo+GVP0t
         74siGELPEO9gjwrVuVhEwblY+YZGaaRAoNJuO+PvFiKX/Xs1Ez4Bdi8R8hcxRclophz2
         Lzx6DsnM+M7mt4HvKZYSssdEYt1H72NTCKazirOeoT2u7Bwt+ot0p3nuwugehbS+CvBm
         g6TQq0wTYQQ54EbKMJlnqp5zUnHfhlm7t+ffXFZTZsAEKxhdI8BvvO8UoxKb/WDLUFDb
         TjzAxfOFJ967yqtbZGM4LuusPBE6gq4eEtvUTXnvhAhhgug/nnQIsTvEQf/J24Zfmmf2
         Ey5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IBQ5DzS+vfkyaqBmbKuUDNLBk30lD5ZF6ldxaX+pNLY=;
        b=fwwIXuHTJ0YPbW9NMuqKh0sfmmDaxbXvmyhhm1pUV2OdoL2DoiZsYtwkJy31Df8bTc
         9Q9ShbU2XyOJ/kqh9Wbp4e8htZDSAgOHLNbRteF3h6yIVAiRihmjHjAC01p3Dckw+gZw
         fCruLDjtWtWfacQS4scZQxerU5V4zpsM2prxrXjo3pXxzdZaC/gEOSVQgoA/9KkB9MWd
         eVmTWYMrO+mweXreRr36B42qdJB/GIOZJvxffEqGbI2CBiHzojfQVbCnZ4zwlE4IzKH+
         mN2Z3yBgjErWMPHTzkAQ7hzPRgCmGXZV6O0m/2P+JkVXL6hlLWmXHFwG//+GCKDYeQk1
         iTng==
X-Gm-Message-State: APjAAAVl04tPPAmz8uNKEJHBk7CG1VxnKiLoagKl+6/Fet0IVHjKTc6o
        D6Zsa52kzoBny9TgT0jKrZ57h8Gv7E/O82Z/EVdDPw==
X-Google-Smtp-Source: APXvYqz6Yg0Od76mbVsDQlI0k8K6DbKwVfiDrSaTpfFp5q+PCSTQ1eGws3NXi4YS/T4PbMDYz5Ybi9rCLhP2rxR7gmA=
X-Received: by 2002:a37:e315:: with SMTP id y21mr42734614qki.233.1555055308682;
 Fri, 12 Apr 2019 00:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
 <777027ac-921e-ee37-493e-974b49242d18@gmail.com> <142fe2e3-b560-6136-32df-b14bb4ac46f7@gmail.com>
In-Reply-To: <142fe2e3-b560-6136-32df-b14bb4ac46f7@gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 12 Apr 2019 15:48:17 +0800
Message-ID: <CAD8Lp47yHMt-zYd02s3AgBDNQvRA5=Ccp4id8nTVHnQOtT+4_Q@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] platform/x86: asus-wmi: Support queued WMI event codes
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 1:44 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
> Event codes are expected to be polled from a queue on at least some
> models.

Maybe avoid the word "poll" since it suggests something else (at least to me).

> The fix flushes the old key codes out of the queue on load and after
> receiving event the queue is read until either ..FFFF or 1 is encountered.
>
> It might be considered a minor issue and no normal user would likely to
> observe this (there is little reason unloading the driver), but it does
> significantly frustrate a developer who is unlucky enough to encounter
> this.
>
> Introduce functionality for flushing and processing queued codes, which is
> enabled via quirk flag for ASUS7000. It might be considered if it is
> reasonable to enable it everywhere (might introduce regressions) or always
> try to flush the queue on module load and try to detect if this quirk is
> present in the future.
>
> This patch limits the effect to the specific hardware defined by ASUS7000
> device that is used for driver detection by vendor driver of Fx505. The
> fallback is also implemented in case initial flush fails.

Which vendor driver are you referring to here?

Researching more:
In our database of 144 Asus models, 142 of them have GANQ.

Of those 142, 9 of them return One in the empty-queue case. The other
133 match your FX505GM device exactly. So it seems valid to interpret
both 0xffff and 0x1 as queue-end markers.

The 2 devices that do not have GANQ are not laptops. They also do not
have the _UID "ATK" WMI device, they only have "ASUSWMI" and their WMI
_WED method does not use a queue.
There are a few more units that have both ASUSWMI and ATK devices, and
the ASUSWMI device appears to never be queued.
Another observation is that the ASUSWMI device works with notify code
0xD2, and the ATK device works with 0xFF.

Nailing this down a bit further, I found a DSDT for EEEPC X101H: that
one only has ASUSWMI and it is also not queued.

So I think you should make this queue behaviour applied more
generically, but either avoid it when the WMI device _UID is not "ATK"
(as discussed in the DCTS/DSTS thread), or avoid it when the notify
code is not 0xFF.

Thanks
Daniel
