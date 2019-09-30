Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8F8C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 23:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EBD20842
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 23:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NAWE7s0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbfI3X1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 19:27:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36563 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731852AbfI3X1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 19:27:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id o12so19305381qtf.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 16:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pl9Uoj87Ji8fhmMmVA6l1LGr0jFQ4KuWKIrFbIh3wWY=;
        b=NAWE7s0qtdMAJiZamX3V6xokEA3BihpvGiwij4I9RhrSrs1/+NcFnC19kIYC2+VXm+
         mw4JB/DlOtISetTBRNDx9DFrMSVyR1OwEHYcnM7fyiodpHUy35LKFF+/IykPa/76nTNi
         oq4scSmcMmXkNJXm9at4/0G+We9rQDvDXAya0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pl9Uoj87Ji8fhmMmVA6l1LGr0jFQ4KuWKIrFbIh3wWY=;
        b=RWrlqS/1REQfVQPqjgIEUuGK3R4W75XwFM+7N2d1CZGMmw89S4zBFmsGxpLFyjS5FM
         os3affUFx2SsRRsa3pUk6PAZw8EQYHMUrwQialqSWol14HecF38C20kigTlpPOx5wQKV
         FyTsV4zXebQppdp1U+IdORviJWDkH5Y0PMmOM4Utao/xi0Hy5tOJJNU9IIW1pEMCDRLv
         PiT+HOsp0pjJu5it3wwoBZiOZiQgBOUnloQffeJyPmFm3LzsiaB7rLi3d2061NtlTWlT
         bDiYcrn9N6n5JB6chbirSynnKJOr38Umic1cj+vn9DdVQADoK1QVKdQfG71TYIjfjmex
         xpMg==
X-Gm-Message-State: APjAAAXbvCGsl4PcUWhL7jOH1uJ+SdAnExIiig0UeCJJ0VoTrIG8Hlyy
        qLSQ1ku25+tsVJh7iTY8KppYV24b5EOpyo9zx09HxA==
X-Google-Smtp-Source: APXvYqzPlXIhfWnlF8sLl3jj8HRowIb8xLOPox6pz/DpeJE7rRAz9Qj8GEZSq7zX8V31/1SFTHD3X0AT7ZutVfrWEtc=
X-Received: by 2002:a05:6214:11b4:: with SMTP id u20mr20478355qvv.200.1569886032025;
 Mon, 30 Sep 2019 16:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190930152846.5062-1-fparent@baylibre.com> <aa0487c21e1f9f04402f209358b18c75@kernel.wtf>
In-Reply-To: <aa0487c21e1f9f04402f209358b18c75@kernel.wtf>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 30 Sep 2019 16:26:46 -0700
Message-ID: <CAJMQK-g_PaNsfvX-H4_BA86aUOdyqpDt9oK86O7_mRWTjWSjHQ@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: i2c-mt65xx: fix NULL ptr dereference
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-i2c@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Qii Wang <qii.wang@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-i2c-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 2:20 PM Cengiz Can <cengiz@kernel.wtf> wrote:
>
> On 2019-09-30 18:28, Fabien Parent wrote:
> > Fixes: abf4923e97c3 ("i2c: mediatek: disable zero-length transfers for
> > mt8183")
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
>
> Reviewed-by: Cengiz Can <cengiz@kernel.wtf>
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

Thanks!
