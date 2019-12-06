Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF98C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608AC24670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfLFQYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:24:55 -0500
Received: from relay.sw.ru ([185.231.240.75]:51336 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfLFQYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:24:53 -0500
Received: from dhcp-172-16-25-5.sw.ru ([172.16.25.5])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1idGPO-00009Z-Ih; Fri, 06 Dec 2019 19:24:46 +0300
Subject: Re: [PATCH 3/3] kasan: don't assume percpu shadow allocations will
 succeed
To:     Daniel Axtens <dja@axtens.net>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, glider@google.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Cc:     daniel@iogearbox.net, cai@lca.pw,
        syzbot+82e323920b78d54aaed5@syzkaller.appspotmail.com,
        syzbot+59b7daa4315e07a994f1@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191205140407.1874-1-dja@axtens.net>
 <20191205140407.1874-3-dja@axtens.net>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <87172e8f-9698-0805-252f-55f68ee07862@virtuozzo.com>
Date:   Fri, 6 Dec 2019 19:24:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191205140407.1874-3-dja@axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/19 5:04 PM, Daniel Axtens wrote:
> syzkaller and the fault injector showed that I was wrong to assume
> that we could ignore percpu shadow allocation failures.
> 
> Handle failures properly. Merge all the allocated areas back into the free
> list and release the shadow, then clean up and return NULL. The shadow
> is released unconditionally, which relies upon the fact that the release
> function is able to tolerate pages not being present.
> 
> Also clean up shadows in the recovery path - currently they are not
> released, which leaks a bit of memory.
> 
> Fixes: 3c5c3cfb9ef4 ("kasan: support backing vmalloc space with real shadow memory")
> Reported-by: syzbot+82e323920b78d54aaed5@syzkaller.appspotmail.com
> Reported-by: syzbot+59b7daa4315e07a994f1@syzkaller.appspotmail.com
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
