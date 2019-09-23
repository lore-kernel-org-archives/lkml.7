Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F07C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B7220B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aSk1Ypud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbfIWRNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 13:13:02 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39524 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfIWRNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:13:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id s22so12808014otr.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 10:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ue6UnAozTnXqTHe4q9S72zUseEDYm3ZUpXLtLXdgahc=;
        b=aSk1Ypud7KXulZTThvAKp8fC1VTr2a6gU6cPi5hjPCn2EnoE8iRrXmCpI8fsuK8wAf
         /pZ2UPQpCAkdSQ1JUV2IOU7FaF0P3AAavBotdSKACYXf5euLG4d5/e41WucJGwq3CeRP
         bYboSwGPMNvWV2/kMDdgev2p+k2BeYCNaqD30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ue6UnAozTnXqTHe4q9S72zUseEDYm3ZUpXLtLXdgahc=;
        b=fPv/Y0lXxKhvFdoDLX6lYkHknvW2/xHDPNPeRGA8i28b76LbwQA4ppHW3UWCSZ2hJ7
         ZizNohBDvucUgQfqly4x1S4f5cptc4Cp3S0FCLrchOjl1gH4mqXilKiuQ5e2ST2FNRPM
         J7Dtc8hWwXMEG/OZa/1fGAmdJZtjq8Ja/3lahuPxXhdRoJ7Bsn6rHHiHgD9P2EPgkGQC
         AkyNICAwWLpIi+qZd2+4NLTDVtONxgjksn319wuBG2WQOrFLJwTszkjxqI049+W7hA/c
         E7Hiqv3AATlHrPKU/FH1BxM/SWDNCivST/zW2ghWiozWaFvdZj/CHOPv98FkKJtRNx0s
         v/Gg==
X-Gm-Message-State: APjAAAUf6B6mpYkODFbQwo91BiJXHVVaZcNYS51C2SMlfcWjx24D3wEV
        XGIuAPFozc6pX/fJdLw7LlTHM1K0IhE=
X-Google-Smtp-Source: APXvYqzHj4/2vahWwsNi7wFYHF5/5pMrJmE0sd6xDGw6ejY+K75vCTabmvCu/eFmVp8UIh+Kd18/cg==
X-Received: by 2002:a9d:3476:: with SMTP id v109mr750250otb.179.1569258781121;
        Mon, 23 Sep 2019 10:13:01 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id l30sm4020359otl.74.2019.09.23.10.12.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 10:12:59 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id g13so12794644otp.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 10:12:59 -0700 (PDT)
X-Received: by 2002:a9d:5f8d:: with SMTP id g13mr784888oti.268.1569258779445;
 Mon, 23 Sep 2019 10:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190916181215.501-1-ncrews@chromium.org> <20190916181215.501-2-ncrews@chromium.org>
 <20190922202947.GA4421@bug> <20190922204353.GD3185@piout.net>
In-Reply-To: <20190922204353.GD3185@piout.net>
From:   Nick Crews <ncrews@chromium.org>
Date:   Mon, 23 Sep 2019 11:12:48 -0600
X-Gmail-Original-Message-ID: <CAHX4x86-fhzSqn_OLAkFy_FkoQQTMgtR5K5evJ56YTYZeU-7dA@mail.gmail.com>
Message-ID: <CAHX4x86-fhzSqn_OLAkFy_FkoQQTMgtR5K5evJ56YTYZeU-7dA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rtc: wilco-ec: Fix license to GPL from GPLv2
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Benson Leung <bleung@chromium.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would you like me to change this patch at all? Perhaps reference
bf7fbeeae6db in the commit description? I probably should have
done that since the beginning, I just couldn't find bf7fbeeae6db at first.

Thanks,
Nick

On Sun, Sep 22, 2019 at 2:43 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 22/09/2019 22:29:48+0200, Pavel Machek wrote:
> > On Mon 2019-09-16 12:12:17, Nick Crews wrote:
> > > Signed-off-by: Nick Crews <ncrews@chromium.org>
> > > ---
> > >  drivers/rtc/rtc-wilco-ec.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> > > index e84faa268caf..951268f5e690 100644
> > > --- a/drivers/rtc/rtc-wilco-ec.c
> > > +++ b/drivers/rtc/rtc-wilco-ec.c
> > > @@ -184,5 +184,5 @@ module_platform_driver(wilco_ec_rtc_driver);
> > >
> > >  MODULE_ALIAS("platform:rtc-wilco-ec");
> > >  MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
> > > -MODULE_LICENSE("GPL v2");
> > > +MODULE_LICENSE("GPL");
> > >  MODULE_DESCRIPTION("Wilco EC RTC driver");
> >
> > File spdx header says GPL-2.0, this change would make it inconsistent with that...
> >
>
> Commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
> bogosity") doesn't agree with you (but I was surprised too).
>
>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
