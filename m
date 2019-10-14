Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC95DC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 03:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F82220815
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 03:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KEcztLNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfJNDVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 23:21:34 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45947 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729823AbfJNDVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 23:21:33 -0400
Received: by mail-vs1-f66.google.com with SMTP id d204so9909090vsc.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 20:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MoAndGD7+xOBQmFjHRilIe31g5IJG3QAYI2h3oVAfaM=;
        b=KEcztLNrUdPKcWuyh2hGeyPVaQfBg/U/7j5i0RNpWCAbI0jKHQPdLtQOyKZlKFk+io
         gQEboJhqjPtjsmxFmgam36eyS7/VqKYyG6aUXo9s3DFRKrICszdqtvoQabD702grmQ5F
         3a9GW6ba/v4r/6DpR1Y28TAVgEcW+/0ZbvEnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MoAndGD7+xOBQmFjHRilIe31g5IJG3QAYI2h3oVAfaM=;
        b=hRRFdMlcoU4XlmVaFyJ1NfXHoK26RDQHsIfHSvQO57XqANobdGXleGV7FKfRuyvxGl
         pzfBAi2oGy5KTBC9lyE/sIQXD6pzEZYhJHrUwde1ixfa9b/rI3GQk2QHmI1+v92UhyOQ
         W8eFX8MvcWW8v0HVm/XYwkhNVr5WLDrMcv6V4R4adsc49RwW8f3ISZLEBJM+9mGgKY8y
         zXfsM9QIJ85z1UTijuChgxNAZ0a29omxT+RnuHbk8SMXl4Tp/PpTDt5aSTH7RoDVi2lO
         zYSwFSkGA0x7CYK9NfE5lqMe6NE5k4iKRmxrt4eJWFQCzwhSHxYEBJwy2Ji+8Y1uFJw/
         jiZg==
X-Gm-Message-State: APjAAAW4xP3eaImMAv0NjMMsJ3jC+aB/HkMNpWHCygn7oxq6yZ4h22lH
        gfxraHyLB1bOArNb5ewh3SHHaMhT0mfOwz+fqZxwK0R9K68j7A==
X-Google-Smtp-Source: APXvYqzUpeUtM7it5vJ7Px2l0C655iX038UrctA+47NpKao+0z1PEHHeav8gnfqe5HbF8piW70zXNvnZHj+qZJIPC8k=
X-Received: by 2002:a05:6102:227c:: with SMTP id v28mr16725837vsd.119.1571023290929;
 Sun, 13 Oct 2019 20:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191007071610.65714-1-cychiang@chromium.org> <CA+Px+wWkr1xmSpgEkSaGS7UZu8TKUYvSnbjimBRH29=kDtcHKA@mail.gmail.com>
 <ebf9bc3f-a531-6c5b-a146-d80fe6c5d772@roeck-us.net> <CAFv8NwLuYKHJoG9YR3WvofwiMnXCgYv-Sk7t5jCvTZbST+Ctjw@mail.gmail.com>
 <5d9b5b3e.1c69fb81.7203c.1215@mx.google.com> <CAFv8Nw+x6V-995ijyws1Q36W1MpaP=kNJeiVtNakH-uC3Vgg9Q@mail.gmail.com>
 <5d9ca7e4.1c69fb81.7f8fa.3f7d@mx.google.com> <e968e478-bb48-5b05-b6c4-ae1bf77f714f@linaro.org>
In-Reply-To: <e968e478-bb48-5b05-b6c4-ae1bf77f714f@linaro.org>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Mon, 14 Oct 2019 11:21:04 +0800
Message-ID: <CAFv8NwKH5rX2cdfbK1XJxUJFU3uo0K4UowUM3Z7447Qoz_y8bA@mail.gmail.com>
Subject: Re: [PATCH] firmware: vpd: Add an interface to read VPD value
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        Hung-Te Lin <hungte@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Dylan Reid <dgreid@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 10:05 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 08/10/2019 16:14, Stephen Boyd wrote:
> >> 3) As my use case does not use device tree, it is hard for ASoC
> >> machine to access nvmem device. I am wondering if I can use
> >> nvm_cell_lookup so machine driver can find the nvmem device using a
> >> con_id. But currently the cell lookup API requires a matched device,
> >> which does not fit my usage because there will be different machine
> >> drivers requesting the value.
> >> I think I can still workaround this by adding the lookup table in
> >> machine driver. This would seem to be a bit weird because I found that
> >> most lookup table is added in provider side, not consumer side. Not
> >> sure if this is logically correct.
> > Maybe Srini has some input here. It looks like your main concern is
> > consumer to provider mapping?
> >
>
> In non-DT setup, there are various ways to lookup nvmem provider.
>
> 1> nvmem_device_get()/put() using provider devid/name. I think you
> should be able to use this in your case.
> 2> nvmem_register_notifier() which notifies when nvmem provider is added
> to system.
> 3> nvmem_device_find() with own match function this will be merged in
> next window (https://lkml.org/lkml/2019/10/3/215)
>
>
> If none of these are of any help, could explain what exactly are you
> looking for w.r.t nvmem to be able to move to what Stephen Boyd suggested?
>
> --srini
>

Hi Stephen, Mark and Srinivas,
Thank you all for the suggestions.
In my non-DT setup, I have been working on coreboot changes to prepare
data in _DSD following suggestion in
https://patchwork.kernel.org/patch/11179237
The basic idea is that codec driver should just get data it needs from
device property.
The coreboot approach works in my local setup, but I have not sent the
change to coreboot upstream yet.
If that path work, then the change needed in kernel will be much simpler.

In the future, there might be DT setup use case, and I think it should
be doable for VPD to register a nvmem device, and let codec driver
gets the property.
But I would drop this path for now.
Thanks!
