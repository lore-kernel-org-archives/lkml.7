Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9375EC4360C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 00:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D27222C7
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 00:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9r4usZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfJEAwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 20:52:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46761 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfJEAwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 20:52:06 -0400
Received: by mail-qt1-f196.google.com with SMTP id u22so11032653qtq.13;
        Fri, 04 Oct 2019 17:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4kfrSx9pecxmKTopMM3H10hlWnjEzdS6486P99JMZic=;
        b=A9r4usZDZI1XYmdWnzVDPjU28NFB618J3iWHmZTBuy82f9U3ecTW2gbZdbInrcGzjq
         fh5weVuLHOJQh3ffu4wX0tY03UT4iIYplzkz8+AdtxDomM4W9SXNj5GVzewfAaobZHII
         VMvttb3S/h9tbr/warC36/gJYESQvrSa9kA3qOn90t2DREceaqkikAiiGYnidiulC0TH
         0j09D0Ta+TUUb1pwj1X9t+SiC4vMXpcgzdBSeb0MCpfoFpQ6GP83lrw3T9RWLiy6RCCZ
         lLnGsLenLxLGq5ul+nxXGy9KWX5XuE0YaYza/7kh9NXDBVjeuawDVIXPts7DnaOHK1nH
         ipSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4kfrSx9pecxmKTopMM3H10hlWnjEzdS6486P99JMZic=;
        b=OI6+EKgMo4C+5qqi33zdwKHOtOrjHvg0imDWvLQN7OLfisKyQyYoWtRa9NbwM8Kqu1
         qkgsptMGxHqFNIF9sKOTuwEmgMu2MdnsTCEVneXpYL/BtBkweiejNg9DCrAxmtUt6a7s
         4nEkawuff3bSr9Fv4gDhgvCLyh/cLb8us+8DBy9vB9EVW3kTn8/Up7YZYaQ2Z+byqN+b
         0phEVc2gy3nQbBj1/s5Ig3SJSmznQ2zruL46PukqAJfaQqu4PuCFA6aFDvmgNZjtqqD5
         WzvCgSZIWSc+R9IQULCmKVgG5QjUZB9JIbqBGwWtk1G2j5Yfgaf0Nn5rMJI5mT6KA62I
         QahQ==
X-Gm-Message-State: APjAAAVOKIvFJlChuy6zBkIUkttp/1S5o/rb7ozWUNh0IEkVC9sfxQqg
        PR3/9E/cSAfcNtLP6Hyt7yg=
X-Google-Smtp-Source: APXvYqxe2v6jRShlgbNxkPA59YDigb42WrFKwpnJxW+Hl+XUgwGuTXMhgBPuZ2LJ/loDpT2Bd3iI7g==
X-Received: by 2002:ad4:40c8:: with SMTP id x8mr16740235qvp.227.1570236725160;
        Fri, 04 Oct 2019 17:52:05 -0700 (PDT)
Received: from vivek-desktop (ool-457857f8.dyn.optonline.net. [69.120.87.248])
        by smtp.gmail.com with ESMTPSA id k2sm3492216qti.24.2019.10.04.17.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 17:52:04 -0700 (PDT)
Date:   Fri, 4 Oct 2019 20:52:00 -0400
From:   Vivek Unune <npcomplete13@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Vicente Bergas <vicencb@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, ezequiel@collabora.com, akash@openedev.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix usb-c on Hugsun X99 TV Box
Message-ID: <20191005005200.GA11418@vivek-desktop>
References: <20190929032230.24628-1-npcomplete13@gmail.com>
 <54c67ca8-8428-48ee-9a96-e1216ba02839@gmail.com>
 <20190929234615.GA5355@vivek-desktop>
 <2223294.9I8gkMH88G@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2223294.9I8gkMH88G@phil>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 11:45:08PM +0200, Heiko Stuebner wrote:
> Hi Vivek,
> 
> Am Montag, 30. September 2019, 01:46:15 CEST schrieb Vivek Unune:
> > On Sun, Sep 29, 2019 at 01:22:17PM +0200, Vicente Bergas wrote:
> > > On Sunday, September 29, 2019 5:22:30 AM CEST, Vivek Unune wrote:
> > > > Fix usb-c on X99 TV Box. Tested with armbian w/ kernel 5.3
> > > > 
> > > > Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> > > > ---
> > > >  arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> > > > b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> > > > index 0d1f5f9a0de9..c133e8d64b2a 100644
> > > > --- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> > > > +++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> > > > @@ -644,7 +644,7 @@
> > > >  	status = "okay";
> > > >  	u2phy0_host: host-port {
> > > > -		phy-supply = <&vcc5v0_host>;
> > > > +		phy-supply = <&vcc5v0_typec>;
> > > >  		status = "okay";
> > > >  	};
> > > > @@ -712,7 +712,7 @@
> > > >  &usbdrd_dwc3_0 {
> > > >  	status = "okay";
> > > > -	dr_mode = "otg";
> > > > +	dr_mode = "host";
> > > >  };
> > > >  &usbdrd3_1 {
> > > 
> > > Hi Vivek,
> > > 
> > > which is the relationship of your patch and this commit:
> > > 
> > > e1d9149e8389f1690cdd4e4056766dd26488a0fe
> > > arm64: dts: rockchip: Fix USB3 Type-C on rk3399-sapphire
> > > 
> > > with respect to this other commit:
> > > 
> > > c09b73cfac2a9317f1104169045c519c6021aa1d
> > > usb: dwc3: don't set gadget->is_otg flag
> > > 
> > > ?
> > > 
> > > I did not test reverting e1d9149e since c09b73cf was applied.
> > > 
> > > Regards,
> > >  Vicenç.
> > > 
> > 
> > Hi Vicenç,
> > 
> > Indeed, I was motivated by e1d9149e ("arm64: dts: rockchip: Fix USB3 
> > Type-C on rk3399-sapphire"). X99 TV box showed exact same symptoms
> > with usb-c port. After applying the fix, it worked.
> > 
> > I was not aware of c09b73cf ("usb: dwc3: don't set gadget->is_otg
> >  flag") and it will be interesting to test it. This might render
> > my fix unecessary.
> 
> So I'll let this patch sit here for now.
> Once you've done the testing, can you please respond with the
> result (both positive and negative results please).
> 
> Thanks
> Heiko
> 
> 

Hi Heiko,

I tested the c09b73cf patch without modifying exsisting dts. I can confirm
that that patch doesn't work for me. No usb-c devices were recognized.

Vicenç - were you able to test it?

As soon as I apply dts patch, usb-c devices are recognized.

Thanks,

Vivek
