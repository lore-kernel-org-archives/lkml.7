Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1E8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480172087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JndfyBpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfCMNow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:44:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39531 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCMNow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:44:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id p27so1558081edc.6;
        Wed, 13 Mar 2019 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xCrZ11yOtG8QPfE2HPpjToUUNBz0tmsHnDhPpk0RrFw=;
        b=JndfyBpOpO7mw96jMujoAMZEEmi1z+gnB3Tu8xfWNYjiuLi6MjFevP0MUU6Fz22iz0
         t7uTin20+dlrUzw60kmUqtgvhHdAuYfjnFDA05TKwLgvfktlAsZcBNf3R/ZE+whZidF+
         VNFH16mwbGgFOWHlkUEDoz3OSJOb3yxrBxn1g3YeAE2UD5kNZ3Qm+jsGfgGuvOmZjipt
         KTjrTvIuwu62PWE9oAFG1j06AVGJz+y6WPXgJ51Sz58TnEsQJfNEAXz5u6IHKHkxwDOe
         +tDA0lJvCo4mSIhgQ+oV7pshI4hswOlAEDaCED2d7AipH9GZoDmvHlSKutpTpUngNTvh
         SsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xCrZ11yOtG8QPfE2HPpjToUUNBz0tmsHnDhPpk0RrFw=;
        b=hOXjFBbJkZkeXvR8GHUzWvDthzOYAdbwBLert44lK1dh6ZZl+fnUOJd6vjHpkoTHuz
         BsXhEM0kLSVJR2Fe1hrpJ1eBK9HLV7je0jZv22zk7qEiptg1Ke1LerNnsrsGGQUmL77X
         XxLdhELnsZHOI3zEAWZqwU4iH2XKW0Y+jgfTUyQoHEwHcmUZfRtoj2Lwt+6hEMY4BKmS
         S2gOe4UQXZhVWbZQQ3bkrZ3v4rZp7QF8jYH4CfWySvBe8afjM8RDrte/DZh6Vwzl+lp9
         AZo0GVraFxxwUVfFhQQBtsMCsqeoouxpZESAY84K9lZWLdrm8eSkDa49CvpSL47dIIJT
         i84g==
X-Gm-Message-State: APjAAAXyVzjFQ5oeSqdh4YwUbdueKzRF+81NGh0PNiLwiPKr2VSmRSeh
        rACm4ad3zk0xgctRFS+9IOY=
X-Google-Smtp-Source: APXvYqxq5cxIArdoYFVirpt+py4JxRmGlbwJk3Vh4/j3HYspiikIEehTkFQikKdYtMP3LXG0Q+Edkg==
X-Received: by 2002:a50:b4e6:: with SMTP id x35mr7754879edd.123.1552484689889;
        Wed, 13 Mar 2019 06:44:49 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id b10sm591501edy.80.2019.03.13.06.44.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 13 Mar 2019 06:44:49 -0700 (PDT)
Date:   Wed, 13 Mar 2019 06:44:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Y Knight <jyknight@google.com>,
        clang-built-linux@googlegroups.com, stable@vger.kernel.org
Subject: Re: [PATCH] Makefile: Add '-fno-builtin-bcmp' to CLANG_FLAGS
Message-ID: <20190313134447.GA19066@archlinux-ryzen>
References: <20190312215203.27643-1-natechancellor@gmail.com>
 <80fb5b7f-42f9-4fd1-00cf-bfa7965ff8f7@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80fb5b7f-42f9-4fd1-00cf-bfa7965ff8f7@rasmusvillemoes.dk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 09:13:11AM +0100, Rasmus Villemoes wrote:
> On 12/03/2019 22.52, Nathan Chancellor wrote:
> > After LLVM revision r355672 [1], all known working kernel configurations
> > fail to link [2]:
> > 
> > ld: init/do_mounts.o: in function `prepare_namespace':
> > do_mounts.c:(.init.text+0x5ca): undefined reference to `bcmp'
> > ld: do_mounts.c:(.init.text+0x5e6): undefined reference to `bcmp'
> > ld: init/initramfs.o: in function `do_header':
> > initramfs.c:(.init.text+0x6e0): undefined reference to `bcmp'
> > ld: initramfs.c:(.init.text+0x6f8): undefined reference to `bcmp'
> > ld: arch/x86/kernel/setup.o: in function `setup_arch':
> > setup.c:(.init.text+0x21d): undefined reference to `bcmp'
> > 
> > Commit 6edfba1b33c7 ("[PATCH] x86_64: Don't define string functions to
> > builtin") removed '-ffreestanding' globally and the kernel doesn't
> > provide a bcmp definition so the linker cannot find a reference to it.
> >
> 
> > Fix this by explicitly telling LLVM through Clang not to emit bcmp
> > references. This flag does not need to be behind 'cc-option' because all
> > working versions of Clang support this flag.
> 
> Wouldn't it be better to just define bcmp as an alias for memcmp? They
> seem to have compatible prototypes, and then somebody might someday sit
> down and implement some word-at-a-time version of bcmp making use of the
> weaker guarantees about the return value to gain some performance. But I
> suppose that can also be done later.
> 
> Rasmus

Hi Rasmus,

Thank you much for the review, I didn't even realize this was possible :)

I'd certainly like to explore it as that is what glibc does. How would
you suggest going about it here?

Thanks,
Nathan
