Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A23EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EADD20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfDJXWp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:22:45 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43007 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJXWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:22:45 -0400
X-Originating-IP: 172.56.42.226
Received: from [IPv6:2607:fb90:8063:d541:dd67:a354:e9bb:effe] (unknown [172.56.42.226])
        (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 719E224000A;
        Wed, 10 Apr 2019 23:22:35 +0000 (UTC)
Date:   Wed, 10 Apr 2019 16:22:29 -0700
In-Reply-To: <CAGXu5jKzBGRr7LjFVdpvHhSFV7C7kuj-6VphhtLsMEoetr_R7g@mail.gmail.com>
References: <20190410224213.20651-1-okaya@kernel.org> <CAGXu5jKzBGRr7LjFVdpvHhSFV7C7kuj-6VphhtLsMEoetr_R7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2] init: Do not select DEBUG_KERNEL by default
To:     Kees Cook <keescook@chromium.org>, Sinan Kaya <okaya@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Changbin Du <changbin.du@intel.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@kernel.org>
From:   Josh Triplett <josh@joshtriplett.org>
Message-ID: <135E84E9-F068-44CB-B4F6-A5AC2F4CDE3D@joshtriplett.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 10, 2019 3:58:55 PM PDT, Kees Cook <keescook@chromium.org> wrote:
>On Wed, Apr 10, 2019 at 3:42 PM Sinan Kaya <okaya@kernel.org> wrote:
>>
>> We can't seem to have a kernel with CONFIG_EXPERT set but
>> CONFIG_DEBUG_KERNEL unset these days.
>>
>> While some of the features under the CONFIG_EXPERT require
>> CONFIG_DEBUG_KERNEL, it doesn't apply for all features.
>>
>> It looks like CONFIG_KALLSYMS_ALL is the only feature that
>> requires CONFIG_DEBUG_KERNEL.
>>
>> Select CONFIG_EXPERT when CONFIG_DEBUG is chosen but you can
>
>Typo: CONFIG_DEBUG_KERNEL
>
>> still choose CONFIG_EXPERT without CONFIG_DEBUG.
>
>same.
>
>>
>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>
>But with those fixed, looks good to me. Adding Josh (and others) to CC
>since he originally added the linkage to EXPERT in commit
>f505c553dbe2.

CONFIG_DEBUG_KERNEL shouldn't affect code generation in any way; it should only make more options appear in kconfig. I originally added this to ensure that features you might want to *disable* aren't hidden, as part of the tinification effort.

What specific problem does having CONFIG_DEBUG_KERNEL enabled cause for you? I'd still prefer to have a single switch for "don't hide things I might want to disable", rather than several.

This would also need checking to make sure it doesn't grow tinyconfig.
