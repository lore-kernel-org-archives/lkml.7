Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B048CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78637208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Veojztz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbfG3KBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:01:06 -0400
Received: from mout.web.de ([212.227.17.12]:54015 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbfG3KBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564480844;
        bh=EtuMB5xC3CZJDxVHY/O5OcOMAYvorEX1VzzjKU1EJ7A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Veojztz1Ev8zLpcBloYVB51ppw4eFxGzyJTy6w4TZFrLHOSLzaqBKi64qLWuibKrC
         XhFq5U0k3qQYte7ZuPQ53RdLoAXW4ozV7bBu7mg0N15fomvNKx7v0W5TrAbB7mNohJ
         QUPThwCwQtjzdydBAsaJYCLG0V6q3T1aoP4MDiUE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.24.141]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LsQPU-1iLFUi1yfI-011zeH; Tue, 30
 Jul 2019 12:00:44 +0200
Subject: Re: [v5 2/3] treewide: Remove dev_err() usage after
 platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20190730053845.126834-1-swboyd@chromium.org>
 <20190730053845.126834-3-swboyd@chromium.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <618a7f7c-c4f5-aaf3-a925-4357e9f56236@web.de>
Date:   Tue, 30 Jul 2019 12:00:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730053845.126834-3-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:iDekILvayeWfwQH7tDfGgp2eHlAVkNOZPgWDWpFODGPlazCtvh+
 ExoLk81OyA47XW+fvZuV6dQIcxAHh89KbS4fvkXxO+MeIGYLAebDXGNBKSsXdvBPGTvsxuI
 lapznyt9I4WYlFVgW5n7qPJwfqMP8tMXd3yYepgWIcrx9aQmfZ9QFnXIxv75+PFZbRjMly9
 3Atz9CG5Koq+ZtHVmyM1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kvM6BW7wdh4=:IYolPJ1QzR6V/qcvf4kj7N
 Wy/yOAxWn060EU8R+yJAYpjao0+UVLym57RYbqKgL5ECGbOwIRJa/XbV8oMTq/mMPn49DE8Sl
 KLEFiYTKBh6aMzUOw7utmC2yaCs7/zyApxW9Vl5YKPEr9tyF7fE4ZrGtLRr/AL3mmzDv7fk3B
 aS1Oift2pDBTTDoO4a/IEa1wq01WXaOM+GPPrEJsghWxtc++CBOV6DJXZQqBcLaunxgoMCVJs
 wcKnB07PEUt+rQ6Sh9H0K7Phcexx+jo6y63I9UzwOc/XGY62gk+nifVXEKQlmVsKfAD2zcxGv
 RX7GeEhLpPR2cpewz8uYQBHb4xOxHQFSpiZcmQDuPm0EJ1eGYGn2Cr8GeeRLt4A4LfNQk2w6F
 mMNzIwiS1oBZ9R9vvRjyoaRz7ReVd8lJ5/Cl6JQOYgZDjeIocLaY9AT/HhQq4CJ/s7BlNEEGZ
 ewGLBFYc3vxBecVqcMScF+jsi+BoQ6vduRwbTT4+Y1eiZK+W0lKVyCZ2qK7fM3/0pSLRL7ao9
 CkAmDBF7QoxKxcLsLqoBUv5MXUIFndpiCM30jCqopuEHyQKG5b3Cq+RmW+02gsRRxkzXMv+kH
 5XvO2WBRWlgoADnJbHZ5BkSyWXX+52CbMdKJA0bq1K1uetdOEitOEzTO8TSEw/r49Aa/Y3ZP7
 ewDEDUyoXii+k0274XrBgXA1UJsmGVbDEmvnfiJLxaa/Nyw9qZahFj0767WzszbjskFc/nWO3
 DI5/Pe12yiRGC3A2tpy7LBZWJxO76Shk4GqFMHiLN0JNM9vglPMQQGcjnm30VIyhhBYfichPk
 AudXmE7oUYR5Dp4/577hwwYbxZ5bIRyb1ctTPSBh8rwwhdnPmlQDJvkkmF/sgYr8DOCAlY6Fn
 qtOhRWdb+ZbADYuJWdaoEuKVTwbTNYb0nzh5Z+DK7bJMBM7L67TTCBsru0/J3WKkrgAoSBy8B
 AQ5TpMSnRUtRFzaeH8Qfj3jD3/lDNjrdMiuWgZIgA+6dMSKp8Yow1dGyMg0M6ySWC5dWHhbDN
 uWUMq4iCAmGc7H9li9W6HVSuCJAgo6s/rWkIQMHnMBqXwIs5qegJ1+EV3ZxSlkdL2RHC74aeS
 gi7WpnaejFLy+4AqymRPV5IbriyEpJrzXfV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.

Will the current patch review result in adjustments for the SmPL code
in the commit description?


> While we're here, remove braces on if statements that only have one
> statement (manually).

Would you like to reduce manual change efforts any further for the shown
source code transformation approach?

Regards,
Markus
