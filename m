Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F79C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E5920882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QxMbVVd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfDCCfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:35:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41763 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfDCCfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 22:35:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id 10so10495881lfr.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 19:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=QxMbVVd/ToMeymqV7HlPS5k7JGnCYEvjbnoCSk9+O+cxe3OFR2WPL/xsYJyDIhCw/0
         8k9VAD697auLWJ4kuGZ4KsSOd5fmabDsDD4qugTOBgs0PnmVzaZo4nRB85mutjQWTdZi
         RGWVzNdpefD9fF2FSUxbrlf3SwjhrYfEX2HTff4hz/9ZT8Te31R9JeO8mkC107Mj5DSb
         fndWTK6fKo09JFKiDNr3OSCPvoaG7YoHlXHgoZFp/VVyyHzQxGIO0+oQwnjoDsjiDOS5
         QttpomjcDzD8tLZ/znH1gBlqsqCSCAJt6xfZ/dV5O6PTcUtMs97TdKIX5vf7f98yXp4w
         IUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkQq/Hrmv0eGgt6shvKyYOCwWEYAJMOW7yeHRm4cO0g=;
        b=FwaMa6SJxaaMf7RtG0azs60Pe1gI4HTiZ4fZnut3t0IqKv4DLkFEmlAWMIHrIpE8nL
         +XCak7nNYYe/eZ8EMxYR7wmIVF3DXqrfq5BuWe7IUkVx2oVrb7rk0E4rQKGL9Z+qCKkq
         0aQzbNt7isjTyl3tA9TBzCxc2+UrpDyzRvDbx6xw7Yh9xK41hJKMotcnEAHqJeff37iU
         IFuGvt2a29xcTMaIcF/rAm6b+1BIesYeZ6w8lpI4YCM/tQAaykICZ45PDxzWDyL86+sG
         2I3ebOoE31rm/xxa9+Z3lWp7K0VBmZxFtKb7k5xFFZyat2sbKAD7X4o6ASYZhlDIwLDW
         VaTQ==
X-Gm-Message-State: APjAAAUp18J14z50NKlaAFPgImojU5HP0zMeCHqHeed2VW8OcF6455p2
        VUwxNLwlFA31ot93xYJ/XF1TdOuC3Q6OiWuplZMuog==
X-Google-Smtp-Source: APXvYqxvkjqKa77shbco4H90qLQnWzueIWFJaKnCY1K8N5GtalfT7tlEIQu29OxAou0xk8CVZZbv3kczxz4O8UbGaig=
X-Received: by 2002:ac2:4285:: with SMTP id m5mr11154447lfh.103.1554258905154;
 Tue, 02 Apr 2019 19:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-17-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-17-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Apr 2019 09:34:53 +0700
Message-ID: <CACRpkdbsUWW4ZEEykWhsAZKA+fQVf_wd857FadLVD0xt6aGo=w@mail.gmail.com>
Subject: Re: [PATCH 17/42] drivers: gpio: loongon1: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 1:55 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
