Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0904C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3432184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558724165;
	bh=h2W0CWnclBlqkH3iiYyEW5PvMU5agmrqPMASVVRGODc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yFYp4pyFZnUNQysWEiCboGV3Xt7F3z7nbxtVE5w8WwBqlGJGYpx8Z7JdA+NoxMNN3
	 BlmmVUlRUDtbKkd/X8ohLbNPKoc7Teq9MhoCc0/gjG2XStOAtvYswVp5awp5lG8ZIq
	 /uTqVi8EMfnubNmMSXyS39HrbOnz/WHTR9yaHdg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391735AbfEXS4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:56:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45822 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391181AbfEXS4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:56:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id r76so4095452lja.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 11:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csmB0SVtlpuGlEdBBr9KglbwXGniIuOaWROmVBN2nig=;
        b=BDFiVmjeU9znvacKUoSeXzX6qILwjm/Koo/XJlf9jEsNo3fWFjyqRx6KkAqAlbbhaa
         D3mTInlmrbdbdoCf3qsYio4ivCLh38fXEFGzOYPndAsHXOGkLuikM8ojUqHIc1ii5QFu
         jbhG67yHeawfxde2WC1KkJlI96daxBp+KkPH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csmB0SVtlpuGlEdBBr9KglbwXGniIuOaWROmVBN2nig=;
        b=ZdXmPcU6fO+KzJSu3XZi8aoiBKau+2PmhCC08zQBJ9TQfKfTzuQ4RuByPJkeAyErjX
         Ig1u7kPaLRVZ4ffCWKGgxaahZ4MPqX5rKdYFEN99qBaxSLdT+D84CirKJegatcM/Ev/1
         N09CPsEMnype9qeuCX6NEFfQuTvU5dMldUr41fHJjjss0ZmIxZO5hloJb9HGhslRrQd2
         Cx51ZsF7kwykIH/cYxA4giOgZWVhcYFOwRjAjkR90Mrtx06vSTvylpNuXEUSFSykRyWM
         iZWW6jGBEBqBlRVqiff0v9GAt6mwAc+8qb9IQ0rJGea8jaRE92jl+9onMsCPKdfwGRYW
         4rrA==
X-Gm-Message-State: APjAAAW7kQVSQ1QYuju5/MirDEnwbJpdxucFUD364Ipl5j6hiV9nSG27
        a8uffOWhuKn5m65y/Cwe57bjDWsgn28=
X-Google-Smtp-Source: APXvYqzTT2hcXN5oT+U2FollcQglTbmQFuZwhvjAWynv2jtKOUcGW/vdvz9QbklIjGHdA4/TNVd4Mg==
X-Received: by 2002:a2e:8041:: with SMTP id p1mr2712694ljg.121.1558724161211;
        Fri, 24 May 2019 11:56:01 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id u7sm658909ljj.51.2019.05.24.11.56.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 11:56:00 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id e13so9526397ljl.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 11:56:00 -0700 (PDT)
X-Received: by 2002:a2e:4246:: with SMTP id p67mr40005336lja.44.1558724160052;
 Fri, 24 May 2019 11:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190523182152.GA6875@avx2> <CAHk-=wj5YZQ=ox+T1kc4RWp3KP+4VvXzvr8vOBbqcht6cOXufw@mail.gmail.com>
 <20190524183903.GB2658@avx2>
In-Reply-To: <20190524183903.GB2658@avx2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 May 2019 11:55:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaCygWXyGP-D2=ER0x8UbwdvyifH2Jfnf1KHUwR3sedw@mail.gmail.com>
Message-ID: <CAHk-=wjaCygWXyGP-D2=ER0x8UbwdvyifH2Jfnf1KHUwR3sedw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] close_range()
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:39 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> > Would there ever be any other reason to traverse unknown open files
> > than to close them?
>
> This is what lsof(1) does:

I repeat: Would there ever be any other reason to traverse unknown
open files than to close them?

lsof is not AT ALL a relevant argument.

lsof fundamentally wants /proc, because lsof looks at *other*
processes. That has absolutely zero to do with fdmap. lsof does *not*
want fdmap at all. It wants "list other processes files". Which is
very much what /proc is all about.

So your argument that "fdmap is more generic" is bogus.

fdmap is entirely pointless unless you can show a real and relevant
(to performance) use of it.

When you would *possibly* have a "let me get a list of all the file
descriptors I have open, because I didn't track them myself"
situation?  That makes no sense. Particularly from a performance
standpoint.

In contrast, "close_range()" makes sense as an operation. I can
explain exactly when it would be used, and I can easily see a
situation where "I've opened a ton of files, now I want to release
them" is a valid model of operation. And it's a valid optimization to
do a bulk operation like that.

IOW, close_range() makes sense as an operation even if you could just
say "ok, I know exactly what files I have open". But it also makes
sense as an operation for the case of "I don't even care what files I
have open, I just want to close them".

In contrast, the "I have opened a ton of files, and I don't even know
what the hell I did, so can you list them for me" makes no sense.

Because outside of "close them", there's no bulk operation that makes
sense on random file handles that you don't know what they are. Unless
you iterate over them and do the stat thing or whatever to figure it
out - which is lsof, but as mentioned, it's about *other* peoples
files.

               Linus
