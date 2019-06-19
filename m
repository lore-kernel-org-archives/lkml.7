Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4FBC31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421D921530
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbfFSMSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:18:52 -0400
Received: from foss.arm.com ([217.140.110.172]:36714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfFSMSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:18:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC31EC0A;
        Wed, 19 Jun 2019 05:18:51 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1AF53F738;
        Wed, 19 Jun 2019 05:18:50 -0700 (PDT)
Date:   Wed, 19 Jun 2019 13:18:48 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     jinho lim <jordan.lim@samsung.com>
Cc:     mark.rutland@arm.com, ebiederm@xmission.com, marc.zyngier@arm.com,
        anshuman.khandual@arm.com, andreyknvl@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        seroto7@gmail.com
Subject: Re: [PATCH] arm64: remove useless condition
Message-ID: <20190619121848.GE7767@fuggles.cambridge.arm.com>
References: <CGME20190619113904epcas1p23e2c335cda62dfa5ea02c4eb5cb0d788@epcas1p2.samsung.com>
 <20190619113857.5053-1-jordan.lim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619113857.5053-1-jordan.lim@samsung.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 08:38:57PM +0900, jinho lim wrote:
> dump_instr function checks user_mode internally.
> 
> Signed-off-by: jinho lim <jordan.lim@samsung.com>
> ---
>  arch/arm64/kernel/traps.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index ccc13b45d9b1..694e78b950ca 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -182,8 +182,7 @@ static int __die(const char *str, int err, struct pt_regs *regs)
>  	print_modules();
>  	show_regs(regs);
>  
> -	if (!user_mode(regs))
> -		dump_instr(KERN_EMERG, regs);
> +	dump_instr(KERN_EMERG, regs);

I don't think this is right, because it means we'll now dump the current
user instruction on the die() path.

Instead, we should probably rename dump_instr to dump_kernel_instr(),
and have it return immediately if user_mode(regs). We can also kill
__dump_instr completely.

Will
