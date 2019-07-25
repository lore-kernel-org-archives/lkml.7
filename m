Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBBCC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5BB2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564039473;
	bh=UgeAKd59RIG7EhdhjKjj0zeeamDrtMwwZ47bB4K8jUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jiRee9Ub/+2oEGGmtXq3ilbjTjJgip1J32s5zOx7QrT4FAcbcirxFID8w3V5IZMwh
	 HBYvlV7oNJU1xHCLG3z1Vq1ywLwRwSBDsoaloXv6oBdHZuaQfXLX5Lzf9FpXTpynK7
	 MWjK7g2GDdBXKmuKgQRL5TzXw/OibQI7bE/KxWaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbfGYHYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:24:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387990AbfGYHYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:24:31 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68C6F21901
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 07:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564039470;
        bh=UgeAKd59RIG7EhdhjKjj0zeeamDrtMwwZ47bB4K8jUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m+6jAV5U+nMfm0lBlwNCHcuuehlnrMdYjsTNxnrKSHYeG1Y3lXucbRDdlMn2Xn9rB
         P9gOZ7avPVdTzuiXH8QRRsj0GC0m54ESI/K4JES9mYMQ4X+oHlIrRkK2NVkJoOPXJ1
         AsIuEU4qzrul2WDea9LvDafW/BhehdxV79GqS/ys=
Received: by mail-lj1-f177.google.com with SMTP id v18so46948214ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 00:24:30 -0700 (PDT)
X-Gm-Message-State: APjAAAWSpDZOTF37enotifw/mitRJ1R+wM52/Td/lWbQO8gcmAGSTtn9
        sxiuz3OMdjmAekYyAf8YUU9iO2jjW0NVGRYcMfo=
X-Google-Smtp-Source: APXvYqwqEs5YJHt+im6G4F2gM+lBFLM7HC6C745xGu9SHm4bSNnOL+KOIR0jjv/j4hiEDCPHKbjDmn+mIuNx9sAzux0=
X-Received: by 2002:a2e:8155:: with SMTP id t21mr44830498ljg.80.1564039468644;
 Thu, 25 Jul 2019 00:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190725064238.6435-1-gomonovych@gmail.com>
In-Reply-To: <20190725064238.6435-1-gomonovych@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 25 Jul 2019 09:24:17 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe2eutXocY5Jo=Z4tksm4Bcpz7p_pj-vFDrNU3Ot=55Uw@mail.gmail.com>
Message-ID: <CAJKOXPe2eutXocY5Jo=Z4tksm4Bcpz7p_pj-vFDrNU3Ot=55Uw@mail.gmail.com>
Subject: Re: [PATCH] extcon: max14577: Add irq mask IRQ_ONESHOT
To:     Vasyl Gomonovych <gomonovych@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, myungjoo.ham@samsung.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019 at 08:42, Vasyl Gomonovych <gomonovych@gmail.com> wrote:
>
> Do not fire irq again until thread done
> This issue was found by code inspection
> Coccicheck irqf_oneshot.cocci

The same as in max77693 - this is virtual IRQ so no need for oneshot.
The hardware IRQ has oneshot set. Otherwise please provide slightly
more specific rationale for this commit.

Best regards,
Krzysztof

>
> Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
> ---
>  drivers/extcon/extcon-max14577.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
> index 32f663436e6e..97c021512ffc 100644
> --- a/drivers/extcon/extcon-max14577.c
> +++ b/drivers/extcon/extcon-max14577.c
> @@ -698,7 +698,7 @@ static int max14577_muic_probe(struct platform_device *pdev)
>
>                 ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
>                                 max14577_muic_irq_handler,
> -                               IRQF_NO_SUSPEND,
> +                               IRQF_NO_SUSPEND | IRQF_ONESHOT,
>                                 muic_irq->name, info);
>                 if (ret) {
>                         dev_err(&pdev->dev,
> --
> 2.17.1
>
