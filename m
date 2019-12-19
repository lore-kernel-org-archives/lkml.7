Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73706C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4703B21D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfLSKmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:42:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37663 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfLSKmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:42:37 -0500
Received: from [79.140.121.60] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ihtGD-0001Mo-2y; Thu, 19 Dec 2019 10:42:25 +0000
Date:   Thu, 19 Dec 2019 11:42:24 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     qiwuchen55@gmail.com
Cc:     peterz@infradead.org, mingo@kernel.org, oleg@redhat.com,
        prsood@codeaurora.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, chenqiwu@xiaomi.com
Subject: Re: [PATCH v3] kernel/exit: do panic earlier to get coredump if
 global init task exit
Message-ID: <20191219104223.xvk6ppfogoxrgmw6@wittgenstein>
References: <1576736993-10121-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1576736993-10121-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 02:29:53PM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> When global init task get a chance to be killed, panic will happen in
> later calling steps by do_exit()->exit_notify()->forget_original_parent()
> ->find_child_reaper() if all init threads have exited.
> 
> However, it's hard to extract the coredump of init task from a kernel
> crashdump, since exit_mm() has released its mm before panic. In order
> to get the backtrace of init task in userspace, it's better to do panic
> earlier at the beginning of exitting route.
> 
> It's worth noting that we must take case of a multi-threaded init exitting
> issue. We need the test for is_global_init() && group_dead to ensure that
> it is all threads exiting and not just the current thread.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
