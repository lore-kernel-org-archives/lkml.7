Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF558C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884122133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cQGWrX6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfFNKsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:48:19 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38202 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfFNKsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:48:18 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5EAlW17075133;
        Fri, 14 Jun 2019 05:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560509252;
        bh=VO4FVnd5gxYVdAkdALZM4NQ4Jp0vvZIA2wgd7x8xSUs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cQGWrX6FBTtB52WDerOTzhblZJzqENMFCgab3pXXu0aCcVMRLLvEY1IJik3EfWciw
         mzu/3Inn3Jj2XDEyHkbwuF6zomIj//AtSJaz/Ep2KNofCQUQvAVlv1GJLXAkrWLgYm
         Vr90ralp0fpOXHlahbhUZhLPfW3TXkizb0VNSYTA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5EAlWP7108465
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Jun 2019 05:47:32 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 14
 Jun 2019 05:47:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 14 Jun 2019 05:47:32 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5EAlT9V088764;
        Fri, 14 Jun 2019 05:47:30 -0500
Subject: Re: [PATCH] ARM: davinci: da850-evm: call
 regulator_has_full_constraints()
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190607090201.5995-1-brgl@bgdev.pl>
 <CACRpkdYjXq-KV=zW=az+02tvjiHVHgUPiC149gNfkWTb4c29PQ@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <5dcd0189-2283-fb0d-dd7c-4906f4594d69@ti.com>
Date:   Fri, 14 Jun 2019 16:17:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYjXq-KV=zW=az+02tvjiHVHgUPiC149gNfkWTb4c29PQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/19 7:37 PM, Linus Walleij wrote:
> On Fri, Jun 7, 2019 at 11:02 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> The BB expander at 0x21 i2c bus 1 fails to probe on da850-evm because
>> the board doesn't set has_full_constraints to true in the regulator
>> API.
>>
>> Call regulator_has_full_constraints() at the end of board registration
>> just like we do in da850-lcdk and da830-evm.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I assume Sekhar will queue this and the LED patch?

Yes, will do. Added this to fixes for v5.2

Thanks,
Sekhar
