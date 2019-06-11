Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1784AC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B03212F5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405012AbfFKJif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:38:35 -0400
Received: from foss.arm.com ([217.140.110.172]:56368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404985AbfFKJib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:38:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD815EBD;
        Tue, 11 Jun 2019 02:38:30 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF8543F77D;
        Tue, 11 Jun 2019 02:38:29 -0700 (PDT)
Date:   Tue, 11 Jun 2019 10:38:23 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] mm: treewide: Clarify pgtable_page_{ctor,dtor}() naming
Message-ID: <20190611093822.GA26409@lakrids.cambridge.arm.com>
References: <20190610163354.24835-1-mark.rutland@arm.com>
 <20190610130511.310e8d2cc8d6b02b2c3e238d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610130511.310e8d2cc8d6b02b2c3e238d@linux-foundation.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 01:05:11PM -0700, Andrew Morton wrote:
> On Mon, 10 Jun 2019 17:33:54 +0100 Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > The naming of pgtable_page_{ctor,dtor}() seems to have confused a few
> > people, and until recently arm64 used these erroneously/pointlessly for
> > other levels of pagetable.
> > 
> > To make it incredibly clear that these only apply to the PTE level, and
> > to align with the naming of pgtable_pmd_page_{ctor,dtor}(), let's rename
> > them to pgtable_pte_page_{ctor,dtor}().
> > 
> > The bulk of this conversion was performed by the below Coccinelle
> > semantic patch, with manual whitespace fixups applied within macros, and
> > Documentation updated by hand.
> 
> eep.  I get a spectacular number of rejects thanks to Mike's series
> 
> asm-generic-x86-introduce-generic-pte_allocfree_one.patch
> alpha-switch-to-generic-version-of-pte-allocation.patch
> arm-switch-to-generic-version-of-pte-allocation.patch
> arm64-switch-to-generic-version-of-pte-allocation.patch
> csky-switch-to-generic-version-of-pte-allocation.patch
> m68k-sun3-switch-to-generic-version-of-pte-allocation.patch
> mips-switch-to-generic-version-of-pte-allocation.patch
> nds32-switch-to-generic-version-of-pte-allocation.patch
> nios2-switch-to-generic-version-of-pte-allocation.patch
> parisc-switch-to-generic-version-of-pte-allocation.patch
> riscv-switch-to-generic-version-of-pte-allocation.patch
> um-switch-to-generic-version-of-pte-allocation.patch
> unicore32-switch-to-generic-version-of-pte-allocation.patch
> 
> But at least they will make your patch smaller!

Aha; thanks for the heads-up!

Given this cleanup isn't urgent, I'll sit on it until the above has
settled.

Mark.
