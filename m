Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7E9C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF84120449
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfCGTPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:15:54 -0500
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:24334 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfCGTPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:15:54 -0500
Received: from belgarion ([90.76.35.80])
        by mwinf5d23 with ME
        id l7Ff1z00R1jkVcS037FmZS; Thu, 07 Mar 2019 20:15:50 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 07 Mar 2019 20:15:50 +0100
X-ME-IP: 90.76.35.80
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: pxamci: fix enum type confusion
References: <20190307100948.570006-1-arnd@arndb.de>
        <20190307152029.GD20201@archlinux-ryzen>
X-URL:  http://belgarath.falguerolles.org/
Date:   Thu, 07 Mar 2019 20:15:39 +0100
In-Reply-To: <20190307152029.GD20201@archlinux-ryzen> (Nathan Chancellor's
        message of "Thu, 7 Mar 2019 08:20:29 -0700")
Message-ID: <87mum65wdg.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Chancellor <natechancellor@gmail.com> writes:

> On Thu, Mar 07, 2019 at 11:09:19AM +0100, Arnd Bergmann wrote:
>> clang points out several instances of mismatched types in this drivers,
>> all coming from a single declaration:
>> 
>> drivers/mmc/host/pxamci.c:193:15: error: implicit conversion from enumeration type 'enum dma_transfer_direction' to
>>       different enumeration type 'enum dma_data_direction' [-Werror,-Wenum-conversion]
>>                 direction = DMA_DEV_TO_MEM;
>>                           ~ ^~~~~~~~~~~~~~
>> drivers/mmc/host/pxamci.c:212:62: error: implicit conversion from enumeration type 'enum dma_data_direction' to
>>       different enumeration type 'enum dma_transfer_direction' [-Werror,-Wenum-conversion]
>>         tx = dmaengine_prep_slave_sg(chan, data->sg, host->dma_len, direction,
>> 
>> The behavior is correct, so this must be a simply typo from
>> dma_data_direction and dma_transfer_direction being similarly named
>> types with a similar purpose.
>> 
>> Fixes: 6464b7140951 ("mmc: pxamci: switch over to dmaengine use")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
