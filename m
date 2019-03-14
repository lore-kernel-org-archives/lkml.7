Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605BDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D6521019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S8ZAjb2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfCNK6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:58:25 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36920 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfCNK6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:58:25 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2EAwBol012260;
        Thu, 14 Mar 2019 05:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552561091;
        bh=ij0v6/c4XznrS6VH0qbWL31+ThtFCQqjuwaHX9q3IYw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=S8ZAjb2J8GSS4vFxv4z0KY0gYpGGnT8DYGNOvJ0dOJByc5rMEX+/CaN2hht0ubzTX
         LlvGmTBSuFNxXrafnrBppMMMw7ULI56y4qKScjDfbTeQUxCHqMfADy1tyV2tYTjtJw
         hV+1KE61hYL+DjBEoksKecR09VMpqjLsTEoHwod0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2EAwBMk042533
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Mar 2019 05:58:11 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Mar 2019 05:58:10 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Mar 2019 05:58:11 -0500
Received: from [172.22.128.177] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2EAw7R3005299;
        Thu, 14 Mar 2019 05:58:08 -0500
Subject: Re: [PATCH] gpio: omap: avoid clang warning
To:     Arnd Bergmann <arnd@arndb.de>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Tony Lindgren <tony@atomide.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-omap@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190307103348.1591457-1-arnd@arndb.de>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <e15686f1-7ec7-194f-d5f2-0892964f91c5@ti.com>
Date:   Thu, 14 Mar 2019 12:58:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190307103348.1591457-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 07.03.19 12:33, Arnd Bergmann wrote:
> clang warns about a tentative array definition in the gpio-omap driver:
> 
> drivers/gpio/gpio-omap.c:1282:34: error: tentative array definition assumed to have one element [-Werror]
> static const struct of_device_id omap_gpio_match[];
> 
> It's best to just reorder the entire file to avoid forward declarations,
> which lets us use the regular declaration. To do this, the unnecessary
> CONFIG_OF check must also be removed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpio/gpio-omap.c | 549 +++++++++++++++++++--------------------
>  1 file changed, 267 insertions(+), 282 deletions(-)

Sry, for delayed reply

I do not have objection to the patch itself, so
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com> 

but personally i do not like such changes as they kill "git blame" :(,


I assume there would be merge conflict with 
https://lkml.org/lkml/2019/3/11/945


-- 
Best regards,
grygorii
