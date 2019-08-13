Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581F3C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E1A2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+ALPbwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfHMHNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:13:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41898 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfHMHNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:13:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so40429814pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 00:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HuqrDVHXoF9vK+SJhef4AZh4usxLReWvSnBMkm4j+U4=;
        b=C+ALPbwcAL0D1t3UdTLzbid9ZDZCE/pTWpjg1BePxfMAUrpy5JHoeAMLPtd7Lcl0FW
         5WmBlGRVN69CsHcKklpy+BGfn+G7rIBGikvW2G7UVaReyAzmH2fuxo2pYVBQiU0y/4qA
         LXFtOYvpEDxqLAjppJInSQ4Cki0kCN+mQ2DmQhPwF0wLMAwyRGKSAE956Sa+GVKViTre
         0NenBoUxNG+edllBfg6kGeayY8yGCCnP4WaYryHurv+9jjmH8NFeo1Nvj+pdSukOFfH5
         QVoaXBRmbrRHA1wfYtAWcutSAyiDKUe1ThnM/aUMydicDO/olZuzEzpr1BJ37D5y4lD5
         n6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HuqrDVHXoF9vK+SJhef4AZh4usxLReWvSnBMkm4j+U4=;
        b=Q4+VeDFzEwchaj7sIvkFHb3fF9rRYVPIB16fw0vfRFNg7qIdKjGlr7w7Aaskfp3Ack
         K6K42G0oeaVpeh0oxn/ojidQs6wMOyU7tvxhE+LNHj5AZpYL1MmQ2ypxMNnR6NIQHdGK
         kBT7hpzHuRHTGndVIf5nUy2RU1EcFFct7PtAhLA0uU9b3LaWSakJ/wKnvJJ12KsuKz5O
         IlRvO2y4cYQbhZzFw3URcD+nSdyRuopZ5GT7yPKA5GkK/3fQqeBcpA3MpItzgQinUL4o
         IkG7/x729Jr0pgSiFRcksFSk4mIAJJZKcWAwSGm/5oNcI3DSEgMzU3pblxJEuGfASGDX
         bCaA==
X-Gm-Message-State: APjAAAVLGo29pq8l0sd/pzteQXgmysGDn6QAbSBmQVBcHTxRM5mcZ5ya
        rxudRx0ZIXP75QimMjoGiNvbTHQE
X-Google-Smtp-Source: APXvYqwqicW8CWggDW0UCI/dqONqunyP0+Xr16MPKuDxTcJ0O70EcFcEA2ay0jLnoJRnDJWZCTZTVw==
X-Received: by 2002:a17:90a:d3d6:: with SMTP id d22mr913489pjw.5.1565680380096;
        Tue, 13 Aug 2019 00:13:00 -0700 (PDT)
Received: from [10.0.2.15] ([122.163.110.75])
        by smtp.gmail.com with ESMTPSA id t7sm2031850pgp.68.2019.08.13.00.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 00:12:59 -0700 (PDT)
Subject: Re: [PATCH] bus: ti-sysc: Remove if-block in sysc_check_children()
To:     Roger Quadros <rogerq@ti.com>, tony@atomide.com,
        linux-kernel@vger.kernel.org, "Kristo, Tero" <t-kristo@ti.com>
References: <20190808074042.15403-1-nishkadg.linux@gmail.com>
 <2038cdcd-1506-84c6-520d-6dda50d4f317@ti.com>
 <a1f56fcc-2207-fa32-83bc-cd219c2b893c@gmail.com>
 <b1f8756e-4b15-7f1a-8562-5b80063733de@ti.com>
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
Message-ID: <4946dafe-f9c2-3cdf-fb0b-d08a32a20633@gmail.com>
Date:   Tue, 13 Aug 2019 12:42:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b1f8756e-4b15-7f1a-8562-5b80063733de@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/19 11:55 AM, Roger Quadros wrote:
> 
> 
> On 13/08/2019 07:35, Nishka Dasgupta wrote:
>> On 08/08/19 7:25 PM, Roger Quadros wrote:
>>> Nishka,
>>>
>>> On 08/08/2019 10:40, Nishka Dasgupta wrote:
>>>> In function sysc_check_children, there is an if-statement checking
>>>> whether the value returned by function sysc_check_one_child is non-zero.
>>>> However, sysc_check_one_child always returns 0, and hence this check is
>>>> not needed. Hence remove this if-block.
>>>>
>>>> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
>>>> ---
>>>>    drivers/bus/ti-sysc.c | 2 --
>>>>    1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
>>>> index e6deabd8305d..bc8082ae7cb5 100644
>>>> --- a/drivers/bus/ti-sysc.c
>>>> +++ b/drivers/bus/ti-sysc.c
>>>> @@ -637,8 +637,6 @@ static int sysc_check_children(struct sysc *ddata)
>>>>          for_each_child_of_node(ddata->dev->of_node, child) {
>>>>            error = sysc_check_one_child(ddata, child);
>>>> -        if (error)
>>>> -            return error;
>>>
>>> We cannot assume that sysc_check_one_child() will never return error in the future.
>>> If it can never return an error then why does it have an int return type?
>>
>> I'm not sure why it has an int return type, unfortunately. This is the function in its entirety:
>>
>> static int sysc_check_one_child(struct sysc *ddata,
>>                  struct device_node *np)
>> {
>>      const char *name;
>>
>>      name = of_get_property(np, "ti,hwmods", NULL);
>>      if (name)
>>          dev_warn(ddata->dev, "really a child ti,hwmods property?");
>>
>>      sysc_check_quirk_stdout(ddata, np);
>>      sysc_parse_dts_quirks(ddata, np, true);
>>
>>      return 0;
>> }
>>
>> I'm not sure how to understand this function. Do dev_warn() or sysc_check_quirk_stdout() or sysc_parse_dts_quirks() cause a non-zero return from sysc_check_one_child()? Should I drop my patch?
> 
> None of those functions return anything.
> Maybe you can fix sysc_check_one_child() to return void?
> I think you can retain your patch but get rid of error variable.

Okay, I'll fixup and send v2. What about sysc_check_children()? If error 
variable is removed then sysc_check_children also only returns 0.
Thanking you,
Nishka


> 
>>
>> Thanking you,
>> Nishka
>>>
>>>>        }
>>>>          return 0;
>>>>
>>>
> 

