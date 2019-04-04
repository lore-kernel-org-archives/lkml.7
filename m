Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE22C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA09D206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FmoOKUi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDDFRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:17:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39614 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfDDFRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:17:24 -0400
Received: by mail-lf1-f66.google.com with SMTP id m13so775508lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 22:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZVp13yc6q87s+OR/Or4+n6UHxk+xyuZGfgJ+9ddS0ag=;
        b=FmoOKUi0seCeye3MfcUL/av1v8PHsGVpMCFmhyKh6cC2aWB+BeQmNKvlKqIDjTAUMY
         nGAJabZavlC3r9IBWFWakNdNk2ZjAbz7R4G7n1F+s8QCGEm0mCGTKKhR9zRkOAJz448p
         Pgs3jzGvwN5rNWSRylnQ54BdLj59ujGxh/DFx6pKA0kGWOyg7AAeQQMWEVLsrBMDvCFR
         NVrhTNIVc78qpNGBW0o9rhEe94YveTQISdnAufBXEkc47zlCELK6M90eXyiAsBzx+hcJ
         Pbzi7izizs687j7Z+i5OgfEQ0CejhS3hbZhEjAts8Ox39jyM1avxxOGFi5r/byppJnuP
         G/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZVp13yc6q87s+OR/Or4+n6UHxk+xyuZGfgJ+9ddS0ag=;
        b=klW031BdrclGgQQyjDWavCXIjqoNEOIu7LhrzjYM9G9t4wfgQGdZJ1rEHRXhEO5MVy
         3cPUHfK30b1eBEVaQ53xP88fyA8lirSy8Wr4apXVTs+WqutyZB6X9vs5cWIIHPqDNjCr
         An1onJSOhyOUNg++fo05TN6sSxJ6QL2NtIMsZwY//VSqkto2VY1eEtWF7gqNcQkB94Gv
         WYo5F1YUotcGOesG12LEuDDk/xhWR0ZTgIBBCs3zfs5rEY+6wrPVlRtMH7Zgfo7mYLLT
         3ySVhCk0JD4Nh87CcBnF4xQdsf7IpGC7ebBCOBjRQCdCXsm+YUV6K0fOdZYina9AHKE3
         KsqQ==
X-Gm-Message-State: APjAAAUoZFCYuwECNRFwV2BnAQ4CVgM79DVaojDnMLKLu7pfQziC1A5/
        mI5JWjLMkM3zvEWGpBUb4/fQ1RwZh2ts+/YfC5LznA==
X-Google-Smtp-Source: APXvYqwAI/6Fn/mul2qD5ucj15urIhgHJ8VhEXp9x1hACi0nE/g8/s4xiq1LRwFjmRW7wIPgJqwLsXApCmVv6ptQVHo=
X-Received: by 2002:ac2:5479:: with SMTP id e25mr1952075lfn.121.1554355041901;
 Wed, 03 Apr 2019 22:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190320141425.20920-1-yuehaibing@huawei.com>
In-Reply-To: <20190320141425.20920-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Apr 2019 12:17:10 +0700
Message-ID: <CACRpkdZfAbAv6f3B77HfEjssfqSx0tKAbA_bTb-YWKvutRx3Qw@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: fsl: Make pinctrl_ipc_handle static
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 9:15 PM Yue Haibing <yuehaibing@huawei.com> wrote:

> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warning:
>
> drivers/pinctrl/freescale/pinctrl-scu.c:38:19: warning:
>  symbol 'pinctrl_ipc_handle' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied.

Yours,
Linus Walleij
