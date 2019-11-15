Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3896CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103242073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDgIcJLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfKORee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:34:34 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42908 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfKORed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:34:33 -0500
Received: by mail-lf1-f66.google.com with SMTP id z12so8594177lfj.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 09:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ob7v0delE9hF5IjnpciylaxsHgiyCTAShfoWSacSSgw=;
        b=KDgIcJLlOfA16OCon6Z/fnTDxf5Hx/uL9ZYdgTNeIoPQZG/u+MvP18i0bmblAIuExh
         4AhKsHBDQh6VUHdbygHk9mz+C5h3N3CWjlwZC57gwE+cfkZl1eiBi5dyC09D6zbjpPjf
         iS9A0SVtb/NOzxG7A+3o1on46xVC53jddwAGrhUBDqcDHQ2AEJpwyGCC1z7i83/Xy5vo
         9EwZVDwuC0/WghTAsNmgD1o5TjRX1aeTioeigTJkPagCDi6ey/mtIMqf3Smcev8m83ao
         nB5kVyStCp+CqAJIOYVmcYpjCrCy+5jt/IgnA1P1lPWd4zP0sPrTSZAwNtriqpyw4LpQ
         L1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ob7v0delE9hF5IjnpciylaxsHgiyCTAShfoWSacSSgw=;
        b=Ahj3u3aORnBPFl+k/oJKaIYzClWiJCBoknvUN748lolwbiIfECBDCNr/7lnuEkBEjM
         l4E7YffbEBkEO9ql3FoFusVtXZ7/VWWqKvWi2wQRI5LVZyX1m/Fba9blGJCDOXvysVro
         qzSoyfvBYvsriSADl+e4ThPRljLKCa057BfR9VgapkU9KrHQBaB+JyGjKnpQSARZVmfL
         In/p/DdHX6d1xMfkwGNIK6a16BsAC9TnPcK8N/TDa/2uO14wNYALYwVj5gv5QfWRRqGg
         dIkA6qcxJx/QnTwq2mGiJu561bYfFkK8ossFecjgO/ZXWVINvPSgK8j6qlDwuR+gvkGN
         brBA==
X-Gm-Message-State: APjAAAU+9IQ0eZgyDbkY1lKGZCDh6Hdcf2fVdfqAzBAO3FvGn6MAMnHJ
        D32Am4DkK61cAncYpPB+wDm+2SlPpTFZV1JRy2Jvww==
X-Google-Smtp-Source: APXvYqy6qUDlT5tIUktBfN6U2sV8LoddiJGr9y2R0ycD7PUF/PmtM+sqDzJmtRIiTxo3gqDWHc0asV3fnwMWX0LgORc=
X-Received: by 2002:a19:ed12:: with SMTP id y18mr11692306lfy.151.1573839271518;
 Fri, 15 Nov 2019 09:34:31 -0800 (PST)
MIME-Version: 1.0
References: <20191115103908.27610-1-valentin.schneider@arm.com>
 <CAKfTPtBoi_5sUiGrTpYuV_u2vPkBK+caUzgaKxY3Ck3PKJXZiw@mail.gmail.com>
 <f4fcc45e-7609-3836-162a-0a1839134bcf@arm.com> <2dce8a83-b358-d975-bf43-8088b3bc5557@arm.com>
In-Reply-To: <2dce8a83-b358-d975-bf43-8088b3bc5557@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 18:34:19 +0100
Message-ID: <CAKfTPtCvt7BZ8g2sC3j=uoN-8nXfwRDGaO06xtHN0O+d8u5MQQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/uclamp: Fix overzealous type replacement
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Tejun Heo <tj@kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 at 18:10, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 15/11/2019 14:29, Valentin Schneider wrote:
> > On 15/11/2019 14:07, Vincent Guittot wrote:
> >>> -static inline enum uclamp_id uclamp_none(enum uclamp_id clamp_id)
> >>> +static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
> >>
> >> Out of curiosity why uclamp decided to use unsigned int to manipulate
> >> utilization instead of unsigned long which is the type of util_avg ?
> >>
> >
> > I didn't stare at the discussion much, but I think it stems from the
> > design choices behind struct uclamp_se: everything is crammed in an unsigned
> > int bitfield. Let me see if I can find some relevant mails.
> >
>
> So I think a relevant mail is:
>
> https://lore.kernel.org/lkml/20180912174236.GB24106@hirez.programming.kicks-ass.net/
>
> Other than that, the uclamp_se.value field was 'int' in v1 and has been
> 'unsigned int' for all following versions. uclamp_bucket.value is a bitfield
> of an 'unsigned long' just because we want more headroom for the tasks count,
> AFAICT.

Thanks for the pointer and deep diving in the email threads
