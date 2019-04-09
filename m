Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDFAC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F7A20820
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEx3KxzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfDITTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36999 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfDITTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:19:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so9872682pgc.4;
        Tue, 09 Apr 2019 12:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cVg8TgLxhu0AsTn/qyNanPtN3GOs1sC0oa8OR9PtDwg=;
        b=XEx3KxzRMldfYCi/2rU/Uc303/rQobRB2EtFNC9BAMr9tNT3iLS9tRWxvQG4am+0je
         cneU0mflFgP30k4XMLpP10yvZF+L6HjecBAqGhpUIwyjssH4WZlFDuSt9MiKylaQ9lsK
         dBGWMBzJbloMtj5W4hMvsUq9olrF1zMJSAF5JHpl89dTfXpYepbq27GXeMfNo7KZDqit
         h8TmHNvq1Cw5Y648FGZa6lcGCP2uZCL4VNsGLKsVp1WvGPKxNkYJJNqeKGFz5asPcDGa
         cXhZvAjww6UtjoMxTFrTE4r7zTTigvkO9nLYPtXg4EwcS1R9jlOooyabQ0Eq3b0h9Lxx
         1p1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cVg8TgLxhu0AsTn/qyNanPtN3GOs1sC0oa8OR9PtDwg=;
        b=e0ocoxIlZY4NMrT4uL5kgx2J6zgcCShOLjC5m6vF0gmCWUkGE1mumH9bnl6fnm32FW
         QVwmY/vbRAKKzTND3CzffEbLpN4OaN0KPTFvMv3k2G+29P6yjc68110j2PL03MR46eLM
         LXZz4PSEl4HJc6Rona2RC8nQWkEW5K0isKOdahl1vzv7zYgt4qxnxelo3LQ+WITWvAnP
         CSvALkD/OLvryKNeDvh91V0v5J4sqa3gp4L4sGIPZabqW9pIYzvwfOBpUP1r5htMAsIi
         xpBs+1AkAYEb7ukHZ6uOHKkSCrjZTHRFBpjPrFm3OnEya/CL0cGAngAivshV5vBwlXtW
         lrKQ==
X-Gm-Message-State: APjAAAVG2MGAhfDXBxtDuJCMYtYwb/c4imliF5Nm446A4+9cpDzvQSdW
        18upYopXEzuGoub11WxICPE=
X-Google-Smtp-Source: APXvYqztvBZm1NzYGeugeF0MfT8xNX49UNCv3/V06t6gbCrkFtPzff9ZE4LNWiQ3IeKh8l+kJSC1iA==
X-Received: by 2002:a62:26c1:: with SMTP id m184mr1034913pfm.102.1554837556859;
        Tue, 09 Apr 2019 12:19:16 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h65sm83315826pfd.108.2019.04.09.12.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 12:19:16 -0700 (PDT)
Subject: Re: Using device tree overlays in Linux
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "pantelis.antoniou@konsulko.com" <pantelis.antoniou@konsulko.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
References: <71fb0ff289e84c55bd92ecd96bc9aa76@svr-chch-ex1.atlnz.lc>
 <61185ee9-4bee-eec3-f0d0-6d6760595845@gmail.com>
 <224942bd629e41eaa23ab327b015134e@svr-chch-ex1.atlnz.lc>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <b2e0e55e-38a3-3dfb-3453-f57d7e2e99a3@gmail.com>
Date:   Tue, 9 Apr 2019 12:19:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <224942bd629e41eaa23ab327b015134e@svr-chch-ex1.atlnz.lc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/19 6:27 PM, Chris Packham wrote:
> Hi Frank,
> 
> On 8/04/19 1:05 PM, Frank Rowand wrote:
>> Hi Chris,
>>
>> On 4/3/19 6:50 PM, Chris Packham wrote:
>>> Hi,
>>>
>>> I'm implementing support for some modular Linux based systems using
>>> device tree overlays. The code is working but it seems a little more
>>> fiddly that than it should be so I'm wondering if I'm doing it right.
>>
>> Let me start by saying that I strongly discourage using device tree
>> overlays in the Linux kernel until the support is more baked.  For
>> some info on how unbaked overlays are, see:
>>
>>     https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts
>>
>> You should consider applying overlays in the Linux kernel to be
>> fragile at best.
>>
>> If you can not figure out how to solve your needs without using
>> overlays, then having the boot loader apply the overlay instead
>> of the kernel applying the overlay avoids most of the issues.
>>
> 
> Consider us beta-testers :).

You should read the elinux.org page more carefully.  The support
isn't even alpha stage.  It is at the level of proof of concept.

I'll update that page to explicitly say the code is proof of
concept.

< snip >

I'll reply to the rest of the email separately.

-Frank
