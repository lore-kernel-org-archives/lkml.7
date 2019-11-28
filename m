Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC4DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 18:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D2321739
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 18:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfK1S5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 13:57:46 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:55266 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1S5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 13:57:45 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl-tcp.brodo.linta [10.1.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id BD6DB200A6E;
        Thu, 28 Nov 2019 18:57:43 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 91BC880238; Thu, 28 Nov 2019 19:56:07 +0100 (CET)
Date:   Thu, 28 Nov 2019 19:56:07 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: unchecked MSR access error in throttle_active_work()
Message-ID: <20191128185607.GA3726@owl.dominikbrodowski.net>
References: <20191128085447.GA3682@owl.dominikbrodowski.net>
 <20191128094419.GB17745@zn.tnic>
 <20191128102930.jgra6igtp4rppmis@isilmar-4.linta.de>
 <2859c017f515695eae1de47fdcf34db35bc5be39.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2859c017f515695eae1de47fdcf34db35bc5be39.camel@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 06:51:42AM -0800, Srinivas Pandruvada wrote:
> On Thu, 2019-11-28 at 11:29 +0100, Dominik Brodowski wrote:
> > On Thu, Nov 28, 2019 at 10:44:19AM +0100, Borislav Petkov wrote:
> > > On Thu, Nov 28, 2019 at 09:54:47AM +0100, Dominik Brodowski wrote:
> > > > On most recent mainline kernels (such as 5.5-rc0 up to
> > > > a6ed68d6468b), I see
> > > > the following output in dmesg during startup:
> > > > 
> > > > [   78.016676] unchecked MSR access error: WRMSR to 0x19c (tried
> > > > to write 0x00000000880f3a80) at rIP: 0xffffffff84ab5742
> > > > (throttle_active_work+0xf2/0x230)
> > > > [   78.016686] Call Trace:
> > > > [   78.016694]  process_one_work+0x247/0x590
> > > > [   78.016703]  worker_thread+0x50/0x3b0
> > > > [   78.016710]  kthread+0x10a/0x140
> > > > [   78.016715]  ? process_one_work+0x590/0x590
> > > > [   78.016735]  ? kthread_park+0x90/0x90
> > > > [   78.016740]  ret_from_fork+0x3a/0x50
> > > > 
> > > > Any clues?
> > > 
> > > Most likely
> > > 
> > > f6656208f04e ("x86/mce/therm_throt: Optimize notifications of
> > > thermal throttle")
> > > 
> > > I guess we're missing some X86_FEATURE_ check for that MSR to
> > > exist.
> > 
> > Thanks. FWIW, it's a i7-8650U.
> > 
> Please try the attached patch. 

Seems to work fine now. Thanks!

	Dominik
