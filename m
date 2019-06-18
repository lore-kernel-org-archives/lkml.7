Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14D4C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA62206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfFRJwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:52:43 -0400
Received: from foss.arm.com ([217.140.110.172]:60470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRJwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:52:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D116D344;
        Tue, 18 Jun 2019 02:52:42 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 211323F246;
        Tue, 18 Jun 2019 02:54:27 -0700 (PDT)
Date:   Tue, 18 Jun 2019 10:52:40 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource/arm_arch_timer: fix
 arch_timer_set_evtstrm_feature return type
Message-ID: <20190618095240.GP20984@e119886-lin.cambridge.arm.com>
References: <20190618094835.3709679-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618094835.3709679-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 11:48:27AM +0200, Arnd Bergmann wrote:
> This looks like it was copied incorrectly from arm64:

Hi Arnd,

Yes that's correct. I sent a patch for this yesterday [1], I believe Daniel
plans to take this through his tree.

[1] https://lkml.org/lkml/2019/6/17/229

Thanks,

Andrew Murray

> 
> In file included from /git/arm-soc/drivers/clocksource/arm_arch_timer.c:31:
> arch/arm/include/asm/arch_timer.h:131:1: error: control reaches end of non-void function [-Werror,-Wreturn-type]
> 
> Change the type to 'void' as it should be.
> 
> Fixes: 11e34eca5d0a ("clocksource/arm_arch_timer: Extract elf_hwcap use to arch-helper")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/include/asm/arch_timer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> index ae533caec1e9..99175812d903 100644
> --- a/arch/arm/include/asm/arch_timer.h
> +++ b/arch/arm/include/asm/arch_timer.h
> @@ -125,7 +125,7 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
>  	isb();
>  }
>  
> -static inline bool arch_timer_set_evtstrm_feature(void)
> +static inline void arch_timer_set_evtstrm_feature(void)
>  {
>  	elf_hwcap |= HWCAP_EVTSTRM;
>  }
> -- 
> 2.20.0
> 
