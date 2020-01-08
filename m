Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C2EC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C296220692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 22:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p7oPI0NG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgAHW0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 17:26:55 -0500
Received: from mail-mw2nam10on2064.outbound.protection.outlook.com ([40.107.94.64]:47296
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726390AbgAHW0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 17:26:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZScSyzgwijMVil9nfz00yYdxOESy46AV5ZDZDqzZksye6zd8+/BaucOc8HzS4F5NPp3hf/6hJoAn82FxbdlrNepuHCe/oGnawyI4VcR7X3QHnvpmB7MFPE4MLRbBBOiwPg7BgFENxtkwdIyKt3R10AxnThIsMKQPefpknaQNUsWuVHujaQ75miTvSOzcpwajLNZK/9w2wLqcxBfgFAWunrZmoGdZpNOtP1ZxbaUSJ+WRga51fUNGx4wYDTwp0PJlmVEaWd2pl0BdyabN8+bcCH+yzaRzwdPFA2RNrkXGVHKh0Ia/5ZQSuqSQWjl7KVg1RHeJN9l6TFvM9HU+8mr03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4h+x/qC+uslTFAP0t7Hys5Nrt8UHKieSBy+gSQ9ywA=;
 b=LBLtjFji4w8rBnW5nYcdEZqdU/rxv+lEeCvKOLxANyFjx7tAlO5sjR9h5N0wYkxrIM/cyE51C+iFmCdUX2RsXpFPMFi9K/Mf4xs6HpVdCLp4jObw/0+CmK+YZ1DMyL/7mttoHAUl8rHIq4IhKk8v1GCKlvQqH2S2R+HorTydoR1RFTcg+k8bT3Z1HNtu1gRtGFWsCu7jkuP4/RLe1Rdts4m6Sku5Ojq7u59Xt2BM8ilV9paOxD+bftXy3opYbnKZgZEC4evwj4vVoooflXyOGrROgw+JSqFWWFBnQFDGLFaol7n/5EGJcATfLfhO6/bCkmi13ydvD9J1A+AteRUU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4h+x/qC+uslTFAP0t7Hys5Nrt8UHKieSBy+gSQ9ywA=;
 b=p7oPI0NG1/YmBXQfNlo8AiLHz0fALMjHqG6JafCEOYUJgLiJqCH1QJaxV2Hh8pa/ae9IN07HbmiHuER9FBzxnNr7pbejwWBogNJz3K1IiXrF6tR9Ej3ThrqI4sTh30s/lOqAfjnugigbNRjZ+4/Hf2kdN7O0nCgIqoTzt4n/V80=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.106.33) by
 SN6PR12MB2798.namprd12.prod.outlook.com (52.135.100.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 8 Jan 2020 22:26:50 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::48af:8c71:edee:5bc]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::48af:8c71:edee:5bc%7]) with mapi id 15.20.2602.017; Wed, 8 Jan 2020
 22:26:50 +0000
Subject: Re: [PATCH 2/2] perf/x86/amd: Add support for Large Increment per
 Cycle Events
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stephane Eranian <eranian@google.com>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <20191114183720.19887-1-kim.phillips@amd.com>
 <20191114183720.19887-3-kim.phillips@amd.com>
 <20191220120945.GG2844@hirez.programming.kicks-ass.net>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <ca10060f-f78f-695f-4929-fe4bc30c6712@amd.com>
Date:   Wed, 8 Jan 2020 16:26:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191220120945.GG2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM3PR08CA0010.namprd08.prod.outlook.com
 (2603:10b6:0:52::20) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
Received: from [10.236.136.247] (165.204.77.1) by DM3PR08CA0010.namprd08.prod.outlook.com (2603:10b6:0:52::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 22:26:48 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d8bd364-599a-4315-c0bf-08d79489daf1
X-MS-TrafficTypeDiagnostic: SN6PR12MB2798:|SN6PR12MB2798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2798BEE9F5C2422A5610D1AE873E0@SN6PR12MB2798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 02760F0D1C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(189003)(199004)(53546011)(66556008)(478600001)(66946007)(66476007)(2906002)(52116002)(8676002)(4326008)(7416002)(6486002)(6916009)(81156014)(81166006)(36756003)(316002)(31686004)(54906003)(16576012)(8936002)(31696002)(44832011)(956004)(5660300002)(2616005)(86362001)(186003)(16526019)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2798;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRoEvKhw0z7M3y8WwjBUm4ILiKQm9Qk4AyidFkyhJ4SfBFcNkvJ76PuMJLFEPK98TEPKAPnXPxFyfEH/bND9yHKo/QhFL4sKzPF5SseEAwkdmtjWv0V+9D3srHx7rA977CG2uh19ib4Kfko9NGAI0LT0Vh1VOYqpeDHjQJV9988UMPqBFFV/eB8QXw6rldXg7flQSupT/bsnNnCgK/Ph9SflL+YuI6f08t81y0SJqMCyjBUF3Eet5dWeY9WTsOinThHh2Mh020Q1e4Yw72YRjjBI7uSR9U/DM/Ha1VzdSZXBfQdfUhJsjEqkJ9H9GRJAc7fv6edINOktzE9f3SP/OwgVSZ/e85Dmy/koRtzQ+4z3d2IGVkRbWtL/mwuBaX9/nu/HhtC18hkLqIDJyCJhSpbWprSGRaCg8ViQpKmPN+8z3d5XThM9TiO6AfrmFNiK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8bd364-599a-4315-c0bf-08d79489daf1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 22:26:50.4159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkMesBgJy0ZEn1LzqBmT5qgd1Mvbx2bYsPcC88PgKhYQuSr++EyxTwlWRWTWde/wuAr1+a/kfgC/voZyuZ99Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2798
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Happy New Year, and thanks for your review...

On 12/20/19 6:09 AM, Peter Zijlstra wrote:
> On Thu, Nov 14, 2019 at 12:37:20PM -0600, Kim Phillips wrote:
>> @@ -621,6 +622,8 @@ void x86_pmu_disable_all(void)
>>  			continue;
>>  		val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
>>  		wrmsrl(x86_pmu_config_addr(idx), val);
>> +		if (is_large_inc(hwc))
>> +			wrmsrl(x86_pmu_config_addr(idx + 1), 0);
>>  	}
>>  }
>>  
> 
> See, the above makes sense, it doesn't assume anything about where
> config for idx and config for idx+1 are, and then here:
> 
>> @@ -855,6 +871,9 @@ static inline void x86_pmu_disable_event(struct perf_event *event)
>>  	struct hw_perf_event *hwc = &event->hw;
>>  
>>  	wrmsrl(hwc->config_base, hwc->config);
>> +
>> +	if (is_large_inc(hwc))
>> +		wrmsrl(hwc->config_base + 2, 0);
>>  }
> 
> You hard-code the offset as being 2. I fixed that for you.

Sorry I missed that!  Thanks for catching and fixing it.

>> @@ -849,14 +862,19 @@ int perf_assign_events(struct event_constraint **constraints, int n,
>>  			int wmin, int wmax, int gpmax, int *assign)
>>  {
>>  	struct perf_sched sched;
>> +	struct event_constraint *c;
>>  
>>  	perf_sched_init(&sched, constraints, n, wmin, wmax, gpmax);
>>  
>>  	do {
>>  		if (!perf_sched_find_counter(&sched))
>>  			break;	/* failed */
>> -		if (assign)
>> +		if (assign) {
>>  			assign[sched.state.event] = sched.state.counter;
>> +			c = constraints[sched.state.event];
>> +			if (c->flags & PERF_X86_EVENT_LARGE_INC)
>> +				sched.state.counter++;
>> +		}
>>  	} while (perf_sched_next_event(&sched));
>>  
>>  	return sched.state.unassigned;
> 
> I'm still confused by this bit. AFAICT it serves no purpose.
> perf_sched_next_event() will reset sched->state.counter to 0 on every
> pass anyway.
> 
> I've deleted it for you.

OK, I had my doubts because perf_sched_next_event doesn't have a counter reset in the "next weight" exit case, which indeed might be a moot case, but then perf_sched_init, called in the beginning of perf_assign_events, doesn't clear the counter variable either..

>> @@ -926,10 +944,14 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
>>  			break;
>>  
>>  		/* not already used */
>> -		if (test_bit(hwc->idx, used_mask))
>> +		if (test_bit(hwc->idx, used_mask) || (is_large_inc(hwc) &&
>> +		    test_bit(hwc->idx + 1, used_mask)))
>>  			break;
>>  
>>  		__set_bit(hwc->idx, used_mask);
>> +		if (is_large_inc(hwc))
>> +			__set_bit(hwc->idx + 1, used_mask);
>> +
>>  		if (assign)
>>  			assign[i] = hwc->idx;
>>  	}
> 
> This is just really sad.. fixed that too.

[*]

> Can you verify the patches in:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/amd
> 
> work?

I found a test that failed: perf stat on 6 instructions + 1 FLOPs events, multiplexing over 6 h/w counters along with the watchdog often returns exceptionally high and incorrect counts for a couple of the instructions events.  The FLOPs event counts ok.

My original patch, rebased onto the same code your perf/amd branch is, does not fail this test.

If I re-add my perf_assign_events changes you removed, the problem does not go away.

If I undo re-adding my perf_assign_events code, and re-add my "not already used" code that you removed - see [*] above - the problem DOES go away, and all the counts are all accurate.

One problem I see with your change in the "not already used" fastpath area, is that the new mask variable gets updated with position 'i' regardless of any previous Large Increment event assignments.  I.e., a successfully scheduled large increment event assignment may have already consumed that 'i' slot for its Merge event in a previous iteration of the loop.  So if the fastpath scheduler fails to assign that following event, the slow path is wrongly entered due to a wrong 'i' comparison with 'n', for example.

Btw, thanks for adding the comment pointing out perf_sched_restore_state is incompatible with Large Increment events.

I'd just as soon put my original "not already used" code back in, but if it's still unwanted, let me know how you'd like to proceed...

Kim
