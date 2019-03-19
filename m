Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75C7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBAA2133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Z39ci2B1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfCSOmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:42:43 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:57862 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbfCSOmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:42:39 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 4500C10C282F;
        Tue, 19 Mar 2019 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1553006558; bh=fD79IsTK8BE3SohIN0hy9gDUnGkroRSRJZQpUFiXSQI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Z39ci2B1pIWFMDjOr33gGjzXaOhEtH8CugXpDDiKxDOiVnEiGjIBVJhqf7VF0pRVk
         ITtWT+8DYJF/2zpbsexeNmKKTtJrmOJdgjzcNxZrpBIRNszu3sQPtzWRyQMomowWfh
         0CLHoUM5bO93VXORfhcEK4s7kErzHKPR0REO7yhvzv3PjgyldP5aaS3USEPRBf6V3R
         sJSNZPuH1lywv2b2BoUWBlgiNVoI6HBQxxvxROmO4EQBW/Bn8NPUhbLXgi0rP4+a47
         khtqP38uGflymusCX76QzWjyh2udmMGpZjKR+LmwFFIoXRf9oW3yGzi6sbPxMqENH+
         AbuZsD8EXBj0A==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 49EB3A0062;
        Tue, 19 Mar 2019 14:42:36 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 19 Mar 2019 07:42:36 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 19 Mar 2019 15:42:34 +0100
Received: from [10.107.19.176] (10.107.19.176) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 19 Mar 2019 15:42:34 +0100
Subject: Re: [PATCH] net: stmmac: fix memory corruption with large MTUs
To:     "Koskinen, Aaro (Nokia - FI/Espoo)" <aaro.koskinen@nokia.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190318213608.612-1-aaro.koskinen@iki.fi>
 <92e465e5-0c77-e22f-d7e1-4689f3d655e7@synopsys.com>
 <DB6PR0701MB2487FF2B8D4C0219DD209952F4400@DB6PR0701MB2487.eurprd07.prod.outlook.com>
From:   Jose Abreu <jose.abreu@synopsys.com>
Message-ID: <b3f61517-3d6d-dc20-fd50-6ac98e0b9dd4@synopsys.com>
Date:   Tue, 19 Mar 2019 14:42:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB2487FF2B8D4C0219DD209952F4400@DB6PR0701MB2487.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.176]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/2019 11:07 AM, Koskinen, Aaro (Nokia - FI/Espoo) wrote:
> Hi,
> 
> From: Jose Abreu [jose.abreu@synopsys.com]:
>> On 3/18/2019 9:36 PM, Aaro Koskinen wrote:
>>>       /* Fill DES3 in case of RING mode */
>>> -     if (priv->dma_buf_sz >= BUF_SIZE_8KiB)
>>> +     if (priv->dma_buf_sz == BUF_SIZE_16KiB)
>>
>> Shouldn't this be: "if (priv->dma_buf_sz > BUF_SIZE_8KiB)" ?
> 
> I think it should be the same as in stmmac_init_rx_buffers():
> 
>         if (priv->dma_buf_sz == BUF_SIZE_16KiB)
>                 stmmac_init_desc3(priv, p);
> 
> A.
> 

Hmm, yeah makes sense. I was under impression that XGMAC had a >
16KB buffer but I was wrong.

This change looks okay then.

Acked-by: Jose Abreu <joabreu@synopsys.com>

Thanks,
Jose Miguel Abreu
