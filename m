Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87ECC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DC8206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQtIGgt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfDPQtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:49:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36950 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPQtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:49:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id f53so16934495ede.4;
        Tue, 16 Apr 2019 09:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uyzHR/KgXJwagK0XVwoEU4PU0Tkk7ULxFid0c4EhSyo=;
        b=dQtIGgt1CtydxYmEhLMrPhs+4/Qf4oXM7p/C+3XSDaM4Sjys4ZOUuwLQv3hXT18pFV
         2NkuaPnYUVJhBH/v59dnZJ2dCfntBoOQthl7hvVaV3eOUbxdqwfAW/4dXVTU/v8l11lL
         lo42lB5BV8OlW+nb4Xj2Zj0cIOttCrKr3aUo+rv5WMo1F1kJb+38+p6xtG7fkFYcbiwh
         rPOzxUOm7cBrB358ge0EelY+9m9O/zNamlNT1anuZvhgMwpO8FmW1ozXPfrvr0VFKPpe
         TBf9CaUta64hlh7gs9K8NKwZJDs/0mLKQ8ObYi3ZDLWry3e/65l3cIL45lI53VGF5wEb
         nACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uyzHR/KgXJwagK0XVwoEU4PU0Tkk7ULxFid0c4EhSyo=;
        b=McFZ+t29eSq6lGX8IEeLTcyFmpcHGaQPTSdEJGUx8ls2HknREfhiEI3CF8WTffVspQ
         mm6viI+/ZDgc3HBIGdBTncrbqsHNKe4slFJCFjqvFT2m1TyT+X82K6dov8OT6EuLqQZt
         7gSZzZZUamEr02vimxBD2A/9PMfuGlA/jyupvJiiqL9K+gv6eZUy90cclfhrG3jQfrR6
         cuvkyNanIjYVHXI7wrIOyaFnUsap9HbsPKtbgoDAFUy9SWYo2llSeSYP77EGSz0qRc2a
         BDK3QwmahmahiFkEH5e4xq5EWfNiMQ69WZvWpWDr/pDqUF3eMYy+8d7e1w77THTolkNc
         Lmrw==
X-Gm-Message-State: APjAAAV6sewp/FBwfIWiZeMyEC4tjC31GAJRQ2Ql8lo4t9nj18q9DygJ
        slU+OXfOSTFcrXWJhHWKx7g=
X-Google-Smtp-Source: APXvYqw7FwLhkIWrQP0OghxyGJGs/cLd+OiBYWrPjX47ZVwe/gjhjHEtZGdPbo5C16EKzzVdNwAuiA==
X-Received: by 2002:a17:906:eb96:: with SMTP id mh22mr21202516ejb.186.1555433351401;
        Tue, 16 Apr 2019 09:49:11 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id r16sm7237629edy.11.2019.04.16.09.49.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Apr 2019 09:49:10 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:49:08 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH 4.9 72/76] arm64: futex: Fix FUTEX_WAKE_OP atomic ops
 with non-zero result value
Message-ID: <20190416164908.GB25801@archlinux-i9>
References: <20190415183707.712011689@linuxfoundation.org>
 <20190415183729.170980546@linuxfoundation.org>
 <20190415220151.GA23056@archlinux-i9>
 <20190416091340.GA31579@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416091340.GA31579@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:13:40AM +0100, Will Deacon wrote:
> On Mon, Apr 15, 2019 at 03:01:51PM -0700, Nathan Chancellor wrote:
> > On Mon, Apr 15, 2019 at 08:44:36PM +0200, Greg Kroah-Hartman wrote:
> > > From: Will Deacon <will.deacon@arm.com>
> 
> [...]
> 
> > > @@ -53,29 +53,29 @@
> > >  static inline int
> > >  arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
> > >  {
> > > -	int oldval = 0, ret, tmp;
> > > +	int oldval, ret, tmp;
> > >  
> > >  	pagefault_disable();
> > >  
> > >  	switch (op) {
> > >  	case FUTEX_OP_SET:
> > > -		__futex_atomic_op("mov	%w0, %w4",
> > > +		__futex_atomic_op("mov	%w3, %w4",
> > >  				  ret, oldval, uaddr, tmp, oparg);
> > >  		break;
> > >  	case FUTEX_OP_ADD:
> > > -		__futex_atomic_op("add	%w0, %w1, %w4",
> > > +		__futex_atomic_op("add	%w3, %w1, %w4",
> > >  				  ret, oldval, uaddr, tmp, oparg);
> > >  		break;
> > >  	case FUTEX_OP_OR:
> > > -		__futex_atomic_op("orr	%w0, %w1, %w4",
> > > +		__futex_atomic_op("orr	%w3, %w1, %w4",
> > >  				  ret, oldval, uaddr, tmp, oparg);
> > >  		break;
> > >  	case FUTEX_OP_ANDN:
> > > -		__futex_atomic_op("and	%w0, %w1, %w4",
> > > +		__futex_atomic_op("and	%w3, %w1, %w4",
> > >  				  ret, oldval, uaddr, tmp, ~oparg);
> > >  		break;
> > >  	case FUTEX_OP_XOR:
> > > -		__futex_atomic_op("eor	%w0, %w1, %w4",
> > > +		__futex_atomic_op("eor	%w3, %w1, %w4",
> > >  				  ret, oldval, uaddr, tmp, oparg);
> > >  		break;
> > >  	default:
> > > 
> > >
> > 
> > This causes a (false) build warning with AOSP's GCC 4.9.4 (which is
> > used to build nearly all arm64 Android kernels before 4.14):
> > 
> >   CC      kernel/futex.o
> > ../kernel/futex.c: In function 'do_futex':
> > ../kernel/futex.c:1492:17: warning: 'oldval' may be used uninitialized in this function [-Wmaybe-uninitialized]
> >    return oldval == cmparg;
> >                  ^
> > In file included from ../kernel/futex.c:69:0:
> > ../arch/arm64/include/asm/futex.h:56:6: note: 'oldval' was declared here
> >   int oldval, ret, tmp;
> >       ^
> > 
> > The only reason I bring this up is Qualcomm based kernels have a Python
> > script that emulates -Werror, meaning this will be fatal for a large
> > number of kernels, when this eventually gets merged into them.
> 
> Thanks. Does restoring the initial assignment of 0 suppress the bogus
> warning? If so, please could you send a patch on top for stable (assuming
> Greg is ok with the simple change for this)?
> 
> Will

Yes, it does and I sure can. Greg, let me know if that is okay.
