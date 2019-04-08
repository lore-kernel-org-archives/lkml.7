Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A89C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CFE2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CaKatH1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfDHLmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:42:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32961 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfDHLmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:42:11 -0400
Received: by mail-lf1-f68.google.com with SMTP id v14so9279288lfi.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 04:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QT8oNj5QjP7tRSO7hm0rI3uXmQX/wip6Y7a7UPC1iVA=;
        b=CaKatH1meK/A+G4ZhOoi0ZZLmD64EfaFx8B47ksuk9n+rl7siac3eHnCe8vP/RWcW+
         YbfCLzWdkdfElWu9EKIVY+sxoj56+5YUYC3pooXvF/gko7LjKRORuWUomSWEKp/VM/fi
         ck/DgLnrWOLEFdzSdxfp9ioh96pnmg8j40wWdCNSXD8+cildrmkgS/fV04R46OYLN6wG
         tEI7W31jOqWoAWlo+COZO9+cSpnFymu+4EsgQ9xScLXQDwvxn9Zab0bkJmmpo0cZstIH
         9oXAvAErXEbQWtw80FHLEZSeks4TqzumcSYAVqL80jGZ8Z+pR95r4vwYX1+AL5Y4/juE
         2CuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QT8oNj5QjP7tRSO7hm0rI3uXmQX/wip6Y7a7UPC1iVA=;
        b=VtNby6H/2oti29OEHD4Yd6iU3FU1HgvgGcTnU9SA9hbMRi/2EV2zwsu5vc+YmEGEhE
         vXcr56e1DQmYpwh/b9H35GZXV7qXJQSuGzinaJYY44g/Cyy0BxyBbsTYZqE4hf77fKHX
         YHmt7Dgkux7WqqUWhnegb+wUTUUpXWLM9apZk2xVpN+/I1Wv6JudwlWrwSGM1nF8Qsik
         X3UMhQh5plF1T2m43vhrKQsU1ji9aN3tB0XmnXQveykTb/nWir1jrNjluSZnVjz8YkjA
         n38bKcwmFQIL43Bej/K4hbUor2DA5/zzbieuYE1NV8ZA7QWEzjY9EDYLFXjf4iCc+M9Q
         HFBg==
X-Gm-Message-State: APjAAAVKg9gMjGA00iIWgB42v8zIZg3tHIf5qaW086KeqfzXK/cd94Yx
        MZvYiY18v1bnmxZlE9r7+DgcbGF3Uvkd66zFlfyV1xsC
X-Google-Smtp-Source: APXvYqyGV9Z0SvNtHpsZkkjpIHbvFroUtFEm11nMfUq+L1OZ1kfCuTeIfLO84LG3+0UjzqPgeV7h9WgAzwur80BzDfE=
X-Received: by 2002:ac2:491a:: with SMTP id n26mr14767765lfi.122.1554723729327;
 Mon, 08 Apr 2019 04:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <1554094986-14897-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554094986-14897-1-git-send-email-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Apr 2019 13:41:58 +0200
Message-ID: <CACRpkdb9-G+Zc4xrZh4qHFv8kA7F2Wm8G46w_YPvPb2kUUPQ_Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: freescale: use devm_platform_ioremap_resource()
 to simplify code
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 7:07 AM Anson Huang <anson.huang@nxp.com> wrote:

> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Patch applied.

Yours,
Linus Walleij
