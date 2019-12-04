Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945F7C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6687D2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aA5tr65m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfLDR3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:29:24 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42151 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfLDR3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:29:23 -0500
Received: by mail-lj1-f195.google.com with SMTP id e28so197181ljo.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 09:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+G7wJcafPi1eNtK8kJ1Mqyq1RAqr5Lp6PNHCMBLKpY=;
        b=aA5tr65mbTONn73uxO8jVLu+vv1DFLLEf7HJELg9SkrOL9r5yuemcAXZ2Mbpk4AR7Q
         0XjEXmODor3qQCEkz2rRnEymeNYmv3oIgkx9M7eVE+T6U9VKL0/Im7Qsapwwlz3vtXUx
         rFwIyjFLzeAHnLfNFOac3tdqDDeP5itKIxU2Pzv5UVd1sivD0vZxA26cM7q1faPFGAcA
         3PPCq21xheUBFln/BMV8MiJQUFZMFnACiqYlSc31G3sSGZPIffboDakSKYupOEAa2S1Z
         8mHSBV5pCfFupm4LM4sdcpwnoWIT8iGWHR5Za4+zu+UI+bD9nhdwgq6TgOLUTo89TXCi
         Q6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+G7wJcafPi1eNtK8kJ1Mqyq1RAqr5Lp6PNHCMBLKpY=;
        b=jfE77fmGvwSuE6CmxRRM17ChQDjOsUq2K6zXaCyb0OhSajybu/tn/yHvx+dAIL/Ex1
         Y2MJb/vXRwZXYpfmnn/ayjGfptIFF8YpYmoae1CxmU/LnEtfCXFJCrBCKkhjuDRQOijB
         rPhKtlOaYRmetPcf9Chq/ofbPwBQ6cu0hKB9n+T9y8oN6pCmKz4jx8DjI7pkB/r0OV+H
         mK24+bvwpjchgrGlFagdFDvZmCyNXIoeA/LP2/eUckJuQUJwH2XGvTMfHXvG6ozsjiXi
         NAv4zlfyVKNHvBn9AUebvPZFPi7x857llIpRpIGzYDnn4aDgv3WEO4D58Wb5RYHnKaKu
         7J1A==
X-Gm-Message-State: APjAAAUPdwQuoZDAC6i5HZyeN0yibSJ+s24md/e4ukrSFh5xXAVLeTEo
        bQVtx58lirceuc83xQ/0Ui7si2xe+UX3ND7MUCObkQ==
X-Google-Smtp-Source: APXvYqw+LuPkKrEMdX9LcGT3iab9lrw0IgoyCucoUVTtFZgYiwEDME7HAO+MH80n4xpa196AfN26KiaTwodegMObrjw=
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr339657ljn.48.1575480561726;
 Wed, 04 Dec 2019 09:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20191203155907.2086-1-valentin.schneider@arm.com>
 <20191203155907.2086-2-valentin.schneider@arm.com> <CAKfTPtC-9nxGCAq8ck0Av6zuqCySvO87oP4hhBE=qKL3gxu+ow@mail.gmail.com>
 <7d6d959d-3767-1a12-4c80-e7d52a48c396@arm.com> <CAKfTPtA3ZLkNn4BEDctLo6VxvgHv_cvQSFx5N_+ERGToa+3FLg@mail.gmail.com>
 <2a244463-8010-ccf4-dc33-80831265ba9a@arm.com>
In-Reply-To: <2a244463-8010-ccf4-dc33-80831265ba9a@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Dec 2019 18:29:09 +0100
Message-ID: <CAKfTPtDg2_Yc98o9SpUjm-qZw3bQ8d_zFJ9PL31EnFy2u_4_mA@mail.gmail.com>
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

On Wed, 4 Dec 2019 at 18:15, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 04/12/2019 16:12, Vincent Guittot wrote:
> > On Wed, 4 Dec 2019 at 17:03, Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >>
> >> On 04/12/2019 15:22, Vincent Guittot wrote:
> >>>> @@ -2303,15 +2303,15 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
> >>>>  unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
> >>>
> >>> Why not changing uclamp_eff_value to return unsigned long too ? The
> >>> returned value represents a utilization to be compared with other
> >>> utilization value
> >>>
> >>
> >> IMO uclamp_eff_value() is a simple accessor to uclamp_se.value
> >> (unsigned int), which is why I didn't want to change its return type.
> >> I see it as being the task equivalent of rq->uclamp[clamp_id].value, IOW
> >> "give me the uclamp value for that clamp index". It just happens to be a
> >> bit more intricate for tasks than for rqs.
> >
> > But then you have to take care of casting the returned value in
> > several places here and in patch 3
> >
>
> True. I'm not too hot on having to handle rq clamp values
> (rq->uclamp[x].value) and task clamp values (uclamp_eff_value())
> differently (cast one but not the other), but I don't feel *too* strongly
> about this, so if you want I can do that change for v3.

Yes please. This makes the code easier to read and understand.

The rest of the patch series looks good to me. So feel free to add my
reviewed by on the next version
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> >>
> >> uclamp_util() & uclamp_util_with() do explicitly return a utilization,
> >> so here it makes sense (in my mind, that is) to return UL.
