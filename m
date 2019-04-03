Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912E2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D0220700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1GqB27Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfDCPHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:07:32 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37224 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDCPHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:07:31 -0400
Received: by mail-oi1-f196.google.com with SMTP id v84so13850862oif.4;
        Wed, 03 Apr 2019 08:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mgivj/uL+QO9zRcYozvENIFDQEIDYYc7Uv++ohl+VgM=;
        b=W1GqB27ZVLzo0aOto9W/ZdmcZOnTfCMFIbl0BD/MsR2Sd2fu6kmpPq5phEhBwcXY26
         1+c205YK24uKY2ESd1ua6iMvBoER+3yyDQ5cfXw9T/TNlgLoFPZLhFkk7Df7BbrRWrME
         ZGtUIysNOE7uw3/XsCIZywu2elgkfE6EmntLSrJ8q7m1/lDepSdkLE0qQM0jrC5on5ON
         C/Vjm95/HRc6RHjsmoZBARfucnIsQVIa/M3fA8SacpBHo871cEaD6jjfsBH9+1xKFpL0
         zxTV9nzG9bBa8k39r1+ky+/j/gLwttd81N3aOdA4ZI6VOEQLZXd6UdKOxtkczEkC3Q+F
         0xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mgivj/uL+QO9zRcYozvENIFDQEIDYYc7Uv++ohl+VgM=;
        b=DtjnkrrM38z1lMz80E9Uhk8MWnvj3XxOhXz1q1QVzjNZPZ3eq06wFs114u1dA1K3nq
         0Yy7OPzYdjpqeehCQUWtY5C9w2AniPg2eukEWA4vF1eHB3Qf9bAwJ7NMYDANIENH1Fut
         DRxaQGu589B9GokFnzkmR46MmzJf59kDUHN7hV4/wFgeTn6mNbo55zbplWHV43QyZiAX
         RvsJVdY9LQbRHqlyMau9sKqBpijlShuxK6in6vl+HwpPh1lr+oRUadNYeMw6F8Z2qW0o
         YYwhpVHUQBmr6XV+dywzn267kxOSFHjOCoYDB+5XK8EZp+KuzZ7wbdbQhXrc0AduMave
         vUSw==
X-Gm-Message-State: APjAAAW75LaHy1vbwvq/2sBKh3MvNIOt0XvKpWN9Ek1bXBCQbS55iaOB
        pMCwS8bzNig8wT1jKxJNwtk=
X-Google-Smtp-Source: APXvYqwRe9ZzNT2ZDqMYx/AiCKcs95gkoitPCpZVKR4qHZ1785gJVzitwn2DmgAPeY0nzIdLzH4/Dw==
X-Received: by 2002:aca:544b:: with SMTP id i72mr557532oib.51.1554304050671;
        Wed, 03 Apr 2019 08:07:30 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id d22sm6519901oti.21.2019.04.03.08.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 08:07:29 -0700 (PDT)
Subject: Re: [PATCH net-next 16/17] Documentation: networking: dsa: Add
 details about NXP SJA1105 driver
To:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     vivien.didelot@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, georg.waibel@sensor-technik.de
References: <20190331174232.22060-1-olteanv@gmail.com>
 <20190331174232.22060-17-olteanv@gmail.com> <20190402212422.GH22349@lunn.ch>
 <47131b09-8f39-0cdc-70cd-809b64448097@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <d8af0493-064a-2ef7-722c-79d1ac8cb6c7@gmail.com>
Date:   Wed, 3 Apr 2019 08:07:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <47131b09-8f39-0cdc-70cd-809b64448097@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/2019 3:09 AM, Vladimir Oltean wrote:
> On 4/3/19 12:24 AM, Andrew Lunn wrote:
>>> +The switches do not support switch tagging in hardware. But they do
>>> support
>>> +customizing the TPID by which VLAN traffic is identified as such.
>>> The switch
>>> +driver is leveraging CONFIG_NET_DSA_TAG_8021Q by requesting that
>>> special VLANs
>>> +(with a custom TPID of ETH_P_EDSA instead of ETH_P_8021Q)
>>
>> Hi Vladimir
>>
>> Reusing ETH_P_EDSA is possibility going to case problems in tcpdump.
>> It has code which looks for this Ethertype and uses it to call the
>> Marvell EDSA header decoder code. This is not going to work for your
>> switch, where you have a normal VLAN header.
>>
>> I wounder if we should allocate a new EtherType for this application
>> of VLANs?
>>
>>     Andrew
>>
> 
> Hi Andrew,
> 
> This makes me wonder whether I would be able to use an EtherType range
> to support cascading switch tags on SJA1105.
> In theory if I were to consistently lie to all switches within a switch
> tree, I could make all of them see each other's fake VLAN-tagged traffic
> as untagged.
> By the way what is the simple ETH_P_DSA used for?

ETH_P_DSA is not used since commit
3e8a72d1dae374cf6fc1dba97cec663585845ff9 ("net: dsa: reduce number of
protocol hooks") but since it is in an UAPI exported file we probably
cannot remove it.
-- 
Florian
