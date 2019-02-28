Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4389C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B4F2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoNBHfOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbfB1I4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:56:47 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41908 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfB1I4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:56:47 -0500
Received: by mail-ed1-f67.google.com with SMTP id x7so16264432eds.8;
        Thu, 28 Feb 2019 00:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hicQKjB5gtEjKViwNEvbfFoyBcT0YuKiR6ZKG3d6NKc=;
        b=NoNBHfOmma08WW1B/qcVGCwBVUN3EOCuLgjOxi/wnJcsXa3UTkP3uiShq8+dnaw3yJ
         mU5TbG6qw5AUozpXcTUpHYviwALUkVHhbmRSg6QnrYPBFQyTzpECK5e+q7aSyWCj2Mqc
         A9odwGo1IbIaq1k4XWZmTICMq+rPsyMBL9g8wXblxRUTkIqBil+tUyC29scwZMuEayUD
         u2fUTWrfP0zd4doS2qY/kS2YxvWbPfbCC17fLwXDso4QO4akrRcJwtFYT5JJK3V7V9xP
         Rfs/80M7AxFUzlubAioBuJCA+XO9MXwHXAEbeP59vDO61nvI1Ehm7wOq0+9tfwbZnFXr
         71hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hicQKjB5gtEjKViwNEvbfFoyBcT0YuKiR6ZKG3d6NKc=;
        b=XckmL5bx9wRUAPllLUHOBJDCZpGz0IroPBw4WmOlYLZD4OtUh1F2nKYh1XVg2KKpi8
         e068I6zaGgN5XzQiDalGmFKWBYhqiRhuimb0zicBy8u6J1Rc2lC0W6DRfwG7kP1oGdsZ
         LvZzhfLzEH3iPLRW3FKjyFn9Cw1/2WzngUpR2Hwd0l7X11BqEpSvzM15UUDCLXxKgvA0
         HfmshRa1JrBGEQ9bwlF0eaXKRLEhAzCuL8pQpmTBQbB5O6mpSa/JLVF8y6+1KR06ExMV
         QHh3dU+lE/33F9u8qj5VbF7yimJaYJ3HTphwpbrQeYF3IKWzcWePSl17viuEzdfZzgSV
         9wrQ==
X-Gm-Message-State: AHQUAuagkmmFOK7BUNJm3BxWr16TF8Rmc8M3o7I1O9C8Ymo4QlBiY80k
        bj2wxp5uPmRh1Ehw3lfy4AA=
X-Google-Smtp-Source: AHgI3IbptJmBjXja2ZRFj9C/AG25Z44AB5NVoh8Jm1wzepCGvCmSv3QJsi30LUg02Kcou5flr41QEw==
X-Received: by 2002:a05:6402:1690:: with SMTP id a16mr5938146edv.16.1551344204525;
        Thu, 28 Feb 2019 00:56:44 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id g24sm4953521edc.67.2019.02.28.00.56.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Feb 2019 00:56:43 -0800 (PST)
Date:   Thu, 28 Feb 2019 01:56:41 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] tmpfs: fix uninitialized return value in shmem_link
Message-ID: <20190228085641.GA7991@archlinux-ryzen>
References: <20190221222123.GC6474@magnolia>
 <alpine.LSU.2.11.1902222222570.1594@eggly.anvils>
 <CAHk-=wgO3MPjPpf_ARyW6zpwwPZtxXYQgMLbmj2bnbOLnR+6Cg@mail.gmail.com>
 <alpine.LSU.2.11.1902251214220.8973@eggly.anvils>
 <CAHk-=whP-9yPAWuJDwA6+rQ-9owuYZgmrMA9AqO3EGJVefe8vg@mail.gmail.com>
 <CAHk-=wiwAXaRXjHxasNMy5DHEMiui5XBTL3aO1i6Ja04qhY4gA@mail.gmail.com>
 <86649ee4-9794-77a3-502c-f4cd10019c36@lca.pw>
 <CAHk-=wggjLsi-1BmDHqWAJPzBvTD_-MQNo5qQ9WCuncnyWPROg@mail.gmail.com>
 <1551276580.7087.1.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1551276580.7087.1.camel@lca.pw>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 09:09:40AM -0500, Qian Cai wrote:
> On Mon, 2019-02-25 at 16:07 -0800, Linus Torvalds wrote:
> > On Mon, Feb 25, 2019 at 4:03 PM Qian Cai <cai@lca.pw> wrote:
> > > > 
> > > > Of course, that's just gcc. I have no idea what llvm ends up doing.
> > > 
> > > Clang 7.0:
> > > 
> > > # clang  -O2 -S -Wall /tmp/test.c
> > > /tmp/test.c:46:6: warning: variable 'ret' is used uninitialized whenever
> > > 'if'
> > > condition is false [-Wsometimes-uninitialized]
> > 
> > Ok, good.
> > 
> > Do we have any clang builds in any of the zero-day robot
> > infrastructure or something? Should we?
> > 
> > And maybe this was how Dan noticed the problem in the first place? Or
> > is it just because of his eagle-eyes?
> > 
> 
> BTW, even clang is able to generate warnings in your sample code, it does not
> generate any warnings when compiling the buggy shmem.o via "make CC=clang". Here

Unfortunately, scripts/Kbuild.extrawarn disables -Wuninitialized for
Clang, which also disables -Wsometimes-uninitialized:

https://github.com/ClangBuiltLinux/linux/issues/381
https://clang.llvm.org/docs/DiagnosticsReference.html#wuninitialized

I'm going to be sending out patches to fix the warnings found with it
then enable it going forward so that things like this get caught.

Nathan

> is the objdump for arm64 (with KASAN_SW_TAGS inline).
> 
> 000000000000effc <shmem_link>:
> {
>     effc:       f81c0ff7        str     x23, [sp, #-64]!
>     f000:       a90157f6        stp     x22, x21, [sp, #16]
>     f004:       a9024ff4        stp     x20, x19, [sp, #32]
>     f008:       a9037bfd        stp     x29, x30, [sp, #48]
>     f00c:       9100c3fd        add     x29, sp, #0x30
>     f010:       aa0203f3        mov     x19, x2
>     f014:       aa0103f5        mov     x21, x1
>     f018:       aa0003f4        mov     x20, x0
>     f01c:       94000000        bl      0 <_mcount>
>     f020:       91016280        add     x0, x20, #0x58
>     f024:       d2c20017        mov     x23, #0x100000000000            //
> #17592186044416
>     f028:       b2481c08        orr     x8, x0, #0xff00000000000000
>     f02c:       f2fdfff7        movk    x23, #0xefff, lsl #48
>     f030:       d344fd08        lsr     x8, x8, #4
>     f034:       38776909        ldrb    w9, [x8, x23]
>     f038:       940017d5        bl      14f8c <OUTLINED_FUNCTION_11>
>     f03c:       54000060        b.eq    f048 <shmem_link+0x4c>  // b.none
>     f040:       7103fd1f        cmp     w8, #0xff
>     f044:       54000981        b.ne    f174 <shmem_link+0x178>  // b.any
>     f048:       f9400014        ldr     x20, [x0]
>         if (inode->i_nlink) {
>     f04c:       91010280        add     x0, x20, #0x40
>     f050:       b2481c08        orr     x8, x0, #0xff00000000000000
>     f054:       d344fd08        lsr     x8, x8, #4
>     f058:       38776909        ldrb    w9, [x8, x23]
>     f05c:       940017cc        bl      14f8c <OUTLINED_FUNCTION_11>
>     f060:       54000060        b.eq    f06c <shmem_link+0x70>  // b.none
>     f064:       7103fd1f        cmp     w8, #0xff
>     f068:       540008a1        b.ne    f17c <shmem_link+0x180>  // b.any
>     f06c:       b9400008        ldr     w8, [x0]
>     f070:       34000148        cbz     w8, f098 <shmem_link+0x9c>
>     f074:       940018fd        bl      15468 <OUTLINED_FUNCTION_1124>
>                 ret = shmem_reserve_inode(inode->i_sb);
>     f078:       38776909        ldrb    w9, [x8, x23]
>     f07c:       940017c4        bl      14f8c <OUTLINED_FUNCTION_11>
>     f080:       54000060        b.eq    f08c <shmem_link+0x90>  // b.none
>     f084:       7103fd1f        cmp     w8, #0xff
>     f088:       540007e1        b.ne    f184 <shmem_link+0x188>  // b.any
>     f08c:       f9400000        ldr     x0, [x0]
>     f090:       97fffcf6        bl      e468 <shmem_reserve_inode>
>                 if (ret)
>     f094:       35000660        cbnz    w0, f160 <shmem_link+0x164>
>         dir->i_size += BOGO_DIRENT_SIZE;
>     f098:       910122a0        add     x0, x21, #0x48
>     f09c:       b2481c08        orr     x8, x0, #0xff00000000000000
>     f0a0:       d344fd09        lsr     x9, x8, #4
>     f0a4:       3877692a        ldrb    w10, [x9, x23]
>     f0a8:       94001828        bl      15148 <OUTLINED_FUNCTION_193>
>     f0ac:       54000060        b.eq    f0b8 <shmem_link+0xbc>  // b.none
>     f0b0:       7103fd1f        cmp     w8, #0xff
>     f0b4:       540006c1        b.ne    f18c <shmem_link+0x190>  // b.any
>     f0b8:       38776929        ldrb    w9, [x9, x23]
>     f0bc:       94001a4a        bl      159e4 <OUTLINED_FUNCTION_1131>
>     f0c0:       54000060        b.eq    f0cc <shmem_link+0xd0>  // b.none
>     f0c4:       7103fd1f        cmp     w8, #0xff
>     f0c8:       54000661        b.ne    f194 <shmem_link+0x198>  // b.any
>     f0cc:       f9000009        str     x9, [x0]
>         inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
>     f0d0:       aa1403e0        mov     x0, x20
>     f0d4:       910182b6        add     x22, x21, #0x60
>     f0d8:       94000000        bl      0 <current_time>
>     f0dc:       b2481ec9        orr     x9, x22, #0xff00000000000000
>     f0e0:       d344fd29        lsr     x9, x9, #4
> 
