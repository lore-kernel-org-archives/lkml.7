Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB9CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DBC2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rlDkQN39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfE0JNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:13:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37666 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfE0JNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:13:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id m15so10912620lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 02:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/7xc7v9tJJNaiyPfxrhOl/58adqp4n0uezKun8Lw2E=;
        b=rlDkQN39x24oD/0Fx/igoqVAOkOn0hmIEsqGZjmKNz0/nL36PAqCBnNBK+QfoOTSX+
         npQ5mAPZW2Ywl3J8Rye284g602C47GrM3i/PfBwN6i+EXW+TNHb1VNJDL6XS73+mTO57
         NfoD/LbHrmQ2kxyfnvJss8TDpL7xSqoBsYUP1A8aRgAGqWhoEjW8H1GaAF70E4iQn3B9
         4y5uhI3c3z1WW0IHkiekCy3FfCZKGiUlk6mBDStXbt8HIYdCIDFvzfuaxjPfLcUfntxU
         ryhsjlGZZeu2HbXwrYGsJMFW0Dvn1kszD4iHFDt/ixgoRz/n9rLOdVgtYZuxDhBtwr3P
         WDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/7xc7v9tJJNaiyPfxrhOl/58adqp4n0uezKun8Lw2E=;
        b=PqwmiFjp5D6BkAry8CRrFXlOzROPe3WgtYSuoiw5QgBKGWY/ocyvtJ77qA6N90O7fg
         obfIXcMc35kHcmE/PLuTS1QtcZp/HQnHlIMS3tas3LD6o6nNbX2lONt5kQa3MPcn71la
         phUH/PGPuTgy53nYX82NimV6idubfWkdKpn21dkSU7oWfyHI5Od+P9g3vCc1lEwe7XR8
         DcpRJCu3hKcYRyIK63YQLgOBuuI38C3GxfByPcwN/Hu/Wbl8J9BlsU8X85hjtCPSg4XJ
         5mI8fV1PZ71UK8P/nKMkOYNYRreYBZqaaQ3M9LtfLca3be0m/nrOip9SELBfeoxhLHu+
         cJZQ==
X-Gm-Message-State: APjAAAXqvr+q8srsbuXPRiDB9HlyVVMQbpl5xDRfxMuZe+IN6cdzgiGM
        PsZedXYQ0tqXMae/Q1PgHj/GL/3fab0nElPWw829wA==
X-Google-Smtp-Source: APXvYqxMD3x3Zg9ONiCBorxk0Q9XTDz80b+4NRApQxGryM34b0wKEecvJIiWl4fu361pYvYyrTrBpySqptqbXxrm9nA=
X-Received: by 2002:ac2:48a8:: with SMTP id u8mr7983174lfg.141.1558948419094;
 Mon, 27 May 2019 02:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190508021902.10358-1-leo.yan@linaro.org> <20190508021902.10358-5-leo.yan@linaro.org>
In-Reply-To: <20190508021902.10358-5-leo.yan@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 May 2019 11:13:27 +0200
Message-ID: <CACRpkdb9SGN6N4y1Po6yY3dROkDhGOHaip=YRRaFKfv10r=sAQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] ARM: dts: ste: Update coresight DT bindings
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 4:20 AM Leo Yan <leo.yan@linaro.org> wrote:

> CoreSight DT bindings have been updated, thus the old compatible strings
> are obsolete and the drivers will report warning if DTS uses these
> obsolete strings.
>
> This patch switches to the new bindings for CoreSight dynamic funnel and
> static replicator, so can dismiss warning during initialisation.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Patch applied to the Ux500 tree.

Yours,
Linus Walleij
