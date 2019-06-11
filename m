Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AC1C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE40720673
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAt+Ugq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390115AbfFKNHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:07:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37762 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389744AbfFKNHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:07:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id bh12so5107438plb.4;
        Tue, 11 Jun 2019 06:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TR2jsLXLuKJzsRWAqZLBERMt4T32XKyN+tY7oRfNleI=;
        b=nAt+Ugq6jGDQK0SymQwKd3xpbk2GdnlJurj19UoyEM0TmKUTrJ4JpE2LoBkYEnxlTB
         YJNQXTvg6Evv9BBlKAk54NPras07mCWlJhU8Ghzd03qh2eLz3Cl3T9tvuy0q7ma1Cap1
         pD0zep2s+9jF15F9BKXq/Dm1q/OflWRkGa1D21zFfJZJTu2C7g+DX3riFbcD1FChjFON
         N9dGXcOni7cmh3OfdWDDNRGJKapyMgAKoLheqO/Inz8S+CUwy3Ia2spBSVcBllLFcKZw
         hAZd0Ks8kSvs094FDW/MW4wUU7vcSj81k50PGF0GOBSIDSXqkuMHn/F6NGK8o1ohXqYZ
         VTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TR2jsLXLuKJzsRWAqZLBERMt4T32XKyN+tY7oRfNleI=;
        b=T1XXaGKQeRoUeOhLLgQsMQqZyo3OpUTso0ZJBMg9W29pCbzKkK4NlsaazP9Och26yW
         zOcUjt/Hft/pEgi4chqnAYO8zx6273Stk0hOVf3pEf2m0XuXhiCZ9OQJ1oklalL+7CEQ
         TqFWMTjkC/NmRLaqfQ3F/iPwI4qB+/nHjWXjefN2V0775fVqD5w9WbFjjBY2yY0Lpeyz
         tV/yyqMS5O9a0ygXwQuV4EfPr3CzDW5fFVyjzwfy6qxV4wGAjNoK6ZBKuySDUoE+l9cO
         TkAukvmcG6CYprzJ9v+Ln+Y8p/4n2lgjGiHQwQnyZRxJKm2Jq1UvAW5g7tS1BoylgD/w
         jxBw==
X-Gm-Message-State: APjAAAWWwmM8+V/rQE/pjVG+54ZH+fYDllnAehA1ihLs7IzxEB1if/1R
        DQdwCyGVahcgOXmsHnDWAkLzRvu02QQ=
X-Google-Smtp-Source: APXvYqzDvUanWKNQFEmP3JE3hL2wEFYJdTHSqZFrqEzStqOSHDdhJITgiUevhXhq35ik1yQ8pCASsQ==
X-Received: by 2002:a17:902:9a42:: with SMTP id x2mr59510096plv.106.1560258462160;
        Tue, 11 Jun 2019 06:07:42 -0700 (PDT)
Received: from [10.44.0.192] ([103.48.210.53])
        by smtp.gmail.com with ESMTPSA id q36sm4347237pgl.23.2019.06.11.06.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 06:07:41 -0700 (PDT)
From:   Greg Ungerer <gregungerer00@gmail.com>
X-Google-Original-From: Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH 04/15] binfmt_flat: remove flat_old_ram_flag
To:     Christoph Hellwig <hch@lst.de>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
References: <20190610212015.9157-1-hch@lst.de>
 <20190610212015.9157-5-hch@lst.de>
 <b1ce6fc6-343c-7686-b4f4-35a305dc2adb@linux-m68k.org>
 <20190611073648.GA21522@lst.de>
Message-ID: <1aaf5ce2-1e7a-e818-fbeb-42fbe551a108@linux-m68k.org>
Date:   Tue, 11 Jun 2019 23:07:36 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190611073648.GA21522@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/19 5:36 pm, Christoph Hellwig wrote:
> On Tue, Jun 11, 2019 at 04:04:39PM +1000, Greg Ungerer wrote:
>>> index c0e4535dc1ec..18d82fd5f57c 100644
>>> --- a/fs/binfmt_flat.c
>>> +++ b/fs/binfmt_flat.c
>>> @@ -488,7 +488,8 @@ static int load_flat_file(struct linux_binprm *bprm,
>>>    	 * fix up the flags for the older format,  there were all kinds
>>>    	 * of endian hacks,  this only works for the simple cases
>>>    	 */
>>> -	if (rev == OLD_FLAT_VERSION && flat_old_ram_flag(flags))
>>> +	if (IS_ENABLED(CONFIG_BINFMT_FLAT_OLD_ALWAYS_RAM) &&
>>> +	    rev == OLD_FLAT_VERSION)
>>
>> The flags are from the binary file header here, so this is going to lose
>> that check for most platforms (except h8300 where it would always have
>> been true).
> 
> Indeed.  The old code is:
> 
> 	if (rev == OLD_FLAT_VERSION && flat_old_ram_flag(flags))
> 		flags = FLAT_FLAG_RAM;
> 
> which for !h8300 evaluates to:
> 
> 	if (rev == OLD_FLAT_VERSION && flags)
> 		flags = FLAT_FLAG_RAM;
> 
> so basically if any flag was set it was turned into FLAT_FLAG_RAM.
> Was that really intentional?

Probably not, looking at the flags. For the compressed flag it
makes some sense. But I don't think many of the others need load
to RAM behavior.


>  I guess even if it wasn't the is no
> point in changing this historic behavior now.
> 
> So I guess what we could do it something like:
> 
> 	if (rev == OLD_FLAT_VERSION &&
> 	    (flags || IS_ENABLED(CONFIG_BINFMT_FLAT_OLD_ALWAYS_RAM)))
> 		flags = FLAT_FLAG_RAM;

Yeah, that to looks to preserve the old behavior.

Regards
Greg

