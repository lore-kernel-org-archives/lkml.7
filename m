Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C9EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70ADE206EE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 04:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkKAOxtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfLREKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 23:10:10 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34533 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLREKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 23:10:10 -0500
Received: by mail-io1-f68.google.com with SMTP id z193so544285iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 20:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZI9jyFjISAngYAMy39G35CXNgJygVR0280jysm3UBIo=;
        b=VkKAOxtPMy5W5SSkbDeqxMUaOoqoynaHignds/XjvcYDcc8zsz5KR2aRMv5v9qrzkr
         Z/LBqHt/TJwnzBix9Zaz/gl+Gb5arycBHBl6Z4Gqn7F7GQfyPrm5c631m9dUdI2H9HuY
         B2I3299Q3mK9KWOet63WIpbW0JB8qw2nfATVljKfoojjjKWAi+b2nHrzCeEStER52xbi
         iXpC3dKE0F13NNsiokVDOnWY16xPyKVKPMZxU7scLL7o9DVt5MP3kn2SsVAIMwhFwHG3
         Dd1Mr7pUzWi2HpiXvWJsyysKjzVNxhlN8w+0PwJuviPlpqiqUIMcAekkb5G2s4vIMZZq
         Conw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZI9jyFjISAngYAMy39G35CXNgJygVR0280jysm3UBIo=;
        b=f5oDUrUH2Oif41Am1DqZjrehpg5wp34jZEbIXqnL95T2mQesWrSKHuQUDX0/rrZuRK
         6IoHLGnJslmlr08CztQk/6fNJuBPWwlEW6s8W80lmQo/KIyTXDb42IrUh7ywRopfv3nB
         8999Oyu08tH3R3ygO4ZR6XdHIYUFmdboJPZ/3u5PNmP6fAUfp9TfbcHTUw+O10ypT3cG
         0p9o7JavIoBDzk5kE+SJuC5Rwl1yim26naXpwWewcdmxYc5e+3vxG1WVJ1+s2KshVATb
         334cOQOEFRL3mq4WBCTSjFJuIaByzPcKK7cUl8K+qXfbpnKNXtzpfMKcDs0BfvnKToIk
         /DMw==
X-Gm-Message-State: APjAAAXUMQrzQEbbEmXXLpghe++0VXX7VyBQgbK7crzsYQquV02d4RjU
        cAW0nKfWB+w3QLnFUdrrkDo7UwFV9GQHAHCfHDo=
X-Google-Smtp-Source: APXvYqxKhLraorW1FRWcgfifseK/7GGEnwsZvDt9U+eHohKKsUxjjdRRIHsxJbxUg/wAiwiJVxA7MbUw7o979mOI3Ok=
X-Received: by 2002:a6b:b48d:: with SMTP id d135mr126438iof.280.1576642209483;
 Tue, 17 Dec 2019 20:10:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac0:9191:0:0:0:0:0 with HTTP; Tue, 17 Dec 2019 20:10:08
 -0800 (PST)
In-Reply-To: <CAHk-=whN00UTq76bDT-WXm72VhttLv8tcchqEkcUoGXt38XXRg@mail.gmail.com>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <20191217051751.7998-1-youling257@gmail.com> <20191217064254.GB3247@light.dominikbrodowski.net>
 <CAOzgRdZR0bO14fyOk5jLBUkWwgsf7fx41JMQr-Hr6nss1KSmLw@mail.gmail.com> <CAHk-=whN00UTq76bDT-WXm72VhttLv8tcchqEkcUoGXt38XXRg@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Wed, 18 Dec 2019 12:10:08 +0800
Message-ID: <CAOzgRda=q0mBeBx_i8N0VT_a_ud8EVcf9hVC5Y_Oz2sdAdGGLg@mail.gmail.com>
Subject: Re: [PATCH 4/5] init: unify opening /dev/console as stdin/stdout/stderr
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

only Revert "fs: remove ksys_dup()", not see the warning
"/system/bin/sh: No controlling tty: open /dev/tty: No such device or
address."

yes, "fs: remove ksys_dup()" caused my system/bin/sh problem.

but test "early init: fix error handling when opening /dev/console",
still can see "/system/bin/sh: No controlling tty" warning, it not
solve my problem.


2019-12-18 5:14 GMT+08:00, Linus Torvalds <torvalds@linux-foundation.org>:
> This should be fixed by 2d3145f8d280 ("early init: fix error handling
> when opening /dev/console")
>
> I'm not sure what you did to trigger that bug, but it was a bug.
>
>               Linus
>
>
> On Tue, Dec 17, 2019 at 1:34 AM youling 257 <youling257@gmail.com> wrote:
>>
>> I had been Revert "fs: remove ksys_dup()" Revert "init: unify opening
>> /dev/console as stdin/stdout/stderr", test boot, n the system/bin/sh
>> warning.
>
