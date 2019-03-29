Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB4CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B761920811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PPCOu9ty";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CXhLaJ2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfC2KCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:02:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45266 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbfC2KCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:02:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D1B816085C; Fri, 29 Mar 2019 10:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553853752;
        bh=X0S5ejWDiWFMFvTQgkHKCnWwfvJnYMIgv+PHTBdppIM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PPCOu9ty46SnX3j+uhhlAWRT+DtED90AZiy5FvKTeM3E5ZbeWahjwU/S1/LzfvJJ+
         ExYvwFgBGRWxvw6CRjMmFuoq4r1Hsep6xnYaTL03Lf7PBTzJjMKg030Kr+c0Aq8sZn
         zASSC1INf5NKmXTulA4mZHw8iFVVB7k57287N5Y0=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2659460779;
        Fri, 29 Mar 2019 10:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553853747;
        bh=X0S5ejWDiWFMFvTQgkHKCnWwfvJnYMIgv+PHTBdppIM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CXhLaJ2g1dFAFmwTLJMTmVoXoKEmL/3ACt7xZ1fsaq6OJUuQZN/Sp96QTx9wWTB7j
         dO5PottGdJchz7ReYCwZ91qSxHJSmhVBDGS+fgxf4HigfhLLtx7EqUXrx0W4dCLzpD
         5IQa+yeU8sw4dkeCztnHGZxnM4jBWZoNAql47ku8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2659460779
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] gpio: of: Optimize quirk checks
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190329084229.17018-1-geert+renesas@glider.be>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <2aa29620-13c9-e618-93e9-dedc464cfa74@codeaurora.org>
Date:   Fri, 29 Mar 2019 15:32:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329084229.17018-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 2:12 PM, Geert Uytterhoeven wrote:
> Simple string comparisons are cheaper than DT lookups, as the latter
> involve taking a spinlock and traversing properties.
> Hence optimize quirk checks by postponing DT lookups after string
> comparisons.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


Looks good to me.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/gpio/gpiolib-of.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 6a3ec575a404ed9f..3a6bb53d89dfed32 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -86,9 +86,9 @@ static void of_gpio_flags_quirks(struct device_node *np,
>   	if (IS_ENABLED(CONFIG_REGULATOR) &&
>   	    (of_device_is_compatible(np, "regulator-fixed") ||
>   	     of_device_is_compatible(np, "reg-fixed-voltage") ||
> -	     (of_device_is_compatible(np, "regulator-gpio") &&
> -	      !(strcmp(propname, "enable-gpio") &&
> -	        strcmp(propname, "enable-gpios"))))) {
> +	     (!(strcmp(propname, "enable-gpio") &&
> +		strcmp(propname, "enable-gpios")) &&
> +	      of_device_is_compatible(np, "regulator-gpio")))) {
>   		/*
>   		 * The regulator GPIO handles are specified such that the
>   		 * presence or absence of "enable-active-high" solely controls
> @@ -119,9 +119,8 @@ static void of_gpio_flags_quirks(struct device_node *np,
>   	 * property named "cs-gpios" we need to inspect the child node
>   	 * to determine if the flags should have inverted semantics.
>   	 */
> -	if (IS_ENABLED(CONFIG_SPI_MASTER) &&
> -	    of_property_read_bool(np, "cs-gpios") &&
> -	    !strcmp(propname, "cs-gpios")) {
> +	if (IS_ENABLED(CONFIG_SPI_MASTER) && !strcmp(propname, "cs-gpios") &&
> +	    of_property_read_bool(np, "cs-gpios")) {
>   		struct device_node *child;
>   		u32 cs;
>   		int ret;
