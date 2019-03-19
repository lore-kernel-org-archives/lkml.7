Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E634DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA3E2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfCSL5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:57:52 -0400
Received: from foss.arm.com ([217.140.101.70]:50178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbfCSL5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:57:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1E1D1596;
        Tue, 19 Mar 2019 04:57:51 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00CD03F614;
        Tue, 19 Mar 2019 04:57:49 -0700 (PDT)
Date:   Tue, 19 Mar 2019 11:57:47 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] kmemleak: skip scanning holes in the .bss section
Message-ID: <20190319115747.GB59586@arrakis.emea.arm.com>
References: <20190313145717.46369-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313145717.46369-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On Wed, Mar 13, 2019 at 10:57:17AM -0400, Qian Cai wrote:
> @@ -1531,7 +1547,14 @@ static void kmemleak_scan(void)
>  
>  	/* data/bss scanning */
>  	scan_large_block(_sdata, _edata);
> -	scan_large_block(__bss_start, __bss_stop);
> +
> +	if (bss_hole_start) {
> +		scan_large_block(__bss_start, bss_hole_start);
> +		scan_large_block(bss_hole_stop, __bss_stop);
> +	} else {
> +		scan_large_block(__bss_start, __bss_stop);
> +	}
> +
>  	scan_large_block(__start_ro_after_init, __end_ro_after_init);

I'm not a fan of this approach but I couldn't come up with anything
better. I was hoping we could check for PageReserved() in scan_block()
but on arm64 it ends up not scanning the .bss at all.

Until another user appears, I'm ok with this patch.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
