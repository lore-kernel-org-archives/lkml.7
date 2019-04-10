Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37B5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4872083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="N848gfrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbfDJLgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:36:15 -0400
Received: from mout.web.de ([212.227.17.12]:35081 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbfDJLgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554896153;
        bh=EpmGjf0QE/uQH049jh3E1+zrAi2YhnCQzfXxngPbYhA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=N848gfrFZuwmTClIH37FbfwmouB2hyvTfqA29qF7xQl3HuhTJTduN5CpOv+qUuh8J
         cyllwtbk525f0k/xeNolJtudRohK81OxVdHCXxmIkpCjQpXOb8hTcrekLpmz47e3wj
         LTH9aeQ5ZE9faVZtG9OV/2tRlVm4796OgNqJJ5sI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.98.93]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LsQLM-1glQMj1qXY-011yfK; Wed, 10
 Apr 2019 13:35:53 +0200
Subject: Re: [v2] ethernet: ti: eliminate a bit of duplicate code in
 gbe_probe()
To:     Wen Yang <wen.yang99@zte.com.cn>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>,
        Wingman Kwok <w-kwok2@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "David S. Miller" <davem@davemloft.net>
References: <201904101838229475340@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d0765170-5b79-23ee-8fc4-28ec459c8f01@web.de>
Date:   Wed, 10 Apr 2019 13:35:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201904101838229475340@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ifja0MMk/p4oUEtpltUgZVwYhg5lVRdc43h/BO/ygYOpL4jFa+l
 F30DMvuvOAYmtbvioaMztybr7bK0Hs4PhLtYZSMLyqpK6MB/9T+gtdJM0QewN+Q8gVq6WQ0
 2/JtQ7QtgyWPZcQ1Up90XPnPezRzNLjWNerbuYP8PWur+0CFUHt7/YuxBNjQFW+xXm6DgmF
 XeNm3p85woHxp6kvDMj+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sHdVSIsVKMs=:9zPzv7Mo0NxL+lFszc8qLQ
 Y684bP2MilBi3yx1N8Fbmx5MefSSxmrO0ve7Zf3KrH9ZiNDDr361ZS/NtLCIszLN8pYdbdRsm
 9iH0jO6m13SPqNET63SVUfBZXZA9VK7cOPxyvQ9JABG+1j4i2V1MXm73fc1j787G73SIpCdyf
 Ox8juhFPnDAO/3yWX6oekUDtSrYQQNP9asb86EpBWkTQ6I7cflPS8TRYuWfSGHuW1UhgkySEJ
 eMFb/VoXeGGIuJGflTDj39pbPFAGU+6/5SceugNNT/9CJdioEeXqeF5U3XXX9lx89S8gkfSDT
 RPqp/GOqtpJSNgaueVcZHo+jxUcRzwS+8xNzIHGihfS8DBopu4gwv1/oH0yOMmwZd3v7VMreB
 TFuhmvCWmKsJyqshyzOQelTN8bQyh+0P6lW2szXaqSvlO4SfLhkvLvDTde6A28NFdHFlI0o8/
 UCAutjP0QJS6uqYMk1ZLZZaSPBgDLsZDrmTt/HIar1BH8G6dByqzQBE6QAO8aUCPNhi839rMP
 +xvFCp/yR4js3MQOwnP0YCXLtdaINY9aTy3LOcmbksyMCy5A+/XocnDkkeTAFlgVrCl1rWJW1
 A2QeLgqvB2JIWRoOGYhdMJNJixdXgTOMv9FToNjWbgirhfTuyjM42j7V4xdYcHM+CPUX0n2eP
 YCLo7Y1nL91devZRe5RC3UoaYBVKcAb9zoLpFR9SqkWp+Gz8pme7s5JYiHaOYbggmYzU2Qadu
 /RRPvC56IkyKYA3lFGisNaWlF/XahcYrfgTARMRHy6WgWqgUE/3v/6uTyuTgCZz1YdcOl1we4
 EjIFiOVNB8km4oaUkMaG8lcfnRKZs6azdeX2phMLIf0CiRHgQlOm2xhTv9vZLtmbGFiPhEu++
 Qs1tJWxfPo6jg+AyuXalIxbb56pnJBsmWozJ8A/9PAQEZ289WxtafcWHM2vT2w+Vy9WU3WiZy
 bFg3fd6DDvQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> @@ -3651,22 +3651,18 @@ static int gbe_probe(struct netcp_device *ne=
tcp_device, struct device *dev,
>>>>>      if (ret)
>>>>>          return ret;
>>>>>
>>>>> -    interfaces =3D of_get_child_by_name(node, "interfaces");
>>>>> -    if (!interfaces)
>>>>> -        dev_err(dev, "could not find interfaces\n");
>>>>> -
>>>>
>>>> How do you think about to skip a bit of statements as a reaction for
>>>> such a null pointer?
>>>> https://elixir.bootlin.com/linux/v5.1-rc4/source/drivers/net/ethernet=
/ti/netcp_ethss.c#L3562
>> =E2=80=A6
>>> Maybe you need to look at the implementation of for_each_child_of_node=
() and of_node_put().
>>> NULL check before those functions is not needed.
>>
>> This information is reasonable in principle.
>>
>> Was the reference counter incremented even if a null pointer was return=
ed
>> by such a function call?
>
> The situation you assume is an issue that the of_get_child_by_name() fun=
ction needs to consider
>  and has been irrelevant to our patch.

I suggest to reconsider the software situation a bit more.


> 1, when returning NULL, the of_get_child_by_name () function needs to en=
sure that the resources
>  it has allocated are released;
> 2, when returning NULL, if of_get_child_by_name() can&apos;t release its=
 resources, then the
>  outer function has no way to release these resources.
>
> If you are interested, you can check the of_get_child_by_name() function=
 further

It seems that the corresponding software documentation can be improved als=
o here.
https://elixir.bootlin.com/linux/v5.1-rc4/source/drivers/of/base.c#L863


> and send it to me if you find any problems.

I find the exception handling suspicious in the discussed function impleme=
ntation.


>>>>>      ret =3D netcp_txpipe_init(&gbe_dev->tx_pipe, netcp_device,
>>>>>                  gbe_dev->dma_chan_name, gbe_dev->tx_queue_id);
>>>>> -    if (ret) {
>>>>> -        of_node_put(interfaces);
>>>>> +    if (ret)
>>>>>          return ret;
>>>>> -    }
>>>>>
>>>>>      ret =3D netcp_txpipe_open(&gbe_dev->tx_pipe);
>>>>> -    if (ret) {
>>>>> -        of_node_put(interfaces);
>>>>> +    if (ret)
>>>>>          return ret;
>>>>> -    }
>>
>> Does the preparation of the NetCP pipe still matter in this special use=
 case?
=E2=80=A6
> Please refer to my reply above.

I propose to take additional software design possibilities into account.


> We have checked the netcp_txpipe_init() and the netcp_txpipe_open() func=
tion.

I wonder if such function calls are still relevant if a questionable syste=
m
configuration would be detected before.


> However, your questions may not actually be related to our patch.

Your update suggestion triggered related adjustment ideas.



>>>> +
>>>> +    interfaces =3D of_get_child_by_name(node, "interfaces");
>>>> +    if (!interfaces)
>>>> +        dev_err(dev, "could not find interfaces\n");
>>>>
>>>>      /* Create network interfaces */
>>>>      INIT_LIST_HEAD(&gbe_dev->gbe_intf_head);
>>>>
>>>> Can code like the following trigger corresponding software developmen=
t concerns?
>>>>
>>>> for_each_child_of_node(interfaces, interface) {
>>>> =E2=80=A6
>>>> }
>>>> of_node_put(interfaces);
>>>>
>> =E2=80=A6
>>>> if (!gbe_dev->num_slaves)
>>>> dev_warn(dev, "No network interface configured\n");
>
>> Is this message really required as another response then?

Is the exception handling still questionable in this function?

Regards,
Markus
