Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70532206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iszv+5bg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfC1DwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:52:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44497 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbfC1DwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 23:52:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id g12so4318361pll.11;
        Wed, 27 Mar 2019 20:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zKeJHF8Fm5rNYOXMS2nDgi4nCJuDVCjRQW1/Gpyx6GY=;
        b=Iszv+5bgnHVDuhWH/4VN/KPdYtKE3yBmSFvCLpQSlXkHHwOBBTAtPRcfEGkKETwjpe
         uiljfCXPMPDHFceV6fHyvfpQUa5vEsGGllaYHQDsIeUgG/vHPHYP0mxojj1eIot8k91u
         hD34A6J+aXCccbRzdhB0wrGfmJkT6/Ru/bIf/MDwZjfVyy62O8uxe0qR509GZ2mSM3Ns
         of474B0yeEO4xf8rAQb9ZmL5Ya5im0YeP08/4tA23nILd7ATaM9/cm5JDu9h3h2DQYsq
         0LjkKHR5TEH8POVtx2NYQZLehWBfe6h8hi4KvM6fbWfOuyyroe2usTFIYv499HlTw1zd
         j93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zKeJHF8Fm5rNYOXMS2nDgi4nCJuDVCjRQW1/Gpyx6GY=;
        b=lm5Sc82JagGH2cWdvAgYmd2ZJyFDcW3RLIVqE+Ng6oeWVETSjG9BYGw2IuLQQ3SNrQ
         +FqU2vMLzF/E0V81xEMh/CEVO3QCoKbj3gUNHGRUFYLOZ3nS3RF8g6MZxVhLzvvtKJhG
         Ae6ZT6iQ9kcV8I2yj6wSUqmAbW7tpl9r/+dz6SvLxOdbredyfIly5y0SXTWEaL0Airz/
         gwTcqnqacOTIRNn97HPOZoYkw475LnQpMR93fARN8XkclyCZ6o8Crf9a5vcM5Y+R7V+o
         BM1F5ziB/hT/Z3aBf4qAgTE/n/MDPt7oUs/PjN6/L+aCAj0+9hSMZjLS7+ljrbBlmufH
         eTDQ==
X-Gm-Message-State: APjAAAVYvS0FDkOOpPOpzcU1iq/SHgwboaDsgpxpBpb68TJL8cXpyFLk
        ZW8fFsiUEz8Trn/YCSj4z0ktBI84
X-Google-Smtp-Source: APXvYqwl7bP9rzZekm6Sqpn+nzafZVGWaU6ldavBGBpQbiXBK3ma5ebBHwUftCnKphUKvrYgUlOoJQ==
X-Received: by 2002:a17:902:1e6:: with SMTP id b93mr40548565plb.325.1553745126599;
        Wed, 27 Mar 2019 20:52:06 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id p3sm17049796pfn.167.2019.03.27.20.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 20:52:05 -0700 (PDT)
Subject: Re: [PATCH net-next v5 15/22] ethtool: provide link mode names as a
 string set
To:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
References: <cover.1553532199.git.mkubecek@suse.cz>
 <823fb9fb5d2055836719962d30befbc5da8e9310.1553532199.git.mkubecek@suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <cd7e73fe-977f-2257-2d2b-4b87cdcbf84f@gmail.com>
Date:   Wed, 27 Mar 2019 20:52:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <823fb9fb5d2055836719962d30befbc5da8e9310.1553532199.git.mkubecek@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2019 10:08 AM, Michal Kubecek wrote:
> Add table of ethernet link mode names and make it available as a string set
> to userspace GET_STRSET requests.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
