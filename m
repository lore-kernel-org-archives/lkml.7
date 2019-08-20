Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF95C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3652082F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfHTLZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 07:25:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51683 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729878AbfHTLZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:25:19 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i02FB-000394-HA; Tue, 20 Aug 2019 13:24:05 +0200
Date:   Tue, 20 Aug 2019 13:24:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin )" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Li <liwei391@huawei.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Waiman Long <longman@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Grzegorz Halat <ghalat@redhat.com>,
        Len Brown <len.brown@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Yury Norov <ynorov@marvell.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Mukesh Ojha <mojha@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] smp: Add cpu unstopped mask for
 smp_send_stop/stop_other_cpus
In-Reply-To: <20190820100843.3028-1-hsinyi@chromium.org>
Message-ID: <alpine.DEB.2.21.1908201321200.2223@nanos.tec.linutronix.de>
References: <20190820100843.3028-1-hsinyi@chromium.org>
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

On Tue, 20 Aug 2019, Hsin-Yi Wang wrote:

> In arm/arm64/x86, reboot IPI function uses CPU online mask to let
> primary CPU know how many secondary CPUs it has to wait for in
> smp_send_stop()/native_stop_other_cpus().
> 
> However, sometimes this would trigger unnecessary warnings, since
> interrupts and tasks might fall on a CPU that has already executed
> the reboot ipi function. This is fine since CPU is already in spinloop.
> But warnings are generated since it finds that the CPU is marked as
> offiline. The warnings are supposed to catch failures in normal hotplug
> offline CPUs, and reboot isn't a regular hotplug. So instead of reusing
> online masks, we should use a new mask in reboot IPI functions to do the
> work.
> 
> Take tick broadcast for example. If broadcast and smp_send_stop()
> happen together, most of the time, the CPU getting earliest broadcast
> is already in spinloop and thus won't do anything. If the first
> broadcast arrives to CPU that hasn't already executed reboot ipi, it
> would try to IPI another CPU, but the CPU is already marked as offline,
> and warning comes out:
> 
> [   22.481523] reboot: Restarting system
> [   22.481608] WARNING: CPU: 4 PID: 0 at ...

That is really the complete wrong approach. There is no valid reason that a
regular reboot needs to use a shortcut homebrewn variant of stopping CPUs.

The proper solution is to restrict this mechansim to emergency reboots and
let the normal reboot go through the regular CPU hotplug mechanism. That
avoids all that duct tape which is just bound to break tomorrow again.

In case of an emergency reboot, we really do not care about any extra stuff
triggered. The machine is hosed already.

Thanks

	tglx


