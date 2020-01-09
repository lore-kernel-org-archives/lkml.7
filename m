Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BF4C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB18220721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRXocOZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbgAITpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:45:17 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44988 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbgAITpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:45:16 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so6076272lfa.11;
        Thu, 09 Jan 2020 11:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dh965pyg6yJaczZEQBcCfsc1pMW2w82DIeLqGYULK+E=;
        b=VRXocOZAoKzB82Jw/PRy9YRzdjjcmZs2FUeO5YsiGhONRrrVSfFWK71LFzW9/BIWSC
         yP0m7hF1SZSIEW7Xy005SN96B7KTgwONVrxXA/qrdSTbOUiyHC4w8+F6gSUnuLhPmrnG
         tyxXr1FhcyM8oRVbts4YkYUn/kkZiJMf0fKXMYxxGEDXDGoCfGEORCGxaMjGE9FCa/bb
         yYbVsOunhlWrokPfGjiAF1E6DYLadmgdvpxsZbHJR5bQDGv/lFgCBXyqe2HzDuE6VM78
         /xOaoujXlm7wS7o2rO4vTUwbfyRUQULfx1JjVbk7XyYl/N4f+gUo77IILO0fW/DrH/tK
         L60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dh965pyg6yJaczZEQBcCfsc1pMW2w82DIeLqGYULK+E=;
        b=kZw7MKN9EQloi+fJEhc6slJQxEnfhKS3TTwqHSa6YO4PQ4Okc9exO9zUcG+pTtmKg5
         oxjQ4vRWmiLt4AO+IVz9TcaMl4A+GxXTSasEceadM2beU27oWAg5Pzu8k31u2aFmkpkX
         /Mo9PNLg+W4ZuPNmhc/Sk86k4ro6bO8bkiwhTwwX3SH6L4gh/Gq1Pty7UXqgP03L+f2D
         cyi8v6BwfY21tnRQDoY3QNXkgCS+jr4d9McFGTji++aBSCfXnxgKaq3dbysQ0wGcFXhH
         u4WL01XXRs4PXFX3sgfThrXd1GokStqQs6JwMzvwVv2c6ZLuzZox8wlNy/jNk7RxUECR
         6hWg==
X-Gm-Message-State: APjAAAUcn9Me+/dGACdeLfB0PoXBNurYnERTHza/UQRJCL+Hjwm1ww7T
        u/jDosNR5WmLGQZ1PDiEvAmUmNcI
X-Google-Smtp-Source: APXvYqxo25T5sB32MBbgdcG+eY2nOkXiZ+jaJEFvCKhGGmbZ6sKpWTqQKxVqfSNwsM9eTpFBsk9MZg==
X-Received: by 2002:ac2:51a4:: with SMTP id f4mr7720175lfk.76.1578599114211;
        Thu, 09 Jan 2020 11:45:14 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id h7sm3540147lfj.29.2020.01.09.11.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 11:45:13 -0800 (PST)
Subject: Re: [PATCH v7 05/21] clk: tegra: Fix Tegra PMC clock out parents
To:     Nicolas Chauvet <kwizart@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, Rob Herring <robh+dt@kernel.org>,
        mark.rutland@arm.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        spujar@nvidia.com, josephl@nvidia.com, daniel.lezcano@linaro.org,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
 <1578457515-3477-6-git-send-email-skomatineni@nvidia.com>
 <CABr+WT=qP1BJUfzgmr4AzN18Zp-trMEStF6SQ+AH7+aYBUuUww@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <94661229-58e6-a43f-50fd-0d0f65c0339c@gmail.com>
Date:   Thu, 9 Jan 2020 22:45:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CABr+WT=qP1BJUfzgmr4AzN18Zp-trMEStF6SQ+AH7+aYBUuUww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.01.2020 11:34, Nicolas Chauvet пишет:
> Le mer. 8 janv. 2020 à 05:27, Sowjanya Komatineni
> <skomatineni@nvidia.com> a écrit :
>>
>> Tegra PMC clock out parents are osc, osc_div2, osc_div4 and extern
>> clock.
>>
>> Clock driver is using incorrect parents clk_m, clk_m_div2, clk_m_div4
>> for PMC clocks.
>>
>> This patch fixes this.
>>
>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>  drivers/clk/tegra/clk-tegra-pmc.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/clk/tegra/clk-tegra-pmc.c b/drivers/clk/tegra/clk-tegra-pmc.c
>> index bec3e008335f..5e044ba1ae36 100644
>> --- a/drivers/clk/tegra/clk-tegra-pmc.c
>> +++ b/drivers/clk/tegra/clk-tegra-pmc.c
>> @@ -49,16 +49,16 @@ struct pmc_clk_init_data {
>>
>>  static DEFINE_SPINLOCK(clk_out_lock);
>>
>> -static const char *clk_out1_parents[] = { "clk_m", "clk_m_div2",
>> -       "clk_m_div4", "extern1",
>> +static const char *clk_out1_parents[] = { "osc", "osc_div2",
>> +       "osc_div4", "extern1",
>>  };
>>
>> -static const char *clk_out2_parents[] = { "clk_m", "clk_m_div2",
>> -       "clk_m_div4", "extern2",
>> +static const char *clk_out2_parents[] = { "osc", "osc_div2",
>> +       "osc_div4", "extern2",
>>  };
>>
>> -static const char *clk_out3_parents[] = { "clk_m", "clk_m_div2",
>> -       "clk_m_div4", "extern3",
>> +static const char *clk_out3_parents[] = { "osc", "osc_div2",
>> +       "osc_div4", "extern3",
>>  };
>>
>>  static struct pmc_clk_init_data pmc_clks[] = {
>> --
>> 2.7.4
> 
> Out of curiosity, this patch touch the clk-tegra-pmc.c file which is
> later removed (by patch 11).
> Is this change made for bugfix ? Is there a stable tag missing ?
> 

This is not a bugfix, but a minor correction which doesn't need a stable
tag.
