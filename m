Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8411CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A5C20856
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iSsXAz2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfJaAt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 20:49:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42552 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfJaAt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 20:49:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id a21so4722062ljh.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 17:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ANRS5wbwl/qhMyqDjpLwYIen+6o/RnmGm7reuX+RDc=;
        b=iSsXAz2h6lI4/+bDAgo3ame/BZgVRj1aE4CRhVp1rkjDm5vlU5S7NBZHxBEgHg/wEo
         LHjrlUjzfObyMjWplPS4iUm9RjAgF5qeticJqVKdiQIoBq9hkhZrryXIwlO/lC3rF9zI
         RUGDn7MhN1RZ4aziEd7tokbiKmLKGtqN1oh1/Bkjo66ARSTwDEhXLfli2ZXzr+qUE27g
         ego3mqJPqzkvZTa4lU2SYZa52RhXEJMi+KQRYiuHajDJTdUR2yAdoa+b3h4qMUN8tIfP
         QZ6T99SeDihkZKnIxQBn1vOcNEJvsNSn6so+SKVs83W44KBmKnvrJIpsFergM970YDYy
         jX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ANRS5wbwl/qhMyqDjpLwYIen+6o/RnmGm7reuX+RDc=;
        b=VxOZ4aYFTAA5ltAKiy9kTuj0qWJhNjiAX8190lmtKo4u/aDoOWiIkC1y7UkmDtcphy
         AoZnfQUTQ1F3bgFDmhiYU0/pa55hwwGPD/fUi9drzIswU0LijT/DBPG+CRHpkBOOc8zT
         ysQa6jj9n/iEQ4bQJZJM4gdV3SUUCeRpfOX7jD8ovbxVqPFjkvqHIMtP5BxXnLDMNaJs
         7tu6kVxe/+YKO3LHr4SORExon3jVKxPVEmW+aByQU43rtLQBLr1pva/cnqyquZPUm1W2
         Lt9TnzrVSSDjFNPvFjhVZw6tvyo1uevd0ftQh0vRMsxMriPuCxEfO7RIbfA7brlwm3xo
         ULBA==
X-Gm-Message-State: APjAAAX2cSiR8D0OLEv0WCnXWKv7JSVf49dhQCAz2W88RAGp1W8E2I7m
        Ylf67Ccrzdjd4BaxL7fL9Y5irJoMyM0HgQK4kq6WYA==
X-Google-Smtp-Source: APXvYqwM7PCCU+3fgkz+ysEB76Izdi4UnxQslU0hMR9roPFMeD2kCgFi2OfvADVGoZLpFkAT3ZECdzLcVTd/EaP9GRk=
X-Received: by 2002:a2e:90b:: with SMTP id 11mr1671387ljj.233.1572482995258;
 Wed, 30 Oct 2019 17:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191028224909.1069-1-rentao.bupt@gmail.com>
In-Reply-To: <20191028224909.1069-1-rentao.bupt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 31 Oct 2019 01:49:43 +0100
Message-ID: <CACRpkdbOPq4AYt9CLoganV_Ck9bYS9+_U3bggGKAukaQ=FHXkA@mail.gmail.com>
Subject: Re: [PATCH] ARM: ASPEED: update default ARCH_NR_GPIO for ARCH_ASPEED
To:     rentao.bupt@gmail.com
Cc:     Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Burton <paulburton@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 11:49 PM <rentao.bupt@gmail.com> wrote:

> From: Tao Ren <rentao.bupt@gmail.com>
>
> Increase the max number of GPIOs from default 512 to 1024 for ASPEED
> platforms, because Facebook Yamp (AST2500) BMC platform has total 594
> GPIO pins (232 provided by ASPEED SoC, and 362 by I/O Expanders).
>
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please send this patch to the ARM SoC and SoC maintainers:
arm@kernel.org
soc@kernel.org

Yours,
Linus Walleij
