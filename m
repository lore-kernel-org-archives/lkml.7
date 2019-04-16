Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91BAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868EF22394
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh5qQhCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfDPN7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:59:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39956 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDPN7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:59:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so4102795ljq.7;
        Tue, 16 Apr 2019 06:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XY54RCXW8EoxaCQWLe7doB13qrmZ0H1D6e5cjG1IQ1g=;
        b=gh5qQhCdLkCqTleEyHtaqL5LwERLf43XYZb0kvOc+u1ZfvJamVFcFNU1iun1ZcM4Gj
         OKZpVjfpmIzQlZGqB+GxvpiJl40azxyQUwsnuGJtlH/wRA4Cn6tSBgxMbXRcbEu3J9+8
         HuGy5VVUaS6v/kXY+T9xbMMIo3xJ9LaFTun4zH8u/HdOWxjF818xjRmhCavXmXLHR5co
         aAP/0KDCiOi2uS9YxD3uKUmcJFEfLeOIKp6r9bJhxH/lhk3u3QiMlEnKpTe6V0+1dsfp
         GOzPxB47jyO2fCPt+Q7yZjlqnBCcG82xv4MzIhFkTLJJO8306axfnAHRa8PO4rqsiIzM
         D62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XY54RCXW8EoxaCQWLe7doB13qrmZ0H1D6e5cjG1IQ1g=;
        b=TnP38PI4iji3JZR/dLESNDNCsJn5kVEmtiCJYSGAVGd6NWRnU0pFRvR+EPyDQKWEep
         yK/ndO29x1LsjrUaOQ9oZBjUrgpCzM33A+m9Z73xx9X4gxxUu+DKo5i5XJDh7XXf5mg/
         uz0uFv/wkrirEZT7jBHi+j4fS/XR70PKs792Aba1KIBAs92NTDmqQl72Llc+spSoGShZ
         umh1vB/8Wz9HzWq4vHsYg6gZIAzd/G4Pa2ZxGqxC2YFue7LcfxfrQkse87dTm94gszJT
         RIKN/gYemF54jdiT9Amr/wcb44oyMTmcqgNYh1I6slGU1+3wdWbrK2JnW4AHUMrCnmpC
         DaaA==
X-Gm-Message-State: APjAAAV15/v8kTVZynof2WH1ktRXBN3Aw5LOBNTv8jmdq3c/emgHP2iu
        zDLmdoxdu9GZNqDeQIcI7UBo1nCZ
X-Google-Smtp-Source: APXvYqww2fmCI7gM4fWilo6MNvmILW2J5OkO9evJD2ujA37dv5LQQeU9w7tZ0bjXBTYdyVlb3yQe8Q==
X-Received: by 2002:a2e:380c:: with SMTP id f12mr46340062lja.116.1555423151078;
        Tue, 16 Apr 2019 06:59:11 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id n9sm10303083lfl.35.2019.04.16.06.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 06:59:10 -0700 (PDT)
Subject: Re: [PATCH v2 05/19] PM / devfreq: tegra: Replace write memory
 barrier with the read barrier
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20190415145505.18397-1-digetx@gmail.com>
 <CGME20190415145805epcas1p209d0e2a8ba052ad11e91155c4585b1bd@epcas1p2.samsung.com>
 <20190415145505.18397-6-digetx@gmail.com>
 <e0a9def6-e3ed-f134-e612-aa257aa3fa12@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1ef32d1f-895a-5006-5760-bf2c070bc6e2@gmail.com>
Date:   Tue, 16 Apr 2019 16:57:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e0a9def6-e3ed-f134-e612-aa257aa3fa12@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.04.2019 11:00, Chanwoo Choi пишет:
> Hi,
> 
> On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
>> The write memory barrier isn't needed because the BUS buffer is flushed
>> by read after write that happens after the removed wmb(), we will also
>> use readl() instead of the relaxed version to ensure that read is indeed
>> completed.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra-devfreq.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>> index d62fb1b0d9bb..f0f0d78f6cbf 100644
>> --- a/drivers/devfreq/tegra-devfreq.c
>> +++ b/drivers/devfreq/tegra-devfreq.c
>> @@ -243,8 +243,7 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>>  static void actmon_write_barrier(struct tegra_devfreq *tegra)
>>  {
>>  	/* ensure the update has reached the ACTMON */
>> -	wmb();
>> -	actmon_readl(tegra, ACTMON_GLB_STATUS);
>> +	readl(tegra->regs + ACTMON_GLB_STATUS);
> 
> I think that this meaning of actmon_write_barrier() keeps
> the order of 'store' assembly command without the execution change
> from compiler optimization by using the wmb().

The IO mapped memory is strongly-ordered on ARM, hence all readl/writel accesses are guaranteed to be ordered by default. I think wmb() here is just a cut-n-pasted relic from old downstream driver.

> But, this patch edits it as following:
> The result of the following two cases are same?
> 
> [original code]
> 	wmb()
> 	read_relaxed()
> 
> [new code by this patch]
> 	readl_relaxed()
> 	rmb()

Yes, the result is the same. The wmb() is not just about IO accesses, but about all kind of memory accesses and at least on Tegra30 it is quite expensive operation because it translates into L2XO cache syncing (arm_heavy_mb) + dsb(). It should be more efficient to flush out writes with a read-back and then wait for that read operation to be completed.
