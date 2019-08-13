Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D32CC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D4221721
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565693939;
	bh=MaBEiztxgmjdBeftAH2vB9aH9XPEk9n5ETdjdNyHA7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N2o1Ab68Piwejl/tVXv/hPb2/DpPisbHSZIldB+VS/azgVy+3UdXkOwvnAveVaKhy
	 cPI/buPSnvUjTTtGxlpW+xnXGCAmQJ9eJqhURWcIoxD47BTVYPXtCyacauO8WZW84Z
	 EDiRGVnKEabmn7puh1T1NKnQp/0h3f081zEBpCig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfHMK66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:58:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbfHMK65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:58:57 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0C402067D;
        Tue, 13 Aug 2019 10:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565693936;
        bh=MaBEiztxgmjdBeftAH2vB9aH9XPEk9n5ETdjdNyHA7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgOGa4E7NGp30R3O6Motf5xhP/4uQWkkct3p8WloQsWNB0yxpvj1CoVTwcsrTICfB
         y75jazLM5uJqJIFJmGAcGinq/peFElvzM/ojRylSHjKM6aRpky6zAxUZ419ziKswtH
         qJECBDo6epBCOx20+w85aHHrijinGhk1KbQyOCzQ=
Date:   Tue, 13 Aug 2019 11:58:52 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: "arm64/for-next/core" causes boot panic
Message-ID: <20190813105852.ovk5gtzddwlsm4ly@willie-the-truck>
References: <1565646695.8572.6.camel@lca.pw>
 <20190813090200.h2rz4xphgnb5j5bc@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813090200.h2rz4xphgnb5j5bc@willie-the-truck>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 10:02:01AM +0100, Will Deacon wrote:
> On Mon, Aug 12, 2019 at 05:51:35PM -0400, Qian Cai wrote:
> > Booting today's linux-next on an arm64 server triggers a panic with
> > CONFIG_KASAN_SW_TAGS=y pointing to this line,
> 
> Is this the only change on top of defconfig? If not, please can you share
> your full .config?
> 
> > kfree()->virt_to_head_page()->compound_head()
> > 
> > unsigned long head = READ_ONCE(page->compound_head);
> > 
> > The bisect so far indicates one of those could be bad,
> 
> I guess that means the issue is reproducible on the arm64 for-next/core
> branch. Once I have your .config, I'll give it a go.

FWIW, I've managed to reproduce this using defconfig + SW_TAGS on
for-next/core, so I'll keep investigating.

Will

--->8

[    0.000000] Unable to handle kernel paging request at virtual address 0037fe0007580d08
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x96000004
[    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000004
[    0.000000]   CM = 0, WnR = 0
[    0.000000] [0037fe0007580d08] address between user and kernel address ranges
[    0.000000] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-rc3-00049-gf964cbd07098 #1
[    0.000000] Hardware name: linux,dummy-virt (DT)
[    0.000000] pstate: 20000085 (nzCv daIf -PAN -UAO)
[    0.000000] pc : kfree+0x44/0x6ac
[    0.000000] lr : apply_wqattrs_prepare+0x390/0x3fc
[    0.000000] sp : ffff9000541d7d00
[    0.000000] x29: ffff9000541d7d80 x28: 4dff0001de034e08 
[    0.000000] x27: b2ff0001de040000 x26: 0000000000000004 
[    0.000000] x25: c1ff0001de034c28 x24: 4dff0001de034e00 
[    0.000000] x23: a8ff0001de034d00 x22: c1ff0001de020a00 
[    0.000000] x21: a8ff0001de034d08 x20: 0000000000000000 
[    0.000000] x19: c1ff0001de034c00 x18: 0000000000000000 
[    0.000000] x17: 0000000000000000 x16: 0000000000000000 
[    0.000000] x15: 1ffff6b000000000 x14: ffff900053ca87e4 
[    0.000000] x13: ffff900052539444 x12: ffff90005253ce48 
[    0.000000] x11: 00000000000000c1 x10: ffff80001de034c1 
[    0.000000] x9 : fffffdffffe00008 x8 : 0138000007780d00 
[    0.000000] x7 : ffffffffffffffff x6 : a8ff0001de034d28 
[    0.000000] x5 : 0000000000000040 x4 : 0000000000000008 
[    0.000000] x3 : 0000000000000100 x2 : ffff9000541ddf68 
[    0.000000] x1 : a8ff0001de034d08 x0 : 4dff0001de034e00 
[    0.000000] Call trace:
[    0.000000]  kfree+0x44/0x6ac
[    0.000000]  apply_wqattrs_prepare+0x390/0x3fc
[    0.000000]  apply_workqueue_attrs+0x70/0xe4
[    0.000000]  alloc_workqueue+0x514/0x728
[    0.000000]  workqueue_init_early+0x36c/0x4a0
[    0.000000]  start_kernel+0x1d0/0x46c
[    0.000000] Code: f2bffc09 d346fd08 f2dfbfe9 927acd08 (f8696909) 
[    0.000000] random: get_random_bytes called from oops_exit+0x4c/0x78 with crng_init=0
[    0.000000] ---[ end trace 0000000000000000 ]---

