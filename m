Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F40C468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4B820833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi8MLwR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfFJEi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 00:38:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39062 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbfFJEi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 00:38:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id g9so3117632plm.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 21:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mpvEIcub74Ft9tQ19C+ftgMqPmIXoqD9CmzUzCOdNHo=;
        b=Pi8MLwR4TLdpCZ6t/LUx60qyKNBsya1oMtOVGH8Y2QkkD4FISlPx4rri2+Zc40wAAC
         uNJnxIHb4x0TjU3oQ2BYr3ymaaof65cJdhUGwWBzCEvZfsHwP3JA99DCD2Pli/UZ5L6k
         38hk8vOkAwnr81DK3tNkSdBjIYbby7+CuOdx3fF9Pq6CdcBX1zzOzzu5uwqHHgjVsvX0
         U6t+0MCMUfPRYhIiOuVs77ir1LyqVoc5eyR5GAUE2rAoP6XsqXy4PVBAUPa6oV6VOJ+/
         0NR+iMgET5E8ECG7DjQazl06DgVKpgQLO7iLiPfN5MJtbhechkNSVkKhz79BpftzA650
         wQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mpvEIcub74Ft9tQ19C+ftgMqPmIXoqD9CmzUzCOdNHo=;
        b=mxPcuAPMprkLplBa0bvSF/uQc3XliKFn+//93MsdILLh5UzTo/y40wN47uYrRuRCux
         pOvIGMHFYFoV8TyY45TinMCG1YRioQ3R1WD9piJD8TMOG9/++7XkEA206uv36XoVyo1l
         YX8pZuhT13u480C3trmUz1Yry/fY2t/ul+iWBOKAy6bVBtpRKkWWgbySIT6tioK4KCwb
         Rg2FuL43epgT/xIk/guZUqote1bWMZafL5ztiJT4Ons+ZzVr5MLf7EVL5LMiFmYpAt6M
         pqXzEh/jwYDLNQ5uk9MrBfxuX7wDHbtzG2yhD2+ypvC356VFcYiFl0Yu6p+n3LRKlt+M
         Lk7A==
X-Gm-Message-State: APjAAAWmlUzL6yLKg6aDhFM1Oh8Iu8ZuzDWpPwd1VU/TLi4T1u1FzQpT
        YO594YMdbwXIvxBx0UCxFMbCPrmk
X-Google-Smtp-Source: APXvYqxRvLX40gv+OgzBjTF3wrCildCfFd1d4SpB/WueK+15EvhScQvfwHZvJubUBIUMqikrDRLAaA==
X-Received: by 2002:a17:902:a516:: with SMTP id s22mr29601481plq.178.1560141505994;
        Sun, 09 Jun 2019 21:38:25 -0700 (PDT)
Received: from [10.0.2.15] ([171.79.92.225])
        by smtp.gmail.com with ESMTPSA id n32sm8603724pji.29.2019.06.09.21.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 21:38:25 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8723bs: core: rtw_mlme_ext.c: Remove unused
 variables
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        straube.linux@gmail.com, benniciemanuel78@gmail.com,
        hardiksingh.k@gmail.com
References: <20190607071123.28193-1-nishkadg.linux@gmail.com>
 <20190609110206.GD30671@kroah.com>
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
Message-ID: <74fd5a83-0f60-baae-a65f-bbc0cd9f4ad0@gmail.com>
Date:   Mon, 10 Jun 2019 10:08:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190609110206.GD30671@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/19 4:32 PM, Greg KH wrote:
> On Fri, Jun 07, 2019 at 12:41:23PM +0530, Nishka Dasgupta wrote:
>> Remove variables that are declared and assigned values but not otherwise
>> used.
>> Issue found with Coccinelle.
>>
>> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
>> ---
>>   drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 9 ---------
>>   1 file changed, 9 deletions(-)
> 
> You sent me 8 patches for this driver, yet only 2 were ordered in a
> series.  I have no idea what order to apply these in :(
> 
> Please resend them _all_ in a numbered patch series so I have a chance
> to get this correct.

Yes, I can do that. Who do I send the patch series to in that case? The 
maintainers list is slightly different for each file, and most of the 
patches in this driver are for different and unrelated files (except, I 
think, the two that I did send as a patch series). Do I combine the 
maintainers lists and send the entire patch series to everyone listed as 
a maintainer for any one of the patches in it?

Thanking you,
Nishka

> thanks,
> 
> greg k-h
> 

