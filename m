Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F69C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C136920730
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YV085ZOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfL3Tde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:33:34 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34308 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3Tde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:33:34 -0500
Received: by mail-ot1-f68.google.com with SMTP id a15so47427117otf.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 11:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9mNn9nURZI+7bF8xI34SvARdK0zc98BlyBAff05Zwow=;
        b=YV085ZOOvhc6d7lXQ0SBArTWIZoH8sYIamOti1KC9sHJJJ+d/rvFCoE55WfIvMkNNP
         OSD298oJWMMz/40hbSmOxuUqPIVB+eBibxKww9917VHEsbn3sSamO4XvE6a6L7YyeuFt
         GSGpITqm8hPZVEOetsAKoF7x54l97GAa6AtLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9mNn9nURZI+7bF8xI34SvARdK0zc98BlyBAff05Zwow=;
        b=gE/29EfzieZMRgVgD3tBl9gmGuyOkUe3hC9Gl7v+DHZoFEnYPUytWlq8A9EVjxDhC2
         MjJ0Ye3CyZuS84eZUd6oDQ0wkPrPOKjycUJs7MBcnSMn+EbZM/raV1dJAw+zAgwyCZwC
         U3SERhiTkJOmpb/biS0i1eQ0uVQfutZFf/3DlcLwBiyR1xcLWjpXC652ApLtobeNRiBP
         gt1undKCMHd58y7OWn1NQxVOjnFeV0J7JRySnaDqqH33DmOe8EygUyqycyoLAyiXf+oz
         Ekh94hur7J6o+Do2/1Adz+gLlAAugky8O/C9D/NL+Uqptw8EegqHE8NBJNauctSiRo4j
         9sgg==
X-Gm-Message-State: APjAAAXdetkVRQwehK6/v0efhZzCmsc6qyx0cv0LSOgyCetcRbsCPprl
        b6y2xTdRD6vp/r7xyGR6RNn1Yg==
X-Google-Smtp-Source: APXvYqyNoTK/EBegjIbIVpgtIGqEsgAPyx26q0BAOQObqFaX7RqA6Ux749p7HJwSPup6gF+Ww3bYog==
X-Received: by 2002:a05:6830:2099:: with SMTP id y25mr73259465otq.87.1577734413863;
        Mon, 30 Dec 2019 11:33:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z12sm16083437oti.22.2019.12.30.11.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 11:33:33 -0800 (PST)
Date:   Mon, 30 Dec 2019 11:33:31 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v2 1/2] samples, selftests/seccomp: Zero out seccomp_notif
Message-ID: <201912301132.5C97DD231B@keescook>
References: <20191228014837.GA31774@ircssh-2.c.rugged-nimbus-611.internal>
 <20191228181825.GB6746@cisco>
 <CAMp4zn91GoB=1eTbc_ux4eNs2-QFm+JocodgFQYUiiXL7H4m9w@mail.gmail.com>
 <20191229001818.GC6746@cisco>
 <CAMp4zn9s1wJyb9xHj4xYL5HTtM=gA07ZfBGTSW5j4ayUzaoZNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMp4zn9s1wJyb9xHj4xYL5HTtM=gA07ZfBGTSW5j4ayUzaoZNQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 11:14:44AM -0800, Sargun Dhillon wrote:
> On Sat, Dec 28, 2019 at 4:18 PM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > On Sat, Dec 28, 2019 at 07:10:29PM -0500, Sargun Dhillon wrote:
> > > On Sat, Dec 28, 2019 at 1:18 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > > >
> > > >
> > > > I know it's unrelated, but it's probably worth sending a patch to fix
> > > > this to be sizes.seccomp_notif_resp instead of sizeof(*resp), since if
> > > > the kernel is older this will over-zero things. I can do that, or you
> > > > can add the patch to this series, just let me know which.
> > >
> > > I was thinking about this, and initially, I chose to make the smaller
> > > change. I think it might make more sense to combine the patch,
> > > given that the memset behaviour is "incorrect" if we do it based on
> > > sizeof(*req), or sizeof(*resp).
> > >
> > > I'll go ahead and respin this patch with the change to call memset
> > > based on sizes.
> >
> > I think it would be good to keep it as a separate patch, since it's an
> > unrelated bug fix. That way if we have to revert these because of some
> > breakage, we won't lose the fix.
> >
> > Cheers,
> >
> > Tycho
> 
> As I was doing this, I noticed that the self-tests all use hard-coded struct
> sizes. When I was playing with extending the API, all of a sudden all the
> self-tests started failing (until I recompiled them against newer headers).
> 
> Should we also change the self-tests to operate against the seccomp
> sizes API, or was it intentional for the self-tests hard-coded the struct
> definitions, and locked to the kernel version?

I intend the seccomp selftests to be kernel-version tied, but I'd like
them to fail as gracefully as possible on mismatched kernel versions...

-- 
Kees Cook
