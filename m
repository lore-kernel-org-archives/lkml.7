Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FA8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BEC2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hV69YT56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfC1DhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:37:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40038 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfC1DhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 23:37:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id b11so4291659plr.7;
        Wed, 27 Mar 2019 20:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AUkveORYzHVUtIHQsPaZeIYBU7580SexfM1N1aZlpg0=;
        b=hV69YT56mKWpRO+AtOVnXM6UUQ6/l3OFW6XhkI1XtVG7d211M1gusICH5apvHynEo0
         N+J43V9z3v+Kl0t796jQ97+PkB5oItKX8dxjGUSsHBfGp5pNdoM71wja/IrfLF+bFddZ
         VBur37pNfXPzhJetoMCnEbKuDG/KSlZ/KjWNMwpdTcYzOC+0HumK5fqDfsasbBVGGeUi
         gBlO0PyEgyCe8FmvP1lg4odJ860o/kTlHKaR40E584ePuae9MLGJvWOZDGdCTnxWSjCa
         UV2yZJL442jg464nuPA5toZITitggJWkbfSlF2YtuongjFkjsc34H5K+SfW6jNf5y6dQ
         Am1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AUkveORYzHVUtIHQsPaZeIYBU7580SexfM1N1aZlpg0=;
        b=awCJcvDoTQXSacwp114sqGRG1Bf3oIsuRbRm6z8eJ678wjqLE+nkX7HKH6XItOF96d
         28E1qNUtNw55GHamtf5cr9EGeCEgkHVHWZhfQvCdWAkbhuT0wZ51B4jtKAWdQe+t54V8
         kgCOsolADGdS0Ot1JmmSLU1Mlf+p8DdNQ6AQtlyG4EBIIg5CZ2U0si17oT0cuGfmG4ux
         P5sLPebeCTkhyztRuquLFzMTL8FjmHMgsnM0moKIbJgS7FsI0+at3CTncsHLNYK6eddv
         lyEx7Vd5O8d+NAPz9iBRDmxNtyAXTlqjp+AetRrb+sBz/VK2Y58detqvE9xao09PpIVm
         dhfQ==
X-Gm-Message-State: APjAAAXRhrWFq9JOBktRXf+jblUGbu1L3zgZoGK8F5Dx8XRc01AxJH1f
        Q2r+ZUWtjE7xS9O6W1VeJbqfPPXn
X-Google-Smtp-Source: APXvYqxWwwgfInVRGOLon3vN2U7Vk85GsSixgqNA9wGCPvJ1twIDJX8jlVNKuEerbpLfGYXravMhaA==
X-Received: by 2002:a17:902:4681:: with SMTP id p1mr39253455pld.42.1553744219602;
        Wed, 27 Mar 2019 20:36:59 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id v20sm14703471pfn.116.2019.03.27.20.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 20:36:58 -0700 (PDT)
Subject: Re: [PATCH net-next v5 14/22] ethtool: provide timestamping
 information in GET_INFO request
To:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
References: <cover.1553532199.git.mkubecek@suse.cz>
 <1dce7f6dd3308ad4b90300014823d071f37b0f74.1553532199.git.mkubecek@suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <262b84dc-e4fb-6c27-7de7-bc797d2247a0@gmail.com>
Date:   Wed, 27 Mar 2019 20:36:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1dce7f6dd3308ad4b90300014823d071f37b0f74.1553532199.git.mkubecek@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2019 10:08 AM, Michal Kubecek wrote:
> Add timestamping information as provided by ETHTOOL_GET_TS_INFO ioctl
> command in GET_INFO reply if ETH_INFO_IM_TSINFO flag is set in the request.
> 
> Add constants for counts of HWTSTAMP_TX_* and HWTSTAM_FILTER_* constants
> and provide symbolic names for timestamping related values so that they can
> be retrieved in GET_STRSET and GET_INFO requests.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> ---

[snip]

> +int __ethtool_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
> +{
> +	const struct ethtool_ops *ops = dev->ethtool_ops;
> +	struct phy_device *phydev = dev->phydev;
> +	int err = 0;
> +
> +	memset(info, 0, sizeof(*info));
> +	info->cmd = ETHTOOL_GET_TS_INFO;
> +
> +	if (phydev && phydev->drv && phydev->drv->ts_info) {
> +		err = phydev->drv->ts_info(phydev, info);
> +	} else if (ops->get_ts_info) {
> +		err = ops->get_ts_info(dev, info);
> +	} else {
> +		info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
> +					SOF_TIMESTAMPING_SOFTWARE;
> +		info->phc_index = -1;
> +	}

We don't have to solve this just yet, but this is the type of logic that
we want to be able to change in the future, there are a number of things
in the current ethtool code where, say, we always prefer PHY time
stamping over MAC time stamping when there should be a choice if both
are supported.

I don't know if you maintain a TODO for after when this patch series get
merged, but we may want to start one :)
-- 
Florian
