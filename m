Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_BTC_ID,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93C4C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA52E206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uBSfYq78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfLDQZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:25:27 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41861 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbfLDQZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:25:27 -0500
Received: by mail-qt1-f193.google.com with SMTP id v2so300554qtv.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 08:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVa8MdwAlJDDx6iLaH+2cmnWCgKAf7e6DS5ywiQvkqM=;
        b=uBSfYq785osgofN/GsfrOi8TbrI1R5zpfaHhxGvWhJgD1bgukjGg2D4L9nCSkr+VG7
         ywPZclymoEHWKzYptstrav+TwQdd20j1AmgJK5GKJZr37eYVFue8suC3WFibJezIUCS4
         CRJtP3kO+cF8QryBQl2d3+4SDwWRu4u1O/fEOBFy2o0bkEsyXfliU65cH5hAcx+w8FXM
         tawtVnoC3X++WrXhTOAw4I9MH9j1tX9NskU9bsIIAMkG0QVFnTcw+lxP85CrT11EJgs4
         ceWinJZna7gjUs1vgKPBP87G9Ao6dPhp88i/ZE+UeMlXiqWQUVJZDCSp1vQ/Yc36niLL
         2Vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVa8MdwAlJDDx6iLaH+2cmnWCgKAf7e6DS5ywiQvkqM=;
        b=l/2Nt8e+AuFlzJsP1HYhgWl8QQZq7cZDKReAHnKRnkglKhW1FQpI4e7k6OtT34/fhV
         yhJHe71QsAoByub6XdvA1Oi3yYyQku41GMPXeMZENwlM00aWFrsfurT9Y4WXF5gVsGNf
         E43Jh73EFyXoSVOI8uXB2HrQSY0dMhaq+3t2FTSamG7j+wMfKKEOu1BvZGnLffZxQ2gx
         +7mlUdC5CsB45Mn4jJTtbeUQu1AA4e1Vc6cAyTFkd09ms1pPWVEikjkP3CX1jrxwf1uu
         Nw5zkws2cTYIzQMP5JUyPHeXrqQSmgoNQ1mYI8BKaubh9d6seC0VA49j3cx3FHc0qBnb
         Kjsg==
X-Gm-Message-State: APjAAAUZ7/6CeNihFmRnVV25iCafr2cK3Zkk6yWIIOLUE98eZ0yl1pxn
        R022ZVdOGd8Kxx/AZppATftYrIhkmg/xIfAMfF0=
X-Google-Smtp-Source: APXvYqxbwxI7IgNRBjnRZ0XPCLFMebhQU9It2q+TPmI6iAvksb06ANWmQFXz8uFinM7yJ4kmzoLzGPuv3Xqb6lvmRoc=
X-Received: by 2002:ac8:1835:: with SMTP id q50mr3471028qtj.210.1575476726394;
 Wed, 04 Dec 2019 08:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20191203155907.2086-1-valentin.schneider@arm.com>
 <20191203155907.2086-2-valentin.schneider@arm.com> <CAKfTPtC-9nxGCAq8ck0Av6zuqCySvO87oP4hhBE=qKL3gxu+ow@mail.gmail.com>
 <7d6d959d-3767-1a12-4c80-e7d52a48c396@arm.com> <CAKfTPtA3ZLkNn4BEDctLo6VxvgHv_cvQSFx5N_+ERGToa+3FLg@mail.gmail.com>
In-Reply-To: <CAKfTPtA3ZLkNn4BEDctLo6VxvgHv_cvQSFx5N_+ERGToa+3FLg@mail.gmail.com>
From:   Rainer Sickinger <rainersickinger.official@gmail.com>
Date:   Wed, 4 Dec 2019 17:25:14 +0100
Message-ID: <CAD9cdQ4btBk8LU+cDj-sfX6So+5CPsoS=Pv=j63bCBkywFJaiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] sched/uclamp: Make uclamp_util_*() helpers use and
 return UL values
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Quentin Perret <qperret@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can just use Math.clamp for that!
Idiots.

RAINER

Am Mi., 4. Dez. 2019 um 17:13 Uhr schrieb Vincent Guittot
<vincent.guittot@linaro.org>:
>
> On Wed, 4 Dec 2019 at 17:03, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
> >
> > On 04/12/2019 15:22, Vincent Guittot wrote:
> > >> @@ -2303,15 +2303,15 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
> > >>  unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
> > >
> > > Why not changing uclamp_eff_value to return unsigned long too ? The
> > > returned value represents a utilization to be compared with other
> > > utilization value
> > >
> >
> > IMO uclamp_eff_value() is a simple accessor to uclamp_se.value
> > (unsigned int), which is why I didn't want to change its return type.
> > I see it as being the task equivalent of rq->uclamp[clamp_id].value, IOW
> > "give me the uclamp value for that clamp index". It just happens to be a
> > bit more intricate for tasks than for rqs.
>
> But then you have to take care of casting the returned value in
> several places here and in patch 3
>
> >
> > uclamp_util() & uclamp_util_with() do explicitly return a utilization,
> > so here it makes sense (in my mind, that is) to return UL.
