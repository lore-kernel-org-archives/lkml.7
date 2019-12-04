Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68205C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF732081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xb0MwDer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfLDQMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:12:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42869 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbfLDQMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:12:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id e28so8740359ljo.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 08:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aEQbr8zROwuWUFHCrCgNlAMwSOCb9/WQ7f8S4z9pFJg=;
        b=Xb0MwDerHtPwvjsigudnnRH7PiA0KhgNJlRZ9+gidTBzuLsMRSxPFwwXwHzIeJW8yd
         IxRHnjqjZMDbMAiPeWVYbu4DsxbpcrfH+tr5v4S4DjbCrXS9suO4Cel8ojNDFVngB5e+
         aFxlbObTmA+PkxWoyT3E4B+RmIaFJXxpLNMwTxAYRzqI0rMPEy1V+2MKT8nC54E1x4pd
         LJWK1S+g2zlobPV0/lLnXG/gY3yCMFOO5ZZ0OYR3U654Hoz2eIs102hVoHQNrHXYC84K
         fw8aqQAObYFb030P7RJdvL6Dxf4lDBGgC2xxqV2exakkTs5YkKC0/P+rHMcvzGgjOHtH
         RX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aEQbr8zROwuWUFHCrCgNlAMwSOCb9/WQ7f8S4z9pFJg=;
        b=EdV8oCJdkvZcpD7Fair5MTpoK3PdEZRxR3nKZ90aGo2/qTg5Y/B2dz+KrPXHLEGPjo
         /xLd3RQpuAuiyKaRMTxTvgC0CMxWq4y4up52H1KDPQM0rA7vW6bK9tkRP8p3QdjOd1uB
         yL+7SxPobrX59SiDMpqaoLGe0gXxP0CknWGcIc5NaueZpjmr6IdD1Bgl2iUfxWtFWWu5
         48AexfzYcVI6rWfTwGCILNnAC5HtQDictOJQFmHBYDcpqVT2s7YRqohekuwZm/x5kUaW
         pbrvF+6V3K3Bub6Im86zWFORfiEwva4JqHGL2+850Szz1cmypGEd+eN8Zonf7WxrOQfK
         7sIA==
X-Gm-Message-State: APjAAAXUER64ddIyjkc13DGUlkx+HR5xWgN8qJuhR7YXDPfI+xFCeU0T
        C5Vr2MnjNkCGzkVzTvjIC13JTtjlbXfyhg46ibB0Nw==
X-Google-Smtp-Source: APXvYqxC6r2RurR4t3Y1ptw9iBisVHKMHSzGYcgkldL9Zzs1xJr8iEa2fZ/dwcVjVKixaOUAmm08lzzSwT0aFNs+Qmk=
X-Received: by 2002:a2e:6a14:: with SMTP id f20mr2605748ljc.87.1575475958449;
 Wed, 04 Dec 2019 08:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20191203155907.2086-1-valentin.schneider@arm.com>
 <20191203155907.2086-2-valentin.schneider@arm.com> <CAKfTPtC-9nxGCAq8ck0Av6zuqCySvO87oP4hhBE=qKL3gxu+ow@mail.gmail.com>
 <7d6d959d-3767-1a12-4c80-e7d52a48c396@arm.com>
In-Reply-To: <7d6d959d-3767-1a12-4c80-e7d52a48c396@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Dec 2019 17:12:26 +0100
Message-ID: <CAKfTPtA3ZLkNn4BEDctLo6VxvgHv_cvQSFx5N_+ERGToa+3FLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] sched/uclamp: Make uclamp_util_*() helpers use and
 return UL values
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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

On Wed, 4 Dec 2019 at 17:03, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 04/12/2019 15:22, Vincent Guittot wrote:
> >> @@ -2303,15 +2303,15 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
> >>  unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
> >
> > Why not changing uclamp_eff_value to return unsigned long too ? The
> > returned value represents a utilization to be compared with other
> > utilization value
> >
>
> IMO uclamp_eff_value() is a simple accessor to uclamp_se.value
> (unsigned int), which is why I didn't want to change its return type.
> I see it as being the task equivalent of rq->uclamp[clamp_id].value, IOW
> "give me the uclamp value for that clamp index". It just happens to be a
> bit more intricate for tasks than for rqs.

But then you have to take care of casting the returned value in
several places here and in patch 3

>
> uclamp_util() & uclamp_util_with() do explicitly return a utilization,
> so here it makes sense (in my mind, that is) to return UL.
