Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77187C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EF522DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566347963;
	bh=uPeKvh44ofbd5Q4hLdSNlFFx9ZZE2pFs0bgJAFyvr/0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HOp4OrDjWw3VionFqEFFgQbW2+anJdKGFOqsILTUg85MvCnqeMBle3lpDY4zdYs/H
	 UNy9MmUeYX8Wrso29YHGrhMxAlnkouxerAuBWWqkRXyIelPmhLFM3upZr+eBPpWrRf
	 Sde30NJ8y33Fqn+Qvl0U4ddXqlKh/vzstADGia1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfHUAjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 20:39:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34411 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfHUAjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:39:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id x18so502834ljh.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 17:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4EOq9mDgEfmNv0YrKNDUErGyd5ODwotD5rgw4r8IYbE=;
        b=QRGPOX2Jza4zd8OncuNxWi+PWiPPE478PtBXEqzKkJ7j3jkFBcnuCO4SgC91yCwywZ
         MycuQf+zjn53qlNCprLCg+9Aa6yqwnCJRcbfVjZUNVMoFOqqlzwklDPSptyPbdPAacTv
         31fWXYUaHQ0kXeKa+g0tH/YeJIPz7cp9EDIoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4EOq9mDgEfmNv0YrKNDUErGyd5ODwotD5rgw4r8IYbE=;
        b=s/tL6tG3YKYhW4CtLFCPLeqvKddVxEB+6HgY7sIccbwhOLRxbZ6ZP5BCNJNnPYTkKx
         X2/TkVMeQ3sod8il07oeEbW87tXtxNp1Dc2dXIrJmzcg1BPbLwxfPtp7aaMd77ntBTZd
         8K7mbw6JLClmZwRX+QYqXEuBkcsq0ErHS8Blsq3ReCmUGNsyLnWvXiPrZhG1C4I8cKYy
         9uNp8cmljuIHxoYxh5j6rrCBtFiWFTi9L8ifcpC8OOoE9b1cfPWmxLBt5lN0PI4vtDfC
         hPEEc9PW6Y6vGJIYdofEVcQuhZa+UjX+Tov00o6Sbmu51Cf8/olIAboe9QaO7KDz1x/f
         cwHQ==
X-Gm-Message-State: APjAAAVWthEOwuAKq3/6mIUGTFP6lxssv6IRxcAsE3oxI8VXIgbPJmuP
        ozSf1w2IcmZ3zFnnE/L443R1v3VqRco=
X-Google-Smtp-Source: APXvYqxeQ2vwOx7eSIiPocPCsw+8nf2e2ykgJ5VEHVQjyv0TrfHJ7vpmI3lrCIWXqRfzlbTszilS2Q==
X-Received: by 2002:a2e:a415:: with SMTP id p21mr17525853ljn.111.1566347958687;
        Tue, 20 Aug 2019 17:39:18 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id d7sm3086406lfa.86.2019.08.20.17.39.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 17:39:17 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id e24so451069ljg.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 17:39:17 -0700 (PDT)
X-Received: by 2002:a2e:9702:: with SMTP id r2mr15740638lji.84.1566347956990;
 Tue, 20 Aug 2019 17:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
 <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
 <CAHk-=wiL7jqYNfYrNikgBw3byY+Zn37-8D8yR=WUu0x=_2BpZA@mail.gmail.com>
 <6a5f470c1375289908c37632572c4aa60d6486fa.camel@perches.com>
 <4398924f28a58fca296d101dae11e7accce80656.camel@perches.com>
 <ad42da450ccafcb571cca9289dcf52840dbb53d3.camel@perches.com>
 <20190820092451.791c85e5@canb.auug.org.au> <14723fccc2c3362cc045df17fc8554f37c8a8529.camel@perches.com>
 <CAHk-=wgqQKoAnhmhGE-2PBFt7oQs9LLAATKbYa573UO=DPBE0Q@mail.gmail.com> <9d12995c5e7e41fc5d8ba202f76a2cf854183245.camel@perches.com>
In-Reply-To: <9d12995c5e7e41fc5d8ba202f76a2cf854183245.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 20 Aug 2019 17:39:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi6bEnBy11HJBbgPsG3-ctE6Zyi2+3cnozjMAafSUBAaQ@mail.gmail.com>
Message-ID: <CAHk-=wi6bEnBy11HJBbgPsG3-ctE6Zyi2+3cnozjMAafSUBAaQ@mail.gmail.com>
Subject: Re: rfc: treewide scripted patch mechanism? (was: Re: [PATCH]
 Makefile: Convert -Wimplicit-fallthrough=3 to just -Wimplicit-fallthrough for clang)QUILT
To:     Joe Perches <joe@perches.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 4:37 PM Joe Perches <joe@perches.com> wrote:
>
> > So I'm putting my foot down on yet another broken string copy
> > interface from people who do not understand this fundamental issue.
>
> I think you are mistaken about the stracpy limits as
> the only limit is not the source size but the dest.
>
> Why should the source be size limited?

You just proved my point. You don't understand that sources can also
be limited, and the limit on a source can be *smaller* than the limit
of a destination.

Did we learn *NOTHING* from the complete and utter disaster that was strlcpy()?

Do you not understand why strlcpy() was unacceptably bad, and why the
people who converted strncpy() to it introduced real bugs?

The fact is, it's not just the destination that has a size limit. The
source often has one too.

And no, the source is not always guaranteed to be NUL-terminated, nor
is the source buffer guaranteed to be larger than the destination
buffer.

Now, if you *know* that the source is smaller than the destination
size, you can do:

    len = strnlen(src, srclen);
    memcpy(dst, len);
    dst[len] = 0;

and that's not wrong, but that works only when

 (a) you actually do the above

 (b) you have no data races on src (or you at least only require that
'dst' is NUL-terminated, not that 'len' is necessarily the correct
length of the result

 (c) you actually know as the programmer that yes, the source is
definitely smaller than the destination.

and honestly, people don't get _any_ of that right.

For one thing, the buffer sizes of the source and destination may be
two different things and some #define. It's hard to tell that one is
always smaller than the other (or that they are always the same size).
So then to get it right in the *general* case, you may need to do
something like

     if (srcsize < dstsize) {
          .. do the above ..
     } else {
          strlcpy(dst,src,dstsize);
     }

do you see the reason?

Do you see why strlcpy() is only safe to do when the allocation size
of the source buffer is at least as big as the allocation size of the
destination buffer?

For example, I just grepped for some patterns, and I can find code
like this in the kernel

     name_len = strnlen(fileName, PATH_MAX);
     name_len++;  /* trailing null */
     strncpy(pSMB->fileName, fileName, name_len);

where pretty much everything is wrong. The comment is fundamentally
wrong, and even spells "nul" wrong. Christ.

Here's another one:

     /* will be less than a page size */
     len = strnlen(link, ocfs2_fast_symlink_chars(inode->i_sb));
     kaddr = kmap_atomic(page);
     memcpy(kaddr, link, len + 1);

and notice how this time at least the comment is (hopefully) correct.
But the code is wrong once again, because it doesn't actually do the
correct pattern I showed above, it does a "memcpy(len+1)" instead.
Bzzt. WRONG!

What I think the code *wants* to do is

     kaddr = kmap_atomic(page);
     copy_string(
             // destination and destination size limit
             kaddr, PAGE_SIZE,
             // source and source size limit
             link, ocfs2_fast_symlink_chars(inode->i_sb)
     );

ie the destination has one size, and the source has another size, and
the source may or may not be NUL-terminated.

And then the programmer wouldn't have needed the comment, and wouldn't
have needed to make sure that yes, ocfs2_fast_symlink_chars() is
guaranteed to be less than PAGE_SIZE.

Again, the code we actually _have_ in the kernel is not sensible. It
doesn't actually nul-terminate the destination, despite clearly
_trying_ to (note that "len+1" in the memcpy).

Now, it's possible that it doesn't care about properly nul-terminating
things. And it's possible; that the source is always nul-terminated to
begin with unless the filesystem is corrupted. But the code clearly
_tries_ to do something, and fails.

Because copying a string is complicated, particularly when the
allocations for source and destination may be entirely different.

On a happier note, I actually found a correct code case too. Our
"kstrndup()" function seems to actually be at a first glance entirely
bug-free, and actually takes a limited source string size, and gives
you back a nul-terminated destination string of a different size. Of
course, that's a simple case, because the size of the destination is
something that that function actually controls, so getting it right is
actually somewhat simpler.

                Linus
