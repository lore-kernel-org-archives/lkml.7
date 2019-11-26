Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309DEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66AE207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxyqyGit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfKZQhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:37:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45889 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfKZQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:37:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id z10so23167622wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 08:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qdnma+f9GLYVfT3ZkMgoemWBrPr+FJbwRC3ObQWrAI4=;
        b=IxyqyGit34QSBpbNyeKY4OXYTXtwmPm0MlEXQ+AtQqnMqQYmUGldxV04tJUvsmxGHs
         UECCcX063oV/1OJz0nyoL5Y1dXFGrl8ighIZzbUg4Q2LZWICWdv8IEZxVBgX+aeAF/RM
         9PHgaOAbExOYYtTNm2PxqeA827jv1amNmHvCLqIM1WpOgEnjOQBdbclxveA1moT0fcWX
         cDjP25GO8Kq5TwYJpnRA/kLWtLabt637TjTjKc4Bv3wSIuxcXrOtQRTshawGJxgS8kbM
         zyTGakYgMdZOrfYLrgC96loXdT8gjuUv9mBJm57x1pVRKOtlY4eW/rAweKIpZtbxtH1F
         uCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qdnma+f9GLYVfT3ZkMgoemWBrPr+FJbwRC3ObQWrAI4=;
        b=JWnyJl+/VHpX1Rlkb9TLzVg9ZI2qszDP0Ti+Kop7ROOK9J95JCbZo+yZoayDbg42rf
         0CWW1uKaKDDI3lYAG7GMa8CsLrbELOPT2TpvJbmaCxygHufm+uacogU7OYUZwi41Tjh3
         ReNt8AnGPsvY+rg3dFhgeBQFbTq0LNBwFKclf05olESsk7N+Aa4UihiwWi8hhtJkEIca
         itUV2t62up+gwuUbCC9LFVFcqWMhS6gdZiVSKl+6KnO+CVEEo3XHkYe+LWNFMejGLv0U
         epp6VEsj5swl47zMTKUbvaUeB2HxwDjyvOtzI0sDVh7P/9HVk8765V3ltfAD/G9/3Nz9
         F0Ow==
X-Gm-Message-State: APjAAAWg94iqdjDQ2tw7rs9NWjyhAQFrERVzzo7/mEM5AggXcCELv3sP
        wUjQn/9CgtwYExG1Wl70res=
X-Google-Smtp-Source: APXvYqyhWitzl/4JGR/5dSN2cqQtst53XhLt+nKzdxY8EzCb/tZ3HxZHVN9i02qT/deo4jvIK2cVow==
X-Received: by 2002:a05:6000:104c:: with SMTP id c12mr8582071wrx.212.1574786266079;
        Tue, 26 Nov 2019 08:37:46 -0800 (PST)
Received: from ltop.local ([2a02:a03f:404e:f500:a8f1:829f:a49c:3403])
        by smtp.gmail.com with ESMTPSA id m3sm512628wrs.53.2019.11.26.08.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 08:37:45 -0800 (PST)
Date:   Tue, 26 Nov 2019 17:37:43 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: add __percpu to SHIFT_PERCPU_PTR
Message-ID: <20191126163743.u4cxecg4chvcvtau@ltop.local>
References: <20191015102615.11430-1-ben.dooks@codethink.co.uk>
 <20191017181301.GA32546@dennisz-mbp.dhcp.thefacebook.com>
 <20191125224119.GA37611@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125224119.GA37611@dennisz-mbp.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 05:41:19PM -0500, Dennis Zhou wrote:
> On Thu, Oct 17, 2019 at 02:13:01PM -0400, Dennis Zhou wrote:
> > On Tue, Oct 15, 2019 at 11:26:15AM +0100, Ben Dooks wrote:
> > > The SHIFT_PERCPU_PTR() returns a pointer used by a number
> > > of functions that expect the pointer to be __percpu annotated
> > > (sparse address space 3). Adding __percpu to this makes the
> > > following sparse warnings go away.
> > > 
> > > Note, this then creates the problem the __percup is marked
> > > as noderef, which may need removing for some of the internal
> > > functions, or to remove other warnings.
> > > 
> > > diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
> > > index a6fabd865211..a49b6c702598 100644
> > > --- a/include/linux/percpu-defs.h
> > > +++ b/include/linux/percpu-defs.h
> > > @@ -229,7 +229,7 @@ do {									\
> > >   * pointer value.  The weird cast keeps both GCC and sparse happy.
> > >   */
> > >  #define SHIFT_PERCPU_PTR(__p, __offset)					\
> > > -	RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
> > > +	RELOC_HIDE((typeof(*(__p)) __kernel __percpu __force *)(__p), (__offset))
> > >  
> > >  #define per_cpu_ptr(ptr, cpu)						\
> > >  ({									\
> > > -- 
> > > 2.23.0
> > > 
> 
> Hi Ben,
> 
> I've reverted this commit. After spending a little more time on it, I
> don't think this is the fix we want because after we call RELOC_HIDE,
> we are shifting from __percpu to __kernel address spaces as we're adding
> the offset here.

I agree. SHIFT_PERCPU_PTR()'s type is as designed.
Also, it should be noted that this warning doesn't exist on x86.

The problem lies in include/asm-generic/percpu.h, in this case within:
	#define raw_cpu_generic_add_return(pcp, val)		\
	({							\
		typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));	\
								\
		*__p += val;					\
		*__p;						\
	})

There, the variable __p is declared as a __percpu pointer but:
1) the value assigned to it, the return value of raw_cpu_ptr(), is not
   a plain (__kernel) pointer.
2) the variable is dereferenced just after when a __percpu pointer
   is implicitly __noderef.
It's thus not SHIFT_PERCPU_PTR() or raw_cpu_ptr() that must have
their return type changed but the declaration of __p.

Here is a quick patch, only compile & sparse tested on mm/vmstat.c:

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index c2de013b2..757b667ca 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -74,7 +74,7 @@ do {									\
 
 #define raw_cpu_generic_add_return(pcp, val)				\
 ({									\
-	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
+	typeof(pcp) __kernel __force *__p = raw_cpu_ptr(&(pcp));	\
 									\
 	*__p += val;							\
 	*__p;								\


Note: the same problem is present in raw_cpu_generic_xchg(),
      raw_cpu_generic_cmpxchg() & raw_cpu_generic_cmpxchg_double()


I need more testing and to evaluate possible side-effects before
sending a proper patch.

Best regards,
-- Luc Van Oostenryck
