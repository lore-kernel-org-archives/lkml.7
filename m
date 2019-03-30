Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFF9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 15:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E98D218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 15:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qv4roUBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbfC3P6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 11:58:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42104 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730558AbfC3P6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 11:58:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id 103so4749457otd.9;
        Sat, 30 Mar 2019 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icdDINxkywQPrZTrei3utV7AEuRr9+VkHAS8J37vk+c=;
        b=qv4roUBNNllkZ8xzNjVC4gFOt5jIhVUe2cubAl/0X+iCt3Hhzc/Y7my51pOs+qrYvf
         Hax4EKtIIrX8bB1jpUUq3hMmsjFg9d7tRVsRxZ/hLEphVRih1z9q6sC0oQxSXgf3rm6j
         V88hw26bwCkfSCBBfA+zAGXYdbz5LPgOP3cRtLWS7aGk9r/a/Kq06aqbxCqlyf0yRb7V
         6g58BVEfCTN//A1YXWsVBwvIgkxnezOoMcXItT9JbJyCTexT97x/EcMu+BhMUWKhT4fY
         E04iJZg9R9FKGeFb8//8L1hAqBw5wp0PlDN58h2LG+imxaOrwEEuSriwF3qjwDz9p4Vn
         yy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icdDINxkywQPrZTrei3utV7AEuRr9+VkHAS8J37vk+c=;
        b=c7SD0Qzc0a7SubeRmHnIU5f8h6kIqJ075C78XoTdxSxkUXfHslbCO189uhB2XNVYnf
         3ecOVZqdjyAM5nKkgwnch98Otrwue7Gkf9lM4CKZrXuOFAzhTwbHA1YMXX2+XujFHZ82
         kS37E/F07ZPPL+gF30J6DS61O7UdZ/Su/kL5CIllSFrnwRMR1dvPS5/znpqU2urF1rUK
         L1STJXT7bl2Ub0qlgtL88sxCzQ7p7d+c2fwxgTMbl0vw/vACkV2tv2krzmwdyxhR7S9Z
         4HOgn7md/EQO9PCT6j6/s9D66EGppexc2hGk5Qq+VCWwyhYa7XNnzVeWutNH11QXiEIh
         Jkwg==
X-Gm-Message-State: APjAAAVyyQYCm4MV6i8c2cOyWZuUEjKN+ZIe+onQHT2p6vCq5mTWKVls
        akiAGUF1bwochLlz+D2EK8/p+GUFQNmIQePG+kY=
X-Google-Smtp-Source: APXvYqwgl3qdsTEWAbkRDqwhNNgxmXKj9oqE3rFmiWYnyHHctUjmrAOdzXaoHtUV1jsQG+HZnlNGdk52INg5JTkbSWI=
X-Received: by 2002:a9d:3db4:: with SMTP id l49mr18214023otc.131.1553961528442;
 Sat, 30 Mar 2019 08:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190329153325.23869-1-jbrunet@baylibre.com>
In-Reply-To: <20190329153325.23869-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 30 Mar 2019 16:58:37 +0100
Message-ID: <CAFBinCCSoJYnSt5L07aK4+wmU54soFxRODuHbxaAqcJpmOL+fg@mail.gmail.com>
Subject: Re: [PATCH 0/3] clk: meson: fix mpll jitter
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 4:34 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> As reported on this [0] mpll series, We are observing a lot of jitter
> on the MPLL outputs of the g12a. No such jitter is seen on gx family.
> On the axg family, only MPLL2 seems affected.
>
> The jitter can be as high as +/- 4%.
>
> This is a problem for audio application. This may cause distortion on
> i2s and completely break SPDIF.
>
> After exchanging with Amlogic, it seems he have activated (by mistake)
> the 'spread spectrum' feature.
>
> This patchset properly set the bit responsible for the spread spectrum
> in the mpll driver and add the required correction in the related clock
> controllers.
>
> Jerome Brunet (3):
>   clk: meson: mpll: properly handle spread spectrum
this depends on a patch from your other series "clk: meson: fixup g12a
mpll": [0]
personally I would base the other series on this one because this one
contains a "Fixes" that (meaning that the patch will get backported
and that's easier if there aren't any conflicts)


Regards
Martin


[0] https://patchwork.kernel.org/patch/10868837/
