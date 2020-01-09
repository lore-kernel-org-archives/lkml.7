Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09BBC33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E42220678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1PwuSuSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgAIJiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:38:51 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38296 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbgAIJiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:38:51 -0500
Received: by mail-qt1-f196.google.com with SMTP id n15so5341670qtp.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2u8yX/6m8ka023+i3ocnOCOzpKH3BIMDen/cmCWdkZM=;
        b=1PwuSuSkQeo2awFeIpunataRcqxxnosFO8ylwONKpCfiRdEv2cMuQs1iPcpN39ve9e
         uVjH/aPbvGPFq8OavOOFJllWZHYTgp1MhtC8XftSjaXWezfpXGdWK5I844c8mx2xYCiI
         p7mugL6HvWl94X8/igMXHg4xsHF7undgc0pNCXTEBGCu6pRD472FMHh4BUXYkRTKJbMm
         KCkp8A17IH9xEnwOvI2pE1MNzKMo4RmJUZu148DpYF6hRQ1NDw4lLdbg7cdHcEksf+it
         JjPpkS5/lhlcQKNJ9Jjd0WoJCUdrPuZshMhwrF8bm7mi1HvxYCvaZjV7y2JvGSuRy2ir
         ADRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2u8yX/6m8ka023+i3ocnOCOzpKH3BIMDen/cmCWdkZM=;
        b=j3FBjzG4FeCQ5VsMowDizB6R+ERpylEeUqudH7JDpibtTX2yzDXfz9It6/NG+6b+uU
         x1HB6xK1cfOUe938361ilmHfPBxkZibT8uX4WeksLQWmCNx27W9bG6h0vQbxSms6WNgr
         lSX1k4GE+NHUYv+S9y/G9AJtJa85xZr1YCbnwWAx1No6MOlIS5iWIlz0abe3McPDigYb
         o1zZlym4sEQOUwXj2uqEF+HzF9KaOkavj7TUTY3GVzcfuXDjDXjR1aCoVa8amtzQkvK0
         eNxHFYVgVWE+QZJgHOWRZ5reMTi1qv79bEsN1MFkBKEGVfbK/7qp/mU3Y135VUtQVvZ2
         654g==
X-Gm-Message-State: APjAAAULYMvuyBtd11BfwDnFlpBQUwWoX7jquraxzGaXlnZHBrlG8iD5
        OY/NKfAdypcf9KaqCYK8+Oc8m6wDZnguVSsmXnEKlA==
X-Google-Smtp-Source: APXvYqz2yXGoSQ7sbAosHgrWq7wGGl6W6TxGeK5uEo27I6GnFOmxS2ckbw/hoaEc3ak4D0wM+n9dhiGnP62y3LgUTHY=
X-Received: by 2002:aed:3b6e:: with SMTP id q43mr7032621qte.57.1578562730145;
 Thu, 09 Jan 2020 01:38:50 -0800 (PST)
MIME-Version: 1.0
References: <20200108161620.80105-1-joyce.ooi@intel.com>
In-Reply-To: <20200108161620.80105-1-joyce.ooi@intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 9 Jan 2020 10:38:39 +0100
Message-ID: <CAMpxmJUMhDeZ=EjjfNJnF+ikAfNq_hh2LP_TTnpoTb3oDMCCow@mail.gmail.com>
Subject: Re: [PATCH] gpio: altera: change to platform_get_irq_optional to
 avoid false-positive error
To:     "Ooi, Joyce" <joyce.ooi@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        See Chin Liang <chin.liang.see@intel.com>,
        Tan Ley Foon <ley.foon.tan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 8 sty 2020 o 17:16 Ooi, Joyce <joyce.ooi@intel.com> napisa=C5=82(=
a):
>
> This patch switches to platform_get_irq_optional() from
> platform_get_irq() as it causes a false-positive error such as 'IRQ
> index 0 not found' when IRQ is not used. The IRQ usage is optional in
> this gpio-altera driver, so the error log is undesirable.
>
> Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>

Patch applied, thanks!

Bartosz
