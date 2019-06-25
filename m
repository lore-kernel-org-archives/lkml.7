Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D130EC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F590208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fVY3ICfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbfFYPHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:07:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38734 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732067AbfFYPHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:07:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id n11so7517968qtl.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MlFm0RSUDJWR/dpFwmu8HNr471hEX79YQx8dujmGuTY=;
        b=fVY3ICfXakhtVfbzcDEtsi9F/GE7Aeb5Q8NxEHcRpOfvNIEa7ZHeVpZ1LXNQKE8eSd
         vqN6KiG0165nartNEfdqe4JzSg8yaALuv9CoTSD7fYD2bxerXjngGFOKyuPepYPQETyX
         ybUXyr6JOCICPvL18Wn+PCsbXig0qOG8x4CIs7tRnaFgJf4jdwC8OshLFaoPEzTrK8JD
         uDy1T1gQia3lfsOzVCtVCiU54zrpuW6jKvcX9mLoDT8AaO0Xr5N4uO9EtMHuqr4yjyYm
         pez17k3OKDsbC43eZDrg9ZfAWdOS/RHVzI951MCp/oiH7S/trI++NRhvG1fQqdMxicd3
         DN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlFm0RSUDJWR/dpFwmu8HNr471hEX79YQx8dujmGuTY=;
        b=rc16uU1DyaqaVJpgO9V5/uty0Ye411YvzkoKIkNs/cjskg0hm5MV4xRYIT9yj8Q/g5
         hOR0jF0aFw604lzD068+/n6yEEn8zx32BvyeGP9GL/RyHcSgsV7cb+ROBtBNvWTTyR6U
         G7ukIeStn8YMu6VxsRGVJhcze/k6S/YclGpHRea1i8Rpjk+N4TYDwz4ZY1TqetjzQNMp
         gdUOvwavuzaRkg2RB7TBoM1gWCYVDVBCOiX/rDUY7Ilt4GWQWttRU/3FnY5AbCTC3R0b
         25fS8X9os7HJj9osXGS11GZBu9GijXGuXUffrfB4Ke1UD9I1bK29GId6GtYOQrt6t+1a
         otiA==
X-Gm-Message-State: APjAAAVfWiTE7+azp7F0eUvj7mBaA36g+KvRT+mbp8KBxk4TvVwS+Scl
        NJ6nZyfM8m5fA7wFJ9R4grVHhQ==
X-Google-Smtp-Source: APXvYqx5qq+RXjT0mopAm4rY8YxlQmok9dJ/vgId4MGAW9BSZbFsk13S7wC2nyjHTouIC5AdCKBLnQ==
X-Received: by 2002:ac8:2d17:: with SMTP id n23mr72728077qta.132.1561475231316;
        Tue, 25 Jun 2019 08:07:11 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d17sm6781843qtp.84.2019.06.25.08.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 08:07:10 -0700 (PDT)
Message-ID: <1561475229.5154.74.camel@lca.pw>
Subject: Re: [PATCH v2] sched/core: silence a warning in sched_init()
From:   Qian Cai <cai@lca.pw>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 25 Jun 2019 11:07:09 -0400
In-Reply-To: <20190625142508.GE3419@hirez.programming.kicks-ass.net>
References: <1561466662-22314-1-git-send-email-cai@lca.pw>
         <20190625135238.GA3419@hirez.programming.kicks-ass.net>
         <1561471459.5154.70.camel@lca.pw>
         <20190625142508.GE3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 16:25 +0200, Peter Zijlstra wrote:
> On Tue, Jun 25, 2019 at 10:04:19AM -0400, Qian Cai wrote:
> > On Tue, 2019-06-25 at 15:52 +0200, Peter Zijlstra wrote:
> > Yes, -Wmissing-prototype makes no sense, but "-Wunused-but-set-variable" is
> > pretty valid to catch certain developer errors. For example,
> > 
> > https://lists.linuxfoundation.org/pipermail/iommu/2019-May/035680.html
> > 
> > > 
> > > As to this one, ideally the compiler would not be stupid, and understand
> > > the below, but alas.
> > 
> > Pretty sure that won't work, as the compiler will complain something like,
> > 
> > ISO C90 forbids mixed declarations and code
> 
> No, it builds just fine, it's a new block and C allows new variables at
> every block start -- with the scope of that block.

I remember I tried that before but recalled the error code wrong. Here it is,

kernel/sched/core.c:5940:17: warning: unused variable 'ptr' [-Wunused-variable]
                unsigned long ptr = (unsigned long)kzalloc(alloc_size,
GFP_NOWAIT);

> 
> And for our config, alloc_size is an unconditional 0, so it should DCE
> the whole block and with that our variable. But clearly the passes are
> the other way around :/
> 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index fa43ce3962e7..cb652e165570 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -6369,7 +6369,7 @@ DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
> > >  
> > >  void __init sched_init(void)
> > >  {
> > > -	unsigned long alloc_size = 0, ptr;
> > > +	unsigned long alloc_size = 0;
> > >  	int i;
> > >  
> > >  	wait_bit_init();
> > > @@ -6381,7 +6381,7 @@ void __init sched_init(void)
> > >  	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
> > >  #endif
> > >  	if (alloc_size) {
> > > -		ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
> > > +		unsigned long ptr = (unsigned long)kzalloc(alloc_size,
> > > GFP_NOWAIT);
> > >  
> > >  #ifdef CONFIG_FAIR_GROUP_SCHED
> > >  		root_task_group.se = (struct sched_entity **)ptr;
