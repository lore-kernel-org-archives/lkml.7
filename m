Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7497C48BE2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B158C206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfFTKXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:23:19 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:65081 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfFTKXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:23:19 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x5KANBen075520;
        Thu, 20 Jun 2019 19:23:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Thu, 20 Jun 2019 19:23:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x5KANBwb075517
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 20 Jun 2019 19:23:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] hung_task: recover hung task warnings in next check
 interval
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1561010100-14080-1-git-send-email-laoar.shao@gmail.com>
 <e5c695c9-2006-f2cb-e3e2-7ea8ee465817@i-love.sakura.ne.jp>
 <CALOAHbCe9J0pOCW03dW+C4NK__amTKttAs=eNHXwvPPf5Lpwhw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ac52f383-697d-8102-a6af-6aa172ee2a6f@i-love.sakura.ne.jp>
Date:   Thu, 20 Jun 2019 19:23:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CALOAHbCe9J0pOCW03dW+C4NK__amTKttAs=eNHXwvPPf5Lpwhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/06/20 19:10, Yafang Shao wrote:
>>> With this patch, hung task warnings will be reset with
>>> sys_hung_task_warnings setting in evenry check interval.
>>
>> Since it is uncommon that the messages are printed for more than 10
>> times for one check_hung_uninterruptible_tasks() call, this patch is
>> effectively changing to always print the messages (in other words,
>> setting -1).
> 
> If sys_hung_task_warnings can't be recovered, does it make sense to exist?
> In which case do we need this setting ?

Someone might want to print the messages up to only a few times because he/she
does not like the ever-repeating messages. But automatically resetting will
forbid his/her wish to print the messages for up to only a few times.

> 
> Btw, why the default value of this setting is 10, instead of -1 ?

I don't know. I guess just by historical reason, for this variable
has been existed before support of -1 is added.

