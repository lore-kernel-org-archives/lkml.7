Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBF0C41514
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 18:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC068206A2
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 18:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HZtm8vRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfHCSe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 14:34:27 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36390 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfHCSe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 14:34:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id c15so3879379oic.3;
        Sat, 03 Aug 2019 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gc1Gbs3YXrODx+h0QJxYpVYYuRirRF1j3l1DtaMbHaI=;
        b=HZtm8vRzHTiPtrlD+ep7+nlheEmUFbP9b4EUg4J6LpOHX2a7uEsusLTxRDfqS61g9x
         cdR/IZ0132AozZPS9fR4FEDvlmLYgIgfMHzl5hV2dFPX1x8xyIAKYk+veblc2ObM+VJI
         VzGN4+atmXhC8j7aRRxG9+67yE0WhBUYO9X6be9glR0FNre0PNkfEoEIAhK93PpWfUEJ
         QfDBjpQRBdFZtRAg/+dmpHdWTzaOAoGL+5M8nQx9nNBC0BRSVk4DQD9+/HqvP4amA26E
         pb+kikQQDdUfAWZ2uYBWBQ1ecrcGrMMUFG4tWP60KqUQJaCo40/MZXMaMeqShpRd3k9c
         FNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gc1Gbs3YXrODx+h0QJxYpVYYuRirRF1j3l1DtaMbHaI=;
        b=oV6Qcd+M6b8WqLiRTzc0iB+JF9ObD8/LcF7RlLxTMApqo27nuww1WMq//BG2fNQBFq
         cXNtC2dtpTjAWtcZqanQxvfYWuzpr3nspi6iuqJLKMQMqekoK1DtnbCifbAQ22aYCGKZ
         I8x+y2aXOvhQoQP++gwOnrjaIMqba1JJA6TmCFSaJm0DvI7yaQiGT5xjLaLQpIKVUq3p
         /mqQNNJTG6FPGYmzMwa6tu84FjnocH88LH32mHRfvIaCT2XL5P6JK7fMjqTqPwF+MEkr
         R9QiL/ANRixIC1z5V+tulKmcOs83Y6FD4XfvA+9PIcligyngPFJPcK8K4AUeeL8EC54w
         +s4w==
X-Gm-Message-State: APjAAAUCcxKxDwjOEGvPP26YR8OgxY9F4Poc9MZ9kbSzRc2uAYl2KeEc
        ysw8MgdUB5Hl2TlStUheNqgSIQPviewGDC4BWH4=
X-Google-Smtp-Source: APXvYqzn73LfCwFAFSrdAJBa/P+YA9JBZW8hIlZBhqmyNI71S2i6jS70rHCp7HPrXsZy/pyPLrc5B/rcaUGuVAHs0rQ=
X-Received: by 2002:a05:6808:3d6:: with SMTP id o22mr6470584oie.140.1564857266448;
 Sat, 03 Aug 2019 11:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190731084019.8451-1-narmstrong@baylibre.com> <20190731084019.8451-3-narmstrong@baylibre.com>
In-Reply-To: <20190731084019.8451-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 3 Aug 2019 20:34:15 +0200
Message-ID: <CAFBinCCU9q16Vg8uop+PTRQ3x8_LnYtNEaKC61Si_cSk3qsK5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] clk: meson: add g12a cpu dynamic divider driver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 10:41 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add a clock driver for the cpu dynamic divider, this divider needs
> to have a flag set before setting the divider value then removed
> while writing the new value to the register.
>
> This drivers implements this behavior and will be used essentially
> on the Amlogic G12A and G12B SoCs for cpu clock trees.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

personally I would add:
Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
