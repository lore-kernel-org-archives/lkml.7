Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B1AC31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 11:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D1E20870
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 11:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfFPL5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 07:57:07 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:54359 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725879AbfFPL5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 07:57:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TUK.rqV_1560686221;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0TUK.rqV_1560686221)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 16 Jun 2019 19:57:01 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] memcg: Ignore unprotected parent in
 mem_cgroup_protected()
To:     Chris Down <chris@chrisdown.name>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20190615111704.63901-1-xlpang@linux.alibaba.com>
 <20190615160820.GB1307@chrisdown.name>
 <711f086e-a2e5-bccd-72b6-b314c4461686@linux.alibaba.com>
 <20190616103745.GA2117@chrisdown.name>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <89067792-2c39-bcf2-6a35-80cab101c5ac@linux.alibaba.com>
Date:   Sun, 16 Jun 2019 19:57:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190616103745.GA2117@chrisdown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On 2019/6/16 PM 6:37, Chris Down wrote:
> Hi Xunlei,
> 
> Xunlei Pang writes:
>> docker and various types(different memory capacity) of containers
>> are managed by k8s, it's a burden for k8s to maintain those dynamic
>> figures, simply set "max" to key containers is always welcome.
> 
> Right, setting "max" is generally a fine way of going about it.
> 
>> Set "max" to docker also protects docker cgroup memory(as docker
>> itself has tasks) unnecessarily.
> 
> That's not correct -- leaf memcgs have to _explicitly_ request memory
> protection. From the documentation:
> 
>    memory.low
> 
>    [...]
> 
>    Best-effort memory protection.  If the memory usages of a
>    cgroup and all its ancestors are below their low boundaries,
>    the cgroup's memory won't be reclaimed unless memory can be
>    reclaimed from unprotected cgroups.
> 
> Note the part that the cgroup itself also must be within its low
> boundary, which is not implied simply by having ancestors that would
> permit propagation of protections.
> 
> In this case, Docker just shouldn't request it for those Docker-related
> tasks, and they won't get any. That seems a lot simpler and more
> intuitive than special casing "0" in ancestors.
> 
>> This patch doesn't take effect on any intermediate layer with
>> positive memory.min set, it requires all the ancestors having
>> 0 memory.min to work.
>>
>> Nothing special change, but more flexible to business deployment...
> 
> Not so, this change is extremely "special". It violates the basic
> expectation that 0 means no possibility of propagation of protection,
> and I still don't see a compelling argument why Docker can't just set
> "max" in the intermediate cgroup and not accept any protection in leaf
> memcgs that it doesn't want protection for.

I got the reason, I'm using cgroup v1(with memory.min backport)
which permits tasks existent in "docker" cgroup.procs.

For cgroup v2, it's not a problem.

Thanks,
Xunlei
