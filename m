Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCECC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4DA2063F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="KfYX2CrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfEBNHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 09:07:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43380 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEBNHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 09:07:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id t1so2091095lje.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 06:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JqnAwt+SQS41g5Ko0Px1WbuXonyyQXUzTE//OpBp39s=;
        b=KfYX2CrBxFbO18Q7k+qRDQ1M7w/A3fmNHeuItS6aeurQMz9Q4CbE3tp1l2wT5eg8pD
         Zq7sMe2fFSbmjkmQPIOYijC6l+TKAfWXFZdZEEWb/f3yopgYBMqJpwpedypBHuViiBXh
         Tq/Dvy43OslwPIB0RIE2HHCxnLjMioGp/6KDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JqnAwt+SQS41g5Ko0Px1WbuXonyyQXUzTE//OpBp39s=;
        b=JY0VhlXmBaAae5hfLqSxTTeEdaookAbJ7D3wUfsIJ6YCdVegP9Kf/OhGwBlwDjTGnS
         F7bETIIBAvR/caur0R0eAJDK09pNSx7FgYYmUnr51FLndOvrMkKGU5XF404cs2CyDi3t
         0DZIMyP5xQ+7nAyaqSmixHFObhezIT9iFLIg/v1Ui17BcxUjw2N9u30Z3ezpJUHPd0so
         T736HB+24mKbV5QrA263yC+41jeyupLXnekJz3pX08BDeaLve/eLmhixp0G4/8ei5BKD
         uFags9MH4AMYevFrZi/tO/NwYOFxEjtSR7knYpE0EYcdtl7XZdS2Smf4W0CQkCsRkfJt
         c9dg==
X-Gm-Message-State: APjAAAWvAnZXnjJ2NLOoDWMP5cQz7oCG6OlUgnmB8gnfS0EsUOtYPNyl
        G3I4yT2b/lMRSflqLndP2s02wpe20MzzliAV
X-Google-Smtp-Source: APXvYqy3ogoxhTfczyioFhq4ks4oxzLywU0V4dBm+YEiNF4X3mt1az97S+WkzyFfKwqupfyNCqmwGA==
X-Received: by 2002:a2e:8e8a:: with SMTP id z10mr1887424ljk.172.1556802426108;
        Thu, 02 May 2019 06:07:06 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id r10sm3129336ljb.81.2019.05.02.06.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 06:07:05 -0700 (PDT)
Subject: Re: [PATCH] mod_devicetable.h: reduce sizeof(struct of_device_id) by
 80 bytes
To:     Jeff Mahoney <jeffm@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190425203101.9403-1-linux@rasmusvillemoes.dk>
 <CAK8P3a1Fu64YhQzvSEy8j3oZ3XwUN81fY+K6Z6ksHhqDWzbxNA@mail.gmail.com>
 <73918e46-e3c8-edc4-c941-e650c05519c8@rasmusvillemoes.dk>
 <67f54ca8-f4bd-5388-1067-35cd192cf37e@suse.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <26b2c5f7-87af-9507-98e4-d92bed8c3354@rasmusvillemoes.dk>
Date:   Thu, 2 May 2019 15:07:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <67f54ca8-f4bd-5388-1067-35cd192cf37e@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2019 14.29, Jeff Mahoney wrote:
> On 5/2/19 5:41 AM, Rasmus Villemoes wrote:

>> But we cannot really know whether there is some userspace tool that
>> parses the .ko ELF objects the same way that file2alias does, doing
>> pattern matching on the symbol names etc. I cannot see why anybody would
>> _do_ that (the in-tree infrastructure already generates the
>> MODULE_ALIAS() from which modules.alias gets generated), but the only
>> way of knowing, I think, is to try to apply the patch and see if anybody
>> complains.
> 
> The size is part of the ABI, though.  module-init-tools has a copy of
> the same struct and uses that size to walk an array of of_device_id when
> a module as more than one.  If you shrink it, that will certainly break.

Urgh, yes, didn't know about module-init-tools. But it seems to be
abandoned? So does anybody actually use that with a modern kernel (there
seems to be many new structs in mod_devicetable.h that the last release
of module-init-tools doesn't know about)?

Oh well. If it's not deemed worth the risk to do a release with this
patch applied, I can always just add this to the list of trivial things
to do when asked to trim a custom kernel.

Rasmus
