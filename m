Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C35C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744F520673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfIWKqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:46:02 -0400
Received: from mail1.windriver.com ([147.11.146.13]:46910 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfIWKqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:46:02 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x8NAjMGt001874
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 23 Sep 2019 03:45:22 -0700 (PDT)
Received: from [128.224.162.221] (128.224.162.221) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 23 Sep
 2019 03:45:22 -0700
Subject: Re: [PATCH] printk: Fix unnecessary returning broken pipe error from
 devkmsg_read
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>
References: <1568813503-420025-1-git-send-email-zhe.he@windriver.com>
 <20190923100513.GA51932@jagdpanzerIV>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <027b2f0d-b7dc-4e76-22a7-ce80c9a0aade@windriver.com>
Date:   Mon, 23 Sep 2019 18:45:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923100513.GA51932@jagdpanzerIV>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [128.224.162.221]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/19 6:05 PM, Sergey Senozhatsky wrote:
> On (09/18/19 21:31), zhe.he@windriver.com wrote:
>> When users read the buffer from start, there is no need to return -EPIPE
>> since the possible overflows will not affect the output.
>>
> [..]
>> -	if (user->seq < log_first_seq) {
>> +	if (user->seq == 0) {
>> +		user->seq = log_first_seq;
>> +	} else if (user->seq < log_first_seq) {
>>  		/* our last seen message is gone, return error and reset */
>>  		user->idx = log_first_idx;
>>  		user->seq = log_first_seq;
> A tough call.
>
> User-space wants to read messages which are gone: log_first_seq > user->seq.
>
> I think returning EPIPE is sort of appropriate; user-space, possibly,
> can printf(stderr, "Some /dev/kmsg messages are gone\n"); or something
> like that.

Yes, a tough call. I was looking at the similar part of RT kernel and thought
that handling was better.
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/kernel/printk/printk.c?h=linux-5.2.y-rt#n706

IMHO, the EPIPE is used to inform user-space when the buffer has overflown and
there is a inconsistency/break between what has been read and what has not.

When user-space just wants to read the buffer from sequence 0, there would not
be the inconsistency.

I think it is NOT necessary to inform user-space, when it just wants to read
from the beginning of the buffer, that the buffer has changed since the time
point when it issues the action of reading. But if that IS what we want, the RT
kernel needs to be changed so that mainline and RT kernel act in the same way.


Zhe

>
> 	-ss
>

