Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6710C46470
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8036D21726
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f0K0xxpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfEQSfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:35:14 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45930 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfEQSfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:35:14 -0400
Received: by mail-vs1-f68.google.com with SMTP id o10so5208256vsp.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7Ld6ak/BcDR+qMn0+Bwsy5o52SxdEie1Dd6vVWMNQc=;
        b=f0K0xxpVCF0ZLjARllhNmUlWPrNzNN5Nc31omR/w66TNZzX+6LZi+uLIHRG3pOjbld
         Gz5edzdihDaQQN/cpB2qydPoWipFpiGBOL0D0BXOabrGcCiX/KO1sGrfrMjUCGjDWKd7
         jKY9WFgb8JoT9kHtActzd8jbPHp6fFMTBZJ+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7Ld6ak/BcDR+qMn0+Bwsy5o52SxdEie1Dd6vVWMNQc=;
        b=CZjKh/xdtAoSaouIpEsKitlC1MR8FU3Q4VAQyfK6CeysX/k4x8AtTUDveWSawsZL49
         /xf3esvnY/efSvjOSaSUmYZ7O7o3pHWLdv/7fF7OL2nlAyQi5mkreJQaY0aSJrR2E2Re
         0IAq6CLWYjCThsf3a0IcDyRUtD+SJppOxhkeiPqSdKhGkk2bTyQSBjYeCfoSfixg5BVu
         UJuwS+xtKw9m9ey6h7PwLR3T/uxp+CTOOYhg1q44Uha1zzVB+JEDH8X7A4trJLXrAdY3
         XkqT+w2zY1HOGR76R/QazgGgWHJ+P9xJmMKq9LOgr+kj55+gpN/b+hNSbep3/tJfZhCA
         9AQA==
X-Gm-Message-State: APjAAAVHVdjw2MItaW+7jpQIpFWny4VwRK52qO8yJOsXGUPIdd+V9iUn
        p7KMECuaXrnj9URLVJsoFRg/BcLxKSs=
X-Google-Smtp-Source: APXvYqz3UF3iXaEGH8yF28GWhiso2NQbDTSBBc3wXDcyQodpZ+K35LKVmgNqlaOGmjhbyAeXclmGdA==
X-Received: by 2002:a67:f2d6:: with SMTP id a22mr18581373vsn.171.1558118113218;
        Fri, 17 May 2019 11:35:13 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id v14sm2335913vkd.4.2019.05.17.11.35.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:35:11 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id t18so3063045uar.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 11:35:10 -0700 (PDT)
X-Received: by 2002:a9f:24a3:: with SMTP id 32mr5229332uar.109.1558118110537;
 Fri, 17 May 2019 11:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190517015305.23194-1-robdclark@gmail.com>
In-Reply-To: <20190517015305.23194-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 May 2019 11:34:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XWz9iigg-GWrKZdsYePhH7==d3hZ9kZDXKeEuwLXOhaw@mail.gmail.com>
Message-ID: <CAD=FV=XWz9iigg-GWrKZdsYePhH7==d3hZ9kZDXKeEuwLXOhaw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-cheza: add initial cheza dt
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 16, 2019 at 6:53 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> This is essentialy a squash of a bunch of history of cheza dt updates
> from chromium kernel, some of which were themselves squashes of history
> from older chromium kernels.
>
> I don't claim any credit other than wanting to more easily boot upstream
> kernel on cheza to have an easier way to test upstream driver work ;-)
>
> I've added below in Cc tags all the original actual authors (apologies
> if I missed any).
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Sibi Sankar <sibis@codeaurora.org>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Abhinav Kumar <abhinavk@codeaurora.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> Updated from review comments and squashed.  I left out the the patch
> related to deleting gpu_mem/zap_shader nodes as the corresponding
> patch that adds them in sdm845.dtsi hasn't landed yet, but once it
> has we will need to revisit that patch for cheza.
>
>  arch/arm64/boot/dts/qcom/Makefile            |    3 +
>  arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dts |  238 ++++
>  arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dts |  238 ++++
>  arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dts |  174 +++
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi   | 1326 ++++++++++++++++++
>  5 files changed, 1979 insertions(+)

Looks sane to me.  Thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
