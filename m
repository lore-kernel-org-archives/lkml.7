Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD73C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC9720818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mD/z0LTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfHFTZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 15:25:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41277 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfHFTZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:25:14 -0400
Received: by mail-oi1-f195.google.com with SMTP id g7so68271096oia.8;
        Tue, 06 Aug 2019 12:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r400Du+BdhcnVb2kJzBt3FbA/D2Jmeeyq4b8DmzoTuE=;
        b=mD/z0LTmYu+WiqSkvRq3LLNujYAd8HlJFwozWt4552r1/zczO8LbiytL3e/MDZPv93
         tKx2hPMqdZNJy4AZEtSf1xYNmFi9cTQ0pg/e1V2e9LTpcKZL2x+lIaiQsQXoXYAfsjNF
         MswbQTt1PmNXl/ZdWsUgdcCG54PR1yGVHLAo1DzYg231IGuaZYdXpqMocD6Lorye/0Ii
         wxqgPZY4+DO5OKhBhuujKEGKCh+I94hhv+5PYRhqxR8LTf/p+JDW57C97tpbCY5SuUg4
         sre2BahrbnzfpUPj+zKkiKXpU4R62NHuLps/qXZyzUkDpsHPwYeMjcPsJ2DniB/2h5Fy
         xAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r400Du+BdhcnVb2kJzBt3FbA/D2Jmeeyq4b8DmzoTuE=;
        b=NTbqq3mLo6N51Ro57rstWyPJ5Uxl4LQhvH3S8w89Z4UiD2VhVldRjwD0/wjZo4KYDk
         8p0yE6j6VbLYTmEviF4SG7dN9SYESNtCwANWpNpHQlRXTfKrJY3Uw3+ajgNDrgQnVw9c
         oTlZW4c9Or4+R+MKk2t9jnyf3GIPccbJWslD3PB/FBAM4jrbcYaYz80dA2pj603XzjjA
         b60yw2JMTCcvB0od+iB/ePD77VZJBFR+cSVnCmMQqp3I/appcv3u8wUe21GlyahCJNLo
         ufZEMAmFHdDoFkDA9Pp1zpDOjfy37wo4WbaV101eU5emn4FkCnKVmK0nL+PyOnljiuy+
         QUFQ==
X-Gm-Message-State: APjAAAWxwVv+e+pVINP5mjTvjr8fp5sDu2idyNLH/LJYEa2dmtMw3AMs
        xB11rG0DEXmdpuTumc4M+ywldj9moouLJVpBl03SFxzF
X-Google-Smtp-Source: APXvYqycqxwAz4ajkkyCaUP9+StDKHGffRIZJGY2i531ZcuklTJ3ImWMc0UgBRuQREKN2HBys+2LheHpq2cOHQCsqK0=
X-Received: by 2002:aca:5c55:: with SMTP id q82mr2887362oib.15.1565119513938;
 Tue, 06 Aug 2019 12:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190806130506.8753-1-glaroque@baylibre.com> <20190806130506.8753-6-glaroque@baylibre.com>
In-Reply-To: <20190806130506.8753-6-glaroque@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 6 Aug 2019 21:25:03 +0200
Message-ID: <CAFBinCCtuL_3TcYJS625ZdJQE_9Lt0n_nNVtxKoY-Nyoz2wSDQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] arm64: dts: amlogic: odroid-n2: add minimal
 thermal zone
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     daniel.lezcano@linaro.org, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 3:06 PM Guillaume La Roque <glaroque@baylibre.com> wrote:
>
> Add minimal thermal zone for two temperature sensor
> One is located close to the DDR and the other one is
> located close to the PLLs (between the CPU and GPU)
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
I'm not familiar with the thermal subsystem but this looks sane so:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
