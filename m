Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD6AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9151E2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pkh47teP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfDDOLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:11:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34849 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfDDOL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:11:29 -0400
Received: by mail-oi1-f195.google.com with SMTP id j132so2008588oib.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 07:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKIumIW4/pqk9mqvGkSZcYMVkb26vhngqjq/5DBwZgQ=;
        b=Pkh47tePszMlIZGUWv2KJ/O9eEZpY0s1yE8lY+JhWob/SHGaPy4MTsnBlqfcvnObIh
         782FRqtopZhjYhLma1XzQwPHzh9oewNTkKCpeAgopzP/hdup3JF+SbgEI5F4ywTBmQ3b
         Rrfnd4fCJm2BBxsbT9Ml6RC8N+5QrXPxR/xzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKIumIW4/pqk9mqvGkSZcYMVkb26vhngqjq/5DBwZgQ=;
        b=CdDOGZaJ5BRD/E2l8MeE8BPL2GqN9gu9mW+PWqNtwE+LlW0y9hX5Z9Mg1ym2YldeVl
         okuFpEefx076niewRfWEgPf6VUsJzZpDYTScV5Gim55QdFwa0GKJzFPsFPjod+ji1Bvz
         ipdwmI+H95pIhdX2AJym+L2jutr/5eikTCC4zbLBcwE2ieSIIFHsWC+bckze0dR0KA/r
         3rMcafhgD2EWA2pedo9/zkNpVsT9OSbM2Ma6mzyhzJZHU02/fJGVOIExEaSYFkbBxhXK
         h7aXHrscbTzFOcuB2ppcX6g8NbbKwipLuXUXXNADfq9yxJVPfpCFLbKdfoiK3p9wfrZj
         6HDQ==
X-Gm-Message-State: APjAAAVODQrfPRMSJBSYdxf6varHumjVHFshiYVq61LxfOAbmC3L+0MK
        mx001WvCno+nwS3L4/YPmKPTg8A/cdg=
X-Google-Smtp-Source: APXvYqx7o7gcS19V2uTteqwXmEGztjFtDfGfqjJi0VNod39z/cRQWFXZZWV4RMpwlrMYqg6Wk9S0vw==
X-Received: by 2002:aca:b607:: with SMTP id g7mr3518128oif.6.1554387088848;
        Thu, 04 Apr 2019 07:11:28 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id p205sm7474394oia.49.2019.04.04.07.11.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 07:11:27 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id m10so2468771otp.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 07:11:27 -0700 (PDT)
X-Received: by 2002:a9d:61cf:: with SMTP id h15mr4235102otk.140.1554387087097;
 Thu, 04 Apr 2019 07:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190308203801.57920-1-ncrews@chromium.org> <20190308210843.GA16125@amd>
 <CAHX4x85=_76=Kyepf3Nw++4yVKOZujhLsonzaicZOnY5fi-Pfw@mail.gmail.com> <20190404112415.GB18653@amd>
In-Reply-To: <20190404112415.GB18653@amd>
From:   Nick Crews <ncrews@chromium.org>
Date:   Thu, 4 Apr 2019 08:11:15 -0600
X-Gmail-Original-Message-ID: <CAHX4x87zDrFMc1z0vbSE5+frPy+Ri9YD=9LtKXtsaGwhtXOrJQ@mail.gmail.com>
Message-ID: <CAHX4x87zDrFMc1z0vbSE5+frPy+Ri9YD=9LtKXtsaGwhtXOrJQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Add Wilco EC keyboard backlight LEDs support
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Daniel Erat <derat@google.com>,
        Guenter Roeck <groeck@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 5:24 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Mon 2019-03-11 09:29:06, Nick Crews wrote:
> > Thanks for looking this over. I will fix most of your concerns, but
> > have one question.
> >
> > On Fri, Mar 8, 2019 at 2:08 PM Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > On Fri 2019-03-08 13:38:02, Nick Crews wrote:
> > > > This patch is meant to be applied on top of the for-next
> > > > branch of the platform/chrome repository, as it uses some of
> > > > the code staged there.
> > > >
> > > > The EC is in charge of controlling the keyboard backlight on
> > > > the Wilco platform. We expose a standard LED class device at
> > > > /sys/class/leds/wilco::kbd_backlight. This driver is modeled
> > > > after the standard Chrome OS keyboard backlight driver at
> > > > drivers/platform/chrome/cros_kbd_led_backlight.c
> > >
> > > Can you make it "platform::kbd_backlight"? We want some consistency
> > > there.
> >
> > The analogous name in the standard driver
> > drivers/platform/chrome/cros_kbd_led_backlight.c is
> > "chromeos::kbd_backlight", and I thought "wilco" was a better
> > substitute for "chromeos" than "platform" would be. What other thing
> > are you saying "platform" would be consistent with?
>
> Yeah, well, we not let the cros_kbd_led_backlight.c use chromeos:: in
> the first place. But it happened. We want all backlights for the
> system keyboard to use common name, and "chromeos" is not really
> suitable for that. "platform" is.
>
>                                                                         Pavel

That reasoning makes sense Pavel. I don't think we care that much
about what the prefix actually is. The userspace daemon only looks
for something that matches "*:kbd_backlight". Therefore, I think we
should change both of these to use "platform::kbd_backlight".
Enric agrees with me here, any other concerns? If I don't hear anything
I'll add that change to this patch as well and re-send it.

Thanks,
Nick
