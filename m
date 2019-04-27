Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2365C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8B0206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bQDs8KX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfD0UWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 16:22:17 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33919 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfD0UWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 16:22:17 -0400
Received: by mail-oi1-f193.google.com with SMTP id v10so5593187oib.1;
        Sat, 27 Apr 2019 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6qCTU447E+GH+ZEsRVkg8uU1ixXBH4ZBCI8kFJ0apk=;
        b=bQDs8KX83mjqeAXYeg4iUYNRuabnlNAd08eHnFUOQ4AhdGC7wAekyyuWwBABzzo7Wv
         GfluAUlBgNKirtqWSfsG9xUPGks0oUuZbwwzK5S7jB6R/0ca1/82S6kPzdbQ5UimvfzP
         ty6j0mVf7n+Dv+2En4CGjKHxvgPkPtEfcfW4Hkd2HXhAHQHrcHjK8vTx41krK95l6EEy
         M/v5QE+R71AVZxL//DA3Bx546S4gxPUuqjVJUIrabHeO92/hBRv1pLNyjCh1Rj/Ibivo
         +E4SsymcFCorizPgUDSQqpL+TfxOE3bAXAfwLUx8NiKRzpH0Dp4fcfFSV05bPOtLhEK7
         2FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6qCTU447E+GH+ZEsRVkg8uU1ixXBH4ZBCI8kFJ0apk=;
        b=mQbhKaM2AknzH+Xhy6WV6xLORbS+Rw2fPxO+ktbCdn2v40ZBK8mZlD2fQglcC2Ydks
         Kj49+1vMt79bSBwj/t/0EdLTYHQGlAIO+OtoHkXB284oVhamST/O1grPtlvRKXwy51GG
         zk7T+7wi4F/I6+79jAUR8CombDFepLPKmp+mCyBPZPYlcphHPvz+1MOj4H6SVD5YBcuE
         ROCdLvqqNF9+CqCl0v4Y3g8zc37b3WljCWTUtRn/lJq3JpLge38Id2gG03ZOKJEOqBPV
         /vBHp6jtlmtsSCjBOA7HUQ8H++FZ/ttOO0I4NIuGxJZNztEzWs4psZv5WNlozZucIBxV
         gzqA==
X-Gm-Message-State: APjAAAWf3vq8DUq1fFFI6JSrpUrpeu2Zo3j0xgq1d02h5bOYVo9yuHgY
        rnev0BjzOpVByoCda0WprJ6XMzt503vxBS/STH8=
X-Google-Smtp-Source: APXvYqxtbDt+c3ni9QrEfFfA/TGXkyJbzrtK2r6bmsseXH9+Ux/3nW9LnS5Zoy+n/Q5hAeAy2Afl98S0tgJTO28uQzw=
X-Received: by 2002:aca:5b06:: with SMTP id p6mr10615717oib.129.1556396536284;
 Sat, 27 Apr 2019 13:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190423091503.10847-1-narmstrong@baylibre.com> <20190423091503.10847-5-narmstrong@baylibre.com>
In-Reply-To: <20190423091503.10847-5-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Apr 2019 22:22:05 +0200
Message-ID: <CAFBinCA7qCmVcz_brXfJ4aiw6ZHvEJ_duhjtEH+znJ3zmL_mmg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] dt-bindings: arm: amlogic: add G12B bindings
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
> Add compatible for the Amlogic G12B SoC, sharing most of the
> features and architecture with the G12A SoC.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
