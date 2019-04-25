Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B824CC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D602067C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JVwzXTHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfDYNlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:41:03 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34620 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfDYNlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:41:02 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3PDevG1052517;
        Thu, 25 Apr 2019 08:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556199657;
        bh=ymUO8AzGIFyynSIE1GbqlkRUK6sm7bTgpKGnWGvH6p0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JVwzXTHQ0usO73cgA4a5/PHc5V/W4hF1YaIGcoBu9W0XLC0q3Sw7WqwPml8jwJ7cQ
         gBHce9676PpIIKlinZbxtiQ4na2SccVrsVRTcVXry9k6FsB6XXM7FbTsbjeOlkjG5m
         3b7fuwyblEsGrXB0w564jWW7IPzaKgmkVPvUD9QA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3PDev1K101402
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Apr 2019 08:40:57 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 25
 Apr 2019 08:40:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 25 Apr 2019 08:40:57 -0500
Received: from [158.218.117.39] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3PDeq8B037551;
        Thu, 25 Apr 2019 08:40:54 -0500
Subject: Re: [PATCH net-next 02/19] net: ethernet: ti: cpsw: drop
 TI_DAVINCI_CPDMA config option
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
CC:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-3-git-send-email-grygorii.strashko@ti.com>
 <20190423172709.693f4784@cakuba.netronome.com>
From:   Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <13c83500-0fd3-9376-f03a-715949287b84@ti.com>
Date:   Thu, 25 Apr 2019 09:44:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190423172709.693f4784@cakuba.netronome.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub,

On 04/23/2019 08:27 PM, Jakub Kicinski wrote:
> On Tue, 23 Apr 2019 16:08:53 +0300, Grygorii Strashko wrote:
>> Both drivers CPSW and EMAC can't work without CPDMA, hence simplify build
>> of those drivers by always linking davinci_cpdma and drop TI_DAVINCI_CPDMA
>> config option.
>> Note. the davinci_emac driver module was changed to "ti_davinci_emac" to
>> make build work.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Last time I tried including the same object file in two different
> modules it backfired pretty badly.  Would you mind sparing some
> details as to why you need to do this?
> 
How did you get to know they backfired? make allmodconfig will catch the 
issue??

Murali
