Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D199C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0A922CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfHUQRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:17:15 -0400
Received: from ns.iliad.fr ([212.27.33.1]:51102 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbfHUQRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:17:15 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 1204220467;
        Wed, 21 Aug 2019 18:17:13 +0200 (CEST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id EC69C203E6;
        Wed, 21 Aug 2019 18:17:12 +0200 (CEST)
Subject: Re: [PATCH] mm: consolidate pgtable_cache_init() and pgd_cache_init()
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1566400018-15607-1-git-send-email-rppt@linux.ibm.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <1655e1c9-ad2c-fc31-c517-e3f55995c6b1@free.fr>
Date:   Wed, 21 Aug 2019 18:17:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566400018-15607-1-git-send-email-rppt@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Aug 21 18:17:13 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2019 17:06, Mike Rapoport wrote:

> Both pgtable_cache_init() and pgd_cache_init() are used to initialize kmem
> cache for page table allocations on several architectures that do not use
> PAGE_SIZE tables for one or more levels of the page table hierarchy.
> 
> Most architectures do not implement these functions and use __week default

s/week/weak  ?
