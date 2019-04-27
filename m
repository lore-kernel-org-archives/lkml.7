Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E06C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7792067C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 20:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oZt/Gnkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfD0U3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 16:29:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37240 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfD0U27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 16:28:59 -0400
Received: by mail-ot1-f66.google.com with SMTP id r20so4399713otg.4;
        Sat, 27 Apr 2019 13:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1I/Om5aYGl76EBPQH6xJKuHTrTxYjP1lSZQ1eei4PnQ=;
        b=oZt/Gnkc+JToAFtKFJv1xZmlYzkiWRGIOyqmO8G+34CGuYKdi4NWz8fdSSkNVEEb+c
         PfyUjCXRBE34YNs5xgGNjJvWCgpvGJcr3hckspV9eKrbxGLtovbs8yX7BKZ6cIcCSB/F
         Gf0z2NeqiV3UoH5896Pa1Tz+EMgMMV0hM6rcQkb993GVp9LdNcspdjkzcXpSxAKwSpmB
         mCwxPEpDxJ6cfb7j2eBlrXpuwSftsW885V0vkz4rWZhz+44QoNoFKIV6c871cFdgP/tx
         sTRWZF1GCKCSvJ9plNIPU3VKh3FReJ8jmXx2u3YaGGaYIuXVdTCLcnxoCYofiXm+iS5T
         81dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1I/Om5aYGl76EBPQH6xJKuHTrTxYjP1lSZQ1eei4PnQ=;
        b=GMHzR7seQNks45T7Us/+aCeOprX3QB7Yio+Gr11sxXnq25VSJi5ziLVoPl8xsjg0xT
         HVuyjlJLkpGr1k2NPKdYxbrWl/ugxpFMDbRL3yXtKxXqA3hOsILV6AcGMPYFkR9CFFKn
         bAdK5T8Kkh3uE/Knr1dV9t8NAhCEbNGO2a54u39vV4D4mmSc3PZJzjWBYB/Dngk0pHBD
         VwYXE007fK2JRNiI7mkJXlmE7YAgvj/LlAugSoyVAfX0H0/birMKJTFSKwt3rsni1Unn
         +S46nJkEoyk+hv23ge17hK7Kq0OKHVXsZLk34QAigM8y+NQCYVC9dEAnTAFFmqdbz3Mf
         rd0w==
X-Gm-Message-State: APjAAAV3vhxhi3jUTPCzjRqfEXmeGCdAOlaCsAyNpBwHotV2XAp5JTv8
        y0/hoHVd+KOnAmB0p4CRFdJ5CVxP0VE9oAgVUxo=
X-Google-Smtp-Source: APXvYqy9mase1ZnVcKmBnICOyv3t+KT6WikFCXT/0YPXUrGRlfZICYalsHFMC6sfA6xprYjrwUMx37FrmRKsqaItP8E=
X-Received: by 2002:a9d:7443:: with SMTP id p3mr11906227otk.148.1556396938787;
 Sat, 27 Apr 2019 13:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190423133646.5705-1-narmstrong@baylibre.com> <20190423133646.5705-2-narmstrong@baylibre.com>
In-Reply-To: <20190423133646.5705-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 27 Apr 2019 22:28:47 +0200
Message-ID: <CAFBinCC2XpRab2Hqb+begpMYFuo5KhWfwemQ6C_1LqxJbBjYxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm: Update bindings for the Meson
 G12A Family
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, baylibre-upstreaming@groups.io,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 3:37 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Update the doc to explicitly support Meson G12A Family.
> The 2 first (A & B) AO PWM uses different clock source than the last 2
> (C & D) AO PWM modules, thus we need to differentiate them.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
