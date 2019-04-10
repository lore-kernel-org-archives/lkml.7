Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E46C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A558D2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Zv3Z8EA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfDJJrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:47:23 -0400
Received: from mout.web.de ([212.227.17.12]:38845 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729737AbfDJJrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554889621;
        bh=MOfgTeMDFSikmkRUlkag5q/KVRe6z7JUQJpCKlySvuI=;
        h=X-UI-Sender-Class:Subject:Cc:References:To:From:Date:In-Reply-To;
        b=Zv3Z8EA8Ds9i9kzwuGirPGM1YQ4r3+uku19UejcntIwdEWQLznrMnGsb9eOwV769P
         yB7wuMHW6qNMVRioK/hE3pNmQi0oWiP8OV1nrcSdA3Nqos3aVLQt6hvEpIV1nirVJZ
         iQif3CFfRfSWLtI5utDH9qYsAcFDarOg0izFWztA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.98.93]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOixm-1hHzZD0CBy-0068q9; Wed, 10
 Apr 2019 11:47:01 +0200
Subject: Re: [v2] ethernet: ti: eliminate a bit of duplicate code in
 gbe_probe()
Cc:     linux-kernel@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>,
        Wingman Kwok <w-kwok2@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "David S. Miller" <davem@davemloft.net>
References: <201904101639050539211@zte.com.cn>
To:     Wen Yang <wen.yang99@zte.com.cn>, netdev@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <10d51c0e-0bf1-ca9d-2d42-99a3d642bf2c@web.de>
Date:   Wed, 10 Apr 2019 11:46:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201904101639050539211@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LI9apOovdlRsRZNERQLcyJbyrouH5ZMdVFpYFgx2o4k1FLQDpHg
 XtvilQgwNC3ojyVwXkrBi2PcfD13kgJy9LMKRSMMs+4BD9FOU6f7y040sMp1czCRymnIRi4
 e/a+aDfy6mA4sFyp8QFii+ZodpFlZOnaMogL7YaHrLKRTe99SUpgrSHuvzxRcSep0DKF/v5
 G5LMc/XmgZ5NDBFL9twgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2f4Qii0k0jE=:AIt6qdakeHAHknMqCYyq6h
 VDUe2JImxqPBwEhmrvmACVBMh7RBrV378kj6QPd/OtxfZ55+JzlcekXMIdyF0U0GyJMsJ5Njg
 wAh/lvjM1USTX8CBP58OUHL5QyJRHOnrgF9SXMHslcS/nysbEu3/wY4jW0aSrFIZVY3nda1lE
 Q1S4BvOqgfkBbZQ5bAjLrueo7Ewp3Q6ajUi9KeacY2IzdZF/Ok0eUdiEA7j32SDKKGoufcrNN
 pEwpLGcQANdLL8TsYL9WM0FZ0hA6dBPRH0iI6IQlthhRnBmtrSHtDfWHdvPNCnXHeIct7+n+C
 OmPft1q7sHoU1+OKi78pwW6lgiEjhqzv+9x+Q23YLyb+lPpNafsUQbf5hxi+GtGOHQaBZQEfj
 mFwLIz8lDIKSCGAiEUxo8lHLCuyzw5K8eCp6iOvpgPKUQW16+e9KRbX2PaPUmpB9eSlYG5YS7
 IcDS98zaIy01gTX+KmtQEhAHDKgST0vK/ckeuGO3bPcG/jKV1wjBlSHneEv11hnCWyi6i3HBi
 D7vqfpGoLNMIlCH0LtfnVdLQ4+TD9fTk8nHaXW9Sxd8j0YGNNteZoeGU2hf/KoqEW3bOjXVAw
 5mIovPkiWaxIgPJyMWE5Ga1rVKd7h1HNZTkiRVrObLoLiIZJmPIUympCd5vF0FRo5XpDy89Jw
 loW079dndwBV+sYuUHQyQvz5xdUQzFRiaWcXvlWMxqH2yc27F/ex8DgT8nqzqCf0rfT59o6xn
 1b68AKlfNkoaQLRQTVp02JnDsoMXYWMgYWNAMD6VLTc22pRKir5KVKLq86IL2g9F10tgnbCNv
 xds4+GslklKsWeePPLaVGOYDgU8piXg+Nj7lmuiaGDAzUiZWb2OpuaijREQWpikI18LPmt2oB
 PwJ4Oor572AREv9StKj0hrsYehHwhnGtVUyt0+OvooK1Zssq/1LOl/msyC/BvWtpc+eLUDDgK
 FzmOkTskYtg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> @@ -3651,22 +3651,18 @@ static int gbe_probe(struct netcp_device *netc=
p_device, struct device *dev,
>>>      if (ret)
>>>          return ret;
>>>
>>> -    interfaces =3D of_get_child_by_name(node, "interfaces");
>>> -    if (!interfaces)
>>> -        dev_err(dev, "could not find interfaces\n");
>>> -
>>
>> How do you think about to skip a bit of statements as a reaction for
>> such a null pointer?
>> https://elixir.bootlin.com/linux/v5.1-rc4/source/drivers/net/ethernet/t=
i/netcp_ethss.c#L3562
=E2=80=A6
> Maybe you need to look at the implementation of for_each_child_of_node()=
 and of_node_put().
> NULL check before those functions is not needed.

This information is reasonable in principle.

Was the reference counter incremented even if a null pointer was returned
by such a function call?


>>>      ret =3D netcp_txpipe_init(&gbe_dev->tx_pipe, netcp_device,
>>>                  gbe_dev->dma_chan_name, gbe_dev->tx_queue_id);
>>> -    if (ret) {
>>> -        of_node_put(interfaces);
>>> +    if (ret)
>>>          return ret;
>>> -    }
>>>
>>>      ret =3D netcp_txpipe_open(&gbe_dev->tx_pipe);
>>> -    if (ret) {
>>> -        of_node_put(interfaces);
>>> +    if (ret)
>>>          return ret;
>>> -    }

Does the preparation of the NetCP pipe still matter in this special use ca=
se?


>>> +
>>> +    interfaces =3D of_get_child_by_name(node, "interfaces");
>>> +    if (!interfaces)
>>> +        dev_err(dev, "could not find interfaces\n");
>>>
>>>      /* Create network interfaces */
>>>      INIT_LIST_HEAD(&gbe_dev->gbe_intf_head);
>>
>> Can code like the following trigger corresponding software development =
concerns?
>>
>> for_each_child_of_node(interfaces, interface) {
>> =E2=80=A6
>> }
>> of_node_put(interfaces);
>>
=E2=80=A6
>> if (!gbe_dev->num_slaves)
>> dev_warn(dev, "No network interface configured\n");

Is this message really required as another response then?

Regards,
Markus
