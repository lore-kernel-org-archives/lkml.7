Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02E5C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3B220882
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQH8RxmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfG3H7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:59:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34505 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfG3H7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:59:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so23407871pgc.1;
        Tue, 30 Jul 2019 00:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uFAlrmOoAl8QPQdLLMxuBk418ZCFdTVKi3BcwvDs0DE=;
        b=iQH8RxmOMF5875eeVO3Da2rdPhB9lA11lpzfN+ZfJVN6bm6r3rR50pnI5vhkCm7k+g
         SUMsV8rxeWoqmqKfla+d0wSLqBH9tkHZw8vYjdrAlyn92qrZDyQS0SMIymzafGxM+aJY
         P/NqNF9VN0J2K5ZXFK9p3H7ihv69ui83yfoKZmK2tvmkyDVcZzCTXGvmHYjBZDwDhv+B
         pspDjFP0Wcqd+CTawX04gl/d4KuzyPfRUZoOsvFWOF5/chtuOm/0ngK0rJrd7bSwrxJO
         jyiETiHeMJA+L81L9x6Qx272zjSzcoU2tjxj8SZfGBBVk78EjwO3ldCfct6uJJ38Sb5P
         9tZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uFAlrmOoAl8QPQdLLMxuBk418ZCFdTVKi3BcwvDs0DE=;
        b=EB6FDH3NNKzpITmfSsZ1elLJQSmHw5Zw5PT0yn+w5H1zwpE9GAV5KvM15F0Jc290hL
         X9jLwY+4cQpDniSbdbe5s3GgtRG4glkLCEjYwX3ruFEzzI8WIghkHr9qmT8JRCV64Mwx
         tVhzn9r8U/mTV2fRDRYZE3j+RYT5XCiHLR1WE5u1HcsqvYZi3Qr1E47RTw8/VB8pqgvr
         sMkpwAjX8PuclpFYKd6H4RB/PHykWtjHL6A5f08FWXU8uqK//6ZSVaVGhhR+nJLWUF7W
         TIT1XqN6RdxGZUQ51olr4+yXxY7DpQ56nyIHI7vGNS6g0fjAgOepinYO81GRWpOuG6YB
         HwSw==
X-Gm-Message-State: APjAAAWkqWzSOvNk5/nlctcCiMT9u/A5g0V5JvoEOr5p8URWUJXmkwZp
        s6Smagf5gQzvv0v5ZYrWRrc=
X-Google-Smtp-Source: APXvYqwzj4cH6/cG01FQ79ISBwq4FGUEBV1C6SsIzTEU3Ib99EXqnyks6RgcY8HCH6FCulwOfpSo5A==
X-Received: by 2002:a63:e213:: with SMTP id q19mr106419831pgh.180.1564473584219;
        Tue, 30 Jul 2019 00:59:44 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id 33sm74160050pgy.22.2019.07.30.00.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 00:59:43 -0700 (PDT)
Date:   Tue, 30 Jul 2019 00:59:35 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Timur Tabi <timur@kernel.org>, Rob Herring <robh@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mihai Serban <mihai.serban@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [alsa-devel] [PATCH v2 1/7] ASoC: fsl_sai: Add registers
 definition for multiple datalines
Message-ID: <20190730075934.GA5892@Asurada>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
 <20190728192429.1514-2-daniel.baluta@nxp.com>
 <20190729194214.GA20594@Asurada-Nvidia.nvidia.com>
 <CAEnQRZDmnAmgUkRGv3V5S7b5EnYTd2BO5NFuME2CfGb1=nAHzQ@mail.gmail.com>
 <20190729202001.GC4787@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729202001.GC4787@sirena.org.uk>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 09:20:01PM +0100, Mark Brown wrote:
> On Mon, Jul 29, 2019 at 10:57:43PM +0300, Daniel Baluta wrote:
> > On Mon, Jul 29, 2019 at 10:42 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > > On Sun, Jul 28, 2019 at 10:24:23PM +0300, Daniel Baluta wrote:
> 
> > > > @@ -704,7 +711,14 @@ static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
> > > >       case FSL_SAI_TCR3:
> > > >       case FSL_SAI_TCR4:
> > > >       case FSL_SAI_TCR5:
> > > > -     case FSL_SAI_TFR:
> > > > +     case FSL_SAI_TFR0:
> 
> > > A tricky thing here is that those SAI instances on older SoC don't
> > > support multi data lines physically, while seemly having registers
> > > pre-defined. So your change doesn't sound doing anything wrong to
> > > them at all, I am still wondering if it is necessary to apply them
> > > to newer compatible only though, as for older compatibles of SAI,
> > > these registers would be useless and confusing if being exposed.
> 
> > > What do you think?
> 
> > Yes, I thought about this too. But, I tried to keep the code as short
> > as possible and technically it is not wrong. When 1 data line is supported
> > for example application will only care about TDR0, TFR0, etc.
> 
> So long as it's safe to read the registers (you don't get a bus error or
> anything) I'd say it's more trouble than it's worth to have separate
> regmap configuations just for this.  The main reasons for restricting
> readability are where there's physical problems with doing the reads or
> to keep the size of the debugfs files under control for usability and
> performance reasons.

Thanks for the input, Mark.

Daniel, did you get a chance to test it on older SoCs? At least
nothing breaks like bus errors?
