Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5768C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9834C20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BMMT6gr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfIKK6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:58:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39864 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfIKK6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:58:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id j16so19562616ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4/T0pBGAJHntS1Kbm8BWjyn4roEDB9HgEnnPwYPp6zU=;
        b=BMMT6gr1xD18cZuT2TTRNbmmh75K7oPCt2ItEaNQ86K3SW0V75avif6iot3oOycBSF
         mRLuGmijn5tAPGsHleo0et7lMUf8LfjAfhj3kzFt41/DDRnILbZ7aekiFmKwCuPcPype
         /tvYS4eUinsdE71SUB/71Xcs3v9Pvp1a5TGF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4/T0pBGAJHntS1Kbm8BWjyn4roEDB9HgEnnPwYPp6zU=;
        b=XIJtSk46VjUbovYceSs2K5KHRphDn74HOASOrB1guc7tqNu/BHB4PIqjAnSYlNzYln
         A3GIjejg4zIg54pWgjtnQSsxIXWJ3Na0qoba3h+DBnGWCrWYwi4ItI/+s/3qXL1xM10g
         203RMNMauAiHAbOLq4IZ9pvnCa4Yeth20pCeXCCyUpLTlKOYDV2S+NTBFSim+ocn175r
         d1oT+LD8NvgyNUNLuj7G459CBdaEbU9A1XN0YYWzVpIGdYiRldf3Tqo+deUxSGKn8mRY
         498eYysUmu7m3jWniqjNFt1CwWCY4aTPn31mgAa37V9hJEAeVexh+CfNWIi2IQWU/b7f
         tyrA==
X-Gm-Message-State: APjAAAV2U7WjLL5XI9ZOjxPqZdI+hJE63gHz6VHMTx3qdsDxkkCEmiJ+
        /zAtvQKV+IayJ6WLUEMc6eB7SA==
X-Google-Smtp-Source: APXvYqyil2boGiMSLg0Y8NzlEW8ElwrhnTajdSrEDCt9REimsq6jzCwF0BLtCmTGvCXId1LN/qEiSg==
X-Received: by 2002:a2e:50b:: with SMTP id 11mr23331127ljf.11.1568199496973;
        Wed, 11 Sep 2019 03:58:16 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x11sm5255046ljc.90.2019.09.11.03.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 03:58:16 -0700 (PDT)
Subject: Re: [PATCH] Staging: octeon: Avoid several usecases of strcpy
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Sandro Volery <sandro@volery.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        aaro.koskinen@iki.fi
References: <20190911084956.GH15977@kadam>
 <39D8B984-479C-42D5-8431-9FF7BD3A96D6@volery.com>
 <20190911091659.GI15977@kadam>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <7a004f18-50cd-9ab0-40b0-051624f0fb95@rasmusvillemoes.dk>
Date:   Wed, 11 Sep 2019 12:58:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911091659.GI15977@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2019 11.16, Dan Carpenter wrote:
> On Wed, Sep 11, 2019 at 11:04:38AM +0200, Sandro Volery wrote:
>>
>>
>>> On 11 Sep 2019, at 10:52, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>>
>>> ﻿On Wed, Sep 11, 2019 at 08:23:59AM +0200, Sandro Volery wrote:
>>>> strcpy was used multiple times in strcpy to write into dev->name.
>>>> I replaced them with strscpy.

Yes, that's obviously what the patch does. The commit log is supposed to
explain _why_.

>>>> Signed-off-by: Sandro Volery <sandro@volery.com>
>>>> ---
>>>> drivers/staging/octeon/ethernet.c | 16 ++++++++--------
>>>> 1 file changed, 8 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
>>>> index 8889494adf1f..cf8e9a23ebf9 100644
>>>> --- a/drivers/staging/octeon/ethernet.c
>>>> +++ b/drivers/staging/octeon/ethernet.c
>>>> @@ -784,7 +784,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
>>>>            priv->imode = CVMX_HELPER_INTERFACE_MODE_DISABLED;
>>>>            priv->port = CVMX_PIP_NUM_INPUT_PORTS;
>>>>            priv->queue = -1;
>>>> -            strcpy(dev->name, "pow%d");
>>>> +            strscpy(dev->name, "pow%d", sizeof(dev->name));
>>>
>>> Is there a program which is generating a warning for this code?  We know
>>> that "pow%d" is 6 characters and static analysis tools can understand
>>> this code fine so we know it's safe.
>>
>> Well I was confused too but checkpatch complained about 
>> it so I figured I'd clean it up quick
> 
> Ah.  It's a new checkpatch warning.  I don't care in that case.  I'm
> fine with replacing all of these in that case.

But why? It actually gives _less_ compile-time checking (gcc and all
static tools know perfectly well what strcpy is and does, but knows
nothing of strscpy). And using sizeof() instead of ARRAY_SIZE() means a
future reader is not even sure dev->name is not just a pointer.

Moreover, it's very likely also a runtime and .text pessimization, again
because gcc knows what strcpy does, so it can just do a few immediate
stores (e.g. 0x25776f70 for the "pow%" part) instead of emitting an
actual function call.

Rasmus
