Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E550C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2382021E6B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4cZ1y0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388120AbfHGNNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:13:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44659 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387598AbfHGNNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:13:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id v16so10137073lfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QPeSCYBgEa5oHwi1QvDtW28UD0MCoSfvST8mfWPIVyY=;
        b=c4cZ1y0tVhiymf92vKCdpgKV+43I/vq5Hq954nP/OGUR83Al7woXs7oQ+xM2A+9xlt
         zkLV5BhRMU4hBSd8vZW7ixinpfEKEP6SBL4D6TDHbJwfjF9Ca+5KZmlzPImEBg5RsHml
         wbpK1wfmu+hAZX8AxkAGBzpYPT6uFEIpMMKXMSbSnfLdcU4VXCHaET1Uw03eaFmy7PvX
         i0C2gHqF7qfGN7eqx+JZg/IiFbUy/euOvdAd+NE0qtyJCwObVcLbXGD7Pct7PPe8GWyn
         zJVpkNkJ4VowqJzICmPlcSAH1mJVVMBcZlAx49s2JPt3nD/l2hsgjSPpYkpHyv2slKSc
         E84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QPeSCYBgEa5oHwi1QvDtW28UD0MCoSfvST8mfWPIVyY=;
        b=llD9c81RO1Gm8EqKmlsHDXGpuA57iNLuACXPbfd/X8IhXEWNERFC1DtlsKoJEaPawk
         pfMNP+paZlE+kNvvn6mpxAd5VecZkqJcyFxi1EiKxkTRrtWLeCmOATl4J9QoDuv1/SPD
         o2WLnlw2er7IZAhQhw7NrNRQfnicAeQRiGzT6kj9eOst9g6Gl0rMvOmlPbxzZmLF3hJK
         nn4JFvbNrvT/A69UYRHliURiZEhqjF/oNanmdXRG5sNRZBvfZrFo58ymgbuK4qIsidOo
         HiZte+YJ+CZVGn+4G4Zp+OxsbyV3Up4oXRPd4+mo74rAfWQoazlxkyaGWlWeOBj7hwLE
         DXTw==
X-Gm-Message-State: APjAAAUwr+wsCEacHUTDdc1ean26RTP215CMHUPHYY84EtGv3TFkoC4J
        po5EbXTx4egKZZ+QCOy8p6OaMQzfpvWh1YPGTlffCA==
X-Google-Smtp-Source: APXvYqza6NtwlGeUFU7vhHOfryh8rYMl0CQaYDfKwaupdDGLNeQyV54Th56/MC1GP5/Xg+l8Cv9vr56lPJQ1c5I8FGM=
X-Received: by 2002:a19:e006:: with SMTP id x6mr5763750lfg.165.1565183584803;
 Wed, 07 Aug 2019 06:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190728235614.GA23618@embeddedor>
In-Reply-To: <20190728235614.GA23618@embeddedor>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Aug 2019 15:12:53 +0200
Message-ID: <CACRpkdZuC0PS7GB_rx4q7YSbVHan0Jy0L+pmDuJv7ec=b6UoSg@mail.gmail.com>
Subject: Re: [PATCH] mfd: db8500-prcmu: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 1:56 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:

> Mark switch cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> drivers/mfd/db8500-prcmu.c: In function 'dsiclk_rate':
> drivers/mfd/db8500-prcmu.c:1592:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    div *= 2;
>    ~~~~^~~~
> drivers/mfd/db8500-prcmu.c:1593:2: note: here
>   case PRCM_DSI_PLLOUT_SEL_PHI_2:
>   ^~~~
> drivers/mfd/db8500-prcmu.c:1594:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    div *= 2;
>    ~~~~^~~~
> drivers/mfd/db8500-prcmu.c:1595:2: note: here
>   case PRCM_DSI_PLLOUT_SEL_PHI:
>   ^~~~
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
