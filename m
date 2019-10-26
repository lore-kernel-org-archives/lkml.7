Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241A6CA9EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDA621655
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="Yc3V8xSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfJZLHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 07:07:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40784 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfJZLHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 07:07:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id u22so6038143lji.7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbtSEwwWtUl8Tn9jW/5rYOk9dRDro0TFs9+gAIA3ZLY=;
        b=Yc3V8xSKcErzzkIufZvgIPdiVXiQAZg6sNPGdV25al2GzTWGRHqUnvyA4S7Ih5edyO
         yHxfaBIpIxrw9D815r6Jr1Bzx/+i/4rR27vBxJd8iBmgE0hOg3q/326eMB62jlWnaPCa
         Yfw7O3MR+77F1oM2DJA6ebAdq+4/0esKJnP4U0f9d5mnkKyCWC/WmkmOPoa52YXNbJKq
         9iwDZyH0M13Cp5qie3yaDgMbd66uiEv835NGad8aBVbcpOyStYf6yYaUuSgWssFQHW35
         rkJuaXJL2r5D0eGpRI7HG+5njgdQJ8tCTye+TfIdiM5yTY6T1DthrJ64fE4/jqnbd2TJ
         f4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbtSEwwWtUl8Tn9jW/5rYOk9dRDro0TFs9+gAIA3ZLY=;
        b=p6sgH5FHXFAXFjTXFEUM6nT4EppNJ4UtOHN88j5/vfkUnU48+kiKfrle/1yRUFkt4x
         H1e+uAZU4tBUqgOrOpOtGJi6JfXbiK4UcU31vyTDxRsr/8Sc0sl7lIbsc++3ol2IDety
         qHLcu14+6W2l0Kh1WG/+2qvUVj2mqvbrsSh7Py9lFCueNAB+nAt0KU6geLcFJahmt43k
         iG7dNdNnW9mPSrmQgdtNqpT8fPK4EVfCw5qFWyaKvd0eorbieLueSYu+vmHOLMN5vchx
         ACuR66Aehcnuw5fSmG0SzJgJ/VdkC4MFgUEHqSe0VkBOk8UUeBUIcBRS90pmZNjEayEJ
         b6dQ==
X-Gm-Message-State: APjAAAUnyrE2os5hcoSY8fERiQnSO+DvGZh81veGM2x9x2EHVEUWEFFM
        gEbE65m3JYKW02hdCJqr4CFEoX4K2AlAQVZPFEcyCw==
X-Google-Smtp-Source: APXvYqwXkiAvXf3Phu3iW0PDFeh83+cl9RW5ZrJMlkjn2TQBbmww5P/ERTPtEJdBkEaAkIJlw1hVNf54K6j0BkUc+Qg=
X-Received: by 2002:a2e:8856:: with SMTP id z22mr5727263ljj.78.1572088034673;
 Sat, 26 Oct 2019 04:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191023001206.15741-1-rajatja@google.com> <20191024112040.GE2825247@ulmo>
 <CAA93t1ozojwgVoLCZ=AWx72yddQoiaZCMFG35gQg3mQL9n9Z2w@mail.gmail.com> <20191025113609.GB928835@ulmo>
In-Reply-To: <20191025113609.GB928835@ulmo>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Sat, 26 Oct 2019 12:07:00 +0100
Message-ID: <CAPj87rNe20nFcFNcijFwOZLQU_E+C2HyzEjtigJ-ehiLCq42iA@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH] drm: Add support for integrated privacy screens
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rajat Jain <rajatxjain@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@google.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rajat Jain <rajatja@google.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, jsbarnes@google.com,
        intel-gfx <intel-gfx@lists.freedesktop.org>, mathewk@google.com,
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

Hi Thierry,

On Fri, 25 Oct 2019 at 12:36, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Thu, Oct 24, 2019 at 01:45:16PM -0700, Rajat Jain wrote:
> > I did think about having a state variable in software to get and set
> > this. However, I think it is not very far fetched that some platforms
> > may have "hardware kill" switches that allow hardware to switch
> > privacy-screen on and off directly, in addition to the software
> > control that we are implementing. Privacy is a touchy subject in
> > enterprise, and anything that reduces the possibility of having any
> > inconsistency between software state and hardware state is desirable.
> > So in this case, I chose to not have a state in software about this -
> > we just report the hardware state everytime we are asked for it.
>
> So this doesn't really work with atomic KMS, then. The main idea behind
> atomic KMS is that you apply a configuration either completely or not at
> all. So at least for setting this property you'd have to go through the
> state object.
>
> Now, for reading out the property you might be able to get away with the
> above. I'm not sure if that's enough to keep the state up-to-date,
> though. Is there some way for a kill switch to trigger an interrupt or
> other event of some sort so that the state could be kept up-to-date?
>
> Daniel (or anyone else), do you know of any precedent for state that
> might get modified behind the atomic helpers' back? Seems to me like we
> need to find some point where we can actually read back the current
> "hardware value" of this privacy screen property and store that back
> into the state.

Well, apart from connector state, though that isn't really a property
as such, there's the link_state property, which is explicitly designed
to do just that. That has been quite carefully designed for the
back-and-forth though.

Cheers,
Daniel
