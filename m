Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609EEC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFAB214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uEweKZJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfDWKfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:35:32 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:32892 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWKfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:35:31 -0400
Received: by mail-vk1-f193.google.com with SMTP id x194so3084525vke.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 03:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PNF64pi2itufQBxUFTFNhv50HBLeH2Ap0sntQKQ3f1w=;
        b=uEweKZJedxr52kdEb1EQ+qAytoCpKzkkNkio0S7iFPL/icJ6TDLRgGrBogdBFI2qtB
         vSw62oslP4U3Gv2T/qDElp5vG8nQVqY1/LIq024azcBasS7lgSzg4noU9tYr1U6Q8JdA
         jIR5z+DwXgxMBGfqLd1iY8biaP3w7hgr6PxZ9COMzCvmrjYat3LuodUXezDC5pjjckpK
         uN0a6UVjuYMaynBkf4/0BGWKTORawoBBxAlYjCA9rDi4Qx0qnESmSc1gNbhN+0tlqrBx
         CzOBhA741UsRmgmtMQkhjrOB6QMaeVAo31PHbgRJRhfQ4hTnoj1Zh013HItXWYtl4ieU
         /qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PNF64pi2itufQBxUFTFNhv50HBLeH2Ap0sntQKQ3f1w=;
        b=AOLcRxWhiKHq0IzDnTULZui1u1kInOx3EY/f9dx3tQ71H2ouMv+eoBJawqo5ZvUOvZ
         DrUe1FEfRzb99R0nfVL+81PiCtbwMsFvdoWuNZ9iJcfo3Ekguv5/u6vvltmEHrAyAsLn
         ZVm/7pZiuYAfs4I1n88EbNRTe6y9KxnLnHpklRKf9/V77N+JTleQBopMTjzwEjvKMh+r
         4gCQ6sZxCJXgx96qsM8uEAIzA4VhqsEfnkO4zg0QVNr2cXWXslvLKQbmiVwHTfIpg6lj
         SpIc47nLWrpK+Ov/uwbraY7NmjpOv6CswqD83RwnkxGKNCVMmOl4Q+IpuEfru3c7uGF7
         dJcQ==
X-Gm-Message-State: APjAAAWO8/mkxWSCK1adrZHcHdecXAgwwF7bKK6NxPDKZxxdz6n47+JN
        TJnXhtkbydWdv3UHeHrFOQxcGjl+x4TBavqnxX2s0g==
X-Google-Smtp-Source: APXvYqxocFfPrpeMB2Mb45qdeREdLOsXBAf8xnhH/PvtHXtLKorwklxLUHAD4xqkX5XKcUujgtlWXTGk8pZFNOTURgo=
X-Received: by 2002:a1f:bc8d:: with SMTP id m135mr13237606vkf.68.1556015730374;
 Tue, 23 Apr 2019 03:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
 <20190402161256.11044-5-daniel.lezcano@linaro.org> <CAHLCerNvp9Bb0TwCcO91ecrbzKGe7epCHFk=fx4RGJgHDE_BRA@mail.gmail.com>
 <9afb2911-512a-9048-9ed8-6aa9dd29a848@linaro.org>
In-Reply-To: <9afb2911-512a-9048-9ed8-6aa9dd29a848@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 23 Apr 2019 16:05:18 +0530
Message-ID: <CAHLCerMMQRY-zjjKbaLA=OXQPo-oS76yNYYhTOBmG05jSS8RtA@mail.gmail.com>
Subject: Re: [PATCH 5/7] thermal/drivers/core: Remove depends on THERMAL in Kconfig
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 9:03 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> Hi Amit,
>
> On 02/04/2019 20:51, Amit Kucheria wrote:
> > On Tue, Apr 2, 2019 at 11:14 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> The dependency on the THERMAL option to be set is already there implicitly
> >> by the "if THERMAL" conditionnal option. The sub Kconfigs do not have to
> >> check against the THERMAL option as they are called from a Kconfig block
> >> which is enabled by the conditionnal option.
> >>
> >> Remove the useless "depends on THERMAL" in the Kconfigs.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>  drivers/thermal/Kconfig       | 2 --
> >>  drivers/thermal/intel/Kconfig | 1 -
> >>  drivers/thermal/qcom/Kconfig  | 1 -
> >>  3 files changed, 4 deletions(-)
> >>
> >> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> >> index ccf5b9408d7a..d8aa7fac8c56 100644
> >> --- a/drivers/thermal/Kconfig
> >> +++ b/drivers/thermal/Kconfig
> >> @@ -24,7 +24,6 @@ config THERMAL_STATISTICS
> >>
> >>  config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
> >>         int "Emergency poweroff delay in milli-seconds"
> >> -       depends on THERMAL
> >>         default 0
> >>         help
> >>           Thermal subsystem will issue a graceful shutdown when
> >> @@ -152,7 +151,6 @@ config CPU_THERMAL
> >>         bool "generic cpu cooling support"
> >>         depends on CPU_FREQ
> >>         depends on THERMAL_OF
> >> -       depends on THERMAL=y
> >
> > This will break the intention of afa1f2ab43d48d0e1. At the moment, we
> > need THERMAL=y if we want cpu_cooling.
>
> The patch 1/7 changes the thermal option from tristate to bool, so the
> thermal is compiled-in always. The dependency is no longer needed in
> this case. Did I miss something?

Sorry, the threading of this series was a bit strange and there was no
cover letter. I wasn't cc'ed on the other patches, so missed the
earlier changes. This series looks good.

FWIW,

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
