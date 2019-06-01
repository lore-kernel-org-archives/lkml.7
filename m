Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E912C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 10:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DF927226
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 10:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KDy6I1Zn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfFAKuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 06:50:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36738 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFAKuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 06:50:09 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x51Anjk4092901;
        Sat, 1 Jun 2019 05:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559386185;
        bh=ob8wspeqbSXyGJzsgzx60G/Qe41rKvi0r3dNErbqquI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KDy6I1Zn9ZRbUKBGdnplrjHzZH6Pi88EVM3voaxTfUuDdTBtZhunmB0mn2YqLfkJV
         SdYVycpBEBpg9fqND5rjW/u723gb4/tbciwJXtnP5F7pJ2twCzF5eeWNdh8PruWffU
         KbYTwGOaX2YPsw3ZMR5IX/7F7neBSuSWh/H9NBp0=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x51AnjsM130744
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 1 Jun 2019 05:49:45 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sat, 1 Jun
 2019 05:49:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sat, 1 Jun 2019 05:49:45 -0500
Received: from [10.250.96.121] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x51Angnh055815;
        Sat, 1 Jun 2019 05:49:42 -0500
Subject: Re: [PATCH v2 net-next 3/7] net: ethernet: ti: cpsw: use cpsw as drv
 data
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, <hawk@kernel.org>,
        <davem@davemloft.net>
CC:     <ast@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <xdp-newbies@vger.kernel.org>,
        <ilias.apalodimas@linaro.org>, <netdev@vger.kernel.org>,
        <daniel@iogearbox.net>, <jakub.kicinski@netronome.com>,
        <john.fastabend@gmail.com>
References: <20190530182039.4945-1-ivan.khoronzhuk@linaro.org>
 <20190530182039.4945-4-ivan.khoronzhuk@linaro.org>
From:   grygorii <grygorii.strashko@ti.com>
Message-ID: <976fc52a-2f9c-d597-09b4-93d37a510f13@ti.com>
Date:   Sat, 1 Jun 2019 13:49:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530182039.4945-4-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/05/2019 21:20, Ivan Khoronzhuk wrote:
> No need to set ndev for drvdata when mainly cpsw reference is needed,
> so correct this legacy decision.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
>   drivers/net/ethernet/ti/cpsw.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)


Thank you.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
