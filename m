Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0ECC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72A121721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560454707;
	bh=kV/UXS6UPdtHW20LkC6qiHL5zLsxwcgJ+5MfGIH3Y+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xS7OepEX88EWdb7fg9U206YgXkHHUNBRu641esNM7HSVq1Hp6ukx05JIxa3ESknba
	 TUu9Mb0UhPp0d+XLC9PhiXNlObvDnc6NTKnE4IWNv7ckDKKdpbAC2pJtSujuCF18Xe
	 L9gSDRpIRL5PLCEBe6Wg0kCx7S4qP/ohKivP86ZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfFMTi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfFMTi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:38:26 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EFE320B7C;
        Thu, 13 Jun 2019 19:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560454705;
        bh=kV/UXS6UPdtHW20LkC6qiHL5zLsxwcgJ+5MfGIH3Y+Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YqLBr4gitPEc2L7ti7o+3dV2DpciuQOuMnQ3qd/V8odd/Ih6uTz4dp6UhdaKupkMF
         O89xwyGlzkvaiF7D71/ryDd3kduYWRCI3OT9g0Zu175L/KRQTJu60lJxp53XrmruJg
         Jp10v1l+w4VZdhMuXAhAX8DPQ0DzKP2xlNjzTp0s=
Date:   Thu, 13 Jun 2019 12:38:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     <vvs@virtuozzo.com>, <adobriyan@sw.ru>, <adobriyan@gmail.com>,
        <tglx@linutronix.de>, <gregkh@linuxfoundation.org>,
        <mingo@kernel.org>, <viresh.kumar@linaro.org>, <luto@kernel.org>,
        <arjan@linux.intel.com>, <Nadia.Derbey@bull.net>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <stern@rowland.harvard.edu>, <paulmck@linux.vnet.ibm.com>,
        <masami.hiramatsu.pt@hitachi.com>, <alex.huangjianhui@huawei.com>,
        <dylix.dailei@huawei.com>,
        Stanislav Kinsbursky <skinsbursky@parallels.com>,
        Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: Re: [PATCH] kernel/notifier.c: remove notifier_chain_register
Message-Id: <20190613123823.bf75e7305e22dd1dcab04fb8@linux-foundation.org>
In-Reply-To: <1560434864-98664-1-git-send-email-nixiaoming@huawei.com>
References: <1560434864-98664-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019 22:07:44 +0800 Xiaoming Ni <nixiaoming@huawei.com> wrote:

> Registering the same notifier to a hook repeatedly can cause the hook
> list to form a ring or lose other members of the list.
> 
> case1: An infinite loop in notifier_chain_register can cause soft lockup
> 	atomic_notifier_chain_register(&test_notifier_list, &test_notifier1);
> 	atomic_notifier_chain_register(&test_notifier_list, &test_notifier1);
> 	atomic_notifier_chain_register(&test_notifier_list, &test_notifier2);
> 
> case2: An infinite loop in notifier_chain_register can cause soft lockup
> 	atomic_notifier_chain_register(&test_notifier_list, &test_notifier1);
> 	atomic_notifier_chain_register(&test_notifier_list, &test_notifier1);
> 	atomic_notifier_call_chain(&test_notifier_list, 0, NULL);
> 
> case3: lose other hook "test_notifier2"
> 	atomic_notifier_chain_register(&test_notifier_list, &test_notifier1);
> 	atomic_notifier_chain_register(&test_notifier_list, &test_notifier2);
> 	atomic_notifier_chain_register(&test_notifier_list, &test_notifier1);
> 
> case4: Unregister returns 0, but the hook is still in the linked list,
> 	and it is not really registered. If you call notifier_call_chain
> 	after ko is unloaded, it will trigger oops.
> 
> If the system is configured with softlockup_panic and the same
> hook is repeatedly registered on the panic_notifier_list, it
> will cause a loop panic.
> 
> The only difference between notifier_chain_cond_register and
> notifier_chain_register is that a check is added in order to
> avoid registering the same notifier multiple times to the same hook.
> So consider removing notifier_chain_register and replacing it
> with notifier_chain_cond_register.
>
> ...
> 
> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index d9f5081..56efd54 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -19,20 +19,6 @@
>   *	are layered on top of these, with appropriate locking added.
>   */
>  
> -static int notifier_chain_register(struct notifier_block **nl,
> -		struct notifier_block *n)
> -{
> -	while ((*nl) != NULL) {
> -		WARN_ONCE(((*nl) == n), "double register detected");
> -		if (n->priority > (*nl)->priority)
> -			break;
> -		nl = &((*nl)->next);
> -	}
> -	n->next = *nl;
> -	rcu_assign_pointer(*nl, n);
> -	return 0;
> -}

Registering an already-registered notifier is a bug (except for in
net/sunrpc/rpc_pipe.c, apparently).  The effect of this change is to
remove the warning about the presence of the bug, so the bug is less
likely to get fixed.

I think it would be better to remove notifier_chain_cond_register() and
blocking_notifier_chain_cond_register() and to figure out why
net/sunrpc/rpc_pipe.c is using it and to redo the rpc code so it no
longer has that need.

