Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B721C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C38221473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="gBlt9XMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbfEMPgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:36:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38703 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbfEMPgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:36:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id 14so11405010ljj.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 08:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aBobX/gRQlSguqoBZZQLy/K1F4tBo5qMszjuejS20Co=;
        b=gBlt9XMxpnYqx/4cyDasaIs3y4oMCc99NXC9pZof4vo3wRkQsQuOQBAmGySmbeIsnT
         pGlcYsS4yR9ytTI6FC1eSjbPpj8iz4s9dZBkDcrSiPAPC7OMzW0Rt0OqIJrPgtasoPCC
         r1LwRRJMyGIeT5nK+1RtGNaHi07nNrgYKip5lk0MdY8M8i+ortxgZcPNOlwIaF3i2knk
         k8J9A+Kc8GGfGKhqh/R2ogQFyXVw8qLb70PRA9fmxiriz2JDhlOr9Yn/Kz/5CvFVx+L4
         /j+HRZj4hBADoWB5wd5ni0jZq65JQozmkv8mwyQYZgxiIQZjdhUkU1QQujGdGVWS5gX9
         Rbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aBobX/gRQlSguqoBZZQLy/K1F4tBo5qMszjuejS20Co=;
        b=IoSNkhOUPgSMx57L+tEcddNoWZ2EtRQOOjqr+HImUiUb2l4b/c+j75JmQ36fcWnPGS
         bywSN2B9QQY4bjPornX44Bc11MVakHjHweyH0gKaMSAApfzeyllaMSRiRyvclPMGUeB5
         NPLrt4B28bwqayQqMD57vxFI2xbTUl7hM7oaBRvvLDDXg0wuDvAAWQEfRvlOa3iIpElj
         CtmS2XCaWOu71yuyOBCAjZ0b1JRHv2rBALnLRW4nrWd8RUG2NNuvcQoDHUrwXXjnKcHp
         p9gs35HlxfVUXBnvtCAIz/B9w+7fbiDSD7vXgjNqNxw2LbndSizQqDKr50/wkl2B6bm/
         /5ug==
X-Gm-Message-State: APjAAAUcjtwkzsyXoVBQYXUGYh/ejHclrohwVZKfzuJ8/JvkGb7UEdns
        CatvHKnOfE4tZgDcQONrfqRPNg==
X-Google-Smtp-Source: APXvYqx7EAgiVp7E/GNOloy5P70soEYmNXt7Mr3QGKLLM+PPeltgJmRtjYkCOSVI8X18cOxFkFgHYw==
X-Received: by 2002:a2e:9713:: with SMTP id r19mr14381849lji.189.1557761772644;
        Mon, 13 May 2019 08:36:12 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.81.227])
        by smtp.gmail.com with ESMTPSA id t23sm711845lfk.9.2019.05.13.08.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 08:36:11 -0700 (PDT)
Subject: Re: [PATCH] net: ethernet: stmmac: dwmac-sun8i: enable support of
 unicast filtering
To:     Corentin Labbe <clabbe@baylibre.com>, alexandre.torgue@st.com,
        davem@davemloft.net, joabreu@synopsys.com,
        maxime.ripard@bootlin.com, peppe.cavallaro@st.com, wens@csie.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <1557752799-9989-1-git-send-email-clabbe@baylibre.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <a4c3f91a-cad2-29f8-841f-df1a0fee0781@cogentembedded.com>
Date:   Mon, 13 May 2019 18:36:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1557752799-9989-1-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 05/13/2019 04:06 PM, Corentin Labbe wrote:

> When adding more MAC address to a dwmac-sun8i interface, the device goes

   Addresses?

> directly in promiscuous mode.
> This is due to IFF_UNICAST_FLT missing flag.
> 
> So since the hardware support unicast filtering, let's add IFF_UNICAST_FLT.
> 
> Fixes: 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
[...]

MBR, Sergei
