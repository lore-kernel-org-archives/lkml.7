Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA78AC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF07C206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="FGjNcf2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfIMMcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 08:32:54 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40879 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbfIMMcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:32:53 -0400
Received: by mail-oi1-f193.google.com with SMTP id k9so1011489oib.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aEYQIpGLFGpiORmG/YphEOzgf9q35cmGzwyvDDgVdfI=;
        b=FGjNcf2SPFV0dd3loyWVFwUayH+0IxcwiJUIy6dOXzuWyTtY0y8QecA2uy4lmYKsG1
         CMqEqSrjgFPK34+KsCcAk8aFSYR8wM1rd8knXHlpm0swDLuB1bPvjezhnbLs5zn5QpnB
         vlI+rH+4JXjhYTz07jyFpa8RpZoRVt1tjWiObn43kbMbegzBrGBk7o6lf9dpRdkBXId/
         dFS2Ad/Sq9BX3cFMtQKq4Pl+71Nu3am8PKSM5oACJSWKBgn0UDqHKtTdIQNZnKlOF9Te
         wJXBmMZeG+zTcN4dtHh9Fonz2WBLnrAKY2j7oEOQcFy6uyShpUwU90dQXmQD/r9OxwIW
         C5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aEYQIpGLFGpiORmG/YphEOzgf9q35cmGzwyvDDgVdfI=;
        b=nzcxO9kB8DpdyHi1tmFgSGutrzIaCDXkaIreENlitQfZJe51ihM0r4i/7lCtWPHMma
         YblrWzpEFaai+v0sLcWuN5TPi3XXQGyLAVIMRAQ7H+euT7fTIsD28iFLqsi2JLuVLzE/
         K1pQiXqfYL0XC8vYkkWr2tje8r3p1NAftevManvcsdWnHgEyQHlZ/qvisPtiCRfu8l1v
         p8LHJDpkVY8nL37mOoNbIt+3d2208kih+hneMX5AAaYmlHjhDa3AlUvroAyLdVQBpfcR
         u5PgzWD9MLvLdkc/5zGQyRTfzbka8XCzKom2KoL8ZEPfE/1qOhQ5ifG6x++YBaKG2N+p
         fzNA==
X-Gm-Message-State: APjAAAX2fz1+UtXbqmDh8x8P6psVl2sLSbzXSPfA6EkJMwK6GVeUQfMx
        Itb5NVo/zTlY2R3WaL4vTK/lPo7QXjGIGLnjyf16CA==
X-Google-Smtp-Source: APXvYqxrUrl9/dFIzDVCWG8qUEt2wyEuoV1i+6GilTuek7dV3WXIr7fJ+wGxFimvSr6IDdYWypN2jqOJ+uGNztYms48=
X-Received: by 2002:aca:4b05:: with SMTP id y5mr1860258oia.70.1568377973003;
 Fri, 13 Sep 2019 05:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <156712993795.1616117.3781864460118989466.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156712995374.1616117.8463747608355533922.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAKv+Gu_6zkq0cfp715sn-boGD=ZVDJ-Xk7venkQb1Gry_hxoeg@mail.gmail.com>
In-Reply-To: <CAKv+Gu_6zkq0cfp715sn-boGD=ZVDJ-Xk7venkQb1Gry_hxoeg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 13 Sep 2019 05:32:41 -0700
Message-ID: <CAPcyv4jRR1aYta9bNSBKqq4Hf+CQPW9UmpkEfqxJMui129JQjQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/10] x86, efi: Push EFI_MEMMAP check into leaf routines
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 2:06 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 30 Aug 2019 at 03:06, Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > In preparation for adding another EFI_MEMMAP dependent call that needs
> > to occur before e820__memblock_setup() fixup the existing efi calls to
> > check for EFI_MEMMAP internally. This ends up being cleaner than the
> > alternative of checking EFI_MEMMAP multiple times in setup_arch().
> >
> > Cc: <x86@kernel.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> I'd prefer it if the spurious whitespace changes could be dropped, but
> otherwise, this looks fine to me, so I am not going to obsess about
> it.

Fair point, I'll drop those when I resubmit after -rc1.

> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks!
