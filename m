Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E671C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B6321872
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a3Rf8Oxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbfJAM5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:57:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37150 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732272AbfJAM5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:57:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id i1so15411190wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 05:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MPSSA5yYuwi4+td+wXD52Uwh92a2xR1aiiNotMAMCSE=;
        b=a3Rf8OxscSifwK0pPutJqQjH17miHaikmrXWHOE/FPTWSW2aOC3KYZ1G+PI+hpTj+A
         fp3YnJyeqQg713B9PbOqFQ6BLHaC1ZiTowuI9mLH404Gmo1Ma1HcTOqgLeErFNWD1ga5
         vsnrRm04P2Smbg+E94VKoPJd8aoWCP6oqR60pCQyU+RHjfGHIwKWeF+oZZEtFeEedpay
         E8T8bo/TX2D7AYPCNFosomlWZTUP93cvmhud2OhFvEsSj63EZW93wBOXtosyeq5PPay3
         aYaNst+psFNwxtr/2FE+OHh0IP0X9rfT18NU9OzKopbou1VeVAGMc/hg/NxVpqLadS0D
         aJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MPSSA5yYuwi4+td+wXD52Uwh92a2xR1aiiNotMAMCSE=;
        b=tyqWmAyKza07B+iD7+g6hjGvabqdm5s59BHzDnEfCjv8p2L80fgulGzZprdCjIDJBS
         0bjqc3GDBRsH5/3Uh3I+DYL4URYQ5e93WH4gaLJMvWcV0oTedWmgpwg6xbZYhQ6BtKPF
         rUF4D7bfHEGnYUWwRNf+VsbibCJ+UDjNGhc2kWr6ZhtWPeDVfOOymdeOtqOs070ZOHf2
         uEKiKCXvz+jtIoT90H1CLeAxjjU81eLDvM86XmEHPv2ywqaR6Oktib15HvjIZmZl1AdG
         xW2qM491QRmg7qTgR6PnAWeNiwXNc2c2csic7P2Yjj66kADWg7i2L/iBRTDG7CO13Hzu
         1NFA==
X-Gm-Message-State: APjAAAXJuJtfWEA0rykw8C95gZOvgldTkNi7/E/qHLI6azMThdNiGRO0
        /6EJ3sHVxWRazItEulbaJ3zUNA==
X-Google-Smtp-Source: APXvYqy7EU9bCTxulCE2P0U9ceV+LdZF+owY0xIwvghTFmWd+5GbnaVwlZM8yo2Kzj/1Bc7sCAsNJQ==
X-Received: by 2002:adf:f5ca:: with SMTP id k10mr3683712wrp.236.1569934665625;
        Tue, 01 Oct 2019 05:57:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id l9sm2730888wme.45.2019.10.01.05.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 05:57:44 -0700 (PDT)
Date:   Tue, 1 Oct 2019 13:57:42 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [RFC PATCH] scripts: Fix coccicheck failed
Message-ID: <20191001125742.GD90796@google.com>
References: <20190928094245.45696-1-yuehaibing@huawei.com>
 <alpine.DEB.2.21.1909280542490.2168@hadrien>
 <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com>
 <alpine.DEB.2.21.1909291810300.3346@hadrien>
 <ac79cb42-1713-8801-37e4-edde540f101c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ac79cb42-1713-8801-37e4-edde540f101c@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuehaibing!

On Mon, Sep 30, 2019 at 10:32:18AM +0800, Yuehaibing wrote:
>On 2019/9/30 0:32, Julia Lawall wrote:
>>
>>
>> On Sun, 29 Sep 2019, Yuehaibing wrote:
>>
>>> On 2019/9/28 20:43, Julia Lawall wrote:
>>>>
>>>>
>>>> On Sat, 28 Sep 2019, YueHaibing wrote:
>>>>
>>>>> Run make coccicheck, I got this:
>>>>>
>>>>> spatch -D patch --no-show-diff --very-quiet --cocci-file
>>>>>  ./scripts/coccinelle/misc/add_namespace.cocci --dir .
>>>>>  -I ./arch/x86/include -I ./arch/x86/include/generated
>>>>>  -I ./include -I ./arch/x86/include/uapi
>>>>>  -I ./arch/x86/include/generated/uapi -I ./include/uapi
>>>>>  -I ./include/generated/uapi --include ./include/linux/kconfig.h
>>>>>  --jobs 192 --chunksize 1
>>>>>
>>>>> virtual rule patch not supported
>>>>> coccicheck failed
>>>>>
>>>>> It seems add_namespace.cocci cannot be called in coccicheck.
>>>>
>>>> Could you explain the issue better?  Does the current state cause make
>>>> coccicheck to fail?  Or is it just silently not being called?
>>>
>>> Yes, it cause make coccicheck failed like this:
>>>
>>> ...
>>> ./drivers/xen/xenbus/xenbus_comms.c:290:2-8: preceding lock on line 243
>>> ./fs/fuse/dev.c:1227:2-8: preceding lock on line 1206
>>> ./fs/fuse/dev.c:1232:3-9: preceding lock on line 1206
>>> coccicheck failed
>>> make[1]: *** [coccicheck] Error 255
>>> make: *** [sub-make] Error 2
>>
>> Could you set the verbose options to see what the problem is?  Maybe the
>> problem would be solved by putting virtual report at the top of the rule.
>> But it might still fail because nothing can happen without a value for the
>> virtual metavariable ns.
>
>diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
>index c832bb6445a8..99e93a6c2e24 100644
>--- a/scripts/coccinelle/misc/add_namespace.cocci
>+++ b/scripts/coccinelle/misc/add_namespace.cocci
>@@ -6,6 +6,8 @@
> /// add a missing namespace tag to a module source file.
> ///
>
>+virtual report
>+
> @has_ns_import@
> declarer name MODULE_IMPORT_NS;
> identifier virtual.ns;
>
>
>
>Adding virtual report make the coccicheck go ahead smoothly.

Thanks for reporting and following up with this issue. I certainly did
not expect all scripts in scripts/coccinelle to be automatically called
by coccicheck and I still think scripts/coccinelle is the right location
for add_namespace.cocci.

I guess, others might better understand the implications of your two
lines fix above, but it looks good to me to address the problem.

Thanks!

>>
>> Should the coccinelle directory be only for things that work with make
>> coccicheck, or for all Coccinelle scripts?

At least I was not expecting this behaviour. Though scripts/ hosts
scripts of various languages, I still think putting all coccinelle
scripts in scripts/coccinelle sounds sensible.

>>
>> julia
>>
>> .
>>
>

Cheers,
Matthias
