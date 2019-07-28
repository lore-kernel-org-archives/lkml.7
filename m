Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C443C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3952075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PupS4yiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfG1WQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 18:16:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33664 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfG1WQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 18:16:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so26651879plo.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 15:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c8YSToKmG8S+pAYeJq04gGadIuFi0aiciNczjeIoUfY=;
        b=PupS4yiK7F/aaFtrJN1Qs/vag2f9vfElBk2oZ4GtPdDHk4oTBX4ZWlYrssDdIzCWt9
         297KyUW5CKif7pwJouq7rVrrzK6MzhrqtYfidugj5hpnc+qAQ6p4aT8lwa4CMma7x+50
         UomKX7T7S7PH2i+ujRem54zfmvQk78Y24rI0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c8YSToKmG8S+pAYeJq04gGadIuFi0aiciNczjeIoUfY=;
        b=K6pJYhK2eTcNXQ14/6xu9qfiO8H43kl/2+3knmP5TrQhgU/9+vRvH9impadMocRIBa
         7Ira+wlYXkcOMFxudoIuVQBz4tfhR0zii9sJpKOnwQNIQ+869B5bEeImHLkbNIDcLeD5
         AVp+LelI1pcwHZbF3eHrEZWipi5Ic3kyoWicOkQ4UKGTY0wk6ZKIYALNuyZYKyM1CU23
         f1aKqxKxyNAXrq1aVu40xFduXdNpLWqQurnfBD+M6ErXzIC8rk9NyQ49LhnqDTcN6/8C
         Zy73qmQcbtmCnfvReHeK6AJmBrfGDwjdviV14wgOQuKo6It2rhVOMlBh3ueImqyQcdFt
         baog==
X-Gm-Message-State: APjAAAVmkqI/RKzUbYOwp4unhuFlix/e7r+nrVHGMpuIPJtR3c/T8mDc
        5GKb8hrC0mwHAC2soszkv0EtEA==
X-Google-Smtp-Source: APXvYqybTpj9RCmsGHrd55vYgJwXjq4jSb6bc/pyNavoJ85eo6o+Jc9zoSgM4lZnkHh3puaJzLQw0A==
X-Received: by 2002:a17:902:2f:: with SMTP id 44mr108866672pla.5.1564352190069;
        Sun, 28 Jul 2019 15:16:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a128sm65029848pfb.185.2019.07.28.15.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Jul 2019 15:16:29 -0700 (PDT)
Date:   Sun, 28 Jul 2019 15:16:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [GIT PULL] meminit fix for v5.3-rc2
Message-ID: <201907281507.B3F11DD54@keescook>
References: <201907281218.F6D2C2DD@keescook>
 <CAHk-=wj+1vDh2=eZExibYF9Lo0GsGxaAjxCSwpUFVURrN44cUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj+1vDh2=eZExibYF9Lo0GsGxaAjxCSwpUFVURrN44cUQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 12:43:15PM -0700, Linus Torvalds wrote:
> On Sun, Jul 28, 2019 at 12:21 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Please pull this meminit fix for v5.3-rc2.
> 
> Side noe: I find "meminit" a confusing description for the structleak
> thing. When I hear it, it sounds like some generic memory
> initialization thing in the VM layer (which we obviously do also
> have), not the stack variable initialization.

I will find a better name. :) We dreamed up "meminit" as finding a name
for the umbrella of both stack and heap auto-initialization. But I
agree, it's confusing.

> Also, have you guys talked to gcc people about just making it a real
> feature, like I think it is for clang? In particular, I still suspect
> that we could/should  just make zero-filling the *default* in the long
> run, and say "our C standard is that local variables are initialized
> to zero, exactly the same way static variables are".

Yes, this is on the list for discussion at Plumber's. Having gcc do
auto-init is the first part. Convincing Clang that _zero_ init isn't
a language-breaking change is the second part. :P That's been a whole
other issue.

> I know you posted some numbers somewhere (well, I'm pretty sure you
> did) and the full stack initialization really was pretty cheap,
> wasn't it?

Yes, Clang's initialization (which is 0xAA not 0x00 in most cases) is
cheap. There are rumors(?) of some pathological workloads, though. I
haven't seen real numbers for that though.

I'll try to find the Clang numbers (maybe Alexander has them?) but I
remember it being the same as (or maybe better than) the gcc-plugin
version, which I measured here:

https://git.kernel.org/linus/81a56f6dcd20

-- 
Kees Cook
