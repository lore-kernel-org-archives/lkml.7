Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250F1C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBBF20657
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lq5xNcua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfFXQNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:13:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40218 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729467AbfFXQNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:13:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so10493003lff.7;
        Mon, 24 Jun 2019 09:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GZPxaE4LPUF9+J5HPzKoEU19i8mw9pm9OwqCmXFx/U=;
        b=Lq5xNcua1mi5U4qn9dT42BftsIszZlSpZZBUj17GZ1uG6Fe0nW/3v1hVO9AHREiul6
         hLc7Z3BVLRPgBZ7oyFnDtYNipFqViKYVjlJB7hnP6oJStr+tm3yUCMkE12D6nZWkvQ5s
         siA+nTZtbq8EEvEIUt/hGxcIYFgvNRlUXQjaMfCDAeQpCpqdI6OburRt3HmHKr/AYgNB
         MepAdaWUnXGI7od7JnYyNbq0kmjXHDzwMomFt+0CnqGFMCjawuJDYg5V3gs9j0m9eu/I
         tYM4XNa0/RsOVKntoQNGKqoOikRgaMiCt+RkoW/DkC9xO/BySbqATIYr6D/quf3e4e3W
         /cOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GZPxaE4LPUF9+J5HPzKoEU19i8mw9pm9OwqCmXFx/U=;
        b=OQVl0jiXdekRYe0SXsGNhtSMR93zL/yX+WQXVyU8CbsfKJ243jMLcwT9NmJpLQ6mv+
         ABCnSEsEVNXXGUQx5NE6m67Z9Cymi9ZuXALONuITR4SkfUtvhSDGrjnw7aP6Z0TpO3DN
         rbjv4lLosTvaBrlnxLMhZ8Hj2DlHDPFxrKm3zOqqEshg7dZuX9zeBin6xeLdqLzbi7of
         h5ZeiiI2/O4tGRy1NUYnn/5WP7MIz9beWW1KAwYrMMXxcjNixz1bnWzzutTW4bZSaYv1
         DvgRwrf1bb7j28Xq80BhF+4UEFArTXlqj+w4Wo/+QLye7vFW2+NX3SD0NonHBdu1QvFT
         PUeQ==
X-Gm-Message-State: APjAAAWS1RtGJjwhEF4DRz+ADiO9wrV6JPOZh9ehVVDvo/30AsUqGpv0
        q+Ie+z9OD0Exe2fTC2wTl6Bu/7AeZaF8xUIQNpE=
X-Google-Smtp-Source: APXvYqxdP+JVlW5k+mSxUHwcly0JYp6JIPTVU2yVYp4LrSzBHV3NclYDyyL6oWgS9snh6oT01HXaRzoS5AtTl62eGn0=
X-Received: by 2002:a19:5046:: with SMTP id z6mr28946753lfj.185.1561392789879;
 Mon, 24 Jun 2019 09:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <1561037428-13855-1-git-send-email-robert.chiras@nxp.com>
 <1561037428-13855-3-git-send-email-robert.chiras@nxp.com> <CAOMZO5DS2v15h9E=qKg2vKuFkBSQQwdBHA5Th5mZ+ca6DWgQsw@mail.gmail.com>
 <1561362278.9328.83.camel@nxp.com>
In-Reply-To: <1561362278.9328.83.camel@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 24 Jun 2019 13:12:58 -0300
Message-ID: <CAOMZO5CVPJqE0dR2PZvKem4WHztvTF=FT9K1x-b7TduH-yYb7A@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v3 2/2] drm/panel: Add support for Raydium
 RM67191 panel driver
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Mon, Jun 24, 2019 at 4:44 AM Robert Chiras <robert.chiras@nxp.com> wrote:

> > You did not handle the "power" regulator.
> There is no need for a power regulator.

I am sure the panel requires power to be applied so that it can work :-)

> > Can't you simply remove them?
> The reset gpio pin is shared between the DSI display controller and

Looking at the imx8mq-evk schematics it is not clear for me what pin
in shared between the OLED display and touch screen.

Could you please clarify which pin you are referring to?

> touch controller, both found on the same panel. Since, the touch driver
> also acceses this gpio pin, in some cases the display can be put to
> sleep, but the touch is still active. This is why, during suspend I
> release the gpio resource, and I have to take it back in resume.
> Without this release/acquire mechanism during suspend/resume, stress-
> tests showed some failures: the resume freezes completly.

Looking at the imx8mq-evk dts from the vendor tree I see that the
touchscreen is not supported in mainline yet.

Maybe there is a better way to solve this, so what if you don't
introduce the suspend/resume hooks for now and then we revisit this
after the touchscreen driver is added?
