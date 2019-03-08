Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1C1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3616020811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XF93q8eJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfCHEhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 23:37:18 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39902 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfCHEhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 23:37:17 -0500
Received: by mail-pf1-f193.google.com with SMTP id i20so13182613pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 20:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6b2TGnM40jjN6eDkMatgtVdtGBBDElcNA9sPAUBmPe4=;
        b=XF93q8eJwMxPyihQX7r5RWVLl/8vySHjhCdn8HWGFsuUzd53RJYyhQ5SOgujFEkH69
         /L/71kQvSncOKD5E5b0ZafQdKwXfFPv7gwiLPmahxUCJ+wEqxuwH9pikstS7xX3ZviFs
         gLd6D64bV2uBAY8+ow5DzNkqiDgjKpHrF4Tn8tr7ihpQf/NZZbR6DU46uvz3wZFY5qqz
         QvSWLWq0ntOgn/pY5YedhAhj9PoowjsSFs/PEbHvGdplkMoOXjLUdazuDIucgEeiQyKX
         C7oDdDQ6Qy26NMaKV+xXcXTciXAxusBQ2QITiTFFFAdeL7H73wh80Tp2h7b1HrY8oamo
         7gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6b2TGnM40jjN6eDkMatgtVdtGBBDElcNA9sPAUBmPe4=;
        b=IW+j0R21bgd6xRpvoFUJgzzzz21xjqywcaBZ+kpsT5Tt/NvlFuFp3bKGQcXqifFDbA
         6ocjOxJUm1jGvYEzJv/pPwtlPjudwOyEnUvtBrYLtwSOPYVcX331YO5WfucHnB2O7clX
         7SIGJ91SndNBjBqGILsIPqxrjM6XBJ8H44zvVaaQL9OMRdtZuZT3MPE8/519t1zLoUZE
         rv7VLKU8ZM6qgaCIOe728OeCdKTOYqKcoBy86u8CjjqWGyN7Kv/fBGtgXMqXFtVO1gqE
         QwL/e0ubdPB1qZB335KZvkry+M/T8QO4p517fcpHxnT3WkV+KOMKxjJLD9spYWsBaLiT
         YngA==
X-Gm-Message-State: APjAAAUklsuJEfkWssfZIJhs36nTqpmWmjpYharB1+m1z/VZ8PHAeon6
        +zdwygf2EQ/Pz0yfOcM6cM4Nog==
X-Google-Smtp-Source: APXvYqw3BoJVtmvOQAw1ugeNgHZtoa3Lr2Xwv2m5w2DEeaLsC7Gl2SDkf8F0bjaC90MZbK07m8cwAg==
X-Received: by 2002:a63:6b47:: with SMTP id g68mr14578047pgc.220.1552019836317;
        Thu, 07 Mar 2019 20:37:16 -0800 (PST)
Received: from localhost ([122.171.71.18])
        by smtp.gmail.com with ESMTPSA id n15sm17031696pfi.173.2019.03.07.20.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 20:37:14 -0800 (PST)
Date:   Fri, 8 Mar 2019 10:07:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, rjw@rjwysocki.net
Cc:     nm@ti.com, sboyd@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OPP: Fix handling of multiple power domains
Message-ID: <20190308043712.3aca6lygz2oya3lc@vireshk-i7>
References: <20190306040726.1930-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306040726.1930-1-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-03-19, 09:37, Rajendra Nayak wrote:
> We seem to rely on the number of phandles specified in the
> 'required-opps' property to identify cases where a device is
> associated with multiple power domains and hence would have
> multiple virtual devices that have to be dealt with.
> 
> In cases where we do have devices with multiple power domains
> but with only one of them being scalable, this logic seems to
> fail.
> 
> Instead read the number of power domains from DT to identify
> such cases.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/opp/of.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 06f0f632ec47..443c305ae100 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -172,7 +172,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>  	struct opp_table **required_opp_tables;
>  	struct device **genpd_virt_devs = NULL;
>  	struct device_node *required_np, *np;
> -	int count, i;
> +	int count, count_pd, i;
>  
>  	/* Traversing the first OPP node is all we need */
>  	np = of_get_next_available_child(opp_np, NULL);
> @@ -185,7 +185,19 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
>  	if (!count)
>  		goto put_np;
>  
> -	if (count > 1) {
> +	/*
> +	 * Check the number of power-domains to know if we need to deal
> +	 * with virtual devices. In some cases we have devices with multiple
> +	 * power domains but with only one of them being scalable, hence
> +	 * 'count' could be 1, but we still have to deal with multiple genpds
> +	 * and virtual devices.
> +	 */
> +	count_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
> +					      "#power-domain-cells");
> +	if (!count_pd)
> +		goto put_np;
> +
> +	if (count_pd > 1) {
>  		genpd_virt_devs = kcalloc(count, sizeof(*genpd_virt_devs),
>  					GFP_KERNEL);
>  		if (!genpd_virt_devs)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

@Rafael, please pick this up for 5.1-rc2 directly. Thanks.

-- 
viresh
