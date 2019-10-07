Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B95C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19F620867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jYE5no4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfJGWst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 18:48:49 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38377 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbfJGWst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 18:48:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id j31so21821306qta.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 15:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqvgBnkPf48/c8iQIpD40dYiZ/C4cQZKWA6sHzbPuDk=;
        b=jYE5no4fqHAFtQq9FMmi4SR6FbbWZnKKqcaF1/WWdYCtx2i92vXBmBiXTlB7Eab7eE
         KIqw5K00bu4K+2/eU9zIkcbRIDqkEEPRMZ81nNX0huyfAz9MU0airqGb0+7Jevk8QMKC
         DoK3shgxraZ15x/7rTaIyENce0dXfEFBk7QqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqvgBnkPf48/c8iQIpD40dYiZ/C4cQZKWA6sHzbPuDk=;
        b=V6xJtkzWBPAmUyAKjlHyOdCFjtJC8yhnxAkSg37ymYB/O5wtVk5BqgmeeIB+BhDTgF
         uCSPQe6lxssYZ/i3Qi92KFPCwS6+LHPlxgAJxlzgKbY5hpCjJt1XG4f/P/0srq0ORxjA
         DuHNcd5c/VlsbnhOiT+SyD0MMfwWY0dND7L8V9a3lsHlI/gilXeeJKmcd996raNX4TsR
         6Bcsmc1BMbX+fYEjQMo23PKpJnevyEPc7YMvXPR37AfJP6tHIIe9Py7uXYyPEa3d6pec
         5h1ELvpgs8FcriI9+EDGWcUPCuSolymP/paR/u4AYljkTvd9akncFVdbIBupl85x4q90
         RhMA==
X-Gm-Message-State: APjAAAXadM7By/PLBJwC6Ujp86zH8jEdPWc7Hj44O+UUx4vqCUGN77WC
        TeCfOiku5jVsd1OXrd3fm83nsrxO3xQ=
X-Google-Smtp-Source: APXvYqwMW+iYNxXh/YkP6uFm94MwF49ZlfSeNffWwH+8j15pQi1aykabt5cqz9/tmcCKPjKvYuaWLw==
X-Received: by 2002:a0c:e5c6:: with SMTP id u6mr29905412qvm.106.1570488526825;
        Mon, 07 Oct 2019 15:48:46 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id l129sm9027197qkd.84.2019.10.07.15.48.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 15:48:44 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id e15so6938928qtr.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 15:48:44 -0700 (PDT)
X-Received: by 2002:a05:6214:370:: with SMTP id t16mr29551583qvu.245.1570488523404;
 Mon, 07 Oct 2019 15:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191005101629.146710-1-ikjn@chromium.org>
In-Reply-To: <20191005101629.146710-1-ikjn@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 7 Oct 2019 15:48:32 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPKqVX6QJLB4OvNTGgfJrrEvKYcwzspYAQaicFpymJigQ@mail.gmail.com>
Message-ID: <CA+ASDXPKqVX6QJLB4OvNTGgfJrrEvKYcwzspYAQaicFpymJigQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] HID: google: whiskers: mask out extra flags in EC event_type
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-input@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Enrico Granata <egranata@google.com>,
        Ting Shen <phoenixshen@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 3:16 AM Ikjoon Jang <ikjn@chromium.org> wrote:
>
> Whiskers needs to get notifications from EC for getting current base
> attached state. EC sends extra bits in event_type field that receiver
> should mask out.

Notably, this patch was never actually landed upstream:

https://lore.kernel.org/patchwork/patch/1019477/
[PATCH] mfd: cros_ec: Add support for MKBP more event flags

and therefore, this EC_CMD_GET_NEXT_EVENT v2 handling is not yet truly
relevant. (i.e., no upstream-proper users should hit this bug yet.)
But that's also a reminder that we need a patch like this for *every*
cros_ec client driver that's using the event_type field. Other
unpatched drivers include
drivers/media/platform/cros-ec-cec/cros-ec-cec.c,
drivers/platform/chrome/cros_ec_chardev.c, and possibly others.

So I wonder: why don't we
(a) *really* try to upstream the above patch and
(b) fix it so that event_data.event_type *always* masks out
EC_MKBP_EVENT_TYPE_MASK
?

(We could still handle the EC_MKBP_HAS_MORE_EVENTS bit within
cros_ec.c, but there's no need for every other driver to have to know
anything about it.)

Of course, this is another reminder that we should *really* try to get
our cros_ec patches landed properly in upstream, because otherwise we
have a different set of bugs and features landing in various
downstream and mostly-upstream kernels.

Brian

...
> --- a/drivers/hid/hid-google-hammer.c
> +++ b/drivers/hid/hid-google-hammer.c
> @@ -96,8 +96,9 @@ static int cbas_ec_notify(struct notifier_block *nb,
>         struct cros_ec_device *ec = _notify;
>         unsigned long flags;
>         bool base_present;
> +       const u8 event_type = ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK;
>
> -       if (ec->event_data.event_type == EC_MKBP_EVENT_SWITCH) {
> +       if (event_type == EC_MKBP_EVENT_SWITCH) {
>                 base_present = cbas_parse_base_state(
>                                         &ec->event_data.data.switches);
>                 dev_dbg(cbas_ec.dev,
