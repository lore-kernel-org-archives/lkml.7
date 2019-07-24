Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA94FC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E68A217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfGXJBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 05:01:07 -0400
Received: from relay.sw.ru ([185.231.240.75]:42698 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfGXJBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:01:07 -0400
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1hqD8l-0002uA-D6; Wed, 24 Jul 2019 12:00:51 +0300
Subject: Re: [PATCH] kmemleak: Increase maximum early log entries to 1000000
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20190723072605.103456-1-drinkcat@chromium.org>
 <CACT4Y+bi5KkZ8igSeYVxjwtr8t0Vjz55gzWfAu_c8VMAqw0zPA@mail.gmail.com>
 <CANMq1KB8ECeRqNhSWyUf3amAkF7qvAmS3aU6rGNnZ=kUV3LC5Q@mail.gmail.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <095e2bc3-9284-e72d-8ed8-e2c6ec3f7c23@virtuozzo.com>
Date:   Wed, 24 Jul 2019 12:00:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANMq1KB8ECeRqNhSWyUf3amAkF7qvAmS3aU6rGNnZ=kUV3LC5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/19 11:13 AM, Nicolas Boichat wrote:
> On Tue, Jul 23, 2019 at 3:46 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> On Tue, Jul 23, 2019 at 9:26 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
>>>
>>> When KASan is enabled, a lot of memory is allocated early on,
>>> and kmemleak complains (this is on a 4GB RAM system):
>>> kmemleak: Early log buffer exceeded (129846), please increase
>>>   DEBUG_KMEMLEAK_EARLY_LOG_SIZE
>>>
>>> Let's increase the upper limit to 1M entry. That would take up
>>> 160MB of RAM at init (each early_log entry is 160 bytes), but
>>> the memory would later be freed (early_log is __initdata).
>>
>> Interesting. Is it on an arm64 system?
> 
> Yes arm64. And this is chromiumos-4.19 tree. I didn't try to track
> down where these allocations come from...
> 

Is this still a problem in upstream tree? 4.19 doesn't have fed84c785270 ("mm/memblock.c: skip kmemleak for kasan_init()")

