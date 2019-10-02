Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52883C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245A621920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvcKcSJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfJBPZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:25:22 -0400
Received: from mail-yw1-f45.google.com ([209.85.161.45]:42591 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfJBPZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:25:22 -0400
Received: by mail-yw1-f45.google.com with SMTP id i207so6206296ywc.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bzfJFKZOgy9NAhPs1ajGEJPbZdxMVe17fWKmhbaFgfM=;
        b=uvcKcSJXyswHOLl870SnIfHmFhb6o1mt7COyznfinJxFb4sonb7CczbfuvZIwvfmpm
         MocxsyU9UHGJ77qF7hCNPcOfVaYqI+X0ZsHSqncCxMQIoK+qdMahsugpFV/AuC/Ds4B3
         YCiVsk4WXIul14D3Vf2U8+q9cche8AAdre6/rT6RoTDg7ljUTBudyI8PTlaXdlKEP3zD
         QSMJJizff/gskWTc53+HyCt2njjSQQ7nKSMGJVgGApf3BAcVAB8+Bj5eh9Ocwb+Wkm8g
         eAbGtKa/cUiy2cBQMubvbbVsuWn+eatIZa3bzzYIajeG4CuO8GYi/AGd3BO61LNBFA1l
         8gBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzfJFKZOgy9NAhPs1ajGEJPbZdxMVe17fWKmhbaFgfM=;
        b=IPtQJEeX+BQs0tOCALruZ7StRY7gpZW0HzMX+dHYI/w0fC6JvXixAJHrBIjVJLe3m4
         skn3O8KlWbkMXOVJDcoA8/LALqhRiOg2OAlo18uQkOOjBtvcFOUXqHYAf0xh5ze0MEUA
         Jof6hSsX9Pk0WS2u4O4kqA4hXPP+KCDGz/UNmA0JPdUIEOG4KJ0kmiGbKQDJWpFBDYtJ
         MlwbI8l/nCZ4xa7XQhGL7n4xGOAH46CvX4srr9+Ml93cFm0lVvZRExJBmSUn9sLyVJNT
         L0gC+6lxlm8hLShf7M9HsTVAZrniXk+hFaMUKRtWU1C+cGU20MBC2+gbPYqJCWORM09h
         QONg==
X-Gm-Message-State: APjAAAXIyed76R3ITVZO4+OPh7NdQkPeynD406yTpSj+eCHWrALXJ8I0
        WhIf2z6OmJIWHnoDZkEm5JlfSqb/lRj7xdA7zarvEA==
X-Google-Smtp-Source: APXvYqxTtzHcL4UU91VHsli8Wy64pVy/gzXSufMR1HGbRvVWwE+xaZKdgBgDlV8FG1Nd0s9cyXgwxHaoZQF4tLoS94A=
X-Received: by 2002:a81:a144:: with SMTP id y65mr2866880ywg.437.1570029920166;
 Wed, 02 Oct 2019 08:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
 <87h84rbile.fsf@intel.com> <20191002102428.zaid63hp6wpd7w34@holly.lan> <8736gbbf2b.fsf@intel.com>
In-Reply-To: <8736gbbf2b.fsf@intel.com>
From:   Mat King <mathewk@google.com>
Date:   Wed, 2 Oct 2019 09:25:09 -0600
Message-ID: <CAL_quvQkFjkBjJC5wH2t5XmyEq9OKWYSbAv39BJWT1hrKO7j8g@mail.gmail.com>
Subject: Re: New sysfs interface for privacy screens
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        rafael@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Ross Zwisler <zwisler@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 4:46 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Wed, 02 Oct 2019, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > On Wed, Oct 02, 2019 at 12:30:05PM +0300, Jani Nikula wrote:
> >> On Tue, 01 Oct 2019, Mat King <mathewk@google.com> wrote:
> >> > Resending in plain text mode
> >> >
> >> > I have been looking into adding Linux support for electronic privacy
> >> > screens which is a feature on some new laptops which is built into the
> >> > display and allows users to turn it on instead of needing to use a
> >> > physical privacy filter. In discussions with my colleagues the idea of
> >> > using either /sys/class/backlight or /sys/class/leds but this new
> >> > feature does not seem to quite fit into either of those classes.
> >> >
> >> > I am proposing adding a class called "privacy_screen" to interface
> >> > with these devices. The initial API would be simple just a single
> >> > property called "privacy_state" which when set to 1 would mean that
> >> > privacy is enabled and 0 when privacy is disabled.
> >> >
> >> > Current known use cases will use ACPI _DSM in order to interface with
> >> > the privacy screens, but this class would allow device driver authors
> >> > to use other interfaces as well.
> >> >
> >> > Example:
> >> >
> >> > # get privacy screen state
> >> > cat /sys/class/privacy_screen/cros_privacy/privacy_state # 1: privacy
> >> > enabled 0: privacy disabled
> >> >
> >> > # set privacy enabled
> >> > echo 1 > /sys/class/privacy_screen/cros_privacy/privacy_state
> >> >
> >> >  Does this approach seem to be reasonable?
> >>
> >> What part of the userspace would be managing the privacy screen? Should
> >> there be a connection between the display and the privacy screen that
> >> covers the display? How would the userspace make that connection if it's
> >> a sysfs interface?
> >>
> >> I don't know how the privacy screen operates, but if it draws any power,
> >> you'll want to disable it when you switch off the display it covers.
> >>
> >> If the privacy screen control was part of the graphics subsystem (say, a
> >> DRM connector property, which feels somewhat natural), I think it would
> >> make it easier for userspace to have policies such as enabling the
> >> privacy screen automatically depending on the content you're viewing,
> >> but only if the content is on the display that has a privacy screen.
> >
> > Connectors versus sysfs came up on a backlight thread recently.
> >
> > Daniel Vetter wrote an excellent summary on why it has been (and still
> > is) difficult to migrate backlight controls towards the DRM connector
> > interface:
> > https://lkml.org/lkml/2019/8/20/752
> >
> > Many of the backlight legacy problems do not apply to privacy screens
> > but I do suggest reading this post and some of the neighbouring parts
> > of the thread. In particular the ACPI driver versus real driver issues
> > Daniel mentioned could occur again. Hopefully not though, I mean how
> > wrong can a 1-bit control go? (actually no... don't answer that).
> >
> > It would definitely be a shame to build up an unnecessary sysfs legacy
> > for privacy screens so definitely worth seeing if this can use DRM
> > connector properties.
>
> Indeed. I'm painfully aware of the issues Daniel describes, and that's
> part of the motivation for writing this.
>
> Obviously the problem with associating the privacy screen with the DRM
> connector is that then the kernel has to make the connection, somehow,
> instead of just making it a userspace problem.
>
> BR,
> Jani.
>
> --
> Jani Nikula, Intel Open Source Graphics Center

I am not familiar with the DRM connector interface and I don't quite
understand how it would work in this case. How would the connector
provide control to userspace? Is there documentation or example code
somewhere that you could point me to?

Thanks,

Mat King
