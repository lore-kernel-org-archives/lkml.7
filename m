Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D7DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111242083D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8m9aVN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfCGMCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:02:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34971 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbfCGMCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:02:23 -0500
Received: by mail-pg1-f193.google.com with SMTP id e17so11094948pgd.2;
        Thu, 07 Mar 2019 04:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cCcMg5pc+2dNLPmNs9eB2iLJmfA5xUcfuYlcrGmXBtI=;
        b=t8m9aVN1NyLjx3zvRRZW/3NykwiPUA78aCbsbuDmMg6BeqZP3fQukxDil6iSqzp+R1
         VRJ/qnURD8zjBcIyT69Dp0Mx4S944f0JkP01+J2Xx6VAwtkqbKD6qAvtXJXhcr5tMwQW
         xBMNXZqsvI717a1lUa3mLvRl5eRL3dOImbNicA6T8lKqEoXpUIYdekx+r18WEfehXGQI
         L+VQu35YuFAx+cuAp7OOALV89YItWnm49WZwajN4fZhPPkrzUrBJ5+WQOPhG2RvOgULZ
         GrNR3Bl3xDnlOd5k3ILm3W0jdoR+3vSph4aS7SDa1diIi0acPY+fQZis2rmNX7DOwEok
         b6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cCcMg5pc+2dNLPmNs9eB2iLJmfA5xUcfuYlcrGmXBtI=;
        b=FybYo4FAiFB50vNXNfBJamhkmfVI3gezBFcdreJ2gLD++uxkufykH7VvckSBT1Ivmk
         oQtw+bd1fiQQM2SLfp4bz7RJjM+plP6j/USbr4Hh/7gHr92exbvogL4r9t45d3ge2xaM
         shr6ipHoEpSRMcd7FNZmVoMDrc0Xf5NsC8fL4T+zI+yee/Aqz2rCLpj4BmdRNzNTE8DE
         1sk5k1pcf7TXHA9UrNmDYO/t8/iGz6sXO3B5zkKBoNNvFLZ1nfMUz+aBVUYoAeH3gPnQ
         GsOMYs5S4c/UpQPe/UtwNplz2oel51HkTDI897CDXIj4K1HAwmTkR7LxKlWp9pShRlGU
         oYnQ==
X-Gm-Message-State: APjAAAU4agq/BNgZQRFCf4qTtTdECXM5jqctcV6DEQaUyB+h6L+Jp6AP
        CyJTZtI3SHwZarY/taRHBaY=
X-Google-Smtp-Source: APXvYqx5MhCcSKXMxnG5wwoct3amjub16sCaozTvfpqlDSxmpqAhXnq4a3i6NMkiQbsgY16Cg59N1A==
X-Received: by 2002:a65:64d9:: with SMTP id t25mr11165549pgv.244.1551960141488;
        Thu, 07 Mar 2019 04:02:21 -0800 (PST)
Received: from icarus ([2001:268:c0a4:120d:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id q62sm14179288pfi.183.2019.03.07.04.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 04:02:20 -0800 (PST)
Date:   Thu, 7 Mar 2019 21:03:13 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Patrick Havelange <patrick.havelange@essensium.com>,
        jic23@kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 0/7] FlexTimer Module Quadrature decoder counter
Message-ID: <20190307120224.GC7851@icarus>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306111208.7454-1-patrick.havelange@essensium.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 12:12:01PM +0100, Patrick Havelange wrote:
> This patch serie is to be applied on top of 
> https://patchwork.kernel.org/project/linux-iio/list/?series=147
> (a more recent version of the serie is available here : 
> https://gitlab.com/vilhelmgray/iio/tree/generic_counter_v10 )
> 
> Main changes in v2: 
> The code is a bit simpler, thanks to more use of devm_* functions.
> The polling/32bit signed version has been dropped, as not needed and
> no other driver is doing that.
> 
> 
> Patrick Havelange (7):
>   include/fsl: add common FlexTimer #defines in a separate header.
>   drivers/pwm: pwm-fsl-ftm: use common header for FlexTimer #defines
>   drivers/clocksource: timer-fsl-ftm: use common header for FlexTimer
>     #defines
>   dt-bindings: counter: ftm-quaddec
>   counter: add FlexTimer Module Quadrature decoder counter driver
>   counter: ftm-quaddec: Documentation: Add specific counter sysfs
>     documentation
>   LS1021A: dtsi: add ftm quad decoder entries
> 
>  .../ABI/testing/sysfs-bus-counter-ftm-quaddec |  16 +
>  .../bindings/counter/ftm-quaddec.txt          |  18 +
>  arch/arm/boot/dts/ls1021a.dtsi                |  28 ++
>  drivers/clocksource/timer-fsl-ftm.c           |  15 +-
>  drivers/counter/Kconfig                       |   9 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/ftm-quaddec.c                 | 356 ++++++++++++++++++
>  drivers/pwm/pwm-fsl-ftm.c                     |  44 +--
>  include/linux/fsl/ftm.h                       |  88 +++++
>  9 files changed, 519 insertions(+), 56 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
>  create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt
>  create mode 100644 drivers/counter/ftm-quaddec.c
>  create mode 100644 include/linux/fsl/ftm.h
> 
> -- 
> 2.19.1

Patrick,

I see you dropped the polling support in this version. If the need
arises in the future, we can discuss a possible ways of resolving your
latency issues; I imagine interrupts during overflow/underflow events to
be a common behavior among counter devices so those too may result in
latency issues as you discovered in your case.

Jonathan,

If you are satisfied with the changes in this patchset, let me know
which patches you like and I'll add respective Reviewed-by tags for you
for the next Counter subsystem introduction patchset submission.

William Breathitt Gray
