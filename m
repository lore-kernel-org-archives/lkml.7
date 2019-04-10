Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CC0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB642084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN+MTAes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfDJGhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:37:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42039 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfDJGhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:37:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id cv12so767948plb.9;
        Tue, 09 Apr 2019 23:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z15Euzi/7W0xWj7RGm8EBO4XV8u51E2URV+Tg7QcB44=;
        b=fN+MTAesy2a1t5HT9VEilFzdZlCXei702B7CZP5CB6t93Rh4kelOvfhXaH153fOE3s
         x9g6qn9pzt2KwJ/l7k4clHhr9GRq2XyzB7LP2wRSDnGMiuI+aM2b3tH5evkrr6DvkRUj
         MedJjeOydOUof6pnSfEzK+0VmRxl9zmT6q+q1pQjqfSELg+/QcilVWNlceGYMqdZf3il
         Pi7X0HIK6K7K2by7bDscJN0KKzrEI0MNRNq1oNwyaPxiWXVLgRTQW1g6Iz1K+bgxIWT2
         zHSspKyJJHEOciQbocPf2cIUv1JaqJNMGaGB07d/qzOZ/TUSZVZ8SNidCfY8oblJoo+p
         GVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z15Euzi/7W0xWj7RGm8EBO4XV8u51E2URV+Tg7QcB44=;
        b=jMs0PjhVhRa9L3z3qnYXoJt6I9arZQONHF4R4kg3C8FLr7S4sZztg+IR9slpgr83Ae
         08LXDqi21+FXnREMqIa7odPsWrdJGejEP0G5s+mqmQjp98a+sxbRgbETYllPLCYt4m07
         iaeIyhPBt1aMgFMwPPkwva6/qlHVmqSadjfKi6BFHAg2hw2KWryMhsfmU2MuOe+WwD+X
         f6qwyIfbqKM1y8tJeFhxwE0EUJnJACsMi6ajvY2A5ZVhE3mEvrq02cFFJdMoU7k2nIHG
         /Dg5f8SOUDxw6179+pVWFaRHcPP2xn+RzUVc3MnmCqnznx4yk+UT5bU93LCy4sFJgUcz
         Ajvw==
X-Gm-Message-State: APjAAAX3+MKfrIeeRAThD/ZLXRTM2nfyXeznBqcP+bjfk0R2cMwaXSe1
        CJEx7li4Al+NmLUjWXvh4Hk=
X-Google-Smtp-Source: APXvYqzOQ+Lu5lRGswb5Z2P63WBfRUX8mHoz+s2loSkaKvwV6H4Mbw7THqFtMSlONX7MfN0SJPM6cg==
X-Received: by 2002:a17:902:3183:: with SMTP id x3mr42274620plb.170.1554878240246;
        Tue, 09 Apr 2019 23:37:20 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id 143sm69811465pge.50.2019.04.09.23.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 23:37:20 -0700 (PDT)
Date:   Tue, 9 Apr 2019 23:37:14 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Viorel Suman <viorel.suman@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Viorel Suman <viorel.suman@gmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: fsl_audmix: remove "model"
 attribute
Message-ID: <20190410063714.GA4156@Asurada>
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-2-git-send-email-viorel.suman@nxp.com>
 <20190410042906.GC3032@Asurada>
 <CAEnQRZBDSrpje2-ML0zr+oJkwMbbkxV5hUNc_HzZtPZv-et8mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZBDSrpje2-ML0zr+oJkwMbbkxV5hUNc_HzZtPZv-et8mA@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 09:20:29AM +0300, Daniel Baluta wrote:
> Hi Nicolin,
> 
> On Wed, Apr 10, 2019 at 7:30 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Tue, Apr 09, 2019 at 11:27:39AM +0000, Viorel Suman wrote:
> > > Use "of_device_id.data" to specify the machine driver
> > > instead of "model" DTS attribute.
> > >
> > > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> >
> > Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> >
> > > ---
> > >  sound/soc/fsl/fsl_audmix.c | 43 +++++++++++++++++++++++--------------------
> > >  1 file changed, 23 insertions(+), 20 deletions(-)
> >
> > > +     priv->pdev = platform_device_register_data(&pdev->dev, mdrv, 0, NULL,
> > > +                                                0);
> >
> > Would you please send a separate patch to replace "pdev->dev"?
> 
> I am not sure exactly how to explain this change in the commit message. It does
> make code easier to read and avoids dereferencing pdev pointer each time.
> 
> Is it enough for commit description?

You mean this? https://lore.kernel.org/patchwork/patch/862610/
