Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93D1C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6EA21736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1Mdi/mA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfDSDCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:02:35 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:44999 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfDSDCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:02:35 -0400
Received: by mail-pg1-f169.google.com with SMTP id i2so2051977pgj.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 20:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/+ggWIaI7WNRRwSICtwbRWtBery3Zb5S//nJtPCZrJg=;
        b=E1Mdi/mAP8Tvmmnwk+hcRNhPC1IVcS4yX3N7HOzxYKPufmOx0h5KG4JZrzV9yh37xx
         3+f1+MKf2sqSaCsVG6YF6THdmJC4UIClfOdLsqTy0VrxbYkif6dPRgzmWV0sL8JzUmSN
         S+9iwNDt4glQd13hSsdBHw+8WDOmwd5p76CaCzOrY6QrC1WVruyuzHPPDHJoCEQ0yZQ8
         d3EviwEUjqP/0449eF0WDSvJ04UR46b+53QHhP0n/afOztEiQvyi/aHY42Tz2eviLD3z
         pWgmvRbzdzfZ0rhZbtsQYrO+ynmjqEh6dqe958E6qVhrcUIhh2m8Z+ki4rjvxkpTXeEc
         gg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/+ggWIaI7WNRRwSICtwbRWtBery3Zb5S//nJtPCZrJg=;
        b=UJMAG2guhYDYcoP7eScc1ZXWVCCs+IDwqgu6AhiysqNu4IONXXfykfx0/Oz3uDOnlj
         qPRJ/y14ovJfAo8So18FNdWwE9ss83SDUd+W0iCcfKOA2OY90DfoBxqZCAe/tdZ2kwoG
         nJBjxpc1mximbuN/5IYYi+fbSvpoOSffIM9CJdD8BJ1LXHlkmmXf07AcIF/8ZieY3qAr
         +vpsGTwBPVvsSGJmll8VGiw3U+BJloOw1ekqSRe+/5RdGHuwYQADFL1mPZbCNdyFmL0W
         GMuIXvDVUIBD997JoDciCldhD8ZEgb6qXLKQu6PyUxb+wxTI2rcNrxECT0K6z+hDkTgC
         GCRQ==
X-Gm-Message-State: APjAAAUE8qto5Z46bCfqbMBD6p1bCEvv++/Nol5y2q8Y54XFPqwmA4Ab
        2LWFaz4DnT+m1DPNCHoGRMgtsxMY
X-Google-Smtp-Source: APXvYqz2lYHLQ1RIvOQCfm9glbCnseQM5bzbkHhd4JOm/kCBKw3ZKgrB5J699UtUTNqpRp59BN4YqA==
X-Received: by 2002:a65:6649:: with SMTP id z9mr1517795pgv.392.1555642953654;
        Thu, 18 Apr 2019 20:02:33 -0700 (PDT)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id b13sm4606680pfd.12.2019.04.18.20.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 20:02:32 -0700 (PDT)
Subject: Re: net: ax25: %x specifier misuse in kernel?
To:     PlusOneSecond <plusonesecond@foxmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <tencent_3A04033395F30A3361F8A78F814E1FF92B07@qq.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <5b376d2b-9fdb-9043-5bc6-48fb2e4cb821@gmail.com>
Date:   Thu, 18 Apr 2019 20:02:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <tencent_3A04033395F30A3361F8A78F814E1FF92B07@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/18/2019 07:01 PM, PlusOneSecond wrote:
> In ax25_info_show of af_ax25.c:1891, linux-5.1.
> The pointer ax25 is cast to long type to print out.
> 
> Why it prints the a pointer 'ax25' use %8.8lx rather than %p?
> If it really want to print the value of ax25, it should use %px.

I guess nobody cared enough abut this security issue.

Please send a patch, thanks.

> 
> Also, I  scan the kernel code and notice that most of the pointers cast to long or unsigned long type to print out are marked with __iomem.
> Is it a misuse of %x?
> 
> 
> Thanks.
> 
