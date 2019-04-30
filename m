Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25669C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F294E20652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfD3JyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:54:02 -0400
Received: from relay.sw.ru ([185.231.240.75]:40588 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfD3JyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:54:01 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hLPSS-0007ia-U6; Tue, 30 Apr 2019 12:53:53 +0300
Subject: Re: [PATCH 1/3] mm: get_cmdline use arg_lock instead of mmap_sem
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        akpm@linux-foundation.org, arunks@codeaurora.org, brgl@bgdev.pl,
        geert+renesas@glider.be, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, mhocko@kernel.org, rppt@linux.ibm.com,
        vbabka@suse.cz
References: <20190418182321.GJ3040@uranus.lan>
 <20190430081844.22597-1-mkoutny@suse.com>
 <20190430081844.22597-2-mkoutny@suse.com>
 <4c79fb09-c310-4426-68f7-8b268100359a@virtuozzo.com>
 <20190430093808.GD2673@uranus.lan>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <1a7265fa-610b-1f2a-e55f-b3a307a39bf2@virtuozzo.com>
Date:   Tue, 30 Apr 2019 12:53:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430093808.GD2673@uranus.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.04.2019 12:38, Cyrill Gorcunov wrote:
> On Tue, Apr 30, 2019 at 12:09:57PM +0300, Kirill Tkhai wrote:
>>
>> This looks OK for me.
>>
>> But speaking about existing code it's a secret for me, why we ignore arg_lock
>> in binfmt code, e.g. in load_elf_binary().
> 
> Well, strictly speaking we probably should but you know setup of
> the @arg_start by kernel's elf loader doesn't cause any side
> effects as far as I can tell (its been working this lockless
> way for years, mmap_sem is taken later in the loader code).
> Though for consistency sake we probably should set it up
> under the spinlock.

Ok, so elf loader doesn't change these parameters. Thanks for the explanation.
