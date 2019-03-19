Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4B9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A2720989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552965465;
	bh=r1bpamU2rdNoCAO0e4/OKYhnRUEy6VlTBSv3ZDpF2h0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LBra0MuaK0D/5efVxafFPngrPJS1tAlyEBCPzce6JwUQTwq5OLPO4lby80qjiy8KA
	 F+Fg+ia1epVVzxaXiN7aOKkf7NbwziWH8WOFroS9EU5H5J1VZihA4jphJngKqVu4B4
	 vrErX/nm7kVYgwlYfvJsmTTD16uETrAHRhJ+Sc8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfCSDRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfCSDRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:17:44 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E0472173C;
        Tue, 19 Mar 2019 03:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552965463;
        bh=r1bpamU2rdNoCAO0e4/OKYhnRUEy6VlTBSv3ZDpF2h0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nXBo/aN7NckNWn6pHjtt1nokQGotWinIM19ZoZ5MVZLH1Ej4QeAFJkCTx3TpSP4V1
         d2b+zx+UuReSKmpyIMTMJhMdvX1IYUFKP0iNs6KMSdtvaisf2BUSWeWC4XqaiRAlbH
         ZJTNv+0oum7oj8tOHqfVtR94PUDCf+d0+hSGT4tI=
Received: by mail-wr1-f41.google.com with SMTP id j9so5148883wrn.6;
        Mon, 18 Mar 2019 20:17:43 -0700 (PDT)
X-Gm-Message-State: APjAAAU834CZ1UBkvNIv3DblHMDBVPSQOG2BF1qK8/FomY3RwfeCRgQ6
        qhJEN28IpsFmN3vRJX47Lq40gwzxNn2AzfY2Umo=
X-Google-Smtp-Source: APXvYqydL8YkbAbEpn4Zi5u+FKtVT0v/pqAjf6neaf4q5fQX5j49G2o9ybKv4+xFCCeeEqtIRdusgAfzAhAU/Qq785k=
X-Received: by 2002:a5d:458f:: with SMTP id p15mr175087wrq.188.1552965461722;
 Mon, 18 Mar 2019 20:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190318073354.12151-1-wens@kernel.org> <20190318073354.12151-7-wens@kernel.org>
 <8e9ef57f-1d24-b151-f8a4-812b7bb65388@sholland.org>
In-Reply-To: <8e9ef57f-1d24-b151-f8a4-812b7bb65388@sholland.org>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 19 Mar 2019 11:17:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v64HJX+2rC14OEPgBSc61h-8KCAthdyY05xTuquKYTfsRA@mail.gmail.com>
Message-ID: <CAGb2v64HJX+2rC14OEPgBSc61h-8KCAthdyY05xTuquKYTfsRA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 6/6] ARM: dts: sunxi: h3/h5: Add device node
 for SID
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 9:55 AM Samuel Holland <samuel@sholland.org> wrote:
>
> On 03/18/19 02:33, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > The device tree binding already lists compatible strings for these two
> > SoCs. Add a device node for them.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  arch/arm/boot/dts/sun8i-h3.dtsi              | 4 ++++
> >  arch/arm/boot/dts/sunxi-h3-h5.dtsi           | 5 +++++
> >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 4 ++++
> >  3 files changed, 13 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> > index 959d265e7254..e37c30e811d3 100644
> > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> > @@ -231,3 +231,7 @@
> >  &rtc {
> >       compatible = "allwinner,sun8i-h3-rtc";
> >  };
> > +
> > +&sid {
> > +     compatible = "allwinner,sun8i-h3-sid";
> > +};
> > diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> > index d74a6cbbfdf4..e2100b673a51 100644
> > --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> > +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> > @@ -227,6 +227,11 @@
> >                       #size-cells = <0>;
> >               };
> >
> > +             sid: eeprom@1c14000 {
> > +                     /* compatible and clocks are in per SoC .dtsi file */
>
> There are no clocks for this node, just a compatible string.

Right. I'll fix this when applying.

ChenYu
