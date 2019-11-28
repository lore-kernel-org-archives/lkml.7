Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32936C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1423F21774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfK1K3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:29:32 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:46620 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfK1K3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:29:31 -0500
Received: by isilmar-4.linta.de (Postfix, from userid 1000)
        id 4F951200700; Thu, 28 Nov 2019 10:29:30 +0000 (UTC)
Date:   Thu, 28 Nov 2019 11:29:30 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: unchecked MSR access error in throttle_active_work()
Message-ID: <20191128102930.jgra6igtp4rppmis@isilmar-4.linta.de>
References: <20191128085447.GA3682@owl.dominikbrodowski.net>
 <20191128094419.GB17745@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128094419.GB17745@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 10:44:19AM +0100, Borislav Petkov wrote:
> On Thu, Nov 28, 2019 at 09:54:47AM +0100, Dominik Brodowski wrote:
> > On most recent mainline kernels (such as 5.5-rc0 up to a6ed68d6468b), I see
> > the following output in dmesg during startup:
> > 
> > [   78.016676] unchecked MSR access error: WRMSR to 0x19c (tried to write 0x00000000880f3a80) at rIP: 0xffffffff84ab5742 (throttle_active_work+0xf2/0x230)
> > [   78.016686] Call Trace:
> > [   78.016694]  process_one_work+0x247/0x590
> > [   78.016703]  worker_thread+0x50/0x3b0
> > [   78.016710]  kthread+0x10a/0x140
> > [   78.016715]  ? process_one_work+0x590/0x590
> > [   78.016735]  ? kthread_park+0x90/0x90
> > [   78.016740]  ret_from_fork+0x3a/0x50
> > 
> > Any clues?
> 
> Most likely
> 
> f6656208f04e ("x86/mce/therm_throt: Optimize notifications of thermal throttle")
> 
> I guess we're missing some X86_FEATURE_ check for that MSR to exist.

Thanks. FWIW, it's a i7-8650U.

Best,
	Dominik
