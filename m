Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6736C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830CA20659
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbfGaOso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:48:44 -0400
Received: from foss.arm.com ([217.140.110.172]:48422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387593AbfGaOso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:48:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C7FD344;
        Wed, 31 Jul 2019 07:48:43 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 647DD3F694;
        Wed, 31 Jul 2019 07:48:42 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:48:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm: kmemleak: Use mempool allocations for kmemleak
 objects
Message-ID: <20190731144839.GA17773@arrakis.emea.arm.com>
References: <20190727132334.9184-1-catalin.marinas@arm.com>
 <20190730125743.113e59a9c449847d7f6ae7c3@linux-foundation.org>
 <1564518157.11067.34.camel@lca.pw>
 <20190731095355.GC63307@arrakis.emea.arm.com>
 <C8EF1660-78FF-49E4-B5D7-6B27400F7306@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8EF1660-78FF-49E4-B5D7-6B27400F7306@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 08:02:30AM -0400, Qian Cai wrote:
> On Jul 31, 2019, at 5:53 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Jul 30, 2019 at 04:22:37PM -0400, Qian Cai wrote:
> >> On Tue, 2019-07-30 at 12:57 -0700, Andrew Morton wrote:
> >>> On Sat, 27 Jul 2019 14:23:33 +0100 Catalin Marinas <catalin.marinas@arm.com>
> >>>> --- a/Documentation/admin-guide/kernel-parameters.txt
> >>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >>>> @@ -2011,6 +2011,12 @@
> >>>>  			Built with CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y,
> >>>>  			the default is off.
> >>>>  
> >>>> +	kmemleak.mempool=
> >>>> +			[KNL] Boot-time tuning of the minimum kmemleak
> >>>> +			metadata pool size.
> >>>> +			Format: <int>
> >>>> +			Default: NR_CPUS * 4
> >>>> +
> >> 
> >> Catalin, BTW, it is right now unable to handle a large size. I tried to reserve
> >> 64M (kmemleak.mempool=67108864),
[...]
> > It looks like the mempool cannot be created. 64M objects means a
> > kmalloc(512MB) for the pool array in mempool_init_node(), so that hits
> > the MAX_ORDER warning in __alloc_pages_nodemask().
> > 
> > Maybe the mempool tunable won't help much for your case if you need so
> > many objects. It's still worth having a mempool for kmemleak but we
> > could look into changing the refill logic while keeping the original
> > size constant (say 1024 objects).
> 
> Actually, kmemleak.mempool=524288 works quite well on systems I have here. This
> is more of making the code robust by error-handling a large value without the
> NULL-ptr-deref below. Maybe simply just validate the value by adding upper bound
> to not trigger that warning with MAX_ORDER.

Would it work for you with a Kconfig option, similar to
DEBUG_KMEMLEAK_EARLY_LOG_SIZE?

> >> [   16.192449][    T1] BUG: Unable to handle kernel data access at 0xffffffffffffb2aa
> > 
> > This doesn't seem kmemleak related from the trace.
> 
> This only happens when passing a large kmemleak.mempool, e.g., 64M
> 
> [   16.193126][    T1] NIP [c000000000b2a2fc] log_early+0x8/0x160
> [   16.193153][    T1] LR [c0000000003e6e48] kmem_cache_free+0x428/0x740

Ah, I missed the log_early() call here. It's a kmemleak bug where it
isn't disabled properly in case of an error and log_early() is still
called after the .text.init section was freed. I'll send a patch.

-- 
Catalin
