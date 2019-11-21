Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EA9C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E99F20692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574356136;
	bh=ghmMB5GcM3OoIWDLflDHvpDZM03WdoPeqIX6aWRzKHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F8/WhlpKD+/hGX0QLpjBp0m3eyzikXa9r2FhTSxYWGHy8M1vhxZYVGHWYvmKbS4UF
	 lO0s09gy+tzN1txj/gnjgyyRBviWds6vYFmsze2URTRzOQ1eGi3eXno402RnY19JKD
	 559AXP5PWUOTW6WHKX1hx0XIlNqtBkdC4IqZn9vc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKURIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:08:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40683 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfKURIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:08:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id y5so4573762wmi.5;
        Thu, 21 Nov 2019 09:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tJAmMjDZD3KRi/40xv3u3AIT54hpltbm49NEAdIVwBU=;
        b=mC54IYR1i6qn0Y+OSbdyzF2QrFnw/ezm55P82m5v8ilvRuI4HCNpYwqwhicyYmuGfp
         cOJg+kZMMaBg9cm0tiS2nKnNoOxYZaodchanU4IiBxws0PQhuJ267mjKA1uwS711nw0O
         nOalDZ8wQcNqBz5SydywB3MClJ6itLWj2RLg6zxqY50cYysoQh0BMNxBO0QNia5Y3lMo
         DxSFt6UUIOL5Jpog3VZMvLipW000KmErEjwd5iF3Bt1+GgD7LE9LnPSz9i1LN2RvPmUk
         KS1M8aH/tKiGxf+xE9m6C3EdPw5OnOaMNn97vxFHdQ2S/nfr+U2KaDI+NFi2tu/+hZaL
         Zmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tJAmMjDZD3KRi/40xv3u3AIT54hpltbm49NEAdIVwBU=;
        b=Qkzr2uB/30pJ3FCpbnRWmsot+R7nJQdl2Xd16e0k9j9X5lg2H23V5MlV7CRcxF2NyQ
         RczP7NizZMkcm8Slx75gJXBnxSRTqanT50vYkBAbyofJ2qbYOcm44TSgjmN+TvEH0mLv
         1oSWTBIsve08Y2pDnPirUY4wREE4L4WBWMpsSbZxjOcqP94ZhOOtPhUkwz6z4z3GAH3X
         il/FLSeIpx0H2dITwVfDSzoa2/8rFtEw2jwYoTmHFq2FUpffCspH1+Wd8R3xGF2grXcJ
         ARNZmzSzjoEE0OrLM3HCEQMPtC+1uy8vVvlMP6Xx2jlApbxCf6kv1tuHb7B8axL/vYFV
         PKIw==
X-Gm-Message-State: APjAAAU9gk7mTCb2GphKY3fjdAUeH8HMD98BiWNeInk2P4VybQFtCPWC
        Ax9/v1Xlqf0YBM7Q/Gaba5k=
X-Google-Smtp-Source: APXvYqyTRQoy9KCVb/TrsrP85AdKMlHufzE2RQ8tO/8ZduBeKnBJRct2hYDBTOgZ1h84TxN4k7AUhA==
X-Received: by 2002:a1c:e915:: with SMTP id q21mr10421973wmc.148.1574356131945;
        Thu, 21 Nov 2019 09:08:51 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id t14sm3925269wrw.87.2019.11.21.09.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 09:08:51 -0800 (PST)
Date:   Thu, 21 Nov 2019 18:08:49 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>, dave@stgolabs.net,
        x86 <x86@kernel.org>
Subject: Re: [tip: x86/mm] x86/mm/pat: Rename pat_rbtree.c to pat_interval.c
Message-ID: <20191121170849.GB12042@gmail.com>
References: <20191021231924.25373-5-dave@stgolabs.net>
 <157431619321.21853.6320580586819014584.tip-bot2@tip-bot2>
 <CAHk-=wg565YQe6Dmpjg6QJ9aPHvkT7G60iDYS12TZoG+q+hbTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg565YQe6Dmpjg6QJ9aPHvkT7G60iDYS12TZoG+q+hbTw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Nov 20, 2019, 22:03 tip-bot2 for Davidlohr Bueso <
> tip-bot2@linutronix.de> wrote:
> 
> >
> > x86/mm/pat: Rename pat_rbtree.c to pat_interval.c
> >
> > Considering that we don't use an rbtree but an interval tree,
> > rename the main file accordingly.
> >
> 
> Wouldn't it be even better to not make the same mistake all over again, and
> instead of naming the file by an implementation detail, it should be named
> by what it does?
> 
> Maybe pat_memtype.c or just pat_manage.c or something?
> 
> Or even just pat.c?

Yeah, so incidentally, just before you made this suggestion yesterday, I 
rearranged the files quite a bit in tip:WIP.x86/mm, and the latest naming 
scheme is:

 dagon:~/tip> ls -l arch/x86/mm/pat/
 total 112
 -rw-r--r-- 1 mingo mingo  5782 Nov 21 06:41 cpa-test.c
 -rw-r--r-- 1 mingo mingo   117 Nov 21 06:41 Makefile
 -rw-r--r-- 1 mingo mingo 32026 Nov 21 06:41 memtype.c
 -rw-r--r-- 1 mingo mingo  1470 Nov 21 06:41 memtype.h
 -rw-r--r-- 1 mingo mingo  5003 Nov 21 06:41 memtype_interval.c
 -rw-r--r-- 1 mingo mingo 56668 Nov 21 06:41 set_memory.c

I named most of the files based on the API families they are 
implementing:

 - memtype*.c for the <asm/memtype.h> APIs
 - set_memory.c for the <asm/set_memory.h> APIs.

Is this close to what you had in mind?

 ( Note: cpa-test.c is a leftover that should probably be renamed to 
   set_memory_test.c, with a few explicit set_memory() API tests added as 
   well, not just the internal change_page_attribute() tests. )

I also started the process of tidying up the API namespace which is a bit 
of a historical accident as well, and I'm done with most of the memtype 
funtions, which are now:

            reserve_memtype()               => memtype_reserve()
            free_memtype()                  => memtype_free()
            kernel_map_sync_memtype()       => memtype_kernel_map_sync()
            io_reserve_memtype()            => memtype_reserve_io()
            io_free_memtype()               => memtype_free_io()

            memtype_check_insert()          => memtype_check_insert()
            memtype_erase()                 => memtype_erase()
            memtype_lookup()                => memtype_lookup()
            memtype_copy_nth_element()      => memtype_copy_nth_element()

This work is in WIP.x86/mm:

 git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/mm

 f53ee099dfac: x86/mm: Tabulate the page table encoding definitions
 2ab1a9a197f7: x86/mm/pat: Fix typo in the Kconfig help text
 0d2a9498e4db: x86/mm/pat: Clean up <asm/memtype.h> externs
 2e2ee215db87: x86/mm/pat: Rename <asm/pat.h> => <asm/memtype.h>
 84285e92bb7a: x86/mm/pat: Standardize on memtype_*() prefix for APIs
 b2c61e70ccca: x86/mm/pat: Move the memtype related files to arch/x86/mm/pat/
 f54b639ad101: x86/mm/pat: Clean up PAT initialization flags
 bca867e88012: x86/mm/pat: Harmonize 'struct memtype *' local variable and function parameter use
 35459848e92f: x86/mm/pat: Simplify the free_memtype() control flow
 a71fbb6061dc: x86/mm/pat: Create fixed width output in /sys/kernel/debug/x86/pat_memtype_list, similar to the E820 debug printouts
 a252a95b6b91: x86/mm/pat: Disambiguate PAT-disabled boot messages
 83d743db88c5: x86/mm/pat: Update the comments in pat.c and pat_interval.c and refresh the code a bit

 820cac65197c: x86/mm/pat: Rename pat_rbtree.c to pat_interval.c
 010ca1041da3: x86/mm/pat: Drop the rbt_ prefix from external memtype calls
 a2cb4c9af315: x86/mm/pat: Do not pass 'rb_root' down the memtype tree helper functions
 2418ac70a9c1: x86/mm/pat: Convert the PAT tree to a generic interval tree

But there's still quite some work left. I'll send out a series once I 
think the end result is a coherent whole.

Davidlohr's four patches are intended for v5.5, the remaining patches 
from me on top of his work will probably need a bit more testing.

Thanks,

	Ingo
