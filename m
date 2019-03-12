Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677B0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0C0214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpgXyJhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfCLK3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:29:32 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:33188 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfCLK3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:29:32 -0400
Received: by mail-ot1-f52.google.com with SMTP id q24so2018881otk.0;
        Tue, 12 Mar 2019 03:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vILeB7Cj9iqdkuCJG61BBQsuhFUsgpmKnI7wcoy6bZE=;
        b=lpgXyJhMUiSo49fjfhZaIzgoc/pgm/gOCWeUlJ6Fp8rAcw5kXofODTd/np+p+14pXr
         bOwBTBmUv9cmXJa+h2b5r7z9x6uK0Xs7m/2oBCT9C0GF4mBFKl/9zuT8e/dLJjXg3k23
         WkcnhaGlHGEwTztm6Y1R9/YNmCtLw8JveCPf1FRg7JOaSWxkNVEOjqzz270ew497qsfS
         DwXeXjYbT73qZA9uywyZWh96SVk0IUHKuuH8MsX6/P7Dls3ju+IutxYb7dlsnQkRt+JR
         DgjO3gA7o2V4Mg2Yh4uPXxLGm5Bc8G6fQSwxmH1UVt5pXzrfR4RsLXvXZ3utdqKtSpHc
         FbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vILeB7Cj9iqdkuCJG61BBQsuhFUsgpmKnI7wcoy6bZE=;
        b=kNewwt67OSZck1Fsw+Mc3DJKlbfiQp+ZNj5vLGkjQTUMl5yB9R7SmcWacI2IgLOcMS
         8OdLKZMLLY+RXfBRsFoFyn2zNbVzhadulGlwkTnn+aXo+enepHTx4Qh8mKBlsIT9MkPC
         F5UMhj8c3PxYQY8Ikq9sOZvJK+LsLlJ0PtDV1pm7fVpAnYLbfMM9r3dPkTbcynqLUy72
         zkgRksbuklAUCc6jqCHTZtJNd+DLf7I68EAoIQUsVPCVVcNhCz0Vw8AO42BOO3ZqZuFA
         NlSRvB+0pKHIdddz7GNjnfk0Sk8gX5JLC9DEEeTFJkIL9C5CnzAEd1wOLXsTE/6Xn8mH
         jWqA==
X-Gm-Message-State: APjAAAX1bFBLer6baB0myaAfh22ji13iXkUXD/MENfEDt+eEi/uYY4wN
        7WEQ9sG/nob0U+rOophMZTuntl+JAC1SWhp1wut7NHpowhM=
X-Google-Smtp-Source: APXvYqwNCm8CC2NaQXDrcN2mmwkyEvxwChpPXRb0t926Vska2sInGvQLCo7I47NZZWe1HK+PluCL5fLS2mO1MukeewI=
X-Received: by 2002:a9d:7094:: with SMTP id l20mr24156074otj.337.1552386571294;
 Tue, 12 Mar 2019 03:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190312083326.18029-1-gch981213@gmail.com> <5c580f1b-1038-2c34-7047-e504eb4ac323@baylibre.com>
In-Reply-To: <5c580f1b-1038-2c34-7047-e504eb4ac323@baylibre.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Tue, 12 Mar 2019 18:29:20 +0800
Message-ID: <CAJsYDVKKNiw9=zqNwn=HWgApVKvTRWy6AEkD8bzwZ5azi447cA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson-gxl-s905d-phicomm-n1: add status LED
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
On Tue, Mar 12, 2019 at 4:59 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> [...]
> BTW, do you know if it's possible to have a sample of the Phicomm N1
> in order to be added in kernelci ?
It's easy to purchase one in China and second-handed ones are dirt
cheap, but I don't think it's available worldwide.
I'm not familiar with world-wide shipping or exporting stuff so I
can't help much here.
>
> Neil
