Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40398C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBD22064B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfGAOvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:51:09 -0400
Received: from foss.arm.com ([217.140.110.172]:36418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbfGAOvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:51:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D8A4344;
        Mon,  1 Jul 2019 07:51:08 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B3D73F246;
        Mon,  1 Jul 2019 07:51:06 -0700 (PDT)
Date:   Mon, 1 Jul 2019 15:51:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, peterz@infradead.org, will.deacon@arm.com,
        julien.thierry@arm.com
Subject: Re: [RFC V3 11/18] arm64: alternative: Mark .altinstr_replacement as
 containing executable instructions
Message-ID: <20190701145104.GE21774@arrakis.emea.arm.com>
References: <20190624095548.8578-1-raphael.gault@arm.com>
 <20190624095548.8578-12-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624095548.8578-12-raphael.gault@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:55:41AM +0100, Raphael Gault wrote:
> Until now, the section .altinstr_replacement wasn't marked as containing
> executable instructions on arm64. This patch changes that so that it is
> coherent with what is done on x86.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> ---
>  arch/arm64/include/asm/alternative.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
> index b9f8d787eea9..e9e6b81e3eb4 100644
> --- a/arch/arm64/include/asm/alternative.h
> +++ b/arch/arm64/include/asm/alternative.h
> @@ -71,7 +71,7 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
>  	ALTINSTR_ENTRY(feature,cb)					\
>  	".popsection\n"							\
>  	" .if " __stringify(cb) " == 0\n"				\
> -	".pushsection .altinstr_replacement, \"a\"\n"			\
> +	".pushsection .altinstr_replacement, \"ax\"\n"			\
>  	"663:\n\t"							\
>  	newinstr "\n"							\
>  	"664:\n\t"							\

I guess that's an inconsistency we missed since the asm macro has "ax".

-- 
Catalin
