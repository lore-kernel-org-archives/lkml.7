Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D6EC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0106221882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lc05jcYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfKGWXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:23:33 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36478 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKGWXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:23:32 -0500
Received: by mail-oi1-f195.google.com with SMTP id j7so3509272oib.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 14:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZOXu8T4pF3RPpBQKh0YAfX9FS2U6WtIcpqxi844o2o=;
        b=lc05jcYGrXd77mjvFh2st+MfjgbDAvcXo0am0zOpmLekG0wMNHS6UQKK5Fv7ICh9QW
         lS8XQhqwhCipkOkSk6zhfV7iW657Ug2ftK3XaPoQ4y07t7r41kwJt2CjB2coTxyUhXNY
         3T3MDaMPazQIU1CnQXWf2dCvm2vgdzcqfNojMrXHKPV6mnx8ABDe5H/ABYSDepRtGCkw
         ePk2jg9N6xr+45Jm1fJDgZvg8XrE0tgusPHB8gJ/V8zqb/Ye05WNE0Cibz8rDDKQ6Ojt
         2dERKMfhMPDH2/QPqET3sVJJ3WGHAVVwlR6HHrmWR6SWM9bmAQVY41eMP9sH8j0dO3kp
         MZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZOXu8T4pF3RPpBQKh0YAfX9FS2U6WtIcpqxi844o2o=;
        b=mZ0pWfx0s3DUwdkq3B/HZijRA05rfSbnddcJ3h1T5MJuOqKxXP215FmW6MREe15Dpi
         r0d5MY3x+LQ5cQYKQoX+HEpqXZTsaKYo9EXs/fdbo5/H6scJaO9oQ4Yj6HclC+0lodwq
         IMxme7pUy3D9sH+PGqi/E5tHBrH+zwli9kE++JoAmxtP4Je3PvgVOTwDt3JeUjykdF9a
         CyPJlAF/kOiqoZ9wSc12OZpgSkZdG8u41Hjk9TS6z2S4kliq7syeoUl5hEW4mWXob1/4
         Ixf2x26AN0BtRoRLr9ETbdHJ8SymI/AF3D1xQqHMTKMqQX0fm4HFIVvBMGXl5TV3XOha
         0ihw==
X-Gm-Message-State: APjAAAXd786HAkFZpz00BNPMSuQXJ9TIN7k5EQznR4xv2oTatcAnnNbQ
        hr89AScZsbzLbVnxlZm8DW0JPUako6EEcX31sNLovQ==
X-Google-Smtp-Source: APXvYqyY6gqmhyUhh3I+7EzLkfqF4UECKiJdfaiTy6lvDg2Gv4yTuY9xtDeOsBizV8dGg8RKtFASWwMYJe6DdFIxXQQ=
X-Received: by 2002:a05:6808:9bc:: with SMTP id e28mr425347oig.169.1573165411701;
 Thu, 07 Nov 2019 14:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-10-john.stultz@linaro.org> <878sp3j42w.fsf@gmail.com>
In-Reply-To: <878sp3j42w.fsf@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 7 Nov 2019 14:23:20 -0800
Message-ID: <CALAqxLWZTevNPxBKBOGm2yMtevDkGXXninDGdZYj2qitFohvPw@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] usb: dwc3: Add host-mode as default support
To:     Felipe Balbi <balbi@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 2:25 AM Felipe Balbi <balbi@kernel.org> wrote:
> John Stultz <john.stultz@linaro.org> writes:
> > diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> > index 61d4fd8aead4..0e3466fe5ac4 100644
> > --- a/drivers/usb/dwc3/drd.c
> > +++ b/drivers/usb/dwc3/drd.c
> > @@ -489,7 +489,10 @@ static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role role)
> >               mode = DWC3_GCTL_PRTCAP_DEVICE;
> >               break;
> >       default:
> > -             mode = DWC3_GCTL_PRTCAP_DEVICE;
> > +             if (dwc->role_switch_default_mode == USB_DR_MODE_HOST)
> > +                     mode = DWC3_GCTL_PRTCAP_HOST;
> > +             else
> > +                     mode = DWC3_GCTL_PRTCAP_DEVICE;
> >               break;
> >       }
> >
> > @@ -515,7 +518,10 @@ static enum usb_role dwc3_usb_role_switch_get(struct device *dev)
> >               role = dwc->current_otg_role;
> >               break;
> >       default:
> > -             role = USB_ROLE_DEVICE;
> > +             if (dwc->role_switch_default_mode == USB_DR_MODE_HOST)
> > +                     role = USB_ROLE_HOST;
>
> look at this, we now have 3 different encodings for role which DWC3
> needs to understand. One is its own PRTCAP_DIR, then there USB_DR_MODE_*
> and now USB_ROLE_*, can we make it so that we only have one private
> encoding and one generic encoding?

And you left out the DWC3_OTG_ROLE_* set too!

So I agree it can be easy to muddle up.  The enums are *almost* equivalent:

include/linux/usb/role.h:
enum usb_role {
        USB_ROLE_NONE,
        USB_ROLE_HOST,
        USB_ROLE_DEVICE,
};

include/linux/usb/otg.h:
enum usb_dr_mode {
        USB_DR_MODE_UNKNOWN,
        USB_DR_MODE_HOST,
        USB_DR_MODE_PERIPHERAL,
        USB_DR_MODE_OTG,
};

But both are widely used:
$ git grep USB_ROLE_ | wc -l
123
$ git grep USB_DR_MODE_ | wc -l
190

So I'm not sure how easy it will be to condense down, since the usage
is coming from different usb subsystems (otg and role switching)  and
I worry assuming them equivalent in just one driver may run into
trouble eventually if the values diverge (ie someone adds
USB_ROLE_BRICK or something).

Heikki/Greg: Any thoughts on this? Does it make sense to try to drop
the usb_role enum and users and replace it with usb_dr_mode?

thanks
-john
