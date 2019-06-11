Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1843C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE392089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405374AbfFKKZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:25:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:52112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405196AbfFKKZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:25:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0928CADDD;
        Tue, 11 Jun 2019 10:25:30 +0000 (UTC)
Subject: Re: [PATCH 11/12] closures: closure_wait_event()
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <20190610191420.27007-12-kent.overstreet@gmail.com>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <3130eb62-e3b7-12d7-e724-7d549c68b6cf@suse.de>
Date:   Tue, 11 Jun 2019 18:25:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610191420.27007-12-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/11 3:14 上午, Kent Overstreet wrote:
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>

Acked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li

> ---
>  include/linux/closure.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/closure.h b/include/linux/closure.h
> index 308e38028c..abacb91c35 100644
> --- a/include/linux/closure.h
> +++ b/include/linux/closure.h
> @@ -379,4 +379,26 @@ static inline void closure_call(struct closure *cl, closure_fn fn,
>  	continue_at_nobarrier(cl, fn, wq);
>  }
>  
> +#define __closure_wait_event(waitlist, _cond)				\
> +do {									\
> +	struct closure cl;						\
> +									\
> +	closure_init_stack(&cl);					\
> +									\
> +	while (1) {							\
> +		closure_wait(waitlist, &cl);				\
> +		if (_cond)						\
> +			break;						\
> +		closure_sync(&cl);					\
> +	}								\
> +	closure_wake_up(waitlist);					\
> +	closure_sync(&cl);						\
> +} while (0)
> +
> +#define closure_wait_event(waitlist, _cond)				\
> +do {									\
> +	if (!(_cond))							\
> +		__closure_wait_event(waitlist, _cond);			\
> +} while (0)
> +
>  #endif /* _LINUX_CLOSURE_H */
> 


-- 

Coly Li
