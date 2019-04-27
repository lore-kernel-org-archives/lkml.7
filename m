Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A60AC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D6C2067C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sb8gi04u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfD0U3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 16:29:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34152 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfD0U3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 16:29:33 -0400
Received: by mail-ot1-f68.google.com with SMTP id n13so2164237otk.1;
        Sat, 27 Apr 2019 13:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r+u1Uc4MpTFdNT8VK8aH808CBTf1BtkCYQRBGkAzTTY=;
        b=sb8gi04uP2A7Hfb/6So0ySjafBDIIFKDXroacQDp23Vn5PiHFtIn2MMEMF6GHONT9j
         jt/rYD/pDq+ZMecfDFF+b6wsfC4DAZ+zgTSAPxgmU099C5QKWaBb3NqMGdor2l9KApDa
         oboT/QVqH0Ey/vLTm90zd3LYU/HCe4eQMlM9761oFZUC4M2BZHEtldjbMcKpTs5PL8fG
         9uvPKqnwvYbUc7D569vKwBfxA+9LFqkeLI0iVsY2VyAMhyAtOoiibJvnNCljBFMY3ljc
         H2EQvrN/N2UEWqO4U0XMqPVcNNtxzeodImbEfaQ8QSoPo3babvW1KcsI0teX289hstzE
         96qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r+u1Uc4MpTFdNT8VK8aH808CBTf1BtkCYQRBGkAzTTY=;
        b=Ki8A3udCucSd6Bmu7fqnyx9TQvO3DpE6XrLPdfalElnnduZEgrWlvGEhGz3HliXiS4
         c2OWpZTR7KdnwJ4cIeoYMGUlXGAlxRDeflhQ8z70wzv5oygKXHrO8S/yyVLOTOvary99
         6bR7OpLCNnoEyoJioD6kyBSawYh9LD/8+sQHoNhxNRuWY/R+jgUrcTjvdPP9r5+xkEIx
         uMF0otiJmQJCCwHfJxMOye8JHg0dbPofL8rS/pXT96S0MSqy7ZNmHgeOnupN4M/0uaYv
         N+p0GCe9317i5fuy2OhC1EI7tXLLRDcK9zMT7aQbKCV4tOCoCOQWEUTBi/tjtiPKri/D
         kR8A==
X-Gm-Message-State: APjAAAVZVrPjHZg9zS3fDVAmcJ3N2m5vHyem6fBEDdTScCrMQAtCjYy2
        8+LODt4JYYJ4C+oyqiJSlRVqc68bB0IypOkZE94=
X-Google-Smtp-Source: APXvYqw5UxrFzLXn58WC+X6RPPz/t2StYMN+4m/MLVUAkSj0fMjagguxFrik34N/KANpNKFzVvAQAdQJ/qKByAyRehk=
X-Received: by 2002:a9d:5e90:: with SMTP id f16mr31089817otl.86.1556396972638;
 Sat, 27 Apr 2019 13:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190423133646.5705-1-narmstrong@baylibre.com> <20190423133646.5705-3-narmstrong@baylibre.com>
In-Reply-To: <20190423133646.5705-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Apr 2019 22:29:21 +0200
Message-ID: <CAFBinCB9WS650JpuyGyjjOE=LNbChOdhAyb+qJMYWGosyMUa=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] pwm: meson: Add clock source configuration for
 Meson G12A
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 3:37 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> For the PWM controller in the Meson G12A SoC, the EE domain and AO domain
> have different clock sources. This patch tries to describe them in the
> DT compatible data. The two AO PWM controller has different clock source,
> but the first AO controller (A & B) can reuse the AXG parents name.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
