Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4459C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C555620659
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfF0Rzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:55:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:26901 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfF0Rzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:55:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 10:55:42 -0700
X-IronPort-AV: E=Sophos;i="5.63,424,1557212400"; 
   d="scan'208";a="337657300"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.95]) ([10.24.14.95])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 27 Jun 2019 10:55:40 -0700
Subject: Re: [PATCH 00/10] x86/CPU and x86/resctrl: Support pseudo-lock
 regions spanning L2 and L3 cache
To:     David Laight <David.Laight@ACULAB.COM>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1561569068.git.reinette.chatre@intel.com>
 <41cd71514a9042abaaef909d816e2522@AcuMS.aculab.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <a9be6561-548b-d384-d877-a3e031013710@intel.com>
Date:   Thu, 27 Jun 2019 10:55:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <41cd71514a9042abaaef909d816e2522@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 6/27/2019 2:12 AM, David Laight wrote:
> From: Reinette Chatre
>> Sent: 26 June 2019 18:49
>>
>> Cache pseudo-locking involves preloading a region of physical memory into a
>> reserved portion of cache that no task or CPU can subsequently fill into and
>> from that point on will only serve cache hits. At this time it is only
>> possible to create cache pseudo-locked regions in either L2 or L3 cache,
>> supporting systems that support either L2 Cache Allocation Technology (CAT)
>> or L3 CAT because CAT is the mechanism used to manage reservations of cache
>> portions.
> 
> While this is a 'nice' hardware feature for some kinds of embedded systems
> I don't see how it can be sensibly used inside a Linux kernel.

Cache pseudo-locking is an existing (obviously not well known) feature
in Linux kernel since v4.19.

> There are an awful lot of places where things can go horribly wrong.

The worse thing that can go wrong is that the memory is evicted from the
pseudo-locked region and when it is accessed again it will have to share
cache with all other memory sharing the same class of service it is
accessed under. The consequence is lower latency when accessing this
high priority memory and reduced cache availability due to the orphaned
ways used for the pseudo-locked region.

This worse case could happen when the task runs on a CPU that is not
associated with the cache on which its memory is pseudo-locked, so the
application is expected to be associated only to CPUs associated with
the correct cache. This is familiar to high priority applications.

Other ways in which memory could be evicted are addressed below as part
of your detailed concerns.

> I can imagine:
> - Multiple requests to lock regions that end up trying to use the same
>   set-associative cache lines leaving none for normal operation.

I think that you are comparing this to cache coloring perhaps? Cache
pseudo-locking builds on CAT that is a way-based cache allocation
mechanism. It is impossible to use all cache ways for pseudo-locking
since the default resource group cannot be used for pseudo-locking and
resource groups will always have cache available to them (specifically:
an all zero capacity bitmask (CBM) is illegal on Intel hardware to which
this feature is specific).

> - Excessive cache line bouncing because fewer lines are available.

This is not specific to cache pseudo-locking. With cache allocation
technology (CAT), on which cache pseudo-locking is built, the system
administrator can partition the cache into portions and assign
tasks/CPUs to these different portions to manage interference between
the different tasks/CPUs.

You are right that fewer cache lines would be available to different
tasks/CPUs. By reducing the number of cache lines available to specific
classes of service and managing overlap between these different classes
of service the system administrator is able to manage interference
between different classes of tasks or even CPUs.

> - The effect of cache invalidate requests for the locked addresses.

This is correct and documented in Documentation/x86/resctrl_ui.rst

<snip>
Cache pseudo-locking increases the probability that data will remain
in the cache via carefully configuring the CAT feature and controlling
application behavior. There is no guarantee that data is placed in
cache. Instructions like INVD, WBINVD, CLFLUSH, etc. can still evict
“locked” data from cache. Power management C-states may shrink or
power off cache. Deeper C-states will automatically be restricted on
pseudo-locked region creation.
<snip>

An application requesting pseudo-locked memory should not CLFLUSH that
memory.

> - I suspect the Linux kernel can do full cache invalidates at certain times.

This is correct. Fortunately Linux kernel is averse to calling WBINVD
during runtime and not many instances remain. A previous attempt at
handling these found only two direct invocations of WBINVD, neither of
which were likely to be used on a cache pseudo-lock system. During that
discussion it was proposed that instead of needing to handle these, we
should just be getting rid of WBINVD but such a system wide change was
too daunting for me at that time. For reference, please see:
http://lkml.kernel.org/r/alpine.DEB.2.21.1808031343020.1745@nanos.tec.linutronix.de

> 
> You've not given a use case.
> 

I think you may be asking for a use case of the original cache
pseudo-locking feature, not a use case for the additional support
contained in this series? Primary usages right now for cache
pseudo-locking are industrial PLCs/automation and high-frequency
trading/financial enterprise systems, but anything with relatively small
repeating data structures should see benefit.

Reinette
