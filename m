Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EC7C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F142077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Muda7dGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfG1PYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 11:24:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53385 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1PYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 11:24:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so51698050wmj.3;
        Sun, 28 Jul 2019 08:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HtRVmybXb1C2x1A/QbBumlyEcgeYu6CTnhrpwjpKg90=;
        b=Muda7dGbveNH73T9XmXzmaPZ3E+lp1CgdTK6jTTybXWpC2RQd+j5YCcCbzH40Qjf+Q
         DOM7gMaS6ZjkJlSAv/cj/9ZY80u2z9PjUnshpErTukYv7xmPF78sYaqCQz8Y/EONv/VC
         VJ1wSLVGlYoTStTq0zv14zdv+Vh55Qxiq9hiRbhbgaEtUM18oO04wUvNLndFyMqx32az
         wNVVSWafOWpDhrfpzqdQiAK0WjpBAZW4gcY5rRnz8vcMiPRr0kkfc90mGls5HVcaAOuc
         7Rzub5mT7hIEOr/eOd6bm84Spo8UOpbC4934HpLVVlQk6a/TVNu5RHm0OGOPGwKoWhix
         5uXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HtRVmybXb1C2x1A/QbBumlyEcgeYu6CTnhrpwjpKg90=;
        b=gxLVaBL6gw1rWDIiQTyqGhc+G6wBpAHRBEW4kOhu5BTlw/5Lcf2J832t+ZtWPtqjEP
         f2cnjt5OrBcDn+pM9uFO3vFX53NxmwVALi5Gdaxx4lP2NRJOV6TfNQxafJENsgwF1co8
         aQesBdqxI9aJLueI+F1UmKg9rVqEekON2ub2tHvX8YBzZcSz+D0k2/rCigUyHQumnKGH
         e1MugabJvOZOr+4HRhuP/AeiUR8lVEsoqv9NQ1xenySjBt7XMHCji9IaIIJr7/85wSyY
         roPrG/vwGoLWrH4QVXScBtgiPvHG6rUeTu975oC2ldBQRZaVyazk/AHPRq4xMwP8Sxj3
         gukg==
X-Gm-Message-State: APjAAAVRwC3InTPRh4Toxl6eZSeqoL2mpCbPbIj1ibzkQEgYJG7YTzac
        9jBN+WBuB5wto3t8DnrMEByLAHkI9IpGKMQepoHIaXB0cfg=
X-Google-Smtp-Source: APXvYqwVL8oWViukuPqmsa31Rg2hE8bmHJXDbuuSpxO+52WwcONISLQsSSg2nN1hGJtGrbA0wGzK79tZ7dQXW02hVlY=
X-Received: by 2002:a1c:c188:: with SMTP id r130mr90251544wmf.73.1564327456436;
 Sun, 28 Jul 2019 08:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <1562155311-24696-1-git-send-email-abel.vesa@nxp.com> <CAEnQRZBK7EYVhbGpFeC79HxU=h0OcXU_SSeaMWbp+Qk=rf=14g@mail.gmail.com>
In-Reply-To: <CAEnQRZBK7EYVhbGpFeC79HxU=h0OcXU_SSeaMWbp+Qk=rf=14g@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Sun, 28 Jul 2019 18:24:05 +0300
Message-ID: <CAEnQRZDrTZ-KFs0fCYorpiRHJFud9twoe-B4fRjekd6DJiODhw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mq: Init rates and parents configs for clocks
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 4:05 PM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> On Wed, Jul 3, 2019 at 3:03 PM Abel Vesa <abel.vesa@nxp.com> wrote:
> >
> > Add the initial configuration for clocks that need default parent and rate
> > setting. This is based on the vendor tree clock provider parents and rates
> > configuration except this is doing the setup in dts rather then using clock
> > consumer API in a clock provider driver.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
>
> For audio related clock:
> Acked-by: Daniel Baluta <daniel.baluta@nxp.com>

Shawn,

Please ignore this patch. I've added some improvements.

New patch is:
[PATCH v4] arm64: dts: imx8mq: Init rates and parents configs for clocks
