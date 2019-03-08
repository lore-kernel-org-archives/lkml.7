Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4768CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0BD20840
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfCHCKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:10:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:57664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726243AbfCHCK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:10:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 945DEAF2E;
        Fri,  8 Mar 2019 02:10:28 +0000 (UTC)
Subject: Re: [PATCH] bcache: Zero initialize bucket in bch_allocator_thread
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20190307221054.13126-1-natechancellor@gmail.com>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <94c7f399-7101-2297-43e0-834f50c3510f@suse.de>
Date:   Fri, 8 Mar 2019 10:10:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190307221054.13126-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/8 6:10 上午, Nathan Chancellor wrote:
> When building with -Wsometimes-uninitialized, Clang warns:
> 
> drivers/md/bcache/alloc.c:333:4: warning: variable 'bucket' is used
> uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
> 
> fifo_pop expands to a conditional depending on '!fifo_empty(...)', which
> is the same condition as the while loop. It seems Clang can't piece
> together that this condition will never been false as long as we are in
> the while loop because they are the same condition. It's easy enough to
> silence this warning by just explicitly zero initializing bucket.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/396
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Hi Nathan,

Nice catch, I will add it to my for-test. Thanks.

Coly Li

> ---
>  drivers/md/bcache/alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
> index 5002838ea476..c72094901ac6 100644
> --- a/drivers/md/bcache/alloc.c
> +++ b/drivers/md/bcache/alloc.c
> @@ -328,7 +328,7 @@ static int bch_allocator_thread(void *arg)
>  		 * the free list:
>  		 */
>  		while (!fifo_empty(&ca->free_inc)) {
> -			long bucket;
> +			long bucket = 0;
>  
>  			fifo_pop(&ca->free_inc, bucket);
>  
> 


-- 

Coly Li
