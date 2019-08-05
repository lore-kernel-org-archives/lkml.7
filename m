Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6760BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371662147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565024591;
	bh=B48eiohTRXUqp1vgix0BJUhceLmylIAqW3xSQiyok/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nJHEPLjnKEgflzpKUbvEZuT3YHu2CqC31CRa9Vgm2zmmsD9QBllMowp6Qv2nizXrr
	 K60awgUEfubT4N3J5LeD4Sk92+BWtZ4LrwoRe07ERx/3nnwhN/AOx99r5iwmBiKnk4
	 zwb5K28FH7Z/cQJBFV5qwiNN46OcrcUPD9uiTmQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfHERDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbfHERDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:03:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D2C82075B;
        Mon,  5 Aug 2019 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565024588;
        bh=B48eiohTRXUqp1vgix0BJUhceLmylIAqW3xSQiyok/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eIg8/ZChC1P4N9v5Ec4ea93COQQM0oQwMI7vQmKok2rouMgnU6TnmPZDvv+dGcQQ1
         qW+9jFVq7n1X1TVgFXKb1vjKFDo/cKLupz+8RAvmblBKj9BYI5TJDS6X+vsHq/knO0
         w5B1vYoyCDGelHVVgZZPaoOBSh+vOInggeXmQM/4=
Date:   Mon, 5 Aug 2019 18:03:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, rrichter@cavium.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/prefetch: fix a -Wtype-limits warning
Message-ID: <20190805170303.brqcusgmtx6j3el3@willie-the-truck>
References: <20190803003358.992-1-cai@lca.pw>
 <20190805100059.4gml6c4kclz2iin3@willie-the-truck>
 <BDD11CC0-DC23-4D3A-B9EB-9A985EC53A30@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BDD11CC0-DC23-4D3A-B9EB-9A985EC53A30@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 08:03:10AM -0400, Qian Cai wrote:
> 
> 
> > On Aug 5, 2019, at 6:00 AM, Will Deacon <will@kernel.org> wrote:
> > 
> > On Fri, Aug 02, 2019 at 08:33:58PM -0400, Qian Cai wrote:
> >> The commit d5370f754875 ("arm64: prefetch: add alternative pattern for
> >> CPUs without a prefetcher") introduced MIDR_IS_CPU_MODEL_RANGE() to be
> >> used in has_no_hw_prefetch() with rv_min=0 which generates a compilation
> >> warning from GCC,
> >> 
> >> In file included from ./arch/arm64/include/asm/cache.h:8,
> >>                from ./include/linux/cache.h:6,
> >>                from ./include/linux/printk.h:9,
> >>                from ./include/linux/kernel.h:15,
> >>                from ./include/linux/cpumask.h:10,
> >>                from arch/arm64/kernel/cpufeature.c:11:
> >> arch/arm64/kernel/cpufeature.c: In function 'has_no_hw_prefetch':
> >> ./arch/arm64/include/asm/cputype.h:59:26: warning: comparison of
> >> unsigned expression >= 0 is always true [-Wtype-limits]
> >> _model == (model) && rv >= (rv_min) && rv <= (rv_max);  \
> >>                         ^~
> >> arch/arm64/kernel/cpufeature.c:889:9: note: in expansion of macro
> >> 'MIDR_IS_CPU_MODEL_RANGE'
> >> return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX,
> >>        ^~~~~~~~~~~~~~~~~~~~~~~
> >> 
> >> Fix it by making "rv" a "s32".
> >> 
> >> Signed-off-by: Qian Cai <cai@lca.pw>
> >> ---
> >> 
> >> v2: Use "s32" for "rv", so "variant 0/revision 0" can be covered.
> >> 
> >> arch/arm64/include/asm/cputype.h | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> >> index e7d46631cc42..d52fe8651c2d 100644
> >> --- a/arch/arm64/include/asm/cputype.h
> >> +++ b/arch/arm64/include/asm/cputype.h
> >> @@ -54,7 +54,7 @@
> >> #define MIDR_IS_CPU_MODEL_RANGE(midr, model, rv_min, rv_max)		\
> >> ({									\
> >> 	u32 _model = (midr) & MIDR_CPU_MODEL_MASK;			\
> >> -	u32 rv = (midr) & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK);	\
> >> +	s32 rv = (midr) & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK);	\
> > 
> > Hmm, but this really isn't a signed quantity: it's two fields extracted
> > from an ID register. I think the code is fine. Are you explicitly enabling
> > -Wtype-limits somehow?
> 
> Yes, it is useful to catch unintended developer mistakes or simply optimize wasted instructions of
> checking like in,
> 
> 919aef44d73d (“x86/efi: fix a -Wtype-limits compilation warning”)
> 
> 5a82bdb48f04 (“x86/cacheinfo: Fix a -Wtype-limits warning”)
> 
> It is normal to fix a false positive this way as in other mainline commits,
> 
> ec6335586953 (“x86/apic: Silence -Wtype-limits compiler warnings”)
> 
> Once those false-positives are under control, the warning flag could be then enabled by default in
> the future.

If there's a way to fix the code without making it more confusing, sure,
but your proposal of making the field signed does not achieve that goal.

Will
