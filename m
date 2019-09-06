Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E72C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E754B20640
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2lXYmPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436485AbfIFRum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 13:50:42 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34997 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395292AbfIFRul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:50:41 -0400
Received: by mail-oi1-f195.google.com with SMTP id a127so5664902oii.2;
        Fri, 06 Sep 2019 10:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F4XFpZ/Ntp6JNNqwWcwMDQ9RkygXrkeY+nz32s4dwlI=;
        b=a2lXYmPyCS4UA3sQ/bVxed9DPzu2SlgOjrFzOX4oEzGwjRtl+jVYZt6AjXGy07rY29
         24SeCgfuTyObZ50ZEOgxXU3gG6tUn6H4IVDoTClIE+Iw9fK2pvvQnoIfi3cVo1w/HlLM
         oxltd0ZVJUkncdo4JwomxUQA4leGpMW7mOd0bk1e8BvBDKPBY+dps8bkRhnCLoKHXjcp
         3JgnO54Au8u+2LWvy753N44LAAU0SSK5584KCAhPu9DIH/BGQult7vs/ODi6xQnAsPxV
         IQQc2dTxYlYZawB7hEzyyLD9RE9s1ay6pOfMo/0hkoiXozlSqCY+X/uZ9pW+Ro56aZjq
         UXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F4XFpZ/Ntp6JNNqwWcwMDQ9RkygXrkeY+nz32s4dwlI=;
        b=OueTTH4yiKDZcyktLWFnxuS9YsI5Rri/dm0Le3z/6F9nC9QzRYFK4ljqVM/zRvE0Pa
         BxXYBOgc1OA+0gv500An1Kk+DbOxZCTtartEGKK/BzvaYh2D3VwTNFTuAPRuQQPKvGlj
         DDUUtCpzplMTnV02N+BkRp78AYhHmQ/gTYxt7DAcTRpN2DfF/zzr/BTOBmyzE/4KbAtV
         3Ccq8x2ktv7+I2Q89nWLKjxXKHs4k/ZW6aBMelhJHG1Z5KaHxwwiBr6+sZU8b/YJgR6V
         +bRz/mO2qJShTkXVn1QSZs0QJr+BPqKSV3arUHVqx/XlyUgENipZLAtTbkXjK/zLgkNP
         rQew==
X-Gm-Message-State: APjAAAXqWhDOQeVDSO0Ssbf+kpblmVSZmj/oHAG2lHqr84hPKmoasFjQ
        76z/sgvndfBLnFLYpsTGlF7AToy3
X-Google-Smtp-Source: APXvYqxzox6qJNPz7yEiqg0BiF3uTnaUtCGgjyVmQFBVlRPiRvwAQoEaZjVsB/vZH88rAZLKA1LVyg==
X-Received: by 2002:a54:4f11:: with SMTP id e17mr7643443oiy.46.1567792240430;
        Fri, 06 Sep 2019 10:50:40 -0700 (PDT)
Received: from [192.168.1.156] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id i47sm2453711ota.1.2019.09.06.10.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 10:50:40 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8188eu: make two arrays static const, makes
 object smaller
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190906173949.21860-1-colin.king@canonical.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <9f1e1550-2a75-abc3-4d87-a0c1d1ae1ccb@lwfinger.net>
Date:   Fri, 6 Sep 2019 12:50:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906173949.21860-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/19 12:39 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate two arrays on the stack but instead make them
> static const. Makes the object code smaller by 49 bytes.
> 
> Before:
>     text	   data	    bss	    dec	    hex	filename
>    26821	   5616	      0	  32437	   7eb5	rtl8188eu/core/rtw_ieee80211.o
> 
> After:
>     text	   data	    bss	    dec	    hex	filename
>    26612	   5776	      0	  32388	   7e84	rtl8188eu/core/rtw_ieee80211.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,

Larry
