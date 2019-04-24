Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890F1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A4621773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfDXMYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:24:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42556 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729009AbfDXMYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:24:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85995A78;
        Wed, 24 Apr 2019 05:24:11 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A2F23F238;
        Wed, 24 Apr 2019 05:24:10 -0700 (PDT)
Date:   Wed, 24 Apr 2019 13:24:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Weikang shi <swkhack@gmail.com>
Cc:     keescook@chromium.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lkdtm: fix potential use after free
Message-ID: <20190424122407.GB24502@lakrids.cambridge.arm.com>
References: <20190424095952.10990-1-swkhack@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424095952.10990-1-swkhack@gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 24, 2019 at 05:59:52PM +0800, Weikang shi wrote:
> From: swkhack <swkhack@gmail.com>
> 
> The function lkdtm_READ_AFTER_FREE calls kfree(base) to free the memory
> of base. However, following kfree(base),
> it access the memory which base point to via base[offset]. This may result in a
> use-after-free bug. 

This is deliberate; the test is designed to provoke a use-after-free to
verify that this can be detected by tools such as KASAN.

> This patch moves kfree(base) after the dereference.

Doing this would break the test, so we should not make this change.

Was this something you spotted with a static analysis tool?

> Signed-off-by: swkhack <swkhack@gmail.com>

A signed-off-by line should have your real name rather than an alias.

Thanks,
Mark.

> ---
>  drivers/misc/lkdtm/heap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
> index 65026d7de..3e2f1580a 100644
> --- a/drivers/misc/lkdtm/heap.c
> +++ b/drivers/misc/lkdtm/heap.c
> @@ -77,7 +77,6 @@ void lkdtm_READ_AFTER_FREE(void)
>  	base[offset] = *val;
>  	pr_info("Value in memory before free: %x\n", base[offset]);
>  
> -	kfree(base);
>  
>  	pr_info("Attempting bad read from freed memory\n");
>  	saw = base[offset];
> @@ -88,6 +87,7 @@ void lkdtm_READ_AFTER_FREE(void)
>  	}
>  	pr_info("Memory was not poisoned\n");
>  
> +	kfree(base);
>  	kfree(val);
>  }
>  
> -- 
> 2.17.1
> 
