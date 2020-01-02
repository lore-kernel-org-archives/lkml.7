Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B941C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED88E215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP5Xweqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgABOky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:40:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39573 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgABOkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:40:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id l2so40907202lja.6;
        Thu, 02 Jan 2020 06:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YTVCjk10X6IDkXlg3Lj964r6euM3rxVqLQ0GPKfUCcY=;
        b=AP5XweqgaDQb81JEDXXKrNOcYIEC2i4tvtdZSUGy93+DHN8A7ffo9TybljSB9VJ4j3
         oZiC3JWlslj+PMJ13KpRrBZjp0emO2GobVqk+FEpnz5lFn8yuNZ+jFhEbwIMK73UeZB1
         P0WN+b7kW6c8faslew/p/cfGYho0JQNrarwEKGJFRRB9bBNHI9/9YGZXVqzP1gMLeQQC
         uwtOqNfEhpzbW6cUHtOSJ+bIzsO+UIoGEBAAxhZSmD/mI0CykOjgaCZixZZlYtfdKQ4T
         iFUw53maeqLsVUL3PHWSSunz0Dv4NC0WQxDaawkoHV6HvLHzG0qBidaxdKLFxkN+F3YC
         IR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YTVCjk10X6IDkXlg3Lj964r6euM3rxVqLQ0GPKfUCcY=;
        b=LDuOcCxuIzJfZfPczf0dw4MAMxSmY8cy+2o79sBX1ERxzauk7Arga1GNQDMYqV8xJC
         jHSFxqu8nhYMIeSpl1QKsUc/BypJtUQD0nc4gR3AuXjFjJBRbskhvSYU2kIumnSIa98R
         jw6p9wcywLai6Vv4Bny0KS7zzJ37MIZDxBoJhl3V+A5KAr2FcGxVVODVugTBp9XKYs9Z
         OQCl3CfhB/Kn5pJCzfVBaZJgOnTN2sh1Z/faJb0NTgtt9API0MPCco5Fm6TIphxcqY4M
         nn8lg/jbhHiIyD/qYjqYzlRvguu5dvZcgsC8XknkUiToAKV74qN4bhi2yZoTJ7ohQ4Sj
         fV8w==
X-Gm-Message-State: APjAAAXQMfUwgsT+mXc7VcLE0VR6TczStRajVrtvWbBcelMdRiVfkcMy
        N01fvBmjEyZcLgEuM+Id3UPxKcs1
X-Google-Smtp-Source: APXvYqxW/kfrNuZymj/mH11dgfiJX4D4dMU5VfflYEafTsK943BzpUc401lim/Fq7EUQMnVZaeZkrg==
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr49355528ljk.201.1577976050485;
        Thu, 02 Jan 2020 06:40:50 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id g15sm18239966ljl.10.2020.01.02.06.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 06:40:49 -0800 (PST)
Subject: Re: [PATCH v3 13/16] usb: phy: tegra: Keep CPU interrupts enabled
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191228203358.23490-1-digetx@gmail.com>
 <20191228203358.23490-14-digetx@gmail.com>
 <20191230203648.GA24135@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ad1a2b09-12b0-112e-1556-6faf6a01c330@gmail.com>
Date:   Thu, 2 Jan 2020 17:40:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191230203648.GA24135@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.12.2019 23:36, Michał Mirosław пишет:
> On Sat, Dec 28, 2019 at 11:33:55PM +0300, Dmitry Osipenko wrote:
>> There is no good reason for disabling of CPU interrupts in order to
>> protect the utmip_pad_count modification.
> 
> Since there are sleeping functions called outside of the locked sections,
> this should be a mutex instead. OTOH if the spin_lock is to protect register
> write against IRQ handler, then the patch is wrong.
> 
> [...]
>> -	spin_unlock_irqrestore(&utmip_pad_lock, flags);
>> +	spin_unlock(&utmip_pad_lock);
>>  
>>  	clk_disable_unprepare(phy->pad_clk);

Hello Michał,

This spinlock isn't for protecting from the IRQ handler, it's used
solely to protect modification of the registers that are shared by all
USB controllers.

It's possible to use mutex instead of spinlock here, but it doesn't
bring any benefits because mutex is more useful when protected code
could block for a long time due to sleep or whatever, while spinlock is
much more efficient when protected code doesn't sleep and takes no more
than dozens microseconds to execute (which is the case here).

In this particular case of the Tegra USB PHY driver, the chance of
getting a block on taking the utmip_pad_lock is zero unless USB
controller drivers will start to use asynchronous probing. So this patch
does a very minor clean-up change and nothing more.
