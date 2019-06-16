Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BE4C31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 06:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C34D216C8
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 06:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfFPGaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 02:30:14 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:36290 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725795AbfFPGaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 02:30:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TUIXG5o_1560666600;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0TUIXG5o_1560666600)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 16 Jun 2019 14:30:01 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] memcg: Ignore unprotected parent in
 mem_cgroup_protected()
To:     Chris Down <chris@chrisdown.name>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20190615111704.63901-1-xlpang@linux.alibaba.com>
 <20190615160820.GB1307@chrisdown.name>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <711f086e-a2e5-bccd-72b6-b314c4461686@linux.alibaba.com>
Date:   Sun, 16 Jun 2019 14:30:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190615160820.GB1307@chrisdown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chirs,

On 2019/6/16 AM 12:08, Chris Down wrote:
> Hi Xunlei,
> 
> Xunlei Pang writes:
>> Currently memory.min|low implementation requires the whole
>> hierarchy has the settings, otherwise the protection will
>> be broken.
>>
>> Our hierarchy is kind of like(memory.min value in brackets),
>>
>>               root
>>                |
>>             docker(0)
>>              /    \
>>         c1(max)   c2(0)
>>
>> Note that "docker" doesn't set memory.min. When kswapd runs,
>> mem_cgroup_protected() returns "0" emin for "c1" due to "0"
>> @parent_emin of "docker", as a result "c1" gets reclaimed.
>>
>> But it's hard to maintain parent's "memory.min" when there're
>> uncertain protected children because only some important types
>> of containers need the protection.  Further, control tasks
>> belonging to parent constantly reproduce trivial memory which
>> should not be protected at all.  It makes sense to ignore
>> unprotected parent in this scenario to achieve the flexibility.
> 
> I'm really confused by this, why don't you just set memory.{min,low} in
> the docker cgroup and only propagate it to the children that want it?
> 
> If you only want some children to have the protection, only request it
> in those children, or create an additional intermediate layer of the
> cgroup hierarchy with protections further limited if you don't trust the
> task to request the right amount.
> 
> Breaking the requirement for hierarchical propagation of protections
> seems like a really questionable API change, not least because it makes
> it harder to set systemwide policies about the constraints of
> protections within a subtree.

docker and various types(different memory capacity) of containers
are managed by k8s, it's a burden for k8s to maintain those dynamic
figures, simply set "max" to key containers is always welcome.

Set "max" to docker also protects docker cgroup memory(as docker
itself has tasks) unnecessarily.

This patch doesn't take effect on any intermediate layer with
positive memory.min set, it requires all the ancestors having
0 memory.min to work.

Nothing special change, but more flexible to business deployment...
