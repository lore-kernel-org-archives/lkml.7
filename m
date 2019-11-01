Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B3CCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763C121855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fef9ITir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfKAWxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 18:53:40 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44600 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfKAWxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:53:40 -0400
Received: by mail-io1-f66.google.com with SMTP id w12so12513511iol.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bf69Nkr7XBkmTO1YD+9sNVV+WBGtzvC5rxPzFLKlWNo=;
        b=fef9ITiroUgvdPL9dSereSDmc2uHGR7fnIsdwnXDmA0MFiLxHlMcWFQLIHWQVYz488
         wepTmOx6B3NDyuQStyl0eD2Y0ifgeBrEdd4uyG48SyEac7cZmtepCiNECLJ5HIE9h1Ku
         nuK5ExP5bNiE27blrdbkdwG0Y7XVk8OxK0D1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bf69Nkr7XBkmTO1YD+9sNVV+WBGtzvC5rxPzFLKlWNo=;
        b=P7jvD4Tvpukt3GfqfiGUDySKkuZSJIQdzVrXDX84WT36KvwvXOFTlA5bGDU9yVfy1G
         AvGLts6+r/QAwIpMZTNXCJoVAAmBG4RJ2UQ9u8eBjUb8dI5ApNmLcYPCbdCAfMQNYXlP
         u6X2uIakMi20ekAb4aQ6JCvgr2PU2chbvfJAR8qQWhU/l/moYT6ZixqIqZYn9S49scg2
         GNoFvz5y6+/r8W3t7lOzg2VslHqk5njRlD3XRoZ4bkBdzx1aNaX/DdUggHafM3nk1vpg
         YICNvyhJWwZSMIyI4J2bwsRJiO+SGd1vzuz/hoKQhi6pgeSim3B0jS6zwD/ajdFBoUq5
         lNNg==
X-Gm-Message-State: APjAAAVQ1KNDQWEKXrJZqLm+Ez3mXeo7OEmXtsDqj74u5ZioSMP96QWl
        RPzJlg+F8x7237oeHgcedCvWixxer5A=
X-Google-Smtp-Source: APXvYqx+QVvXgfeevL2lSk6GX1PQA2KYhmgQblLE3STqbwD964hC38xK11A0hjDHPk5zADNTUP/BhQ==
X-Received: by 2002:a5d:9e58:: with SMTP id i24mr13407613ioi.255.1572648818983;
        Fri, 01 Nov 2019 15:53:38 -0700 (PDT)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id k20sm512379ioc.70.2019.11.01.15.53.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 15:53:37 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id t9so7715532ils.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:53:37 -0700 (PDT)
X-Received: by 2002:a92:d0a:: with SMTP id 10mr14227736iln.218.1572648817422;
 Fri, 01 Nov 2019 15:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1572526427.git.amit.kucheria@linaro.org> <18717de35f31098d3ebc12564c2767b6d54d37d8.1572526427.git.amit.kucheria@linaro.org>
In-Reply-To: <18717de35f31098d3ebc12564c2767b6d54d37d8.1572526427.git.amit.kucheria@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Nov 2019 15:53:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X3o3JKye8pZZckEtk=9XNoajf-Kj8XGUemut7NS2bZjw@mail.gmail.com>
Message-ID: <CAD=FV=X3o3JKye8pZZckEtk=9XNoajf-Kj8XGUemut7NS2bZjw@mail.gmail.com>
Subject: Re: [PATCH v7 03/15] drivers: thermal: tsens: Add __func__ identifier
 to debug statements
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>, masneyb@onstation.org,
        Stephen Boyd <swboyd@chromium.org>, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 31, 2019 at 11:38 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> Printing the function name when enabling debugging makes logs easier to
> read.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-common.c | 8 ++++----
>  drivers/thermal/qcom/tsens.c        | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)

Obviously my opinion doesn't trump maintainers ones, but I have always
heard that this is the wrong thing to do for "dev_xxx" debug
statements.  Specifically:

* For "dev_xxx" statements, the device name is already printed which
is pretty good for getting you to the right driver.

* Once you're in the right driver, error messages should be unique
enough to find the right function.

If having __func__ in all messages was beneficial then the "dev_xxx"
macros would include it by default.  They don't and such things just
uglify the logs and chew up log space.  I suppose you could try
including a CONFIG option to add it to all "dev_xxx" functions and see
if it would be accepted?  Then you can turn it on locally.

Using __func__ in cases where you don't happen to have a "struct
device" (and can't get one easily) makes some sense, but otherwise I
believe it should be kept out.

-Doug
