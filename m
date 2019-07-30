Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB484C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78398206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YXd7kBZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfG3ETt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 00:19:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38443 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfG3ETt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 00:19:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id h28so43618587lfj.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 21:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nQ683IxaS2cCdEC0NtzNiRTRgopPEXo2ky8LcnAwTHI=;
        b=YXd7kBZwL28XEpjz/Z3rtR2dIB0OAidqsAOvHtlQRogEYM6NC2ckM1jSIgsGWoCMGZ
         X4kEVhO2JN9T8BnkvbQGc0ZIxFAWD/Nx5DfQ/vkzYSAz1D/KaNnTbs6puGB0gjop/fW4
         d2bo9BqeIyQDhBhh030hPqWlNYWaRdg2iUgXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQ683IxaS2cCdEC0NtzNiRTRgopPEXo2ky8LcnAwTHI=;
        b=qQGhoJj14lARMHmLBeJbWdXAl8fWi9ibhp36i9isgy+tFsQHuqhjhOS3YHjCtnhajj
         yDIphJisMBBauWgQp2o2SDkKsXNLJ/uugSvqNjSJH3S5ORYvCb7ltX9WmJOkwioTYM2/
         hi0hZHuU5Kf4LHh+2OfvptLxTcETgblpI79tvcPV3GvomMSgZ1OKQVuujwih0qA2ugwH
         TWj5HgwU6Fny5yVu+qGYhTajKAvhsQhbbwFJgi0q3r1uwTC7SL/GRTgphHypVyLhx/Na
         +JLlbB2Ccy/qoDFgT9pjabPrF23keA05IfwVN2Wd41IsouzLUtdB/cLGn7KVUV//docE
         GJfg==
X-Gm-Message-State: APjAAAW67Ti+GqGvw/rixF82t8ojpV6IPB1cijfpt/gotJ5oKady8VzY
        3OPRAl8k6xrB93MZdsWRGBJ+UXPT0rxgGn9TOPTFDw==
X-Google-Smtp-Source: APXvYqyUBssSkjnT2gtitHVrncu9TYw17XAlBxT/191uCUb+ZIoGAc3Hg6SlZoNfJX9WbRCy4CNt44rlrHF1KrhAnJM=
X-Received: by 2002:a19:8c06:: with SMTP id o6mr53293760lfd.176.1564460387288;
 Mon, 29 Jul 2019 21:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190729010734.3352-1-devel@etsukata.com> <20190729112126.6554b141@gandalf.local.home>
 <2ceec933-503e-5d58-60b4-85b491b017d4@etsukata.com> <20190729221506.1aed7dfc@oasis.local.home>
In-Reply-To: <20190729221506.1aed7dfc@oasis.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 30 Jul 2019 00:19:36 -0400
Message-ID: <CAEXW_YT_vh1iGOwXdymzPO4-k59=+tqQCWHHokv+Kfif5GHypw@mail.gmail.com>
Subject: Re: [PATCH] tracing: Prevent RCU EQS breakage in preemptirq events
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Eiichi Tsukata <devel@etsukata.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        Peter Zilstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Luto <luto@amacapital.net>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 10:15 PM Steven Rostedt <rostedt@goodmis.org> wrote:
[snip]
> > If the problem was only with userstacktrace, it will be reasonable to
> > surround only the userstack unwinder. But the situation is similar to
> > the previous "tracing vs CR2" case. As Peter taught me in
> > https://lore.kernel.org/lkml/20190708074823.GV3402@hirez.programming.kicks-ass.net/
> > there are some other codes likely to to user access.
> > So I surround preemptirq events earlier.
>
> I disagree. The issue is with the attached callbacks that call
> something (a stack unwinder) that can fault.
>
> This is called whenever irqs are disabled. I say we surround the
> culprit (the stack unwinder or stack trace) and not punish the irq
> enable/disable events.

I agree with everything Steve said.

thanks,

 - Joel
