Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5117C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD7C2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="mHFrTUKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfHNShS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:37:18 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:37970 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbfHNShR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:37:17 -0400
Received: by mail-ot1-f48.google.com with SMTP id r20so297388ota.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1ZhkxlA5RiuxtYaWeDgg6qWaM8JmbM5adPrEVLQCaY=;
        b=mHFrTUKiPm4qyuo740JkJ7NzrjP6aZ05fw+cbk/S1SH/Xp8XRyb4Qr6JMvEHaqDpeb
         6k0m7zmpxIeHgqZ05hZyX5ciFz3Y1cfCb9EcgczR9hd2ZlCgcrE0EooCzT9ib+3XuG7D
         /hH9E0TM8qOyoW8OcZ+td0oBasB3IvuTybxtCcqufMHMhsFCL7bEy0eHDHp1PCBL7xKk
         kDsDdv+NHXzgr/G0Ue7HQpILnjPycMftf8nGNwLT0wie+5+X3GoK7WnnKmLXnKrecD32
         xVSfVhk0jJPLfG/CcjPSVLRxanongInZpzdKxAc6s1lKXNoimCvL6qIIguTYZ+5AxMW0
         hVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1ZhkxlA5RiuxtYaWeDgg6qWaM8JmbM5adPrEVLQCaY=;
        b=M/2Z/PyS3VtIj0djC/u7aSbxcXJGV4bpJyUDxnkHqTMx/6Ug0vNdJJiJXa0AACzzVl
         1Z44xDVjlmcqb+NEl7/SKAgdIW/oT421Mj2IGSe2ovP21qY0OhCobwHMSmuLSKgkuZGm
         eDzj+Zu3Orl4RnCF63AV+uMtaztJ3YE5jwTgaGRoGqD3g70BCPjPckw2m8P2FrvwQ89G
         VXxJDd9Vol7mX9B7/EuBX0AGS9CC4UkM+MOOCdXhPXBhAnZuhREdbZjNLfb31mDLP6sJ
         Ohrer94/SNyR0y6ISSgj+JFEfxW7d+MniBwwV/o7M0tKgA/XC0qSmipv4Syjg/X6ZP3W
         iw/w==
X-Gm-Message-State: APjAAAVA+UxpYKOazGdQ9by1QmivTeXWK3XPbj81CBUf3DV8TLa7VD9w
        rha1zhQ3q4doyzP44K8QsQ7R7N76/7b2iOdRweCkuQ==
X-Google-Smtp-Source: APXvYqxbpuYpgfQERx/WDHl76hZenTI35Sh0ai+nP9DIPjQa3J7qJfNAG5EVro6PHqaavQ2NvV+TrvsE/9vX002QLeo=
X-Received: by 2002:a05:6830:13d9:: with SMTP id e25mr411557otq.197.1565807836826;
 Wed, 14 Aug 2019 11:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <1565731976.8572.16.camel@lca.pw> <5d53b238.1c69fb81.d3cd3.cd53@mx.google.com>
 <20190814084014.GB52127@atomide.com>
In-Reply-To: <20190814084014.GB52127@atomide.com>
From:   Tri Vo <trong@android.com>
Date:   Wed, 14 Aug 2019 11:37:05 -0700
Message-ID: <CANA+-vDeSAYUNfTQzQPT2N_CUgvYr6i_LP_BdHT_zX+FPt8NHg@mail.gmail.com>
Subject: Re: "PM / wakeup: Show wakeup sources stats in sysfs" causes boot warnings
To:     Tony Lindgren <tony@atomide.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, Qian Cai <cai@lca.pw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 1:40 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Stephen Boyd <swboyd@chromium.org> [691231 23:00]:
> > I also notice that device_set_wakeup_capable() has a check to see if the
> > device is registered yet and it skips creating sysfs entries for the
> > device if it isn't created in sysfs yet. Why? Just so it can be called
> > before the device is created? I guess the same logic is handled by
> > dpm_sysfs_add() if the device is registered after calling
> > device_set_wakeup_*().
>
> Hmm just guessing.. It's maybe because drivers can enable and disable
> the wakeup capability at any point for example like driver/net drivers
> do based on WOL etc?
>
> > There's two approaches I see:
> >
> >       1) Do a similar check for device_set_wakeup_enable() and skip
> >       adding the wakeup class until dpm_sysfs_add().
> >
> >       2) Find each case where this happens and only call wakeup APIs
> >       on the device after the device is added.
> >
> > I guess it's better to let devices have wakeup modified on them before
> > they're registered with the device core?
>
> I think we should at least initially handle case #1 above as multiple
> places otherwise seem to break. Then maybe we could add a warning to
> help fix all the #2 cases if needed?

Makes sense. For case#1, we could also just register the wakeup source
without specifying the parent device if the latter hasn't been
registered yet. Userspace won't be able to associate a wakeup source
to the parent device. But I think it's a reasonable fix, assuming we
want to fix devices not being added before calling wakeup APIs #2.
