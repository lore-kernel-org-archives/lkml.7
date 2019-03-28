Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12390C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AD12075C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrwMfSg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfC1Dmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:42:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41909 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfC1Dmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 23:42:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so5253796pfd.8;
        Wed, 27 Mar 2019 20:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mXejdoPA/cvf6bL+OK6DuWZDgQPlKQSh2cXFE+sLisQ=;
        b=TrwMfSg6zHdLJDzmrlFbjlU2uHnNHtfmg0+rmrdWip62Of5MQae8sLbYU+Jx4N7PYQ
         xyZ77fpUVVkLqnH9DyfibFQQdpDsqUaxpGL/NEE1qhlNYAhlK7LkO3Ed9Bf9YfEVvj9j
         0JDNaB+OTuiWS/Bl1EV1QYp40WFyIzP/wcRnlPXMCuvaM6ntQa7J04wcfMRh03TT7J1o
         eppUw2L/uNF6cK6t+SlTOHX/q7shmCbyLUb/OMCVweXsWIeM1UfojojcrwvHvGAxfUN/
         nvwoKyuQgfrwBzsPefTgnHgM0/yURash2a1L92zRt/kBHJhvyrEgQOmd78K+IvrZ4kEh
         p0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mXejdoPA/cvf6bL+OK6DuWZDgQPlKQSh2cXFE+sLisQ=;
        b=NAjoe6DzV9w8dwN1wNS4xRwsLYmFwkAOoF2FsrCJc8HXGiHmwTiErIjhVMP1pY5dCB
         weJZpgJ/FYDo5iV+SkJFlCbG4GdIT+vUNvGOgAq4cccGzr5qiPC01Ond7arUpCnZBJJM
         OjF1dtrc4fZF1vkJikRPO8jWQdQ+XlC/HHFN/kNKdRh8NKN/Jsuzol+mrizHH/zPkLzw
         7Itv5MKRp02gZstk0fa7ckPpQm7Tj8qCTWzpHh4+d/ZEDxfrSgK6NjGclz7PfGEr5BUh
         A+3xNWIjy/25XaaSP0BnOxR/9NBDjtatX+QbQEfGujiryPihBFFvJwY9J7v335tM6K8R
         cvIA==
X-Gm-Message-State: APjAAAWWxBuxGGPik0ij/BNY+2fap0GcXKCwS8C1rXBm7JUgq0x1RaAB
        xZ4mhjRjLjstB/NDD9BoHp0pPJU4
X-Google-Smtp-Source: APXvYqzrvs8ygSqx0KAilAzoFngZgEnbVc3/K8Amfdr5DQtXeQxX6skgU+aPFc2oecXHo2A20Yyxrw==
X-Received: by 2002:aa7:83ca:: with SMTP id j10mr38625266pfn.50.1553744552117;
        Wed, 27 Mar 2019 20:42:32 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id a65sm31496000pgc.72.2019.03.27.20.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 20:42:31 -0700 (PDT)
Subject: Re: [PATCH net-next v5 19/22] ethtool: provide WoL information in
 GET_SETTINGS request
To:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
References: <cover.1553532199.git.mkubecek@suse.cz>
 <be5ce3381f30d7c3fe14ba6d98a58a31c57b851b.1553532199.git.mkubecek@suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <7580e650-565a-a7e2-35cc-6cce1c3f5ba6@gmail.com>
Date:   Wed, 27 Mar 2019 20:42:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <be5ce3381f30d7c3fe14ba6d98a58a31c57b851b.1553532199.git.mkubecek@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2019 10:08 AM, Michal Kubecek wrote:
> Add information about supported and enabled wake on LAN modes into the
> GET_SETTINGS reply when ETH_SETTINGS_IM_WOL flag is set in the request.
> 
> The GET_SETTINGS request can be still sent by unprivileged users but in
> such case the SecureOn password (if any) is not included in the reply.
> 
> Send notification in the same format as reply SET_SETTINGS message when
> wake on LAN settings are modified using ioctl interface (ETHTOOL_SWOL
> command).

Looks good to me, just one question below:

> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> ---

[snip]
>  
> +	data->privileged = ethnl_is_privileged(skb);

Is not this potentially creating a time of check/time of use issue? Can
you check for ethnl_is_privileged() at the time where you fill in the
reply skb?
-- 
Florian
