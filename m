Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7B6C49EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC6F20869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCvudKjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbfKEJtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:49:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41470 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387867AbfKEJtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:49:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id m9so21001077ljh.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 01:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAJe5ziKrCKK7rX2BdKY2ykoCXQoTfLqEiQktMB0pZc=;
        b=XCvudKjB3WldlrlLUYWp/rPSkhOTlZs7uTgllg94l9Dj/pvnvq+ZHihNGllZ5Cnfq2
         3YEIZcIKR7ab5YkIh0hd3sd3vHojbv0gNSkvu/8KbJzhxt6ln836ALEKFfSCMzu/KCdj
         CIm/wm9HhbRTGIlU7t98t9inx4s3syMNih/JbId2T8lWPiVQPkJfvBb8fXfHrmq8wVvu
         puto/O0rx5kW+R1PhNelEX7ydVAXKvbm31QA1dx+VlQegxySg7VaY9I/nwJ+ThZ/HjYs
         ZRMKjym+sv62w8vchDShhPjQ+J07r0+nWHFQAxFnFqO1NGw6cI3NdDud7gfMsrAp0dfG
         HBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAJe5ziKrCKK7rX2BdKY2ykoCXQoTfLqEiQktMB0pZc=;
        b=nJp2SVd3sBHJnYYgnm6TY2wTPLahs1VvDwOzbDyRxUp4HuJ8tDljsoDIjLuY4u479N
         rjhwmX/lLqshGrPNTLhzMCLHTO3LdGZ9JtmdoRtM2e0o+t6yGT/Mq9fUA4kIx0TIFCk4
         VxksxQTduPQPWcPCI50erpWiH1Qf6qW3d5CESlfwA/IAbqZtogJ013kRDCOi+QiWN+mh
         2IJ4+bxxZ+U3JxVS0F4igboDgWhfQ8BFEUODvE0N4j+BIuzfH4t4kX0WZTTfRFeSdYQs
         mtN+EDgWEec4kR4dbkfS4o0fz2gATd2q5YyBQpds47QdAj7nFb1v1CrioZ7NxmBuUlyJ
         h7UQ==
X-Gm-Message-State: APjAAAWlZ0ouSa3eK1Z+QicHI6LFfUUMOwQOphCoA0E0+/LTW08TeCUJ
        1s3eOtbQwAjsJ1ENgQuzlOrt4LLeI0tJnP6/Tw8pnQ==
X-Google-Smtp-Source: APXvYqwzKGwdM6Y55E27yheMCcnZ7qcC3Lb2zH9XzpcvqFMRqUcMcymk+LRc2yyxdiCWk004eqbcBGD0s8yWxwr90pI=
X-Received: by 2002:a2e:a0c9:: with SMTP id f9mr22644979ljm.77.1572947358711;
 Tue, 05 Nov 2019 01:49:18 -0800 (PST)
MIME-Version: 1.0
References: <1572419178-5750-1-git-send-email-mkshah@codeaurora.org> <1572419178-5750-2-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1572419178-5750-2-git-send-email-mkshah@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Nov 2019 10:49:06 +0100
Message-ID: <CACRpkdbjFSiSmRrbjAm3xD-2jYcyHPb0U9L8rqMPM44_cQi8Bg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: qcom: sc7180: Add GPIO wakeup interrupt map
To:     Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, lsrao@codeaurora.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 8:07 AM Maulik Shah <mkshah@codeaurora.org> wrote:

> GPIOs that can be configured as wakeup sources, have their
> interrupt lines routed to PDC interrupt controller.
>
> Provide the interrupt map of the GPIO to its wakeup capable
> interrupt parent.
>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>

Looks good to me but I'd like to see Bjorns and preferably also
Lina's review on this.

Yours,
Linus Walleij
