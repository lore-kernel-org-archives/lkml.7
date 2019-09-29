Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07803C32793
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 23:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D092120866
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 23:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgOkqUXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfI2XqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 19:46:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39539 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfI2XqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 19:46:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id n7so14704800qtb.6;
        Sun, 29 Sep 2019 16:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9IjuVXfjyC+Q3EgkfLoZRHzj7hful0PTkZcBqQey3BU=;
        b=WgOkqUXG/IOsCK1v46IkgYuvCCXlWivbA0/c8I3P1LW9SLM09h//IDxsINvCoNLie1
         d2uDzX0BimZmK66AyDUtq4ykya65Xw7IM43b5alZxJ6Bj4GSCxD/hznZReZ+zKZKcjnW
         32ER5J6DTGckGj+qW2ka0ox7QFqlyfL11PLQ6onHceTt7/mxI6u6G7ArnYeq9ad3PyZG
         fTePApuiq8DXfLot28KFYxlHH/PoJ4FZSJzGQPl5+gejE1YAeeSNrfgue6W8MbxenL3w
         0YHyQ/tlYHv2h/6F+e+b8mDM6hZXe+sEJBwENssePuU7yxUAt54Pmic+/221kiWZY6iy
         oUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9IjuVXfjyC+Q3EgkfLoZRHzj7hful0PTkZcBqQey3BU=;
        b=QYalZ82IQlTBOHYDrnrUPjrw7d2jCG+T7F1ARTCC4KfMtd3fsQQ/V6YK1YY60L01Wj
         eX0ZO5LV84JoE/5qhyN5+lWRlDHFc5XA9NeJOIk7kjSXzSKBFOocPThUWJi11cWTjxtr
         asucc3jBAwqIE18RIC086HPp+7SRQI+ypJps1EMFUi8HJjNcGaZ6aa7Y9XMRe6KuThXc
         x0LQcmdIgfjqtrcsmf/6PxmFw4wPBFZqNb9q/MlXOtix9A3VZffqciqVJhQHU8GE4XhN
         DnXcQndICANHUxqcMDaqoSiSKoJoB45pz8hLTLsBw99dpByUBoc96uNKhRVbuKn5nLG2
         NcJw==
X-Gm-Message-State: APjAAAWstWj7o94+EhvGKXkgdthMT63+/MOnCHEaPP/KA3uvgEiz3/6e
        JbpNdedSAZ24E4XXwz8ai/E=
X-Google-Smtp-Source: APXvYqxVMoPmFYQFR1uQ9s3WqrOhj1kuaz6jaF1gAqCSFqi7agIMTQouJhYavwt4z9geiH7wAvaCbg==
X-Received: by 2002:a0c:c48e:: with SMTP id u14mr18611626qvi.37.1569800779344;
        Sun, 29 Sep 2019 16:46:19 -0700 (PDT)
Received: from vivek-desktop (ool-457857f8.dyn.optonline.net. [69.120.87.248])
        by smtp.gmail.com with ESMTPSA id m14sm4585875qki.27.2019.09.29.16.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Sep 2019 16:46:18 -0700 (PDT)
Date:   Sun, 29 Sep 2019 19:46:15 -0400
From:   Vivek Unune <npcomplete13@gmail.com>
To:     Vicente Bergas <vicencb@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        ezequiel@collabora.com, akash@openedev.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix usb-c on Hugsun X99 TV Box
Message-ID: <20190929234615.GA5355@vivek-desktop>
References: <20190929032230.24628-1-npcomplete13@gmail.com>
 <54c67ca8-8428-48ee-9a96-e1216ba02839@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54c67ca8-8428-48ee-9a96-e1216ba02839@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 01:22:17PM +0200, Vicente Bergas wrote:
> On Sunday, September 29, 2019 5:22:30 AM CEST, Vivek Unune wrote:
> > Fix usb-c on X99 TV Box. Tested with armbian w/ kernel 5.3
> > 
> > Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> > b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> > index 0d1f5f9a0de9..c133e8d64b2a 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> > @@ -644,7 +644,7 @@
> >  	status = "okay";
> >  	u2phy0_host: host-port {
> > -		phy-supply = <&vcc5v0_host>;
> > +		phy-supply = <&vcc5v0_typec>;
> >  		status = "okay";
> >  	};
> > @@ -712,7 +712,7 @@
> >  &usbdrd_dwc3_0 {
> >  	status = "okay";
> > -	dr_mode = "otg";
> > +	dr_mode = "host";
> >  };
> >  &usbdrd3_1 {
> 
> Hi Vivek,
> 
> which is the relationship of your patch and this commit:
> 
> e1d9149e8389f1690cdd4e4056766dd26488a0fe
> arm64: dts: rockchip: Fix USB3 Type-C on rk3399-sapphire
> 
> with respect to this other commit:
> 
> c09b73cfac2a9317f1104169045c519c6021aa1d
> usb: dwc3: don't set gadget->is_otg flag
> 
> ?
> 
> I did not test reverting e1d9149e since c09b73cf was applied.
> 
> Regards,
>  Vicenç.
> 

Hi Vicenç,

Indeed, I was motivated by e1d9149e ("arm64: dts: rockchip: Fix USB3 
Type-C on rk3399-sapphire"). X99 TV box showed exact same symptoms
with usb-c port. After applying the fix, it worked.

I was not aware of c09b73cf ("usb: dwc3: don't set gadget->is_otg
 flag") and it will be interesting to test it. This might render
my fix unecessary.

Thanks,

Vivek

