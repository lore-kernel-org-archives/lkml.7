Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032AFC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 01:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4942084B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 01:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T9qVefZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbfFTB2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 21:28:12 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41857 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfFTB2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 21:28:11 -0400
Received: by mail-io1-f67.google.com with SMTP id w25so1316404ioc.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 18:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K+lJ3CLPTlV9tpNBKFgd0Xmeaz/SJ4QdPFY55va1FCk=;
        b=T9qVefZXg/l4TY1fZ5t4+FBcV8bawtYd7X1iwe2XqARuiVY+xJvg4NGnhUnJ/dR/K1
         Y9cB1lnaFpB2sOYEZkpB8u1dWTE9wM6t07kCXXzXW3SqvSe6lqHfvnhmN3QyN0W4IRi9
         CTTi0MmuSSPbmAZXhKPRSNz3zuDNzA0674j2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+lJ3CLPTlV9tpNBKFgd0Xmeaz/SJ4QdPFY55va1FCk=;
        b=FDUJIqk8vCrfjiB5rWTEwdgQ03iA/P0Hug/9kt4vlwtPo0Pr9cTMJt7Dq+DE5ioJyr
         zE0i+ZoTbai3M2wtJseQR/GsBFVcX7qBF7mvUll0iO8M5eFQPlSKlBalCJdlXGLQz6/3
         LM5NiZkMWydyaJZZBE19dLvOH66By25hdc8oIsW1VVZn9N8VQUqMkqPfjUw72h/8Gl/a
         O1Ve4RWOrBgvVlIT4FHhzqF/R1WFXDJ6hQLslhxQ/PkNjVpTU7X3Xihh1XuHUbTqQlqN
         pb5h6hqd7wqw5dSjB6O21ybkQC0GA+PGkvir21wEQwM6awRVNWazdMsCW9TkX7kCzICr
         c6Nw==
X-Gm-Message-State: APjAAAUzinefFLHfJRh/Whs2I9RNEKHKB7pwV8a4iGfjxxHiFfIcKALi
        jvvqrjDodYOym14DU6efvSCC0AFtN3A=
X-Google-Smtp-Source: APXvYqxp9aX1saz2EW6H9mUyv6K5WGpLW8KhGgvGJzTY6+PjksMifKnkIHdtCCxcioxpuTKqTJekNw==
X-Received: by 2002:a02:914c:: with SMTP id b12mr14411283jag.105.1560994090948;
        Wed, 19 Jun 2019 18:28:10 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id p63sm25055819iof.45.2019.06.19.18.28.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 18:28:10 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id r185so442791iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 18:28:10 -0700 (PDT)
X-Received: by 2002:a5e:d615:: with SMTP id w21mr12594037iom.0.1560994089873;
 Wed, 19 Jun 2019 18:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <1458265206-15733-1-git-send-email-heiko@sntech.de> <1458265206-15733-5-git-send-email-heiko@sntech.de>
In-Reply-To: <1458265206-15733-5-git-send-email-heiko@sntech.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 19 Jun 2019 18:27:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U23+5pcze=6zDTx0dAYF8HTmbR8s8zem93VhgYgaZeGQ@mail.gmail.com>
Message-ID: <CAD=FV=U23+5pcze=6zDTx0dAYF8HTmbR8s8zem93VhgYgaZeGQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] ARM: dts: rockchip: add startup delay to
 rk3288-veyron panel-regulators
To:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Yakir Yang <ykk@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Fri, 18 Mar 2016 Heiko Stuebner <heiko@sntech.de> wrote:
>
> The panels need a bit of time to actually turn on. If this isn't
> observed, this results in problems when trying talk to the panels
> and thus produces detection errors. 100ms seem to be a safe value
> for the time being.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm/boot/dts/rk3288-veyron-jaq.dts    | 1 +
>  arch/arm/boot/dts/rk3288-veyron-jerry.dts  | 1 +
>  arch/arm/boot/dts/rk3288-veyron-minnie.dts | 1 +
>  arch/arm/boot/dts/rk3288-veyron-speedy.dts | 1 +
>  4 files changed, 4 insertions(+)

I know it was 3 years ago, but any idea how to reproduce the problems
you were seeing without this patch?  I believe the downstream kernel
never had any delay like this and I'm not aware of any issues.

I wonder if the need for this extra 100 ms delay is no longer there
now that we have:

3157694d8c7f pwm-backlight: Add support for PWM delays proprieties.
5fb5caee92ba pwm-backlight: Enable/disable the PWM before/after LCD
enable toggle.
6d5922dd0d60 ARM: dts: rockchip: set PWM delay backlight settings for Veyron
