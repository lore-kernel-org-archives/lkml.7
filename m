Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A661C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED5B2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFMbC985"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfDLKLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:11:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36184 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfDLKLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:11:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so8362997ljg.3;
        Fri, 12 Apr 2019 03:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xn/jl0l8wy9Wx4YR6VFKnd5ygUGyyHcHvo4Be+M6xsg=;
        b=cFMbC9857mvJYXH/vgoXZmP+JvUeCFIdD1jgwpkHv3CdFZM6nBjw3lC0ht7tX2PxOO
         J+nxW6rYvzsm8nscVQOjAcvxasKoq5UzOnExN/B5uqVKCMALJEDaxGI9+OT9FLFMEz7q
         rxFyBMEH6BuI1v3vPJmUhISAIEUmDpV+ImXtAjK+GKS4Nzk1YPZd30rEBjgYKuzsIYf9
         BBuiR7ny5nouVJWajxTAX2zFpStp8DPfzlqVAeKdwKfvZfLh5oR4jfMQlFGnDOz23Ccw
         VM/9LfyOG64rTwu1WrCp4hdaQj8VpbuOxf26X74PGKbPhl9sonY56Y3TcR1Mrrt96Bm6
         9pvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xn/jl0l8wy9Wx4YR6VFKnd5ygUGyyHcHvo4Be+M6xsg=;
        b=RbiDx+h8x7S6+nTQ+Un89SBTR7pvJKLkDVY0m5S+eZEAA4igBEKOmNFDNHE3MRak1L
         b3flolsnXdPAd3e3gz5Ic1Kw6G9QaDK5DKoc1e0JcEGRobEVwJFDtzAv9w4O4eWuI1Fr
         aWF3jniR2rj5rFAV7htCDaWpKkQZGCqEy2k0wstY9yknc8VsJ6V8V+qGgxN8jhmGA4ZV
         J1iwODt2MKsFLzxiSSEwQSIEzBBb+EQ63xhOoLEIaG5a3IxoAK2F7evdICtPlFRCIGA/
         h2ze6fCl2AwypU41NWceuVCqohMtNUHYkbRYd8SfXRxr3IUUigS37MEtSRiYKHR9qlAJ
         RfEA==
X-Gm-Message-State: APjAAAW5IR1v3n6EqjgZTo0EDNcJ9HrGwzFo35kQjapUMu9F2+i/0nsb
        6+TIrIIEFmjWP9zxPpjiy0uwDkk5
X-Google-Smtp-Source: APXvYqweQSml1+I6D0wAdHOtlhBpRWHGCKSRiIVOsfH6kdsQeNQpuiHv94gvu3mjHJlM1L5xyvZpbQ==
X-Received: by 2002:a2e:2a03:: with SMTP id q3mr29594341ljq.56.1555063892915;
        Fri, 12 Apr 2019 03:11:32 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id k25sm8116996ljc.14.2019.04.12.03.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 03:11:32 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] ARM: dts: tegra30: Add External Memory Controller
 node
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190411230221.31362-1-digetx@gmail.com>
 <20190411230221.31362-4-digetx@gmail.com>
 <20190412080606.GH12975@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <17f2a6b4-8017-0581-d7a2-6ff1cd914df1@gmail.com>
Date:   Fri, 12 Apr 2019 13:11:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412080606.GH12975@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.04.2019 11:06, Peter De Schrijver пишет:
> On Fri, Apr 12, 2019 at 02:02:21AM +0300, Dmitry Osipenko wrote:
>> Add Add External Memory Controller node to the device-tree.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
> ..
>> diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
>> index 38ebdb076ccd..defdb38bde54 100644
>> --- a/drivers/memory/tegra/tegra30-emc.c
>> +++ b/drivers/memory/tegra/tegra30-emc.c
>> @@ -980,7 +980,8 @@ static long emc_round_rate(unsigned long rate,
>>  	}
>>  
>>  	if (!timing) {
>> -		dev_err(emc->dev, "no timing for rate %lu\n", rate);
>> +		dev_err(emc->dev, "no timing for rate %lu min %lu max %lu\n",
>> +			rate, min_rate, max_rate);
>>  		return -EINVAL;
>>  	}
> 
> This doesn't seem to belong to this patch?

Yes, I accidentally edited a wrong patch on rebase. Fixed it up for v2 already, thank you.
