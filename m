Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1EAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7187021773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfDXMY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:24:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42568 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbfDXMYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:24:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FCD7A78;
        Wed, 24 Apr 2019 05:24:55 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 659603F238;
        Wed, 24 Apr 2019 05:24:54 -0700 (PDT)
Date:   Wed, 24 Apr 2019 13:24:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Weikang shi <swkhack@gmail.com>
Cc:     keescook@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm: fix potential use after free
Message-ID: <20190424122451.GC24502@lakrids.cambridge.arm.com>
References: <20190424102103.11816-1-swkhack@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424102103.11816-1-swkhack@gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 06:21:03PM +0800, Weikang shi wrote:
> From: swkhack <swkhack@gmail.com>
> 
> The function lkdtm_WRITE_AFTER_FREE calls kfree(base) to free the memory
> of base. However, following kfree(base),
> it write the memory which base point to via base[offset] = 0x0abcdef0. This may result in a
> use-after-free bug. This patch moves kfree(base) after the write.

As with lkdtm_READ_AFTER_FREE, this is deliberate, and we should not
make this change.

Thanks,
Mark.

> 
> Signed-off-by: swkhack <swkhack@gmail.com>
> ---
>  drivers/misc/lkdtm/heap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
> index 65026d7de..0b9141525 100644
> --- a/drivers/misc/lkdtm/heap.c
> +++ b/drivers/misc/lkdtm/heap.c
> @@ -40,8 +40,8 @@ void lkdtm_WRITE_AFTER_FREE(void)
>  	pr_info("Allocated memory %p-%p\n", base, &base[offset * 2]);
>  	pr_info("Attempting bad write to freed memory at %p\n",
>  		&base[offset]);
> -	kfree(base);
>  	base[offset] = 0x0abcdef0;
> +	kfree(base);
>  	/* Attempt to notice the overwrite. */
>  	again = kmalloc(len, GFP_KERNEL);
>  	kfree(again);
> -- 
> 2.17.1
> 
