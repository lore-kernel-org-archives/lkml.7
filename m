Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EB2C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEE02077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WfKFP2Ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfH0VSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:18:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34448 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfH0VSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:18:34 -0400
Received: by mail-ot1-f68.google.com with SMTP id c7so635917otp.1;
        Tue, 27 Aug 2019 14:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79O2d4MxaNzshKkDgbf9PCXtK+1faNjqfacVtcjhXCw=;
        b=WfKFP2Ex7iHPWuOIN+wXVARM//Fw+EtyALZ2RHdD2VFf+u0UdwMzKBy3aPxg/7RPR/
         pYJqOuJj0qomXcd2rN3UpcOUFUw8Te0rvzryveTSoFLLKuz9uBTGHHZeGoXBb1HDcwkh
         P4KNTBURWbvWCfte0L+pEJbEatRgNmt4QzDU9JxVdcIW+lWwlw23gSLvYqoiscpm2ckT
         lsj3Bq39CEouDk2Ngp62twh+Oebm/Ssxc4voexjQq+sn44Nn+bJDjoNsV6Uc0Ij80O04
         D5nyNFuMbQtVPo3CMRAWfJUQc2XEfLcN0T6kVN+E6nNvnGMZkw/b7XXvq+TSsrC+CMJA
         0EdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79O2d4MxaNzshKkDgbf9PCXtK+1faNjqfacVtcjhXCw=;
        b=Nr7ts3WvRMBqozzdhn4y9tFSWMgA6W2Pr16Ij4MRnak2iiGoc7hM17GVskfdds3fE8
         nqWNZ9dJ00o38HzxwPNKOl6/uhNcQOcEnAixEJDYResiDSljaJ7BReqyzE7TeTdYj2wr
         AP3//hPzJjfGBSlZvGvtymuUTe0Qweej43Ckjfz8aapxAi5QdO1IJGi8ZvdkHJJM6xGs
         w15aMUrVUeRhh8fcQezkIbMpq/k9tpToVeVko++2CH1SxT2rep5V9UCznlv/M2mI711T
         sXFEynkgS9Ry7AmRKotVEe4sMsE6hqy9rA6h0AF7x+zSHRq1WjVi1B3YOEEb6Sj0Dpx0
         ABxQ==
X-Gm-Message-State: APjAAAWRMcyIn1NUsJxxU3CNQFS03NazUaM4zU3VcsW3lVmDIFw9ayN6
        /pe5n4i4Lh5FCraNH2iHA9w6+S3AhyynNMGEhEw=
X-Google-Smtp-Source: APXvYqwGwnC+flBOhOIUQLHX1WACuwTk+aVA1Xep4g6gD4QcHubhVgX2ByYgZ7v0D2tQL2mAd7UJqcYjnDBDStIY/rY=
X-Received: by 2002:a9d:7b44:: with SMTP id f4mr571632oto.42.1566940713518;
 Tue, 27 Aug 2019 14:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190823081427.17228-1-narmstrong@baylibre.com>
 <20190823081427.17228-3-narmstrong@baylibre.com> <CAFBinCBLVDVWPbDZ+_cPTbJNCavvzJH4A6U8D9XWVSR-j3fzFQ@mail.gmail.com>
 <c853d934-113c-2305-f229-1e2c7138fc3f@baylibre.com>
In-Reply-To: <c853d934-113c-2305-f229-1e2c7138fc3f@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 27 Aug 2019 23:18:22 +0200
Message-ID: <CAFBinCBLxW2r-N0z10Z7uUpvdoPikkZ0Lca6J-NctGYXtuxb2Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] amlogic: arm: add Amlogic SM1 based Khadas VIM3
 variant bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 9:42 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> >> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
> >> index b48ea1e4913a..2751dd778ce0 100644
> >> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
> >> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
> >> @@ -150,9 +150,10 @@ properties:
> >>            - const: amlogic,s922x
> >>            - const: amlogic,g12b
> >>
> >> -      - description: Boards with the Amlogic Meson SM1 S905X3 SoC
> >> +      - description: Boards with the Amlogic Meson SM1 S905X3/D3/Y3 SoC
> >>          items:
> >>            - enum:
> >>                - seirobotics,sei610
> >> +              - khadas,vim3
>
> Khadas asked me to rename the board to "vim3l", which is the commercial name,
> should I only change the DT name or also the compatible "khadas,vim3l" ?
I vote for being consistent:
- rename the .dts to vim3l
- and change the compatible string

> >>            - const: amlogic,sm1
> > on the GXL we differentiate between S905X and S905D
> > do we need to differentiate S905X3 from S905D3 (for example)?
>
> From a pure SoC die perspective they are the same, exactly like
> the S905X and S905D, only the package changes.
> So only the board DT will determine which eth PHY is used,
> if a DSI panel is connected, a demodulator is connected.. even
> if the underlying package is S905Y3 without any of these pins
> available.
OK, I see - fine for me then
GXL's S905W and/or S805X are the "special cases" then which (AFAIK)
use a different (smaller) package (so it made sense to differentiate
all GXL SoCs)


Martin
