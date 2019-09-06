Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C829EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9794120854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QluWeNZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406120AbfIFXnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 19:43:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43334 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406033AbfIFXnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:43:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so3900031pld.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 16:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zo5YswUAz6JsJFVtIEd53vHJMhrVmB8v1kbjcYdOKCQ=;
        b=QluWeNZeNy7EH782UDhVcTdZvd8NAM/qrdYZSCCSRfgWUdGBBv9IdaKMnhr2fN7Ax0
         fjbP+fflks+czLRgkGwYZwhk/PnwkfMbr+bdbQGOEnNoR2YILTom8pgDBp5QCNDS8Kn/
         hVHLqv6o8O6hX+dnDmf4GYeOWfH0WtuwtE5iq5FKCwHVj4hD4owTcuNQ+vTmQ/OxRuHA
         G9aobEQ82itoSEk4fYqhXPq/NiIx5mEwlt3dzNNDzHjmYEAchtGb4eSplS3RAav7k0Ni
         vgC+BeeKEweRvkpiz2BMDH+fKTYnO8xNsYU4EFKvcs6l5CkbJs1CHpq6qOnJSNLL83jG
         QKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zo5YswUAz6JsJFVtIEd53vHJMhrVmB8v1kbjcYdOKCQ=;
        b=QgbdYPTwH0mj/KHBehXDFafMXpgYgz8A0xVCB+PpanUeceVJ+uUbr49PSdDTZSwgUV
         ITT4nUTUD7VR2tL4PXY1gMKhSHZZt3jyqyXp0dZNxaOOlomllEL2p3g+GUsPtb2yCOCS
         Pc5yw6jqkQOD7NkL+yQOJzq+dsFKMEJNcubahPZHEZpxRTNFyV20Arof3AJC+TW7rGyF
         mFYXyDmK80LClFpSiaIaTN3+dHcrd0+ioCzjsYWKPZviRL+reiF96bNW6lCF6DezQyvL
         BZjMG/VHhGXq0PvWwxj142pFSShuaFtatFJ0l1pvJsaGrd5cHHkTnHPuqHVaDm3G8RwB
         ivPQ==
X-Gm-Message-State: APjAAAXwoVHHT6bhBtslDc1mcgQchirQvJenFqMfDHZ/kyVoeKvnUGX1
        4JTGtBMSaDiQmdYUMZR0c98YB4FdFEiXW67nmmNS+g==
X-Google-Smtp-Source: APXvYqwO41Gqd79ex/w/lXAZu864/bYFJcXkmP0tYZgcqvD1GRVyRgqPFBaUcvTaT6Ggf+LJGpcGYaTpbpvrn+HMKys=
X-Received: by 2002:a17:902:7296:: with SMTP id d22mr11780120pll.179.1567813390944;
 Fri, 06 Sep 2019 16:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <a5085133-33da-6c13-6953-d18cbc6ad3f5@rasmusvillemoes.dk>
 <20190905134535.GP9749@gate.crashing.org> <CANiq72nXXBgwKcs36R+uau2o1YypfSFKAYWV2xmcRZgz8LRQww@mail.gmail.com>
 <20190906122349.GZ9749@gate.crashing.org> <CANiq72=3Vz-_6ctEzDQgTA44jmfSn_XZTS8wP1GHgm31Xm8ECw@mail.gmail.com>
 <20190906163028.GC9749@gate.crashing.org> <20190906163918.GJ2120@tucnak>
 <CAKwvOd=MT_=U250tR+t0jTtj7SxKJjnEZ1FmR3ir_PHjcXFLVw@mail.gmail.com>
 <20190906220347.GD9749@gate.crashing.org> <CAKwvOdnWBV35SCRHwMwXf+nrFc+D1E7BfRddb20zoyVJSdecCA@mail.gmail.com>
 <20190906225606.GF9749@gate.crashing.org>
In-Reply-To: <20190906225606.GF9749@gate.crashing.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Sep 2019 16:42:58 -0700
Message-ID: <CAKwvOdk-AQVJnD6-=Z0eUQ6KPvDp2eS2zUV=-oL2K2JBCYaOeQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 3:56 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Fri, Sep 06, 2019 at 03:35:02PM -0700, Nick Desaulniers wrote:
> > On Fri, Sep 6, 2019 at 3:03 PM Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > > And if instead you tested whether the actual feature you need works a=
s
> > > you need it to, it would even work fine if there was a bug we fixed t=
hat
> > > breaks things for the kernel.  Without needing a new compiler.
> >
> > That assumes a feature is broken out of the gate and is putting the
> > cart before the horse.  If a feature is available, it should work.
>
> GCC currently has 91696 bug reports.

Fair.

>
> > > Or as another example, if we added support for some other flags. (x86
> > > has only a few flags; many other archs have many more, and in some ca=
ses
> > > newer hardware actually has more flags than older).
> >
> > I think compiler flags are orthogonal to GNU C extensions we're discuss=
ing here.
>
> No, I am talking exactly about what you brought up.  The flags output
> for inline assembler, using the =3D@ syntax.  If I had implemented that
> for Power when it first came up, I would by now have had to add support
> for another flag (the CA32 flag).  Oh, and I would not have implemented
> support for OV or SO at all originally, but perhaps they are useful, so
> let's add that as well.  And there is OV32 now as well.

Oh, I misunderstood.  I see your point.  Define the symbol as a number
for what level of output flags you support (ie. the __cplusplus
macro).

>
> > > With the "macro" scheme we would need to add new macros in all these
> > > cases.  And since those are target-specific macros, that quickly expa=
nds
> > > beyond reasonable bounds.
> >
> > I don't think so.  Can you show me an example codebase that proves me w=
rong?
>
> No, of course not, because we aren't silly enough to implement something
> like that.

I still don't think feature detection is worse than version detection
(until you find your feature broken in a way that forces the use of
version detection).

Just to prove my point about version checks being brittle, it looks
like Rasmus' version check isn't even right.  GCC supported `asm
inline` back in the 8.3 release, not 9.1 as in this patch:
https://godbolt.org/z/1woitS .  So users of gcc-8.2 and gcc-8.3
wouldn't be able to take advantage of `asm inline` even though their
compiler supported it.

Or was it "broken" until 9.1?  Lord knows, as `asm inline` wasn't in
any release notes or bug reports I can find:
8: https://gcc.gnu.org/gcc-8/changes.html
9: https://gcc.gnu.org/gcc-9/changes.html
Bug tracker query:
https://gcc.gnu.org/bugzilla/buglist.cgi?bug_status=3DUNCONFIRMED&bug_statu=
s=3DNEW&bug_status=3DASSIGNED&bug_status=3DSUSPENDED&bug_status=3DWAITING&b=
ug_status=3DREOPENED&cf_known_to_fail_type=3Dallwords&cf_known_to_work_type=
=3Dallwords&query_format=3Dadvanced&short_desc=3Dasm%20inline&short_desc_ty=
pe=3Danywordssubstr

Ah, here it is:
https://github.com/gcc-mirror/gcc/commit/6de46ad5326fc5e6b730a2feb8c62d09c1=
561f92
Which looks like the qualifier was added to this page:
https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html

I like many of the GNU C extensions, and I want to help support them
in Clang so that they can be used in more places, but the current
process (and questions I have when I implement some of them) leaves me
with the sense that there's probably room for improvement on some of
these things before they go out the door.

Segher, next time there's discussion about new C extensions for the
kernel, can you please include me in the discussions?
--=20
Thanks,
~Nick Desaulniers
