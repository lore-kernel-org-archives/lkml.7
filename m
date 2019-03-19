Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A207C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5805320857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ROUZPLjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfCSLpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:45:23 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41988 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfCSLpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:45:22 -0400
Received: by mail-qt1-f194.google.com with SMTP id u7so21598444qtg.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 04:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+CK9gfyg06N1FdsFONPK8CGgHJvRc6A4h/2r6Ru0BaU=;
        b=ROUZPLjJ/+O5ZPOeqd38mHfyJseLUi7az/3QF7fp2V9cLOSuZHmQaG/2nd6AoEtAsk
         CipT/OSvvdfHwSNQr2leQuWJRB5UZw6vEVxkN/hJUg+YiEdOyWwRli+hT4OGGCQYcr+Y
         uhv/Gq+UvTyRTuuDd+z7vqO8yk1vV2iSAxtEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+CK9gfyg06N1FdsFONPK8CGgHJvRc6A4h/2r6Ru0BaU=;
        b=diyxArapJxw79dhz1VWj7GiVPrRNn0wUXVFJ+6Thwmkh9cs2ArU5u9sGtRaSi6QmSJ
         FCYnG8FPJqfvnubJIYhKvbaUdBE9bjQNgH2D/PPCQkOvfYecPar5oTqORtZH05fRCQnq
         2YAdh0ORe6hkIDGVA2rw4uIYGfTcQVzX/edWar4/UAfw29JaHLEDJ42xIzx9pZ/Lf76O
         DX5mNsxEJJxQkFtdzd3gaaWyUhtE10xcqbSizu3NwiwdAuYIjApWIbsJmeB7r0G96Q5G
         JMjsD5wSMZSLLnuWzPEyofzpEnLztkvCYowU5rvLzHlA7eYxO66UrxXCY7QyXz7BV9Ph
         vMPQ==
X-Gm-Message-State: APjAAAWCOppvSVJwpUGH3KU6vjC47paxFkwdW3p5wigmPIx8vIKBf5gw
        xxuKuR4aTnby2mwNGgIDw5K6lQO7MukwvGF4XAGnUg==
X-Google-Smtp-Source: APXvYqxnoKuOBKaePJ7W63F8IS2n0VSWzbkETBhP6VEGiprRvQPPPgFQIoE7peZJ1yfrR2nlRs94iwjM+8PztmAB8H0=
X-Received: by 2002:ac8:1884:: with SMTP id s4mr1545896qtj.339.1552995921737;
 Tue, 19 Mar 2019 04:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190319080140.24055-1-weiyi.lu@mediatek.com> <20190319080140.24055-5-weiyi.lu@mediatek.com>
In-Reply-To: <20190319080140.24055-5-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 19 Mar 2019 19:45:10 +0800
Message-ID: <CANMq1KCLQaFg3bOrHnXzbjU9KM5Ny2rRX9bP4xg17jOYirxxig@mail.gmail.com>
Subject: Re: [PATCH v5 04/14] soc: mediatek: Refactor polling timeout and documentation
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 4:02 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> Use USEC_PER_SEC to indicate the polling timeout directly.
> And add documentation of scp_domain_data.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 9f52f501178b..2855111b221a 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -21,7 +21,7 @@
>  #include <dt-bindings/power/mt8173-power.h>
>
>  #define MTK_POLL_DELAY_US   10
> -#define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
> +#define MTK_POLL_TIMEOUT    USEC_PER_SEC
>
>  #define MTK_SCPD_ACTIVE_WAKEUP         BIT(0)
>  #define MTK_SCPD_FWAIT_SRAM            BIT(1)
> @@ -108,6 +108,18 @@ static const char * const clk_names[] = {
>
>  #define MAX_CLKS       3
>
> +/**
> + * struct scp_domain_data - scp domain data for power on/off flow
> + * @name: The domain name.
> + * @sta_mask: The mask for power on/off status bit.
> + * @ctl_offs: The offset for main power control register.
> + * @sram_pdn_bits: The mask for sram power control bits.
> + * @sram_pdn_ack_bits: The mask for sram power control acked bits.
> + * @bus_prot_mask: The mask for single step bus protection.
> + * @clk_id: The basic clock needs to be enabled before enabling certain
> + *          power domains.

I assume these are the clock*s* that *this* scp_domain requires?

So maybe just: "The basic clocks required by this power domain." ?

> + * @caps: The flag for active wake-up action.
> + */
>  struct scp_domain_data {
>         const char *name;
>         u32 sta_mask;
> --
> 2.18.0
>
