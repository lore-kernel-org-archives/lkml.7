Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E412CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37C32173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GdiqpVu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfC2JOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:14:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35992 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbfC2JOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:14:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2T9DoWk061661;
        Fri, 29 Mar 2019 04:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553850830;
        bh=x5xDuW4+Jb4uWtHPtPQgbfXYnrde9PnslThD8VlRyPU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GdiqpVu9Obm9z6z32DqsUTJqPP1ueZTA/rgHs+UHHvx83KcIDAcozl3+kDlnnxwiC
         2ZFFes0cRjVaLgC8Cmj9juwnLYrCcDTAGQfzlHnXwYmAG3gDcvdWbJQOAsSB/aLm+m
         vRrAd3rW44+APqT6O3y93IvYHMCmSSOKbj2QWpss=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2T9Dot5074695
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 04:13:50 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 04:13:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 04:13:50 -0500
Received: from [172.22.188.74] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2T9Dkuv062515;
        Fri, 29 Mar 2019 04:13:47 -0500
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_mdio: switch to
 readl/writel_relaxed()
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1553792993-7722-1-git-send-email-grygorii.strashko@ti.com>
 <CAK8P3a2MP-YNkHLG9LgrQ_zeRWiJkwwNXJmptunF8+_uZTcYFg@mail.gmail.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <5e37fb17-ccf8-540e-0cdc-bc3b71ccf259@ti.com>
Date:   Fri, 29 Mar 2019 11:11:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2MP-YNkHLG9LgrQ_zeRWiJkwwNXJmptunF8+_uZTcYFg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 29.03.19 03:00, Arnd Bergmann wrote:
> On Fri, Mar 29, 2019 at 1:10 AM Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>>
>> Switch to readl/writel_relaxed() APIs, because this is recommended
>> API and the MDIO block is reused on Keystone 2 SoCs
>> where LE/BE modes are supported.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> In general, my recommendation would be to use readl/writel instead of
> readl_relaxed/writel_relaxed everywhere, because they have much
> more predictible behavior. If you want to use the _relaxed version
> in the fast-path for data traffic, that is usually fine, but then I would
> add a comment next to it to explain why it is safe there without extra
> barriers to serialize with spinlocks and DMA.
> 

it's not fast path, so readl/writel should be ok. I'll resend.

-- 
Best regards,
grygorii
