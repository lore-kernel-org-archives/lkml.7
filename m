Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F34FC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 18:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D08520818
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 18:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKJSOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 13:14:09 -0500
Received: from smtprelay0069.hostedemail.com ([216.40.44.69]:34071 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726684AbfKJSOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 13:14:08 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 088A3181D3417;
        Sun, 10 Nov 2019 18:14:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hope08_5dfd750254439
X-Filterd-Recvd-Size: 2710
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sun, 10 Nov 2019 18:14:05 +0000 (UTC)
Message-ID: <61e165241e4b98cd655ac79cd110f3f08e389838.camel@perches.com>
Subject: Re: [PATCH] lkdtm: Remove set but not used variable 'byte'
From:   Joe Perches <joe@perches.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, keescook@chromium.org,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Date:   Sun, 10 Nov 2019 10:13:50 -0800
In-Reply-To: <20191110092249.182210-1-zhengyongjun3@huawei.com>
References: <20191110092249.182210-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-11-10 at 17:22 +0800, Zheng Yongjun wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/misc/lkdtm/bugs.c: In function lkdtm_STACK_GUARD_PAGE_LEADING:
> drivers/misc/lkdtm/bugs.c:236:25: warning: variable byte set but not used [-Wunused-but-set-variable]
> drivers/misc/lkdtm/bugs.c: In function lkdtm_STACK_GUARD_PAGE_TRAILING:
> drivers/misc/lkdtm/bugs.c:250:25: warning: variable byte set but not used [-Wunused-but-set-variable]
> 
> byte is never used, so remove it.

I believe "hulk robot" needs to be updated instead.

It seems a generically bad idea to elide as byte
is in fact used because it's volatile and the
compiler was forced to perform the access of *ptr.


> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/misc/lkdtm/bugs.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 7284a22b1a09..fcd943725b66 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -249,12 +249,9 @@ void lkdtm_STACK_GUARD_PAGE_LEADING(void)
>  {
>  	const unsigned char *stack = task_stack_page(current);
>  	const unsigned char *ptr = stack - 1;
> -	volatile unsigned char byte;
>  
>  	pr_info("attempting bad read from page below current stack\n");
>  
> -	byte = *ptr;
> -
>  	pr_err("FAIL: accessed page before stack!\n");
>  }
>  
> @@ -263,12 +260,9 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
>  {
>  	const unsigned char *stack = task_stack_page(current);
>  	const unsigned char *ptr = stack + THREAD_SIZE;
> -	volatile unsigned char byte;
>  
>  	pr_info("attempting bad read from page above current stack\n");
>  
> -	byte = *ptr;
> -
>  	pr_err("FAIL: accessed page after stack!\n");
>  }
>  

