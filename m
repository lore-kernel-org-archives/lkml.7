Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4285CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238D022CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfH1Nq7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:46:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45724 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfH1Nq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:46:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id x19so45308eda.12;
        Wed, 28 Aug 2019 06:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zyNoxyVItTkE7KkpzOzDQs+Ze+MdA8PTrGpUeQ6qzjg=;
        b=a+LRiAunB7YSQbIrYOSvaFDmH2xgyHMf1bOdE3qB30z6nZA7gxcr9YLo4AnMyWcTbO
         o1cemcVmAuoXO3kdxLQU74/fhbYAA5vB555JkMNBxtjpidDq6J9OkmZ6or5/thMFTVdH
         7Bzon90JFiytHIBarS2xJO1MFdbjK53XnhVN5OuYr0gcog8yLsCa2lFvDWpbfVot9RPW
         SGK/wrX+j2V3+f7X1Sder6MArpxDepF+Bb6GLqekuCgDedpjS+EAQEfrJLQEpMaGSfJw
         uZMvpl+lSoE+SxNrnY24n8lDMiv+YccNThH72A6W+Tu5xNRgM6pH1K66RV0wlFb0o6sK
         lF1A==
X-Gm-Message-State: APjAAAW47dfYpp3Xzm6zMfrlLfTFbU4YquXKiK8cPcEDqO67Ufe+IYmf
        1wVCuITit1s8SKs7mFImu2pZM/oOBU4=
X-Google-Smtp-Source: APXvYqzGGR54H/3chozR6MXep8XidX9GVefLA56aH5jB+4Zx5Lu5GiU+AbMknH0QlsY7p5vBGLOvUg==
X-Received: by 2002:aa7:dac9:: with SMTP id x9mr4110101eds.271.1567000014749;
        Wed, 28 Aug 2019 06:46:54 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id h2sm473102edr.16.2019.08.28.06.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 06:46:54 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id u16so2617563wrr.0;
        Wed, 28 Aug 2019 06:46:53 -0700 (PDT)
X-Received: by 2002:a5d:568e:: with SMTP id f14mr4694015wrv.167.1567000013782;
 Wed, 28 Aug 2019 06:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
 <CACRpkdazfe3gJr6Q+X05GzxPuKtUg0M780SPA_oR5bd+-xBPvA@mail.gmail.com>
 <CAGb2v67e8EiS-LUuhAyPc57nWd4iOBEWC_SZbH801Lzi4QWGyg@mail.gmail.com> <20190828134334.qzuwodoxmw7ov5yg@flea>
In-Reply-To: <20190828134334.qzuwodoxmw7ov5yg@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 28 Aug 2019 21:46:43 +0800
X-Gmail-Original-Message-ID: <CAGb2v67hS1a2iNJYgc97vwpg6hZwxjoxRhdMb5PjHmMrOC1jNA@mail.gmail.com>
Message-ID: <CAGb2v67hS1a2iNJYgc97vwpg6hZwxjoxRhdMb5PjHmMrOC1jNA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH] mmc: sunxi: fix unusuable eMMC on some
 H6 boards by disabling DDR
To:     Maxime Ripard <mripard@kernel.org>
Cc:     =?UTF-8?Q?Alejandro_Gonz=C3=A1lez?= 
        <alejandro.gonzalez.correo@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 9:43 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Wed, Aug 28, 2019 at 09:29:32PM +0800, Chen-Yu Tsai wrote:
> > On Wed, Aug 28, 2019 at 8:52 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > On Sun, Aug 25, 2019 at 5:06 PM Alejandro González
> > > <alejandro.gonzalez.correo@gmail.com> wrote:
> > >
> > > > Jernej Skrabec compared the BSP driver with this
> > > > driver, and found that the BSP driver configures pinctrl to operate at
> > > > 1.8 V when entering DDR mode (although 3.3 V operation is supported), while
> > > > the mainline kernel lacks any mechanism to switch voltages dynamically.
> >
> > AFAIK The Pine H64 does not have the ability to switch I/O voltages. It is
> > fixed to either 1.8V (the default based on the schematics) or 3.3V.
>
> Should that be handled at the board level then maybe?

Yeah. You'd specify which one using vqmmc-supply in the mmc node and
vcc-pc-supply
in the pinctrl node.

ChenYu
