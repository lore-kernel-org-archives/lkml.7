Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A77C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FCF2189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfGCJRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:17:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51194 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfGCJRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:17:13 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hibNx-0007zt-Qo; Wed, 03 Jul 2019 11:17:05 +0200
Date:   Wed, 3 Jul 2019 11:17:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Song liwei <liwei.song@windriver.com>
cc:     linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Will Deacon <will@kernel.org>, Borislav Petkov <bp@suse.de>,
        Kulkarni <Ganapatrao.Kulkarni@cavium.com>,
        Guo Ren <ren_guo@c-sky.com>, Joseph Lo <josephl@nvidia.com>,
        Hoan Tran <Hoan@os.amperecomputing.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Rafael J <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] x86/microcode, cpuhotplug: move microcode hotplug callback
 after cpu teardown
In-Reply-To: <1562143728-78052-1-git-send-email-liwei.song@windriver.com>
Message-ID: <alpine.DEB.2.21.1907031114490.1802@nanos.tec.linutronix.de>
References: <1562143728-78052-1-git-send-email-liwei.song@windriver.com>
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

On Wed, 3 Jul 2019, Song liwei wrote:

> After CPUHP_TEARDOWN_CPU callback was invoked, the context will become
> atomic and IRQ disabled, while mc_cpu_down_prep will called
> kernfs_find_and_get_ns which will try to acquire mutext lock which may
> sleep.
> 
> Adjust CPUHP_AP_MICROCODE_LOADER callback function run before
> CPUHP_TEARDOWN_CPU to fix this bug.

That's just wrong and reintroduces the bug which was fixed with that commit
as perf will access a non existing MSR which is brought in by the micro
code update.

Aside of that the mutex issue _is_ fixed in rc7 already:

 5423f5ce5ca4 ("x86/microcode: Fix the microcode load on CPU hotplug for real")

Thanks,

	tglx
