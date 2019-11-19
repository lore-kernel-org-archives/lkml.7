Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C830C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49D722449
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKSWg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:36:28 -0500
Received: from foss.arm.com ([217.140.110.172]:59118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfKSWg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:36:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B54631B;
        Tue, 19 Nov 2019 14:36:28 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AF473F52E;
        Tue, 19 Nov 2019 14:36:26 -0800 (PST)
Date:   Tue, 19 Nov 2019 22:36:24 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eiichi Tsukata <devel@etsukata.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] cpu: Hide cpu_up/down
Message-ID: <20191119223623.y63qalyj6t72saip@e107158-lin.cambridge.arm.com>
References: <20191030153837.18107-1-qais.yousef@arm.com>
 <20191030153837.18107-13-qais.yousef@arm.com>
 <alpine.DEB.2.21.1911192323310.6731@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911192323310.6731@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/19 23:25, Thomas Gleixner wrote:
> On Wed, 30 Oct 2019, Qais Yousef wrote:
> > -int cpu_down(unsigned int cpu)
> > +static int cpu_down(unsigned int cpu)
> >  {
> >  	return do_cpu_down(cpu, CPUHP_OFFLINE);
> >  }
> > -EXPORT_SYMBOL(cpu_down);
> 
> The exports should be gone already at this point, right?

Yes. The only in-kernel user was the torture test.

> > +/*
> > + * This function is meant to be used by device core cpu subsystem.
> > + *
> > + * Other subsystems should use device_offline(get_cpu_device(cpu)) instead.
> > + */
> 
> Can you please use proper kernel-doc function documentation?

Will do.

Thanks

--
Qais Yousef
