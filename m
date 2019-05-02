Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FE4C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C9B20873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="EgB6mGwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfEBJlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 05:41:35 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38531 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfEBJld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 05:41:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id v1so1383904lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=060caLbyZI4zk0ZjA7Fiouwu98LQI7AWRp5h7x3hZmQ=;
        b=EgB6mGwdWeIn3vIPHsngENAUNgzb9IiX4BoErNZL46CNGAaquzw9mGlUYs7Zh6UbJn
         vYqOEdIhzJYxZQcMquB5S7abAjQEiy2HiC477MOze+j8OJOQnc9oSTyRKKhLZT7Cn2tH
         Og8q35ad1q3I9CKQJxRoMcFKNlfpCtLJWtSd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=060caLbyZI4zk0ZjA7Fiouwu98LQI7AWRp5h7x3hZmQ=;
        b=mhjz6fy0SZ7AWiPpNmr03HtMMf+moHuGhXPLQeybxhhCpOjNoAzHdhKwQcFFHRajyk
         nQuT6/Y8hmqzIGJiwuPiHNyro6mbvnojHdRHRxlm6NmrDT067x1ybNwKZjDVchZcvuFO
         2Ehx7u+f2Kz8SB5x65P67Cnc9qFPYxLEr0gW/QgnFhDt6e/dBDPfapbd67QPtsZ6k1t+
         g5VB7etQZi7J9kUeh0zZ37vOiD76AP8aNMaABrgXFdBGaY9MuMf0R62mOzqHtUnFPO3p
         3nw4vo6X4PFmAM3Y0MjJMpRklQf3svpZ0m9F3iGaEhjGS1PfZQAhfDVXyhiQZ7y2RV8R
         rMfw==
X-Gm-Message-State: APjAAAW/OLCXEDQDPXqPdQ1OYqSGtgjxOpvu33lTWLnJO1MAVXH0qX1I
        HedahH3wQjAxsGIIq9PuVIMk4zkQsZ6K4vVc
X-Google-Smtp-Source: APXvYqzCKARzaa7KDntpBOsDXCBZb0O1Ck2efsStbjzbQ90RsUz1DOVYRjLf1CDCOVyuQGSrWgkOAw==
X-Received: by 2002:a19:7719:: with SMTP id s25mr1442278lfc.69.1556790091338;
        Thu, 02 May 2019 02:41:31 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id 77sm403262ljs.77.2019.05.02.02.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 02:41:30 -0700 (PDT)
Subject: Re: [PATCH] mod_devicetable.h: reduce sizeof(struct of_device_id) by
 80 bytes
To:     Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Mattias Jacobsson <2pi@mok.nu>, Jeff Mahoney <jeffm@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190425203101.9403-1-linux@rasmusvillemoes.dk>
 <CAK8P3a1Fu64YhQzvSEy8j3oZ3XwUN81fY+K6Z6ksHhqDWzbxNA@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <73918e46-e3c8-edc4-c941-e650c05519c8@rasmusvillemoes.dk>
Date:   Thu, 2 May 2019 11:41:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1Fu64YhQzvSEy8j3oZ3XwUN81fY+K6Z6ksHhqDWzbxNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2019 11.27, Arnd Bergmann wrote:
> On Thu, Apr 25, 2019 at 10:31 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> For an arm imx_v6_v7_defconfig kernel, .rodata becomes 70K smaller;
>> .init.data shrinks by another ~13K, making the whole kernel image
>> about 83K, or 0.3%, smaller.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> The space savings are nice, but I wonder if the format of these
> structures is part of the ABI or not. I have some vague recollection
> of that, but it's possible that it's no longer true in this century.
> 
> scripts/mod/file2alias.c processes the structures into a different
> format and seems to be written specifically to avoid problems
> with changes like the one you did. Can anyone confirm that
> this is true before we apply the patch?

I can't confirm it, of course, but I did do some digging around and
couldn't find anything other than file2alias, which as you mention is
prepared for such a change. I also couldn't find any specific reason for
the 128 (it's not a #define, so at least originally it didn't seem to be
tied to some external consumer) - Jeff, do you remember why you chose
that back when you did 5e6557722e69?

But we cannot really know whether there is some userspace tool that
parses the .ko ELF objects the same way that file2alias does, doing
pattern matching on the symbol names etc. I cannot see why anybody would
_do_ that (the in-tree infrastructure already generates the
MODULE_ALIAS() from which modules.alias gets generated), but the only
way of knowing, I think, is to try to apply the patch and see if anybody
complains.

Rasmus


