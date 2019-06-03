Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C7AC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0CF26E4D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ml7wuVQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFCUXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 16:23:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35700 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfFCUXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 16:23:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id p1so7401959plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 13:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KCAuqRvIU2ckCVob7UWIpr/PcPCBeVFLEtuvFQkKpqI=;
        b=ml7wuVQqI13CX5CtZbEMSvLH+lTnj7SlZGlSspITVoAwDFKDNOP2M5SbtrMFVvoJBg
         F1HtFgtNNXBSieNILcwxBBAS47/WpYlBjJN4f2BfJeBdg8ua3fnnsAS+jd+GFq+CBTCh
         /V36KrM5l2j0FhaqLdLUxP+tkluWMC9ieIwfbpbu3VyR7KPebNLO3FFT4TXLvoU6OUtM
         nmz1G5ET6hvaDV6HOcbenZaSQe7pRVoxIuBVhjy9oAwVnrcfrTrZoaowimguuMYy0Sl+
         fjEhQRmRl3xC9olgZaqPN8CQypG4auGESOS+8XfBSe/zNfyUuAqciNa65BiRckd1a489
         8KUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=KCAuqRvIU2ckCVob7UWIpr/PcPCBeVFLEtuvFQkKpqI=;
        b=kuh2ciwjJ/93SzT3dFEH+ID3q3je9/WBEGbeyzgsdSwpKu20ukQAJxRgZqBWRstS8v
         P7Z54/eiMqr2Bc4Y3CeZnOzx8FDwmmS56xNl1A8ESqf4k2W+via93ql62Mrh2Rd4S/na
         QOBMlj5IHPjhGu2y0e1b460ZKmmiJbCQdNNW8Wy5W7Qew/QCHN8qTSC1MI1PpWLqYZm2
         epXN8kFBx0/sdn+d/Go60C88wo+nyYq6loT0s+VTZ1BHVf3iL9Km5/Ejf7QzaKl8iPN1
         ApGZO2l8Fp33esEMzji18rGvBrii1gsg1QmBZA4huqBJwm2+LJyXylyXIhHEEPssYVlb
         yoZg==
X-Gm-Message-State: APjAAAUqs9tG5qGqthGU4UcrIhexp8KBTHL+PwDSQBPRtYtzS0fm9zcA
        AB8u/nywPsgmMUA/pyidgMUy31vkwA96vw==
X-Google-Smtp-Source: APXvYqyT/rioNX/CjI8MK8d4J/CnQvOHs3ooFykn9bW567HHKi+5SQ4e2xqB5glHws46IA2CER8BLg==
X-Received: by 2002:a17:902:b717:: with SMTP id d23mr17071198pls.53.1559593429452;
        Mon, 03 Jun 2019 13:23:49 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id v64sm7361064pjb.3.2019.06.03.13.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 13:23:48 -0700 (PDT)
From:   bsegall@google.com
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Liangyan <liangyan.peng@linux.alibaba.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, yun.wang@linux.alibaba.com,
        shanpeic@linux.alibaba.com, xlpang@linux.alibaba.com,
        "liangyan.ply" <liangyan.ply@linux.alibaba.com>
Subject: Re: [PATCH] sched/fair: don't restart enqueued cfs quota slack timer
References: <20190603044309.168065-1-liangyan.peng@linux.alibaba.com>
        <20190603094905.GA3419@hirez.programming.kicks-ass.net>
Date:   Mon, 03 Jun 2019 13:23:47 -0700
In-Reply-To: <20190603094905.GA3419@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Mon, 3 Jun 2019 11:49:05 +0200")
Message-ID: <xm26sgsqxvsc.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Jun 03, 2019 at 12:43:09PM +0800, Liangyan wrote:
>> From: "liangyan.ply" <liangyan.ply@linux.alibaba.com>
>> 
>> start_cfs_slack_bandwidth() will restart the quota slack timer,
>> if it is called frequently, this timer will be restarted continuously
>> and may have no chance to expire to unthrottle cfs tasks.
>> This will cause that the throttled tasks can't be unthrottled in time
>> although they have remaining quota.
>
> This looks very similar to the patch from Ben here:
>
>   https://lkml.kernel.org/r/xm26blzlyr9d.fsf@bsegall-linux.svl.corp.google.com

Yeah, it should do the same sort of thing, but testing hrtimer_active
is racy (we could miss restarting the timer if it's just dropped the
cfsb lock but hasn't finished yet), so the extra accounting flag is
needed.

>
>> 
>> Signed-off-by: Liangyan <liangyan.peng@linux.alibaba.com>
>> ---
>>  kernel/sched/fair.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d90a64620072..fdb03c752f97 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4411,9 +4411,11 @@ static void start_cfs_slack_bandwidth(struct cfs_bandwidth *cfs_b)
>>  	if (runtime_refresh_within(cfs_b, min_left))
>>  		return;
>>  
>> -	hrtimer_start(&cfs_b->slack_timer,
>> +	if (!hrtimer_active(&cfs_b->slack_timer)) {
>> +		hrtimer_start(&cfs_b->slack_timer,
>>  			ns_to_ktime(cfs_bandwidth_slack_period),
>>  			HRTIMER_MODE_REL);
>> +	}
>>  }
>>  
>>  /* we know any runtime found here is valid as update_curr() precedes return */
>> -- 
>> 2.14.4.44.g2045bb6
>> 
