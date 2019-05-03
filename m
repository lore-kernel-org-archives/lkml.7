Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D30C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36132075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 13:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WaxjY/Wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfECN3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 09:29:34 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35348 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfECN3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 09:29:34 -0400
Received: by mail-ua1-f68.google.com with SMTP id g16so2012945uad.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 06:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtQarfjvBVELqAYN+Ba2dtNFq+u9qtxgeg7ns1Ue40Y=;
        b=WaxjY/WoDhL7nGbSX7lFGJ71jz4K7qOKbL3imHr9auDwTMLOQMSV75mOHf/Igr2G9f
         Zsa5W7OHaDLyXkHoPAN2Xk6cSZ97mvLHxfPtqDDrTDM3mJY5LF+V9cxKj7BBE8bgGuZ6
         ighhVpC0VpwHAdNGcRo4ludLrz+jyeP+mujh9jaKf1S6ndI+RLgMhdQyDOV8THcrdVcK
         McHsHze3OBzsuMbSJ7Rw/3u9QVwIwFo/fDkZJZMJNOY98P9uKvsrN+Wa1sxtDS16IcTt
         44LwwYm8nq2f1BtmrkYVvR9YUPGCgyaWXKuMDNtszOnv2QR0fJXcgXXnajJR/lU2fyRK
         BlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtQarfjvBVELqAYN+Ba2dtNFq+u9qtxgeg7ns1Ue40Y=;
        b=l6LLozJhCJY6MgQax3JEbE7ZI5xhBAxGyPkYulzRS63dFm1Zdh9lho5eCwMUhEXlXX
         H9p04splHkbSaKIj+w1ODlUTSzffUXqnOou5bVtrZaRLQycvtTBRQZksMFC7T65fPyAM
         bx8K+n3dkJjoK5t6PqGtcWJaE+2gE5/iE2O6SruQA9o4K4c5bv2DalgJ72rce8tz6ZcY
         X6frtIiy7vqvazSeDxM0NXMSyTTg/KGqfcosg0oCfnxas5P4QuU/Y2N1joaVu0s6QoWn
         i5R1A2sscXXCKZjPgIIzI2lUDIa6hqTEA+HW4ArFxxp0MjvSXOGvbTR36o79aSbvsig8
         FJ8g==
X-Gm-Message-State: APjAAAWukba5os4MJhv2uFnHdTOkDoJgx6iAzn0+QjuNrbT4pXG/UL4E
        5yLx9bpfC3C54Edp0YTWGPufrEVJ4UKV37wn0mbeaQ==
X-Google-Smtp-Source: APXvYqwnmdGyKdfMPiSIuwt2e0HNuMqoxfqgddY3iC09i4sLQrrpLWQU83CoFwPzamWtIIajUnTeAeKS42MMJHYU/dg=
X-Received: by 2002:ab0:2b13:: with SMTP id e19mr5169793uar.15.1556890173163;
 Fri, 03 May 2019 06:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190423090235.17244-1-jbrunet@baylibre.com> <CAPDyKFoQyPKERckAdU+kkw3go=161PWc+5GAkz7y=xWMGbq+SQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoQyPKERckAdU+kkw3go=161PWc+5GAkz7y=xWMGbq+SQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 May 2019 15:28:56 +0200
Message-ID: <CAPDyKFqvkn0x6+AWKwa1xxj1adj+Ehy6jmoqPfh=0Dhm8AxzCw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mmc: meson-gx: clean up and tuning update
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2019 at 12:44, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 23 Apr 2019 at 11:02, Jerome Brunet <jbrunet@baylibre.com> wrote:
> >
> > The purpose of this series is too improve reliability of the amlogic mmc
> > driver on new (g12a) and old ones (axg, gxl, gxbb, etc...)
> >
> > * The 3 first patches are just harmless clean ups.
>
> Applied these first three, postponing the the rest until Martin are
> happy with all of them. Thanks!

Applied the rest of the series for next and by adding also Kevin's tags, thanks!

[...]

Kind regards
Uffe
