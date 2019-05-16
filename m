Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAA1C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2D4205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="vCowvd26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfEPRKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 13:10:54 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54816 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfEPRKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:10:54 -0400
Received: by mail-it1-f196.google.com with SMTP id a190so7350847ite.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5EwJksJ2FoQVnQI0xcmWd22xXK+H+BAMsUpI/Bz70Ko=;
        b=vCowvd26w29wqEIEqcsiaPf/EuWN6j87GJLMX9br2vStXOBGTGzRN91ItAb+LaOQov
         WcIXvg/Iss7UD0wf5R5taBEu6nJBnNMi+b2EvVfphRMPAV7l3DPtO/ZQ4xLQxMug0O51
         +wlBD8vh1YTVeBBuA7q+6GY3HFwyoDWpZb6UAD1b4xhql5PGYneQIxHyH0Vs//sbyOS8
         cPDxc784vau+PgeWv7Bexo+t3xJ/DR+CBS23VizH8X8qRN3V0s51vabU1T1LbJsPW0tC
         6t4stv8bRxm0XZEuXUKnbQs7Xy8Tn5OTo92cVwgFjEVkqscPGTS5R1T9qb1Fh4QetsuM
         Up4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5EwJksJ2FoQVnQI0xcmWd22xXK+H+BAMsUpI/Bz70Ko=;
        b=jBNzy4f/AVhyNB1ecrZbXvVw42f4NZuRY9D7csq/7fVnnRAYaCe8rqKzUPqcUCcIpP
         NotraNSQWlehmJVoU8tWhtdv2WReochtykbKWjVaBqqZvKCF9Yln8G61OIfqedMsBTNn
         wUqry7WwxozXyN/4uAoosoRDfkTsnCzdS9U3RhJtH17ACZun2/1xG2Ij8KnefSR+W3Ig
         7XM+Tq9o42g6mHm9oYEdY9yazZrrPEltBV1z08p2vXP8Ccd77GrvU+zgdjp/WgLuuCrI
         Uxn4e1FBjVXRoxWG46aIU1ywWwmVdFPvUau2bxYRkT1xZeKyEUSYDTLayNnym4pSk5TL
         crJA==
X-Gm-Message-State: APjAAAVweFP+aXHt7zIrHDZtoVQWvet0mjE3tJGZ5xgcM8Ec2C7SzSRW
        h5JoYcIk6eC23YofzBcwYKgzqCR5t0HIu6ytLpi7/g==
X-Google-Smtp-Source: APXvYqzz59DMUAjZfEHs6VQoL3fmXQV164OUtAdl/v/4z6/H+c+fWkLi7UOzh0Zmnp7mXm/7gNJcsov+/59rFuOfTFM=
X-Received: by 2002:a24:70ca:: with SMTP id f193mr13222240itc.103.1558026653421;
 Thu, 16 May 2019 10:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190516064304.24057-1-olof@lixom.net> <20190516064304.24057-2-olof@lixom.net>
 <CAHk-=wj7uZ+rLecwEP+U3jRRPWRoB1QVTr8pHzTcmQadE=Ngvg@mail.gmail.com> <CAK8P3a27zgq3c_iWHVfypAc-hLag06Bs=Q2D7bn4i4nVfPQSyw@mail.gmail.com>
In-Reply-To: <CAK8P3a27zgq3c_iWHVfypAc-hLag06Bs=Q2D7bn4i4nVfPQSyw@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Thu, 16 May 2019 10:10:41 -0700
Message-ID: <CAOesGMgQ9kF08PDzA3LSjsXt-ETB8vAnqo2EjtbKEMJ5UrnJnw@mail.gmail.com>
Subject: Re: [GIT PULL 1/4] ARM: SoC platform updates
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        ARM SoC <arm@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 8:53 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, May 16, 2019 at 5:34 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, May 15, 2019 at 11:43 PM Olof Johansson <olof@lixom.net> wrote:
> > >
> > > SoC updates, mostly refactorings and cleanups of old legacy platforms=
.
> > > Major themes this release:
> >
> > Hmm. This brings in a new warning:
> >
> >   drivers/clocksource/timer-ixp4xx.c:78:20: warning:
> > =E2=80=98ixp4xx_read_sched_clock=E2=80=99 defined but not used [-Wunuse=
d-function]
> >
> > because that drivers is enabled for build testing, but that function
> > is only used under
> >
> >   #ifdef CONFIG_ARM
> >         sched_clock_register(ixp4xx_read_sched_clock, 32, timer_freq);
> >   #endif
> >
> > It's not clear why that #ifdef is there. This driver only builds
> > non-ARM when COMPILE_TEST is enabled, and that #ifdef actually breaks
> > that build test.
> >
> > I'm going to remove that #ifdef in my merge, because I do *not* want
> > to see new warnings, and it doesn't seem to make any sense.
> >
> > Maybe that's the wrong resolution, please holler and let me know if
> > you want something else.
>
> As far as I can tell, that is the best fix, thanks for the cleanup!

Yeah, this was entirely on me -- it was found and fixed on linux-next,
and Linus Walleij sent patches. However, as I was staging these pull
requests, I applied them to a branch of fixes that I'm collecting for
later this week instead of on top of the one I was sending.

Thanks for fixing it up.


-Olof
