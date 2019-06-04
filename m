Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12F5C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2B6206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="doTgsxvd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfFDXgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:36:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43595 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfFDXgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:36:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id j29so3809031lfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 16:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WV3sJyKzvv2hglik5laJLi6zk95U7YCGm4MZG0UbbBM=;
        b=doTgsxvdZv8uU0x8XW1L0hFFxk7NVRCh4EcK48wmJsmGLsH6XMlLAb/m9hX5yAKfq/
         mpAOXL47upaREgDMBi3qMSM8JV9L1dBVgYXWkO08XRJIh04mvW8/RphRVPAe4EgWjIYG
         dOxwWXAQNwFnvP+7LdEIctpkg0tJPmm6BMtrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WV3sJyKzvv2hglik5laJLi6zk95U7YCGm4MZG0UbbBM=;
        b=HTjEwdgmJ7QdIprnQ4XleQTOuIussdhp3PYyjF63FtT46vejxn7L7o2YeD9BbGYocX
         EAkgvEfhpw3ZsLHZcqktFvJIxL2WzxJKKWktMV1DDPcAwwMbK7TxnKNX6RA/DtKn4Rh9
         CiCZrZWouOs1rVNG0JU02wAc6i0VFHWCldKunlH3vSve1gBRWocKTyFZ9m+ig0s7Yx4Y
         aF3BofwItgc7AccTvt/yu3nmlBVh7itYcnJP1Y4gyj0qElh9UKMrKiy0LOgpYdqo9OVP
         e1JYcC7MD3xqirxhaNQHEqNzI2dBUgyan+JpFIs5RXZL+apkcc697WKvfYtto7aoyAG/
         4VbA==
X-Gm-Message-State: APjAAAWwScxj9gBKsYYjip+O/FfKYqkYqkngHdYzDd17699UeCCd4hhp
        ljpD7Y2iUyS4bFLIDE8LLbus7izjoEQ=
X-Google-Smtp-Source: APXvYqzcVSmtpx5DFvT1D5tIc3VnsncdsgXxLM4V7AQ93jjMcQTlea6trAAfgtwe4vCjJy4r3bSIbQ==
X-Received: by 2002:a19:ab1a:: with SMTP id u26mr10234931lfe.6.1559691359928;
        Tue, 04 Jun 2019 16:35:59 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id v17sm2039417ljg.36.2019.06.04.16.35.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 16:35:59 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id m23so3111074lje.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 16:35:59 -0700 (PDT)
X-Received: by 2002:a2e:5d9c:: with SMTP id v28mr18287829lje.32.1559691358483;
 Tue, 04 Jun 2019 16:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190604232443.3417-1-bjorn.andersson@linaro.org>
In-Reply-To: <20190604232443.3417-1-bjorn.andersson@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 4 Jun 2019 16:35:21 -0700
X-Gmail-Original-Message-ID: <CAE=gft7nZNLykioozOJUDitXWc8PgFjDmCucmoz-3wtxzg_4CA@mail.gmail.com>
Message-ID: <CAE=gft7nZNLykioozOJUDitXWc8PgFjDmCucmoz-3wtxzg_4CA@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom-qmp: Correct READY_STATUS poll break condition
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 4:24 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> After issuing a PHY_START request to the QMP, the hardware documentation
> states that the software should wait for the PCS_READY_STATUS to become
> 1.
>
> With the introduction of c9b589791fc1 ("phy: qcom: Utilize UFS reset
> controller") an additional 1ms delay was introduced between the start
> request and the check of the status bit. This greatly increases the
> chances for the hardware to actually becoming ready before the status
> bit is read.
>
> The result can be seen in that UFS PHY enabling is now reported as a
> failure in 10% of the boots on SDM845, which is a clear regression from
> the previous rare/occasional failure.
>
> This patch fixes the "break condition" of the poll to check for the
> correct state of the status bit.
>
> Unfortunately PCIe on 8996 and 8998 does not specify the mask_pcs_ready
> register, which means that the code checks a bit that's always 0. So the
> patch also fixes these, in order to not regress these targets.
>
> Cc: stable@vger.kernel.org
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Cc: Vivek Gautam <vivek.gautam@codeaurora.org>
> Fixes: 73d7ec899bd8 ("phy: qcom-qmp: Add msm8998 PCIe QMP PHY support")
> Fixes: e78f3d15e115 ("phy: qcom-qmp: new qmp phy driver for qcom-chipsets")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Nice find.

Reviewed-by: Evan Green <evgreen@chromium.org>
