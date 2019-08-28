Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA43C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFC720828
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfH1K5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:57:04 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55316 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfH1K5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:57:04 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7SAv1Yi014970;
        Wed, 28 Aug 2019 19:57:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Wed, 28 Aug 2019 19:57:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7SAv12i014965
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 28 Aug 2019 19:57:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional
 information
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Edward Chron <echron@arista.com>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
References: <20190826193638.6638-1-echron@arista.com>
 <1566909632.5576.14.camel@lca.pw>
 <CAM3twVQEMGWMQEC0dduri0JWt3gH6F2YsSqOmk55VQz+CZDVKg@mail.gmail.com>
 <79FC3DA1-47F0-4FFC-A92B-9A7EBCE3F15F@lca.pw>
 <CAM3twVSdxJaEpmWXu2m_F1MxFMB58C6=LWWCDYNn5yT3Ns+0sQ@mail.gmail.com>
 <2A1D8FFC-9E9E-4D86-9A0E-28F8263CC508@lca.pw>
 <CAM3twVR5TVuuZSLM2qRJYnkCEKVZmA3XDNREaB+wdKH2Ne9vVA@mail.gmail.com>
 <20190828070845.GC7386@dhcp22.suse.cz>
 <2e816b05-7b5b-4bc0-8d38-8415daea920d@i-love.sakura.ne.jp>
 <20190828103211.GD28313@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5db2d2bd-645b-8967-849a-0d1de5861742@i-love.sakura.ne.jp>
Date:   Wed, 28 Aug 2019 19:56:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828103211.GD28313@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/08/28 19:32, Michal Hocko wrote:
>> Speak of my cases, those who take care of their systems are not developers.
>> And they afraid changing code that runs in kernel mode. They unlikely give
>> permission to install SystemTap/eBPF scripts. As a result, in many cases,
>> the root cause cannot be identified.
> 
> Which is something I would call a process problem more than a kernel
> one. Really if you need to debug a problem you really have to trust
> those who can debug that for you. We are not going to take tons of code
> to the kernel just because somebody is afraid to run a diagnostic.
> 

This is a problem of kernel development process.

>> Moreover, we are talking about OOM situations, where we can't expect userspace
>> processes to work properly. We need to dump information we want, without
>> counting on userspace processes, before sending SIGKILL.
> 
> Yes, this is an inherent assumption I was making and that means that
> whatever dynamic hooks would have to be registered in advance.
> 

No. I'm saying that neither static hooks nor dynamic hooks can work as
expected if they count on userspace processes. Registering in advance is
irrelevant. Whether it can work without userspace processes is relevant.

Also, out-of-tree codes tend to become defunctional. We are trying to debug
problems caused by in-tree code. Breaking out-of-tree debugging code just
because in-tree code developers don't want to pay the burden of maintaining
code for debugging problems caused by in-tree code is a very bad idea.

