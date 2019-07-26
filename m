Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CC1C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194D3229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 12:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfGZMJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 08:09:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49028 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGZMJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:09:54 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqz2l-0001Ny-AA; Fri, 26 Jul 2019 14:09:51 +0200
Date:   Fri, 26 Jul 2019 14:09:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/7] vmpressure: Use spinlock_t instead of struct
 spinlock
In-Reply-To: <20190704153803.12739-3-bigeasy@linutronix.de>
Message-ID: <alpine.DEB.2.21.1907261409260.1791@nanos.tec.linutronix.de>
References: <20190704153803.12739-1-bigeasy@linutronix.de> <20190704153803.12739-3-bigeasy@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019, Sebastian Andrzej Siewior wrote:

Polite reminder ...

> For spinlocks the type spinlock_t should be used instead of "struct
> spinlock".
> 
> Use spinlock_t for spinlock's definition.
> 
> Cc: linux-mm@kvack.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/vmpressure.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/vmpressure.h b/include/linux/vmpressure.h
> index 61e6fddfb26fd..6d28bc433c1cf 100644
> --- a/include/linux/vmpressure.h
> +++ b/include/linux/vmpressure.h
> @@ -17,7 +17,7 @@ struct vmpressure {
>  	unsigned long tree_scanned;
>  	unsigned long tree_reclaimed;
>  	/* The lock is used to keep the scanned/reclaimed above in sync. */
> -	struct spinlock sr_lock;
> +	spinlock_t sr_lock;
>  
>  	/* The list of vmpressure_event structs. */
>  	struct list_head events;
> -- 
> 2.20.1
> 
> 
