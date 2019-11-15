Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8DEC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FFF206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfKOAFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 19:05:54 -0500
Received: from foss.arm.com ([217.140.110.172]:50920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfKOAFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:05:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4433831B;
        Thu, 14 Nov 2019 16:05:53 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB51B3F534;
        Thu, 14 Nov 2019 16:05:51 -0800 (PST)
Subject: Re: [PATCH] sched/uclamp: Fix overzealous type replacement
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, tj@kernel.org,
        patrick.bellasi@matbug.net, surenb@google.com, qperret@google.com
References: <20191113165334.14291-1-valentin.schneider@arm.com>
 <20191114202855.64e4jnb4dcbru4w3@e107158-lin.cambridge.arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <4b702b68-997b-da33-660c-db4313ac6dc5@arm.com>
Date:   Fri, 15 Nov 2019 00:05:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191114202855.64e4jnb4dcbru4w3@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2019 20:28, Qais Yousef wrote:
> On 11/13/19 16:53, Valentin Schneider wrote:
>> Some uclamp helpers had their return type changed from 'unsigned int' to
>> 'enum uclamp_id' by commit
>>
>>   0413d7f33e60 ("sched/uclamp: Always use 'enum uclamp_id' for clamp_id values")
>>
>> but it happens that some *actually* do return an unsigned int value. Those
>> are the helpers that return a utilization value: uclamp_rq_max_value() and
>> uclamp_eff_value(). Fix those up.
>>
>> Note that this doesn't lead to any obj diff using a relatively recent
>> aarch64 compiler (8.3-2019.03). The current code of e.g. uclamp_eff_value()
>> already figures out that the return value is 11 bits (bits_per(1024)) and
>> doesn't seem to do anything funny. I'm still marking this as fixing the
>> above commit to be on the safe side.
>>
>> Fixes: 0413d7f33e60 ("sched/uclamp: Always use 'enum uclamp_id' for clamp_id values")
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> ---
> 
> The changelog could be a bit simpler and more explicitly say 0413d7f33e60
> wrongly changed the return type of some functions. For a second I thought
> something weird is going inside these functions.
> 

The first paragraph is exactly that, no? The rest (that starts with "Note
that") is just optional stuff I look into because I was curious.

> But that could be just me :-)
> 
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> 
> Thanks!
> 
> --
> Qais Yousef
> 
