Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AFDC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CD82081C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbfGOPoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:44:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:36618 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730257AbfGOPoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:44:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A3D5AF78;
        Mon, 15 Jul 2019 15:44:21 +0000 (UTC)
Date:   Mon, 15 Jul 2019 17:44:18 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] x86/mm: Check for pfn instead of page in
 vmalloc_sync_one()
Message-ID: <20190715154418.GA13091@suse.de>
References: <20190715110212.18617-1-joro@8bytes.org>
 <20190715110212.18617-2-joro@8bytes.org>
 <alpine.DEB.2.21.1907151508210.1722@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907151508210.1722@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 03:08:42PM +0200, Thomas Gleixner wrote:
> On Mon, 15 Jul 2019, Joerg Roedel wrote:
> 
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > Do not require a struct page for the mapped memory location
> > because it might not exist. This can happen when an
> > ioremapped region is mapped with 2MB pages.
> > 
> > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> 
> Lacks a Fixes tag, hmm?

Yeah, right, the question is, which commit to put in there. The problem
results from two changes:

	1) Introduction of !SHARED_KERNEL_PMD path in x86-32. In itself
	   this is not a problem, and the path was only enabled for
	   Xen-PV.

	2) Huge IORemapings which use the PMD level. Also not a problem
	   by itself, but together with !SHARED_KERNEL_PMD problematic
	   because it requires to sync the PMD entries between all
	   page-tables, and that was not implemented.

Before PTI-x32 was merged this problem did not show up, maybe because
the 32-bit Xen-PV users did not trigger it. But with PTI-x32 all PAE
users run with !SHARED_KERNEL_PMD and the problem popped up.

For the last patch I put the PTI-x32 enablement commit in the fixes tag,
because that was the one that showed up during bisection. But more
correct would probably be

	5d72b4fba40e ('x86, mm: support huge I/O mapping capability I/F')

Or do I miss something?

Regards,

	Joerg


