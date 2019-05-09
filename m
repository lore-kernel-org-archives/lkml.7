Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19819C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F972085A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557429612;
	bh=JBxQ/eSrrAw2M1d34gj2YGHsDirDuGZoki6MPuJXk3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ym22G39nkCs5Is38iqrUeYayAvOjierEfXw+mhgec+F6pqZj1qDqIBkHOfra60oP8
	 7vTQ59J116G4ct4eTqcVOHIhqiyJfxtbzdyz6qJgQl7eLfKu1yQ/I2SpqVA7/vOiOY
	 QyqZO/U4/FgjSJV+Elxa76R42r1r71N/7gm1s4cM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfEITUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:20:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38078 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfEITUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 15:20:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id f2so4534294wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 12:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=anUrkM2Wj0DIh3H/cCyImXgR3XTg6/qrQOK2JnUaXZ0=;
        b=ny1Rw9YVqD2VRKJ4owxB5TLp61Ea13OgZVQ07vvZjGSQGhOk/rSkE9XX1K48IoqX0v
         uGh7efenlZA808oPPZEaLbIToBkEfj+yILrVO9fbsnzQlwgjxpCwtFcQgI/Wt+D0clCG
         Vx//zECWXzk2FIhsRChNfYhSnYq4TSrXpFffHIfLsPJJ5rkZ4FXokoN5dzEU8ClMW/YZ
         d9qH0ZGeYLkIAh/Ot98obBQMkVCP2R+uPVmUPRSg4OhZY9CA5QsCxcbiO/2z9rE6fr1P
         a2NCZZlTFRt6/zG2DotjhSvDWdgnuIVlUoW/2HEfMBB/mlu270jqLmEjJHW/nOq6tOT/
         zTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=anUrkM2Wj0DIh3H/cCyImXgR3XTg6/qrQOK2JnUaXZ0=;
        b=apwFWEDjhyJQWHTbShZz5fc9mNVBESzxmtfbBwdATSBhV21cYtBJB2te02GYkR9WTT
         jbDBhoov57/vBFkuPYGLBI63xwYaidkz97pWlBiti/28aVHUzCVjKjRrV6a3v40+R55n
         C3QfedspoLb7TFqTLDTyJMbiUdqrxZ6ftoxlvhbiWDWoyXWbuW67KiLJpUSNQ7EB4IP3
         Z9Nb6HuYItWB8K0EIBsC3sgvxEdn6UTub9i0GqT5mqVq9ADrvtyIOKh/Hz66akxQASeW
         Kbg79JBasb6rq1yQVtOHXAnoDbOJy5Jx+Za4hagwinCzJMbGUnjzXwbnzCCYr54KGIto
         +nRg==
X-Gm-Message-State: APjAAAXE4KjimXCd4/4Dnd2ATwCGERTuDEr7hEjXWu7Ae88Ca+TtxAwf
        UQwoW7Xg66VkZawZHLkwLSk=
X-Google-Smtp-Source: APXvYqwb06wxIE1QBjGN/hCp13/fXKJ6ccPFJPJT84oJc8tpkabaAkqnG92zsB1P8NeuksJ57Kngvg==
X-Received: by 2002:a1c:be16:: with SMTP id o22mr3991126wmf.1.1557429604783;
        Thu, 09 May 2019 12:20:04 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s13sm287804wmh.31.2019.05.09.12.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 12:20:03 -0700 (PDT)
Date:   Thu, 9 May 2019 21:20:01 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Yury Norov <ynorov@marvell.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Clean up the __[PHYSICAL/VIRTUAL]_MASK_SHIFT
 definitions a bit
Message-ID: <20190509192001.GA65373@gmail.com>
References: <20190508204411.13452-1-ynorov@marvell.com>
 <20190509090131.GA130570@gmail.com>
 <20190509172244.GA11274@yury-thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509172244.GA11274@yury-thinkpad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yury Norov <yury.norov@gmail.com> wrote:

> On Thu, May 09, 2019 at 11:01:31AM +0200, Ingo Molnar wrote:
> > 
> > * Yury Norov <yury.norov@gmail.com> wrote:
> > 
> > > __VIRTUAL_MASK_SHIFT is defined twice to the same valie in
> > > arch/x86/include/asm/page_32_types.h. Fix it.
> > > 
> > > Signed-off-by: Yury Norov <ynorov@marvell.com>
> > > ---
> > >  arch/x86/include/asm/page_32_types.h | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/x86/include/asm/page_32_types.h b/arch/x86/include/asm/page_32_types.h
> > > index 0d5c739eebd7..9bfac5c80d89 100644
> > > --- a/arch/x86/include/asm/page_32_types.h
> > > +++ b/arch/x86/include/asm/page_32_types.h
> > > @@ -28,6 +28,8 @@
> > >  #define MCE_STACK 0
> > >  #define N_EXCEPTION_STACKS 1
> > >  
> > > +#define __VIRTUAL_MASK_SHIFT	32
> > > +
> > >  #ifdef CONFIG_X86_PAE
> > >  /*
> > >   * This is beyond the 44 bit limit imposed by the 32bit long pfns,
> > > @@ -36,11 +38,8 @@
> > >   * The real limit is still 44 bits.
> > >   */
> > >  #define __PHYSICAL_MASK_SHIFT	52
> > > -#define __VIRTUAL_MASK_SHIFT	32
> > > -
> > >  #else  /* !CONFIG_X86_PAE */
> > >  #define __PHYSICAL_MASK_SHIFT	32
> > > -#define __VIRTUAL_MASK_SHIFT	32
> > >  #endif	/* CONFIG_X86_PAE */
> > 
> > I think it's clearer to see them defined where the physical mask shift is 
> > defined.
> > 
> > How about the patch below? It does away with the weird formatting and 
> > cleans up both the comments and the style of the definition:
> > 
> > /*
> >  * 52 bits on PAE is beyond the 44-bit limit imposed by the
> >  * 32-bit long PFNs, but we need the full mask to make sure
> >  * inverted PROT_NONE entries have all the host bits set
> >  * in a guest. The real limit is still 44 bits.
> >  */
> > #ifdef CONFIG_X86_PAE
> > # define __PHYSICAL_MASK_SHIFT	52
> > # define __VIRTUAL_MASK_SHIFT	32
> > #else
> > # define __PHYSICAL_MASK_SHIFT	32
> > # define __VIRTUAL_MASK_SHIFT	32
> > #endif
> > 
> > ?
> 
> My main concern was about double definition. It pretty looks like a
> bug. But if it's intentional, I'm OK. In the patch below, could you
> please add some note to the comment that __VIRTUAL_MASK_SHIFT defined
> twice intentionally?

It's not defined "twice", it has values set in the PAE and the non-PAE 
branch - just like __PHYSICAL_MASK_SHIFT.

__VIRTUAL_MASK_SHIFT happens to have the same value in both branches, but 
that's OK and pretty standard and happens in other headers too.

Thanks,

	Ingo
