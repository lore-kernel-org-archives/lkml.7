Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB858C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0797217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmueB0y3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfEJTuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 15:50:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32826 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfEJTuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 15:50:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id y3so3300284plp.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 12:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VTV0JN/9ENBFAZ0M/QxnnD6SZBBv2/kjRYCYKZs9XPY=;
        b=KmueB0y3i3qGJRDvmqPH7URjqw6vyz21hMQLM6dIjWYJfsJT748elaM5ki69ZsCxhy
         vxbqKOHWIyV8ReOjykYACi7FVCoNWRDt91ciq3Pnpiu1qapcb51RnoIF6zEX62Nvqwep
         CGfE0yBTWRmT4JRYz6ezs0EFqOJO17u6j6rZCLvOG4/HZ4oq251CXJ89isw05VbAR3fJ
         oviNGbVVgSu6CkJRBuORh/E9LxXBz5Y9bXqtxAmSYJxdbKulxm81k//x37ZlE9/2xui4
         BUvHoTStvYUbZGqbZXZshB+p5n+hEbZ8ljd0qmZLuWN4aeVdesUDlDfZf6XseDTh8v/i
         0z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VTV0JN/9ENBFAZ0M/QxnnD6SZBBv2/kjRYCYKZs9XPY=;
        b=OEDl3k7osNtb4chDg+WmL1Oa65ugJFvmDpACCFwPgIrnteUmEVTbRPNLOiIOjYPilK
         SpOOG0gyC2gmSXgC/QSmsTyITbOR3EQGcgUNwzAY24GhvbhoA887Zw5xHkfcVL3QxfC5
         cRGzjlOOJiIGuexQc5JgYg8ECLDTn9IAm17edySbRfswXOPqakkNtCs7uerATjd7pqAC
         q1tgZaFpweiYxiZjh1cxZ7aT6ENGT9ElpMDp4hNo0sEmBaRrjkdSb5ifA8oh+b8Lrb8x
         rukLmB9f2ZZPTCu3gBOOXIyOvyc9F8GZzJ7ir9NrxSiF7QrK4Me9rhclkA7N4m9hOk9G
         ALyg==
X-Gm-Message-State: APjAAAXzEjbJLlD88/YaWBwvHyM0O75eTJQTBeiZZcOtDy3VhGZ5gn1a
        Db/I+y5z8ho7M7e13uiCnYs=
X-Google-Smtp-Source: APXvYqyEgLetPROw+a8Ih2sAxmk+DAl8vQXbNDMUFVN32Ua3YGpVihSDCAOH5kJQ9mns8dTgqr5D6w==
X-Received: by 2002:a17:902:7247:: with SMTP id c7mr15624487pll.65.1557517803401;
        Fri, 10 May 2019 12:50:03 -0700 (PDT)
Received: from [10.67.49.52] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id r138sm13499445pfr.2.2019.05.10.12.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 12:50:02 -0700 (PDT)
Subject: Re: [PATCH v2] perf vendor events arm64: Add Cortex-A57 and
 Cortex-A72 events
To:     John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "moderated list:ARM PMU PROFILING AND DEBUGGING" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190502234704.7663-1-f.fainelli@gmail.com>
 <5c04ebac-3e3c-fa53-d287-3a602a350091@huawei.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <a8a3c429-307c-40fc-12b4-d62374bfda1d@gmail.com>
Date:   Fri, 10 May 2019 12:49:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5c04ebac-3e3c-fa53-d287-3a602a350091@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/19 12:25 AM, John Garry wrote:
> On 03/05/2019 00:47, Florian Fainelli wrote:
>> The Cortex-A57 and Cortex-A72 both support all ARMv8 recommended events
>> up to the RC_ST_SPEC (0x91) event with the exception of:
>>
>> - L1D_CACHE_REFILL_INNER (0x44)
>> - L1D_CACHE_REFILL_OUTER (0x45)
>> - L1D_TLB_RD (0x4E)
>> - L1D_TLB_WR (0x4F)
>> - L2D_TLB_REFILL_RD (0x5C)
>> - L2D_TLB_REFILL_WR (0x5D)
>> - L2D_TLB_RD (0x5E)
>> - L2D_TLB_WR (0x5F)
>> - STREX_SPEC (0x6F)
>>
>> Create an appropriate JSON file for mapping those events and update the
>> mapfile.csv for matching the Cortex-A57 and Cortex-A72 MIDR to that
>> file.
> 
> I suppose you could have also created separate a72 and a57 folders, and
> used a symbolic link for the json. That would have kept the folder
> structure consistent and neat.

Will, Mark, any preference on that? Either way works fine.

> 
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Apart from the above:
> 
> Reviewed-by: John Garry <john.garry@huawei.com>

Thanks

> 
>> ---
>> Changes in v2:
>>
>> - added a shared directory for both Cortex-A57 and A72 (Will)
>> - removed unsupported ARMv8 v3 events (John)
>>
>>  .../arm/cortex-a57-a72/core-imp-def.json      | 179 ++++++++++++++++++
>>  tools/perf/pmu-events/arch/arm64/mapfile.csv  |   2 +
>>  2 files changed, 181 insertions(+)
>>  create mode 100644
>> tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
>>
>> diff --git a/tools/perf/pmu-even
> 


-- 
Florian
