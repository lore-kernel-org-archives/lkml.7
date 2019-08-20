Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03982C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74DC22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVijRt/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfHTR6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:58:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46547 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730006AbfHTR6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:58:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so13292660wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nL5wmWAkInloOmP6KaWDiP57TY5h/6kIVcxnHD5OgX8=;
        b=QVijRt/pnGOTOHQX6VTkjeE/TbK60axXWdIop2BpcoKc42w1qCd7cspYjzVfjYt0zS
         RYCBQ5WIs/X39vAQTeW9AAANKr5jZoLLfUBuIyX1QWXnAm/hS3DQWumiX9LiQsjeqVLq
         FAl67Zd3EOXUqJADiGNUF1lg1gdPjzFWnGHtPzVUURV4blAN+tE6PSJ+Z7cPNfkrgQ5T
         yRapVzzxr1O0N5FMUqZ+BnW88uSpH3hldsTGqR3C3mRGAlgwLMQbVaERzII+Evo2DQ43
         vSL+MNZB+kk+dNO00LZo8U8RELN/2Cm85vvf3r5NHP2WvvN02o1y3HJCCFWbsWKL/Mrm
         CiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nL5wmWAkInloOmP6KaWDiP57TY5h/6kIVcxnHD5OgX8=;
        b=ADn7LBhoiHzboj1rAZ8GVm5QgnDcLZ0AFqVCl3ChX3/Zbl9oKzLGJcC2clrY+N3A/w
         4siBNmU+DNtL0895QV7LR23hD2uuu4E9Qh0dB22OuREO2YyLpBQBzhZyCRsdsU3IOuGV
         e729t7SS07T+JQ40E6j5DnNhNxNa4wP7jTRxcsWsQh8XTBKm3gn1Bk3iySei3FS1h13I
         FXLiyUQdDB6ZMAVV5TYaOaYfJHvnHqpN/P1CMN59045Sj7A5SFCvjZu8VrdqJzHQVGRW
         DtLlQVfm24S/lHgfAXrb3WzgqzUDbGVG4WfWJzRuN8Sufq5XEVIerJxXpKeWSDr0T+G7
         oCLw==
X-Gm-Message-State: APjAAAWMyhX6cKegtuENxesrw23UALqNjoGulboiWeSdXyPpuQIrC2K4
        U44lSwA4gSaVlRTiu3ftmyZ8Hgq9AKLM/Q==
X-Google-Smtp-Source: APXvYqy4oqKEPeEW3S9YLuOzS1IhOJ4LHvsVQvdsc4W4XSrb2bZ7wF632y8yvmgoGmz5KNzgZ2IMjg==
X-Received: by 2002:adf:ecc3:: with SMTP id s3mr36531412wro.302.1566323884062;
        Tue, 20 Aug 2019 10:58:04 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id i5sm20817729wrn.48.2019.08.20.10.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:58:03 -0700 (PDT)
Date:   Tue, 20 Aug 2019 10:58:01 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Don't add -mabi= flags when building with Clang
Message-ID: <20190820175801.GA9420@archlinux-threadripper>
References: <20190818191321.58185-1-natechancellor@gmail.com>
 <20190819091930.GZ31406@gate.crashing.org>
 <20190820031538.GC30221@archlinux-threadripper>
 <20190820124033.GQ31406@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820124033.GQ31406@gate.crashing.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 07:40:33AM -0500, Segher Boessenkool wrote:
> On Mon, Aug 19, 2019 at 08:15:38PM -0700, Nathan Chancellor wrote:
> > On Mon, Aug 19, 2019 at 04:19:31AM -0500, Segher Boessenkool wrote:
> > > On Sun, Aug 18, 2019 at 12:13:21PM -0700, Nathan Chancellor wrote:
> > > > When building pseries_defconfig, building vdso32 errors out:
> > > > 
> > > >   error: unknown target ABI 'elfv1'
> > > > 
> > > > Commit 4dc831aa8813 ("powerpc: Fix compiling a BE kernel with a
> > > > powerpc64le toolchain") added these flags to fix building GCC but
> > > > clang is multitargeted and does not need these flags. The ABI is
> > > > properly set based on the target triple, which is derived from
> > > > CROSS_COMPILE.
> > > 
> > > You mean that LLVM does not *allow* you to select a different ABI, or
> > > different ABI options, you always have to use the default.  (Everything
> > > else you say is true for GCC as well).
> > 
> > I need to improve the wording of the commit message as it is really that
> > clang does not allow a different ABI to be selected for 32-bit PowerPC,
> > as the setABI function is not overridden and it defaults to false.
> 
> > GCC appears to just silently ignores this flag (I think it is the
> > SUBSUBTARGET_OVERRIDE_OPTIONS macro in gcc/config/rs6000/linux64.h).
> 
> What flag?  -mabi=elfv[12]?

Yes.

> (Only irrelevant things are ever ignored; otherwise, please do a bug
> report).

I believe that is the case here but looking at the GCC source gives me a
headache.

> > It can be changed for 64-bit PowerPC it seems but it doesn't need to be
> > with clang because everything is set properly internally (I'll find a
> > better way to clearly word that as I am sure I'm not quite getting that
> > subtlety right).
> 
> You can have elfv2 on BE, and e.g. the sysv ABI on LE.  Neither of those
> is tested a lot.
> 
> > > (-mabi= does not set a "target ABI", fwiw, it is more subtle; please see
> > > the documentation.  Unless LLVM is incompatible in that respect as well?)
> > 
> > Are you referring to the error message?
> 
> Yup.
> 
> > I suppose I could file an LLVM
> > bug report on that but that message applies to all of the '-mabi='
> > options, which may refer to a target ABI.
> 
> That depends on what you call "an ABI", I guess.  You can call any ABI
> variant a separate ABI: you'll have to rebuild all of userland.  You can
> also says ELFv1 and ELFv2 are pretty much the same thing, which is true
> as well.  The way -mabi= is defined is the latter:
> 
> '-mabi=ABI-TYPE'
>      Extend the current ABI with a particular extension, or remove such
>      extension.  Valid values are 'altivec', 'no-altivec',
>      'ibmlongdouble', 'ieeelongdouble', 'elfv1', 'elfv2'.
> 
> 
> Segher

The GCC documentation also has this description for '-mabi=elfv1' and
'-mabi=elfv2':

-mabi=elfv1:
Change the current ABI to use the ELFv1 ABI. This is the default ABI for
big-endian PowerPC 64-bit Linux. Overriding the default ABI requires
special system support and is likely to fail in spectacular ways.

-mabi=elfv2:
Change the current ABI to use the ELFv2 ABI. This is the default ABI for
little-endian PowerPC 64-bit Linux. Overriding the default ABI requires
special system support and is likely to fail in spectacular ways.

https://gcc.gnu.org/onlinedocs/gcc/RS_002f6000-and-PowerPC-Options.html#index-mabi_003delfv1

Thinking about this a little bit more, I think this patch is correct in
the case that clang is cross compiling because the target triple will
always be specified (so the default ABI doesn't need to be changed).
However, I am not sure how native compiling would be affected by this
change; in theory, if someone was on a little endian system and wanted
to build a big endian kernel, they would probably need -mabi=elfv1
like GCC would but I don't have any real way to test this nor am I sure
that anyone actually natively compiles PowerPC kernels with clang. It's
probably not worrying about at this point so I'll just move forward with
a v2 rewording the commit message.

Cheers,
Nathan
