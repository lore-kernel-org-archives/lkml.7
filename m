Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D11C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6B02147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsKHSM7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDCJ6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:58:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34384 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfDCJ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:58:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id r186so4427287wmf.1;
        Wed, 03 Apr 2019 02:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jJhJoAKR6Xx6zdUywkAozy/HWnK00UYRpu6873wjNrU=;
        b=rsKHSM7Mt25mKPrreYX61hjNPRc/lww1vVqGlWdGAkivw7QsbhWflbiIS+Dfizc59q
         MbLL8sd/AIwsVwqSDJdToqHZohfcvhfNap6oWSSYnKqKGnGnIaB6pOFbau5Ruxn1A94s
         qHIaEbXXZNbTB+tP2roN8WgFvbkTk90CSEUHLW7G1zzq6Uttfpa86CKGygPfKBZwjIfs
         OSkulBTJd+q8mGnz7AQYYYc2IXvv2G/J/2pGNKnqnXcOk6AXX0SpOg9o9kMjZvZ4VCf9
         Brybm5pTMsci0sTrHKrjp28oI2k12SFChgO/bfppRaAmfPWIy0SrEAu1FpVrAD/ZoXQD
         K17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jJhJoAKR6Xx6zdUywkAozy/HWnK00UYRpu6873wjNrU=;
        b=VHpwtwP+ikJ7SLK4Wq7LdHiq3qmOwPQACFhuXa9ejZUoOG2LHITtUYzzeWHb2TJMHM
         q4PGjcDhpgTNhjl2CHSyABZa22vUjWrOfyTtlk/hLAXh2JjhvviLUPER1oPR7E90uX3L
         i7u6i4B4jTRsOvhi0y+HY5fkjqCx6S6e4YA8D4Rq+BCjyJ7axsh0+uzLwX57T4nqYxdn
         I4ABmMku7fu/35d8HvR6wUu6taSPOO++UKjb28ptqjIbmZQhAj8/QskAiXdXyKlAOfzD
         k28kpJMCIUMq+0Q4+oR/rJypyzB/2NdexSp0yYECe1U+8zCDswTN27Tbu6m2N6CnGtxr
         r55g==
X-Gm-Message-State: APjAAAXU3Uj2PER4Vb2s+wjlb/lV/vuPcvATpsU6VPLdctXi9Mam7Dg7
        8wHjr9TPeWYZcmsbJ3vGHc8=
X-Google-Smtp-Source: APXvYqwU4/DVNbkTmtnqe8ID5gcRDvzUyFSmU27AxR/5Rn0fKwz6WzjVz3H4yF0JlbbxHy1Ux6FnTg==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr1543916wmj.0.1554285521985;
        Wed, 03 Apr 2019 02:58:41 -0700 (PDT)
Received: from [192.168.1.22] ([94.230.156.24])
        by smtp.gmail.com with ESMTPSA id b204sm28226478wmh.29.2019.04.03.02.58.41
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 02:58:41 -0700 (PDT)
Subject: Re: [PATCH net-next 06/17] net: dsa: Call driver's setup callback
 after setting up its switchdev notifier
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        georg.waibel@sensor-technik.de
References: <20190331174232.22060-1-olteanv@gmail.com>
 <20190331174232.22060-7-olteanv@gmail.com> <20190402210349.GG22349@lunn.ch>
From:   Vladimir Oltean <olteanv@gmail.com>
Message-ID: <75b2250e-d6a5-44cb-42af-1d5838a03863@gmail.com>
Date:   Wed, 3 Apr 2019 12:58:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190402210349.GG22349@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 12:03 AM, Andrew Lunn wrote:
> On Sun, Mar 31, 2019 at 08:42:21PM +0300, Vladimir Oltean wrote:
>> This allows the driver to perform some manipulations of its own during
>> setup, using generic code.
>> One current usage scenario is for the driver to request DSA to set up
>> 802.1Q based switch tagging for its ports.
>>
>> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
>> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   net/dsa/dsa2.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
>> index c00ee464afc7..5beceb18b7e2 100644
>> --- a/net/dsa/dsa2.c
>> +++ b/net/dsa/dsa2.c
>> @@ -360,14 +360,14 @@ static int dsa_switch_setup(struct dsa_switch *ds)
>>   	if (err)
>>   		return err;
>>   
>> -	err = ds->ops->setup(ds);
>> -	if (err < 0)
>> -		return err;
>> -
>>   	err = dsa_switch_register_notifier(ds);
>>   	if (err)
>>   		return err;
> 
> It seems that notifiers are the important thing here? Maybe state that
> in the commit message?
> 
> I'm also wondering how safe this is in general. If we have not yet
> called the driver setup, the switch is potentially not yet ready to
> actually handle an requests that come via the notifier. If such
> notifiers can only come from the driver itself, it should be
> safe. However, if they could come from the rest of the stack, i could
> see bad things happening.
> 
>      Andrew
> 

Hi Andrew,

Correct me if I'm wrong, but the switchdev notifiers coming from the 
stack are coming through a net device, and the slave net devices are 
only created in dsa_port_setup, which is later than the code I'm 
modifying anyway? Do you have an example of potentially racy situation 
caused by this change?

Thanks,
-Vladimir
