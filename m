Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76FDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA7E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553507815;
	bh=RahqOi3+qNpPYHNCn8iuJpEvxWxzXDyhr6DYSRbtG00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U7Npr9GvqVOeNK6spQ5PjKnxAXE+KznGyVap0PJz3RgrssIv50ozFvIffzPyue0aS
	 Kfb2ESEY0Lv3RFdTyUS/fQ8P/Qfz97r+6RS1LUFbUD74cpIWvBa05zrkSg54AcB3cc
	 1envLHYEB2EoXR1lYWEUFqm5mYyFs57vmF7htDn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbfCYJ4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:56:54 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42446 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbfCYJ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:56:53 -0400
Received: by mail-oi1-f196.google.com with SMTP id w139so6425159oie.9;
        Mon, 25 Mar 2019 02:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XOd9IT2dezh2M2cUgQ4aKfbEw2w2NXDJPkRGJfYzM+s=;
        b=ncLLxsX44EXmI2LNJA2TTu5bow9U4sg3SLFm6mHb9qCF8O+GK5NX78OoOoHILT2c4J
         gimDVY5MgodzO4A/Ay4A7Lwh8LvUOM7sjPgucw9ti30qwoGA01TRKRiKdqucFqlGRd80
         MyRxjhhAbT2KIuWX7wizrElE86AkAu0JkYZdoBjujqYqOw0kzgE4YibByVzQ/4VuJb+L
         W9/GojV5Gcr2ZPcx7Z5Py/s6mDmFktCAhIyBTi52RSX8v+rk94gz+S4RJb5xg5Liieo4
         sW6gKq92ZGlf3tkOlNdAsVBZJiZk7wNIKLPOaXoP84NBl00lgzcLBN9Ddi6RnQXDTnjY
         BxkQ==
X-Gm-Message-State: APjAAAUqvyYc4BPE2hpEaP4xrdHSh8FeGl0PerjYXBEZZlqNh0ItSLJf
        hXFnU4d55Sbqgs44bzfWxMwG35K4KLMyABfkITY=
X-Google-Smtp-Source: APXvYqz5hglFUb/WifAFET7+2tDLNrfyl0ZlxnGgoVLUrU+pq1McKD/0L77uPT/Xwa6AP3t3M2NbnWPjBqe1LCTDn4g=
X-Received: by 2002:aca:8d3:: with SMTP id 202mr11171314oii.76.1553507813031;
 Mon, 25 Mar 2019 02:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <1637073.gl2OfxWTjI@aspire.rjw.lan> <1762575.ER2xjzr9E1@aspire.rjw.lan>
 <20190322150009.GY6058@hirez.programming.kicks-ass.net>
In-Reply-To: <20190322150009.GY6058@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Mar 2019 10:56:42 +0100
Message-ID: <CAJZ5v0j_gfneFY-7e48Oi5habQd+s3s+aJRN8DQcnJc7yN8CTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs interface
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

On Fri, Mar 22, 2019 at 4:00 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 21, 2019 at 11:20:17PM +0100, Rafael J. Wysocki wrote:
> > +     ret = rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = wrmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS,
> > +                         (epb & ~EPB_MASK) | val);
>
> That's two back-to-back IPIs and a giant waste.

Giant with respect to what?

I know that the read can be avoidable if more MSR bits are stored in
memory, but I don't expect this i/f to be used very often (once per
boot maybe or on AC<->DC changes at most), so I didn't think that this
would be a good tradeoff.

> If you'd use a proper msr shadow variable, you'd not have to do the
> rdmsr_on_cpu :-)

Not really.

The MSR can be updated from elsewhere which is not controlled by this code.
