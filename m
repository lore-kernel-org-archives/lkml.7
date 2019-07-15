Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3501DC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D65621734
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfGOIYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 04:24:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46660 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfGOIY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 04:24:27 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hmwHW-00059u-Qz; Mon, 15 Jul 2019 10:24:24 +0200
Date:   Mon, 15 Jul 2019 10:24:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Uros Bizjak <ubizjak@gmail.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andrew Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH, x86]: Disable CPA cache flush for selfsnoop
 targets
In-Reply-To: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907151020320.1669@nanos.tec.linutronix.de>
References: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uros,

On Thu, 11 Jul 2019, Uros Bizjak wrote:
> Recent patch [1] disabled a self-snoop feature on a list of processor
> models with a known errata, so we are confident that the feature
> should work on remaining models also for other purposes than to speed
> up MTRR programming.
> 
> I would like to resurrect an old patch [2] that avoids calling clflush
> and wbinvd
> to invalidate caches when CPU supports selfsnoop.

Please do not attach patches, send them inline and please add a proper
changelog. Just saying 'Disable CPA cache flush for selfsnoop targets' in
the subject line then nada gives absolutely zero information.
 
> The patch was ported to latest Fedora kernel (5.1.16) and tested with
> CONFIG_CPA_DEBUG on INTEL_FAM6_IVYBRIDGE_X. The relevant ports of
> dmesg show:
> 
> ...
> < hundreds of CPA protect messages, resulting from set_memory_rw CPA
> undo test in mm/init_64.c >
> CPA  protect  Rodata RO: 0xffffffffbd1fe000 - 0xffffffffbd1fefff PFN
> 1461fe req 8000000000000063 prevent 0000000000000002
> CPA  protect  Rodata RO: 0xffff889c461fe000 - 0xffff889c461fefff PFN
> 1461fe req 8000000000000063 prevent 0000000000000002
> Testing CPA: again
> Freeing unused kernel image memory: 2016K
> Freeing unused kernel image memory: 4K
> x86/mm: Checked W+X mappings: passed, no W+X pages found.
> rodata_test: all tests were successful
> x86/mm: Checking user space page tables
> x86/mm: Checked W+X mappings: passed, no W+X pages found.
> 
> and from CPA selftest:
> 
> CPA self-test:
>  4k 36352 large 4021 gb 0 x 81[ffff889b00098000-ffff889bdf7ff000] miss 133120
>  4k 180224 large 3740 gb 0 x 81[ffff889b00098000-ffff889bdf7ff000] miss 133120
>  4k 180224 large 3740 gb 0 x 81[ffff889b00098000-ffff889bdf7ff000] miss 133120
> ok.

These outputs are pretty useless simply because the selftest only verifies
the inner workings of CPA itself, but has nothing to do with the
correctness vs. cache flushing.

Thanks,

	tglx
