Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02648C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C578120873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfEOTj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 15:39:28 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:48672 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfEOTj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 15:39:26 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1hQzjd-0008AI-LV; Wed, 15 May 2019 21:38:41 +0200
Date:   Wed, 15 May 2019 21:38:41 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, pasha.tatashin@oracle.com,
        alexander.h.duyck@linux.intel.com, ira.weiny@intel.com,
        andreyknvl@google.com, arunks@codeaurora.org, vbabka@suse.cz,
        cl@linux.com, riel@surriel.com, keescook@chromium.org,
        hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 0/5] mm: process_vm_mmap() -- syscall for duplication
 a process mapping
Message-ID: <20190515193841.GA29728@angband.pl>
References: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 06:11:15PM +0300, Kirill Tkhai wrote:
> This patchset adds a new syscall, which makes possible
> to clone a mapping from a process to another process.
> The syscall supplements the functionality provided
> by process_vm_writev() and process_vm_readv() syscalls,
> and it may be useful in many situation.
> 
> For example, it allows to make a zero copy of data,
> when process_vm_writev() was previously used:

I wonder, why not optimize the existing interfaces to do zero copy if
properly aligned?  No need for a new syscall, and old code would immediately
benefit.

> There are several problems with process_vm_writev() in this example:
> 
> 1)it causes pagefault on remote process memory, and it forces
>   allocation of a new page (if was not preallocated);
> 
> 2)amount of memory for this example is doubled in a moment --
>   n pages in current and n pages in remote tasks are occupied
>   at the same time;
> 
> 3)received data has no a chance to be properly swapped for
>   a long time.

That'll handle all of your above problems, except for making pages
subject to CoW if written to.  But if making pages writeably shared is
desired, the old functions have a "flags" argument that doesn't yet have a
single bit defined.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ Latin:   meow 4 characters, 4 columns,  4 bytes
⣾⠁⢠⠒⠀⣿⡁ Greek:   μεου 4 characters, 4 columns,  8 bytes
⢿⡄⠘⠷⠚⠋  Runes:   ᛗᛖᛟᚹ 4 characters, 4 columns, 12 bytes
⠈⠳⣄⠀⠀⠀⠀ Chinese: 喵   1 character,  2 columns,  3 bytes <-- best!
