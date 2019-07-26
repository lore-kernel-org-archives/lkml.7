Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256B4C76194
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 01:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AFB2238C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 01:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cp2ZutT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfGZB5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 21:57:05 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43197 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGZB5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 21:57:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id w79so39182708oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 18:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0ptnVs6ufwHdUe2bXDnes7rPX5LPCdAZDTAzLOU0mg=;
        b=cp2ZutT6OZJivqpOFZ5qv8yYQljKChM6RQaGffj7XyAYlw5jqK5uHaRUMjLhG/TqBp
         ZsEqS9W32J1vvPOEWcWJlrz+vmTiGM3btTV2LemgpW12edItyRa2BpTC2IIdDNZCxjCx
         hTM3qv+H7nfMnq9y3L4APNfSITDXwvPvCdLjjchQ/ZIXA/zkEq8vKgXT4SAOKEjA8jqj
         gJ6jPffwDMF+PlrXCQES1f5RsfjI0d0l95oxBvscRIvdmTv8u9Xr0pTbcc9FqRDc1s9A
         VcAZksUMHExU196JOxNPyIZ3hTzmJGZN+20te/DUq6tCQchAYgHeMV9o0zzzPP1QG2pP
         Km3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0ptnVs6ufwHdUe2bXDnes7rPX5LPCdAZDTAzLOU0mg=;
        b=P+XU/3zzKfoWMKCZt6ThzttO4vBTzM+tk7rNg/YqEehJzitNlzx5vTDm/RpBAF9GSX
         nWKV7l1wg8WcryNl4aM0a1k2x4YD4RafeRii3oi5vRn8AVhi04zSQ9LTgyyYuansbNmO
         osC6e+FoP2T7GA1t0rqymWall3IK2MG+8NXiitoftDHuY1yGAOwYv1hA2Fo8W0PGhgcr
         ZsjsCQVYzRLdObrqPGw6HFt3nVmjRLji/nI4KCEiN7xA+CCAIwWbKtWjFY7wwfl1aUcC
         uJFc9UmI78NU8SWzHp1A3E7+2Zjo1MGaAEqZZiMtiJFWlpGVeQBDYo2bQSSJjqMf9M7e
         ROrA==
X-Gm-Message-State: APjAAAUOrTFapKwZ5V7mPG4QMed29Cse6bGrG426c6WsL9OVPyRXEPvX
        vkP1N/AQguIHAFiAO/0L+iMdkZCkn9zst9RQWPWBdA==
X-Google-Smtp-Source: APXvYqyDyd5ROlTv8OSC4BboxrM2M+E2lZlC4AR+6tYCydL7ELU5Y56k4Cyf9dH/zfTQv7O4F36NVazwT6wvBETh2+E=
X-Received: by 2002:aca:d8c2:: with SMTP id p185mr46769844oig.30.1564106224182;
 Thu, 25 Jul 2019 18:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190724014222.110767-1-saravanak@google.com> <20190725023050.7ggjbwsthoxpkexv@vireshk-i7>
 <CAGETcx_ZHXkjZMBhO8YTW2fMyVqmsj8f9F8d6oJTn=NmRL1q=A@mail.gmail.com> <20190725052229.znf6asnvl44rjqxg@vireshk-i7>
In-Reply-To: <20190725052229.znf6asnvl44rjqxg@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 25 Jul 2019 18:56:28 -0700
Message-ID: <CAGETcx8VCFW6_XoFxRHkGj7gdHZvTOM4i6ee_EZVK0F7SvQG5g@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Add required-opps support to devfreq passive gov
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
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

On Wed, Jul 24, 2019 at 10:22 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 24-07-19, 20:40, Saravana Kannan wrote:
> > On Wed, Jul 24, 2019 at 7:30 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 23-07-19, 18:42, Saravana Kannan wrote:
> > > > The devfreq passive governor scales the frequency of a "child" device based
> > > > on the current frequency of a "parent" device (not parent/child in the
> > > > sense of device hierarchy). As of today, the passive governor requires one
> > > > of the following to work correctly:
> > > > 1. The parent and child device have the same number of frequencies
> > > > 2. The child device driver passes a mapping function to translate from
> > > >    parent frequency to child frequency.
> > >
> > > > v3 -> v4:
> > > > - Fixed documentation comments
> > > > - Fixed order of functions in .h file
> > > > - Renamed the new xlate API
> > > > - Caused _set_required_opps() to fail if all required opps tables aren't
> > > >   linked.
> > >
> > > We are already in the middle of a discussion for your previous version
> > > and I haven't said yet that I am happy with what you suggested just 2
> > > days back. Why send another version so soon ?
> >
> > I wanted you to see how I addressed your comments.
>
> Sure, but that is just half the comments.
>
> > It didn't look like
> > you were going to make more comments on the code.
>
> I posted some queries and you posted your opinions on them. Now
> shouldn't I get a chance to reply again to see if I agree with your
> replies or if we can settle to something else ? I only got one day in
> between where I was busy with other stuff and so couldn't come back to
> it. Please wait a little longer specially when the comments aren't
> minor in nature.

Sorry if it came off as trying to rush you. That wasn't the intention.
Just some misunderstanding on my part.

> Anyway, lets get over it now. Lets continue our discussion on V3 and
> then we can have a V5 :)
>
> Have a good day Saravana.

Sounds good. You too Viresh! :)

-Saravana
