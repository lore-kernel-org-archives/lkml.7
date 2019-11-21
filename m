Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EE1C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9B520715
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574315852;
	bh=0IpMLOtsTpNEWZD/z0kqVmaagbMmbrSjPdDElhyk8eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jXCzoQcBq24FSRh2lyXlhlVtLZKIw0RVB6aw4TJdumn+UQXGyY+oFi0IUXhbqYIX2
	 x/dtDVJ1R3AGC5CEsJfe8rF801ciHRfUzd4XaNUHZ6q+9NGfzlMiJ2UnGAK6ACmhIH
	 1gzurwFdwB2sV+wt0k7qjZ9l92YT/fRkm5gW71sA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKUF5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 00:57:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35277 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUF5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:57:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id 8so2313749wmo.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 21:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dkWuzJhFxsap/bBn2x3w9fV4hC7gHwnEGs4GgvrBBhY=;
        b=mYdeGcMZBOk1xCoELA4GJrpa93t+ES8qiGwicihqG3mkodMwQRYHR0wwdgFcjWNguY
         sqD/0rwxN3n2uLcr/IxihJ2PDrYBZ41Ix/I4RFxGz07FF4iSTNM3UqUQyjCqdA0FVU5i
         dshR2z3SufdDSG7vpLELHY7Ib+E0M5k67HZG23kqbgRXQIpvLjJAcfihGb2CRger/ioT
         AmJzYRl1ySktpHsP5TsNLMeLIeN74FRUkvJ6l9zhaZVvZZMevRtB22s/ASrlTPeJh+ov
         79Mju2BLFuVS81lgFk5LH2lBxU5v0gm9GCostjkCPuXn++uT0o3R18FI/i5e4Xqcs6Wh
         0sUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dkWuzJhFxsap/bBn2x3w9fV4hC7gHwnEGs4GgvrBBhY=;
        b=m91eUnKuOAlw6895g7oGTRRDPz6skEWv4z4cIHO8BoCHtPubdgmxhg71Z4nZ94T+/D
         5tABn7bwmm0CZuZwYnhXgGnlGn9h7mts+mbZl9L2HBtVsLVxsGRhUHAe5QD11K8RlVc3
         TKIjsmZLXjgPl02yrycdcchuxiHLRH2nVAf73rC9vqa3vIAwoXxdesUYvQ5LEFGU4yuR
         /Acs9sjiqnVyBVhSU/+rH7+FwSmL6jHd4En2ZRnWRSErz+AzM0HMOh4TX7kSKiqJ9Vaw
         W5ovdoZsb41QonodSzD+R3Wl9Vjews8wsalpV7Bxh31EWqzIhFt/7byM7FajKrXc8teS
         2f1A==
X-Gm-Message-State: APjAAAXgNdkc93hNpDCoBNioknckM0IxjjSOuifE5QTKIPW0p/bORuWE
        hH1/WJATGmfU0/XAqg102g4=
X-Google-Smtp-Source: APXvYqwG/3Bmtg3JxWQv3lu0mHaTyFMUUmm0kiF/qwo8VyZfN0iFmdDR2jVSmXBI6rc5gznjgJhckw==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr7075478wmb.87.1574315847558;
        Wed, 20 Nov 2019 21:57:27 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id y78sm1782525wmd.32.2019.11.20.21.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 21:57:26 -0800 (PST)
Date:   Thu, 21 Nov 2019 06:57:24 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -tip v3 0/4] x86,mm/pat: Move towards using generic
 interval tree
Message-ID: <20191121055724.GA38182@gmail.com>
References: <20191121011601.20611-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121011601.20611-1-dave@stgolabs.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Davidlohr Bueso <dave@stgolabs.net> wrote:

> Changes from v2:
>  - Removed unnecessary goto error path in patch 1, per tglx.
>  - Added the corresponding Makefile change for patch 4, per mingo.
>  - Added tglx's review tags.
> 
> Changes from v1[0]:
>  - Got rid of more code in patch 1 by using the end - 1 for closed
>    intervals, instead of keeping the overlap-check.
>    
>  - added an additional cleanup patch.
> 
> Hi,
> 
> I'm sending this series again in this format as the interval tree
> node conversion will, at a minimum, take longer than hoped for
> (ie: Jason still removing interval tree users for the mmu_notifier
> rework[1]). There is also a chance this will never see be done.
> 
> As such, I'm resending this series (where patch 1 is the only
> interesting one and which Ingo acked previously, with the exception
> that the nodes remain fully closed). In the future, it would be
> trivial to port pat tree to semi open nodes, but for now think that
> it makes sense to just get the pat changes in.
> 
> Please consider for v5.5. Thanks!
> 
> [0] https://lore.kernel.org/lkml/20190813224620.31005-1-dave@stgolabs.net/
> [1] https://marc.info/?l=linux-mm&m=157116340411211
> 
> Davidlohr Bueso (4):
>   x86/mm, pat: Convert pat tree to generic interval tree
>   x86/mm, pat: Cleanup some of the local memtype_rb_* calls
>   x86/mm, pat: Drop rbt prefix from external memtype calls
>   x86/mm, pat: Rename pat_rbtree.c to pat_interval.c
> 
>  arch/x86/mm/Makefile       |   2 +-
>  arch/x86/mm/pat.c          |   8 +-
>  arch/x86/mm/pat_internal.h |  20 ++--
>  arch/x86/mm/pat_interval.c | 185 +++++++++++++++++++++++++++++++
>  arch/x86/mm/pat_rbtree.c   | 268 ---------------------------------------------
>  5 files changed, 200 insertions(+), 283 deletions(-)
>  create mode 100644 arch/x86/mm/pat_interval.c
>  delete mode 100644 arch/x86/mm/pat_rbtree.c

Thanks Davidlohr - this is a really nice cleanup of the logic and of the 
tree data structure, and I've applied your earlier series to 
tip:WIP.x86/mm already, with a few more work-in-progress patches from me 
on top that tidy up this area of the code.

In particular I've done a bunch of changes to improve the hackability of 
all pat/memtype/set_memory facilities, we've now got <asm/memtype.h>, 
memtype.[ch], memtype_interval.c and set_memory.c in arch/x86/mm/pat/:

 dagon:~/tip> ls -l arch/x86/mm/pat/
 total 112
 -rw-r--r-- 1 mingo mingo  5782 Nov 21 06:41 cpa-test.c
 -rw-r--r-- 1 mingo mingo   117 Nov 21 06:41 Makefile
 -rw-r--r-- 1 mingo mingo 32026 Nov 21 06:41 memtype.c
 -rw-r--r-- 1 mingo mingo  1470 Nov 21 06:41 memtype.h
 -rw-r--r-- 1 mingo mingo  5003 Nov 21 06:41 memtype_interval.c
 -rw-r--r-- 1 mingo mingo 56668 Nov 21 06:41 set_memory.c

 ( Note: cpa-test.c should probable be renamed to set_memory_test.c, with 
   a few explicit set_memory() API tests added as well, not just the 
   internal change_page_attribute() tests. Will do this later. )

The memtype APIs are (rightside column):

            reserve_memtype()               => memtype_reserve()
            free_memtype()                  => memtype_free()
            kernel_map_sync_memtype()       => memtype_kernel_map_sync()
            io_reserve_memtype()            => memtype_reserve_io()
            io_free_memtype()               => memtype_free_io()
    
            memtype_check_insert()          => memtype_check_insert()
            memtype_erase()                 => memtype_erase()
            memtype_lookup()                => memtype_lookup()
            memtype_copy_nth_element()      => memtype_copy_nth_element()

But there's a lot more changes:

 218bf1a8c73b: x86/mm/pat: Convert the PAT tree to a generic interval tree
 3309be371c20: x86/mm/pat: Clean up some of the local memtype_rb_*() calls
 b40805c214c5: x86/mm/pat: Drop the rbt_ prefix from external memtype function names
 ee4e7b04b718: x86/mm/pat: Rename pat_rbtree.c to pat_interval.c

 8afed68b3426: x86/mm/pat: Update the comments in pat.c and pat_interval.c and refresh the code a bit
 bc8a3eed1241: x86/mm/pat: Disambiguate PAT-disabled boot messages
 10ffd914266a: x86/mm/pat: Create fixed width output in /sys/kernel/debug/x86/pat_memtype_list, similar to the E820 debug printouts
 37dfd5d60000: x86/mm/pat: Simplify the free_memtype() control flow
 b686cd38771d: x86/mm/pat: Harmonize 'struct memtype *' local variable and function parameter use
 7fa6ebcdfb73: x86/mm/pat: Clean up PAT initialization flags
 a224f826be60: x86/mm/pat: Move the memtype related files to arch/x86/mm/pat/
 acb2f580640a: x86/mm/pat: Standardize on memtype_*() prefix for APIs
 393cac16e6b7: x86/mm/pat: Rename <asm/pat.h> => <asm/memtype.h>
 22a6d30c44c7: x86/mm/pat: Clean up <asm/memtype.h> externs
 56ca0be07c28: x86/mm/pat: Fix typo in the Kconfig help text
 07fbea7b3be2: x86/mm: Tabulate the page table encoding definitions

I'll send them out separately as well once completed, but wanted to give 
you a heads-up. My patches are in WIP state because neither the 
changelogs nor the split-up is necessarily final.

These can all be accessed and followed under:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/mm

What do you think about these changes? Anything else you'd like to see 
happen?

In terms of upstreaming plans, the 4 commits from you I grouped 
separately definitely look like v5.5 material to me - will merge them 
into tip:x86/mm later today.

Thanks,

	Ingo
