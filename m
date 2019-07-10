Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E904AC74A25
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF18C20651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562766644;
	bh=BAkUJjbt16QmJo5dgfrz95vBRU7FG87R0fS1o5ZT8KY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Eir1W4NnTsRE93kHVof5/rl5P3am1I2WtL3etxk0NNU508Zi3UIsipYN6s5Q/7OpF
	 neKA3CAM5IDzMziE2HAinus1dI8Gjn23/nD/hu3Ek8cdLCb24al8zeW8QQaCVavb8l
	 VWuaO0BNiccTQl+spmzrGKXzSy1Nc+drLwx7RYO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfGJNun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfGJNun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:50:43 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 313C5208E4;
        Wed, 10 Jul 2019 13:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562766642;
        bh=BAkUJjbt16QmJo5dgfrz95vBRU7FG87R0fS1o5ZT8KY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kS1q2SBNDqfDxOT5fhNxw2JPlBAhO2F8+BGrMWgxC4E+G7wdF1PMeVXKASi5Gqdb5
         hzFtQfwBaSwBpBsm0QcJhayGQbD0IaIrEcMt3HFIB872S/E6fb1eetdaF7STkr6qtq
         wp+j4+qTAwJod/Qg7IGsVmEsjze4iph9q5OcPp8U=
Received: by mail-qk1-f172.google.com with SMTP id v22so1897839qkj.8;
        Wed, 10 Jul 2019 06:50:42 -0700 (PDT)
X-Gm-Message-State: APjAAAWTojJ1CH4GGe44WipKANQrrqzMxIbBSJ9aQ/fXWMKSWfa51M0H
        cFlTFmof8cGgvz/T8ElMz6lPvREub+qw1yGX4A==
X-Google-Smtp-Source: APXvYqzqcyHECUE8Dw6jw3/udA2D+zm3IIa+/nL9hdsG+Jcrsvvf8zl/zsy5GkeSWvYskt3SEh1F3f67UnbWQyNMo3w=
X-Received: by 2002:a37:a010:: with SMTP id j16mr24177941qke.152.1562766641368;
 Wed, 10 Jul 2019 06:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <1560280855-18085-1-git-send-email-luis.oliveira@synopsys.com>
 <1560280855-18085-5-git-send-email-luis.oliveira@synopsys.com>
 <20190709142000.GA995@bogus> <MN2PR12MB371024C55C5B48A91EECE7A0CBF10@MN2PR12MB3710.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB371024C55C5B48A91EECE7A0CBF10@MN2PR12MB3710.namprd12.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 10 Jul 2019 07:50:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJVfcrQBOgMK_iNYOZpEMfWcjS=_j++LPyu7bnLinMpfw@mail.gmail.com>
Message-ID: <CAL_JsqJVfcrQBOgMK_iNYOZpEMfWcjS=_j++LPyu7bnLinMpfw@mail.gmail.com>
Subject: Re: [v4 4/6] dt-bindings: phy: Document the Synopsys MIPI DPHY Rx bindings
To:     Luis de Oliveira <Luis.Oliveira@synopsys.com>
Cc:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 10:29 AM Luis de Oliveira
<Luis.Oliveira@synopsys.com> wrote:
>
> From: Rob Herring <robh@kernel.org>
> Date: Tue, Jul 09, 2019 at 15:20:00
>
> > On Tue, Jun 11, 2019 at 09:20:53PM +0200, Luis Oliveira wrote:
> > > Add device-tree bindings documentation for SNPS DesignWare MIPI D-PHY in
> > > RX mode.
> > >
> > > Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
> > > ---
> > > Changelog
> > > v3-v4
> > > - @Laurent I know I told you I could remove the snps,dphy-frequency on V3 but
> > >   it is really useful for me here. I removed all other the proprietary
> > >   properties except this one. Do you still think it must be removed?
> > > - Frequency units @Rob
> >
> > Frequency units means append '-khz' to the property name. That also
> > makes the 'frequency' part redundant, so maybe name it more around what
> > the frequency is. The frequency for what?
> >
> > Rob
> >
>
> This is the D-PHY high speed frequency configuration that corresponds to
> the high speed data transfer of the bus.
> Basically is the transmission speed per lane.
> Do you think I can use "link-frequencies" (present in
> video-interfaces.txt) with one frequency?

Seems reasonable.

Rob
