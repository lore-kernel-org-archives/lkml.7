Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD92C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCD720684
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="x910cGS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfLBXfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:35:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41123 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLBXfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:35:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so657699pfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 15:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w+pmrGh029YUQ5eJon38ktMcsPqVlDtQrz3QkfAhmHE=;
        b=x910cGS2QlOTRO1S/PmgDIscoIikexDQMmyILqLppQV6gA6VUD5qAhc6UjY9oeLaVE
         OnZ8AOyh2fTkDFZJJM9olVCaJin9mWsXiu70Dd/Sgc+J5OncVpn8r8PrQgdhxfpKpPqq
         +ygLpx/GKUBhi/7uBpo2+2TTi17lvmpqUrQVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w+pmrGh029YUQ5eJon38ktMcsPqVlDtQrz3QkfAhmHE=;
        b=p2XrGzBcnkhSaaR97eJBMkPnj/3fJRGZ8WUFdeZvMmUbIqBKWx3/CQ9dp7LiFw5GvD
         1Kz2xIhQz8XwbSQTCtLqw5a7DqLB5sLvon2zCMfRDYOLQC2SS6TBd7ziAFvmiPa3N+WL
         cJI8/LMFUrHoj9G6/mK522OD49iO6kBlfFQ6XxxCRc8euGg82iC8v9bN4lBOonLiqSCk
         yPq14Rkl49WBQ1g5j2coihiymU8lj+Qi2e9KIEugDI0HKgoPlD6E0/4ri/Rnoj/gjdou
         ATobeP2/iUw4r2OessHDgLsYht7bBNag57WVry7x/ZBo8RuBCddEJqqQ1QThg+AbEiIB
         /rDg==
X-Gm-Message-State: APjAAAWbBEyIBENj/LLxJlHRaTHWA6seginYP3Css07kKToFiQMqmgS7
        tjI0cKJA7sV6GLSH/qHo+fy3SAPTVzM=
X-Google-Smtp-Source: APXvYqypKYC/VOb4FqzCGiWl5xuMwdb0hemEIWiokHB6bj/M7vUVrVqZtV18DyGSVqmpW8U/kBMNwQ==
X-Received: by 2002:a63:ec09:: with SMTP id j9mr1838045pgh.367.1575329732844;
        Mon, 02 Dec 2019 15:35:32 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o15sm708702pgf.2.2019.12.02.15.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 15:35:32 -0800 (PST)
Date:   Mon, 2 Dec 2019 18:35:31 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip] kprobes: Lock rcu_read_lock() while searching kprobe
Message-ID: <20191202233531.GO17234@google.com>
References: <157527193358.11113.14859628506665612104.stgit@devnote2>
 <20191202210854.GD17234@google.com>
 <20191203073453.057c1bed6931457b011dd8cc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203073453.057c1bed6931457b011dd8cc@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 07:34:53AM +0900, Masami Hiramatsu wrote:
> Hi Joel,
> 
> On Mon, 2 Dec 2019 16:08:54 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > On Mon, Dec 02, 2019 at 04:32:13PM +0900, Masami Hiramatsu wrote:
> > > Anders reported that the lockdep warns that suspicious
> > > RCU list usage in register_kprobe() (detected by
> > > CONFIG_PROVE_RCU_LIST.) This is because get_kprobe()
> > > access kprobe_table[] by hlist_for_each_entry_rcu()
> > > without rcu_read_lock.
> > > 
> > > If we call get_kprobe() from the breakpoint handler context,
> > > it is run with preempt disabled, so this is not a problem.
> > > But in other cases, instead of rcu_read_lock(), we locks
> > > kprobe_mutex so that the kprobe_table[] is not updated.
> > > So, current code is safe, but still not good from the view
> > > point of RCU.
> > > 
> > > Let's lock the rcu_read_lock() around get_kprobe() and
> > > ensure kprobe_mutex is locked at those points.
> > > 
> > > Note that we can safely unlock rcu_read_lock() soon after
> > > accessing the list, because we are sure the found kprobe has
> > > never gone before unlocking kprobe_mutex. Unless locking
> > > kprobe_mutex, caller must hold rcu_read_lock() until it
> > > finished operations on that kprobe.
> > > 
> > > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Instead of this, can you not just pass the lockdep_is_held() expression as
> > the last argument to list_for_each_entry_rcu() to silence the warning? Then
> > it will be a simpler patch.
> 
> Ah, I see. That is more natural to silence the warning.

Np, and on such fix, my:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> 
> Thank you!
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
