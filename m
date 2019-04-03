Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E748C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FE52133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IszAIFqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfDCSRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:17:42 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45667 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCSRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:17:41 -0400
Received: by mail-vs1-f65.google.com with SMTP id n14so10508514vsp.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 11:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MYqdDic6d8CUyxCOagr9VsVDT6GOi5mggxwVr55eWgo=;
        b=IszAIFqeaZc3Df5wcWKOC1c6uu2m5Ephq7sZCOqxJFmAkbIIVSCDtCG2f/5RxYexFm
         uEOvUdBvex5kSJmrIFisNW6mwliAcudyS7o6XjATowP8E+QR6aTT2WnOtZ1mW+pMgbFo
         DDoBpUP7AmI50+RI4Sg2zyVEaUI0UXfDLZH48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MYqdDic6d8CUyxCOagr9VsVDT6GOi5mggxwVr55eWgo=;
        b=mGo5vfyAYMW7Pf9Ja7JJe+AiRGPGBy7n/dnluhZx+nxIBx53Yy6NCHvxjkMi3gWF4s
         bJkkuga4uAyqfCIu9o9kplHGVg8KgtWBqEvj/SnoP5xYF/kDao7DFZuhmwSSVOhNYsnH
         Tkaa18Hs+KlFluSQ+u9xSp0jME7uX3sjjjF+NlmTJnc41HyAEmAxZgzX4WLDNpwfuZr0
         aKp76ui+ndhAJX7fjH48ekVo2SOlWmDCfmDLwZjohVzAxtfn81uJtEsAB9nEA9/2ekD9
         W4LtDkdWcGP/dHTZWO3hbwDlNpP1O7SMa8wJhpr+LlaPLfZcm2TjK7GDhXdY90s2RQti
         TMyg==
X-Gm-Message-State: APjAAAXa2dFs7Zl4P3iO2eJ2QD10tc5Vn7B1M4rRKKOniqseaYkIcrLq
        5Qf6czw2YJdJZu/FDeWcWwfxx//LfLw=
X-Google-Smtp-Source: APXvYqwjaqn5tXgynddaexQ7PoQZ3vpQXoEoLELS40zla9Y1HfynmxgprhYir7rLu6yGDHEKpSG9vQ==
X-Received: by 2002:a05:6102:3cc:: with SMTP id n12mr1319585vsq.58.1554315460383;
        Wed, 03 Apr 2019 11:17:40 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id m23sm24036020vsl.24.2019.04.03.11.17.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 11:17:39 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id a190so10588562vsd.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 11:17:39 -0700 (PDT)
X-Received: by 2002:a67:7f44:: with SMTP id a65mr1260767vsd.179.1554315458931;
 Wed, 03 Apr 2019 11:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190403160526.257088-1-dianders@chromium.org>
 <CA+ASDXN-4Ya6cK5wsmARXxP0bJCGpMkoyu1t_fS7hqVFKF0ZBw@mail.gmail.com> <20190403181415.GQ112750@google.com>
In-Reply-To: <20190403181415.GQ112750@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 3 Apr 2019 11:17:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UC6MpTgmir+nwUy4hWk8Vvz97M5G45=-r5JAg_=z6vQQ@mail.gmail.com>
Message-ID: <CAD=FV=UC6MpTgmir+nwUy4hWk8Vvz97M5G45=-r5JAg_=z6vQQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_spi: Transfer messages at
 high priority
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Simon Glass <sjg@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ryan Case <ryandcase@chromium.org>,
        Randall Spangler <rspangler@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 3, 2019 at 11:14 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> Each transfer has it's own work struct (allocated on the stack), hence
> a) does not occur. b) is still true, but shouldn't be a problem on
> its own.

Actually, it could be much worse _because_ it's on the stack.  The
worker could write something back to the work after the work has been
de-allocated.  That's bad.


> Anyway, using flush_work() as you suggested is the better solution :)

Yup, thanks!
