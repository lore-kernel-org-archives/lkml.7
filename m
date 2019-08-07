Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DA3C31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F97620679
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0Q2zH5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfHGBL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 21:11:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37753 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfHGBL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:11:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id b3so38602753plr.4;
        Tue, 06 Aug 2019 18:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dp8mvh65KHuF+NgUue69yu5lshqxJ1qu1kFOwYukDzQ=;
        b=W0Q2zH5Eprm6HfAF1fdlZeg3FTPVQ9TRhGBsVbp+mOBva0lMNGOLCHaBDt6AKQ3p37
         0jD4YFEALVWroS5uWoipALMLbTG54RhU+pCS83a0cGwPdKV8rTtyvVCzTX0kVTQRnawX
         +kg4Uie4N5pipPiCFLuw5Clt90kaPo5kLbZfixFvoK04bOcBzJtlbXd1lhnhVlXAbgBI
         mo2EUXbnLragIb/ILMFUJSCU9ap2Pbb/M5AdWAElCHh2vy+Sm6L6AvAT9w8V6OZhn3ab
         rVusdBK/uJ6qUcSxcaWMyXTaAEqq256lDIpDBCbCedJlwUx0Ka911OCJnyO+uL5t/Yxz
         an8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dp8mvh65KHuF+NgUue69yu5lshqxJ1qu1kFOwYukDzQ=;
        b=TMuYbzwRFMiOGywGH19qHMUG71NQXCs8n9KDapIjiPwkpW4dNOVaqRTBx7TksCGFkL
         ql79j839m7oKBfxP8mwoS/ZQMTmQph/MF4EeUyHGI/Ro7PohHWNWIWBYLzWxBbha1uAd
         3iA/GvgCsFS4Ow10psfZFmtGedscs57jn1gWLZOCFrFEoIlutB1e8jGxUz5p8/Aq9eQi
         EiHUMADI4cshXKoHUOiGMNJtaWCXWmr3EUiLPkmBA3nwqNbW4DERXBZXx6EUyLSNWFZu
         T3Zy3XmDJX5267G8kDrSLs2Qc72nibDv8DStnVApO3kv9JQN+oqzLiZu6DxFDOTX7bsF
         Dk7Q==
X-Gm-Message-State: APjAAAWBep9etgj9y3zq43ohgg3InTby8vo1fInx+cnLVHCEyZbSgvkl
        NEaZaWT08xwcCSV5rfmUP4I=
X-Google-Smtp-Source: APXvYqyRZhIFjUquoFklw1N6uzzmYgLKw2zn7k7U5o1DoBKZiOMqffr7P9u+UWpRR1/gHtBZTFkxPA==
X-Received: by 2002:a17:902:8d97:: with SMTP id v23mr5649791plo.157.1565140288366;
        Tue, 06 Aug 2019 18:11:28 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id w2sm78210147pgc.32.2019.08.06.18.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 18:11:28 -0700 (PDT)
Date:   Tue, 6 Aug 2019 18:12:23 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
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
Message-ID: <20190807011222.GB8938@Asurada-Nvidia.nvidia.com>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
 <20190728192429.1514-2-daniel.baluta@nxp.com>
 <20190729194214.GA20594@Asurada-Nvidia.nvidia.com>
 <CAEnQRZDmnAmgUkRGv3V5S7b5EnYTd2BO5NFuME2CfGb1=nAHzQ@mail.gmail.com>
 <20190729202001.GC4787@sirena.org.uk>
 <20190730075934.GA5892@Asurada>
 <CAEnQRZBpQPoi5OH--c=ubKYc6B3rspmVnb846UTFW7P5SE62ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZBpQPoi5OH--c=ubKYc6B3rspmVnb846UTFW7P5SE62ww@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 02:15:03PM +0300, Daniel Baluta wrote:
> On Tue, Jul 30, 2019 at 10:59 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Mon, Jul 29, 2019 at 09:20:01PM +0100, Mark Brown wrote:
> > > On Mon, Jul 29, 2019 at 10:57:43PM +0300, Daniel Baluta wrote:
> > > > On Mon, Jul 29, 2019 at 10:42 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > > > > On Sun, Jul 28, 2019 at 10:24:23PM +0300, Daniel Baluta wrote:
> > >
> > > > > > @@ -704,7 +711,14 @@ static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
> > > > > >       case FSL_SAI_TCR3:
> > > > > >       case FSL_SAI_TCR4:
> > > > > >       case FSL_SAI_TCR5:
> > > > > > -     case FSL_SAI_TFR:
> > > > > > +     case FSL_SAI_TFR0:
> > >
> > > > > A tricky thing here is that those SAI instances on older SoC don't
> > > > > support multi data lines physically, while seemly having registers
> > > > > pre-defined. So your change doesn't sound doing anything wrong to
> > > > > them at all, I am still wondering if it is necessary to apply them
> > > > > to newer compatible only though, as for older compatibles of SAI,
> > > > > these registers would be useless and confusing if being exposed.
> > >
> > > > > What do you think?
> > >
> > > > Yes, I thought about this too. But, I tried to keep the code as short
> > > > as possible and technically it is not wrong. When 1 data line is supported
> > > > for example application will only care about TDR0, TFR0, etc.
> > >
> > > So long as it's safe to read the registers (you don't get a bus error or
> > > anything) I'd say it's more trouble than it's worth to have separate
> > > regmap configuations just for this.  The main reasons for restricting
> > > readability are where there's physical problems with doing the reads or
> > > to keep the size of the debugfs files under control for usability and
> > > performance reasons.
> >
> > Thanks for the input, Mark.
> >
> > Daniel, did you get a chance to test it on older SoCs? At least
> > nothing breaks like bus errors?
> 
> Tested on imx6sx-sdb, everything looks good. No bus errors.

Okay. Let's just stick to it then. Thanks for the reply.
