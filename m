Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750B8C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B65233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387566AbfHVKZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:25:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387555AbfHVKZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:25:35 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A37E2D1CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 10:25:35 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id g2so1871955wmk.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 03:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OkWE/ypXtm5ByIaQmws7qUqEgpMrRSHM+eiQENF8y7E=;
        b=KB5PDhvxl4SJ11v9oodODA7MsIgh5jxKs/iTOOX85iywYtxYhAAyhjSIRj0+vFJy63
         s3k/3fnCOqLcOQvQG/FfZJLkeulEBc7EtyQob21N4RLaX4jgXDTyHHr1aWDEMEan4k9f
         dWDOZ8vBRD1GYjivW+ii7z0+Gw5MIjqMFS5B5ITaz9yTx5Ejw8z4S57SSZ6Sx57qziPZ
         J2ZJerGTifhjPUDMVGLpjGvRK8kwT8YDT/ux4NAnSqguFgVp5D6MVZzZadmGcPXESw0T
         M8aGxrDys/1xHjlR2sXcx+j33gymngWBq4+dep2q15vnazi+1vbbTjfN9MJvkurg16zq
         jOOg==
X-Gm-Message-State: APjAAAVwnATTvd4Is7+mB3AQTMDYGo1jUvt9FcWTBuDcQ3pL5Y/E+Yv9
        zKfFDEB8/qBi2DA59dsI24O1tFA5tyS9VYfCJm29rwOemmGawd9T4jKsAOK+FOQv/pybTXrbo88
        xVMuywlj/KUy2yFm2GyGeq4tR
X-Received: by 2002:a1c:a383:: with SMTP id m125mr5554927wme.57.1566469533833;
        Thu, 22 Aug 2019 03:25:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzfnLy3HKEn/7VIiE1whM0k6Xh58TuFmITLJJOXHevPzuzCcy4uuxv6bxU801laeEZq5DwlZQ==
X-Received: by 2002:a1c:a383:: with SMTP id m125mr5554883wme.57.1566469533587;
        Thu, 22 Aug 2019 03:25:33 -0700 (PDT)
Received: from steredhat (host80-221-dynamic.18-79-r.retail.telecomitalia.it. [79.18.221.80])
        by smtp.gmail.com with ESMTPSA id f13sm17769033wrr.5.2019.08.22.03.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 03:25:33 -0700 (PDT)
Date:   Thu, 22 Aug 2019 12:25:29 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "jhansen@vmware.com" <jhansen@vmware.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsock: Fix a lockdep warning in __vsock_release()
Message-ID: <20190822102529.q5ozdvh6kbymi6ni@steredhat>
References: <1566270830-28981-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566270830-28981-1-git-send-email-decui@microsoft.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 03:14:22AM +0000, Dexuan Cui wrote:
> Lockdep is unhappy if two locks from the same class are held.
> 
> Fix the below warning by making __vsock_release() non-recursive -- this
> patch is kind of ugly, but it looks to me there is not a better way to
> deal with the problem here.
> 
> ============================================
> WARNING: possible recursive locking detected
> 5.2.0+ #6 Not tainted
> --------------------------------------------
> a.out/1020 is trying to acquire lock:
> 0000000074731a98 (sk_lock-AF_VSOCK){+.+.}, at: hvs_release+0x10/0x120 [hv_sock]
> 
> but task is already holding lock:
> 0000000014ff8397 (sk_lock-AF_VSOCK){+.+.}, at: __vsock_release+0x2e/0xf0 [vsock]
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(sk_lock-AF_VSOCK);
>   lock(sk_lock-AF_VSOCK);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 2 locks held by a.out/1020:
>  #0: 00000000f8bceaa7 (&sb->s_type->i_mutex_key#10){+.+.}, at: __sock_release+0x2d/0xa0
>  #1: 0000000014ff8397 (sk_lock-AF_VSOCK){+.+.}, at: __vsock_release+0x2e/0xf0 [vsock]
> 
> stack backtrace:
> CPU: 7 PID: 1020 Comm: a.out Not tainted 5.2.0+ #6
> Call Trace:
>  dump_stack+0x67/0x90
>  __lock_acquire.cold.66+0x14d/0x1f8
>  lock_acquire+0xb5/0x1c0
>  lock_sock_nested+0x6d/0x90
>  hvs_release+0x10/0x120 [hv_sock]
>  __vsock_release+0x24/0xf0 [vsock]
>  __vsock_release+0xa0/0xf0 [vsock]
>  vsock_release+0x12/0x30 [vsock]
>  __sock_release+0x37/0xa0
>  sock_close+0x14/0x20
>  __fput+0xc1/0x250
>  task_work_run+0x98/0xc0
>  do_exit+0x3dd/0xc60
>  do_group_exit+0x47/0xc0
>  get_signal+0x169/0xc60
>  do_signal+0x30/0x710
>  exit_to_usermode_loop+0x50/0xa0
>  do_syscall_64+0x1fc/0x220
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  net/vmw_vsock/af_vsock.c         | 33 ++++++++++++++++++++++++++++++++-
>  net/vmw_vsock/hyperv_transport.c |  2 +-
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index ab47bf3..420f605 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -638,6 +638,37 @@ struct sock *__vsock_create(struct net *net,
>  }
>  EXPORT_SYMBOL_GPL(__vsock_create);
>  
> +static void __vsock_release2(struct sock *sk)
> +{
> +	if (sk) {
> +		struct sk_buff *skb;
> +		struct vsock_sock *vsk;
> +
> +		vsk = vsock_sk(sk);
> +
> +		/* The release call is supposed to use lock_sock_nested()
> +		 * rather than lock_sock(), if a lock should be acquired.
> +		 */
> +		transport->release(vsk);
> +
> +		/* Use the nested version to avoid the warning
> +		 * "possible recursive locking detected".
> +		 */
> +		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);

What about using lock_sock_nested() in the __vsock_release() without
define this new function?

> +		sock_orphan(sk);
> +		sk->sk_shutdown = SHUTDOWN_MASK;
> +
> +		while ((skb = skb_dequeue(&sk->sk_receive_queue)))
> +			kfree_skb(skb);
> +
> +		/* This sk can not be a listener, so it's unnecessary
> +		 * to call vsock_dequeue_accept().
> +		 */
> +		release_sock(sk);
> +		sock_put(sk);
> +	}
> +}
> +
>  static void __vsock_release(struct sock *sk)
>  {
>  	if (sk) {
> @@ -659,7 +690,7 @@ static void __vsock_release(struct sock *sk)
>  
>  		/* Clean up any sockets that never were accepted. */
>  		while ((pending = vsock_dequeue_accept(sk)) != NULL) {
> -			__vsock_release(pending);
> +			__vsock_release2(pending);
>  			sock_put(pending);
>  		}
>  
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index 9d864eb..4b126b2 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -559,7 +559,7 @@ static void hvs_release(struct vsock_sock *vsk)
>  	struct sock *sk = sk_vsock(vsk);
>  	bool remove_sock;
>  
> -	lock_sock(sk);
> +	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);

Should we update also other transports?

Thanks,
Stefano
