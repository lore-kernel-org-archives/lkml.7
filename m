Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D81C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BE8206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfGONNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:13:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47662 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730071AbfGONNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:13:35 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hn0nN-0006W2-9L; Mon, 15 Jul 2019 15:13:33 +0200
Date:   Mon, 15 Jul 2019 15:13:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vasily Averin <vvs@virtuozzo.com>
cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] generic arch_futex_atomic_op_inuser() cleanup
In-Reply-To: <7b963f9a-21b1-4c6d-3ece-556d018508b4@virtuozzo.com>
Message-ID: <alpine.DEB.2.21.1907151510230.1722@nanos.tec.linutronix.de>
References: <7b963f9a-21b1-4c6d-3ece-556d018508b4@virtuozzo.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2019, Vasily Averin wrote:

> Access to 'op' variable does not require pagefault_disable(),
> 'ret' variable should be initialized before using,
> 'oldval' variable can be replaced by constant.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  include/asm-generic/futex.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
> index 8666fe7f35d7..e9a9655d786d 100644
> --- a/include/asm-generic/futex.h
> +++ b/include/asm-generic/futex.h
> @@ -118,9 +118,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  static inline int
>  arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
>  {
> -	int oldval = 0, ret;
> -
> -	pagefault_disable();
> +	int ret = 0;

The variable is clearly initialized before using in 'default:', but the
whole function is pretty useless. It's guaranteed to return -ENOSYS and
does nothing else than disabling/enabling pagefaults for no reason.

Thanks,

	tglx


