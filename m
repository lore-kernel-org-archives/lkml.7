Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A2AC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34BC21835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 11:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgACLbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:31:53 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:41083 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727453AbgACLbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 06:31:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TmjiLWd_1578051110;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TmjiLWd_1578051110)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jan 2020 19:31:51 +0800
Subject: Re: [PATCH v2] ftrace: avoid potential division by zero
To:     Justin Capella <justincapella@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, xlpang@linux.alibaba.com,
        LKML <linux-kernel@vger.kernel.org>
References: <20200103030248.14516-1-wenyang@linux.alibaba.com>
 <CAMrEMU8wB4c0TFTSJ4ixQg_gSnW72n_T3ip8ZfZFAk8xWjaKsA@mail.gmail.com>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <a2468cc8-cdc1-0a03-6de1-6607bff4d0fa@linux.alibaba.com>
Date:   Fri, 3 Jan 2020 19:31:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMrEMU8wB4c0TFTSJ4ixQg_gSnW72n_T3ip8ZfZFAk8xWjaKsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/1/3 4:00 下午, Justin Capella wrote:
>> -               do_div(stddev, rec->counter * (rec->counter - 1) * 1000);
>>
>> +               stddev = div64_ul(stddev,
>> +                                 rec->counter * (rec->counter - 1) * 1000);
> 
> 
> Is a rec->counter > 1 assertion needed here?
> 

Hello, the above lines deal with this situation:

         if (rec->counter <= 1)
                 stddev = 0;
         else {


--
Regards,
Wen
