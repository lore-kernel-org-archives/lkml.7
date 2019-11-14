Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEB7C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB57420729
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hHhiugik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKNTjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:39:44 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40237 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfKNTjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:39:43 -0500
Received: by mail-oi1-f194.google.com with SMTP id 22so6384464oip.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 11:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qaQkNh+GwkOF+p4ly8ErfnaN1DdWL0XCLZl3cfnx0U=;
        b=hHhiugikMlvmnXY5OlPpArh17lbPea4isMp4gtfpQVX0k1giOLMErHW7H/USxzM3h/
         jOQcKrFZNTOTuT+89N0iSB1mRtJRzmb60d2eKp8TGgbav6sVp7nnwOV4PtWkU6oydc3p
         iy80YEdHK54gK3kWYSJOOOgumGhCXZB+Gt9f1n0Wlv1anT2AbI4d4NJDzagXxEUr7EGr
         RyPk20WvXOee+EYrxxcZDcM8c757d8l8vlwKKer+SnXUSBJa3MgEj0SMw7r6Kv7vQ+O3
         jJm01sKIsxqgYKTeJ/yS0eGvLjTXI4mSI+xzujNOGtlrW9v2ASsZUAWsRvuc/wk2e7/i
         9QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qaQkNh+GwkOF+p4ly8ErfnaN1DdWL0XCLZl3cfnx0U=;
        b=SG1tgQctgZDLFzgvESNE4316a49Z60uyubzQJBmWT5dIHHO9jgsDCdHjpafEaufF1Q
         WKbKul6zHA90Mkf0uGZozi/UuiWyGycA0VBIWasDzXWJEgCE1a0Tb5W+z9GBNKE5KQ75
         BsB6ZvG6eMwvZru7OwmcnGeICJMgyuS2KsfeZ0X1BzEXf+8vJuI5hVZqhh3fgXwAbl7H
         axAE4GQgN1qoueDW2wIesbh4jibnAnHuIo189xr7JTvSElZvRwh+6DOqG7b9uJfiO1Gt
         GhdEqrtYxl6Ow+X9U2BvTSXK/ZI+NKkBEsDMY0+SsTgB1n03LKTGzQtgBGlpCp3AFV7I
         xUkw==
X-Gm-Message-State: APjAAAVvn1BJNlGTvkgGi+JCx6kE01zHDwDMpYmY3ajmTxtH58kdKSfK
        JLJvz4AHdQ6++2DvASV0wEPiRfq4lawRfUJzJzDSWQ==
X-Google-Smtp-Source: APXvYqx3fXNqkZI16D4D5lPb7+21HLSvnaDSZr50dgUF+ElE4iLArszfeHeTjd+60PQkHrdyr4vkZoVyG160Ab8Cb58=
X-Received: by 2002:aca:d558:: with SMTP id m85mr4669663oig.43.1573760382147;
 Thu, 14 Nov 2019 11:39:42 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190724014230epcas5p371a5fdee330f91a646d619fbcc024acf@epcas5p3.samsung.com>
 <20190724014222.110767-1-saravanak@google.com> <cb0d4aad-81e4-0b8d-40f2-7f58ef1e38d9@samsung.com>
 <CAGETcx-tUtnX0T47YGdf7-cgp6e8K9Rgb34Mfe5Za9L4YMGS1g@mail.gmail.com> <20191114083532.vmccmqgj2uj73tcn@vireshk-i7>
In-Reply-To: <20191114083532.vmccmqgj2uj73tcn@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 14 Nov 2019 11:39:06 -0800
Message-ID: <CAGETcx9ccBgH2cjHMuecLRNJzTZTC_WZSGiWT-476Dqf2vADkQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Add required-opps support to devfreq passive gov
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 12:35 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-11-19, 00:23, Saravana Kannan wrote:
> > Thanks for checking. I haven't abandoned this patch series. This patch
> > series depends on "lazy linking" of required-opps to avoid a cyclic
> > dependency between devfreq and OPP table population. But Viresh wasn't
> > happy with my implementation of the lazy liking for reasonable
> > reasons.
> >
> > I had a chat with Viresh during one of the several conferences that I
> > met him at. To fix the lazy linking in the way he wanted it meant we
> > had to fix other issues in the OPP framework that arise when OPP
> > tables are shared in DT but not in memory. So he was kind enough to
> > sign up to add lazy linking support to OPPs so that I won't have to do
> > it. So, I'm waiting on that. So once that's added, I should be able to
> > drop a few patches in this series, do some minor updates and then this
> > will be good to go.
>
> I am fixing few other issues in OPP core right now and lazy linking
> is next in the list :)

Thanks Viresh! Glad the offer still stands :)

-Saravana
