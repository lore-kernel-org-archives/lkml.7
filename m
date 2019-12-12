Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97267C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BD0214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfLLPv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:51:29 -0500
Received: from ns.iliad.fr ([212.27.33.1]:48126 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729424AbfLLPv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:51:28 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 05F9E20348;
        Thu, 12 Dec 2019 16:51:26 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id E13E42007E;
        Thu, 12 Dec 2019 16:51:25 +0100 (CET)
Subject: Re: [PATCH v1] clk: Convert managed get functions to devm_add_action
 API
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <3d8a58bf-0814-1ec1-038a-10a20b9646ad@free.fr>
 <20191128185630.GK82109@yoga> <20191202014237.GR248138@dtor-ws>
 <f177ef95-ef7e-cab0-1322-6de28f18ecdb@free.fr>
 <c0ccca86-b7b1-b587-60c1-4794376fa789@arm.com>
 <ba630966-5479-c831-d0e2-bc2eb12bc317@free.fr>
 <20191211222829.GV50317@dtor-ws>
 <70528f77-ca10-01cd-153b-23486ce87d45@free.fr>
 <20191212141747.GI25745@shell.armlinux.org.uk>
 <58c27422-e06c-f42e-16ea-baeca3bb9b01@free.fr>
 <20191212144616.GJ25745@shell.armlinux.org.uk>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <d2595721-b5cb-d268-d6bd-bc794c07aacc@free.fr>
Date:   Thu, 12 Dec 2019 16:51:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191212144616.GJ25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Dec 12 16:51:26 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2019 15:46, Russell King - ARM Linux admin wrote:

> However, please don't call this __clk_put().
> git grep __clk_put will tell you why.  Thanks.

$ git grep __clk_put
drivers/clk/clk-devres.c:static void __clk_put(struct device *dev, void *data)
drivers/clk/clk-devres.c:               if (!devm_add(dev, __clk_put, &clk, sizeof(clk)))
drivers/clk/clk.c:void __clk_put(struct clk *clk)
drivers/clk/clk.h:void __clk_put(struct clk *clk);
drivers/clk/clk.h:static inline void __clk_put(struct clk *clk) { }
drivers/clk/clkdev.c:   __clk_put(clk);

I see. I will s/__clk_put/my_clk_put/ in my proposal.

Out of curiosity...

$ git grep __clk_put v2.6.29-rc1
v2.6.29-rc1:arch/arm/common/clkdev.c:   __clk_put(clk);
v2.6.29-rc1:arch/arm/mach-ep93xx/include/mach/clkdev.h:#define __clk_put(clk) do { } while (0)
v2.6.29-rc1:arch/arm/mach-integrator/include/mach/clkdev.h:static inline void __clk_put(struct clk *clk)
v2.6.29-rc1:arch/arm/mach-pxa/include/mach/clkdev.h:#define __clk_put(clk) do { } while (0)
v2.6.29-rc1:arch/arm/mach-realview/include/mach/clkdev.h:#define __clk_put(clk) do { } while (0)
v2.6.29-rc1:arch/arm/mach-versatile/include/mach/clkdev.h:#define __clk_put(clk) do { } while (0)

Genesis seems to be 0318e693d3a56

The clkdev API expected platforms to export a __clk_put method?

Regards.
