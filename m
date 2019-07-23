Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B6EC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0549521849
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BL1zhkUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbfGWUgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:36:41 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42972 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730380AbfGWUgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:36:41 -0400
Received: by mail-oi1-f195.google.com with SMTP id s184so33339534oie.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 13:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/2BGGrFh2KLC5qxtGNSu6iKrTWzABVeH6rFOx3c7Qw=;
        b=BL1zhkUPPRxU40lcrS8uiFDXE+2BGu9l8vsUdji2crvpvlihwTFnCFaONc/CM3nZ+f
         6sgtoSkf2YWktAl7/P+aU1k4z7V5yXaYQ2kOb8j4r5fi2LyqwQiOjUWHyrIWioWCL4Bs
         81pw6zpZ5iETwRan/qS15wby7O/Aks2MjCm1+j0tIEqdT6jqBDDXAgqGnY+cAwKOTWSL
         oc5DNx3zubzmiP8dpeGOYZZu/Un6Lr6gO0U68bhBmOm7gWRpz3C6sgl8wJGVoegzWCM0
         M1l6y+DSuH8YHY2mifWrqjdF0tJodWFDASRV75XKcIRd+IfHEcXJ/f31HGcLizZeadfs
         EBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/2BGGrFh2KLC5qxtGNSu6iKrTWzABVeH6rFOx3c7Qw=;
        b=WZ9rf3fMGjlfRk3PcmpvUjYweFBdMFsIcRXB91zKzMAfho+eTFK9I3d2V5p6BrlWLZ
         AQ0LdMM+lcRmv3lm4aeYvMumWvbKTa+UY4/kH7Wr491Z3tx5AaYL6ykG4qrQczbArRMj
         byOugidWcly5C5NMkmL/pUQkR7qFUvh0sD1KFS9fs3fRID9tOv6Bb6f2dLpSAqQKV00Q
         vpDCF8zU6ZSGxT/VDX4SXMbmLg7s09HCOh8uHU+W1vBVBFxZMYznIuoPmUYzt5ald7GW
         e9b4OwjloAZYHzC/9PTirT8dPQQxF6zBX0ehfArkXK3Q2Jh2o6FLJ2+rUle+k1mBqX3O
         flpw==
X-Gm-Message-State: APjAAAVEymrcdsXdBJv0X4H68+6cUaCJktWnZVaxqErkBPx3L46YCiWL
        8OODt3XJvpNXAkbd01aQUyoazfhyNcbzkyZubuSm6Q==
X-Google-Smtp-Source: APXvYqy9VJmbWkvDpT4M3SIpbRF3dqdqe5Zhd/hh5ShO8VLur1e+DBTTOISx8N1NpvX5A+GHQD6ltf1BojILtrZcglM=
X-Received: by 2002:aca:5106:: with SMTP id f6mr40545168oib.69.1563914199859;
 Tue, 23 Jul 2019 13:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190717222340.137578-1-saravanak@google.com> <20190717222340.137578-4-saravanak@google.com>
 <20190723102842.t2s45zzylsjuccm4@vireshk-i7>
In-Reply-To: <20190723102842.t2s45zzylsjuccm4@vireshk-i7>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 23 Jul 2019 13:36:03 -0700
Message-ID: <CAGETcx_4N8uBbA0yhMdcTHpw_DkMVqQwbZeSDTLOzR7t-uZnVg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
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

Resending again due to accidental HTML (minor rewording/typo fixes too).

On Tue, Jul 23, 2019 at 3:28 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> $subject doesn't have correct property name.
>
> On 17-07-19, 15:23, Saravana Kannan wrote:
> > Currently, the linking of required-opps fails silently if the
> > destination OPP table hasn't been added before the source OPP table is
> > added. This puts an unnecessary requirement that the destination table
> > be added before the source table is added.
> >
> > In reality, the destination table is needed only when we try to
> > translate from source OPP to destination OPP. So, instead of
> > completely failing, retry linking the tables when the translation is
> > attempted.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/opp/core.c | 32 +++++++++++-----
> >  drivers/opp/of.c   | 91 ++++++++++++++++++++++------------------------
> >  drivers/opp/opp.h  |  5 +++
> >  3 files changed, 71 insertions(+), 57 deletions(-)
>
> Here is the general feedback and requirements I have:
>
> - We shouldn't do it from _set_required_opps() but way earlier, it
>   shouldn't affect the fast path (where we change the frequency).

I don't think there's any other intermediate OPP API call where we can
try to lazily link the tables. Also if the tables are already fully
linked, I don't think this is really going to slow down the fast path
in anyway (because it's just a few NULL checks).

If you have other ideas, I'm willing to look at it. But as it is right
now seems the best to me.

> - Programming required-opps for half of the properties isn't correct,
>   i.e. in case only few of the required-opps are parsed until now. So
>   setting of rate shouldn't even start unless the OPP table is fully
>   initialized with all required-opps in it.

Ok, I can fix this.

-Saravana
