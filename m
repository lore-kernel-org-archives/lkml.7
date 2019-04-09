Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B65C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44AE2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3RWtpBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDIOa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:30:57 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:46109 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfDIOa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:30:57 -0400
Received: by mail-pf1-f172.google.com with SMTP id 9so9796412pfj.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 07:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v58eMpfsbiEIl9l4zzEufgNsVEjnb59XTH7GyJk9IOs=;
        b=C3RWtpByHtpPFSYe0sLTPnvvrnMOPvTbKwBWj+qHmmjlhgDES+r5KR9aDKmqKqCWeJ
         pHydW9SBZfKbe67XlyqjvqBRize5Nt5efTOOAJUwLonGNhz6Zf+9tUE1uYDFpAyQuSrP
         LZW8yQjOtLwjq4Fbo2sGllOlMSN3Wd7Vo5ga0boLcxX3lUpbxnGlP5YLC6RfT8+E0DUk
         O3HefkAETo28n/BNnqHBXSVn8h8IacGnmQe8u7m90avfz3fSWvSPu1LrvqPkrNSAFXQ9
         3nk9GO1yW1OvSKHKUwMf1+NPQSgIr55Tuk22q4iQoahFH2r5xY+zhzbSq9G5NYDKp0kd
         NOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v58eMpfsbiEIl9l4zzEufgNsVEjnb59XTH7GyJk9IOs=;
        b=nLjOv+uS2NSAg1hXAyroVrr6Wx6o6NW14wV9LgRcnKBo348sWpV6987PEDVz9t2yhz
         yoUpnj4GcMvwh20lMywLHLkJWyR6zAbrSrbicquNU0dtQszw9jkz+/Jp0g1KgSRSzxg9
         HD06yWZr3sm8ZNQrAB/EQ3uNbfz6AAK0ZTd1q4w6RQvN4a7GHOdYMCuW8aWs3mgFLu98
         gPxVVhGGkYipFZ7E1sZv5q/AkB0iLGdQcMgh0876mS82UV9YjkUhYQHb+Z+VcxUKNktQ
         e4B0OgTdhIPxw+jfb6L2ywOVRkKSNV7rQWO4SYtdnxljBjKkVcQzHciE6Zbo7/7L+WeK
         rhBg==
X-Gm-Message-State: APjAAAXZ/gPoemVwoxQVoKL+X5k0N+bjL8td9H1LSJvVmfWgsyzmGw3k
        nRtUhdxQnAuCh61GqkQQRuU=
X-Google-Smtp-Source: APXvYqxvNbk3RY0sjC9xAFiUP6EE6HeshGcGfwUQEMquPb1kHVWV40vIHakXttXtl+quo+g1Q5EktA==
X-Received: by 2002:a63:6988:: with SMTP id e130mr18607721pgc.150.1554820255577;
        Tue, 09 Apr 2019 07:30:55 -0700 (PDT)
Received: from [10.230.28.107] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id g64sm75692364pfg.13.2019.04.09.07.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 07:30:54 -0700 (PDT)
Subject: Re: [PATCH] perf vendor events arm64: Add Cortex-A72 events
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "moderated list:ARM PMU PROFILING AND DEBUGGING" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190407213422.19059-1-f.fainelli@gmail.com>
 <20190408164733.GC7872@fuggles.cambridge.arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <7771bb01-30a1-4b52-b887-1d6651085c85@gmail.com>
Date:   Tue, 9 Apr 2019 07:30:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408164733.GC7872@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/2019 9:47 AM, Will Deacon wrote:
> Hi Florian,
> 
> On Sun, Apr 07, 2019 at 02:34:22PM -0700, Florian Fainelli wrote:
>> The Cortex-A72 supports all ARMv8 recommended events up to the
>> RC_ST_SPEC (0x91) event, create an appropriate JSON file for mapping
>> those events and update the mapfile.csv for matching the Cortex-A72 MIDR
>> to that file.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  .../arm64/arm/cortex-a72/core-imp-def.json    | 206 ++++++++++++++++++
>>  tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
>>  2 files changed, 207 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a72/core-imp-def.json
> 
> It would be worth checking how many of these events are common between a57
> and a72, as they may be able to share much of the json file.

Makes sense, will check the Cortex-A57 TRM and re-submit accordingly.
Thanks!
-- 
Florian
