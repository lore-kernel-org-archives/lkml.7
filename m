Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F0DC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0F32173E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565341460;
	bh=XB27LRpAnKdCPjK7IA3bv7hINGwvghKW9x+bkK/uxu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hpWPBayvfFXWfvlrruyTMIT5Hd5IMjrIXJSDY/e2Tlw2CN209O+gU8wybu/Vr7WOA
	 1l7UONuxqI9FI1uRx0B1wS532s2SmOV1BMi0qrPhe5BSN297eevWwmrmT8yJaPJAUA
	 PIi0KaxXZu10u3ZgwcyL02YF1cOkGwayrurru8zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406049AbfHIJET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406007AbfHIJES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:04:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CC4B20B7C;
        Fri,  9 Aug 2019 09:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565341458;
        bh=XB27LRpAnKdCPjK7IA3bv7hINGwvghKW9x+bkK/uxu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nevi0XM+6LrRhhb/2dv4E7szy+r+o33LwwpfBaGazqXklqWzb45GRcfqLn32fp2D9
         W4J1GchixTk+gZ7v0qqmMiIP71rkTOEXWN6dCqp99SPN8VEW45qSAV2/XsQUOdYKKx
         PfBQHjb0CsxYTY6UapbnMjFSAL+Yn2pXyrIJ9Reg=
Date:   Fri, 9 Aug 2019 10:04:13 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64/cache: silence -Woverride-init warnings
Message-ID: <20190809090413.c57d7qlqgihdyzt6@willie-the-truck>
References: <20190808032916.879-1-cai@lca.pw>
 <20190808103808.GC46901@lakrids.cambridge.arm.com>
 <D2A2F2B9-0563-4DF6-8E77-F191A768CE4E@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D2A2F2B9-0563-4DF6-8E77-F191A768CE4E@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 06:18:39PM -0400, Qian Cai wrote:
> > On Aug 8, 2019, at 6:38 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Please just turn this off by default for clang.
> 
> As mentioned before, it is very valuable to run “make W=1” given it found
> many real developer mistakes which will enable “-Woverride-init” for both
> compilers. Even “-Woverride-init” itself is useful find real issues as in,

Every single patch you've sent to me resulting from building with "W=1" has
been a false positive. Every. Single. One. That's not what I would call
"very valuable". It's probably what I'd call a "colossal waste of
everybody's time", especially as your tendancy to shoot from the hip when
writing these so-called fixes has resulted in some patches that ACTUALLY
INTRODUCED REAL BUGS. Do you see the insanity here?

> ae5e033d65a (“mfd: rk808: Fix RK818_IRQ_DISCHG_ILIM initializer”)
> 32df34d875bb (“[media] rc: img-ir: jvc: Remove unused no-leader timings”)
> 
> Especially, to find redundant initializations in large structures. e.g.,
> 
> e6ea0b917875 (“[media] dvb_frontend: Don't declare values twice at a table”)
> 
> It is important to keep the noise-level as low as possible by keeping the
> amount of false positives under control to be truly benefit from those
> valuable compiler warnings. 

So that's where you and I have a disagreement. I think maintainability
of the code is the single most important thing to consider after
correctness.

If code isn't maintainable, then it's liable to churn and be a constant
source of bugs as people keep tripping over whatever subtleties lie within.
In some cases, we have little choice and the combination of things like
performance requirements and compatibility force us down a path which we
wouldn't otherwise have considered. However, appeasing a compiler warning
that *doesn't even appear with the default build options* does not quality
for this sort of treatment in my opinion, so I will not be applying your
patch.

Please stop sending it. Real fixes, sure, but not this rubbish.

Will
