Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D936AC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985F121841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVFQZJlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388972AbfEXHBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:01:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45755 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388689AbfEXHBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:01:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so4734873pfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 00:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kcpiZ7R8bxxOGoxY0wG0uRBYgVeNOevv4W9NWBBQjIo=;
        b=QVFQZJlc66vuLIMsxfASsBcB+kl/AU4ofR9x4QtN1+/JaLthAVLuyMyHbZ0oAxVPJ0
         W4GYAZm473D/QCRsp3DVCwXtfvkxgKNAyyVznrSKGofQRDElNAjpxkMNAM2eSUUX1ZeD
         YOtb2gMLWDKi+G5rRWMR8FXL+MOB1vMDGHBwZ4l6SuSIYZ42MoYaRK63DzhDuX1VDUEr
         7gkMnYupkGqhh7nZj2AOubOdJPew//UcUt8X0Bnidl8QXMsMB4yVsx4pAytf2QDXCCZ0
         r3XDBr8VB3wmj3orqjvIT+o7Mw89F0276xAob2eX9Gv+3Ld0BDRNEVwNyaovCP4uYgpW
         HQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kcpiZ7R8bxxOGoxY0wG0uRBYgVeNOevv4W9NWBBQjIo=;
        b=p0pLw7eP6vcZOUoxWU8DfrxSNrMcXB+P4Vs2fkvP/ymDuIeMVTELmWThp9athx25sZ
         BRjHUHuY/+5SZeSsruamecUc/qCw+/IO9+ZNu6TS8IaszaHg14/igGHOBFJwKC+3Hp/Q
         2cssXZsXZg1XxkZxKSZKn4EsAOWP8PsiSf8mp+w41XyXSNrtrinZUOy7Xz2+6iYzTg4T
         N9txltLieia5ca2VIilbJ+OL9Y96226fFppmeEnq0o5PqULvf8J2DejXV/5CJioetgvx
         SiziF6TjPP4zIKGWp/yvNwVow+RhclNhR/qIFA0SfMtv/dLq2B2u8PyG7ANNUGYLAfRn
         Dp/g==
X-Gm-Message-State: APjAAAWUPun55v4Tm4J+LHjfFA4xo+TrDcqV447O7BqiDueaV4FIfz+j
        y+UM2JZS05vpGI+gTf5thjbKz72k
X-Google-Smtp-Source: APXvYqxqZhsVhUG8FRXyeEFRdwfLU4LOE99S2muppyTS+kjC/CdlUHG4PzaDHug1XfLZKtAOmL0NhQ==
X-Received: by 2002:a17:90a:204a:: with SMTP id n68mr6923151pjc.21.1558681283503;
        Fri, 24 May 2019 00:01:23 -0700 (PDT)
Received: from [10.0.2.15] ([110.225.17.212])
        by smtp.gmail.com with ESMTPSA id 135sm2181690pfb.97.2019.05.24.00.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 00:01:23 -0700 (PDT)
Subject: Re: [PATCH] staging: ks7010: Remove initialisation
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190524055602.3694-1-nishkadg.linux@gmail.com>
 <20190524065238.GA3600@kroah.com>
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
Message-ID: <aae76db5-8768-d277-e527-9e166a02f46e@gmail.com>
Date:   Fri, 24 May 2019 12:31:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524065238.GA3600@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/19 12:22 PM, Greg KH wrote:
> On Fri, May 24, 2019 at 11:26:02AM +0530, Nishka Dasgupta wrote:
>> As the initial value of the return variable result is never used, it can
>> be removed.
>> Issue found with Coccinelle.
>>
>> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
>> ---
>>   drivers/staging/ks7010/ks7010_sdio.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Didn't you already send this?

I sent two patches about removing initialisation in ks7010 today, but I 
couldn't make it a patch series because the different files had 
different maintainers. I don't think I've sent this patch before, but 
it's possible I made a mistake because my local tree has not been the 
best organised lately. I apologise for the confusion.

> And please run a spell-checker on your subject line when you resend
> this :)

Is this about "initialise" (and now also "organised", "apologise", etc)? 
As far as I'm aware whether the word ends in "-ise"/"-ize" depends on 
local varieties of English, so I went with the variety I'm more used to. 
Should I stick with American/Canadian spelling variants (including "-or" 
over "-our" etc) from now on?

Nishka
> 
> thanks,
> 
> greg k-h
> 

