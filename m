Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E41EC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F4C218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbfDXJcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:32:36 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44023 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfDXJcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:32:35 -0400
Received: by mail-vk1-f193.google.com with SMTP id d30so2063231vkl.10;
        Wed, 24 Apr 2019 02:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYsocJ7uF78j1Uf7U89zOhsLlQNU46x1CcuW1tTWcpo=;
        b=mLJO8RoPZ7HwClafimlvKYK+du+KEM2XAHa67tDtucHKsUtzwVWDZAbJmbYufRK/2A
         PnruRJHW/3ALN7WWE/v4XFlTYCvETT/rtG0pcXnsAsJiCl6RhYYrSPZekTGObrgXzjeX
         k1eD72ZyBzCs+8+WZoy76CFTLwCxqYExUTv/VHp7KhZFlU2Guf0BkDRpp41H1BxA2YKI
         RXcVf018DGDN/Y5sgPQGGERB1BTiDnO2pShldkCmfhW/yvB5Ry9GS/gPAm9N638eLSep
         iqyl5lSE9ldEF2ZuIFnBgdp8z4iM93CODNGYeWLIpIgtIMfrcYksuxGLfu7dcCdU5Rc8
         yjeg==
X-Gm-Message-State: APjAAAW9S87hkLbLzHDTeWzd8xqk6OYMYaRGrYJzsKep3rPheEP1uLh3
        8+MUwFHYnwMCZosgMSg5odex7zihsfjvHg79Wbk=
X-Google-Smtp-Source: APXvYqwp+5/74K+/HL9NnSrck8crG12GYqhgKWZQvw4ssq9zUHg8QF5tXh9RSNFciPnwWAbb6XGiqyy7Nioxn5ybWZ8=
X-Received: by 2002:ac5:c383:: with SMTP id s3mr16505133vkk.65.1556098354362;
 Wed, 24 Apr 2019 02:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190414110933.30529-1-wsa+renesas@sang-engineering.com>
 <VI1PR10MB23525523F623FFAC4126EBC9FE2B0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <20190415092853.GA1861@kunai> <VI1PR10MB23520D64B2120138FF64D0BBFE2B0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <VI1PR10MB23520D64B2120138FF64D0BBFE2B0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 Apr 2019 11:32:23 +0200
Message-ID: <CAMuHMdXX_OT9soypArNwqkVYTjiTM890qAvp8ZYHaOh9bW5wgg@mail.gmail.com>
Subject: Re: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value, too
To:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        LINUX RENESAS SOC <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, Apr 15, 2019 at 12:10 PM Steve Twiss
<stwiss.opensource@diasemi.com> wrote:
> On 15 April 2019 10:29, Wolfram Sang wrote:
> > Subject: Re: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value, too
> > On Mon, Apr 15, 2019 at 08:11:16AM +0000, Steve Twiss wrote:
> > > On 14 April 2019 12:10, Wolfram Sang wrote:
> > >
> > > > Tested with a Renesas Lager board (R-Car H2, DA9063AD)
> > >
> > > Can I please check there is no mistake in your description. I have been repeatedly
> > > told by the hardware engineers here, (for the past 6 years) it is not possible.
> > > But, you seem to have an R-Car H2 with the AD silicon version of DA9063?
> >
> > I am confused, what is not possible? That I have an AD version? Yes, we
> > found that out when we worked on the RTC recently.
>
> Sure, I know, people have been requesting continued support for DA9063 AD silicon
> for years. The original DA9063 Linux driver was sent to LKML with AD support.
>
> > It is an early version of the Lager development board. I have no numbers
> > but my assumption is there are not too many out there.
>
> Thanks, yes, there is interest from the hardware engineers here. Thanks for the
> confirmation about your board. I will inform them about the DA9063 AD silicon on
> the Renesas Lager board -- and I will let you know their response.

For the record, I see the following DA9063 variants on the Renesas boards I have
access to:
  - DA9063 AD: Lager (R-Car H2), Koelsch (R-Car M2-W),
  - DA9063 BB: Gose (R-Car M2-N), Blanche (R-Car V2H), Alt (R-Car E2).

I cannot check Porter (R-Car M2-W) and Silk (R-Car E2) right now, but
from Marek's report, Porter has DA9063L CA.

Marek: which variant does your Stout (R-Car H2) have?

Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
