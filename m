Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFF9C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B276E2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V6XaEGRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfFYNwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:52:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfFYNwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2AgL/t73Q0waWhszwMSp6rBmzxCxDTZMFIpT9EEU4hw=; b=V6XaEGRxmY3ZxkM2dJEbcdnBC
        mQfNA6Au8IlT+pWdX7pT1furqbVYdt83np2q7mngecAm8I/CJxZ1wY3VO5oFXNdk9ISHZWvZRcjc4
        Hz+tMsj0JipUE39zGZfmAqPVUNM3IOTjaADbMjFlPh12Vlf0Gwgf5reR4LP36lvhiP12hmMMAd+hq
        FwtDOy0DQJw61kKbkXYh5UR4dNwciqSVIiSgwSacpB4QtMadZfsOP9GoV0SwEo8M1b7q6BGSsApz/
        psqRE8mLdDR4VVha7W/wKzZl1XM/QMyB2Fg/U3wYD3UI/3IPxkFFtyLz/N2ycn1xJoRNJy0vsJhHH
        5F+IYIocg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hflsG-0002e9-10; Tue, 25 Jun 2019 13:52:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45A51202B4821; Tue, 25 Jun 2019 15:52:38 +0200 (CEST)
Date:   Tue, 25 Jun 2019 15:52:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mingo@redhat.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/core: silence a warning in sched_init()
Message-ID: <20190625135238.GA3419@hirez.programming.kicks-ass.net>
References: <1561466662-22314-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561466662-22314-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 08:44:22AM -0400, Qian Cai wrote:
> Compiling a kernel with both FAIR_GROUP_SCHED=n and RT_GROUP_SCHED=n
> will generate a warning using W=1,
> 
> kernel/sched/core.c: In function 'sched_init':
> kernel/sched/core.c:5906:32: warning: variable 'ptr' set but not used
> [-Wunused-but-set-variable]
>   unsigned long alloc_size = 0, ptr;
>                                 ^~~
> 
> It apparently the maintainers don't like the previous fix [1] which
> contains ugly idefs, so silence it by appending the __maybe_unused
> attribute for it instead.
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: Incorporate the feedback from Valentin.
> 
>  kernel/sched/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 874c427742a9..12b9b69c8a66 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5903,7 +5903,8 @@ int in_sched_functions(unsigned long addr)
>  void __init sched_init(void)
>  {
>  	int i, j;
> -	unsigned long alloc_size = 0, ptr;
> +	unsigned long alloc_size = 0;
> +	unsigned long __maybe_unused ptr;
>  

That still isn't particularly pretty.

Why do we care about W=1 build noise? Some of that seems rather silly,
like that -Wmissing-prototype nonsense.

As to this one, ideally the compiler would not be stupid, and understand
the below, but alas.

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fa43ce3962e7..cb652e165570 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6369,7 +6369,7 @@ DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
 
 void __init sched_init(void)
 {
-	unsigned long alloc_size = 0, ptr;
+	unsigned long alloc_size = 0;
 	int i;
 
 	wait_bit_init();
@@ -6381,7 +6381,7 @@ void __init sched_init(void)
 	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
 #endif
 	if (alloc_size) {
-		ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
+		unsigned long ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 		root_task_group.se = (struct sched_entity **)ptr;
