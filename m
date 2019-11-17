Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA28AC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 00:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E38206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 00:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573949469;
	bh=PKbosmcBdjQjtRLMX4RrdIREb6fSj5Q09Ssa1PoocC8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cRpGsEc2hC9rwYy7t+r+l+DNd6kEeT9LqG7mh/GxdqP+olSWMJBJpn50CPwxvKq1x
	 ucF99ybXBPlZGTIq/6r2dY1lk9v+p2St2Cj10OgfLgz2794dMTcwhLbstqXfmm/dWw
	 Yn65WO40VSb6KnOEpVgjxfYoBP/SDpu5vg3IRIJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfKQALE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 19:11:04 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41106 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfKQALE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 19:11:04 -0500
Received: by mail-lf1-f65.google.com with SMTP id j14so10854756lfb.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 16:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MuI8NkN6kwBgCdzu3sQGhw3JdUfIFyabbWQ3KLfNo54=;
        b=MuU5eSfcCD/nLcplvfyIZtz7MCTL5KCATX3C3yw5qbYdTGhkdcqmCy9NTsGHmA0ZaI
         2j6JIodhX4t+rtbtINFYvthrO3RuX1BuI9IGcKJtGAaDzdalpAh8f7KrRVB9hWuifc59
         auWm7rQtSUk/ABkoje3j7I401KXvSB02qemiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MuI8NkN6kwBgCdzu3sQGhw3JdUfIFyabbWQ3KLfNo54=;
        b=GEfTT1nrQAJFkqFeL3eYCZOs+IbDiYxwHx2ZAq9ScpqmgmbIIbmOu39LgFlQ/En9UU
         7unKYgVi7cZdNkORhdSddzHRsFdp5bxTwVjzd4vsVzKOlL47+PdY8jj6eR3AvktYUxsU
         5GXwKlrqGbYrEzGc028+RW1FTvDBxwdZM4szR58nAlSNjMmqdRHTng2mfzoClZgNIlD+
         69HSyfr7/tq072EO19QdDqvlDmdsGEf0IJvFyKLxYciozQOWszpgVngo1L7upKrqfE5y
         iQWTElPCqKzXkvGAmQj9zcWBSD6Uls7RUev3DvE+uJY1ZdinOQ8emxnUfaGL2R+B+lBt
         1jMg==
X-Gm-Message-State: APjAAAXLhKqQK6n21rzltQk8T1XEc2oTUm+2aaXTwN7e1nAlGd+RXKBH
        ncjplLP1bROx4FnLAXzZyE/mjVBUtq8=
X-Google-Smtp-Source: APXvYqz3bF8x33YbyZ4dCqy39UR9/+Kc+aw8mlpHPzhEPPWVUOjSvSQ29j287POD+Ln3hFfgwOpj2w==
X-Received: by 2002:ac2:57cb:: with SMTP id k11mr15744346lfo.87.1573949461688;
        Sat, 16 Nov 2019 16:11:01 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id d4sm6373845lfi.32.2019.11.16.16.10.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2019 16:11:00 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id j14so10854702lfb.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 16:10:59 -0800 (PST)
X-Received: by 2002:a19:4949:: with SMTP id l9mr15512677lfj.52.1573949459704;
 Sat, 16 Nov 2019 16:10:59 -0800 (PST)
MIME-Version: 1.0
References: <20191116213742.GA7450@gmail.com> <ab6f2b5a-57f0-6723-c62f-91a8ce6eddac@arm.com>
In-Reply-To: <ab6f2b5a-57f0-6723-c62f-91a8ce6eddac@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Nov 2019 16:10:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiFvP0idYrvWVtEwt6FM9jZ9TRF5yQhT1-X3vx31GRHTg@mail.gmail.com>
Message-ID: <CAHk-=wiFvP0idYrvWVtEwt6FM9jZ9TRF5yQhT1-X3vx31GRHTg@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler fixes
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2019 at 2:44 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> > Valentin Schneider (2):
> >       sched/uclamp: Fix overzealous type replacement
>
> This one got a v2 (was missing one location), acked by Vincent:
>
>   20191115103908.27610-1-valentin.schneider@arm.com
>
> >       sched/topology, cpuset: Account for housekeeping CPUs to avoid empty cpumasks
>
> And this one is no longer needed, as Michal & I understood (IOW the fix in
> rc6 is sufficient), see:
>
>   c425c5cb-ba8a-e5f6-d91c-5479779cfb7a@arm.com

Ingo, what do you want me to do? Pull it anyway and send updates
later? Or skip this pull request?

I'll leave it pending for now,

              Linus
