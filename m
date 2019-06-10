Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2F4C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B7020859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560197113;
	bh=PduZaRzQRSkUFp6m8ZuArUO0JgqoGEOmHa6pWYxRhLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qvcrst1tBL31h0y0WNbeZUhmj8OIbo2swAyRYLE8gaUkuSeUq3oPDk66+AiQ0SW0Y
	 AZjS0fTFfO/ufl8VS2aA5zJp8FAsIBqiExoIUI4zeHq23wZoDUM4upo8lCuYKehjkR
	 RPO9wMd/zyAvRKXehScEjRnMpcr77V5uHVzmqX6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389408AbfFJUFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389170AbfFJUFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:05:12 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8188206E0;
        Mon, 10 Jun 2019 20:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560197111;
        bh=PduZaRzQRSkUFp6m8ZuArUO0JgqoGEOmHa6pWYxRhLY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=THqierrQ3+YbCKPeWK1KP2EH89+NflIOBBl/puw8HhTzdGgC6kpn+afPni4h21D8y
         cUPYgRp1SwvfIcbGjuZD/510c42MO514WgKmJwvDnF3o4XJwKjUM+oc0zmAwDDwSQq
         GA3St+YuMNf3bmJYn7ZzZ+PLg5m1N7zCIehpkVHI=
Date:   Mon, 10 Jun 2019 13:05:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] mm: treewide: Clarify pgtable_page_{ctor,dtor}() naming
Message-Id: <20190610130511.310e8d2cc8d6b02b2c3e238d@linux-foundation.org>
In-Reply-To: <20190610163354.24835-1-mark.rutland@arm.com>
References: <20190610163354.24835-1-mark.rutland@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019 17:33:54 +0100 Mark Rutland <mark.rutland@arm.com> wrote:

> The naming of pgtable_page_{ctor,dtor}() seems to have confused a few
> people, and until recently arm64 used these erroneously/pointlessly for
> other levels of pagetable.
> 
> To make it incredibly clear that these only apply to the PTE level, and
> to align with the naming of pgtable_pmd_page_{ctor,dtor}(), let's rename
> them to pgtable_pte_page_{ctor,dtor}().
> 
> The bulk of this conversion was performed by the below Coccinelle
> semantic patch, with manual whitespace fixups applied within macros, and
> Documentation updated by hand.

eep.  I get a spectacular number of rejects thanks to Mike's series

asm-generic-x86-introduce-generic-pte_allocfree_one.patch
alpha-switch-to-generic-version-of-pte-allocation.patch
arm-switch-to-generic-version-of-pte-allocation.patch
arm64-switch-to-generic-version-of-pte-allocation.patch
csky-switch-to-generic-version-of-pte-allocation.patch
m68k-sun3-switch-to-generic-version-of-pte-allocation.patch
mips-switch-to-generic-version-of-pte-allocation.patch
nds32-switch-to-generic-version-of-pte-allocation.patch
nios2-switch-to-generic-version-of-pte-allocation.patch
parisc-switch-to-generic-version-of-pte-allocation.patch
riscv-switch-to-generic-version-of-pte-allocation.patch
um-switch-to-generic-version-of-pte-allocation.patch
unicore32-switch-to-generic-version-of-pte-allocation.patch

But at least they will make your patch smaller!
