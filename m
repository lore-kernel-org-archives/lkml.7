Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CBEC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781EC20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZffpFYBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfDHKbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:31:00 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46202 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfDHKbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:31:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id x188so10028457oia.13;
        Mon, 08 Apr 2019 03:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bf7SVbXVHsaF4+XZ5unw9bMrO6ItzHO0anxO3aCT3Mo=;
        b=ZffpFYBNQXXfPsuht/L0Qp9wTuWwFxxxVepqKWhl+a0A0L4cEL1FTGTIdibdcUycKp
         OAXDbvONhX6bs3NdTkyAuj3zRAoafslP4OILvvovfrYaygHd1Gqpr67/OUH+rOgG60CV
         Ap3C+mt205E35iVcxLs6huOScXLnBs2GDwW4ZFEtxcgh4BGlNfB52uQn7Wtuhh/xJYDZ
         2OV57hbt58uzoNR16w/2ayUbhPqbjz9eLOnZaTJ0B+Nfyi3FArlVKuHTK+Ym3EorvMtg
         3agevs0S5kpoOWbL1WyCq0GFBztGpnOlJAqf4+hYB6dSxkKFaQqucpZscuKt78BXW8VI
         NCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bf7SVbXVHsaF4+XZ5unw9bMrO6ItzHO0anxO3aCT3Mo=;
        b=jp2P8a8I29V/MDg82pI5f3XJyXlWNHkW2BC0JH2eJErtuEbXE7Osf9u8f95dL6iFAz
         +se0kEdN1eb5+tZbpFWTDpESfLW3DN6INMP+9T9PMIelF4fqXSN4vOeRN478Vrmftxuf
         W/xsuD/hQALvMIFCdM3/JDkoTHq1bp8GFzO181p7TzwXDZZ8lCgW5ktV3fRHX6HL2PC6
         jQHwI0e1uthdnNoiKGkjjpohWgFCGUheuBZp79i46HTN1IBQHWK5J0o53v1DYRsGc914
         vUUZyH7AVL3+HjX8bZBXeR0HMGeGQ4iqBUWHttFBHDEFEJQMxM07PsNZFpKCN1L+nfFC
         BOTw==
X-Gm-Message-State: APjAAAXvj1WPP7seu26+WXB9jgPleOE1ecuiNEOztrNprbOXyueaNFyN
        VaK8sZFw/WUBR2F4zPhIDAVshhPfvs0h4l0sJQmaCQ==
X-Google-Smtp-Source: APXvYqwzoXl00F5liRhIaS8aOLixVY9QdfN5BIw7PhVYTzClSrNStagsZs+U+6c1/3MWNqavYNfW0HzDd6Gre5d2HnQ=
X-Received: by 2002:aca:db45:: with SMTP id s66mr15395354oig.59.1554719459352;
 Mon, 08 Apr 2019 03:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
In-Reply-To: <20190404050931.9812-1-niklas.cassel@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon, 8 Apr 2019 16:00:48 +0530
Message-ID: <CAOh2x==enW-jmtYi3F=TP8QS=wt8UHKV5td-tyJiCXV=D6ZBBQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Add support for QCOM Core Power Reduction
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 10:40 AM Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> This is a first RFC for Core Power Reduction (CPR), a form of
> Adaptive Voltage Scaling (AVS), found on certain Qualcomm SoCs.
>
> Since this is simply an RFC, things like MAINTAINERS hasn't
> been updated yet.
>
> CPR is a technology that reduces core power on a CPU or on other device.
> It reads voltage settings from efuses (that have been written in production),
> it uses these voltage settings as initial values, for each OPP.
>
> After moving to a certain OPP, CPR monitors dynamic factors such as
> temperature, etc. and adjusts the voltage for that frequency accordingly
> to save power and meet silicon characteristic requirements.
>
> This driver is based on an RFC by Stephen Boyd[1], which in turn is
> based on work by others on codeaurora.org[2].
>
> [1] https://lkml.org/lkml/2015/9/18/833
> [2] https://www.codeaurora.org/cgit/quic/la/kernel/msm-3.10/tree/drivers/regulator/cpr-regulator.c?h=msm-3.10

Please add relevant people to all the patches as it makes their life
easier and never
miss anyone from the cover-letter :)

--
viresh
