Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1C0C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B32214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS1nwDR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbfISOZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:25:58 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36350 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732479AbfISOZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:25:50 -0400
Received: by mail-wr1-f49.google.com with SMTP id y19so3341068wrd.3;
        Thu, 19 Sep 2019 07:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9umKgFGD6g+WJt/wl45oeQhdVJbiaAj3+K1hzH1/ufs=;
        b=GS1nwDR9taBgtdcGa7y5LzSu4ifdc6yHNKKH4Mrd998QSfga8J1UaHp7VBCTAcc9IY
         WP5jnJEKIbj3iHL/v91ETzlCk4IoOxshLaaByjxwR9RnQefgzcFfHlYym6kuxqprb09M
         2dS+Q+fyxt3o5K0JRjpazid4iSweTWYXqsBpSdDC5jssEdjTcneXy6wt6R8d/UmS4KJe
         9v2CemuntMk5/AqTRcRXGY6QIqiIkLlvVZv5dDUjXMWgl52dFRjGDFQjOCQad99sjWx8
         gO2xF+a2fKxTvM7v0+HgpCA350QIdXMGDj2HVQe6l9ZSqQzhHJxB1CKYcWm5+r+ETPZz
         TrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9umKgFGD6g+WJt/wl45oeQhdVJbiaAj3+K1hzH1/ufs=;
        b=AE9r8EHm2WtmfKmezAcdu51w8+rcNKrcg4A388/ikUy4qPcsEggPdNYXzsZQl4Ke20
         d4QwZW/h7aq3d3nce/WtNe7ybaaU8u6NjUNwNKamBR7VeZd+NuFWHb/2Als0DsD0ebKR
         eC5e2OZTR7M1zeelkQ5RyKiXjNRBN0f3S2EYSqGcNQ0svds4UEVOwUbqfehggd9xcqw7
         WFtOrKhSav/Gaq6c689nL1Yt9KQ19mFhDJoU+/I0cFA9lnxV6B17nNEt2sReNhQf1lKa
         SEEPAu0M0LDyc+rFO6YaP/zrfxNGptjKui8E1gF+jTgaabBoeruVXnHVuwP6j8/1UonY
         0UFw==
X-Gm-Message-State: APjAAAV+tiUMxNsNHxQdoVCOiJqaIaJgq6nGlfWebEr5PQjW8V4Nme3T
        DbZwlf8OmF6F0vdIVm2qDrk=
X-Google-Smtp-Source: APXvYqytENN9tdJTVLfShfuHfPwOrRl3/YgBhIhd5w7vxZz7+O8gx7CmOkmql9fWNtAPcZ+tBuT/0g==
X-Received: by 2002:a05:6000:1281:: with SMTP id f1mr7242674wrx.247.1568903148701;
        Thu, 19 Sep 2019 07:25:48 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g4sm9240305wrw.9.2019.09.19.07.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 07:25:48 -0700 (PDT)
Subject: Re: [PATCH 4/9] select: Micro-optimise __estimate_accuracy()
To:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, Adrian Reber <adrian@lisas.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
References: <20190909102340.8592-1-dima@arista.com>
 <20190909102340.8592-5-dima@arista.com> <20190919140547.GC2507@uranus.lan>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <6ba601dc-4ee5-7381-d9ce-e1a56fbc1653@gmail.com>
Date:   Thu, 19 Sep 2019 15:25:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190919140547.GC2507@uranus.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/19 3:05 PM, Cyrill Gorcunov wrote:
[..]
>> diff --git a/fs/select.c b/fs/select.c
>> index 12cdefd3be2d..2477c202631e 100644
>> --- a/fs/select.c
>> +++ b/fs/select.c
>> @@ -51,15 +51,14 @@
>>  
>>  static long __estimate_accuracy(ktime_t slack)
>>  {
>> -	int divfactor = 1000;
>> -
>>  	if (slack < 0)
>>  		return 0;
> 
> Btw, don't you better use <= here?
> 

Good point, will do for v2.

Thanks,
          Dmitry
