Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863FBC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6E620645
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mSV1asYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfD0UXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 16:23:23 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40562 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfD0UXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 16:23:22 -0400
Received: by mail-ot1-f68.google.com with SMTP id w6so5521352otl.7;
        Sat, 27 Apr 2019 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJgD+pL9W7Px5skVpUJDUZ1yvSNePMr+f36/qtWiwqI=;
        b=mSV1asYvFd1SpvBS+eVyXagB5z5UPgZShzDKHeaL/gYAe1R9F/cyVd4Wn5lX1xVS6s
         /6XXHkc+KSwGRWpqdgNvoTjVR58aJkpgZZjA+P0lPqUXluNp06V3nuo1KLIeaT95eAHa
         VExtIEajTHifJInirjb2OCoOdgixVGyGFu4cWdetigUlE93zjAQN4M3tCz+j7HWku0j3
         otcrgaZL7pGLxESDI/eupyDEFVqDsEnwg9wI084qMbHZLm6qRn2SbrbJmVf+EoSQVsLu
         bpcu2oHut13nAKlnHJjd7ElBR7CFNflQ5poefMM+JeEx6yuWibo41yWVdBMz53lKysa+
         1c1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJgD+pL9W7Px5skVpUJDUZ1yvSNePMr+f36/qtWiwqI=;
        b=a50uPGGWV4a5H9a7+M23rQ8Qbu0MDfX+jfmAK/l+fOQvsoVxK0qd/LFLuw7iZov5p7
         AXR8RgnC2OiFqFJIOzFRx8PXMIX9RzAHcGRU4JbBEVqPutUkz95iD1sfEiHnjOsiNOOP
         c6saIeNUQ3Y7RsP01Eb6DByZiFic2gBQI6u/Fna6FD1kvY68fsWMkvGyWEDkqzDUN0d5
         AYgO0ABbOcdAsdKbSSs+l5TOn1tW/KhlesIeSSw8zSN5SYuIq1IQDy607on4OxBSarWr
         nhaWK8rt4sHEXnDAJNZeai/in9MSNwgjYBu7Ch7A34n+iB0rIAxXDTIB/fNAAa2JjK4B
         +Ncg==
X-Gm-Message-State: APjAAAXuE6grH1a0EOdSKZxZZ7hKO3N3rJ2LLvR13gKXyu+OiRchUIsr
        9XUR9TwMsHaJZC7/TeqWoCvhIhQ1iBy07TAck4s=
X-Google-Smtp-Source: APXvYqyXYDlYXJ5hEDJFecpKSBEoTRt9zgmKmzSy5qHUmuTaeGBiyYOrwCGgC8Nz/Jmw+ECl8TNZ0LqnPtkDpxTNgvY=
X-Received: by 2002:a9d:3db4:: with SMTP id l49mr32899960otc.131.1556396601630;
 Sat, 27 Apr 2019 13:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190423091503.10847-1-narmstrong@baylibre.com> <20190423091503.10847-6-narmstrong@baylibre.com>
In-Reply-To: <20190423091503.10847-6-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Apr 2019 22:23:10 +0200
Message-ID: <CAFBinCBmO5JYxFuDZ09rBhQz64skNczN+ST7MGC6vPt5jfDArA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] dt-bindings: arm: amlogic: add Odroid-N2 binding
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org,
        jbrunet@baylibre.com, Rob Herring <robh@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:16 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add compatible for the Amlogic G12B (S922X) SoC based Odroid-N2 SBC
> from HardKernel.
nit-pick: their website mentions "Copyright 2018 Hardkernel co., Ltd. "

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
