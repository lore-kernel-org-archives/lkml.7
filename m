Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA13C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F067E21783
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xtrtu2h6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406996AbfHINPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:15:20 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49802 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHINPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:15:19 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x79DEQcH051478;
        Fri, 9 Aug 2019 08:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565356466;
        bh=lqd4cvYerI+bLrW81rK95niroFLbI9sxTGg612NPmek=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xtrtu2h6nP1YNCrnZ692gMoH/T0GxF8LseKl+MC9nSK3mVtkFYhvP1IkspE2d5/5J
         /0iG7w9n9sa9A+m6oYiJ5Kgb0BaRhbP4xftiAgIcyjLt2EaU+zNZE0TAgT/2lu1PAZ
         iumzoiWEB5dUiFH2kjWox/nWba9JGGZtZMEWBygc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x79DEQUv064547
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Aug 2019 08:14:26 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 9 Aug
 2019 08:14:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 9 Aug 2019 08:14:26 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x79DEOC9069090;
        Fri, 9 Aug 2019 08:14:24 -0500
Subject: Re: [PATCH] fix odd_ptr_err.cocci warnings
To:     Mark Brown <broonie@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>
CC:     <kbuild-all@01.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <alpine.DEB.2.21.1908091229140.2946@hadrien>
 <20190809123112.GC3963@sirena.co.uk>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <88ac4c79-5ce3-3f1a-5f6e-3928a30a1ef5@ti.com>
Date:   Fri, 9 Aug 2019 16:14:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809123112.GC3963@sirena.co.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/08/2019 15.31, Mark Brown wrote:
> On Fri, Aug 09, 2019 at 12:30:46PM +0200, Julia Lawall wrote:
> 
>> tree:   https://github.com/omap-audio/linux-audio peter/ti-linux-4.19.y/wip
>> head:   62c9c1442c8f61ca93e62e1a9d8318be0abd9d9a
>> commit: 62c9c1442c8f61ca93e62e1a9d8318be0abd9d9a [34/34] j721e new machine driver wip
>> :::::: branch date: 20 hours ago
>> :::::: commit date: 20 hours ago
>>
>>  j721e-evm.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> --- a/sound/soc/ti/j721e-evm.c
>> +++ b/sound/soc/ti/j721e-evm.c
>> @@ -283,7 +283,7 @@ static int j721e_get_clocks(struct platf
> 
> This file isn't upstream, it's only in the TI BSP.

Yes, it is not upstream, but the fix is valid.

Julia: is it possible to direct these notifications only to me from
https://github.com/omap-audio/linux-audio.git ?

It mostly carries TI BSP stuff and my various for upstream branches nowdays.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
