Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E130C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9863206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="fND51JmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfJGTxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:53:18 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33677 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGTxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:53:17 -0400
Received: by mail-yw1-f66.google.com with SMTP id w140so3933971ywd.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 12:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9fZ4Zp2LoFUBEHKFC3VfGjyFqFgPFxRmJbq4J4sKygI=;
        b=fND51JmAB40TXr2jZ5eaHDzLl4XiNMU2z/A8DUIdoeHdSxlaLKDARWw5QToebjJ1cU
         k2FzGi4WjW2CCpFkro3qR8q+3jR8xfuwIBq9arKrI0JaYlZQgdpq9lOla4lnGKfxnsYv
         H/XvxeIgTStoFvvnmHWGtuMxnqU5LDCh6zJES9cB+ZmkqijzHewwmRhKxJ1xy2XVwivI
         tz7xwvRw9VPWbdM1NDkc6EDP3zY2fxqNAJUsHJMK9ldiuxTpvd7elXxcnSj2HAdx6qG4
         Uj5hYHPMy+aFeNxacsCgeMbG23QnaEURwZebNzRe4QvcZjXKILEJapcEjl1cDFvuuK/w
         u+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9fZ4Zp2LoFUBEHKFC3VfGjyFqFgPFxRmJbq4J4sKygI=;
        b=GUbpeezTF6y7vfZHyshMLErwHhlbC/I9XIY4Ef9Kvo+BmuKgIH9/wTUIORml9CUxF4
         5NXcpmOZwpru/1XSZ3lU73vAVvopzOEK7Mvk8iaRxmk6HduJpQTy5GuJXxo4Ejue6ZbM
         UTOKlSWRNrs3P+Goyf5JHg40QlqljwYJ8kRki1Fkfld2DC3ibAFnKL3t4yjVSpwp5pAc
         EzG+p8cHON4rh5IAAk+E6lQy3aItkVzlN+wPlNCtquZPSKqbO+B2uT4l9llg9L3+fsVo
         9mo3FRZZuVKRy3Bj03rmB9YHsQ7qMa5+fmKFtMezDkZ/UHdcROQ9rsc0MGbb86T9EhBM
         1l4A==
X-Gm-Message-State: APjAAAXJ3IBbaVyOFDZnhaSB45FsijtX6S5o0CpKj10xp4ugFr9bUHfZ
        jkORytqIVqc6I5EPC298PYwvlA==
X-Google-Smtp-Source: APXvYqx0/UOMSXjbMdivkqZ9diKgs0ZXY4cBBAObwfQmK6XoKoKFnSw2Xz3U14z04SAGBLrvjMSbYg==
X-Received: by 2002:a81:c202:: with SMTP id z2mr22914112ywc.47.1570477996643;
        Mon, 07 Oct 2019 12:53:16 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id y63sm3905006ywg.5.2019.10.07.12.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 12:53:15 -0700 (PDT)
Date:   Mon, 7 Oct 2019 15:53:15 -0400
From:   Sean Paul <sean@poorly.run>
To:     Rajat Jain <rajatja@google.com>
Cc:     Mat King <mathewk@google.com>, Sean Paul <seanpaul@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ross Zwisler <zwisler@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alexander Schremmer <alex@alexanderweb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: New sysfs interface for privacy screens
Message-ID: <20191007195315.GH126146@art_vandelay>
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
 <87h84rbile.fsf@intel.com>
 <20191002102428.zaid63hp6wpd7w34@holly.lan>
 <8736gbbf2b.fsf@intel.com>
 <CAL_quvQkFjkBjJC5wH2t5XmyEq9OKWYSbAv39BJWT1hrKO7j8g@mail.gmail.com>
 <87h84q9pcj.fsf@intel.com>
 <CAL_quvQoWnWqS5OQAqbLcBO-bR9_obr1FBc6f6mA1T00n1DJNQ@mail.gmail.com>
 <CAOw6vbJ7XX8=nrJDENfn2pacf4MqQOkP+x8JV0wbqzoMfLvZWQ@mail.gmail.com>
 <CAL_quvTe_v9Vsbd0u4URitojmD-_VFeaOQ1BBYZ_UGwYWynjVA@mail.gmail.com>
 <CACK8Z6H+tBHproaH2hf59mYF406ohYhAWj8szYn=Fjao2SUZVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6H+tBHproaH2hf59mYF406ohYhAWj8szYn=Fjao2SUZVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 12:31:08PM -0700, Rajat Jain wrote:
> On Mon, Oct 7, 2019 at 9:19 AM Mat King <mathewk@google.com> wrote:
> >
> > On Mon, Oct 7, 2019 at 7:09 AM Sean Paul <seanpaul@chromium.org> wrote:
> > >
> > > On Thu, Oct 3, 2019 at 3:57 PM Mat King <mathewk@google.com> wrote:
> > > >
> > > > On Thu, Oct 3, 2019 at 2:59 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > > > >
> > > > > On Wed, 02 Oct 2019, Mat King <mathewk@google.com> wrote:
> > > > > > On Wed, Oct 2, 2019 at 4:46 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > > > > >>
> > > > > >> On Wed, 02 Oct 2019, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > > > > >> > On Wed, Oct 02, 2019 at 12:30:05PM +0300, Jani Nikula wrote:
> > > > > >> >> On Tue, 01 Oct 2019, Mat King <mathewk@google.com> wrote:
> > > > > >> >> > Resending in plain text mode
> > >
> > > /snip
> > >
> > > >
> > > > So my proposal would now be to add a new standard property to
> > > > drm_connector called "privacy_screen" this property would be an enum
> > > > which can take one of three values.
> > > >
> > > > PRIVACY_UNSUPPORTED - Privacy is not available for this connector
> > > > PRIVACY_DISABLED - Privacy is available but turned off
> > > > PRIVACY_ENABLED - Privacy is available and turned on
> > >
> > > Agree with Jani, use the property presence to determine if it's supported
> >
> > That makes sense; just to confirm can a property be added or removed
> > after the connector is registered?
> >
> > >
> > > >
> > > > When the connector is initized the privacy screen property is set to
> > > > PRIVACY_UNSUPPORTED and cannot be changed unless a drm_privacy_screen
> > > > is registered to the connector. drm_privacy_screen will look something
> > > > like
> > > >
> > > > struct drm_privacy_screen_ops {
> > > >     int (*get_privacy_state)(struct drm_privacy_screen *);
> > > >     int (*set_privacy_state)(struct drm_privacy_screen *, int);
> > > > }
> > > >
> > > > struct drm_privacy_screen {
> > > >     /* The privacy screen device */
> > > >     struct device *dev;
> > > >
> > > >     /* The connector that the privacy screen is attached */
> > > >     struct drm_connector *connector;
> > > >
> > > >     /* Ops to get and set the privacy screen state */
> > > >     struct drm_privacy_screen_ops *ops;
> > > >
> > > >     /* The current state of the privacy screen */
> > > >     int state;
> > > > }
> > > >
> > > > Privacy screen device drivers will call a function to register the
> > > > privacy screen with the connector.
> > >
> > > Do we actually need dedicated drivers for privacy screen? It seems
> > > like something that is panel-specific hardware, so I'd suggest just
> > > using the panel driver.
> >
> > The privacy screen is physically part of the display but the control
> > interface, at least in all current use cases, is ACPI. Is there a way
> > to control an ACPI device with the panel driver?
> 
> I feel that doing it in a dedicated driver has the advantage that if
> we can standardise the control interface, it can be used across
> different panels. So a new panel can be supported using the existing
> driver by merely instantiating the right ACPI HID "privacy screen"
> device as a child device of the parent display / panel device. This
> parent-child relation would also give the kernel the connection needed
> about "which display does this privacy screen attach to". In future,if
> non-x86 platforms need the feature using a different control interface
> (say via a GPIO driver), the privacy screen driver can be updated to
> support that also.


I might be misunderstanding the scope of this, but if everything is controlled
via drm properties, you could just use a helper function to toggle it on/off? We
have helper libraries for a plethora of optional hardware features already.

Sean

> 
> Thanks,
> 
> Rajat
> 
> >
> > >
> > > Sean
> > >
> > > >
> > > > int drm_privacy_screen_register(struct drm_privacy_screen_ops *ops,
> > > > struct device *dev, struct drm_connector *);
> > > >
> > > > Calling this will set a new field on the connector "struct
> > > > drm_privacy_screen *privacy_screen" and change the value of the
> > > > property to ops->get_privacy_state(). When
> > > > drm_mode_connector_set_obj_prop() is called with the
> > > > privacy_screen_proptery if a privacy_screen is registered to the
> > > > connector the ops->set_privacy_state() will be called with the new
> > > > value.
> > > >
> > > > Setting of this property (and all drm properties) is done in user
> > > > space using ioctrl.
> > > >
> > > > Registering the privacy screen with a connector may be tricky because
> > > > the driver for the privacy screen will need to be able to identify
> > > > which connector it belongs to and we will have to deal with connectors
> > > > being added both before and after the privacy screen device is added
> > > > by it's driver.
> > > >
> > > > How does that sound? I will work on a patch if that all sounds about right.
> > > >
> > > > One question I still have is there a way to not accept a value that is
> > > > passed to drm_mode_connector_set_obj_prop()? In this case if a privacy
> > > > screen is not registered the property must stay PRIVACY_UNSUPPORTED
> > > > and if a privacy screen is registered then PRIVACY_UNSUPPORTED must
> > > > never be set.

-- 
Sean Paul, Software Engineer, Google / Chromium OS
