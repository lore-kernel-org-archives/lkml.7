Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF041C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACA721743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2vezRmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfGQQok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 12:44:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36469 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfGQQoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:44:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id q26so17023992lfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yk4XP9CZ1kslTNlitSHU1MG+UFO4IaHTa/axM5q+rdo=;
        b=F2vezRmfQSUXDCV1cPzbOl2mzviZagTPoHiu/ODYdsVpUBhK9w9YTNxRiMunEfJhbe
         3mqlmRvWWVWE6Wv2vMgJ/3fBXkb3weOGO4vSXqe1TpskMrzWhuzEuBnbHN2a2Hq7gQ+N
         E0BypQok1qcNIHv9hOwhsaElTu9JZ9Rqp2IpbKSGBiLu7ZE4GXKoNRauH2aKK/ljCC5z
         monU+OXeYlqNMgfB3NMS8HM2UQQH3Q12XmDlf9eAzdg0CjaNheV90gHdKVequ8iaodmB
         iPe07LMAM179eQNaYMQKSFAIGnaQEVwfW9GcMigIERJVLEFsmYpeY5n5M4g2gsHVL8c2
         047g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yk4XP9CZ1kslTNlitSHU1MG+UFO4IaHTa/axM5q+rdo=;
        b=EpQHpvT7Oo0jl1a84fAISjR9ZSoZzMRxUh8Zl6tRD61LpVElBPpV6+30yeNDxsbAb0
         dkOD+wzsIMFbsNB3iIe91+h6rP+yrQKGjMTea9bvLS/s8RsmxkaVEFtuMgcJgZ6nCivU
         WioOEdaCLTsDhlzURD/n+kse81IBEfweh6Ni0kguDjtHqMGZkfa9vyDAl+2oEuKvzX8A
         iiOdL5GGL03uQMjZ7riBSevyTu1ncjKFRft78HZlgdAaa1T8yf3vrqUsGTEsbEOytY+p
         rTgQ5UMYWQQqMAT4MT79GkYCngCPIgsmjgCuiKQqRyJ+DZMeyCw3Zis1hr6ken6DJakj
         6vtw==
X-Gm-Message-State: APjAAAXF7ljhl3ZGm+1aWAcZs2Jt5TAkpIS1BHyOSgilP3O7wFZznoyi
        el5fQ3jCqz5QdBdaXxdXrJtnAha88EM9RvzfAsWZ+GHH
X-Google-Smtp-Source: APXvYqwQLMvsudJ95j/wcOmtZU/P9Yg5GgR6Iscd/wl6FHMGs+YoknUb+sFGT6wakjO1DBNIm8fyfNl1xZoU/iz67ug=
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr7368803lfp.61.1563381877741;
 Wed, 17 Jul 2019 09:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190712091357.744515-1-arnd@arndb.de>
In-Reply-To: <20190712091357.744515-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 17 Jul 2019 18:44:26 +0200
Message-ID: <CACRpkdaKNk3eE5cfh8fKQ341PhDxOCRqVz8Cay5to_ZZ3t_7Vg@mail.gmail.com>
Subject: Re: [PATCH] dma: ste_dma40: fix unneeded variable warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        dmaengine@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 11:14 AM Arnd Bergmann <arnd@arndb.de> wrote:

> clang-9 points out that there are two variables that depending on the
> configuration may only be used in an ARRAY_SIZE() expression but not
> referenced:
>
> drivers/dma/ste_dma40.c:145:12: error: variable 'd40_backup_regs' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> static u32 d40_backup_regs[] = {
>            ^
> drivers/dma/ste_dma40.c:214:12: error: variable 'd40_backup_regs_chan' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> static u32 d40_backup_regs_chan[] = {
>
> Mark these __maybe_unused to shut up the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Seems like a reasonable fix:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
