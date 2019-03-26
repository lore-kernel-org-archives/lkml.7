Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349B5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079AC2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DR2k7H5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbfCZRmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:42:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34943 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732117AbfCZRmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:42:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id j132so10643787oib.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ksQ3V6OnXM5qhpcnJ5nmSh0VB/ZyAct7AyWcwfR7+88=;
        b=DR2k7H5Vq1w9+9V7G7zDURmGkuNjtR7LEckQ48Dwo1HsnrjGhYGzwnAGDHW/LHcnp6
         VSKKYqiwGoFiCogqmKbsEMM/8zG5dlc3imk2FQ5L7Ddmyfoew5rYe2gLtnkaT50j/n6G
         voAcjAoru6X4nhWWCpOzahRcJzSgogC8RYocOAgyXIisDxw5MTfwwHoTdASe2q7sGAMZ
         9/aCJ7W2+XboEPZCx7eQZJfoHaIB8YSpDWPiDTY4wTrVhGUJFxyNj4tWHhNR2/vdRxTz
         Qcm/XJzjz4inI4euOKYn45Jt0FyQKslMbHfC1U7BxoiEksatGdNQ1xUnVik2rgn+n214
         K99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ksQ3V6OnXM5qhpcnJ5nmSh0VB/ZyAct7AyWcwfR7+88=;
        b=oj3eSAhIZhNewy3ZYfL5XijWT3Z7TQsFb8KDoy6Qn7k4tajOk3vfJHUuWA7IIFUB2y
         0JA8D2T/p9UcjEaCeiV6ZzzN0554cl2ZV0cJTTQJdOkU0tduoCPEMSTebuprKvfr1GYe
         IA0pJJ/IE+CKjwvPq8fyvItDg4HHfxoA3vbkmmEv0n+Q1iNjVM9yBaQg1jS/LBc7v0N+
         9kiQyQAgv6PqK8YfQObqH0rUCEEdCVecaXuwGSRekN1Vzk3OtW/S0lCGzP/wVRxyAE/0
         jKlzji0hS+sSz0UtfZSuYaMvbv+loVzZHkZvhEP+Si38lj8Uk2IeyGQhfRU9GgtXIlTY
         7bBA==
X-Gm-Message-State: APjAAAXFfWsFturICKNnfRorASKkQ5YAsbKB6mmyZ2GsCz6dIkGpqPaU
        wVhNCds17ld6M6iVj/AgKSFnAtYGnv1Ur0h2hfq1jw==
X-Google-Smtp-Source: APXvYqzYCNT+YqoFGiflYiCNrDoyHg2615QHGlLtxM2wciSTejUVHPDaBbqQe8eUs4FNSurxl6KxrW0Sh6/c3gDU73Q=
X-Received: by 2002:aca:4c88:: with SMTP id z130mr16780530oia.170.1553622128811;
 Tue, 26 Mar 2019 10:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553610690.git.sramani@mellanox.com>
In-Reply-To: <cover.1553610690.git.sramani@mellanox.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 26 Mar 2019 18:41:58 +0100
Message-ID: <CAMpxmJX6y9aKD8=P+v+5db4_WsOna+5fvw5tGc6RvOE6PFWUnQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/1] gpio: add driver for Mellanox BlueField GPIO
To:     Shravan Kumar Ramani <sramani@mellanox.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 26 mar 2019 o 15:43 Shravan Kumar Ramani <sramani@mellanox.com> napisa=
=C5=82(a):
>
> Changes since v5:
> Use devm_platform_ioremap_resource().
>
> Shravan Kumar Ramani (1):
>   gpio: add driver for Mellanox BlueField GPIO controller
>
>  drivers/gpio/Kconfig      |   7 +++
>  drivers/gpio/Makefile     |   1 +
>  drivers/gpio/gpio-mlxbf.c | 153 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 161 insertions(+)
>  create mode 100644 drivers/gpio/gpio-mlxbf.c
>
> --
> 2.1.2
>

Applied, thanks!

Bart
