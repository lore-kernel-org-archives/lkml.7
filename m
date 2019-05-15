Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA69C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC0D20818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zc5yKj+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfEOSyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:54:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42442 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfEOSyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:54:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id 13so422872pfw.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cVT78IJCPLcdHpZlSy9CyLIzWuA4kiJHvORERAjYKNc=;
        b=Zc5yKj+dzdGHFwrngtPNulmpvTFAQiHjt9r4AYVjVxzTElNtgApgpWhJ69oyErsVd/
         SL6/CpWLrQnuDXlH5lHrllGvcSB74n8b3lFpQqYX8jZ+GJySoUlOPDyDVFg+97SC1cfn
         qfJDIXQcz41/uwxGvI+J4DP8gCDoncjP7L0Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cVT78IJCPLcdHpZlSy9CyLIzWuA4kiJHvORERAjYKNc=;
        b=LZbwrNEN8Slm+b0fzglfLqrzh8lAE+W7zEzB7C5ipukNYcPy2FeyXqZKT80cNhKSY/
         rM2iSlClrhobZeLTjVld/Oc7lSqow4P4aSKDtTMYrOnogDT9aP9PlWyv5Vyz1SOBnySL
         D0mX28j2P4x5eba5k4OYKGrLXwOXGsPvdvdADtUqZkpV2ZVIRxo6C1D/aBqmCqrkiNBN
         h4E4tvqJ372+8nvKQQHulh0TzBBE5HSbHbhiOHPvz3XT7E1uETMseq9DyVN2AzSHNoih
         r+4P85xwerl1u9FVNsVRRKWaguKTuCrgxcklHyhJR1YJEm3fZAprAWfGk0YggbWGoWXi
         vqOA==
X-Gm-Message-State: APjAAAWwbc1BfjYTCSVM0vqhXm9nxD2cjUDzJEcwGXFPkVnFh4QY/3I/
        lTLKW+8PMKs1MeLdB3dSjIsJXA==
X-Google-Smtp-Source: APXvYqym1OlHCaQXFvNtmnzGauqy8sKNI0kjPsnJWKJrQtFLfhWkyVT7Bmi5gT77VdOHaSNljPGc7A==
X-Received: by 2002:a63:e417:: with SMTP id a23mr44303130pgi.224.1557946482723;
        Wed, 15 May 2019 11:54:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f28sm6573303pfk.104.2019.05.15.11.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 11:54:41 -0700 (PDT)
Date:   Wed, 15 May 2019 11:54:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     Borislav Petkov <bp@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/build: Move _etext to actual end of .text
Message-ID: <201905151151.D4EA0FF7@keescook>
References: <20190423183827.GA4012@beast>
 <20190514120416.GA11736@probook>
 <201905140842.21066115C5@keescook>
 <20190514161051.GA21695@probook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514161051.GA21695@probook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 06:10:55PM +0200, Johannes Hirte wrote:
> On 2019 Mai 14, Kees Cook wrote:
> > On Tue, May 14, 2019 at 02:04:21PM +0200, Johannes Hirte wrote:
> > > This breaks the build on my system:
> > > 
> > >   RELOCS  arch/x86/boot/compressed/vmlinux.relocs
> > >   CC      arch/x86/boot/compressed/early_serial_console.o
> > >   CC      arch/x86/boot/compressed/kaslr.o
> > >   AS      arch/x86/boot/compressed/mem_encrypt.o
> > >   CC      arch/x86/boot/compressed/kaslr_64.o
> > > Invalid absolute R_X86_64_32S relocation: _etext
> > > make[2]: *** [arch/x86/boot/compressed/Makefile:130: arch/x86/boot/compressed/vmlinux.relocs] Error 1
> > > make[2]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
> > > make[2]: *** Waiting for unfinished jobs....
> > > make[1]: *** [arch/x86/boot/Makefile:112: arch/x86/boot/compressed/vmlinux] Error 2
> > > make: *** [arch/x86/Makefile:283: bzImage] Error 2
> > 
> > Interesting! Can you send along your .config and compiler details?
> 
> Tested with gcc-8.3 and gcc-9.1, both the same result.
> [...]
> gcc version 8.3.0 (Gentoo 8.3.0-r1 p1.1)

Hm, I'm not able to reproduce this with any of the compilers I have
access to. The most recent I have is:

gcc (Ubuntu 20180425-1ubuntu1) 9.0.0 20180425 (experimental) [trunk revision 259645]

Various stupid questions: did you wipe the whole bulid tree and start
clean? Is this specific to Gentoo's compiler package?

I'll see if I can spin up a Gentoo image...

-- 
Kees Cook
