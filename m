Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBC4C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C0221479
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnMbF78z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfIKSo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 14:44:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36269 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbfIKSo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 14:44:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so14282341pfr.3;
        Wed, 11 Sep 2019 11:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TqRe5lHOX4M4V547/WzO3Xh0zpwoYhwfsfhLh4/QmNw=;
        b=cnMbF78zIN2X9zEOosJXsLy6lBLW8nW1rFohkwPEIwEa6uF/WOsmr2xAEaCVe9SAaN
         i7+2cu7+E+HD86A9dgw7KnHv3DgSkf6MbdVO6kYHFHGtBoMfaXxiHoGeuuUYZoXnYMZY
         Ekg3XH3c4rxVxhQhmfQv/GmEOMWlbMfF3zq/YKsRPvNNmuh+7DmnXbZDJakCr3JItly7
         E/L6ZmHXOf49bDukg+osrL8HBIaUPKtSIS4xFCHloTkspkUpLF4eXYWTwugwaG0JCCW0
         hiovc2vqED7iGDoHu2Ad6HClqB4Wpnka75/Wpcf8D3WPpKG4j8ii4SVkKr6u3WFJeoyc
         0Vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TqRe5lHOX4M4V547/WzO3Xh0zpwoYhwfsfhLh4/QmNw=;
        b=MnMGdjcDifEe/3XJJvLL22t94wfRVYEu9C9reGnG+P5OetVVt8TycdUPSikygzkZHe
         4mclQpCsiWaxAutzBIixigRuwgLN2LA7YqlTcsIJAep1pVxsDJi5tiotLi0U8WEWGfFh
         Xzo6QUCot01JP5SxL0EnXHuM71UIf/jDoczTAk4l81WFsDhS9CxXoBdK9ZAWttL/F3OU
         uekx72wtdG7cbYG9BxQ5kN25jfDxzG7YWSxYzPy9HRXt6snvy6YoURWPS8BzqwZerqUR
         Xa3aIPSe3GScootZhVvf1fjEh7FxSvlB+Cm52Q1F2RD5mzslZaVeh8G4ju9ofCcp4VIa
         w7+w==
X-Gm-Message-State: APjAAAU8MDrTFetIw22BKHOh8mx58wECuOUo7k7M0XpMMtPyUeYsJjTG
        veSAl13H0i8tlgWjaM07RtI=
X-Google-Smtp-Source: APXvYqywaaDO+l8UX/soexCNWT1d0rN20NelYgx+BVxfqR8t062U5VDK59Nz1VPcLeOY/YWISW81Sg==
X-Received: by 2002:a62:cb:: with SMTP id 194mr46108963pfa.130.1568227496001;
        Wed, 11 Sep 2019 11:44:56 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g26sm23692017pfi.103.2019.09.11.11.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 11:44:54 -0700 (PDT)
Date:   Wed, 11 Sep 2019 11:44:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/7] usb: mtu3: support ip-sleep wakeup for MT8183
Message-ID: <20190911184453.GA2628@roeck-us.net>
References: <1567150854-30033-1-git-send-email-chunfeng.yun@mediatek.com>
 <1567150854-30033-4-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1567150854-30033-4-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 03:40:50PM +0800, Chunfeng Yun wrote:
> Support USB wakeup by ip-sleep mode for MT8183, it's similar to
> MT8173
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v3: changes micros define
> 
> v2: no changes
> ---
>  drivers/usb/mtu3/mtu3_host.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
> index c871b94f3e6f..4f8208885ebd 100644
> --- a/drivers/usb/mtu3/mtu3_host.c
> +++ b/drivers/usb/mtu3/mtu3_host.c
> @@ -18,6 +18,12 @@
>  #include "mtu3.h"
>  #include "mtu3_dr.h"
>  
> +/* mt8183 etc */
> +#define PERI_WK_CTRL0	0x20
> +#define WC0_IS_C(x)	(((x) & 0xf) << 28)  /* cycle debounce */
> +#define WC0_IS_P	BIT(12)	/* polarity */
> +#define WC0_IS_EN	BIT(6)
> +

For 64-bit builds, this results in:

drivers/usb/mtu3/mtu3_host.c: In function ‘ssusb_wakeup_ip_sleep_set’:
./include/linux/bits.h:6:19: warning:
	conversion from ‘long unsigned int’ to ‘u32’ {aka ‘unsigned int’}
	changes value from ‘18446744073441120320’ to ‘4026536000’ [-Woverflow]

since WC0_IS_C() is sign extended to 64 bit and then truncated.

Observed with gcc 7.4.0 and 8.3.0.

Guenter

>  /* mt8173 etc */
>  #define PERI_WK_CTRL1	0x4
>  #define WC1_IS_C(x)	(((x) & 0xf) << 26)  /* cycle debounce */
> @@ -30,7 +36,8 @@
>  #define SSC_SPM_INT_EN		BIT(1)
>  
>  enum ssusb_uwk_vers {
> -	SSUSB_UWK_V1 = 1,
> +	SSUSB_UWK_V0 = 0,
> +	SSUSB_UWK_V1,
>  	SSUSB_UWK_V2,
>  };
>  
> @@ -43,6 +50,11 @@ static void ssusb_wakeup_ip_sleep_set(struct ssusb_mtk *ssusb, bool enable)
>  	u32 reg, msk, val;
>  
>  	switch (ssusb->uwk_vers) {
> +	case SSUSB_UWK_V0:
> +		reg = ssusb->uwk_reg_base + PERI_WK_CTRL0;
> +		msk = WC0_IS_EN | WC0_IS_C(0xf) | WC0_IS_P;
> +		val = enable ? (WC0_IS_EN | WC0_IS_C(0x8)) : 0;
> +		break;
>  	case SSUSB_UWK_V1:
>  		reg = ssusb->uwk_reg_base + PERI_WK_CTRL1;
>  		msk = WC1_IS_EN | WC1_IS_C(0xf) | WC1_IS_P;
