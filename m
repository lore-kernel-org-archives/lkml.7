Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD26CC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FAB21A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390007AbfKEQ5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:57:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43699 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388836AbfKEQ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:57:35 -0500
Received: by mail-lj1-f194.google.com with SMTP id y23so11776033ljh.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 08:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOVYf2vdaSL/RWJvi5inztDYzFK8sbHwNSUro0lwIhE=;
        b=PQWB0gIenrxlWs5CFGBWd7ncUTKs8I4dyKPEg49ElKr1vXkPwGFxm2samw7xAZmhTx
         u5pLIEDKovzQHcajKutmt3/RueRa3zGqFsIdjwHU1UIoJ/WakaQPkbGXP33s+sPLsSoT
         tYAsSySDWq2jxVYB7ZEIuhHaAVO+jt643fetdyKNk/98KWEsgCSONOoQwV7AoaBUrgoh
         Vdn5tIbv4SFy9LbUxogGstrQkqP225Rh0TQUOuZ57cModb6ffr6dL9cFQVfCbesC9qW4
         S4LishWfAiD/n0gFb6Q1mhQ/2GM3OfSyKyYbqrqLINHmhnYyjuVAdbFQvCueMBu18uTH
         vZVw==
X-Gm-Message-State: APjAAAWFXYlus9Vt3Lyv/cKDpQ2yfZ2joILrKddH/CE5dzGj3qns/ENY
        2RrqEc5wDkAfZhO51P8nS9g3xquVFOvNYcABrbvvCxS+cQg=
X-Google-Smtp-Source: APXvYqx1q5h25O1Avl1/rNRBA2TpfZ8vpThwQmiaeaIk1Z4Qvm+oVdx2IoV+LaUJUqn8XFTKqkgazKObjHqA+PE3MKU=
X-Received: by 2002:a05:651c:20f:: with SMTP id y15mr8682641ljn.31.1572973052825;
 Tue, 05 Nov 2019 08:57:32 -0800 (PST)
MIME-Version: 1.0
References: <20191018163047.1284736-1-arnd@arndb.de> <20191104151310.GA1872@bogus>
 <CAK8P3a1B5v_3p0XhddoeWu7wChr6BndfqVVjPUvWYC6=aRfLXg@mail.gmail.com>
In-Reply-To: <CAK8P3a1B5v_3p0XhddoeWu7wChr6BndfqVVjPUvWYC6=aRfLXg@mail.gmail.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 5 Nov 2019 16:57:21 +0000
Message-ID: <CAPKp9uZ8OMhsXvF4m8=M+5QKHFGPK4ZmM_+eHt_perRQng9J8g@mail.gmail.com>
Subject: Re: [PATCH 1/6] ARM: versatile: move integrator/realview/vexpress to versatile
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 3:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Nov 4, 2019 at 4:13 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Fri, Oct 18, 2019 at 06:29:14PM +0200, Arnd Bergmann wrote:
> > > These are all fairly small platforms by now, and they are
> > > closely related. Just move them all into a single directory.
> > >
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> >
> > Looks good to me, so for vexpress part:
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > As Linus W requested, if you share a branch, I can give it a go on
> > Vexpress TC2.
>
> You are of course both right, I should have split this out into a separate
> branch, rather than sticking it on the end of the completely unrelated
> pxa-multiplatform branch.
>
> For testing the changes, this should be fine in the meantime:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=pxa-multiplatform

Thanks, tested this branch and found no issues.
So in addition to ack:

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
