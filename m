Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673C3C3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBD9214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyOw9ueU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfH1C0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 22:26:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46355 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfH1C0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 22:26:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id m3so506338pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 19:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=tmS2mj3RDHe/s39Essdscd5laSqvRE7R4IrNZ/gvifA=;
        b=RyOw9ueUKkbk6TrWRbwEFwcNS4LFrn375b4GoVirycvZxUNH/vhGayI9fepPDdP7Kh
         2fiiR6e1rv5ckSB8GNLLifUDyOFLHZejQ/TN5cB0MFA5YoD/G3io3ym79OTgjod2nSbE
         x3tgzVpk81adzHhexE6oD2pWtbLjA0OkLt/8TmOiVKDgkAJ5xeeVv4MLL4+nh2vXpM0A
         WH4qBRWYSLSLInvy0i+N68gTCLMKrQQy4xBcExIYB5DjzTsw9QtpcBO0/6HRYKSfIF3u
         obP0ByZRjGK/VSGHMpqEzxwoAABKiASYOCy/jA2Nc20qWYwP+gJi8FruYrS44CdmeYfc
         XObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=tmS2mj3RDHe/s39Essdscd5laSqvRE7R4IrNZ/gvifA=;
        b=T6a6SDFAzIihJhhqg//O77y5Ug3DD5pcOlPFkwEUyb+C1MWeos614sROaYiFn8YMxj
         KfP0ilOZyoF/++VwBc5MjIX3W2QYDVmWcEMudt8btbxQQeYEsrKQkSC44up/nhPqFoWP
         dljtgWeTwluSGmovlxO5qjaWSsXe0zRiWoEVAaETM4e5CLBSMi2s4nfvVWK9egJ12SQA
         8X1Xrrzp0Nja3yKOU9pJjIWUd1q8Jk/m5fhcV0woc1aRyrK5g9Z92ObQBeGuq0YLEMIA
         fUFpbaJHxPnYYDBlT/6ENqOkRkoVPrm/CM+r5ovLQD9Pz7yKXRCynvd8/YyUb6tgrY7s
         Q2og==
X-Gm-Message-State: APjAAAVxCRqCJDdTtAk7RrHGWL11yYaUB1xMysV3jBHOuQvWFxcZnBfy
        ey7juSXNdvhswJE0qj/zRV4=
X-Google-Smtp-Source: APXvYqw9m/QdgDZJzb9IfXd730676Sx51gpVpAmZEOp1AdttXC5PZBFTGnGpwy1p1d0d7uLqQEmGsw==
X-Received: by 2002:aa7:9a81:: with SMTP id w1mr1997209pfi.24.1566959189859;
        Tue, 27 Aug 2019 19:26:29 -0700 (PDT)
Received: from localhost (14-202-91-55.tpgi.com.au. [14.202.91.55])
        by smtp.gmail.com with ESMTPSA id r27sm609522pgn.25.2019.08.27.19.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 19:26:28 -0700 (PDT)
Date:   Wed, 28 Aug 2019 12:25:33 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: a bug in genksysms/CONFIG_MODVERSIONS w/ __attribute__((foo))?
To:     Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?iso-8859-1?q?Debian=0A?= kernel maintainers 
        <debian-kernel@lists.debian.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>
References: <CAKwvOdnJAApaUhTQs7w_VjSeYBQa0c-TNxRB4xPLi0Y0sOQMMQ@mail.gmail.com>
        <CAKwvOdkbY_XatVfRbZQ88p=nnrahZbvdjJ0OkU9m73G89_LRzg@mail.gmail.com>
        <1566899033.o5acyopsar.astroid@bobo.none>
        <CAK7LNARHacanVT6XjRDkFJDETWX6qHfUJCFhskCVG6aDL-bt1g@mail.gmail.com>
        <1566908344.dio7j9zb2h.astroid@bobo.none>
        <daacccf8e36132b6a747fa4b42626a8812906eaa.camel@decadent.org.uk>
In-Reply-To: <daacccf8e36132b6a747fa4b42626a8812906eaa.camel@decadent.org.uk>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1566955930.uir50f8wen.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Hutchings's on August 28, 2019 1:34 am:
> On Tue, 2019-08-27 at 22:42 +1000, Nicholas Piggin wrote:
>> Masahiro Yamada's on August 27, 2019 8:49 pm:
>> > Hi.
>> >=20
>> > On Tue, Aug 27, 2019 at 6:59 PM Nicholas Piggin <npiggin@gmail.com> wr=
ote:
>> > > Nick Desaulniers's on August 27, 2019 8:57 am:
>> > > > On Mon, Aug 26, 2019 at 2:22 PM Nick Desaulniers
>> > > > <ndesaulniers@google.com> wrote:
>> > > > > I'm looking into a linkage failure for one of our device kernels=
, and
>> > > > > it seems that genksyms isn't producing a hash value correctly fo=
r
>> > > > > aggregate definitions that contain __attribute__s like
>> > > > > __attribute__((packed)).
>> > > > >=20
>> > > > > Example:
>> > > > > $ echo 'struct foo { int bar; };' | ./scripts/genksyms/genksyms =
-d
>> > > > > Defn for struct foo =3D=3D <struct foo { int bar ; } >
>> > > > > Hash table occupancy 1/4096 =3D 0.000244141
>> > > > > $ echo 'struct __attribute__((packed)) foo { int bar; };' |
>> > > > > ./scripts/genksyms/genksyms -d
>> > > > > Hash table occupancy 0/4096 =3D 0
>> > > > >=20
>> > > > > I assume the __attribute__ part isn't being parsed correctly (lo=
oks
>> > > > > like genksyms is a lex/yacc based C parser).
>> > > > >=20
>> > > > > The issue we have in our out of tree driver (*sadface*) is basic=
ally a
>> > > > > EXPORT_SYMBOL'd function whose signature contains a packed struc=
t.
>> > > > >=20
>> > > > > Theoretically, there should be nothing wrong with exporting a fu=
nction
>> > > > > that requires packed structs, and this is just a bug in the lex/=
yacc
>> > > > > based parser, right?  I assume that not having CONFIG_MODVERSION=
S
>> > > > > coverage of packed structs in particular could lead to potential=
ly
>> > > > > not-fun bugs?  Or is using packed structs in exported function s=
ymbols
>> > > > > with CONFIG_MODVERSIONS forbidden in some documentation somewher=
e I
>> > > > > missed?
>> > > >=20
>> > > > Ah, looks like I'm late to the party:
>> > > > https://lwn.net/Articles/707520/
>> > >=20
>> > > Yeah, would be nice to do something about this.
>> >=20
>> > modversions is ugly, so it would be great if we could dump it.
>> >=20
>> > > IIRC (without re-reading it all), in theory distros would be okay
>> > > without modversions if they could just provide their own explicit
>> > > versioning. They take care about ABIs, so they can version things
>> > > carefully if they had to change.
>=20
> Debian doesn't currently have any other way of detecting ABI changes
> (other than eyeballing diffs).
>=20
> I know there have been proposals of using libabigail for this instead,
> but I'm not sure how far those progressed.
>=20
>> > We have not provided any alternative solution for this, haven't we?
>> >=20
>> > In your patch (https://lwn.net/Articles/707729/),
>> > you proposed CONFIG_MODULE_ABI_EXPLICIT.
>>=20
>> Right, that was just my first proposal, but I am not confident that I
>> understood everybody's requirements. I don't think the distro people
>> had much time to to test things out.
>>=20
>> One possible shortcoming with that patch is no per-symbol version. The=20
>> distro may break an ABI for a security fix, but they don't want to break
>> all out of tree modules if it's an obscure ABI.
>=20
> Right, for example the KVM kABI is only meant for in-tree modules (like
> kvm_intel) and in Debian we do not change the "ABI version" and require
> rebuilding out-of-tree modules just because that ABI changes.=20
> Currently we maintain explicit lists of exported symbols and exporting
> modules for which we ignore ABI changes at build time.
>=20
>> The counter argument to=20
>> that is they should just rename the symbol in their kernel for such=20
>> cases, so I didn't implement it without somebody describing a good
>> requirement.
> [...]
>=20
> Sometimes it is just a single function that changes, but often a
> structure change can affect large numbers of functions.  For example,
> if KVM adds a member to an operations struct that can indirectly change
> the ABI for most of its exported functions.  We wouldn't want to change
> the ABI version but would still want to prevent loading mismatched kvm
> and kvm_intel versions.  It would be a lot more work to change all of
> the affected function names.

You could change just a single symbol name though :)

> An alternative to symbol version matching that I think would work for
> us is: if a module's exports or imports match the "changes ignored"
> list then the module can only be loaded on the exact version of the
> kernel, otherwise it only needs to match the ABI version.  I think that
> would avoid the need for carrying symbol versions, but we would still
> need a build-time ABI check and a way of flagging which symbols need
> the tighter version match.

Just trying to think how best to express that.

[ Aside, the whole symbol name resolution linking stuff does matching on=20
  on any number of ~arbitrary strings that you can generate as you like,=20
  and symbol tables are something that all existing tools and libs=20
  understand.

  So I strongly favour using that as the back end for our "version"
  resolution system _if at all possible_ rather than adding these extra
  bits of crud that really just do the same thing. At least for a first
  pass, I don't want to over-engineer things.

  Then it hopefully becomes a matter of adding some helper macros and
  build facilities on top of that which can contain everyone's
  requirements mostly within .config and perhaps a very small patch.
  A bit more work with preprocessor macros etc is far preferable to
  linking and loading "features" IMO]

Back to your case, is it sufficient to have just an internal and an
external module version where the kernel provides both and your in-tree
modules match on the internal, others match on external?

Thanks,
Nick

=
