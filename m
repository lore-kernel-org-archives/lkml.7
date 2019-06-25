Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E333BC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57B6215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="yfu8bNMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbfFYKvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:51:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38799 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728732AbfFYKvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:51:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id b11so12311808lfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 03:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QYR0/BYwnzwCl+rKULiTMDwFesUkqjrw3t7FlbQxB08=;
        b=yfu8bNMV5M/M7hGf8bi48wMrTqPQ2ptTJ2bXJ41rOTfD7rmdXz09MFQLz1Lfx/LeYl
         OpOr3nQARG5SsJl5vXwuwAH6Mzf+nuDp8PwSV7UPn2GB8fIKzcPAALmeF0SikSsIiGD9
         jVEkP6EBLp5r0UYSnHk8kaIIrkwyIz4H8QPrrZjyhetij564U2H5WT1Rz3s7YtxT1VDt
         /mzSxSgU5JrZJFKju+1XmsplmX6v1IR2fTZyuzDKx72SPrPHBwaxGlSN2JjJBGVNYgxY
         MwyCQGGIFvZNWqvPkIWmm3DtI6/xyKp76RBCEU645MMyPtgNBqeFKJ1F0xCikU7RTqn2
         t0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QYR0/BYwnzwCl+rKULiTMDwFesUkqjrw3t7FlbQxB08=;
        b=HzITUe7EAWQgK99GgbNunpMVTTj7Dw6PQwrPPZQk6scFdHAY8JTmsuveXuTSz0jNsY
         MaT4DdvzZ0lN9oMnMiq3n7mI5teadvCpO19HozGjoxZ2lptFnKJp6brHIavPC5Gsh32y
         IV9Au4CQ1jCuu/ZtJeABQ1uQxRzar/7HM+/hBDMjqnO8h0sG1TwbA0tRDiE5iUjLAMus
         msrJCcqojEvvtTQ1DatOUMd2lNvyUIObqbe1YpKwBo3mKtTvI5ofo47mek7gVih/6yq2
         uY0SAl7A+1GdqA0mYLa2083wmhWIp0V49UH5iJTogByXgHYvvRWAMK4GITRo20Ua6y59
         eCYw==
X-Gm-Message-State: APjAAAUP5OQxk34F9ItltpDQIU8toSTrPM4PbInYTjcRU6LkU2BqiaDD
        YHaKTgmCV28qMfqHaZy9ieJATw==
X-Google-Smtp-Source: APXvYqzZ09wkjVNPOiocxOa4T9N2dk+LWvcKvQjj68NhxhSUE1cmPSz5jwP2yyCvKMWoN/WTUgKZvg==
X-Received: by 2002:ac2:569c:: with SMTP id 28mr19131895lfr.147.1561459900452;
        Tue, 25 Jun 2019 03:51:40 -0700 (PDT)
Received: from [192.168.1.100] ([213.87.147.32])
        by smtp.gmail.com with ESMTPSA id k82sm2185877lje.30.2019.06.25.03.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 03:51:39 -0700 (PDT)
Subject: Re: [PATCH net-next] net: stmmac: Fix the case when PHY handle is not
 present
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
References: <351cce38d1c572d8b171044f2856c7fae9f89cbc.1561450696.git.joabreu@synopsys.com>
 <895a67c1-3b83-d7be-b64e-61cff86d057d@cogentembedded.com>
Message-ID: <6a0db024-312b-746c-4ecc-ab6166c6e409@cogentembedded.com>
Date:   Tue, 25 Jun 2019 13:51:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <895a67c1-3b83-d7be-b64e-61cff86d057d@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.2019 13:29, Sergei Shtylyov wrote:

>> Some DT bindings do not have the PHY handle. Let's fallback to manually
>> discovery in case phylink_of_phy_connect() fails.
>>
>> Reported-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> Fixes: 74371272f97f ("net: stmmac: Convert to phylink and remove phylib logic")
>> Signed-off-by: Jose Abreu <joabreu@synopsys.com>
>> Cc: Joao Pinto <jpinto@synopsys.com>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>> Cc: Alexandre Torgue <alexandre.torgue@st.com>
>> ---
>> Hello Katsuhiro,
>>
>> Can you please test this patch ?
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c 
>> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index a48751989fa6..f4593d2d9d20 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -950,9 +950,12 @@ static int stmmac_init_phy(struct net_device *dev)
>>       node = priv->plat->phylink_node;
>> -    if (node) {
>> +    if (node)
>>           ret = phylink_of_phy_connect(priv->phylink, node, 0);
>> -    } else {
>> +
>> +    /* Some DT bindings do not set-up the PHY handle. Let's try to
>> +     * manually parse it */
> 
>     The multi-line comments inb the networking code should be formatted like 
> below:
> 
>      /*
>       * bla

    Oops, that was the general comment format, networking code starts without 
the leading empty line:\

	/* bla
>        * bla
>        */
[...]

MBR, Sergei

