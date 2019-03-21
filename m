Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BC9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627B4218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553160089;
	bh=H8Q1KaePjfNLYvm/uXMcUCYQlnnGbCOfGDGJC2RYx1w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Vce448v9F7lb40KFcxJ/8LVEfoJK7eBgmZENoEEgIg6WfQkS6/217TMII3kZ0pjLi
	 zaUgeB07p88t9sQFDcg7755TE/iskjcz9mmCAUSse2AHAhbjnVqB8zNLMN9j6bCbwQ
	 bM7mXXKeaQ1jl+wm3gBae7r6IYAPn4/kfZ2v8D48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfCUJV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:21:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44258 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfCUJV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:21:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id d24so4776328otl.11;
        Thu, 21 Mar 2019 02:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVNkUOOLD7/LLg9HX1cO3iiu92h3BsRmg1XybBMG8hg=;
        b=SPQG6MUG6XRTLMsJJMnZU9AJlp7zmKuiQacMjSHtIKPW7f+IaUfrC9nz2LEe6mBmf7
         w2GfLXCcfolNOIjqfEHIbyXPssxb2Ddt4Q784Q6Iy4GMDfAphc+9BNZblGpAmLKa8Tys
         9kk2Ds+FMevixd+zWXab2P1kjiCWFs01Esa8H/uldNdMb3x1PnuTka5hyGYPpcpVnYQN
         aD+28ZNaGTXBu0I0QDlbMVLW9Ybk9FIea0aRTtOk+tGOv9TwBcPj4drbwLQGkDNCHPDg
         8ka1XjRpcXkOTYYBT2SxTalyFjN9/2MwdzOfHgov/9mZQ6gG6osnlr40ifDw0mPWW5X7
         +sow==
X-Gm-Message-State: APjAAAV03JlrlH2wX7TfJUNCIIzLKRce7nPbUeMz+bSlURRY027iBhKD
        Kcv0ka594axV54OKrwFUe4KgMixlWcxFVkKB0sA=
X-Google-Smtp-Source: APXvYqzwqYWxbKWyBynqEy3oX0qz6NhOr/eFhbOaVgQ9DgC2GQwWqNoD4ySlc/FQrPqyRSNKR68HDaMuN1IUuAZyh7Y=
X-Received: by 2002:a9d:36a:: with SMTP id 97mr1636400otv.124.1553160086902;
 Thu, 21 Mar 2019 02:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <2816566.rddYshD6lm@aspire.rjw.lan> <20190321075807.GK6058@hirez.programming.kicks-ass.net>
In-Reply-To: <20190321075807.GK6058@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Mar 2019 10:21:15 +0100
Message-ID: <CAJZ5v0hz3KFtmsP+8Qbee7KrV4BBOUzReUmK8BWH52+hwekt=Q@mail.gmail.com>
Subject: Re: [PATCH] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS handling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Schricker <sschricker@suse.de>,
        Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 8:58 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 21, 2019 at 01:00:52AM +0100, Rafael J. Wysocki wrote:
> > + * The Performance and Energy Bias Hint (EPB) allows software to specify its
> > + * preference with respect to the power-performance tradeoffs present in the
> > + * processor.  Generally, the EPB is expected to be set by user space through
> > + * the generic MSR interface (with the help of the x86_energy_perf_policy tool),
> > + * but there are two reasons for the kernel to touch it.
>
> So I hate /dev/msr with a passion. It is absolute atrocious crap.
>
> Please, just make a real interface for this if it is important.

That's the plan going forward, this is just documenting the current situation.

Do you have any particular concerns regarding this patch?
