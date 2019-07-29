Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6F1C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF3820651
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387750AbfG2Lp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:45:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43736 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387638AbfG2Lp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:45:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so61457329wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 04:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wswpQoJgwyGyzPq8XXsD+wjeWZTbEbjja41h5xGOJVQ=;
        b=ddz4Wor4yo8TmxH/uvHUEtv/+ZD88N5kD3iXKJe55xA17xsP3AWWW9F3z8Ta4be6kA
         XuXKQM+XxegdmkctCTzC4e5UiG+MySlTUFrl0HlGqApGgNgfJF9uXeDIUDQtYDpczjp3
         7Jp2Yh8/bpZEa4MqbaTXIRDUpYouXZ+iFGAfSOur2UmD97540jocfdJ+ec7pG2/Tbai3
         ZwuKb5e9DU/soMxrPdmuNpQGh6ni63Eg0mBMRArNTKBb7J/Ep2oV/HtbwZiYG+krtpSK
         LvKE5JuQGFO65vm7y6cQVnHcgjawFDJVwF0TK35sHBqk2wvwzSFlOLt06+63ELO7KHZr
         tnKQ==
X-Gm-Message-State: APjAAAUI3RiyYpoPkyoCVeU4B1VcCTCKc+fU783jlQDcOszmbWBHfT/N
        YACvh/w+MZWwQXMNjzQvMq/PvQ==
X-Google-Smtp-Source: APXvYqxe+aP64hAMwZCKl2r96RQuNJ8QO4qV5Nz/0wIXQvSs0/a1KeBhexRENJdUdvzJDmVJ3Lt07Q==
X-Received: by 2002:a5d:498f:: with SMTP id r15mr113353676wrq.353.1564400754574;
        Mon, 29 Jul 2019 04:45:54 -0700 (PDT)
Received: from t460s.bristot.redhat.com (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.gmail.com with ESMTPSA id k17sm78744410wrq.83.2019.07.29.04.45.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 04:45:53 -0700 (PDT)
Subject: Re: [RFC][PATCH 01/13] sched/deadline: Impose global limits on
 sched_attr::sched_period
To:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, luca.abeni@santannapisa.it,
        balsini@android.com, dvyukov@google.com, tglx@linutronix.de,
        vpillai@digitalocean.com, rostedt@goodmis.org
References: <20190726145409.947503076@infradead.org>
 <20190726161357.397880775@infradead.org>
 <20190729085711.GQ25636@localhost.localdomain>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <a7928ec6-b198-015e-edfb-7272de05a953@redhat.com>
Date:   Mon, 29 Jul 2019 13:45:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729085711.GQ25636@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2019 10:57, Juri Lelli wrote:
> Hi,
> 
> On 26/07/19 16:54, Peter Zijlstra wrote:
>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Luca Abeni <luca.abeni@santannapisa.it>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> ---
>>  include/linux/sched/sysctl.h |    3 +++
>>  kernel/sched/deadline.c      |   23 +++++++++++++++++++++--
>>  kernel/sysctl.c              |   14 ++++++++++++++
>>  3 files changed, 38 insertions(+), 2 deletions(-)
>>
>> --- a/include/linux/sched/sysctl.h
>> +++ b/include/linux/sched/sysctl.h
>> @@ -56,6 +56,9 @@ int sched_proc_update_handler(struct ctl
>>  extern unsigned int sysctl_sched_rt_period;
>>  extern int sysctl_sched_rt_runtime;
>>  
>> +extern unsigned int sysctl_sched_dl_period_max;
>> +extern unsigned int sysctl_sched_dl_period_min;
>> +
>>  #ifdef CONFIG_UCLAMP_TASK
>>  extern unsigned int sysctl_sched_uclamp_util_min;
>>  extern unsigned int sysctl_sched_uclamp_util_max;
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -2597,6 +2597,14 @@ void __getparam_dl(struct task_struct *p
>>  }
>>  
>>  /*
>> + * Default limits for DL period; on the top end we guard against small util
>> + * tasks still getting rediculous long effective runtimes, on the bottom end we
> s/rediculous/ridiculous/
> 
>> + * guard against timer DoS.
>> + */
>> +unsigned int sysctl_sched_dl_period_max = 1 << 22; /* ~4 seconds */
>> +unsigned int sysctl_sched_dl_period_min = 100;     /* 100 us */
> These limits look sane to me. I've actually been experimenting with 10us
> period tasks and throttling seemed to behave fine, but I guess 100us is
> a saner default.
> 
> So, (with a few lines of changelog :)
> 
> Acked-by: Juri Lelli <juri.lelli@redhat.com>


Looks sane to me too!

Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>

-- Daniel
