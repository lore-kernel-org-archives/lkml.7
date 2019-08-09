Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC766C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDE52070D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="koHCpbha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfHIWj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 18:39:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40658 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfHIWj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:39:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so46769902pfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 15:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=R8IVqh7wNpqQDfIMMC12abfOlWhh3Xl6VzDVWeyjpqU=;
        b=koHCpbhas47m+8kubE8D34Xr+WHGo4wP8w8VF91CC3jXukweA2wnDrgcCudp6FO4Au
         ++SgN3LzVEBJLekmB2wCZN3rKB2qoPxFD6cNXexR7hyMO8CJheGlcqshx6VgbQWTPlQP
         RCB0kgSU397FUL8ELhq9uWiMNghiaUx1kG8m9GKtdtxU0lqL38CC5hPofaLjXwRPvRMq
         97R4iHo8o9xR4i+YStWSdOOzuLid6XJAoJQMxVsvfNvayZluDAwAhg2zb1CGcYYAGxEd
         MO7M5rlDnn/qmIOI7CkelajgZ9JklTuNCnnDsl05oIuP1xOGDf/c6w+NAYkIe9KKfMm3
         fJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=R8IVqh7wNpqQDfIMMC12abfOlWhh3Xl6VzDVWeyjpqU=;
        b=N7k0ABQVAMzjBWrUMFFfzK6i3YJiVNzjKQ4WdvO1zatiVGUrU+RfJm/HE7J4Xz/Mu1
         rsZ1824iuC1OopJRhX3MTpQLhJvYQz4aoE/rgRIo+bT46kvTGcJK+E7fge1mNO1mAoXs
         Eb0c4tmgeDiuItx/UM/vC7y1jGyC5+mZwieEz5tcVy60DkOHXcIgnX/iWpB5LumMFv55
         SG+T1bjEiZm7xIRDPaUbvwNpfZ0Wd/EKYo+UdgGUcl2RitSlj0EUpYADTmIz8sqRdw7L
         CTQo1m0Y8Nz3WFvhctH/fB4EMnfAaxaHMWVc5s+Dd588eU4/I/tYcz3EzJRvUiKLh7NV
         L3yQ==
X-Gm-Message-State: APjAAAXx/oFuUO4CHvJnb3RMRJ1U8T1MibjQyeaphzBOMQ+zoWMiAN5i
        ZLJd0Spe9JFj4aUd92ChTu8ToA==
X-Google-Smtp-Source: APXvYqzABUyKC0jSvgE7WOPJUqmUvpdDD6GCn2QJTRwTDXEgpqNw+hfWHxGIIm/8tVEh0rnWuRjffQ==
X-Received: by 2002:a62:ae01:: with SMTP id q1mr23332658pff.219.1565390365097;
        Fri, 09 Aug 2019 15:39:25 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:b873:707a:e893:cdb3])
        by smtp.gmail.com with ESMTPSA id l31sm143779758pgm.63.2019.08.09.15.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 15:39:24 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: amlogic: fix x96-max/sei510 section in amlogic.yaml
In-Reply-To: <CAL_JsqJ=dUX-bPa06KxJowf_3GM2-mPwm4U1KyTXyH0thA1pvg@mail.gmail.com>
References: <20190806075520.14652-1-narmstrong@baylibre.com> <CAL_JsqJ=dUX-bPa06KxJowf_3GM2-mPwm4U1KyTXyH0thA1pvg@mail.gmail.com>
Date:   Fri, 09 Aug 2019 15:39:23 -0700
Message-ID: <7ho90y2cbo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh+dt@kernel.org> writes:

> On Tue, Aug 6, 2019 at 1:55 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> From: Christian Hewitt <christianshewitt@gmail.com>
>>
>> Move amediatech,x96-max and seirobotics,sei510 to the S905D2 section and
>> update the S905D2 description to S905D2/X2/Y2.
>>
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/arm/amlogic.yaml | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Acked-by: Rob Herring <robh@kernel.org>

Queued for v5.4,

Thanks,

Kevin
