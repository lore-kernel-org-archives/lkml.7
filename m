Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF4DCA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 17:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BDC21655
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 17:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eyLk4QNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfJZRTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 13:19:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38338 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfJZRTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 13:19:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so3123981plq.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XJ2OTe+YJhZKDPOKv2vH6Q6K0N8s/caGH/kB608TKt8=;
        b=eyLk4QNAvuzO/V4qc5beDIpydWz0nT1Z7PbayMVwyIxnU48/j0WH6rDiGC60Rm/K98
         aCDKNmnmTd9UDDrUpdqZ2cdo1AvA/F07bWJgiN9HOD9eALRWv85Zi/NQCdabmHFxOnT7
         AKzgjCtSK9D8lWUKV3je5GJoddOmxB4dhlIdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XJ2OTe+YJhZKDPOKv2vH6Q6K0N8s/caGH/kB608TKt8=;
        b=VrkCc28pAmV+jW0B5eFvwmRcGyyfarOlEjbfH1Q8SWhH+F64WafRb/VFej9MkW3VdC
         7grkqJ4NZtyps5A+uKqxTXOWqFjiKiZduf2/5rYF3pBC2HxikYXstLHOxcqda641TZ3v
         idzZHWy6YhkoYy2lcQAC9QL0smuA7NxiBzDtBkrTwh21bTpHG6Qkx7nzJPF75RR7Y1nr
         eDt77lr7LgJnnf8E0DBguvX8MSDtEGUUQahXaQKqARVPpGNvpAPwP++3d19wGgnExnXl
         P3HCyKmTHuJZNhhZk7P5WONB2iNUL6X4HgQikvCJirIY5HEwMkUiQ6NYBjJBmopCMBFO
         Wa/Q==
X-Gm-Message-State: APjAAAW/Jiv8XxQ6/6J1oQGHh48Ro/dnywj9OZ4TOZAMiAhfjtttcGYv
        dxaL7AXwuaiKzIaQMbh0UKzQMVRWJC65h0bP7rd8Dg==
X-Google-Smtp-Source: APXvYqxVqfwJ/ddt02LfEd8cvon5v+MggvIiTlWYGWcVUPPJDQOWOIQhls1waYXlhWsELgoeWEiG1pcJ8N4muKqlxnU=
X-Received: by 2002:a17:902:864a:: with SMTP id y10mr10096482plt.162.1572110347046;
 Sat, 26 Oct 2019 10:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191023001206.15741-1-rajatja@google.com> <20191024112040.GE2825247@ulmo>
 <CAA93t1ozojwgVoLCZ=AWx72yddQoiaZCMFG35gQg3mQL9n9Z2w@mail.gmail.com>
 <20191025113609.GB928835@ulmo> <CAPj87rNe20nFcFNcijFwOZLQU_E+C2HyzEjtigJ-ehiLCq42iA@mail.gmail.com>
In-Reply-To: <CAPj87rNe20nFcFNcijFwOZLQU_E+C2HyzEjtigJ-ehiLCq42iA@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sat, 26 Oct 2019 19:18:54 +0200
Message-ID: <CAKMK7uGjd1CJ+XDWPQShV_fADC5ndxdf_ecO61K4VDi6EZyMEQ@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH] drm: Add support for integrated privacy screens
To:     Daniel Stone <daniel@fooishbar.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Sean Paul <seanpaul@google.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rajat Jain <rajatja@google.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jesse Barnes <jsbarnes@google.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Mat King <mathewk@google.com>,
        Maxime Ripard <mripard@kernel.org>,
        Duncan Laurie <dlaurie@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 1:07 PM Daniel Stone <daniel@fooishbar.org> wrote:
>
> Hi Thierry,
>
> On Fri, 25 Oct 2019 at 12:36, Thierry Reding <thierry.reding@gmail.com> wrote:
> > On Thu, Oct 24, 2019 at 01:45:16PM -0700, Rajat Jain wrote:
> > > I did think about having a state variable in software to get and set
> > > this. However, I think it is not very far fetched that some platforms
> > > may have "hardware kill" switches that allow hardware to switch
> > > privacy-screen on and off directly, in addition to the software
> > > control that we are implementing. Privacy is a touchy subject in
> > > enterprise, and anything that reduces the possibility of having any
> > > inconsistency between software state and hardware state is desirable.
> > > So in this case, I chose to not have a state in software about this -
> > > we just report the hardware state everytime we are asked for it.
> >
> > So this doesn't really work with atomic KMS, then. The main idea behind
> > atomic KMS is that you apply a configuration either completely or not at
> > all. So at least for setting this property you'd have to go through the
> > state object.
> >
> > Now, for reading out the property you might be able to get away with the
> > above. I'm not sure if that's enough to keep the state up-to-date,
> > though. Is there some way for a kill switch to trigger an interrupt or
> > other event of some sort so that the state could be kept up-to-date?
> >
> > Daniel (or anyone else), do you know of any precedent for state that
> > might get modified behind the atomic helpers' back? Seems to me like we
> > need to find some point where we can actually read back the current
> > "hardware value" of this privacy screen property and store that back
> > into the state.
>
> Well, apart from connector state, though that isn't really a property
> as such, there's the link_state property, which is explicitly designed
> to do just that. That has been quite carefully designed for the
> back-and-forth though.

connector state is an immutable property, which is a hilarious way to
say that "only the driver can update it, userspace only reads it". So
not a good template here. But yeah link_state is a good example of
what we need here.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
