Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047CBC31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 04:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA69E216C8
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 04:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfFPEHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 00:07:48 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:58833 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbfFPEHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 00:07:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TUHzmZd_1560658064;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0TUHzmZd_1560658064)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 16 Jun 2019 12:07:45 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] psi: Don't account force reclaim as memory pressure
To:     Chris Down <chris@chrisdown.name>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20190615120644.26743-1-xlpang@linux.alibaba.com>
 <20190615155831.GA1307@chrisdown.name>
From:   Xunlei Pang <xlpang@linux.alibaba.com>
Message-ID: <130aca9c-4d73-49ed-e78a-534ce2100ff8@linux.alibaba.com>
Date:   Sun, 16 Jun 2019 12:07:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190615155831.GA1307@chrisdown.name>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On 2019/6/15 PM 11:58, Chris Down wrote:
> Hi Xunlei,
> 
> Xunlei Pang writes:
>> There're several cases like resize and force_empty that don't
>> need to account to psi, otherwise is misleading.
> 
> I'm afraid I'm quite confused by this patch. Why do you think accounting
> for force reclaim in PSI is misleading? I completely expect that force
> reclaim should still be accounted for as memory pressure, can you
> present some reason why it shouldn't be?

We expect psi stands for negative factors to applications
which affect their response time, but force reclaims are
behaviours triggered on purpose like "/proc/sys/vm/drop_caches",
not the real negative pressure.

e.g. my module force reclaims the dead memcgs, there's no
application attached to it, and its memory(page caches) is
usually useless, force reclaiming them doesn't mean the
system or parent memcg is under memory pressure, while
actually the whole system or the parent memcg has plenty
of free memory. If the force reclaim causes further memory
pressure like hot page cache miss, then the workingset
refault psi will catch that.
