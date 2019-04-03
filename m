Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D3AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBDC206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oW5H4DD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfDCVIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:08:55 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37526 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCVIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:08:55 -0400
Received: by mail-vs1-f66.google.com with SMTP id w13so66757vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 14:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUmBJWqO62UFdWqTqgDAL/OAcgHOw4NaLhjkbb1riwc=;
        b=oW5H4DD+BHdgOkrvB4go1u/qrjq0xcNUrai71mjD2+BYVnXgg5Sh6OzQyjzuuvUjCC
         tDl9tl1xTLM7EzoihkeRVhe0s/roxN+7Tk4WwizzI+KMUUQySG/FArwNLZFLlRbRy877
         QniRopnDKYRRSfvTUqJxkNuVSYG1vWrYrCjls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUmBJWqO62UFdWqTqgDAL/OAcgHOw4NaLhjkbb1riwc=;
        b=XJ07fZjoC6Ef9Bd2Uzn+Ye7y088BigrAiq3ugwf9EPI5ptlophQRvYNmSetmgxf/lx
         RH7TKh+fxZYyUrixCstpHbdCWx7zX59O8hnKKfTX8JbS2XBaXDLYpsdv0H0mdurjYJM+
         uXVeImquj7ynOiYJ8dLv4Wgi0jZwOH0TcQyAt0t37XsEzNXGkl3T7UKZOpZcpMUf1Vab
         HKORmU2Bj2h0PKjW7w/2RV2+OEQa0hDQfrugRDzZ499oGC9rIZOpLXzi1xlTKSCJs02J
         Z5cWfsI5la8ZowIO5i3P9MbjFCQq55keA9f9RK1Ut3IXkmOGLcHLFG+9UmSGAIjHxfyf
         8pJQ==
X-Gm-Message-State: APjAAAVWQmIta+eo4EObYVY0GrrK22o+yF0zKcnrRWnMXYnhLceosWPF
        PbGe8MiKJ38FjGW8TIrtWY9lkuNWSSs=
X-Google-Smtp-Source: APXvYqzpQnC2Klc8uO+StThgK9Ex2qkNXb7yKINOawDKs7hpje59JsbVnyh0oogigfz3cFJqCa16bA==
X-Received: by 2002:a67:b44c:: with SMTP id c12mr1843190vsm.169.1554325733811;
        Wed, 03 Apr 2019 14:08:53 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id l143sm5265913vke.46.2019.04.03.14.08.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 14:08:52 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id d15so131476vka.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 14:08:52 -0700 (PDT)
X-Received: by 2002:ac5:c2cb:: with SMTP id i11mr1711223vkk.51.1554325732106;
 Wed, 03 Apr 2019 14:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190403203137.203582-1-dianders@chromium.org> <20190403210436.GS112750@google.com>
In-Reply-To: <20190403210436.GS112750@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 3 Apr 2019 14:08:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Whd4upxDDOrmVt=HgjEiGNuL2FccOfezpAFsy5yB55JA@mail.gmail.com>
Message-ID: <CAD=FV=Whd4upxDDOrmVt=HgjEiGNuL2FccOfezpAFsy5yB55JA@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: cros_ec_spi: Transfer messages at
 high priority
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Simon Glass <sjg@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ryan Case <ryandcase@chromium.org>,
        Randall Spangler <rspangler@chromium.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 3, 2019 at 2:04 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > +static int cros_ec_xfer_high_pri(struct cros_ec_device *ec_dev,
>
> nit: the fact that a high priority workqueue is used is an
> implementation detail, since the driver has no function to perform a
> transfer with 'normal'/low priority there is no need to distinguish
> between the two cases. In this sense I'd be inclined to remove the
> 'high_pri' from the function names.
>
> Sorry for not mentioning this earlier, I focussed on other
> details, anyway it's just a nit.

I still kinda like having the "high_pri" in there since the point of
this function is to transfer the work onto the high priority
workqueue.  It's not an exported function so having the implementation
detail leak into the name isn't a bad thing, is it?  ...so unless
someone else thinks the name should change or you feel strongly about
it I won't plan to change the name.

Thanks!

-Doug
