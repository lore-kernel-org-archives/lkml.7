Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E01C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DC02064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nXecmtG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfHNUMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:12:22 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:41598 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbfHNUMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:12:22 -0400
Received: by mail-ot1-f44.google.com with SMTP id o101so934862ota.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=baesCGH/f6622nKyTt3pYuyj9GQL9uGRdAZgpKFE0pg=;
        b=nXecmtG4odunHeB6aXBTN0HKi7UMHEqpEKs1j6keLeZaCBgpHF5VklO2Y4bTIhuYGx
         77N5DKPerrlC7WllHf34rtrK33Zn5+cdKLrTE5yXuDNzXuPBSqoV/6xoM109pN+cAxpJ
         /CtREKnKJm5FlnkbSvYaSYJkw/K0E+GJcQ66g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=baesCGH/f6622nKyTt3pYuyj9GQL9uGRdAZgpKFE0pg=;
        b=uCyHz8BaMEX/Vg22OoVoC0bxDU1ZMXftqjZTNhVw2rTrcwer27uqfmiH+R1rMgnFgH
         Wa2ILQSKlwyUQZfCgHsnNFcYBd9QwCPHPIHKgPyBxOc7yWBrPULNwJBP8so0Yu/Tc7lB
         Srhv5BPQeh2GfgTXyQSK3pwxJyPgadX/5AY5oZeorhoyBgWgGLzwRpEEVxqf5yT2m39O
         br1UCcWwg65oT05Fog74ncAloaIh4lRduQmu8nc3i3YjD/YQFWV0HrkrX+tZK9+hJWsF
         0bjjfcG3mnJ3Fq/HHdhVHA4YKZRPoSPG14TiSAsd1wkXyXUn5TJ9smpI2DeGjyggeDDz
         lICA==
X-Gm-Message-State: APjAAAUo8wlpkvgmIRS7C39joTbCU7wWDICZ4N5HEHpwCd8X4tE/Ciio
        5sLw6E9Kam7uBEuWTyG2A1XzKSroUoM=
X-Google-Smtp-Source: APXvYqzeXVGJRAObmUlcXBdcHBCME877BW4RB3Zhmr/6NHER7hxTi2A+itOebSodsOk5JE7xWgGrJg==
X-Received: by 2002:a05:6830:1199:: with SMTP id u25mr651912otq.213.1565813540664;
        Wed, 14 Aug 2019 13:12:20 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id u16sm245556otk.53.2019.08.14.13.12.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2019 13:12:19 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id k22so5583937oiw.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 13:12:19 -0700 (PDT)
X-Received: by 2002:aca:56d2:: with SMTP id k201mr761220oib.171.1565813538728;
 Wed, 14 Aug 2019 13:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHX4x86QCrkrnPEfrup8k96wyqg=QR_vgetYLqP1AEa02fx1vw@mail.gmail.com>
 <20190813060249.GD6670@kroah.com>
In-Reply-To: <20190813060249.GD6670@kroah.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Wed, 14 Aug 2019 14:12:07 -0600
X-Gmail-Original-Message-ID: <CAHX4x87DbJ4cKuwVO3OS=UzwtwSucFCV073W8bYHOPHW8NiA=A@mail.gmail.com>
Message-ID: <CAHX4x87DbJ4cKuwVO3OS=UzwtwSucFCV073W8bYHOPHW8NiA=A@mail.gmail.com>
Subject: Re: Policy to keep USB ports powered in low-power states
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Kurtz <djkurtz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the fast response!

On Tue, Aug 13, 2019 at 12:02 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 12, 2019 at 06:08:43PM -0600, Nick Crews wrote:
> > Hi Greg!
>
> Hi!
>
> First off, please fix your email client to not send html so that vger
> does not reject your messages :)

Thanks, should be good now.

>
> > I am working on a Chrome OS device that supports a policy called "USB Power
> > Share," which allows users to turn the laptop into a charge pack for their
> > phone. When the policy is enabled, power will be supplied to the USB ports
> > even when the system is in low power states such as S3 and S5. When
> > disabled, then no power will be supplied in S3 and S5. I wrote a driver
> > <https://lore.kernel.org/patchwork/patch/1062995/> for this already as part
> > of drivers/platform/chrome/, but Enric Balletbo i Serra, the maintainer,
> > had the reasonable suggestion of trying to move this into the USB subsystem.
>
> Correct suggestion.
>
> > Has anything like this been done before? Do you have any preliminary
> > thoughts on this before I start writing code? A few things that I haven't
> > figured out yet:
> > - How to make this feature only available on certain devices. Using device
> > tree? Kconfig? Making a separate driver just for this device that plugs
> > into the USB core?
> > - The feature is only supported on some USB ports, so we need a way of
> > filtering on a per-port basis.
>
> Look at the drivers/usb/typec/ code, I think that should do everything
> you need here as this is a typec standard functionality, right?

Unfortunately this is for USB 2.0 ports, so it's not type-C.
Is the type-C code still worth looking at?

>
> thanks,
>
> greg k-h
