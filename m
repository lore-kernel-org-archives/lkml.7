Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B066C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E56206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IbMC7GFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbfC2P60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:58:26 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34902 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbfC2P6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:58:25 -0400
Received: by mail-it1-f195.google.com with SMTP id w15so4683497itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=caXoiDSKn+Qb4g9BBNk10pBV5z7PZJqZpPtP1dFea80=;
        b=IbMC7GFKvrgUaiTqJFvP74ZyjG6NU/WKWiiWLX2Kidj5ZdQ8gGGveO5ndlA20lP2bD
         1aWAJBkg6eb+0bY/n6RLbKoX3M9WoHaqv+SV73l5Tr7Nbf/xLo2h6O0jMOcb7q1UC1ku
         ckOCP6vKQkWH5fmhHkjx70LL8RjbCf3qBwJPh4A5OltfvRt8ttNdnKvPJ/RMHQUp63ar
         8HV4uUJW0gMNuUlvpPogcGyzH+7zllW6Rfn+F56JDjvuGA4yegtQqGq/zYYwJVt+kJFf
         JZ3tYSnG6gUFKfjy1jqhRVVj3GneTVpveeher3SUmCfzn44+79S+xxxlHIUhIFwSD9oW
         rPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=caXoiDSKn+Qb4g9BBNk10pBV5z7PZJqZpPtP1dFea80=;
        b=c20gEzbZQulzfkritSYdrH5X84ESSXhyIyi/bx+FtI6nk+WpHftbbt9F/FwdA2gvxe
         ZNZ79/wbe7ILcZhU72UISTFrao0CJ5Atms4sViTuZ3WMNv79Mfii8uqaRYlP1fIjYcxp
         fbnGz6cPFREKuaMKmPrOnBOZR+jd3K8yDJVXQP0GK9J6a50pwy+94MWbhQE1+KpuQCrJ
         X8/X6GqMOx+6HZs8HGCPjAdZX/yLrt0J3c+UsQYSUtGIe8XFjjGF7qbIuhN5H325e2Eb
         +xdRmMSWxRAku8dhg2CpfvUMA5mHGc6l4Y8B9hJ3YesfrVvDVP9F41/74iH3TRDwbm/q
         iH3A==
X-Gm-Message-State: APjAAAWRViKsf889sjlxRDXQvKNHYY35S9F6ntaGnvuSO5RR0z5BCk7H
        MBZTCeQ+X2AJBCcPyt5Z+7+T28zzVtOD0g==
X-Google-Smtp-Source: APXvYqx0OlT9l2j8nq5h0N9ABWd9WGGmBJb7rxXzynWwch3PAmiVOR2VU1hPSN6jx18KdB9bRmWyzA==
X-Received: by 2002:a02:b78e:: with SMTP id f14mr4239534jam.43.1553875104720;
        Fri, 29 Mar 2019 08:58:24 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id s10sm951215ioc.54.2019.03.29.08.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 08:58:23 -0700 (PDT)
Subject: Re: [PATCH] block/bfq: fix ifdef for CONFIG_BFQ_GROUP_IOSCHED=y
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
References: <155386807826.3190.16175453392005064129.stgit@buzz>
 <c40b8d4a-c504-fdf4-0b96-64aaeb167435@applied-asynchrony.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5234a971-2b6a-47b1-0071-8f3bd07d9fc3@kernel.dk>
Date:   Fri, 29 Mar 2019 09:58:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c40b8d4a-c504-fdf4-0b96-64aaeb167435@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 9:56 AM, Holger Hoffstätte wrote:
> On 3/29/19 3:01 PM, Konstantin Khlebnikov wrote:
>> Replace BFQ_GROUP_IOSCHED_ENABLED with CONFIG_BFQ_GROUP_IOSCHED.
>> Code under these ifdefs never worked, something might be broken.
>>
>> Fixes: 0471559c2fbd ("block, bfq: add/remove entity weights correctly")
>> Fixes: 73d58118498b ("block, bfq: consider also ioprio classes in symmetry detection")
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> ---
>>   block/bfq-iosched.c |    2 +-
>>   block/bfq-wf2q.c    |    2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 4c592496a16a..fac188dd78fa 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -674,7 +674,7 @@ static bool bfq_symmetric_scenario(struct bfq_data *bfqd)
>>   	 * at least two nodes.
>>   	 */
>>   	return !(varied_queue_weights || multiple_classes_busy
>> -#ifdef BFQ_GROUP_IOSCHED_ENABLED
>> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>   	       || bfqd->num_groups_with_pending_reqs > 0
>>   #endif
>>   		);
>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>> index 63311d1ff1ed..a11bef75483d 100644
>> --- a/block/bfq-wf2q.c
>> +++ b/block/bfq-wf2q.c
>> @@ -1012,7 +1012,7 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
>>   		entity->on_st = true;
>>   	}
>>   
>> -#ifdef BFQ_GROUP_IOSCHED_ENABLED
>> +#ifdef CONFIG_BFQ_GROUP_IOSCHED
>>   	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
>>   		struct bfq_group *bfqg =
>>   			container_of(entity, struct bfq_group, entity);
>>
>>
> 
> Good catch! I run without group scheduling and therefore didn't notice these
> stray defines earlier. For 5.1 it should merge cleanly; adding this on top of
> the pending 5.2 BFQ patches required a small context fixup in hunk #1 due to
> "block, bfq: do not idle for lowest-weight queues".

I'm hesitant to apply this, since the group scheduling stuff has obviously never
been tested.

Hence it should go through some actual testing first, which means it's a 5.2
candidate, not 5.1.

-- 
Jens Axboe

