Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117D9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D409E207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJsPh5Wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfDBI6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:58:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35220 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbfDBI6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:58:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id t4so10845208ljc.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vHPapakipVF+IlDmV1uxsFzg+cFJnSIOX+OXVInwoHQ=;
        b=nJsPh5Wnr57TXHSHpgGFiCB8+4JU4vhb7D3iaHa7r6H1C7j3v/KErU/dNRcTz/fbn/
         SmYfWy/Tw18Dyteca8yVB8Pq4Mx4RpEJ9sJ4qzXKuO98chDdzMl9ic63xntU5376Z5pn
         hU9Zxp7VK4WLyOVUrIe0QiAjTEszps9Wk6HRxM7+3kq9dbGE09qxjm4Bh+NkZKOC1n8p
         rdr5pcmpoAm5TA5T64lVKYuo8xQ7lbAQa8HuUgeLMWdoTz3EzVcDNyfDLkXZ7W2oLt7d
         9WlM7u80cSU0c7xM1mZOKTLFk7/sj39O5noKx6Shg4P7J3stFW8GFqwO+FY3tOVln+Ok
         iVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHPapakipVF+IlDmV1uxsFzg+cFJnSIOX+OXVInwoHQ=;
        b=bgzFTGkNQA9xuR4B+Stc7tmfO+yygj3uyQkdXkmbU84E2yvCIeXSXMkKKeiU3BmVkm
         e6IJTQyW3W66+FX+xHdr0D9VtjtbZMTUGhdPyQrn/48jd+UaQhWvf27WJk66i60ldZDP
         XJ95BGbvkEYO4Xpfs+pAdK8uevDWKA3+LdOnO4KvsshbY83GdbORIZGw91ym1VNRKrJk
         KRv4ZUZOc3k7k9HTXqdAeqKiJZgbuRlk4hKmxfekpiiBn65JH1xz62aSxSLjcI25dDiR
         54FW4w0j1V5Dm+jiIMYkN3OHpyIZvONEND3Hfc6n3thNW8xgah9A+++MM2lvBeOS3Uwo
         yrmw==
X-Gm-Message-State: APjAAAV6UGug0DoW077bNmz97RbjFwmlUpRAF/mFmWZJSu+04dcejgDl
        LjgNzTBUzxGmDYR14nWeoQp5Wh9hjCRB3AIat8ygEA==
X-Google-Smtp-Source: APXvYqw+qie5FmIxKv90NJ6cVymC3Ijj86umRzjBW7o7X4Iy/tDSgELJgQTMPcqa2NWbuXlrpHjftCAwq6D8YVbeM5s=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr2330248lja.49.1554195482337;
 Tue, 02 Apr 2019 01:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-5-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-5-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 15:57:50 +0700
Message-ID: <CACRpkdZCawLmDFXKGXXGWTqN9r5dHevHLLBOs=ou-ro6G2-HKQ@mail.gmail.com>
Subject: Re: [PATCH 05/42] drivers: gpio: bcm-kona: use devm_platform_ioremap_resource()
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

Patch applied with Florian's ACK.

Yours,
Linus Walleij
