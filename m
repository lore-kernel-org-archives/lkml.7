Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A93EC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF146208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Uz3SxEZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfE0SGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:06:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40633 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0SGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:06:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id u11so15483508otq.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 11:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snK6jJsPt2cSi+KLqPDOwYhYAz49h47RS/7FICnk118=;
        b=Uz3SxEZe3/KUMBtLpSR9DuRksazc9sQh8Y1rw3ZYmGZKEDdF1pakQzZrAcm6I6koa3
         RWSyRcQwrZt/GFy/etLHeg1jeEI0wtH91a82uWMz94N69PHboC/Mvd1RnVKDf04oO192
         IEmQsEFpF8/k3UzHaG8bcci0k5Tm9Ff3vgI/gjg/JzFy+NGfyRJnfEz+gnshlCkC9GhE
         yD9VDP3kJBXCFPM0hbHs0Tbsm4cGoC3Or8GPTC25HlXuNGzM4aG0KbOQe1aVyN2pw0JG
         p/fdCCT1aAR6ChXHuYV0tCbgZoQ2Yn31aAfznXGR5fclChYmbeFjsgsnZ9EiFWXb+FkN
         khng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snK6jJsPt2cSi+KLqPDOwYhYAz49h47RS/7FICnk118=;
        b=iusLetTgbf0+GXPTEzNnwzbTG1LxwDV4ZWjfGaCa/3oVuvsesF8JaKlZlxNn6/tzvb
         KYSE5BlfUQifL+hKfBLqtVh4kV/ip1Q6x4tG/8S4U9A49qLx0fWsdvQJCo4FX1HAyp4c
         oIeYt41lXvntFeqUOi116HD16lv1LiZLFhZx9PO5DTjd4qR4SVqSDrK4Nt1xPaF1FMQJ
         FvN5hp/TfKmUL2vQDomZaWmbEQeuNfj+6uFpao2ZSZFXmgdiqFUzMWewjJQwcvEH0RiD
         qppZOXG1A2e63kKodE42RbAkZldVPcYlGOimK3XYP4I7XTM56jInBDB87stL2bcuRgsf
         nKUQ==
X-Gm-Message-State: APjAAAUImt8IqR6rU+tWGKqC2G3XJsXhb1niw1xBZzz16zK2rgsJOjUD
        UWs3LCy9gnlwyPq8gObEnGvRX4dKiHWae64ZQUY=
X-Google-Smtp-Source: APXvYqxgFZc3Pv3vlrT0PGq1/+3W6d3l714KVeY/h/DwK3dNU2U9IMXHfxtnwQ85CM6AHjQEp4xb6lPqxgzGJpNUgCs=
X-Received: by 2002:a9d:69c8:: with SMTP id v8mr18558055oto.6.1558980395825;
 Mon, 27 May 2019 11:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190527133857.30108-1-narmstrong@baylibre.com> <20190527133857.30108-4-narmstrong@baylibre.com>
In-Reply-To: <20190527133857.30108-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:06:24 +0200
Message-ID: <CAFBinCBJ2S100DQLWcCBN7uyUR8orr9-qKEX6N=WqZpEo5ptBw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] ARM: dts: meson6: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 3:39 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> While the text specifies "of the GPL or the X11 license" the actual
> license text matches the MIT license as specified at [0]
>
> [0] https://spdx.org/licenses/MIT.html
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
