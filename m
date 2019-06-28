Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6311BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3059D216E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561684220;
	bh=yzoO61EJmprVWNY3EpL3GXI+joDNjs4U10vKsbjnU54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GaJWPUm3bxZTHv2iiAVncXE+Kw6XKHF4kgTnkoORfPdRz/Sf5j8aUtZ98nwy+k7/T
	 OSfhhDBQZ1z9agVsYWIP4uLlCXBXl0VAaKGDDie+grpLN6LCi6AJM1DrUt4T/aLvfZ
	 kkMrOkB4ttjWU4Utk6RbDLgzK1Bpp8UEd92wNZOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfF1BKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 21:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbfF1BKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:10:18 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5D90208CB;
        Fri, 28 Jun 2019 01:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561684217;
        bh=yzoO61EJmprVWNY3EpL3GXI+joDNjs4U10vKsbjnU54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J4DAc2GS3ltAyGnSJz8KKcoypxlm0zXtV8PZB8uJEmQnyghsKWeED0zUoAfSMzoDJ
         DuYlTiFcwxXIiBb+vuD+HIEZiXLmpZi5D3ZmcMriTX/hUU7aa2nnD/hKhlbI+OCapN
         2Lp28nmbcieceEy6Ow52Y+n5cu3oTFJwr6bK2gXY=
Date:   Fri, 28 Jun 2019 03:10:13 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] sched/nohz: Optimize get_nohz_timer_target()
Message-ID: <20190628011012.GA19488@lerouge>
References: <1561682593-12071-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561682593-12071-1-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 08:43:12AM +0800, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> On a machine, cpu 0 is used for housekeeping, the other 39 cpus in the 
> same socket are in nohz_full mode. We can observe huge time burn in the 
> loop for seaching nearest busy housekeeper cpu by ftrace.
> 
>   2)               |       get_nohz_timer_target() {
>   2)   0.240 us    |         housekeeping_test_cpu();
>   2)   0.458 us    |         housekeeping_test_cpu();
> 
>   ...
> 
>   2)   0.292 us    |         housekeeping_test_cpu();
>   2)   0.240 us    |         housekeeping_test_cpu();
>   2)   0.227 us    |         housekeeping_any_cpu();
>   2) + 43.460 us   |       }
>   
> This patch optimizes the searching logic by finding a nearest housekeeper
> cpu in the housekeeping cpumask, it can minimize the worst searching time 
> from ~44us to < 10us in my testing. In addition, the last iterated busy 
> housekeeper can become a random candidate while current CPU is a better 
> fallback if it is a housekeeper.
> 
> Cc: Ingo Molnar <mingo@redhat.com> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
