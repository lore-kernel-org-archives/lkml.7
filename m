Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB0AC072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057EA20989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ojcs6udB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfE1SN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:13:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37435 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE1SN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:13:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id r10so1131928otd.4;
        Tue, 28 May 2019 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LPvFSy/+Ol+ZuQMgkb+qnJE+L1Iql0hHfM4lKqsprYE=;
        b=Ojcs6udBEkePD30+FubBfExeTjFdf/YPOSYCAUMwiskoT4bMtWzZOPU9/eKjyPOG7U
         wVAlr775HDvInKKs9ocAemTOAMS11GS5df+uZmdNUi27faV9vJvZnuQC77iYUGzfY28o
         pPd64Eyv8SmCOroCDWO9P3uhnW5BMAAPYzWJjtLLkdLrQbp662bgEcrPAqk9B1XOkqX3
         mJLxI8CS0ikanr/A+ddV34f29i+OkHMjuc4IP0CFELBtD+09E+zlfQB/LYE/HBANMPyh
         tRwogab5N70tW5YDnREToqiEgRSlTZyRCdQQA4xwWIZCJxCWC1Ms+/aWZEVVz5KK1rg0
         7DsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPvFSy/+Ol+ZuQMgkb+qnJE+L1Iql0hHfM4lKqsprYE=;
        b=RBjWL2v31Fa8rUFRlPzLBB2VPMzlozBOCTQArOKztrsOIeu6RZWpejYIMMUzhm2G1C
         3olKOBJ0+M/qb81bFkeN0JBjCZqJlfosu0UDt0pAQShKcskWivQthtaoyQ00lDmj7Xfe
         qDQxQqyi+/zNJITlO5SkyWYKJT+bTzeJhbJEySuuhOZkw5K9X0RRcfQUaPohGkkZmJkU
         MFUgdSNd69APq2tgOWDXtBkQEdovO6GT67aPWHj7SDnlYwzu9vLuSobsY+ww2ihzxQMJ
         ZVuE4NtHK20imp12dShanHXVafi3toeOryruZKgRAQZtfdqFDOhAM+37BywzqBqmE4eY
         Rn3w==
X-Gm-Message-State: APjAAAVa4cz6VFkKtG1ykK6qwT/VifRl+V50B/1ulGYrfsg8/Zsbd3Ef
        eauJP3cVsjWTck0Wd0z9ZtUFu7PRizS2hzRAzd14cdV64ow=
X-Google-Smtp-Source: APXvYqyagHBu0OgYtX3i84tIgx8uv2A97o9m+a9iuX4CshpGLW7d441lQy2nxKnxaNDuCwtbZifs7QCWJ9IKORrBOo0=
X-Received: by 2002:a9d:69c8:: with SMTP id v8mr22334562oto.6.1559067206898;
 Tue, 28 May 2019 11:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190528080758.17079-1-narmstrong@baylibre.com> <20190528080758.17079-3-narmstrong@baylibre.com>
In-Reply-To: <20190528080758.17079-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 28 May 2019 20:13:16 +0200
Message-ID: <CAFBinCCMfTL337=HtvoXDDznfqhH+i0N6NAj8qBPso84XFoJBg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] clk: meson: g12a: Add support for G12B CPUB clocks
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, May 28, 2019 at 10:08 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Update the Meson G12A Clock driver to support the Amlogic G12B SoC.
>
> G12B clock driver is very close, the main differences are :
> - the clock tree is duplicated for the both clusters, and the
>   SYS_PLL are swapped between the clusters
> - G12B has additional clocks like for CSI an other components
>
> Here only the cpu clock tree is handled.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
thank you for taking care of everything I noticed in the previous version!
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

do you still have the CPU post-divider muxes (which are currently
modeled as CLK_DIVIDER_POWER_OF_TWO dividers) on your TODO-list once
this is merged?


Martin
