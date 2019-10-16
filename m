Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1076DC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2AEC20650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392407AbfJPKZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:25:53 -0400
Received: from foss.arm.com ([217.140.110.172]:35270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730972AbfJPKZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:25:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA6CB28;
        Wed, 16 Oct 2019 03:25:52 -0700 (PDT)
Received: from bogus (unknown [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D936C3F6C4;
        Wed, 16 Oct 2019 03:25:50 -0700 (PDT)
Date:   Wed, 16 Oct 2019 11:25:45 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wuyun.wu@huawei.com" <wuyun.wu@huawei.com>, hushiyuan@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH V2] arm64: psci: Reduce waiting time of
 cpu_psci_cpu_kill()
Message-ID: <20191016102545.GA11386@bogus>
References: <18068756-0f39-6388-3290-cf03746e767d@huawei.com>
 <20191015162358.bt5rffidkv2j4xqb@willie-the-truck>
 <ab42357e-f4f9-9019-e8d9-7e9bfe106e9e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab42357e-f4f9-9019-e8d9-7e9bfe106e9e@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 11:22:23AM +0800, Yunfeng Ye wrote:
>
>
> On 2019/10/16 0:23, Will Deacon wrote:
> > Hi,
> >
> > On Sat, Sep 21, 2019 at 07:21:17PM +0800, Yunfeng Ye wrote:
> >> If psci_ops.affinity_info() fails, it will sleep 10ms, which will not
> >> take so long in the right case. Use usleep_range() instead of msleep(),
> >> reduce the waiting time, and give a chance to busy wait before sleep.
> >
> > Can you elaborate on "the right case" please? It's not clear to me
> > exactly what problem you're solving here.
> >
> The situation is that when the power is off, we have a battery to save some
> information, but the battery power is limited, so we reduce the power consumption
> by turning off the cores, and need fastly to complete the core shutdown. However, the
> time of cpu_psci_cpu_kill() will take 10ms. We have tested the time that it does not
> need 10ms, and most case is about 50us-500us. if we reduce the time of cpu_psci_cpu_kill(),
> we can reduce 10% - 30% of the total time.
>

Have you checked why PSCI AFFINITY_INFO not returning LEVEL_OFF quickly
then ? We wait for upto 5s in cpu_wait_death(worst case) before cpu_kill
is called from __cpu_die.

Moreover I don't understand the argument here. The cpu being killed
will be OFF, as soon as it can and firmware controls that and this
change is not related to CPU_OFF. And this CPU calling cpu_kill can
sleep and 10ms is good to enter idle states if it's idle saving power,
so I fail to map the power saving you mention above.

> So change msleep (10) to usleep_range() to reduce the waiting time. In addition,
> we don't want to be scheduled during the sleeping time, some threads may take a
> long time and don't give up the CPU, which affects the time of core shutdown,
> Therefore, we add a chance to busy-wait max 1ms.
>

On the other hand, usleep_range reduces the timer interval and hence
increases the chance of the callee CPU not to enter deeper idle states.

What am I missing here ? What's the use case or power off situation
you are talking about above ?

>
> > I've also added Sudeep to the thread, since I'd like his ack on the change.
> >

Thanks Will.

--
Regards,
Sudeep
