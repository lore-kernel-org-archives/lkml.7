Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDEBECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FF42084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570800889;
	bh=S0q1Ris4gOQMieXusBU2vx1H+aMfSdt6g9UnsV6flCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=px3NwrUmDbtONXmfJgK0s9sZTz/Wol6cwlM8nHk+k8ns+SfxjWqI/fgk80VhLbyQZ
	 hyI/AuMyXs0UfC/4KwAA3uEd5wGdii+uotqdbh+UHkkBn0G54QfgMYyTroSWgX//y2
	 mWDnuM+SyotsIxGAWc1bhGwguohM34k+vMNj10bY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfJKNer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:34:47 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:36144 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727709AbfJKNer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:34:47 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iIv48-00079K-Cw; Fri, 11 Oct 2019 15:34:44 +0200
Date:   Fri, 11 Oct 2019 14:34:42 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, rnayak@codeaurora.org,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org>,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        andrew.murray@arm.com, will@kernel.org, Dave.Martin@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Relax CPU features sanity checking on heterogeneous
 architectures
Message-ID: <20191011143442.515659f4@why>
In-Reply-To: <7910f428bd96834c15fb56262f3c10f8@codeaurora.org>
References: <b3606e76af42f7ecf65b1bfc2a5ed30a@codeaurora.org>
        <20191011105010.GA29364@lakrids.cambridge.arm.com>
        <7910f428bd96834c15fb56262f3c10f8@codeaurora.org>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: saiprakash.ranjan@codeaurora.org, mark.rutland@arm.com, rnayak@codeaurora.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, linux-arm-kernel-bounces@lists.infradead.org, linux-kernel@vger.kernel.org, jeremy.linton@arm.com, bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org, andrew.murray@arm.com, will@kernel.org, Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2019 18:47:39 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:

> Hi Mark,
> 
> Thanks a lot for the detailed explanations, I did have a look at all the variations before posting this.
> 
> On 2019-10-11 16:20, Mark Rutland wrote:
> > Hi,
> > 
> > On Fri, Oct 11, 2019 at 11:19:00AM +0530, Sai Prakash Ranjan wrote:  
> >> On latest QCOM SoCs like SM8150 and SC7180 with big.LITTLE arch, below
> >> warnings are observed during bootup of big cpu cores.  
> > 
> > For reference, which CPUs are in those SoCs?
> >   
> 
> SM8150 is based on Cortex-A55(little cores) and Cortex-A76(big cores). I'm afraid I cannot give details about SC7180 yet.
> 
> >> SM8150:  
> >> >> [    0.271177] CPU features: SANITY CHECK: Unexpected variation in  
> >> SYS_ID_AA64PFR0_EL1. Boot CPU: 0x00000011112222, CPU4: >> 0x00000011111112  
> > 
> > The differing fields are EL3, EL2, and EL1: the boot CPU supports
> > AArch64 and AArch32 at those exception levels, while the secondary only
> > supports AArch64.
> > 
> > Do we handle this variation in KVM?  
> 
> We do not support KVM.

Mainline does. You don't get to pick and choose what is supported or
not.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
