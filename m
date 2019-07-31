Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9241BC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A318206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfGaPur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:50:47 -0400
Received: from foss.arm.com ([217.140.110.172]:50476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfGaPur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:50:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCC8A1570;
        Wed, 31 Jul 2019 08:50:46 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB15D3F694;
        Wed, 31 Jul 2019 08:50:44 -0700 (PDT)
Date:   Wed, 31 Jul 2019 16:50:42 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        marc.zyngier@arm.com, james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com
Subject: Re: [RFC v2 8/8] arm64, kexec: enable MMU during kexec relocation
Message-ID: <20190731155042.GF39768@lakrids.cambridge.arm.com>
References: <20190731153857.4045-1-pasha.tatashin@soleen.com>
 <20190731153857.4045-9-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731153857.4045-9-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 11:38:57AM -0400, Pavel Tatashin wrote:
> +/*
> + * The following code is adoped from "Bare-metal Boot Code for ARMv8-A
> + * Processors Version 1.0, 5.3.1 Cleaning and invalidating the caches".
> + * http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dai0527a
> + */
> +.macro dcache_invalidate tmp0, tmp1, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, tmp8
> +	mov	\tmp0, #0x0			/* tmp0 = Cache level */
> +	msr	CSSELR_EL1, \tmp0		/* 0x0 for L1, 0x2 for L2 */
> +	mrs	\tmp4, CCSIDR_EL1		/* Read Cache Size ID */
> +	and	\tmp1, \tmp4, #0x7
> +	add	\tmp1, \tmp1, #0x4		/* tmp1 Cache Line Size */
> +	ldr	\tmp3, =0x7fff
> +	and	\tmp2, \tmp3, \tmp4, lsr #13	/* tmp2 Cache Set num - 1 */
> +	ldr	\tmp3, =0x3ff
> +	and	\tmp3, \tmp3, \tmp4, lsr #3	/* tmp3 Cache Assoc. num - 1 */
> +	clz	\tmp4, \tmp3			/* tmp4 way pos. in the CISW */
> +	mov	\tmp5, #0			/* tmp5 way counter way_loop */
> +1: /* way_loop */
> +	mov	\tmp6, #0			/* tmp6 set counter set_loop */
> +2: /* set_loop */
> +	lsl	\tmp7, \tmp5, \tmp4
> +	orr	\tmp7, \tmp0, \tmp7		/* Set way */
> +	lsl	\tmp8, \tmp6, \tmp1
> +	orr	\tmp7, \tmp7, \tmp8		/* Set set */
> +	dc	cisw, \tmp7			/* Clean & Inval. cache line */
> +	add	\tmp6, \tmp6, #1		/* Increment set counter */
> +	cmp	\tmp6, \tmp2			/* Last set reached yet? */
> +	ble	2b				/* If not, iterate set_loop, */
> +	add	\tmp5, \tmp5, #1		/* else, next way. */
> +	cmp	\tmp5, \tmp3			/* Last way reached yet? */
> +	ble	1b				/* If not, iterate way_loop. */
> +.endm
> +

For various reasons, one cannot safely use Set/Way operations in
portable code. They only make sense for low-level platform-specific
firmware performing power management operations.

If you need to perform D-cache maintenance, you must use the VA
operations to do so.

Thanks,
Mark.
