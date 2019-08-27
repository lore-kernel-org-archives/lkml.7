Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD104C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35F42184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="sInfPNmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbfH0NsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:48:10 -0400
Received: from vps.xff.cz ([195.181.215.36]:59392 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfH0NsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1566913686; bh=gUkiaA2UIAfdqLZqpz83L/LrKryHgSOsMfxD9p5JB0g=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=sInfPNmyAp81M2iQxMQJOE28y/Ho0Y8utaCVwSOeVpnZ9lPQ14QaOa5uVI27fnTN5
         cCVcd9Dz3wvLkYxGyn4l8FmgikPs9k0c3XzJpOfsBok90o5FCZbg8rkUf8Xk3wQBy7
         q+cBxetxCsNjEQRtNK/YhpgyExf19CKbEms/5oIM=
Date:   Tue, 27 Aug 2019 15:48:06 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: a64: pine64-plus: Add PHY
 regulator delay
Message-ID: <20190827134806.5l7dxyvzjrvabh7o@core.my.home>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20190825130336.14154-1-jernej.skrabec@siol.net>
 <20190827133443.fdxl5wjmgkerc3uh@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827133443.fdxl5wjmgkerc3uh@flea>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 27, 2019 at 03:34:43PM +0200, Maxime Ripard wrote:
> On Sun, Aug 25, 2019 at 03:03:36PM +0200, Jernej Skrabec wrote:
> > Depending on kernel and bootloader configuration, it's possible that
> > Realtek ethernet PHY isn't powered on properly. It needs some time
> > before it can be used.
> >
> > Fix that by adding 100ms ramp delay to regulator responsible for
> > powering PHY.
> >
> > Fixes: 94dcfdc77fc5 ("arm64: allwinner: pine64-plus: Enable dwmac-sun8i")
> > Suggested-by: Ondrej Jirman <megous@megous.com>
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> How was that delay found?

I suggested it. There's no delay in the dwmac-sun8i driver, so after enabling
the phy power, it will start accessing it over MDIO right away, which is not
good.

I suggested the value based on post-reset delay in the PHY's datasheet (30ms).
Multiplied ~3x (if I remember correctly) to get some safety margin. Chip has
more to do then after the HW reset, and regulator also needs some time to
ramp-up.

regards,
	o.

> It should at least have a comment explaining why it's there.
> 
> Thanks!
> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


