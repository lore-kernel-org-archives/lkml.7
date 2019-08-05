Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CD1C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289E4214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565013752;
	bh=jjNyHTb7y2OQFlMNJASooyvqSUfY24hc6hv9fvauXAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ut4bnhG5X/OOT9vn+DN06v2+TG69cgZB1E2yidyR5DK2PhVD7lwYAjyBTZPmmA9BD
	 NCpmuYAlvC2+BV9g0vbAc0iw3Vo5xUvlcXZ4RJBM/FnQ5K9+CuqkAwHAA6D0yY9aYQ
	 ajDTf+GH7rpDNO/hxxl7fISrwzYd4RBAfYzGTGME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfHEOCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfHEOBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:01:25 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5C2B214C6;
        Mon,  5 Aug 2019 14:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565013683;
        bh=jjNyHTb7y2OQFlMNJASooyvqSUfY24hc6hv9fvauXAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yZEAcRQk5+MQbNA8Iv+LnnLWLy3Ow0Bj9Xm45B2LMoDpvdrsNB1JAMRtAdgHpUUOM
         TastMn6ZW6vaKBxTpUvQzXEF72Gnghhsvy5EmnwLOCJtgdYRRMnAM5jrc9cePl9cq4
         /ZvswzjpGAJhhKQ2fvc3R0xtmDK4HFvL2Zl6OpQc=
Date:   Mon, 5 Aug 2019 15:01:19 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cache: fix -Woverride-init compiler warnings
Message-ID: <20190805140118.fys437oor2b2rnq5@willie-the-truck>
References: <1564759944-2197-1-git-send-email-cai@lca.pw>
 <20190805095256.ocgdb2yfhnbdz6kw@willie-the-truck>
 <771C4B4C-6D79-419D-9778-5DE1BFC67FBE@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <771C4B4C-6D79-419D-9778-5DE1BFC67FBE@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 07:47:37AM -0400, Qian Cai wrote:
> 
> 
> > On Aug 5, 2019, at 5:52 AM, Will Deacon <will@kernel.org> wrote:
> > 
> > On Fri, Aug 02, 2019 at 11:32:24AM -0400, Qian Cai wrote:
> >> The commit 155433cb365e ("arm64: cache: Remove support for ASID-tagged
> >> VIVT I-caches") introduced some compiation warnings from GCC,
> >> 
> >> arch/arm64/kernel/cpuinfo.c:38:26: warning: initialized field
> >> overwritten [-Woverride-init]
> >>  [ICACHE_POLICY_VIPT]  = "VIPT",
> >>                          ^~~~~~
> >> arch/arm64/kernel/cpuinfo.c:38:26: note: (near initialization for
> >> 'icache_policy_str[2]')
> >> arch/arm64/kernel/cpuinfo.c:39:26: warning: initialized field
> >> overwritten [-Woverride-init]
> >>  [ICACHE_POLICY_PIPT]  = "PIPT",
> >>                          ^~~~~~
> >> arch/arm64/kernel/cpuinfo.c:39:26: note: (near initialization for
> >> 'icache_policy_str[3]')
> >> arch/arm64/kernel/cpuinfo.c:40:27: warning: initialized field
> >> overwritten [-Woverride-init]
> >>  [ICACHE_POLICY_VPIPT]  = "VPIPT",
> >>                           ^~~~~~~
> >> arch/arm64/kernel/cpuinfo.c:40:27: note: (near initialization for
> >> 'icache_policy_str[0]')
> >> 
> >> because it initializes icache_policy_str[0 ... 3] twice.
> >> 
> >> Fixes: 155433cb365e ("arm64: cache: Remove support for ASID-tagged VIVT I-caches")
> >> Signed-off-by: Qian Cai <cai@lca.pw>
> >> ---
> >> arch/arm64/kernel/cpuinfo.c | 4 ++--
> >> 1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> >> index 876055e37352..193b38da8d96 100644
> >> --- a/arch/arm64/kernel/cpuinfo.c
> >> +++ b/arch/arm64/kernel/cpuinfo.c
> >> @@ -34,10 +34,10 @@
> >> static struct cpuinfo_arm64 boot_cpu_data;
> >> 
> >> static char *icache_policy_str[] = {
> >> -	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN",
> >> +	[ICACHE_POLICY_VPIPT]		= "VPIPT",
> >> +	[ICACHE_POLICY_VPIPT + 1]	= "RESERVED/UNKNOWN",
> >> 	[ICACHE_POLICY_VIPT]		= "VIPT",
> >> 	[ICACHE_POLICY_PIPT]		= "PIPT",
> >> -	[ICACHE_POLICY_VPIPT]		= "VPIPT",
> > 
> > I really don't like this patch. Using "[0 ... MAXIDX] = <default>" is a
> > useful idiom and I think the code is more error-prone the way you have
> > restructured it.
> > 
> > Why are you passing -Woverride-init to the compiler anyway? There's only
> > one Makefile that references that option, and it's specific to a pinctrl
> > driver.
> 
> Those extra warnings can be enabled by “make W=1”. “-Woverride-init “ seems to be useful
> to catch potential developer mistakes with unintented double-initializations. It is normal to
> start to fix the most of false-positives first before globally enabling the flag by default just like
> “-Wimplicit-fallthrough” mentioned in,
> 
> https://lwn.net/Articles/794944/

I think this case is completely different to the implicit fallthrough stuff.
The solution there was simply to add a comment without restructuring the
surrounding code. What your patch does here is actively make the code harder
to understand.

Initialising a static array with a non-zero pattern is a useful idiom and I
don't think we should throw that away just to appease a silly compiler
warning that appears only with non-default build options. Have a look at
the way we use PERF_MAP_ALL_UNSUPPORTED in the Arm PMU code, for example.

Will
