Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C46C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0F22053B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556234540;
	bh=vdbub+T9Glshegmo5i779tB0XHrVNxYlSvmT3pdn2Jg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xLLBnPXmJeJz8H63weuVKuSt1b76fa/WyaQ+ta4j1///Izbxd+mqSKCkJeISGzqjW
	 /HYJPR7sAxTLI1s0g17zFsKKV5bpnAZDfvzWwbRFAPLuxsyjDFCjkK66eIx4S7kKVJ
	 yuzKKVejtZI3FoNIlvil5pp993t/EQuoqaJA9cyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfDYXWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 19:22:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43950 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfDYXWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 19:22:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id i68so908828lfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 16:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=swaxA/YSpLPeJvaAtBk0QjWJT6AyvgwqR+ASQdMW7Xs=;
        b=IWue13h4zR7r/zINo0McDzklHlOwEUy8yNt13HnPDLcv7EwZB3napkxJnfLq6ovSaG
         ofNHk3e+fTtX7dlfmF7QqkXpikSfXWOWbsxOnGruHZI2mVvAb6iw1BMo8LZYLStxBCIL
         d/H9hBUshrvuRMCTURPUXqSM3pD8xZfKX+IW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swaxA/YSpLPeJvaAtBk0QjWJT6AyvgwqR+ASQdMW7Xs=;
        b=iaRTKpgucDOFo185Q70ZkU8jELjjK3VWRnxB3djpEC8nv/o2iCJKwsRN3crarmnBuj
         X0nXh04NuWlK3ZR/yMViVQV8HnGkocV6kAO9XOwcPfKV+pgsevHSxgjYYy7ZvNLM3LnI
         xQ8hl+6kw1sM5/oJmXuwQTsdGEN3EjbKhdVus01n1SkSh4S+DYWrDbssWIYvKCLhdkiV
         4BzIUQDfzVpJY1ZQtTv/BW5YpopRrKjripvoA9LMdH0lYbN8wlbTkucM2nUuN9hFbUx7
         MPB3tnJjRYUTrEW6KARw4TrX8G+PDV1KX9O6ZInPm46uCZnrOX3wo114kP8gxSeBbTLk
         vNHA==
X-Gm-Message-State: APjAAAWA0hj4aG6ZPKdNmiB4XJ6HBj8q6hSzrblt4ebJhNoYGJT4ejzN
        ZRpnzNQJ/C/dtgNCPv57vyXOWA3bpFk=
X-Google-Smtp-Source: APXvYqzE0I43bFwPRPAlCg04IcBYfYE4g6FZu5I7cH6LH6PmP15ZbBc0WWG/kioDhvMnwKZv0WE9zg==
X-Received: by 2002:a19:5218:: with SMTP id m24mr20664566lfb.113.1556234535712;
        Thu, 25 Apr 2019 16:22:15 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id i24sm4859267ljb.31.2019.04.25.16.22.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 16:22:15 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id j20so1065259lfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 16:22:15 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr22184518lfg.88.1556234055199;
 Thu, 25 Apr 2019 16:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000101b30587622a69@google.com>
In-Reply-To: <0000000000000101b30587622a69@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Apr 2019 16:13:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjp-R083To=AVbovNJWrskNfYN8rqz=nZZTPRihCohE4g@mail.gmail.com>
Message-ID: <CAHk-=wjp-R083To=AVbovNJWrskNfYN8rqz=nZZTPRihCohE4g@mail.gmail.com>
Subject: Re: BUG: unable to handle page fault for address = ADDR
To:     syzbot <syzbot+45474c076a4927533d2e@syzkaller.appspotmail.com>,
        Ben Hutchings <ben@decadent.org.uk>
Cc:     David Miller <davem@davemloft.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Netdev <netdev@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        peter@hurleysoftware.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        vegard.nossum@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 3:16 PM syzbot
<syzbot+45474c076a4927533d2e@syzkaller.appspotmail.com> wrote:
>
> The bug was bisected to:
>
> commit bcdd0ca8cb8730573afebcaae4138f8f4c8eaa20
> Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date:   Wed Apr 25 11:12:31 2018 +0000
>
>      tty: Use __GFP_NOFAIL for tty_ldisc_get()

I think this just makes slhc_init() fail more easily, but the bug was
pre-existing.

The *real* source of the bug seems to be

    4ab42d78e37a ("ppp, slip: Validate VJ compression slot parameters
completely")

from back in 2015.

We have (in drivers/net/slip/slip.c: sl_alloc_bufs())

        slcomp = slhc_init(16, 16);
        if (IS_ERR(slcomp))
                goto err_exit;
....
err_exit:
#ifdef SL_INCLUDE_CSLIP
        kfree(cbuff);
        slhc_free(slcomp);
#endif

so we do "slhc_free()" on an error pointer, which results in

    BUG: unable to handle page fault for address = fffffffffffffff4

and the fix might be something like the appended whitespace-damaged
trivial one-liner: just make slhc_free() silently ignore an error
pointer, to match the slhc_init() return behavior.

Ben? David?

                       Linus

diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
index f4e93f5fc204..ea90db3c7705 100644
--- a/drivers/net/slip/slhc.c
+++ b/drivers/net/slip/slhc.c
@@ -153,7 +153,7 @@ slhc_init(int rslots, int tslots)
 void
 slhc_free(struct slcompress *comp)
 {
-       if ( comp == NULLSLCOMPR )
+       if ( IS_ERR_OR_NULL(comp) )
                return;

        if ( comp->tstate != NULLSLSTATE )
