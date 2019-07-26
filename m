Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A25C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD4522BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564144056;
	bh=OZObsaiWD9C6Z4j0R2E6zW92OcmQ4NJIcSACVpKktp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1lkTinS0iNd8K9ESMOhuZ5rh6i9VycKg1qnChNp6pLr1O87b0D7KL3Biw9FV6+IM/
	 DiB3DuzGWQs2i9NtShbafAEsf7WOJu/95cre+J0ZCJ0s+pxMdnMA173kdoNjvaT4hP
	 HAyxqzY8kwE19qwVOrqlMRE+dAe7evZ7uMNcz50Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfGZM1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfGZM1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:27:34 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82A4D22ADA;
        Fri, 26 Jul 2019 12:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564144054;
        bh=OZObsaiWD9C6Z4j0R2E6zW92OcmQ4NJIcSACVpKktp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XI94dtPGA09qzd+pPmSHGSws7MyNVI5CHU+LlA3L/oabxDaPBS25r/b8kvkbzzsWR
         /tS3yisVZV+qWyrvZ1rmXxYU+Z9oXdzXzsFQ4pZxGyFPOB8BqdW/TLE0yAiHOs/+lF
         kOjaQ6gZpQr9EJcTdi9mn8n8+55oCIJ/90x1cw9o=
Date:   Fri, 26 Jul 2019 13:27:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/3] arm64: perf: Mark expected switch fall-through
Message-ID: <20190726122728.jhn4e6wq7rcowyi4@willie-the-truck>
References: <20190726112716.19104-1-anders.roxell@linaro.org>
 <20190726121056.GA26088@lakrids.cambridge.arm.com>
 <20190726121354.GB26088@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190726121354.GB26088@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 01:13:54PM +0100, Mark Rutland wrote:
> On Fri, Jul 26, 2019 at 01:10:57PM +0100, Mark Rutland wrote:
> > On Fri, Jul 26, 2019 at 01:27:16PM +0200, Anders Roxell wrote:
> > > When fall-through warnings was enabled by default, commit d93512ef0f0e
> > > ("Makefile: Globally enable fall-through warning"), the following
> > > warnings was starting to show up:
> > > 
> > > ../arch/arm64/kernel/hw_breakpoint.c: In function ‘hw_breakpoint_arch_parse’:
> > > ../arch/arm64/kernel/hw_breakpoint.c:540:7: warning: this statement may fall
> > >  through [-Wimplicit-fallthrough=]
> > >     if (hw->ctrl.len == ARM_BREAKPOINT_LEN_1)
> > >        ^
> > > ../arch/arm64/kernel/hw_breakpoint.c:542:3: note: here
> > >    case 2:
> > >    ^~~~
> > > ../arch/arm64/kernel/hw_breakpoint.c:544:7: warning: this statement may fall
> > >  through [-Wimplicit-fallthrough=]
> > >     if (hw->ctrl.len == ARM_BREAKPOINT_LEN_2)
> > >        ^
> > > ../arch/arm64/kernel/hw_breakpoint.c:546:3: note: here
> > >    default:
> > >    ^~~~~~~
> > > 
> > > Rework so that the compiler doesn't warn about fall-through. Rework so
> > > the code looks like the arm code. Since the comment in the function
> > > indicates taht this is supposed to behave the same way as arm32 because
> > 
> > Typo: s/taht/that/
> > 
> > > it handles 32-bit tasks also.
> > > 
> > > Cc: stable@vger.kernel.org # v3.16+
> > > Fixes: 6ee33c2712fc ("ARM: hw_breakpoint: correct and simplify alignment fixup code")
> > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > 
> > The patch itself looks fine, but I don't think this needs a CC to
> > stable, nor does it require that fixes tag, as there's no functional
> > problem.
> 
> Hmm... I now see I spoke too soon, and this is making the 1-byte
> breakpoint work at a 3-byte offset.

I still don't think it's quite right though, since it forbids a 2-byte
watchpoint on a byte-aligned address.

I think the arm64 code matches what we had on 32-bit prior to
d968d2b801d8 ("ARM: 7497/1: hw_breakpoint: allow single-byte watchpoints
on all addresses"), so we should have one patch bringing us up to speed
with that change, and then another annotating the fallthroughs.

Will
