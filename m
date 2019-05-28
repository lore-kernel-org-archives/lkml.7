Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823D6C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57396208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sjcsG/R9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfE1MXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:23:37 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:43620 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfE1MXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:23:37 -0400
Received: by mail-lj1-f177.google.com with SMTP id z5so17480759lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 05:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymG/kaexVio8Y+H8Sg1++5yggKsKosn6WTBAawQTRw8=;
        b=sjcsG/R9SOUmrIoO/4C+AklpCd2b8K4HcDXhJzE8GhUx4DK8S8KA8aF6U0hzEXl9qk
         8JvCCBmyrnqG0n7N8lhm9uivH2hDdqb6onYTDzoE+NFwrFgBF9fmv1y5WLyxDfizxwOB
         DZp7KDYA5p0jVXJNWQJhHF7ljiEGm7ljliAJsVZDwv30GPFKWu8ENz9grWGdMF2U3fjp
         x61PSSFKUgz5OXlkzq7IXezVQVyyE9w20yj9FIjnTngHrNBBFuzSljElG8GLH10jR9LI
         iY0NjXK6Xf0PXyIUAvg79HsL98OL3W5l2rjcNA7/riu2RcZ2En4NIcMSSUmgG2UooZkG
         V/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymG/kaexVio8Y+H8Sg1++5yggKsKosn6WTBAawQTRw8=;
        b=dDDFGfEiRawYrAaePy0MODWEsem0Xby4fyXjbSWMrJZqCwcVUDpGo7jw1RiVenKGha
         +8P/1LsKwH2/WsOpGnx5Y5YZylTbodz2daU52PB/1zqyQl7Yaoemsy51la5Kc54sFMxj
         E/dt5Mut25Rk+DnjX17Pqu44qudVjIt+3Hoxov/plE4caX0J0l8BxBEjybrwe63++3Vn
         kZt0uNB4cmSEgUOPppnqAa1x/wjQzQ4ufLMNkWM2MMCKribUVkrXsd4ddFhN5ePSvfTL
         EucEGGEieBmkJkb8nLb6I2Tz5Dk7lid4FDqj1Oc66CuNaPpbCBvPLkoKOYTyapeRMjml
         kaKA==
X-Gm-Message-State: APjAAAXXCtjLi5qYg+DhibsalYnybSHdg47yvAtoj3B2/zg+GiZRcKCQ
        8dIK7Nds+4RzJS2+0EQFUsIO8ESF1mBcUgqm2NaowQ==
X-Google-Smtp-Source: APXvYqyJ02wwCyQ8eiKTSbWS6OLDxuQmUnrfb+73pJjp7xH0SNE6BIax5LQq2o0IHRXQPJKugcdAsM+DTQGnGXhdKLk=
X-Received: by 2002:a2e:86c2:: with SMTP id n2mr32026124ljj.23.1559046214980;
 Tue, 28 May 2019 05:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuC8dgKs04HmyCaKeQ_xwqKBxnh=zsOFjQK+3Fq7AZRyw@mail.gmail.com>
 <5de0df37-f0d0-f54c-2eef-a7533cbe7a25@xs4all.nl> <CA+G9fYtbb82EPY9gG63+U2FTVswt7f3FjHdaHMA2kibxgVvZcw@mail.gmail.com>
 <CA+G9fYu-guJaWDrEp5=KeJsje6Teo-V=_AhFStf0gnLk-QNfzA@mail.gmail.com> <29b08b95-ae5b-2989-8f09-93fe702aef29@xs4all.nl>
In-Reply-To: <29b08b95-ae5b-2989-8f09-93fe702aef29@xs4all.nl>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 28 May 2019 17:53:23 +0530
Message-ID: <CA+G9fYuLsDQSFMJAjWXAORvQhww6EW8uL9zKYtidO9E6MnxxQA@mail.gmail.com>
Subject: Re: test VIDIOC_G/S_PARM: FAIL on stable 4.14, 4.9 and 4.4
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        paul.kocialkowski@bootlin.com, ezequiel@collabora.com,
        treding@nvidia.com, niklas.soderlund+renesas@ragnatech.se,
        sakari.ailus@linux.intel.com,
        Hans Verkuil <hans.verkuil@cisco.com>, mchehab@kernel.org,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Tue, 28 May 2019 at 17:27, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
> >>>> Do you see test VIDIOC_G/S_PARM: FAIL on stable 4.14, 4.9 and 4.4
> >>>> kernel branches ?
> >>>
> >>> Probably related to commit 8a7c5594c0202 (media: v4l2-ioctl: clear fields in s_parm).
> >>
> >> I have cherry-picked on stable rc 4.9 branch and tested and test got
> >> PASS on x86_64.
> >
> > I have cherry-picked for stable -rc 4.14 and 4.9 and test got PASS.
>
> Just to be clear: you cherry-picked commit 8a7c5594c0202 (media: v4l2-ioctl: clear
> fields in s_parm) for both 4.9 and 4.14, right?

Right.

>
> If so, feel free to post that patch to the stable mailinglist for those kernels.
> Make sure you CC me when you do that.

Alright I will do that.

> > do you want to queue this for stable rc 4.14 and 4.9 ?
> >
> > I have tested for 4.4 with patch applied but failed with below error.
> >
> > test VIDIOC_G/S_PARM: FAIL
>
> You probably need commit f63998331935 ([media] vivid: set V4L2_CAP_TIMEPERFRAME)
> and possibly commit 3f122df4a2ba (media: vivid: do not implement VIDIOC_S_PARM for output streams).

Thanks for suggesting few more patches.
I will apply these patches and test.

- Naresh
