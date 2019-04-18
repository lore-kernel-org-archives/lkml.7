Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A0FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FD72183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbfDRJuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:50:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58614 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733049AbfDRJuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:50:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 738F215AB;
        Thu, 18 Apr 2019 02:50:20 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CBC73F68F;
        Thu, 18 Apr 2019 02:50:18 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:50:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Qian Cai <cai@lca.pw>, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/mm/mem_encrypt: fix a crash with kmemleak_scan
Message-ID: <20190418095015.GB18646@arrakis.emea.arm.com>
References: <20190409040502.55361-1-cai@lca.pw>
 <20190416171104.GI31772@zn.tnic>
 <26957df8-f1b0-c000-2edf-1368ce22bfce@lca.pw>
 <20190418074510.GB27160@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418074510.GB27160@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 09:45:10AM +0200, Borislav Petkov wrote:
> On Tue, Apr 16, 2019 at 08:38:30PM -0400, Qian Cai wrote:
> > kmemleak_init() will register the data/bss sections (only register
> > .data..ro_after_init if not within .data) and then kmemleak_scan() will scan
> > those address and dereference them looking for pointer referencing. If
> > free_init_pages() free and unmap pages in those sections, kmemleak_scan() will
> > trigger a crash if referencing one of those addresses.
> >
> > I checked other x86 free_init_pages() call sites and don't see anything obvious
> > where another place to free an address in those sections.
> 
> And why is .bss/.data special and why does it need that special handling
> by kmemleak?

Kmemleak is basically a tri-colour marking tracing garbage collector [1]
but without automatic freeing. It relies on a graph of references
(pointers) between various objects and the root of such graph is the
.bss/.data.

free_init_pages() is called on memory regions outside .bss/.data like
smp_locks, initrd, kernel init text which kmemleak does not track
anyway. That said, kmemleak_free_part() is tolerant to unknown pointers,
so we could call it directly from free_init_pages().

> There must be some rule or a heuristic why kmemleak does that. Is that
> documented somewhere?

There is Documentation/dev-tools/kmemleak.rst briefly mentioning the
tracing garbage collector (although the Wikipedia link is no longer
valid, it should be replaced with [1]). It doesn't, however, state why
.bss/.data are special.

-- 
Catalin

[1] https://en.wikipedia.org/wiki/Tracing_garbage_collection#Tri-color_marking
