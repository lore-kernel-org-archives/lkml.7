Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16601C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DE52075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FhbBv0lm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfDDSlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:41:45 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36901 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbfDDSlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:41:45 -0400
Received: by mail-oi1-f193.google.com with SMTP id v84so2778955oif.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 11:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndF6e0KraTkIrYsDCv77TWOivEtX3C6Q0r0KXXhAAGk=;
        b=FhbBv0lmLayK3GkbHep6oA1XDZk8BzOJMoARldyTiIt6QuS0Ksq4xCArMLgytLOB9j
         PEmuaWbsb2h/hom+N3P23XWftbbsX0bWRGlb2Ww/GQqBIualupyQyLhxgjnleTVcMQUK
         XGrtSRqNLJynwfeuVd7fhGAa/0F6JYVpL1Lp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndF6e0KraTkIrYsDCv77TWOivEtX3C6Q0r0KXXhAAGk=;
        b=Azvjr/OClXCvShcoZHJXACqVQMU/yPtLiRBnQJOsc/1FuUSWBKI7/1PvL3PBsCrJmV
         gy1oKZDZYiFlNVFHhIYwZxA0Hub/wLfS0haAu59hcic0dOup5GByJsUkEaj1VfOjSVxz
         N+aGl07lGavqXuj8SLhGq02L3FjI9gwo5nW3jF9r7v17WJg6EnTSnw95nSTjzOFhNwrX
         lx1DZ4GG1XvkIfe7NRGy3n7vDBr03KQ75qoA8juKcYlq2c8pEz54NTBEJmBD7gJzrinZ
         XSLD6QEa5RdMpjFwjJ//LpFVtJcU5KPW8foun5NgeGRw5m1nejLzAzflaQMjWaJQ8qRo
         /DUg==
X-Gm-Message-State: APjAAAVGWJWE+KoEA4ZFhBg0e+g2cRgWreEnWk+R+9OLEYi7OvsvG5RV
        nHFuvtciabBsriofk+zKsozr+Q/HH7s=
X-Google-Smtp-Source: APXvYqyl25MelR3ZHYmCTK/HvQM7KWNV8zKsAWgxy3xAalPIJuucHMhaYAYNcBdQ+QKvJmdUT3POtw==
X-Received: by 2002:aca:3b43:: with SMTP id i64mr4464110oia.121.1554403304388;
        Thu, 04 Apr 2019 11:41:44 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id n77sm10120054ota.77.2019.04.04.11.41.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 11:41:43 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id f10so3300235otb.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 11:41:42 -0700 (PDT)
X-Received: by 2002:a9d:70cf:: with SMTP id w15mr5599304otj.304.1554403302149;
 Thu, 04 Apr 2019 11:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190404171007.160878-1-ncrews@chromium.org> <20190404171007.160878-3-ncrews@chromium.org>
 <CABXOdTeFnohENJrZ+=_W-EgsrKWttSFYKoR=LaCwzbhEbaOxzw@mail.gmail.com> <CAE_wzQ8xS+zvSKNVs1v4B_y3NDu2qB65p_hD+j=qGHFxQWOmSg@mail.gmail.com>
In-Reply-To: <CAE_wzQ8xS+zvSKNVs1v4B_y3NDu2qB65p_hD+j=qGHFxQWOmSg@mail.gmail.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Thu, 4 Apr 2019 12:41:30 -0600
X-Gmail-Original-Message-ID: <CAHX4x87cQLhZOEDxwBJs=UkDxwGxZOELGjHtp6aFLBWmjyQAFQ@mail.gmail.com>
Message-ID: <CAHX4x87cQLhZOEDxwBJs=UkDxwGxZOELGjHtp6aFLBWmjyQAFQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] platform/chrome: Standardize Chrome OS keyboard
 backlight name
To:     Dmitry Torokhov <dtor@google.com>
Cc:     Guenter Roeck <groeck@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Simon Glass <sjg@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 11:43 AM Dmitry Torokhov <dtor@google.com> wrote:
>
> On Thu, Apr 4, 2019 at 10:36 AM Guenter Roeck <groeck@google.com> wrote:
> >
> > On Thu, Apr 4, 2019 at 10:11 AM Nick Crews <ncrews@chromium.org> wrote:
> > >
> > > We want all backlights for the system keyboard to
> > > use a common name, so the name "platform::kbd_backlight"
> > > would be better than the current "chromeos::kbd_backlight"
> > > name. Normally this wouldn't be worth changing, but the new
> > > Wilco keyboard backlight driver uses the "platform" name.
> > > We want to make it so all Chrome OS devices are consistent,
> > > so we'll change the name here too.
> > >
> >
> > Wondering - who is the "we" you are talking about ?

You're right, I should have been more precise.
I was referring to Pavel, Enric, and myself. Pavel had this opinion here:
https://lkml.org/lkml/2019/4/4/1040. I don't know what Pavel meant by "we"
in that comment, but I would guess that could mean the other LED maintainers
as well? I talked with Enric 1:1 and he didn't see the problem with changing it,
though perhaps he was only considering our use of the LED via powerd,
and not users in general. I'm guessing Pavel's and Enric's meanings though,
excuse me if I am misinterpreting.

>
> This also has a potential of breaking existing setups if somebody did
> happen to match on entire name instead of suffix. Such changes have to
> be considered very carefully; at this point I am against of doing
> this.

Would it make sense to keep the old name as is, and only make the new
Wilco name begin with "platform:"? What would you think is best?

>
> Thanks.
>
> --
> Dmitry
