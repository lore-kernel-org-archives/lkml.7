Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC824C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2161230F2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qtPpAFID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbfHTU0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:26:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39818 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbfHTU0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:26:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id b1so6291515otp.6;
        Tue, 20 Aug 2019 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=twYIezSLU/OVYsbr2IHsXTRqkIzdrg1CxaCIxhHJ0W4=;
        b=qtPpAFID3Om/7WrfwGpqo+WusqVG/L/xldtmFXjwmBDBEZmr07SFzZG7VMV4hPPY6T
         AxUYmYp0rbp6n5GApnTmNJegIPzAS061q30gKP+GRDtLijQfhcVO8K+S0nySmiU4tjyl
         M6wDQKrNRDFX5zV/OV77sPPTnGTk/EKR4uELvVJKK8/ydHprAq88WRHkxwLehgBYHIcK
         cvUVCbxPC0kwklPJMCtLc51yga3WnVaBWY2AyFu92kffq0ue7XFUU3RHIcJJjxfaVbWo
         BlLLRxucvDLhYEeU2WIq8WFRiXTLQGcTjjcUpErPK+TJUyMACc9oNF1udZkLzkXBaq7x
         BU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=twYIezSLU/OVYsbr2IHsXTRqkIzdrg1CxaCIxhHJ0W4=;
        b=pxNyLexv2CWPqN/U2xKIpezcumTfeppjvJISBAte/rGjTFnanmJ7EBYqY7vA/ls2sD
         XrE1Oz5AmEHTyHQXbQtXWzLi68Gr3tt5+uOyCfgoqI5uoW+PdX6cR+5hpEHPowyojutH
         XDooplX3ZQGz36/Jgqt1EiWOdNkvw6JWltNiCZFS1k5X7JDR50Obs6OKGeGX5d/QY29A
         +/OoE1zWHxyNbOwFo6yA5/o0PeY0hIYgItfB+QVpMMjIE4bz5CPnyfuUxX/k1ADqY092
         XI6QrcCUcLVITAr1M/zMY39DOk3GwO/y/3+CHsQdRqlfuGdKL9JWnkq8EK/Fa35pHYYh
         I0cw==
X-Gm-Message-State: APjAAAXHnwdbH7CeurpFWzdVdOfP6bB6O2LV7WlIWMhQJeMl5A0VLf1+
        fjLy9El9LijD1RQkCLrkXDr7GAqsZQpzW4bBwMs=
X-Google-Smtp-Source: APXvYqyerGVLGtwIyjcFiVjLmf45wgZ9hv1MOkh77AdzGvP0Bvu52F28OTfLpnlxRkTfP6wDOTfvooN+in+Ddu5+EGQ=
X-Received: by 2002:a9d:6c0e:: with SMTP id f14mr22577236otq.6.1566332769966;
 Tue, 20 Aug 2019 13:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190814142918.11636-1-narmstrong@baylibre.com> <20190814142918.11636-8-narmstrong@baylibre.com>
In-Reply-To: <20190814142918.11636-8-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 20 Aug 2019 22:25:59 +0200
Message-ID: <CAFBinCC9LS+-tM80d8EeyhwUJhV65h11e-M8J6UVy1iE1aD9Kg@mail.gmail.com>
Subject: Re: [PATCH 07/14] arm64: dts: meson-gx: fix periphs bus node name
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 4:32 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This fixes the following DT schemas check errors:
> meson-gxbb-nanopi-k2.dt.yaml: periphs@c8834000: $nodename:0: 'periphs@c8834000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> meson-gxl-s805x-libretech-ac.dt.yaml: periphs@c8834000: $nodename:0: 'periphs@c8834000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
