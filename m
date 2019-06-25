Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF839C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC3820656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qVBYgfR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfFYOEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:04:22 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37043 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFYOEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:04:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so18514701qtk.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 07:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DPvMW2fr6AyDsa9whSMq52vSxajOQqknetC+q6gbmvc=;
        b=qVBYgfR4rzpYSfVDWCfmtOGij+iQv/dTWWpAI7ouenA/QAQL8u324gRoj+hE3ByVot
         /XZGfd0UIbcPANtiK5ovRQw2quPQM2tmokuffAtyI8jEKei70LP7gHG5B+H/yl2XgvYu
         gE27WDJHVh+WnJO57wDBrse/8DPrBnIYnFWcrzEPFwMosD2+01ngbrYuMFZRxlYcBnvq
         nCMNTphS5kIoDrAf09qBYJ5Q3YvssIiH6bFfHY7egLfg7nHH2kAKsbHJckSqR8d6bQrD
         s+wObjAKwEC+sutdu6cQ2Pn0KFWZXtYRlICaUfdDFOKx9s6o7Zom4KmrPJ5lbB/Rpcbj
         dPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DPvMW2fr6AyDsa9whSMq52vSxajOQqknetC+q6gbmvc=;
        b=J2I+eOZyesqUoeu17R4/U+nRZxCP68ZHxO1sqcmgntPEm5DPCiC7qIJrq1aFYXuUUZ
         MaueYNv8FLaGUiHjV2fNDJrbBmpFHVGfQSGjyXWroEDvkU7925W9bvx3Qsd0RLIRywtE
         KQM/X3bPSxAojIOZfSYbwjCdivy02pFdm79lGybRZH9Gem+qfMar2PFntd31QcmPS8WD
         52IcJqTl/+Nf35EaPkwOIkrAGOYxY50vn6Lr95JEUckboKPIIcL/7Xu2TIoipHO5beya
         xo+6/lo00hNW8JhRxNjCLlPRRRIb2zC1RIcP+uOhRtCzNMwTTiZexsq718yUTX/f2IDS
         F7Rg==
X-Gm-Message-State: APjAAAVYQ6cMMLepFxiHhLWr3eUNdtF1lUyhxS17N6j4wtNE1Ysjd+3V
        PDvno3vbGblE7TzXGhvEIQq1fQ==
X-Google-Smtp-Source: APXvYqwduY2QsR9K9z38OBh9vpdtbSjdYNDTxzEULBB7Vkixpobp6AR9osyAYp7gYn6khfvZr65DPA==
X-Received: by 2002:aed:38e6:: with SMTP id k93mr5247562qte.147.1561471461067;
        Tue, 25 Jun 2019 07:04:21 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w9sm7159986qki.81.2019.06.25.07.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:04:20 -0700 (PDT)
Message-ID: <1561471459.5154.70.camel@lca.pw>
Subject: Re: [PATCH v2] sched/core: silence a warning in sched_init()
From:   Qian Cai <cai@lca.pw>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 25 Jun 2019 10:04:19 -0400
In-Reply-To: <20190625135238.GA3419@hirez.programming.kicks-ass.net>
References: <1561466662-22314-1-git-send-email-cai@lca.pw>
         <20190625135238.GA3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 15:52 +0200, Peter Zijlstra wrote:
> On Tue, Jun 25, 2019 at 08:44:22AM -0400, Qian Cai wrote:
> > Compiling a kernel with both FAIR_GROUP_SCHED=n and RT_GROUP_SCHED=n
> > will generate a warning using W=1,
> > 
> > kernel/sched/core.c: In function 'sched_init':
> > kernel/sched/core.c:5906:32: warning: variable 'ptr' set but not used
> > [-Wunused-but-set-variable]
> >   unsigned long alloc_size = 0, ptr;
> >                                 ^~~
> > 
> > It apparently the maintainers don't like the previous fix [1] which
> > contains ugly idefs, so silence it by appending the __maybe_unused
> > attribute for it instead.
> > 
> > Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> > 
> > v2: Incorporate the feedback from Valentin.
> > 
> >  kernel/sched/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 874c427742a9..12b9b69c8a66 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5903,7 +5903,8 @@ int in_sched_functions(unsigned long addr)
> >  void __init sched_init(void)
> >  {
> >  	int i, j;
> > -	unsigned long alloc_size = 0, ptr;
> > +	unsigned long alloc_size = 0;
> > +	unsigned long __maybe_unused ptr;
> >  
> 
> That still isn't particularly pretty.
> 
> Why do we care about W=1 build noise? Some of that seems rather silly,
> like that -Wmissing-prototype nonsense.

Yes, -Wmissing-prototype makes no sense, but "-Wunused-but-set-variable" is
pretty valid to catch certain developer errors. For example,

https://lists.linuxfoundation.org/pipermail/iommu/2019-May/035680.html

> 
> As to this one, ideally the compiler would not be stupid, and understand
> the below, but alas.

Pretty sure that won't work, as the compiler will complain something like,

ISO C90 forbids mixed declarations and code

> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fa43ce3962e7..cb652e165570 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6369,7 +6369,7 @@ DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
>  
>  void __init sched_init(void)
>  {
> -	unsigned long alloc_size = 0, ptr;
> +	unsigned long alloc_size = 0;
>  	int i;
>  
>  	wait_bit_init();
> @@ -6381,7 +6381,7 @@ void __init sched_init(void)
>  	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
>  #endif
>  	if (alloc_size) {
> -		ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
> +		unsigned long ptr = (unsigned long)kzalloc(alloc_size,
> GFP_NOWAIT);
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  		root_task_group.se = (struct sched_entity **)ptr;
