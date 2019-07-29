Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2F0C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B405120578
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564393883;
	bh=b5MXa1GsRvDSUonZppqvxM6/Xf9ixG4a4Z6IEG+81jM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=gWvJSADQpZybSFLEgBbJ0AoJHFnSDSM0QC9EVFKvplSCoDX1TJHmofC94TKdcyLGo
	 2kymqfjyRqqEqnwHw1lm3X62B70IxBJ/sg0xefA7eAHek3TLFv5vxjopo57UE3qpal
	 79CK+Dvf9I63VTSNjYqqtzaIUWfQJ7cALxTwfqE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfG2JvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:51:22 -0400
Received: from foss.arm.com ([217.140.110.172]:40974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfG2JvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:51:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B4DE1570;
        Mon, 29 Jul 2019 02:51:21 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 988DF3F694;
        Mon, 29 Jul 2019 02:51:20 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm64: mark expected switch fall-through in HYP
To:     Matteo Croce <mcroce@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <20190728231949.6874-1-mcroce@redhat.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <181597ab-f38c-73f1-4404-5bbddc451f85@kernel.org>
Date:   Mon, 29 Jul 2019 10:51:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190728231949.6874-1-mcroce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2019 00:19, Matteo Croce wrote:
> Mark switch cases where we are expecting to fall through,
> fixes a 130+ lines warning.
> 
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  arch/arm64/kvm/hyp/debug-sr.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/debug-sr.c b/arch/arm64/kvm/hyp/debug-sr.c
> index 26781da3ad3e..c648c243f98b 100644
> --- a/arch/arm64/kvm/hyp/debug-sr.c
> +++ b/arch/arm64/kvm/hyp/debug-sr.c
> @@ -18,40 +18,70 @@
>  #define save_debug(ptr,reg,nr)						\
>  	switch (nr) {							\
>  	case 15:	ptr[15] = read_debug(reg, 15);			\
> +			/* fallthrough */				\
>  	case 14:	ptr[14] = read_debug(reg, 14);			\
> +			/* fallthrough */				\
>  	case 13:	ptr[13] = read_debug(reg, 13);			\
> +			/* fallthrough */				\
>  	case 12:	ptr[12] = read_debug(reg, 12);			\
> +			/* fallthrough */				\
>  	case 11:	ptr[11] = read_debug(reg, 11);			\
> +			/* fallthrough */				\
>  	case 10:	ptr[10] = read_debug(reg, 10);			\
> +			/* fallthrough */				\
>  	case 9:		ptr[9] = read_debug(reg, 9);			\
> +			/* fallthrough */				\
>  	case 8:		ptr[8] = read_debug(reg, 8);			\
> +			/* fallthrough */				\
>  	case 7:		ptr[7] = read_debug(reg, 7);			\
> +			/* fallthrough */				\
>  	case 6:		ptr[6] = read_debug(reg, 6);			\
> +			/* fallthrough */				\
>  	case 5:		ptr[5] = read_debug(reg, 5);			\
> +			/* fallthrough */				\
>  	case 4:		ptr[4] = read_debug(reg, 4);			\
> +			/* fallthrough */				\
>  	case 3:		ptr[3] = read_debug(reg, 3);			\
> +			/* fallthrough */				\
>  	case 2:		ptr[2] = read_debug(reg, 2);			\
> +			/* fallthrough */				\
>  	case 1:		ptr[1] = read_debug(reg, 1);			\
> +			/* fallthrough */				\
>  	default:	ptr[0] = read_debug(reg, 0);			\
>  	}
>  
>  #define restore_debug(ptr,reg,nr)					\
>  	switch (nr) {							\
>  	case 15:	write_debug(ptr[15], reg, 15);			\
> +			/* fallthrough */				\
>  	case 14:	write_debug(ptr[14], reg, 14);			\
> +			/* fallthrough */				\
>  	case 13:	write_debug(ptr[13], reg, 13);			\
> +			/* fallthrough */				\
>  	case 12:	write_debug(ptr[12], reg, 12);			\
> +			/* fallthrough */				\
>  	case 11:	write_debug(ptr[11], reg, 11);			\
> +			/* fallthrough */				\
>  	case 10:	write_debug(ptr[10], reg, 10);			\
> +			/* fallthrough */				\
>  	case 9:		write_debug(ptr[9], reg, 9);			\
> +			/* fallthrough */				\
>  	case 8:		write_debug(ptr[8], reg, 8);			\
> +			/* fallthrough */				\
>  	case 7:		write_debug(ptr[7], reg, 7);			\
> +			/* fallthrough */				\
>  	case 6:		write_debug(ptr[6], reg, 6);			\
> +			/* fallthrough */				\
>  	case 5:		write_debug(ptr[5], reg, 5);			\
> +			/* fallthrough */				\
>  	case 4:		write_debug(ptr[4], reg, 4);			\
> +			/* fallthrough */				\
>  	case 3:		write_debug(ptr[3], reg, 3);			\
> +			/* fallthrough */				\
>  	case 2:		write_debug(ptr[2], reg, 2);			\
> +			/* fallthrough */				\
>  	case 1:		write_debug(ptr[1], reg, 1);			\
> +			/* fallthrough */				\
>  	default:	write_debug(ptr[0], reg, 0);			\
>  	}
>  
> 

Already reported here[1].

Thanks,

	M.

[1] https://www.spinics.net/lists/arm-kernel/msg743592.html
-- 
Jazz is not dead, it just smells funny...
