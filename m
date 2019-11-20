Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C995C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB0822429
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfKTKti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:49:38 -0500
Received: from foss.arm.com ([217.140.110.172]:37176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbfKTKti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:49:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FBDA1FB;
        Wed, 20 Nov 2019 02:49:37 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B6D73F6C4;
        Wed, 20 Nov 2019 02:49:36 -0800 (PST)
Date:   Wed, 20 Nov 2019 10:49:34 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] ia64: Replace cpu_down with freeze_secondary_cpus
Message-ID: <20191120104933.e6gkdjwkzulm6uak@e107158-lin.cambridge.arm.com>
References: <20191030153837.18107-1-qais.yousef@arm.com>
 <20191030153837.18107-5-qais.yousef@arm.com>
 <alpine.DEB.2.21.1911192318400.6731@nanos.tec.linutronix.de>
 <20191119223234.ov323rcln4slj7br@e107158-lin.cambridge.arm.com>
 <alpine.DEB.2.21.1911192344110.6731@nanos.tec.linutronix.de>
 <20191119231912.viwqgcyzttoo5eou@e107158-lin.cambridge.arm.com>
 <alpine.DEB.2.21.1911200944590.6731@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911200944590.6731@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/19 09:46, Thomas Gleixner wrote:
> On Tue, 19 Nov 2019, Qais Yousef wrote:
> > On 11/19/19 23:59, Thomas Gleixner wrote:
> > > On Tue, 19 Nov 2019, Qais Yousef wrote:
> > > > My plan was to simply make freeze_secondary_cpus() available and protected by
> > > > CONFIG_SMP only instead.
> > > > 
> > > > Good plan?
> > > 
> > > No. freeze_secondary_cpus() is really for hibernation. Look at the exit
> > > conditions there.
> > 
> > Hmm do you mean the pm_wakeup_pending() abort?
> > 
> > In arm64 we machine_shutdown() calls disable_nonboot_cpus(), which in turn
> > a wrapper around freeze_secondary_cpus() with 0 passed as an argument.
> > 
> > IIUC this means arm64 could fail to offline all CPUs on machine_shutdown(),
> > correct?
> 
> Looks like.

Okay I'll double check and introduce a new function to be called from
machine_down() for arm64 and ia64 if necessary.

Thanks

--
Qais Yousef
