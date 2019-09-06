Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBDBC00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E91720838
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbfIFSwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 14:52:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39252 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbfIFSwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:52:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id n7so8243766qtb.6;
        Fri, 06 Sep 2019 11:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=luFi0TuT3XVQl6cR8nGLOgL43zbHkVse71c1EpIkwPo=;
        b=bUayELkvBnVGOXCRbY4DkjbNb8Cqa1oB8RnIuSaZmhp4pxxu36uJaUXkyEeBLlfnh8
         JY6/P6sJJOXw0EkTKG1pVhXYHxv0iXPkrSAQ3BSgu6sLOCwZD5PG9wkaR7ju+xfI8PTE
         7ro5Ssj8yFR1LeYPSAR+1h7FzXmcvINHJe4+8sHaW8EgR4+EAuYTcMQd9NjttRG9XbSK
         hduB2/aq2blHWM5vaC43zSKDNHBx35XFy2sulA9dwACiCWT4MT6PpCWhjrRiMz16xWgU
         PMppXsX1g/ODZE5fcp+QIcYQ98dN20HIbwRkcl61F2u/vT6eD9ZYkrU1fgAB8ZHHBayE
         SvMg==
X-Gm-Message-State: APjAAAUPQu/QrfHE4TKJ3JfNjlPK69eVdHZQDxrTiWfAuJx0FDsZbYwf
        PrC2mfwyE9VdhiBlWjW/Jj1mXYJB7A6GKz+HOJA=
X-Google-Smtp-Source: APXvYqzm8UhXimBrmiHcTNKFne7oUY9qI1eWWCcAi3Su7JD0OfQZdwEb1ZjP0ebwDn4AFeFtbnddrWgkhn/cu+YfmAw=
X-Received: by 2002:a0c:e74b:: with SMTP id g11mr1159328qvn.62.1567795962670;
 Fri, 06 Sep 2019 11:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190906152609.1603386-1-arnd@arndb.de> <20190906165932.GX2680@smile.fi.intel.com>
In-Reply-To: <20190906165932.GX2680@smile.fi.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Sep 2019 20:52:26 +0200
Message-ID: <CAK8P3a1833nidJN0N0s5ZwiZatB3qR_tMx-pywNhga+6KUhpOQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: intel: hide unused intel_pin_to_gpio
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chris Chiu <chiu@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 6:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 06, 2019 at 05:26:01PM +0200, Arnd Bergmann wrote:
> > The intel_pin_to_gpio() function is only called by the
> > PM support functions and causes a warning when those are disabled:
> >
> > drivers/pinctrl/intel/pinctrl-intel.c:841:12: error: unused function 'intel_pin_to_gpio' [-Werror,-Wunused-function]
> >
> > As we cannot change the PM functions themselves to use __maybe_unused,
> > add another #ifdef here for consistency.
>
> It's not adding another #ifdef here...
>
> Nevertheless, I'm afraid that in the future we might need this in other
> place(s). Can we add __maybe_unused to this function exclusively?

Ok, sending v2 now.

      Arnd
