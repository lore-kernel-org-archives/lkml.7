Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D091C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D191F206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfLLO44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:56:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728861AbfLLO4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:56:55 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 14B6EA39E3995B3780DE;
        Thu, 12 Dec 2019 22:56:49 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.236) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 12 Dec 2019
 22:56:39 +0800
Subject: Re: [PATCH] sched/fair: Optimize select_idle_cpu
To:     <mingo@kernel.org>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>, <xiexiuqi@huawei.com>,
        <liwei391@huawei.com>, <huawei.libin@huawei.com>,
        <bobo.shaobowang@huawei.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>,
        "chengjian (D)" <cj.chengjian@huawei.com>
References: <20191212144102.181510-1-cj.chengjian@huawei.com>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <3cf0931f-d2f4-008e-8e58-cbc9bd45e3a6@huawei.com>
Date:   Thu, 12 Dec 2019 22:56:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191212144102.181510-1-cj.chengjian@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.133.217.236]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/12/12 22:41, Cheng Jian wrote:
> Our threads are all bind to the front CPUs of the LLC domain,
> and now all the threads runs on the last CPU of them. nr is
> always less than the cpumask_weight, for_each_cpu_wrap can't
> find the CPU which our threads can run on, so the threads stay
> at the last CPU all the time.
Test :

Run on ARM64 4NODE, 128 CORE

// cat a.c
#include <time.h>

int main(void)
{
     struct timespec time, save;
     int ret;

     time.tv_sec = 0;
     time.tv_nsec = 1;

     while (1) {
         ret = nanosleep(&time, &save);
         if (ret)
             nanosleep(&save, &save);
     }
     return 0;
}

#cat a.sh
for i in `seq 0 9`
do
     taskset -c 8-11 ./a.out &
done


then run:

     gcc a.c -o a.out
     sh a.sh



without this patch, you can see all the task run on CPU11 all the times.



     %Cpu8  :  0.0 us,  0.0 sy,  0.0 ni, 98.4 id,  0.0 wa,  1.6 hi, 0.0 
si,  0.0 st
     %Cpu9  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi, 0.0 
si,  0.0 st
     %Cpu10 :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi, 0.0 
si,  0.0 st
     %Cpu11 :  5.7 us, 40.0 sy,  0.0 ni, 45.7 id,  0.0 wa,  8.6 hi, 0.0 
si,  0.0 st

