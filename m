Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACD2C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8598A207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfJMTbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 15:31:16 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:32123 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728945AbfJMTbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 15:31:16 -0400
X-IronPort-AV: E=Sophos;i="5.67,293,1566856800"; 
   d="scan'208";a="405952555"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Oct 2019 21:31:14 +0200
Date:   Sun, 13 Oct 2019 21:31:13 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Wambui Karuga <wambui.karugax@gmail.com>
cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        eric@anholt.net, wahrenst@gmx.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [Outreachy kernel] [PATCH v2] staging: rtl8723bs: use DIV_ROUND_UP
 helper macro
In-Reply-To: <20191013191027.6470-1-wambui.karugax@gmail.com>
Message-ID: <alpine.DEB.2.21.1910132126290.2565@hadrien>
References: <20191013191027.6470-1-wambui.karugax@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 13 Oct 2019, Wambui Karuga wrote:

> Use the DIV_ROUND_UP macro to replace open-coded divisor calculation
> to improve readability.
> Issue found using coccinelle:
> @@
> expression n,d;
> @@
> (
> - ((n + d - 1) / d)
> + DIV_ROUND_UP(n,d)
> |
> - ((n + (d - 1)) / d)
> + DIV_ROUND_UP(n,d)
> )
>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
> Changes in v2:
>   - Remove comment that explained previously used calculation.

Maybe it is not very important for a comment, but remember that what is
below the --- will disappear in the history.  So when actual code changes,
it may be necessary to integrate the extended change in the commit log as
well as putting it in the v2 changes.

julia


> ---
>  drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> index 87535a4c2e14..22931ab3a5fc 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> @@ -4156,9 +4156,8 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
>  				break;
>  			}
>
> -			/*  The value of ((usNavUpper + HAL_NAV_UPPER_UNIT_8723B - 1) / HAL_NAV_UPPER_UNIT_8723B) */
> -			/*  is getting the upper integer. */
> -			usNavUpper = (usNavUpper + HAL_NAV_UPPER_UNIT_8723B - 1) / HAL_NAV_UPPER_UNIT_8723B;
> +			usNavUpper = DIV_ROUND_UP(usNavUpper,
> +						  HAL_NAV_UPPER_UNIT_8723B);
>  			rtw_write8(padapter, REG_NAV_UPPER, (u8)usNavUpper);
>  		}
>  		break;
> --
> 2.23.0
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191013191027.6470-1-wambui.karugax%40gmail.com.
>
