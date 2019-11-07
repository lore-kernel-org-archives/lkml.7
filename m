Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A9DC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B922166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="TdvYPQSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKGVpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:45:17 -0500
Received: from vps.xff.cz ([195.181.215.36]:35650 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfKGVpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1573163114; bh=BGrAD8UvpxW4rw/cBqSRYppxgp0R9zi8fjyFRCWE9AY=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=TdvYPQSvv8h6dPQKJl5xiSdshpLt3NscKqvja8+fyZ9oAcxd+S4xpa4ZlpN3cWbsq
         uydGrZT0jN/CgxKm0d5n49fgiFkW2DTI0wY0cv59e7V0QBZp6Zm5wIhI0FhJ4jAq+i
         utioVXoDBiZLJSVKppU1aWh3cjKt0e7+QPBDMxxk=
Date:   Thu, 7 Nov 2019 22:45:14 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     arnd@arndb.de, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, icenowy@aosc.io, kishon@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, mark.rutland@arm.com,
        mripard@kernel.org, paul.kocialkowski@bootlin.com,
        robh+dt@kernel.org, tglx@linutronix.de, wens@csie.org
Subject: Re: [PATCH] phy: allwinner: Fix GENMASK misuse
Message-ID: <20191107214514.kcz42mcehyrrif4o@core.my.home>
Mail-Followup-To: Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        arnd@arndb.de, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, icenowy@aosc.io, kishon@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, mark.rutland@arm.com,
        mripard@kernel.org, paul.kocialkowski@bootlin.com,
        robh+dt@kernel.org, tglx@linutronix.de, wens@csie.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20191020134229.1216351-3-megous@megous.com>
 <20191107204645.13739-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107204645.13739-1-rikard.falkeborn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rikard,

On Thu, Nov 07, 2019 at 09:46:45PM +0100, Rikard Falkeborn wrote:
> Arguments are supposed to be ordered high then low.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
> Spotted while trying to add compile time checks of GENMASK arguments.
> Patch has only been compile tested.

thank you!

Tested-by: Ondrej Jirman <megous@megous.com>

regards,
	o.

>  drivers/phy/allwinner/phy-sun50i-usb3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c b/drivers/phy/allwinner/phy-sun50i-usb3.c
> index 1169f3e83a6f..b1c04f71a31d 100644
> --- a/drivers/phy/allwinner/phy-sun50i-usb3.c
> +++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
> @@ -49,7 +49,7 @@
>  #define SUNXI_LOS_BIAS(n)		((n) << 3)
>  #define SUNXI_LOS_BIAS_MASK		GENMASK(5, 3)
>  #define SUNXI_TXVBOOSTLVL(n)		((n) << 0)
> -#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(0, 2)
> +#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(2, 0)
>  
>  struct sun50i_usb3_phy {
>  	struct phy *phy;
> -- 
> 2.24.0
> 
