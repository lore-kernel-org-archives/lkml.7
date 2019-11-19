Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BCEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D88F223CA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfKSWvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:51:06 -0500
Received: from foss.arm.com ([217.140.110.172]:59232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfKSWvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:51:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81E911FB;
        Tue, 19 Nov 2019 14:51:05 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41E2B3F52E;
        Tue, 19 Nov 2019 14:51:03 -0800 (PST)
Date:   Tue, 19 Nov 2019 22:51:00 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Richard Fontana <rfontana@redhat.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] arm64: hibernate.c: create a new function to
 handle cpu_up(sleep_cpu)
Message-ID: <20191119225100.gqiiiwoyt3yntdoj@e107158-lin.cambridge.arm.com>
References: <20191030153837.18107-1-qais.yousef@arm.com>
 <20191030153837.18107-2-qais.yousef@arm.com>
 <alpine.DEB.2.21.1911192326120.6731@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911192326120.6731@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/19 23:31, Thomas Gleixner wrote:
> On Wed, 30 Oct 2019, Qais Yousef wrote:
> >  
> > +int hibernation_bringup_sleep_cpu(unsigned int sleep_cpu)
> 
> That function name is horrible. Aside of that I really have to ask how you
> end up hibernating on an offline CPU?

James Morse can probably explain better.

But AFAIU we could sleep on any CPU, but on the next cold boot that CPU could
become offline as a side effect of using maxcpus= for example.

How about bringup_hibernate_cpu() as a name? I could add the above as an
explanation of why we need this call too.

It does seem to me that this is a generic problem that we might be able to
handle generically, but I'm not sure how.

Thanks

--
Qais Yousef
