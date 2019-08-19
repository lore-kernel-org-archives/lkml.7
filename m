Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB39BC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12A920874
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ir9OqPH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfHSIhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 04:37:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32882 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfHSIhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 04:37:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id n190so807858pgn.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 01:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S4GHfSKQyx9obgpD6pUQlhguun535Iv+9qQdLHTCQIU=;
        b=ir9OqPH+14qK5lFOFTNB+sPUzt3MSL7+W/lXJqrmVbjMEUxHpV9idwMPgGnT/J60Yt
         f+jNFB+7G/kVPp5l/0nm08Brh2asukPu9IxfrczHHQyieOLLYPiwjABxf4aD8NEQxsQL
         qNFY+zzVc4suuEeb3qUkrTrxWX/7hVoxlGGiN8g6e0det561n0VNcJhNYzLG/oUUwJHY
         TU8hk1nmGcz6Qn8kxY+XQ0hX3VjFTYc7MR8IK+sXiodffvkzG9VpBISpS+HyQm/7+dwG
         gzd21ZIwtboOMV1L0I1QwlmEpGXTeNuQcIQrmvUMh/dxTkSBNfW+IC4aj4upgNwz+U3p
         bCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S4GHfSKQyx9obgpD6pUQlhguun535Iv+9qQdLHTCQIU=;
        b=b7aNumwfi1F664yuaPBUpdhjfB451+nN0W551OcVIgAKACrcL5Laymwr6hKLIfwOkr
         UKfq8N6vW5KmphZc//qkq11eLE5Rxwc6QfQgPOw3NcZc8quoQBuZtBZDw2a7vBCaEiDZ
         WPpPAJBR5ew6jtGCR8eS6tbDanXZP3uY4ASmXsfVZJKyfWh0gGZqPYMIFSPjqvqZnuxY
         wD+XMj6B3wMH+TqtNY0mVLTsyR3lLqvKOeDJoTMgQaVS79IWLJq3BGMgUiUB7LDINXZt
         GcpsV7VxTr4EXXGeBn1Vs14QpjNnSdzX8EcDD8RWqOxzVCr2pLXlBYW2MxktFo8EqO7I
         xFQQ==
X-Gm-Message-State: APjAAAUcmvIxyAqBAUgdv5Hb17+9LDAj1KXgLS38Gyt5nd7qlGgTE8FK
        mIDuIe6dDJX9vkdnnc8v2w+Ciq1LOZo=
X-Google-Smtp-Source: APXvYqzxl6MDX+m2ZXx/oOOpJ6HFlbhtvNzG4FiAtQifvybxRcF5ONNGhiWAU87pm52wiqpLLtBfPQ==
X-Received: by 2002:aa7:938d:: with SMTP id t13mr22083730pfe.180.1566203827811;
        Mon, 19 Aug 2019 01:37:07 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id s16sm15700182pfs.6.2019.08.19.01.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 01:37:07 -0700 (PDT)
Date:   Mon, 19 Aug 2019 14:07:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net,
        leonard.crestez@nxp.com, abel.vesa@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH RESEND V2 3/7] cpufreq: Use imx-cpufreq-dt for i.MX8MN's
 speed grading
Message-ID: <20190819083705.fqpsyk7rgqmul6y4@vireshk-i7>
References: <1566109945-11149-1-git-send-email-Anson.Huang@nxp.com>
 <1566109945-11149-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566109945-11149-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-19, 02:32, Anson Huang wrote:
> Add i.MX8MN to blacklist, so that imx-cpufreq-dt driver can handle
> speed grading bits just like other i.MX8M SoCs.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
> No changes.
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index ec2057d..febcec8 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -109,6 +109,7 @@ static const struct of_device_id blacklist[] __initconst = {
>  	{ .compatible = "fsl,imx7d", },
>  	{ .compatible = "fsl,imx8mq", },
>  	{ .compatible = "fsl,imx8mm", },
> +	{ .compatible = "fsl,imx8mn", },
>  
>  	{ .compatible = "marvell,armadaxp", },
>  

Applied. Thanks.

-- 
viresh
