Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4E3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3295218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 04:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tL8buQTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfB1ERk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 23:17:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42524 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730463AbfB1ERj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 23:17:39 -0500
Received: by mail-pg1-f195.google.com with SMTP id b2so9031048pgl.9;
        Wed, 27 Feb 2019 20:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hjN1GdXbLPw2JjOrkQmUscCmbdeCBgc0oDcoeIPC7u4=;
        b=tL8buQTIVeJkfbZNDBkIrtTQCcxoHJi5e+MMloPKZpgVwltJQwWiU8j2L97lJMEDWN
         42EB2+EsOW1t/4PxywKsYWOntUf7Y5kVIVTqfOaNdsM1BU/5V6sgEa8HBGvmKAFsaA+s
         JZ8dl38Bcw7UXndZt3Y172OkG+81AzpQJuTZO4MxN1OJo+/D9Hth8SbergsmLuWDKBgG
         0S5Byi+Y5MaSDDBr4QzmYniEB6zwQyrL2cntKYThm/fTXQB6/i4DP2ehwjy4Oxra3CCG
         71Wu5iG9vSXvB8qOTHC/qlOXiO8e/ZKh98pCIwZ8pE9fYsbdESi3JIS+3WnCbjNxm1Th
         NGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hjN1GdXbLPw2JjOrkQmUscCmbdeCBgc0oDcoeIPC7u4=;
        b=PK1/EJd7YJ9+Tr87tHbwup86rdlMlgkM0TMyH2D+2yobkji/gFN2WRTHa28h67JRbo
         dIc4bqZfSWRtaldpogyzb26IgYfGit403ByfICmELCSpI/gOpjS3eTH5plye9giCDDC5
         IJLfdsqn96C2Y8GG4cIa8znOxivs2ApoflGR7Y+ihL2o1q0alzmaXqU53qNt0Rubeor1
         IWFK9WKqqjLJWa0cZZcwoGlIz75fo8JlS3YXpRCYbtVHVHqr6OZBQ2pLFpROD8H2nmsX
         FUEZik01ErPH6n5LrEbgGAZnY1ZZYh3yTzV6Ilq0rp12p7wP5YEVUSxB0YnzAWVE+QP+
         bfjg==
X-Gm-Message-State: AHQUAuYZCvR/mTr/XbR3QpcgfhOzyjH6Bed7iW3HxMxqksNUqOA7V2Pi
        uz+Bg7cULgxtBRYo6kiYyqo=
X-Google-Smtp-Source: AHgI3IaX8O46nrTL23xLOvGUjywvEqv651YBfZjnx73Diq1YCtAT0FuUur34Jw3KVt5A+mh7z5FKwA==
X-Received: by 2002:a62:b61a:: with SMTP id j26mr5289613pff.151.1551327458744;
        Wed, 27 Feb 2019 20:17:38 -0800 (PST)
Received: from [10.230.1.150] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id s4sm14642750pfe.16.2019.02.27.20.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 20:17:37 -0800 (PST)
Subject: Re: [PATCH net-next 5/6] net: ethernet: ti: cpsw: update mc filtering
 to use IVDF
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net,
        grygorii.strashko@ti.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-6-ivan.khoronzhuk@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <1f68e415-e022-e4a2-6123-b3ebc2ff797b@gmail.com>
Date:   Wed, 27 Feb 2019 20:17:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190226184556.16082-6-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
> The cpsw can filter multicast addresses only per vlan. Thus if mcast
> address is set for one of them or only for real device it must be
> added for every created vlan consuming ALE table w/o reason. In order to
> simplify dispatching vlan filters, the IVDF recently added is resused.
> 
> In case IVDF is disabled - mc is updated only for real device as before.
> The previous method is harder to reuse and vlan filtering is limited
> only for vlans directly connected to real netdev, so drop it in flavor
> of IVDF decision.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
>  drivers/net/ethernet/ti/Kconfig |   1 +
>  drivers/net/ethernet/ti/cpsw.c  | 113 ++++----------------------------
>  2 files changed, 13 insertions(+), 101 deletions(-)

Nice diffstat!
-- 
Florian
