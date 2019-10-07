Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617CFC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306CD21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UKLLFbk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfJGNJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:09:03 -0400
Received: from mail-yw1-f49.google.com ([209.85.161.49]:43371 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfJGNJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:09:03 -0400
Received: by mail-yw1-f49.google.com with SMTP id q7so5068542ywe.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 06:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGGpibKSgPN52F+AToEQA5qscMTvvOJsG/MluQQQWb8=;
        b=UKLLFbk7MozKtKXnphdmdst1Gzjdzn/kP9WFcji1s6Ob0Ncn1WVsfCDCMDa0kelx2H
         UgWEmBVm0gVF1Ibj+h+q30kw7QRZOXHs+5UmEBaVM0iuR+HuyETd4jhXWRCglTr+ODNO
         YPUu2jQnH1pWJeZuZdRTFn7uKmM+ApWINK8M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGGpibKSgPN52F+AToEQA5qscMTvvOJsG/MluQQQWb8=;
        b=jyavsXBknew2S71vGsWLkKg4oBScZQcinH+Fc4qO/bLDSi0SK2OW1VzG15BzXcYz1z
         stp4auNsUFHVfDV2ae8mUN/KSzHa1ml64d8mofa1l64508OX07pNlqAfJmZZtwTArABZ
         95Y2cYgX+1BdYEowSJhUSOg02N4crUn8bnv2DMcCDx00QjfvefrtIL7uJwNx+dkJioOJ
         bbcd8+WI9OeV/MPCQQrbVIT8YhGWOrcrNyja6SdEsvlnJVnh6hcmgaCO8aVwCYLv1xfl
         ALG03j3tgd3ttJ0dzIw1U1IWf4vy7AQRgATjkJKg9ojzPLMA12BlbqaGR95BcP0XrfCV
         u+UQ==
X-Gm-Message-State: APjAAAVt8z5SEBT2oMNc4a2RFkRlj+rgpBfqd/5ATpO0s5HSC7lCoX8W
        eqtdc54rIiPnG2r/aqa4tcMCEUlJafs=
X-Google-Smtp-Source: APXvYqxW3dyvPx/1H8IGb7prcocx0DXPPNaJsTES5w++jWmnkeoJi5FQHyviHL8Qzc+9kTU0Cv2ucw==
X-Received: by 2002:a0d:ea81:: with SMTP id t123mr19600152ywe.30.1570453741536;
        Mon, 07 Oct 2019 06:09:01 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id d66sm3635156ywe.31.2019.10.07.06.08.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 06:09:00 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 4so956530ybq.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 06:08:59 -0700 (PDT)
X-Received: by 2002:a25:6e41:: with SMTP id j62mr11442914ybc.41.1570453738921;
 Mon, 07 Oct 2019 06:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
 <87h84rbile.fsf@intel.com> <20191002102428.zaid63hp6wpd7w34@holly.lan>
 <8736gbbf2b.fsf@intel.com> <CAL_quvQkFjkBjJC5wH2t5XmyEq9OKWYSbAv39BJWT1hrKO7j8g@mail.gmail.com>
 <87h84q9pcj.fsf@intel.com> <CAL_quvQoWnWqS5OQAqbLcBO-bR9_obr1FBc6f6mA1T00n1DJNQ@mail.gmail.com>
In-Reply-To: <CAL_quvQoWnWqS5OQAqbLcBO-bR9_obr1FBc6f6mA1T00n1DJNQ@mail.gmail.com>
From:   Sean Paul <seanpaul@chromium.org>
Date:   Mon, 7 Oct 2019 09:08:18 -0400
X-Gmail-Original-Message-ID: <CAOw6vbJ7XX8=nrJDENfn2pacf4MqQOkP+x8JV0wbqzoMfLvZWQ@mail.gmail.com>
Message-ID: <CAOw6vbJ7XX8=nrJDENfn2pacf4MqQOkP+x8JV0wbqzoMfLvZWQ@mail.gmail.com>
Subject: Re: New sysfs interface for privacy screens
To:     Mat King <mathewk@google.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, rafael@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Ross Zwisler <zwisler@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alexander Schremmer <alex@alexanderweb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 3:57 PM Mat King <mathewk@google.com> wrote:
>
> On Thu, Oct 3, 2019 at 2:59 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >
> > On Wed, 02 Oct 2019, Mat King <mathewk@google.com> wrote:
> > > On Wed, Oct 2, 2019 at 4:46 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > >>
> > >> On Wed, 02 Oct 2019, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > >> > On Wed, Oct 02, 2019 at 12:30:05PM +0300, Jani Nikula wrote:
> > >> >> On Tue, 01 Oct 2019, Mat King <mathewk@google.com> wrote:
> > >> >> > Resending in plain text mode

/snip

>
> So my proposal would now be to add a new standard property to
> drm_connector called "privacy_screen" this property would be an enum
> which can take one of three values.
>
> PRIVACY_UNSUPPORTED - Privacy is not available for this connector
> PRIVACY_DISABLED - Privacy is available but turned off
> PRIVACY_ENABLED - Privacy is available and turned on

Agree with Jani, use the property presence to determine if it's supported

>
> When the connector is initized the privacy screen property is set to
> PRIVACY_UNSUPPORTED and cannot be changed unless a drm_privacy_screen
> is registered to the connector. drm_privacy_screen will look something
> like
>
> struct drm_privacy_screen_ops {
>     int (*get_privacy_state)(struct drm_privacy_screen *);
>     int (*set_privacy_state)(struct drm_privacy_screen *, int);
> }
>
> struct drm_privacy_screen {
>     /* The privacy screen device */
>     struct device *dev;
>
>     /* The connector that the privacy screen is attached */
>     struct drm_connector *connector;
>
>     /* Ops to get and set the privacy screen state */
>     struct drm_privacy_screen_ops *ops;
>
>     /* The current state of the privacy screen */
>     int state;
> }
>
> Privacy screen device drivers will call a function to register the
> privacy screen with the connector.

Do we actually need dedicated drivers for privacy screen? It seems
like something that is panel-specific hardware, so I'd suggest just
using the panel driver.

Sean

>
> int drm_privacy_screen_register(struct drm_privacy_screen_ops *ops,
> struct device *dev, struct drm_connector *);
>
> Calling this will set a new field on the connector "struct
> drm_privacy_screen *privacy_screen" and change the value of the
> property to ops->get_privacy_state(). When
> drm_mode_connector_set_obj_prop() is called with the
> privacy_screen_proptery if a privacy_screen is registered to the
> connector the ops->set_privacy_state() will be called with the new
> value.
>
> Setting of this property (and all drm properties) is done in user
> space using ioctrl.
>
> Registering the privacy screen with a connector may be tricky because
> the driver for the privacy screen will need to be able to identify
> which connector it belongs to and we will have to deal with connectors
> being added both before and after the privacy screen device is added
> by it's driver.
>
> How does that sound? I will work on a patch if that all sounds about right.
>
> One question I still have is there a way to not accept a value that is
> passed to drm_mode_connector_set_obj_prop()? In this case if a privacy
> screen is not registered the property must stay PRIVACY_UNSUPPORTED
> and if a privacy screen is registered then PRIVACY_UNSUPPORTED must
> never be set.
