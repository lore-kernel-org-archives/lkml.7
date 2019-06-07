Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601F4C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CC9208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Lfw9bJRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfFGGUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:20:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55877 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFGGUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:20:18 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190607062017euoutp02d83c0c48117818f81beaadf1cbc7e080~l1kA_G0Gl0099800998euoutp02s
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 06:20:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190607062017euoutp02d83c0c48117818f81beaadf1cbc7e080~l1kA_G0Gl0099800998euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559888417;
        bh=QWgR1Mag9DtnhNNTuCferod2c+G3wcu7+9hJRlFhyTc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Lfw9bJRyXqh9nGHRORNe2F1rezGjZHhqi8ec9X8txiuKHCYqCgn1LQ+pTEHOG23rk
         SttzdKSr0bbuLIoO4CVbbd40HOOhO24KRMX3rPhms2bwKZce/5MV4sN0BDeVeva2b4
         E9gmRvpi1ceS/c681yD5x/5PTQ9brJcdi1gqEurA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190607062016eucas1p13e01e39232b2e046b86020b06442914e~l1kARAACI3127831278eucas1p1l;
        Fri,  7 Jun 2019 06:20:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AA.D5.04325.0220AFC5; Fri,  7
        Jun 2019 07:20:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190607062015eucas1p2cc1e99f263d505335ece18465b09fc80~l1j-UwqW80138001380eucas1p2M;
        Fri,  7 Jun 2019 06:20:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190607062015eusmtrp1f5d6b43e61775a65f46adf09c386e0cd~l1j-FJLuw0816608166eusmtrp1Q;
        Fri,  7 Jun 2019 06:20:15 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-eb-5cfa0220a1a6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8D.2B.04146.F120AFC5; Fri,  7
        Jun 2019 07:20:15 +0100 (BST)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190607062014eusmtip29862da6c032a3c2305769c2fe4d67b16~l1j_ZQHn-0647806478eusmtip2V;
        Fri,  7 Jun 2019 06:20:14 +0000 (GMT)
Subject: Re: [PATCH v4 12/15] drm/bridge: tc358767: Introduce
 tc_pllupdate_pllen()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Archit Taneja <architt@codeaurora.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <45e628a7-6c99-7bd4-4e59-3add4b6c1eb0@samsung.com>
Date:   Fri, 7 Jun 2019 08:20:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607044550.13361-13-andrew.smirnov@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0gUYRTH+2ZmZ2at1XG19mBitV3oqpaRA5Vl9DAPPhj1YCXklpNZutqO
        WlaQrV221bwi4qppliQlaN5KjSgFp8hbqKGBF0rxUragbWrkmuMo+fY7/3POd/5/+Ghc3aZw
        o8P1MbxBr4vQkg5ETdNM66712J9g7+nfTmyi6SBrbEhQsEbTuIKd7mwk2HevRYzttFlJdiC/
        B2Pvpz+h2I66PJLt7XtPsGUFX8jDK7mOlAcYN5A1h3G1ll6KyzXlKLj+JBHjUme9ObH7JcZN
        VnhwrVktWKDylMOBUD4iPI43ePmFOFwobc6nou3uV+vtmxNQpcaMlDQwe2GuvYgwIwdazZQg
        GE4fweXiF4L2qdrFziSCvJ9WfGklo7NuceopgtRRMyUX4whGut9S0pQLcwKMdbYFdmUCYcJY
        S0qMMzYMOvqUEpPMNpit7JnXaVrF+MFdq6MkE8wmeFhSs3BsNRME/U3lColVjDN8yBkkJFYy
        h8Bcn0TIT66DxOpcXGYNfBkswCQ/wIxSYG0bRLLrozCTMkbK7AJjYhUlszt8zEwmZL4J/SW3
        cXnZhKC6vHYx8n5oFD8pJKP4vOmyOi9Z9gd7YSslycA4Qve4s+zBETJqsnFZVoHprlqe3gD9
        LdWLD2qguN1GpiGtZVkyy7I0lmVpLP/vFiLiGdLwsUJkGC/46PkrnoIuUojVh3mei4qsQPPf
        7KNdtL1Cb/6ebUAMjbSrVBw1E6xW6OKE+MgGBDSudVXFtU8Hq1WhuvhrvCHqjCE2ghca0Fqa
        0GpU11cMnFYzYboY/hLPR/OGpS5GK90SkKFPuUe88nmsqmn10GWXroEi+8nSonszG1948clH
        XNJTyR2Png2dOvkdvt3yKJ9q/bElwPw4JtPoxxZTTmm33xPDxRlcqXI4b414x3PrDddCn5Dt
        qqB9XfTOQn3z81Dh2PHmF9qJ7K8X05JX5WbOnS9ZmyBm2qx7oir8fX3zA8qqtYRwQbd7O24Q
        dP8AO2pLOWIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xe7ryTL9iDK4tE7Jo7rC1aDrUwGrR
        1PGW1eLHlcMsFgf3HGeyuPL1PZvFg7k3mSw6Jy5ht7i8aw6bxd17J1gs1s+/xebA7XG5r5fJ
        48HU/0weO2fdZfeY3TGT1eN+93Emj/6/Bh7Hb2xn8vi8Sc7j3NSzTAGcUXo2RfmlJakKGfnF
        JbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZa87MZS/4J1Ox+59qA+Nm
        8S5GTg4JAROJSVd2MXcxcnEICSxllJh5+AAjREJcYvf8t8wQtrDEn2tdbBBFrxkl7vXuZwFJ
        CAuESDTt+soOYosI+El0zTvA1MXIwcEs8J1J4iUfRP0xRom+71fA6tkENCX+br7JBlLDK2An
        0faeDyTMIqAiMW/FNrBdogIREmferwAr5xUQlDg58wmYzSlgL9G1uxvMZhZQl/gz7xIzhC0v
        0bx1NpQtLnHryXymCYxCs5C0z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefn
        bmIERu+2Yz8372C8tDH4EKMAB6MSD68Dw88YIdbEsuLK3EOMEhzMSiK8ZRd+xAjxpiRWVqUW
        5ccXleakFh9iNAV6biKzlGhyPjCx5JXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0t
        SC2C6WPi4JRqYOyZkb5GcYriZVaO+t2Z7M92eXwTFc1J3n/swcKepdv563+1m/5c0hGwskde
        olxke7/JxmfrhMsSjZSTjGq5gpvCXZeG8/9Vd/H4Gzr9b0Bua6vUx6hJeiU56qkLbz4LOpbh
        KrZqxhzGm/H7Zl/83N6Q37v7xdQ9RzvPqDm/uKg3dWHDptSZL5RYijMSDbWYi4oTAVF/Lu70
        AgAA
X-CMS-MailID: 20190607062015eucas1p2cc1e99f263d505335ece18465b09fc80
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607044647epcas1p4293a910d9ceea202cff1473c5cfe93b6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607044647epcas1p4293a910d9ceea202cff1473c5cfe93b6
References: <20190607044550.13361-1-andrew.smirnov@gmail.com>
        <CGME20190607044647epcas1p4293a910d9ceea202cff1473c5cfe93b6@epcas1p4.samsung.com>
        <20190607044550.13361-13-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.2019 06:45, Andrey Smirnov wrote:
> tc_wait_pll_lock() is always called as a follow-up for updating
> PLLUPDATE and PLLEN bit of a given PLL control register. To simplify
> things, merge the two operation into a single helper function
> tc_pllupdate_pllen() and convert the rest of the code to use it. No
> functional change intended.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>


I guess tc_pllupdate would be OK as well, but shorter.

Anyway:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


> Cc: Archit Taneja <architt@codeaurora.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index ac55b59249e3..c994c72eb330 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -443,10 +443,18 @@ static u32 tc_srcctrl(struct tc_data *tc)
>  	return reg;
>  }
>  
> -static void tc_wait_pll_lock(struct tc_data *tc)
> +static int tc_pllupdate_pllen(struct tc_data *tc, unsigned int pllctrl)
>  {
> +	int ret;
> +
> +	ret = regmap_write(tc->regmap, pllctrl, PLLUPDATE | PLLEN);
> +	if (ret)
> +		return ret;
> +
>  	/* Wait for PLL to lock: up to 2.09 ms, depending on refclk */
>  	usleep_range(3000, 6000);
> +
> +	return 0;
>  }
>  
>  static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
> @@ -546,13 +554,7 @@ static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
>  		return ret;
>  
>  	/* Force PLL parameter update and disable bypass */
> -	ret = regmap_write(tc->regmap, PXL_PLLCTRL, PLLUPDATE | PLLEN);
> -	if (ret)
> -		return ret;
> -
> -	tc_wait_pll_lock(tc);
> -
> -	return 0;
> +	return tc_pllupdate_pllen(tc, PXL_PLLCTRL);
>  }
>  
>  static int tc_pxl_pll_dis(struct tc_data *tc)
> @@ -626,15 +628,13 @@ static int tc_aux_link_setup(struct tc_data *tc)
>  	 * Initially PLLs are in bypass. Force PLL parameter update,
>  	 * disable PLL bypass, enable PLL
>  	 */
> -	ret = regmap_write(tc->regmap, DP0_PLLCTRL, PLLUPDATE | PLLEN);
> +	ret = tc_pllupdate_pllen(tc, DP0_PLLCTRL);
>  	if (ret)
>  		goto err;
> -	tc_wait_pll_lock(tc);
>  
> -	ret = regmap_write(tc->regmap, DP1_PLLCTRL, PLLUPDATE | PLLEN);
> +	ret = tc_pllupdate_pllen(tc, DP1_PLLCTRL);
>  	if (ret)
>  		goto err;
> -	tc_wait_pll_lock(tc);
>  
>  	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1, 1000);
>  	if (ret == -ETIMEDOUT) {
> @@ -914,15 +914,13 @@ static int tc_main_link_enable(struct tc_data *tc)
>  		return ret;
>  
>  	/* PLL setup */
> -	ret = regmap_write(tc->regmap, DP0_PLLCTRL, PLLUPDATE | PLLEN);
> +	ret = tc_pllupdate_pllen(tc, DP0_PLLCTRL);
>  	if (ret)
>  		return ret;
> -	tc_wait_pll_lock(tc);
>  
> -	ret = regmap_write(tc->regmap, DP1_PLLCTRL, PLLUPDATE | PLLEN);
> +	ret = tc_pllupdate_pllen(tc, DP1_PLLCTRL);
>  	if (ret)
>  		return ret;
> -	tc_wait_pll_lock(tc);
>  
>  	/* Reset/Enable Main Links */
>  	dp_phy_ctrl |= DP_PHY_RST | PHY_M1_RST | PHY_M0_RST;


