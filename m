Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA39C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCA522CF5
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="nzaLeW0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfHSSaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:30:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35857 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfHSSaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:30:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id k18so2592480otr.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 11:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/VeAeKX1xTDl+s4tBgBAHJpn7eS0PK+CB1vnSZNpOE=;
        b=nzaLeW0lOmuy34oquCtsLKqtgPATh1wWb/oREDrGAPrZMOi7mLLlCqwJDwHzuQI1zQ
         nFQaknob2bqdEOyUP9e8S6auemmhPRtBmAsn1hYWWsgeyTnK/NTt3s+W80KuAGTbREo+
         HJZVKXhv2NdFL2epDgHBMma/rfIYstd8Soysr4+OiXVDyyxAAne/xrVRaR4wozSrIX0j
         LCDAMJexdqbJwN3F5eTUoEz2yCtV+r3nFFGEp/BRaVsoOfko4zwOgIoZfzjE92uNBKJ4
         Mw+eS9L/SV/u6xj2Osl+u5p+i4hHMK1U5rzO5+qAAupURpQtqupRLpUOlA+JSLKzViM9
         fvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/VeAeKX1xTDl+s4tBgBAHJpn7eS0PK+CB1vnSZNpOE=;
        b=DF3VJPI2kt2MaCXV6zw6yYLCaOjc/LtUcJ9eMXNRtuLoAx9QtNY5UxA90ABQOWprzI
         rKSGBkoWnV9FGZlIDxCRsu2Zx/Y9RszPwhqf9CGMZCoGzS6M1FLx1JjMzjkJjUalpyB0
         GwDg2d0xFR0DTbvMSupSTLPRP3T96xCruGz4v1Xp9uUpGdtJv/XNZw3XvtWy3/GZ1kxw
         n4w+hmyw467nKuTispObxplbhhgAc4NBsFVgh/3UmXB/wlFFGMhsfTsV8fSbGwEFQNzP
         /6uVTx9WpEad9hQvGmR4hCRBzkuA3UJ+x6ISP0c3VrNl0xV79i/YQP7i7Ekeb3rKkyCQ
         9X2Q==
X-Gm-Message-State: APjAAAVK7raOPipUEXYKD/JchwAawKLzBJe2YQbueP5kW43HZWtPyZwk
        hzMjh3n+d0Lm9jbwl+HooVGRHd/5CutKpexKXZhDOw==
X-Google-Smtp-Source: APXvYqzSVE22VDiQu8uGHa8Q+AjRI72tU3whMdq4pqkn94MHCeMT3uvhcjwzyjipLlogSVD3xRNpahFaVw6maSbIuSo=
X-Received: by 2002:a9d:5911:: with SMTP id t17mr18326897oth.159.1566239454336;
 Mon, 19 Aug 2019 11:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190819175457.231058-1-swboyd@chromium.org> <20190819175457.231058-2-swboyd@chromium.org>
In-Reply-To: <20190819175457.231058-2-swboyd@chromium.org>
From:   Tri Vo <trong@android.com>
Date:   Mon, 19 Aug 2019 11:30:43 -0700
Message-ID: <CANA+-vBZF+KkB-ZWhjpRS=hwhk+6pM0mmUsj8gwxy0VcKjqG2Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM / wakeup: Register wakeup class kobj after
 device is added
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 10:55 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The device_set_wakeup_enable() function can be called on a device that
> hasn't been registered with device_add() yet. This allows the device to
> be in a state where wakeup is enabled for it but the device isn't
> published to userspace in sysfs yet.
>
> After commit 986845e747af ("PM / wakeup: Show wakeup sources stats in
> sysfs"), calling device_set_wakeup_enable() will fail for a device that
> hasn't been registered with the driver core via device_add(). This is
> because we try to create sysfs entries for the device and associate a
> wakeup class kobject with it before the device has been registered.
>
> Let's follow a similar approach that device_set_wakeup_capable() takes
> here and register the wakeup class either from
> device_set_wakeup_enable() when the device is already registered, or
> from dpm_sysfs_add() when the device is being registered with the driver
> core via device_add().
>
> Fixes: 986845e747af ("PM / wakeup: Show wakeup sources stats in sysfs")
> Reported-by: Qian Cai <cai@lca.pw>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Tri Vo <trong@android.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Tri Vo <trong@android.com>
