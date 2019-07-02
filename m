Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF38C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6151E218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfGCAlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:41:13 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:40523 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfGCAlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:41:12 -0400
Received: from [192.168.1.110] ([95.117.57.107]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M6m1g-1hcKYA3FGQ-008H7u; Tue, 02 Jul 2019 22:26:16 +0200
Subject: Re: [PATCH] devres: allow const resource arguments
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Enrico Weigelt <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20190628150049.1108048-1-arnd@arndb.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <665cd853-ba34-8913-3b63-a88130eda3f8@metux.net>
Date:   Tue, 2 Jul 2019 22:26:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190628150049.1108048-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2EiotxMAAmjsTYjjhHFlQbtCH5AwERUvgcCE1kHa5uHuZFTKNvV
 UGRFM0uhJrjXHwsIbIEcNhcXAMM5vWS1GTm2Umhi1OSz48FFtH46MGI4VZYLopurniDJ+ys
 V5D08p2yqnG8BiqUaAlH3TLx/IyXqlXlzmNYxA9DKsGhUVF8ZsytjCB41D2IgUVoj5H4u0E
 82k93hZn3uDbROmZYe/4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rpp3EBnTlec=:HB9r0UmrVG8WVpvM3k4C20
 QGvr1nwEL7xBlydC4AuiBDChCpB6vw0kyzGQLA2B4Qywq8VDHIw5wEAqWrJG73vbxV1dbMHEU
 OUsLrGuuSYyoWXm4W5TvDRlQLwk/yKjD3SD+ysSjcCuyS9kNd1QnAN0/opSSCENNOfZmtAfEN
 IgeMWs78eIGKV+c6ftXRsJStYo6urMr4BYxJqIhT0gWg6hkhe2B/Cr1N0Not1+Pg5zILMb3Fr
 gBOm3ENpVUVr3ttJEzr27XOp/GVMEXJI7pBuBYlAaVLXRwJVqbd14mCbJLBKZnEeEez/fZOPr
 oPManpmN+yYbZyGO1E0YtPtm271K0RhK9mmoWCOKJAIbTS2fSpYaAGeyAPeNJjRwtrixnHf+C
 0bNv6jtw9bkMl9OeSGhcRuBjdzlpFDrA6Gx7UhDjqwIr+ki792JPMfz3kmrq9rw4Ko+mJPcn2
 PqbQVIrtORcIPVTmmyDdZHzFZ0xtRGBTNofg/rZihQbGHkFgHtk9y2AswdppJn/4sm/N2xUDc
 Iv7OU6KEadrtd29+tPfQ+0btH8XRBOQfbPBRasW8dekDYSIEnMIM60XcS1drkITW0QWUbIqYz
 FURk3NzGRNk4pssIGeWpykiXXFJ3fcBUic8WnvMkinEc2h3bW7fkgyuI98S5bqV5kKV2kEz9z
 htgfcUEPyobB3qc0e3/qD55fjxMx+WMzBpiiw/ZZLNxzrCHJ/yPii5AdTuREUUewianbiBk9q
 W0XO4BK5bE08iIwO8x6GSz9OMptv6AG8ZWibVOkv/dp12weGPNoX1qVsUpg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.19 16:59, Arnd Bergmann wrote:
> devm_ioremap_resource() does not currently take 'const' arguments,
> which results in a warning from the first driver trying to do it
> anyway:
> 
> drivers/gpio/gpio-amd-fch.c: In function 'amd_fch_gpio_probe':
> drivers/gpio/gpio-amd-fch.c:171:49: error: passing argument 2 of 'devm_ioremap_resource' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>   priv->base = devm_ioremap_resource(&pdev->dev, &amd_fch_gpio_iores);
>                                                  ^~~~~~~~~~~~~~~~~~~

<snip>

I've posted quite the same some time ago - no idea why it got no
response.


Reviwed-By: Enrico Weigelt <info@metux.net>


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
