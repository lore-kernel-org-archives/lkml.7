Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3118C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C4A216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1jlEv+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfHTDPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:15:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56242 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfHTDPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:15:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id f72so1246344wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 20:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7pEz/mR885Taa0HQdSYyi+vy4Iw51smBsh3WTJyedOw=;
        b=U1jlEv+rIFTTstDRBwIEoGqTgrD45FhvGzyIMEsdvRzHezzDHoJxt+KZjIaN8foV6C
         PDj+JQd4Na9tvU5ifkiUeCfXMhi8cBR33rjszrFKZKssXU1wQL2BEOb0BNmUdvTVKCgT
         6E2m7yz5bPkgQtM+7oZbsN8l4a4o4Waz39jxOjtnZAOi7VOZywSueWL2y2iNs5glbEP4
         e2TzVXUwJ/06gWnC7soxIat0LCiBmnroUnJjQWtSZMigXFtwnJPzIu9mqQm4PPRrb+zD
         3wn0Oossx+TS3eLtb/Ij84UsuGOBzNWQA3VTVpIEh1Wa2rGTfeAbSu/oCxm3HWVBVZWS
         IQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7pEz/mR885Taa0HQdSYyi+vy4Iw51smBsh3WTJyedOw=;
        b=Ysl3I7X6MG1twzfT5vmp1dlevbpTblfNhUGVL9OCi+ZrWZE8WqyNzyxdQWV4KnAW2p
         IVqNKezxtEGl++gVGwVIYzDXmJdfCmrYrxnYWNbuz9VD0FfyH7DHhdTrYKYwaYehiUuC
         aNPOW4hO+iwVCL1RptvUS3o3VIJJ6fowV3vSZvRvcg8hzz5srsVG9OHM6Iely55pO0d1
         l0cpsD5ZI+TSgb4XPdsdyGotgx4ewavw/aI0OqAXBugchhEiKEEHrSv/C2MVDjws4iU4
         zo1B+Q0Y6SDkt0UCdPFHfkE5oWcfGf2J5tp0dYEWwK6+Hkp2r9QqyJBSWx2JT0j9Ux/J
         EPNQ==
X-Gm-Message-State: APjAAAVObWqdozZDO0zEkQ1yAeRHFd3xKRnB1LmGUfhMVmMevyOR2lwg
        t24tWhcn1kGWlIH+d5oUucE=
X-Google-Smtp-Source: APXvYqzWwWuQcQkzT9jKY09rQLsUL79FaHwhNJesYyqzFa3UsHkj69Rf3jVuX1For+jGJHU+T/K1yw==
X-Received: by 2002:a1c:2582:: with SMTP id l124mr24669519wml.153.1566270940665;
        Mon, 19 Aug 2019 20:15:40 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id a141sm1292983wmd.0.2019.08.19.20.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 20:15:40 -0700 (PDT)
Date:   Mon, 19 Aug 2019 20:15:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Don't add -mabi= flags when building with Clang
Message-ID: <20190820031538.GC30221@archlinux-threadripper>
References: <20190818191321.58185-1-natechancellor@gmail.com>
 <20190819091930.GZ31406@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819091930.GZ31406@gate.crashing.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 04:19:31AM -0500, Segher Boessenkool wrote:
> On Sun, Aug 18, 2019 at 12:13:21PM -0700, Nathan Chancellor wrote:
> > When building pseries_defconfig, building vdso32 errors out:
> > 
> >   error: unknown target ABI 'elfv1'
> > 
> > Commit 4dc831aa8813 ("powerpc: Fix compiling a BE kernel with a
> > powerpc64le toolchain") added these flags to fix building GCC but
> > clang is multitargeted and does not need these flags. The ABI is
> > properly set based on the target triple, which is derived from
> > CROSS_COMPILE.
> 
> You mean that LLVM does not *allow* you to select a different ABI, or
> different ABI options, you always have to use the default.  (Everything
> else you say is true for GCC as well).

I need to improve the wording of the commit message as it is really that
clang does not allow a different ABI to be selected for 32-bit PowerPC,
as the setABI function is not overridden and it defaults to false.

https://github.com/llvm/llvm-project/blob/llvmorg-9.0.0-rc2/clang/include/clang/Basic/TargetInfo.h#L1073-L1078

https://github.com/llvm/llvm-project/blob/llvmorg-9.0.0-rc2/clang/lib/Basic/Targets/PPC.h#L327-L365

GCC appears to just silently ignores this flag (I think it is the
SUBSUBTARGET_OVERRIDE_OPTIONS macro in gcc/config/rs6000/linux64.h).

It can be changed for 64-bit PowerPC it seems but it doesn't need to be
with clang because everything is set properly internally (I'll find a
better way to clearly word that as I am sure I'm not quite getting that
subtlety right).

> (-mabi= does not set a "target ABI", fwiw, it is more subtle; please see
> the documentation.  Unless LLVM is incompatible in that respect as well?)

Are you referring to the error message? I suppose I could file an LLVM
bug report on that but that message applies to all of the '-mabi='
options, which may refer to a target ABI.

Cheers,
Nathan
