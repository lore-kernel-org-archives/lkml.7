Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC52C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 05:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C1620678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 05:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHgLFOns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392423AbfIQFof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 01:44:35 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33308 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfIQFof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 01:44:35 -0400
Received: by mail-ua1-f65.google.com with SMTP id u31so711727uah.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 22:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWLbKiwRlS208Z3+3AMSNgvhyJJKUZ0x7Hzk0zm86yg=;
        b=mHgLFOns1Q8pXhphDAfob5kfnh4UcmO03EkmEF12HNV6uR4Qno8zQEPxHXzhgHUrcr
         kewUlr7NxVnQ4PnWNzV8t88xJLA3EKmTZUxISQDqOotlVDFgEd7zAQ/uPjFpd7Hldor3
         d9oBHQku82cjL3DWPdKTo2lBdvoYiUd6yB1XHD8EXnHAbSwbugEAF7vPCB7W+hcHHICC
         4XMgP+jZQENSLrAeTm/uNbxHaA0YjpvBJTs2fxmDN51BvYHMmzyk/2QYv9K2Vii18Xk+
         MsJRPeayYD3HVFu2SvFWk6qswSvGngTNlz2DrWjU6LOkjOQy1g2Osvw1nC+/G7RsHuC8
         Terw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWLbKiwRlS208Z3+3AMSNgvhyJJKUZ0x7Hzk0zm86yg=;
        b=M1A3lPhRXkHZAH6oOzbF3K2KGT/vSzpJcZwmTpAEcjT4D+50Nch3bHmlCrCcYz2udq
         tYwVopn44buB0Aj1zkdlIxclhfaurkcXSXA0zcUVu68tPEdZpOJag/GRSIUWhw+SGZBR
         zwBmPPOZ7LE/YkTwYuhVfCa4rj9X66lSnRv/3yug1rilY5I/zdEU+gnVby923iM6jRlt
         1sTLepy3NlqU+i1wVTItCR/XDLXeqvebfOyYWjuMeHKCeek6EiU/+htRPWbso3NG4jjG
         /9Vf44AL/X7rlh2UvXsQLfF1BC+HWwFWsyyQKwUK21YW9GqCtn3RzK2jaBBtEAQqMPqd
         gyMQ==
X-Gm-Message-State: APjAAAWl5UJxBxXUPj7ItES6On1FnN68HwYDQRsdnS98pb2VEsuG/JFd
        AYjOgTdvziub9MfEKxirblOdhR0Von3mAhTL5gqUCA==
X-Google-Smtp-Source: APXvYqykoJrSGi+xeUz/j8IFT5604ond2RCO1ES3sXqJPjir0wt/iu+bHY6zaeJiBuBtp/FFUSbJNrd1ImAhCmm6N9E=
X-Received: by 2002:ab0:539d:: with SMTP id k29mr612429uaa.67.1568699073725;
 Mon, 16 Sep 2019 22:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568240476.git.amit.kucheria@linaro.org>
 <c88947d18c65a692a8f314e4ad996d9d2a997997.1568240476.git.amit.kucheria@linaro.org>
 <5d7fe862.1c69fb81.8e5e3.2325@mx.google.com>
In-Reply-To: <5d7fe862.1c69fb81.8e5e3.2325@mx.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 17 Sep 2019 11:14:22 +0530
Message-ID: <CAHLCerMnFvMvAYOnJHoHwkMNhn1n=vpT1TL9nuGM8tBc0sDDRg@mail.gmail.com>
Subject: Re: [PATCH 4/5] clk: qcom: Initialise clock drivers earlier
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>, ilina@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 1:24 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-09-11 15:32:33)
> > Initialise the clock drivers on sdm845 and qcs404 in core_initcall so we
> > can have earlier access to cpufreq during booting.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
>
> Did you want this patch to go through clk tree?

Yes, This patch can go in via the clk tree regardless of the rest of the series.

Regards,
Amit
