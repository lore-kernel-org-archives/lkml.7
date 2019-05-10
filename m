Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB89C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82FC2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfEJLE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:04:27 -0400
Received: from foss.arm.com ([217.140.101.70]:43640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbfEJLE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:04:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0585F374;
        Fri, 10 May 2019 04:04:27 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BDA23F738;
        Fri, 10 May 2019 04:04:26 -0700 (PDT)
Date:   Fri, 10 May 2019 12:04:18 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Salman Qazi <sqazi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: icache_is_aliasing and big.LITTLE
Message-ID: <20190510110418.GA51370@lakrids.cambridge.arm.com>
References: <CAKUOC8WxRnzeMEcS-vao-GOzXnF+FN+3uk8R6TspRj23V7kYJQ@mail.gmail.com>
 <20190509085004.GE64514@C02TF0J2HF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509085004.GE64514@C02TF0J2HF1T.local>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 09:50:04AM +0100, Catalin Marinas wrote:
> Hi,
> 
> On Wed, May 08, 2019 at 11:45:03AM -0700, Salman Qazi wrote:
> > What is the intention behind icache_is_aliasing on big.LITTLE systems
> > where some icaches are VIPT and others are PIPT? Is it meant to be
> > conservative in some sense or should it be made per-CPU?
> 
> It needs to cover the worst case scenario across all CPUs, i.e. aliasing
> VIPT if one of the CPUs has this. We can't make it per-CPU because a
> thread performing cache maintenance might be migrated to another CPU
> with different cache policy (e.g. sync_icache_aliases()).

It's slightly more subtle than that -- for broadcast maintenance the
policy of the CPU receiving the broadcast matters.

So even if all i-cache maintenance were performed on a thread pinned to
a CPU with PIPT caches, to correctly affect any VIPT i-caches in the
system it would be necessary to perform maintenance as-if the CPU
performing the maintenance had VIPT i-caches.

Thanks,
Mark.
