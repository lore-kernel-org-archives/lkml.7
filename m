Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB36C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0AB20B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQnUfgvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbfHFLPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:15:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39643 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbfHFLPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:15:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so65697922wmc.4;
        Tue, 06 Aug 2019 04:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=amZcTjeg2x25Ly20jxoyFkWiF2cVUUckbhD3XaV8CIk=;
        b=FQnUfgvdPoIaacu03nWzCLZh7LUWsPG7bapZSLjOOzwKSYC6AdHtxqvXBOkPjMUZIj
         H7zyVRoz52ffJ1x+zVECR6Rm0EKZ8RYbezzws79i3hKpc0isQl+v373gQ40VYVxgk1P2
         m+MLWeapgBAsYTXHixu7lT+fVh9rMxG9fb+4oraUtrJqoJsjvSmnvL0OPEvZifmOi2bf
         JJF+Jj/WvDX2Hln4YZFG64XJN+ZVPrja+1ag266P5CVWEXXAiJnqQifJ3jit7fidrYPS
         K/miwVXjovaevzTpriHzeAeZ9FM9CRPciNwdtc61Y554FGEcRnJTJjrqmZWiEJfv4AA5
         CZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=amZcTjeg2x25Ly20jxoyFkWiF2cVUUckbhD3XaV8CIk=;
        b=LrXbb7tPg8RX5ILLLtXev5wdV7Lr7eVsWM2IkC7OW5nNeCaok+9OU7MRGGbdV4OurV
         4DBr31FgP9D4WZqFIBrWeWaIUEB/WH5CEltHhN/stocjXti5xLyiSIi4oUnjMifCVZlz
         lZlcHwsWjWvTZ+Q56Ut4DJxniLfGHRqpwwCt1sqbC1G0jLlmtjnLNp9tJ4LHfCQd7mCE
         WoRs5gImuC+AbwB7XD2j6MJv4CNX9jix+JeYSDZ5CiAi5AGek9apK4wbTTvZ+01E4bCq
         08KC7PFmhwXTY3tevJyozMSeSYSbQwoxnDq34j4xJsnK6+stSIHMltfZRugxyA07sfvb
         Kqag==
X-Gm-Message-State: APjAAAWMtybRElMgp4kPt+mkovfyXAjbje5XBJZSXVfSefXS15i/6feE
        fp2UQcx/Jd2XQL87veHrorZyBU1vIiLs3tvwNFk=
X-Google-Smtp-Source: APXvYqxDUUjK9kCtDTeW4zcHyR9oQz/tY0Uj9nlsukUlv9LRJgi2lCZaSGGROaqAgAkZK2BHu73O8MUaJvhH449DU7o=
X-Received: by 2002:a1c:18d:: with SMTP id 135mr4246358wmb.171.1565090114880;
 Tue, 06 Aug 2019 04:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190728192429.1514-1-daniel.baluta@nxp.com> <20190728192429.1514-2-daniel.baluta@nxp.com>
 <20190729194214.GA20594@Asurada-Nvidia.nvidia.com> <CAEnQRZDmnAmgUkRGv3V5S7b5EnYTd2BO5NFuME2CfGb1=nAHzQ@mail.gmail.com>
 <20190729202001.GC4787@sirena.org.uk> <20190730075934.GA5892@Asurada>
In-Reply-To: <20190730075934.GA5892@Asurada>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 6 Aug 2019 14:15:03 +0300
Message-ID: <CAEnQRZBpQPoi5OH--c=ubKYc6B3rspmVnb846UTFW7P5SE62ww@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/7] ASoC: fsl_sai: Add registers
 definition for multiple datalines
To:     Nicolin Chen <nicoleotsuka@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 10:59 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Jul 29, 2019 at 09:20:01PM +0100, Mark Brown wrote:
> > On Mon, Jul 29, 2019 at 10:57:43PM +0300, Daniel Baluta wrote:
> > > On Mon, Jul 29, 2019 at 10:42 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > > > On Sun, Jul 28, 2019 at 10:24:23PM +0300, Daniel Baluta wrote:
> >
> > > > > @@ -704,7 +711,14 @@ static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
> > > > >       case FSL_SAI_TCR3:
> > > > >       case FSL_SAI_TCR4:
> > > > >       case FSL_SAI_TCR5:
> > > > > -     case FSL_SAI_TFR:
> > > > > +     case FSL_SAI_TFR0:
> >
> > > > A tricky thing here is that those SAI instances on older SoC don't
> > > > support multi data lines physically, while seemly having registers
> > > > pre-defined. So your change doesn't sound doing anything wrong to
> > > > them at all, I am still wondering if it is necessary to apply them
> > > > to newer compatible only though, as for older compatibles of SAI,
> > > > these registers would be useless and confusing if being exposed.
> >
> > > > What do you think?
> >
> > > Yes, I thought about this too. But, I tried to keep the code as short
> > > as possible and technically it is not wrong. When 1 data line is supported
> > > for example application will only care about TDR0, TFR0, etc.
> >
> > So long as it's safe to read the registers (you don't get a bus error or
> > anything) I'd say it's more trouble than it's worth to have separate
> > regmap configuations just for this.  The main reasons for restricting
> > readability are where there's physical problems with doing the reads or
> > to keep the size of the debugfs files under control for usability and
> > performance reasons.
>
> Thanks for the input, Mark.
>
> Daniel, did you get a chance to test it on older SoCs? At least
> nothing breaks like bus errors?

Tested on imx6sx-sdb, everything looks good. No bus errors.
