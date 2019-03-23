Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6209C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 22:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63CF2148D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 22:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="NwFi89bH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfCWWJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 18:09:16 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:59532 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfCWWJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 18:09:15 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 22C9D745
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 22:09:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o71dImfpkexc for <linux-kernel@vger.kernel.org>;
        Sat, 23 Mar 2019 17:09:14 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id E59BBCBA
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 17:09:13 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id s3so5363013itl.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 15:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=subject:cc:references:in-reply-to:from:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=YZQh7d4OLvCLB1Tazwzha2kIsiqXXBmwwhhfigRUgUc=;
        b=NwFi89bH0EFwFfn3DQujACzYMTMLR3ql/KvYH+6ONLqXSc0He5DBqKl77tfSBonfzY
         bR0d04QYqAom2Bk3eAzkbwzUag85/Ojx0KkhBZ2nAiyDXfQiCwBiR2TnlUS0MX9jr9PM
         fJs2QBkZbwbmyk1MPFUPQCk2yRGCo8TjzHhptkWSzjdQ6Zd426UKgGVHpMy7+WcD2er4
         mtjR+eqkgHN80yIgiWDF8VsSsj2D7qgggZqVYIjT6Drm3ZNwzM0eVmU1z0aIaIQOxuif
         w3rY+Qj74lxy5dnDaMskFoLpol0zypTdg49xqg3twVTp3c9gVtADwhuGoO0X7uRRMp0S
         FuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:in-reply-to:from
         :message-id:date:user-agent:mime-version:content-transfer-encoding
         :content-language;
        bh=YZQh7d4OLvCLB1Tazwzha2kIsiqXXBmwwhhfigRUgUc=;
        b=IbfIpUryjSNEtH7Ch4ez3qVHY9y46dhX3rcZxc2vTIz1ZhGxgOFI2qf85j19/6TXTa
         GavCFB/ors2o2Wn4f7RAs1V7C1iUb+lrIx+USJge7KXVZtrasDCXElN+vlqprG3WEaeY
         9Lmo6GDDNVXsutiLcrGo5ut98ikM7+tTwZQdjGNzFMM4TzUA6h28BdLeBO7gMHplr76p
         /HTz1ly6gA7tcRMEjoAmRvFPd97NTASYz0NaWF5ROvppWw6gDdfT/3UYSPzxAT3OWbm1
         5cACDplsI7HQw3qFKfqG/0s/FhuOfH/ceHclc4UPRJ9S8WeJ27xvhxMeWEk83uZDDMUR
         Y1xw==
X-Gm-Message-State: APjAAAUM+M30PEMX0udZCJazlkQ5ODt2CdlIfoxREHEgT5PNPLg3vhZW
        V15e5XQWuKt+fZTQ4t7q2t0a7Jfpa4itx8C/rMUs3LYcrPZmQrRci7mTPwFwjHfTqfGtDB1u/Hj
        KtdLi7/6nF7ZqFT+9PhmUY0iNCzJy
X-Received: by 2002:a24:5f52:: with SMTP id r79mr6962932itb.125.1553378953444;
        Sat, 23 Mar 2019 15:09:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyUxD/6+derKpKvhoZ0ByPkDLHImuwkCfLrSBEud3I9n7acAGL3v2r1cWG2rTUWOphwLJ3LUw==
X-Received: by 2002:a24:5f52:: with SMTP id r79mr6962920itb.125.1553378953231;
        Sat, 23 Mar 2019 15:09:13 -0700 (PDT)
Received: from [128.101.106.66] (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id u82sm3544292itb.18.2019.03.23.15.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 15:09:12 -0700 (PDT)
Subject: Re: [PATCH] pinctrl: axp209: Fix NULL pointer dereference after
 allocation
Cc:     kjlu@umn.edu, Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190312151911.2207-1-pakki001@umn.edu>
In-Reply-To: <20190312151911.2207-1-pakki001@umn.edu>
From:   Aditya Pakki <pakki001@umn.edu>
Message-ID: <94966a29-9c51-df66-552b-5a047499e229@umn.edu>
Date:   Sat, 23 Mar 2019 17:09:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle reminder, Can someone review this patch.


On 3/12/19 10:19 AM, Aditya Pakki wrote:
> axp20x_build_funcs_groups allocates groups via devm_kcalloc and tries to
> dereference without checking for NULL. This patch avoids such a
> scenario.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/pinctrl/pinctrl-axp209.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
> index afd0b533c40a..4fcf7262bed9 100644
> --- a/drivers/pinctrl/pinctrl-axp209.c
> +++ b/drivers/pinctrl/pinctrl-axp209.c
> @@ -366,6 +366,8 @@ static int axp20x_build_funcs_groups(struct platform_device *pdev)
>  		pctl->funcs[i].groups = devm_kcalloc(&pdev->dev,
>  						     npins, sizeof(char *),
>  						     GFP_KERNEL);
> +		if (!pctl->funcs[i].groups)
> +			return -ENOMEM;
>  		for (pin = 0; pin < npins; pin++)
>  			pctl->funcs[i].groups[pin] = pctl->desc->pins[pin].name;
>  	}
