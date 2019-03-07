Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89406C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6107820684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCGUyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:54:13 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:57377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfCGUyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:54:13 -0500
Received: from [192.168.1.110] ([77.9.35.131]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MHG0U-1hFFZX3Vuy-00DF2D; Thu, 07 Mar 2019 21:53:51 +0100
Subject: Re: [PATCH 10/61] gpio: simplify getting .drvdata
To:     Wolfram Sang <wsa@the-dreams.de>, Adam Ford <aford173@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Hoan Tran <hotran@apm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
 <b0c1e303-ca95-8bc8-a5d4-65e75dc8398a@ti.com>
 <CACRpkday+d9iGeX+CRHTEyC=w+oNUK-8oTy0HqugO5PRhHn62w@mail.gmail.com>
 <20180430092947.GC2270@ulmo>
 <CAHCN7xLBa0JxcUs9i6Rr3hUNe5zymfb66icqNK0N3PMo51T-TA@mail.gmail.com>
 <20190307201807.GA950@kunai>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <e7cadedc-b8ca-36d5-88dd-447fbeaac27a@metux.net>
Date:   Thu, 7 Mar 2019 21:53:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190307201807.GA950@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:rORioEcuNxOqGCtA4G9wBudOePC2xQIAML2vCX12uhhkMNxeZXx
 PWRWsAJhVUkfETngiMgVOka0hTcicwQ9iRcfA7C2oS+6shsOYMzWgAUyWuQ9VqcCSry1mOW
 GZ6NbvEMysLyFB8qIMRNRT+zuxUNFm20YqXMybV6z6DuZni97dGUNyiScBkI+FR/yySEf6I
 Jczk+XbB9x56utZMtpt5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xqCPBT68NxI=:wJlFcWLuvkhSk2nfUtPLVV
 oKK7J79sI3w/KgGQ4g0pI5+etezgW19kRjEmuKvAdNYsLD5DefmNIBKzBWbM4igmW0xbdEvOk
 9ZRTr+OLM2M61dxkpADmGDvV14BJt/XkIf18TgOZIBXC3Jb7MSi0Sd4Qs0D+bdu0853CzzVGi
 IX/K2DtNkuJSMfLrJTAyWu2mY5HY+6Eed+T/mhjjZYFtANg8/VE/L0Xpx8DRZ5uEpPVMCKRAQ
 WC5mQzPhfE0ygXvfqvzMcORTdNGqUz+eIU/FG/7GP2Npe0rT8c00jYKI+Z1LMpwrBd2g/3i3L
 a4Htj8XaN5LmPJAYl7lGj2XLI4lLcHyy+IhdfWrT4ulEr8+5AgjhcbhAmtcSUB6Ri/brxAt3B
 bMtkV1i/K6uebSlSFqeeaMfKn0EAlISNTU4qI0vxPLW0oubfpgQ2M+bCFGFJPelSKu9hugAbu
 dYIGG7M07pkkjeUsxECfbehpj4Hp9c2gp3ktjIg5OsiW35XsI4hxWAuIvVJMewdtoeXTj7Twn
 H/cjveMq+Ba4ghBC5WnUOo9rKARRIQwq19mtVSoYJKSOIEGYxtyJ+ZymwkqAHTq7tapuUa7/u
 ZwAxQqEno2Ans3mcQEEfCT7tTm57SROn59B86q2zD77dA9/4IwUUVf3x7zbOauYYkUBdsPtit
 I2rbvmp+txAmlcK/yhvsBg9M4BznmPY+LCTboPPkYQ0G/eZaHg+JDN7ayLM3SaDAybK698a7b
 G7yZ23Yz/FNA4K6LRWw5xnYPPGSE4I7NSAxS5RRvLO1eOkB4A38PXlq3RN8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.19 21:18, Wolfram Sang wrote:
> 
>> It's been almost a year later, and several Linux revisions, and this
>> still seems stuck somewhere/somehow.
> 
> I wanted to respin this series once rc1 is released.
> 
Maybe just rebase and repost ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
