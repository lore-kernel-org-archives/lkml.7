Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D769DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A793F2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbiMr+LU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfHMNNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:13:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44064 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbfHMNNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:13:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id a21so4033924edt.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ubTbMeSv2M83GvfRwkB/P+VL404uyP8HpfpedP/OoAY=;
        b=LbiMr+LUmaZQrw0UyPVfcE20C2rhk/qkyZVK+3mYVCagAEE8U/paBXrjyllhdz6qtK
         Wzyo4uPi6N3fin0E1mVY9if56H4zb9YiKT42Fw945pXhXBVv8S0YTiidT67x5mLUlNDf
         g9b3ExT+UD6gq0KpgfVTPNpdEYLQUgk6xdw1mGSodufjLObjZ8vlHlJcOkuIqQRHQs2h
         i5tMQILnrg1tWoOOFbCbnBec0cRn2C0XZDoQpYkUbEh1S7kiLV6VU2k6/2ERXkSFxH+s
         +jkQs/sxXRCPpGZ0782kYlorhUlcaFR7Hnm3JOSxGlLlFVSUG0SKHT6NxMTgWJKS5Sbj
         1vSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ubTbMeSv2M83GvfRwkB/P+VL404uyP8HpfpedP/OoAY=;
        b=g8mX1oa0UScWrmcPpPUok3xE/tBKh9u6j1p8fS+5S7NlC/kc4gX6DYOm4LxVRjfCiY
         JHb6Nt37CjYlnHFnuyRwCk3tSS9gM4Ml+0dcyURH9uZ4bsRBJ1/N3m5Znn4cALj4dzWI
         MdlgjJZDwsAyJayPl2pIAQ6haULriST2Fl4YRIsZtAmcYSjQ5upFyLkXvAI3lQqo5KrK
         ckmTW7+7ZiSqX2RA+r27MijFWwlbJ42RvVqTY8Vg3C7xEP70WUYXFXRqv66qOBYZ58HU
         KXCMHEJF+3e5XX00ZZMfzf3W9QBahKULb0RpII8RL8sABZ0+qLwNmSbTdke5bvxMaH7b
         FM0g==
X-Gm-Message-State: APjAAAW0rs3IGZ0lh62H17oEb9t5nWv/p91N4YZ9CCh4tRh7AowsKGU3
        5fen+tC73hdWjon9MCNTpPI=
X-Google-Smtp-Source: APXvYqwdvW3aE7k5RgRuOYmrOfG36rPCpQtWz80XoYTilWeyUOHf94znm2sC9lo7U0BNc43D3/8rag==
X-Received: by 2002:a50:f285:: with SMTP id f5mr29025998edm.109.1565701995522;
        Tue, 13 Aug 2019 06:13:15 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id z9sm3562897edd.18.2019.08.13.06.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 06:13:14 -0700 (PDT)
Date:   Tue, 13 Aug 2019 13:13:12 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hotplug: prevent memory leak when reuse pgdat
Message-ID: <20190813131312.l4pzy7ornmc4a5yj@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190813020608.10194-1-richardw.yang@linux.intel.com>
 <20190813075707.GA17933@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813075707.GA17933@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 09:57:07AM +0200, Michal Hocko wrote:
>On Tue 13-08-19 10:06:08, Wei Yang wrote:
>> When offline a node in try_offline_node, pgdat is not released. So that
>> pgdat could be reused in hotadd_new_pgdat. While we re-allocate
>> pgdat->per_cpu_nodestats if this pgdat is reused.
>> 
>> This patch prevents the memory leak by just allocate per_cpu_nodestats
>> when it is a new pgdat.
>
>Yes this makes sense! I was slightly confused why we haven't initialized
>the allocated pcp area because __alloc_percpu does GFP_KERNEL without
>__GFP_ZERO but then I've just found out that the zeroying is done
>regardless. A bit unexpected...
>
>> NOTE: This is not tested since I didn't manage to create a case to
>> offline a whole node. If my analysis is not correct, please let me know.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Acked-by: Michal Hocko <mhocko@suse.com>
>
>Thanks!
>

Thanks :-)

>> ---
>>  mm/memory_hotplug.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index c73f09913165..efaf9e6f580a 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -933,8 +933,11 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
>>  		if (!pgdat)
>>  			return NULL;
>>  
>> +		pgdat->per_cpu_nodestats =
>> +			alloc_percpu(struct per_cpu_nodestat);
>>  		arch_refresh_nodedata(nid, pgdat);
>>  	} else {
>> +		int cpu;
>>  		/*
>>  		 * Reset the nr_zones, order and classzone_idx before reuse.
>>  		 * Note that kswapd will init kswapd_classzone_idx properly
>> @@ -943,6 +946,12 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
>>  		pgdat->nr_zones = 0;
>>  		pgdat->kswapd_order = 0;
>>  		pgdat->kswapd_classzone_idx = 0;
>> +		for_each_online_cpu(cpu) {
>> +			struct per_cpu_nodestat *p;
>> +
>> +			p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
>> +			memset(p, 0, sizeof(*p));
>> +		}
>>  	}
>>  
>>  	/* we can use NODE_DATA(nid) from here */
>> @@ -952,7 +961,6 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
>>  
>>  	/* init node's zones as empty zones, we don't have any present pages.*/
>>  	free_area_init_core_hotplug(nid);
>> -	pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
>>  
>>  	/*
>>  	 * The node we allocated has no zone fallback lists. For avoiding
>> -- 
>> 2.17.1
>> 
>
>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
