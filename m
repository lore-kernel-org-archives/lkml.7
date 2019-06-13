Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99017C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E49920B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="EhoeFLRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392074AbfFMQWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:22:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34275 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731137AbfFMQV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:21:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id s49so2264791edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mz6GIPKtlkGerT/pt6ZWWFPZs8Zmg5qBehaRfeC+EUo=;
        b=EhoeFLRHnBhKbWvy9HbsUZYnmSqkMjgbw/4JBVzBmKwtC2BYciZon/sGwYlwxD2ArB
         820lhaGvsyDxIQBlup+5VKFfAjqc0UgL0AndVHVEjCUhxyB6MYwWpt9rVeipesbYJm9O
         9LctzS/TEIahM6LL9VOCpzIV8wbDeIGYc6LpG/4Ag9cMHwzd7NIdHtF03n3uFJ5oSCsa
         3G8seNu4kPRGCTWh5OLMltNpswqlywnH6ctZu426ea1q3OKYycClQ4ZPMg8bCkDfv5pf
         qrUMZwVvDtNADcRslOs9acphTWeWGkYvfzJ9d44UO3i9kqBf746dXPNN4G9zYO82urgl
         cWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mz6GIPKtlkGerT/pt6ZWWFPZs8Zmg5qBehaRfeC+EUo=;
        b=lMcdXlQcu644DiusZQ19IIczNb+Ys4QgQBkHOeMOiXoM+gUbV4NVzRF0Xp9+EbUpNM
         EbcTKjrE7LFN8PjT3QR4nsxLvoP3x0ESDDs6blmnihrNu5y6bosKpYD0+yr+sp2JyncP
         tqvWB87PAuO/F6hV9FZQPOhgQG2EUaFTeUBX7WZ1LZjK+Fqkh7IdFyJkceR+5gB4lmom
         o6Vs1ClxGxmL7kI/azwfRKcdN4gbMnCntrejKtmJmubqCANtvmEnd3V7y2gIxhryhAgh
         xW8Il3tuPTP2nBLo85/LyeaL5Gpber+2vCGWTYwkWMW8jQ887Bev+ORUgINnlaMdeCJx
         +Uzg==
X-Gm-Message-State: APjAAAXnfDdLKxp8bRK1XSqEz2A5Cf4KNi3u8ye0z90y0B1FQziSsDhO
        qW9sYbQJaB8lhcYKFwy5CZpImf0MhfuZuSK1Y/auRf69HUQ=
X-Google-Smtp-Source: APXvYqxuWVuyBpuxXeXaLydjVhfXhrVUHymBl4vNZ13Z3Lq3A6ZwUrJo9f7zawIdyv/dg+ZkFHQ0nrTO50sHeOAATfU=
X-Received: by 2002:a17:906:3948:: with SMTP id g8mr45653628eje.168.1560442914546;
 Thu, 13 Jun 2019 09:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190612163144.18486-1-roman.stratiienko@globallogic.com>
 <20190612163144.18486-2-roman.stratiienko@globallogic.com>
 <20190613135241.aghcrrz7rg2au3bw@MacBook-Pro-91.local> <CAODwZ7v=RSsmVj5GjcvGn2dn+ejLRBHZ79x-+S9DrX4GoXuVaQ@mail.gmail.com>
 <20190613145535.tdesq3y2xy6ycpw7@MacBook-Pro-91.local>
In-Reply-To: <20190613145535.tdesq3y2xy6ycpw7@MacBook-Pro-91.local>
From:   Roman Stratiienko <roman.stratiienko@globallogic.com>
Date:   Thu, 13 Jun 2019 19:21:43 +0300
Message-ID: <CAODwZ7so4cVVJmPHXGGOxKRO_0L2NjZJac73wfaHPV7ZN6ce1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] nbd: add support for nbd as root device
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-kernel@vger.kernel.org, nbd@other.debian.org,
        Aleksandr Bulyshchenko <A.Bulyshchenko@globallogic.com>,
        linux-block@vger.kernel.org, axboe@kernel.dkn.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't doubt you have a good reason to want it, I'm just not clear on why an
> initramfs isn't an option?  You have this special kernel with your special
> option, and you manage to get these things to boot your special kernel right?
> So why is a initramfs with a tiny nbd-client binary in there not an option?
>
> Also I mean that there are a bunch of different nbd servers out there.  We have
> our own here at Facebook, qemu has one, IIRC there's a ceph one.  They all have
> their own connection protocols.  The beauty of NBD is that it doesn't have to
> know about that part, it just does the block device part, and I'd really rather
> leave it that way.  Thanks,
>
> Josef


The only reason I prefer embed client into the kernel is to save
valuable engineering time creating and supporting custom initramfs,
that is not so easy especially on Android-based systems.

Taking into account that if using NBD and creating custom initramfs
required only for automated testing, many companies would choose
manual deployment instead, that is bad for the human progress.

I believe that all users of non-standard NBD handshake protocols could
continue to use custom nbd-clients.

Either you accept this patch or not I would like to pass review from
maintainers and other persons that was involved in NBD development,
thus making a step closer to get this mainlined in some future.

--
Regards,
Roman
