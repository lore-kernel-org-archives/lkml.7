Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FB8C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3AA12133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbfJDVpY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:45:24 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38072 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfJDVpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:45:23 -0400
Received: from 94.112.246.102.static.b2b.upcbusiness.cz ([94.112.246.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iGVNt-0006sD-N6; Fri, 04 Oct 2019 23:45:09 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Vivek Unune <npcomplete13@gmail.com>
Cc:     Vicente Bergas <vicencb@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, ezequiel@collabora.com, akash@openedev.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix usb-c on Hugsun X99 TV Box
Date:   Fri, 04 Oct 2019 23:45:08 +0200
Message-ID: <2223294.9I8gkMH88G@phil>
In-Reply-To: <20190929234615.GA5355@vivek-desktop>
References: <20190929032230.24628-1-npcomplete13@gmail.com> <54c67ca8-8428-48ee-9a96-e1216ba02839@gmail.com> <20190929234615.GA5355@vivek-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

Am Montag, 30. September 2019, 01:46:15 CEST schrieb Vivek Unune:
> On Sun, Sep 29, 2019 at 01:22:17PM +0200, Vicente Bergas wrote:
> > On Sunday, September 29, 2019 5:22:30 AM CEST, Vivek Unune wrote:
> > > Fix usb-c on X99 TV Box. Tested with armbian w/ kernel 5.3
> > > 
> > > Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> > > b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> > > index 0d1f5f9a0de9..c133e8d64b2a 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> > > @@ -644,7 +644,7 @@
> > >  	status = "okay";
> > >  	u2phy0_host: host-port {
> > > -		phy-supply = <&vcc5v0_host>;
> > > +		phy-supply = <&vcc5v0_typec>;
> > >  		status = "okay";
> > >  	};
> > > @@ -712,7 +712,7 @@
> > >  &usbdrd_dwc3_0 {
> > >  	status = "okay";
> > > -	dr_mode = "otg";
> > > +	dr_mode = "host";
> > >  };
> > >  &usbdrd3_1 {
> > 
> > Hi Vivek,
> > 
> > which is the relationship of your patch and this commit:
> > 
> > e1d9149e8389f1690cdd4e4056766dd26488a0fe
> > arm64: dts: rockchip: Fix USB3 Type-C on rk3399-sapphire
> > 
> > with respect to this other commit:
> > 
> > c09b73cfac2a9317f1104169045c519c6021aa1d
> > usb: dwc3: don't set gadget->is_otg flag
> > 
> > ?
> > 
> > I did not test reverting e1d9149e since c09b73cf was applied.
> > 
> > Regards,
> >  Vicenç.
> > 
> 
> Hi Vicenç,
> 
> Indeed, I was motivated by e1d9149e ("arm64: dts: rockchip: Fix USB3 
> Type-C on rk3399-sapphire"). X99 TV box showed exact same symptoms
> with usb-c port. After applying the fix, it worked.
> 
> I was not aware of c09b73cf ("usb: dwc3: don't set gadget->is_otg
>  flag") and it will be interesting to test it. This might render
> my fix unecessary.

So I'll let this patch sit here for now.
Once you've done the testing, can you please respond with the
result (both positive and negative results please).

Thanks
Heiko


