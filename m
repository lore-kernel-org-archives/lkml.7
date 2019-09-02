Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66769C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B3B217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567424332;
	bh=OpXxr+BU7p7KY33dk2QGMbECJ2xkRL8tD6em4euS+OI=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=khPufJnSlzsKJ9rB3H7R/gvCvvsNXx2C01twcgon61AoOlUCbtUI29nKLxczr6D9E
	 WvWvcXeyVigJE2OWn+X5BIIRDLOZM9RJxBscTJ3Bbg1R+yjNm7i2b/CPUHJUUZoZ1P
	 j37i7izqUmhfflI9h/9rHxq3FLsmeq8hN0zVPN7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfIBLiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 07:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfIBLiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 07:38:50 -0400
Received: from localhost (smbhubinfra01.hotspot.hub-one.net [213.174.99.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01F0A217F4;
        Mon,  2 Sep 2019 11:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567424329;
        bh=OpXxr+BU7p7KY33dk2QGMbECJ2xkRL8tD6em4euS+OI=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=khYckrjHLYrPNF+DLRGhNBfCjgMQqqQsWK1NB5KuaWlopBlWjd5X8T5z04GamgAQV
         R51kwjGe2B1t45Vbg1E53IvO8NaEf4VreaDhzYn2gmdvytiRmD6KW9ohqmZsF6MIlk
         prJ2BS0EdCXdFPirFpAfjg639HJgdJD56kA0givg=
Date:   Mon, 2 Sep 2019 13:38:46 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: a64: pine64-plus: Add PHY
 regulator delay
Message-ID: <20190902113846.752jdgr3czywuieh@flea>
References: <20190825130336.14154-1-jernej.skrabec@siol.net>
 <20190827133443.fdxl5wjmgkerc3uh@flea>
 <20190827134806.5l7dxyvzjrvabh7o@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190827134806.5l7dxyvzjrvabh7o@core.my.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 03:48:06PM +0200, Ond=C5=99ej Jirman wrote:
> Hi,
>
> On Tue, Aug 27, 2019 at 03:34:43PM +0200, Maxime Ripard wrote:
> > On Sun, Aug 25, 2019 at 03:03:36PM +0200, Jernej Skrabec wrote:
> > > Depending on kernel and bootloader configuration, it's possible that
> > > Realtek ethernet PHY isn't powered on properly. It needs some time
> > > before it can be used.
> > >
> > > Fix that by adding 100ms ramp delay to regulator responsible for
> > > powering PHY.
> > >
> > > Fixes: 94dcfdc77fc5 ("arm64: allwinner: pine64-plus: Enable dwmac-sun=
8i")
> > > Suggested-by: Ondrej Jirman <megous@megous.com>
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > How was that delay found?
>
> I suggested it. There's no delay in the dwmac-sun8i driver, so after enab=
ling
> the phy power, it will start accessing it over MDIO right away, which is =
not
> good.
>
> I suggested the value based on post-reset delay in the PHY's datasheet (3=
0ms).
> Multiplied ~3x (if I remember correctly) to get some safety margin. Chip =
has
> more to do then after the HW reset, and regulator also needs some time to
> ramp-up.

That sounds reasonable, can you add that as a comment?

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
