Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF769C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A009206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbfDAHjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:39:16 -0400
Received: from foss.arm.com ([217.140.101.70]:56676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731769AbfDAHjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:39:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C641B374;
        Mon,  1 Apr 2019 00:39:14 -0700 (PDT)
Received: from blommer (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1CDC3F690;
        Mon,  1 Apr 2019 00:39:12 -0700 (PDT)
Date:   Mon, 1 Apr 2019 08:39:02 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64/vdso: don't leak kernel addresses
Message-ID: <20190401073901.wun6lnthvbvq6gd4@blommer>
References: <20190330184638.16219-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330184638.16219-1-mcroce@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 07:46:38PM +0100, Matteo Croce wrote:
> Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
> two obfuscated kernel pointer are printed at every boot:
> 
>     vdso: 2 pages (1 code @ (____ptrval____), 1 data @ (____ptrval____))
> 
> Remove the addresses from the print, which turns into a more discrete:
> 
>     vdso: 2 pages (1 code, 1 data)
> 
> Fixes: ad67b74d2469d9b8 ("printk: hash addresses printed with %p")
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  arch/arm64/kernel/vdso.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 2d419006ad43..fdfee0ef5bc5 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -146,8 +146,8 @@ static int __init vdso_init(void)
>  	}
>  
>  	vdso_pages = (vdso_end - vdso_start) >> PAGE_SHIFT;
> -	pr_info("vdso: %ld pages (%ld code @ %p, %ld data @ %p)\n",
> -		vdso_pages + 1, vdso_pages, vdso_start, 1L, vdso_data);
> +	pr_info("vdso: %ld pages (%ld code, %ld data)\n",
> +		vdso_pages + 1, vdso_pages, 1L);

It's probably better to drop this pr_info() entirely. The number of data and
code pages hasn't changed since this was upstreamed, and the pointers were the
useful part for debugging.

If you respin this to delete the pr_info() entirely, then feel free to add:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
