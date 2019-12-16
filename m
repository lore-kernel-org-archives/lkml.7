Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E38C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C90420725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDL84PL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLPK0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:26:24 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46570 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfLPK0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:26:24 -0500
Received: by mail-lj1-f194.google.com with SMTP id z17so6145673ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 02:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OkpVHHKfDIvE++qC7pqWmg/jiaUV0l9IrypFklbrI6o=;
        b=lDL84PL+2Ns4vFAqwLLrdQi1O+3TQ6U/1dl28aR2f5iPN84nonscwhbbksUFjIlS5R
         otbTznmgxLMJaAner5nrpGth72IVvBmT/6uaM4tx+Y+mEEawgORon/elo6UPVH5JvJYb
         Ck2/MV674z0jbmRgEZH0vAlKytoZnH/ItSxaGXx0K213YovI7A4yEtfAGr8qVFC8qILi
         94ezCXOUyfvLoV8f/yzdmpj1qIfvNUfwHHlA4TO3fmxjmrNVgk41krWYbwyb3SMyU9cr
         Nn8qkvnhE3ahvqrWYa02Vf4Ret+ZHDC4hZD4vr81kUyvgcplB6Y5bMnP2WfkMtddC/uN
         iXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OkpVHHKfDIvE++qC7pqWmg/jiaUV0l9IrypFklbrI6o=;
        b=Ki3+4jlhTtQetplvZEkKlplcTPawqZeSy61KwZNnumQqBz62fbjaMW+0ajYEQuBFNb
         c2L+fs9KC2uUembyGu5Ai7PShw4lSsu1yow/G/WKO3fK+dX4A1EwZEX+I4QO1n4Pe81d
         WKjmgEiJ9oJbAQw52un9kE3EX6Wc7YPOqiQ8F2d/aOuO6izQNlTNg2MBc++rEZvrFrjU
         Sb3vKibDGGXLN15V//E2kwjQH6+yz1Mouog9poZHPi6y+0YkWhNYyemYlr3UiPWofl3V
         ifcbZM50fWhg9oK0eqsdOOPoFPzj8J51+bMI0fnkl4PzuFdjojoWq81QEQqU36J09+Ps
         6r3g==
X-Gm-Message-State: APjAAAXRm1u8O6FseILlhWyDkMPHHaIYLKZc50C9R/zGEOZFcSrT+1BP
        uQsETWMW0LzTNHpY61yShpjiKQnUvVzbiC5rq8aeUw==
X-Google-Smtp-Source: APXvYqyfCsSztFtNTTzlCe+aXkIxE7g02n2kJDD5isrSGVNYwnEfbfi911iDlZCap4HI8gvXspWAPVC8NvrEdEvcY0s=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr18582325ljm.233.1576491982626;
 Mon, 16 Dec 2019 02:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20191215163810.52356-1-hdegoede@redhat.com>
In-Reply-To: <20191215163810.52356-1-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 11:26:10 +0100
Message-ID: <CACRpkdarJ5chDfgc5F=ntzG1pw7kchtzp0Upp+OH9CH6WLnvXw@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/i915/dsi: Control panel and backlight enable
 GPIOs from VBT
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 5:38 PM Hans de Goede <hdegoede@redhat.com> wrote:

> Linus, this series starts with the already discussed pinctrl change to
> export the function to unregister a pinctrl-map. We can either merge this
> through drm-intel, or you could pick it up and then provide an immutable
> branch with it for merging into drm-intel-next. Which option do you prefer?

I have created an immutable branch with these changes and pulled it
to my "devel" branch for v5.6:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-pinctrl-unreg-mappings

Please pull this in and put the other patches on top of that.

I had a bit of mess in my subsystems last kernel cycle so I
want to avoid that by strictly including all larger commits
in my trees.

Yours,
Linus Walleij
