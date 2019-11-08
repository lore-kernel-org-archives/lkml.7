Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D106AC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31C2206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573232522;
	bh=aWxW6bR43V6gh4YLR9SqJSDr+w3hQ5rwBAK3wEjJwnk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FSPZyiVA+jLhX+hhr4BA382NRkEg6FfbsIwvYtjOKYVw1yDcn5EssMqEqJgUjfwAt
	 TcON+1N8Bjf7VSozZMgZveBqErQCBWp+arJT/ZyXXoEqwNMGYpS81oew3Mg/udOYud
	 yiin+XJ9z4cYUth1pglIL4RHQ/Q7qGBBwVZuMqlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfKHRBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:01:55 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:44552 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730745AbfKHRBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:01:53 -0500
Received: by mail-lj1-f182.google.com with SMTP id g3so6938251ljl.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 09:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=areMWrVEmfkCGN5C3vFUMp6ntvtTANx8pMI7+P+pQwk=;
        b=fTQAG1nv+Xfvawkzfroy56UyjdshaUI6tDZmA2U31BY2vRabBOWqqcIrGwEiaPTMLM
         UpxslrqN19Q5RkBzYwKrg+R9FYC+kmfTcy86WRoQeVweyUd8I+BSDcL1kR2UVpc9heaR
         8C9Z7s7NSuSZCqLYqqjNuS4lSdyWdr7omtzoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=areMWrVEmfkCGN5C3vFUMp6ntvtTANx8pMI7+P+pQwk=;
        b=jxO0UcFecw31XBZjSU06rCHPduQRGoHsNlCusBnvDmvTLKpsMu9FctI4Ay9t4m53wk
         tEP8xaqVcqlNPmByCUoYHdoWck1cn/wpignXlHWZR60cg/4YsxUgYLLxYHLZa5/epk9v
         PBvd0whXbq1ZlcMsFpRfHe0RFzoXvY4eny2yiAWQQM3PvapaQl6emvG4QiKTGSm2Zk3S
         RxBnQXazspKeymIIVZQ78O831bJNpxYEHG3RLXLPe7p2bNxHBzSNax5F4/1y6YX+jpr6
         UdYobjF0KAAD40/yow5tNq2cNfg2DNZN3AVfxW3EYggZ5rNzBc8UXiTjSotV6Z4ycZ1y
         D49g==
X-Gm-Message-State: APjAAAUmp2PjkYRTjdzH6rUZ2U1kd3kJm0MoimyP1SBCoGTI/xFcMYlk
        6sbA7/nFfg+WJy3WexrfUxlScEUksE0=
X-Google-Smtp-Source: APXvYqzqpM8s5ESVfxjdvwEwzN2kNzCBEHQ9IsmHh/igQ+7Ug+UqzjidKbU2uKW1xeBYODI6/WDT6Q==
X-Received: by 2002:a2e:a175:: with SMTP id u21mr7430836ljl.198.1573232510173;
        Fri, 08 Nov 2019 09:01:50 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id o5sm3161909lfn.78.2019.11.08.09.01.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 09:01:49 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id r7so6982166ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 09:01:48 -0800 (PST)
X-Received: by 2002:a2e:8809:: with SMTP id x9mr7562934ljh.82.1573232508697;
 Fri, 08 Nov 2019 09:01:48 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
In-Reply-To: <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Nov 2019 09:01:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
Message-ID: <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        elver@google.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 5:28 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> Linus, what do you think of the following fix ?

I think it's incredibly ugly.

I realize that avoiding the cacheline dirtying might be worth it, but
I'd like to see some indication that it actually matters and helps
from a performance angle. We've already dirtied memory fairly close,
even if it might not share a cacheline (that structure is randomized,
we've touched - or will touch - 'cred->usage') too.

Honestly, I don't think get_cred() is even in a hotpath. Most cred use
just use the current cred that doesn't need the 'get'. So the
optimization looks somewhat questionable - for all we know it just
makes things worse.

I also don't like using a "WRITE_ONCE()" without a reason for it. In
this case, the only "reason" is that KCSAN special-cases that thing.
I'd much rather have some other way to mark it.

So it just looks hacky to me.

I like that people are looking at KCSAN, but I get a very strong
feeling that right now the workarounds for KCSAN false-positives are
incredibly ugly, and not always appropriate.

There is absolutely zero need for a WRITE_ONCE() in this case. The
code would work fine if the compiler did the zero write fifty times,
and re-ordered it wildly. We have a flag that starts out set, and we
clear it.  There's really no "write-once" about it.

               Linus
