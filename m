Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026EEC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C232063F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIG8RNUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEBVlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:41:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55368 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEBVlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:41:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id y2so4474831wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 14:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=War2A0BOAbp9GPGMi2vdiNC4OWUlay+EdjS3sCge9Bk=;
        b=tIG8RNUh4+cHOE8iaUA4ZU94KHEMJsE/6WIdRFiK8x6sc9GI/dOk+wXYGPLJV1y1TT
         Fmx3NqmEMbqhIsMQZzxtnGnkurwMZbvgb+JD65zb5Fq1dNNtIWQ0AZjHO0/iEbXBaV5Q
         uBs6CkjIoUFSiX0cyksEECWqMff4F7/Zrw0Grtqce0e8VO8amXV1FabBNGbLIA3ohBY6
         XfOBWblMg3RgcJSw7ZRSym1u9WMmTCEShq6H6408x1iA8oKcfx68bi9/EMGwR5sVxWJ1
         As4uR8ZfRkURFVA6A0YfH6QgJZMMTzJwGA7sfaev2By9yes5h5mSsIoIEPC2ShZdFQTQ
         ftDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=War2A0BOAbp9GPGMi2vdiNC4OWUlay+EdjS3sCge9Bk=;
        b=Ruy4EcNXJbr6M7+0upe2OIoi9x3FeRGjPreJcE7zT6c+cgYlEVDABHeD53mZmEJnid
         tTrS8YQo7yoLL4x+GDGNraE5UAOfNhxt/bny0gIM2OrP/dNMwf9gjJkUjx0MfEMQfdpd
         CxZAPAbW8KG0xeAS0Uoxirn09Rcfx28S1tWy5VysknMzJZ8B5dmsqFNajbq82gH72Ynt
         R1pCcnk7/xXniyPj0mUwVE0B/Lkh7AhqNeF14vBzBsAKAhwKDfYeHEF90ygo+BYIZYo9
         udwba6fHj/i1EWFXnktgCZrEnxpfwFuXvxDiHWR8Z5Mb65JWN9gv2iPU0cKTA65QIkjf
         1VLA==
X-Gm-Message-State: APjAAAUpQc3bU2Hzl5kTxNFufcPnc05NiCz2UJZAMgBJSpHg15+X2XY2
        Nb3XIUaTN+w137Y/YiJEcPM=
X-Google-Smtp-Source: APXvYqzv0Ge2Wf6G3J96Pe76QE3G9bpmy7gUZDimyUbrDY7fIrv85yKW8LfOEJZiXBeB+lvE8yqP8A==
X-Received: by 2002:a1c:d14c:: with SMTP id i73mr3634429wmg.21.1556833309736;
        Thu, 02 May 2019 14:41:49 -0700 (PDT)
Received: from [10.67.50.73] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id y197sm249397wmd.34.2019.05.02.14.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 14:41:48 -0700 (PDT)
Subject: Re: [PATCH] perf vendor events arm64: Add Cortex-A72 events
To:     John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "moderated list:ARM PMU PROFILING AND DEBUGGING" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190407213422.19059-1-f.fainelli@gmail.com>
 <1a7b28b0-3fee-f3b9-0e83-61a2759c0555@huawei.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <f1e76036-1626-153d-efba-2eabf6e1075f@gmail.com>
Date:   Thu, 2 May 2019 14:41:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1a7b28b0-3fee-f3b9-0e83-61a2759c0555@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/19 6:01 AM, John Garry wrote:
> On 07/04/2019 22:34, Florian Fainelli wrote:
>> The Cortex-A72 supports all ARMv8 recommended events up to the
>> RC_ST_SPEC (0x91) event, create an appropriate JSON file for mapping
>> those events and update the mapfile.csv for matching the Cortex-A72 MIDR
>> to that file.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  .../arm64/arm/cortex-a72/core-imp-def.json    | 206 ++++++++++++++++++
>>  tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
>>  2 files changed, 207 insertions(+)
>>  create mode 100644
>> tools/perf/pmu-events/arch/arm64/arm/cortex-a72/core-imp-def.json
>>
>> diff --git
>> a/tools/perf/pmu-events/arch/arm64/arm/cortex-a72/core-imp-def.json
>> b/tools/perf/pmu-events/arch/arm64/arm/cortex-a72/core-imp-def.json
>> new file mode 100644
>> index 000000000000..eb82fc8529c6
>> --- /dev/null
>> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a72/core-imp-def.json
>> @@ -0,0 +1,206 @@
>> +[
>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_RD",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_WR",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
>> +    },
>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
> 
> I'm just checking the A72 TRM, and this does not seem to be included,
> that being event number 0x44.
> 
>> +    },
>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
>> +    },
> 
> Or this.
> 
>> +    {
>> +        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
>> +    },
>> +    {
> 
> Please check this.

Indeed, thanks!
-- 
Florian
