Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEA3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A5F21741
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No08yi/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbfC0BSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:18:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38387 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfC0BSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:18:23 -0400
Received: by mail-io1-f67.google.com with SMTP id v4so12621326ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 18:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69vIIQnvsFVLrNcpvL1oqzWwyS2SEbqw1MraP781CkA=;
        b=No08yi/2Zy6ezN3NLJO8ZEhtoYf+p32jodFRPbrUjPsA/w4gkGwsaSc0L2kZ0r82wR
         sVaKHdPd2JW0joj8hzqiXfETG4cSezE+7wbT42uFXIG7M0n6eyYTJwHBb302mXj1n1ld
         NchOTH2AKDeFiMX82ItPGMfcaNi7tl8Uwzg+ngsTc4LGGrK0KZtJQKtxXfjL983TqcFR
         BuSMT6mXv7M6a2JZ8PV59XOSJbaOEabPogjTKKgQ+Hv9nzulBgKKXM3R/476HuOJKeYD
         CnRlQrx30NZRSGpArFeTpRfoaFtYEw+iJ7ocM2cnxhdgYOXOUuRvTnbJF5l6vkz0xL+p
         +T2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69vIIQnvsFVLrNcpvL1oqzWwyS2SEbqw1MraP781CkA=;
        b=klaDwOdifoudk7ZaVDIMslgiTLWX/gHuJLGfVFj+aJFQW9LhuV4GfcQ7jzISYvqzFm
         UCWlgeEqfIGt7kSVkhxvxQkW0xe4iW76DeT7IqdcCYCnnSFVe50O11Z6HGKLncDmNdon
         by0h5LhVxyXLLi9Rb/cIA8+yUCG+NS59gLgwlEXU9CmmGELfjfTmbbGm19LsT6qywQ6g
         38jWH8ZD6cAjxrw80Cxw5SZPZ4VjRm7JULeOj83uJMBauweEbmAzkHTRyGC7JbpuHOet
         mrJENlpPoJYhegH35vBXMW+7kaj3PQR6dRGKk+sKxHFGojJP83VBHz/dGRBBHRSjltwT
         KuGA==
X-Gm-Message-State: APjAAAXMT4KBz9WNiKbSe07f139ytVkgdOaaxRLAo+0ZPOZxJevHPsV/
        iJiqbQzJTZ6kkiF1ZHwmCGBNgiZj5OzZp6YPJPk=
X-Google-Smtp-Source: APXvYqxOC07EHDFTbwOWWWioiGuK/o5IpJAfXSK/tat5vEAIUURiCVMWLCCjxsAUrM6EYxjAb9+Bky+648CIbevjWlQ=
X-Received: by 2002:a6b:e50d:: with SMTP id y13mr21333312ioc.142.1553649502094;
 Tue, 26 Mar 2019 18:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <1553602391-11926-1-git-send-email-laoar.shao@gmail.com>
 <1553602391-11926-4-git-send-email-laoar.shao@gmail.com> <20190326151815.GI4102@linux.ibm.com>
 <20190326112958.2668a4a1@gandalf.local.home>
In-Reply-To: <20190326112958.2668a4a1@gandalf.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 27 Mar 2019 09:17:45 +0800
Message-ID: <CALOAHbCZ7Bppb8q5=b=QG4g+uZu4EdKQZcME346OJPiCPsQngA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rcu: validate arguments for rcu tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>, mingo@redhat.com,
        Peter Zijlstra <peterz@infradead.org>, josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        LKML <linux-kernel@vger.kernel.org>, shaoyafang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:30 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 26 Mar 2019 08:18:15 -0700
> "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
>
> > On Tue, Mar 26, 2019 at 08:13:11PM +0800, Yafang Shao wrote:
> > > When CONFIG_RCU_TRACE is not set, all these tracepoints are defined as
> > > do-nothing macro.
> > > We'd better make those inline functions that take proper arguments.
> > >
> > > As RCU_TRACE() is defined as do-nothing marco as well when
> > > CONFIG_RCU_TRACE is not set, so we can clean it up.
> >
> > How about this for the commit log?
> >
> >       Unless the CONFIG_RCU_TRACE kconfig option is set, almost all
> >       of RCU's tracepoints are defined as empty macros.  It would
> >       be better if these tracepoints could instead be empty inline
> >       functions with proper arguments and type checking.  It would
> >       also be good to get rid of the RCU_TRACE() macro, which
> >       compiles its argument in CONFIG_RCU_TRACE=y kernels and
> >       omits them otherwise.
> >
> >       This commit therefore creates a TRACE_EVENT_RCU macro that
> >       is defined as TRACE_EVENT in CONFIG_RCU_TRACE=y kernels and
> >       as the new TRACE_EVENT_NOP otherwise, which allows the
> >       empty macros and the RCU_TRACE() macro to be eliminated.
> >
> > With that:
> >
> > Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
>
> Yafang,
>
> If you are OK with the above changes, I'll take this patch with the
> updated change log.
>

Hi Steve,

This new changelog is OK by me.
Pls. take it.

Thanks
Yafang
