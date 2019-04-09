Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991E4C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AE62084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSvo5iSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfDIQaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:30:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40388 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfDIQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:30:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id h22so15531603edw.7;
        Tue, 09 Apr 2019 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hzwlE548oHwmQvi7KHwntG9Pp/EUNoag5IWtMq7QI10=;
        b=KSvo5iSVAJKQsySQlK8CvClsQq+jejyRdfqQUeuLFMFOUaawroJGnvQa8Wy6scPt7z
         jELKnNGZhg55clkBNykfXLrBtEG3XTYUqBvEVMTLl4X+EOcX1ljGOqL8dIEQ3rD4tEwh
         uBnwLy1WNmouB0vKio583SWUC8kqAn2cCAUVnnHscu+I49nFi+nKVu83gaGy2rdT3nyB
         RfOi3fL9r/6PclkVYymdbEJLmSFJ5j5ox+6dWNh36jmHOGVa/4Ub/kgK/Dn6xP9CdNSG
         iFFj/4dsWr6yCPlGUw+b6CMhZuG3tTCQzfdTsW8oYiraCEI5gv6f0brI5qvi2yk9amQP
         MSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hzwlE548oHwmQvi7KHwntG9Pp/EUNoag5IWtMq7QI10=;
        b=nrWfxi58oIriCNBBvY7FAstnIPFGCUtGNO8bk1grCi5XMUBA7x9vwPVOcvMFggCxaZ
         VFQnl6srgPk2Ud0cwGGOOkbnC2W371xs4Sqeg1V7xrbUgOXzXB6dqPkeWwLYMhX4Czbp
         XJdSyC2qgV17YsWK0CuPg/YDf0PznZJLuc8Ew55ZDrGN3PyskLA4WD3qxUGf8GkOxMY7
         XK8iGf74hZx4GuRWDTSHpWomykgrVnWTxbY3hE6tWrQpQGl7dEo8CO0FzkMCpJZElyUF
         HoIHQ80JbkpgEJT7Vk2c7BLTh08m16e7y0qnnItJwbd3fLLlCXbKujgXYdgbblFzCKhZ
         pkLA==
X-Gm-Message-State: APjAAAUnmlV+QY6ELwC3VfLkK27KCpFlFcbKZbufe1HBAdPASjEMwGa8
        CxcWsS7CxWzFLF8RCCrBJZs=
X-Google-Smtp-Source: APXvYqyAmiFmo66dxw/cEmEsxFaDJQJrOVPQUtKRipbrq1ZK2Lz1nyiBNT+2zAwTcSJB9MHyzdceeg==
X-Received: by 2002:a50:9856:: with SMTP id h22mr24412225edb.186.1554827453133;
        Tue, 09 Apr 2019 09:30:53 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id m25sm2294450eja.10.2019.04.09.09.30.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Apr 2019 09:30:51 -0700 (PDT)
Date:   Tue, 9 Apr 2019 09:30:49 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/12] s390: purgatory: pass --target option to clang
Message-ID: <20190409163049.GA2046@archlinux-i9>
References: <20190408212648.2407234-1-arnd@arndb.de>
 <20190408212648.2407234-3-arnd@arndb.de>
 <20190408220312.GA18333@archlinux-i9>
 <CAK8P3a39NqQOp+0=WYuWh0UmpH=kEFLKyymNYm8DH-0gx9XaaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a39NqQOp+0=WYuWh0UmpH=kEFLKyymNYm8DH-0gx9XaaQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 08:43:09AM +0200, Arnd Bergmann wrote:
> On Tue, Apr 9, 2019 at 12:03 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Mon, Apr 08, 2019 at 11:26:16PM +0200, Arnd Bergmann wrote:
> > > The purgatory Makefile does not inherit the original cflags,
> > > so clang falls back to the default target architecture when
> > > building it, typically this would be x86 when cross-compiling.
> > >
> > > Pass --target=s390x-linux to all compilers that understand
> > > this option.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  arch/s390/purgatory/Makefile | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
> > > index ce6a3f75065b..3a14b968cec3 100644
> > > --- a/arch/s390/purgatory/Makefile
> > > +++ b/arch/s390/purgatory/Makefile
> > > @@ -22,6 +22,7 @@ KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
> > >  KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
> > >  KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
> > >  KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
> > > +KBUILD_CFLAGS += $(call cc-option,--target=s390x-linux)
> > >  KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
> > >  KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
> > >
> > Would
> >
> > ifdef CONFIG_CC_IS_CLANG
> > KBUILD_CFLAGS += --target=s390x-linux
> > endif
> >
> > be a little clearer (and save a cc-option call)?
> 
> Fine with me as well. Actually I noticed later that we need the same
> thing for arch/s390/boot/Makefile and arch/s390/boot/compressed/Makefile
> in some form, so maybe we should drop this one for now and find
> a solution that works for all three of them. The boot stuff is the one
> patch I did not send, since I did not think I had a good solution there,
> just one that happened to make it build.
> 

It did just occur to me that we added the --target and --gcc-toolchain
flags to a clang specific variable, CLANG_FLAGS, that has already been
used by powerpc in commit 813af51f5d30 ("powerpc/boot: Set target when
cross-compiling for clang"). I assume that could be used here?

Nathan

> > Otherwise, makes sense.
> >
> > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> 
>  Thanks,
> 
>        Arnd
