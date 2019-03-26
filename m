Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3DFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EF92083D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbfCZBgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbfCZBgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:36:10 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C8BC2075D;
        Tue, 26 Mar 2019 01:36:09 +0000 (UTC)
Date:   Mon, 25 Mar 2019 21:36:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] ring-buffer: Fix ring buffer size in
 rb_write_something
Message-ID: <20190325213607.74a62138@oasis.local.home>
In-Reply-To: <1537704693-184237-1-git-send-email-yuehaibing@huawei.com>
References: <1537704693-184237-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Sep 2018 12:11:33 +0000
YueHaibing <yuehaibing@huawei.com> wrote:

> 'cnt' should be used to calculate ring buffer size rather than data->cnt

I just found this patch in my inbox (was traveling at the time. But now
I have patchwork attached to my INBOX so patches like these shouldn't
be missed anymore!)

Yes, you are correct, this should be fixed. But as it is just for a
startup test, I'll queue it for the next merge window.

Thanks and sorry for the delay.

-- Steve

> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  kernel/trace/ring_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 65bd461..53538c3 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -4924,7 +4924,7 @@ static __init int rb_write_something(struct
> rb_test_data *data, bool nested) cnt = data->cnt + (nested ? 27 : 0);
>  
>  	/* Multiply cnt by ~e, to make some unique increment */
> -	size = (data->cnt * 68 / 25) % (sizeof(rb_string) - 1);
> +	size = (cnt * 68 / 25) % (sizeof(rb_string) - 1);
>  
>  	len = size + sizeof(struct rb_item);
>  
> 
> 

