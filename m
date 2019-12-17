Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C61EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B1920716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6cRBpaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfLQT6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:58:40 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39904 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfLQT6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:58:40 -0500
Received: by mail-qt1-f194.google.com with SMTP id e5so8413601qtm.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 11:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYpIdpOiYgT7YABZMBUVi67PMv1hgfpKwI/wpxaTacE=;
        b=m6cRBpaDvz9tOeWbO2fsQxnxrt9Vn1dx9HXLEVDsE6wcamkzk29SFwF+bDkNrGMD8s
         W8YvksQPx8HNXubuCQDtfzL2mcTDyp+Ou5/4A5GsnhYzaCBlbwzICa/40dja5PQ3cgqo
         x4ICttKdfw1eoaSYnNOAHvArBsaWnNIakTFpPpqBTuJ9pylELxkrTCCWMlHql7WvH/XR
         bZscXDu97ct+mnSatyr0KnK04gy13fOp1GHv1qe5k5beoky6gxgU6Vlm26GhLyQ9d6LW
         yuBNxP6hheOAsgr/5i39wNpHpxteytjnGgF2czeOOSRkcoO45rsGdQmaxvbYIyM7LdJe
         v7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYpIdpOiYgT7YABZMBUVi67PMv1hgfpKwI/wpxaTacE=;
        b=FGaYor/uwzsxB44YeuPcuM5jiawRi4p2+GcpXP7pc+Bu5bH1l53xD475Wkv2XANqRF
         k4jNL1ifW8CrizWzZbo6X2mdrGh8qrKT6fW0hdlRm/QkvDQtgbItAT1ROpMKUdvTQgzf
         0/3RSyGHt5VrsRhAKp9F30AUiZwVxErWN47AQ7KIOd/K0AIQTBxuUCmpdBFGrYwtvL1K
         jQp9yVm1a3NEa447F3Zegp6gNCfCwHncOWqWhn4zcox7yRuce0tw/wAOZwoVqUlNN8Y4
         gfmGk4zrrpB96bVFVHBSKxUkiuAFOfOU4gyMbozMHbr9ucxbRoSw2bnQYMy3LJFUFiJP
         Epaw==
X-Gm-Message-State: APjAAAVrfjKfpIlXMtzeA597G7LLcbxllpTEqFoGJ/C2veIIk2q0SeKa
        9y587l/U5hhtRw/111rF1s2AKoikK6tVUI228sBiaw==
X-Google-Smtp-Source: APXvYqxIhLNEjgJvec+Qn4qoV4ymCiJa4bYCuhFfS95jZ4mtrlZxnKh6hRW9zBdVP3eoHJjlkw34TnaQfZQL1P//WEE=
X-Received: by 2002:ac8:2b29:: with SMTP id 38mr6124609qtu.238.1576612719148;
 Tue, 17 Dec 2019 11:58:39 -0800 (PST)
MIME-Version: 1.0
References: <20191204200623.198897-1-joshdon@google.com> <CAKfTPtBZUUtJ=ZvQOWmKx_1zUXtNoqcS0M85ouQmgi36xzfM2A@mail.gmail.com>
 <CABk29NsCjgMVf-xrhpyzFBTpyTvyWxZc4RJSarnHVzdOXyVPMw@mail.gmail.com> <CAKfTPtCJGT0axT5=E=hLWtMav_kLGVFrSvjZS8+cfvjYS72vqQ@mail.gmail.com>
In-Reply-To: <CAKfTPtCJGT0axT5=E=hLWtMav_kLGVFrSvjZS8+cfvjYS72vqQ@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 17 Dec 2019 11:58:28 -0800
Message-ID: <CABk29Ntp5eRFn2otK2o5Fe=uYOvKpjHgKRSw0_er45CVC025Pg@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Do not set skip buddy up the sched hierarchy
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 12:05 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Josh,
>
> On Fri, 6 Dec 2019 at 23:13, Josh Don <joshdon@google.com> wrote:
> >
> > Hi Vincent,
> >
> > Thanks for taking a look.
> >
> > > There is a mismatch between the author Venkatesh Pallipadi and the
> > > signoff Josh Don
> > > If Venkatesh is the original author and you have then done some
> > > modifications, your both signed-off should be there
> >
> > Venkatesh no longer works at Google, so I don't have a way to get in
> > touch with him.  Is my signed-off insufficient for this case?
>
> Maybe you can add a Co-developed-by tag to reflect your additional changes
> I guess that as long as you agree with the DCO, it's ok :
> https://www.kernel.org/doc/html/v5.4/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
>
> Ingo, Peter, what do you think ?

I could add the Co-developed-by tag if that would be sufficient here.
As a side note, I'm also looking at upstreaming our other sched
fixes/patches, and some of these have the same issue with respect to
the original author.  How would you prefer I handle these in general?
