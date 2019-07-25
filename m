Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE49C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F326A2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR1Wx3yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387950AbfGYKl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:41:58 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:45799 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387725AbfGYKl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:41:57 -0400
Received: by mail-qt1-f182.google.com with SMTP id x22so43625010qtp.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pGiwvfWNKHPPhL2m3Y+ZU+k11VBWGFXZIJf18IlQWnc=;
        b=cR1Wx3yvjSP8ftL5qjLwcS3bydYdNBb9LbMe98teK2F5ipD3Njxpjc7WU14tCHa32d
         olU+kyMW/5PV5LF0V8BHY+d+2QN4JMTFkqIKMZNHmcQOsOUpXsfpNaqugUI6P6qqnLVN
         5BDvwdKYjwcce2Bi8hrccNAjjgyyPSqbYxPU3am29d9+SKZRD5W56rcmEpAzl4TmmQho
         XL+Wg2/j6LrxODMkDuMKvZw8v9yyHBkF+lhQx/lDcDWs/em7ghOKmCigO9HlPJbBWRyl
         wnFYR8QDShBTVHXs5YR6QywYgqUW9QOHLAv2on2+xBups8afqm9xjI3CS63d3SvrNq6R
         m9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pGiwvfWNKHPPhL2m3Y+ZU+k11VBWGFXZIJf18IlQWnc=;
        b=ovHsXHmhXFP50TfLHTELhJhkio7isQ3wOazrokD/QO0aimShQNX38iFZBk3nT3UyQM
         S3SuoKU8WmjOlzjzQdyjBzEPLI/Jf2N0KirhpTrnaom4BDcRTdOI5gF4xnEVA3jD5krz
         h3hLISoTNOPWSRNJas+NUCGT9NTlsGCfaPi7pXTeIPho1WJqQiE0FbJjti/IZk99ZpW3
         jQRZeQKVvxkxvLIJ8BDB9AiGftIbQLFlwQU6GLHMZivYaEWBP2+W/ntsLdlP8x3sc3JA
         wrmdtdtUiXC54AwI82wVzLU8BSEWMXltTLlhjQWzxThklHZhXZwyil8BN+7gXScsgU+Y
         PUAQ==
X-Gm-Message-State: APjAAAU1aW8WDxlEUqox5XSjAICgfz2n3Zc66+RuGBsLC4Im5lZU8Nwr
        on0wBhEkja0Zn/oFVRRMnC69SmRW5t2vOcyfVbyP/tBP
X-Google-Smtp-Source: APXvYqwaHdM+e7GM8T7UVUIfXaFJJXhhorDT6t3/u3D3jbmoxQUBcTM6AGxPfcCuVwnDboRA1w3b6OlNCMC+IJaVLBo=
X-Received: by 2002:ac8:540e:: with SMTP id b14mr56392763qtq.134.1564051316047;
 Thu, 25 Jul 2019 03:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAOKSTBs-cHMr7xbJVVUjZ9C3__bY6jZU-_TZ0RmMRMJ3dBk3PA@mail.gmail.com>
 <0c3f445d-1e37-1531-d3d5-f7ad75c58343@metux.net>
In-Reply-To: <0c3f445d-1e37-1531-d3d5-f7ad75c58343@metux.net>
From:   Gilberto Nunes <gilberto.nunes32@gmail.com>
Date:   Thu, 25 Jul 2019 07:41:19 -0300
Message-ID: <CAOKSTBsYLKGMDC8noaTVHf=S4U8UnXB0HfJpD5YRjVPHw8rEXA@mail.gmail.com>
Subject: Re: AMD Drivers
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     linux-kernel@vger.kernel.org,
        dri devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there

> What about other versions (eg. v4.19) ?
> Which is the last working version ?

The only series that works properly is 4.15.x

> Could you also try 5.3 ?
I will, ASAP!

>> Oh! By the way, the network card r8169 are work wonderful!
>Didn't you say (above) that it does not work ?
>Or is it just an immediate fail and later comes back ?

Well... I installed 5.2 and after reboot NIC works fine, but get stuck
with amdgpu again...
It's seems 5.x is in the right path... But still amdgpu has some bugs,
I think...

Thanks a lot for your coments


Best regards

Em qui, 25 de jul de 2019 =C3=A0s 04:22, Enrico Weigelt, metux IT consult
<lkml@metux.net> escreveu:
>
> On 24.07.19 16:17, Gilberto Nunes wrote:
>
> Hi,
>
> crossposting to dri-devel, as it smells like a problem w/ amdgpu driver.
>
> > CPU - AMD A12-9720P RADEON R7, 12 COMPUTE CORES 4C+8G
> > GPU - Wani [Radeon R5/R6/R7 Graphics] (amdgpu)
> > Network Interface card:
> > 01:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 12)
> >
> > When I install kernel 4.18.x or 5.x, the network doesn't work anymore..=
.
>
> What about other versions (eg. v4.19) ?
> Which is the last working version ?
>
> > I can loaded the modulo r8169 andr8168.
> > I saw enp1s0f1 as well but there's no link at all!
> > Even when I fixed the IP none link!
> > I cannot ping the network gateway or any other IP inside LAN!
> > Right now, I booted my laptop with kernel
> > Linux version 5.2.2-050202-generic (kernel@kathleen) (gcc version
> > 9.1.0 (Ubuntu 9.1.0-9ubuntu2)) #201907231250 SMP Tue Jul 23 12:53:21
> > UTC 2019
>
> Could you also try 5.3 ?
>
> > The system boot slowly, and I have a SSD Samsung, which in kernel
> > 4.15, boot quickly.
> > And there's many errors in dmesg command, like you can see in this past=
bin
> >
> > https://paste.ubuntu.com/p/YhbjnzYYYh/
>
> looks like something's wrong w/ reading gpu registers (more precisely
> waiting for some changing), that's causing the soft lockup. (maybe too
> big timeout ?)
>
> > Oh! By the way, the network card r8169 are work wonderful!
>
> Didn't you say (above) that it does not work ?
> Or is it just an immediate fail and later comes back ?
>
>
> --mtx
>
>
> --
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287
