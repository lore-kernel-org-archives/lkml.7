Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8FCC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA7B2183F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555347971;
	bh=8AmWko7T1LjNiFsryfxCZUOlHYcmwEq5GAJP/6U+Kz0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oR9Pi0lIC9ZYisRWowI495xgWpsPZcMAzGd3aRkjHj/aIR5zNCcasGvAIIJJgkWKQ
	 ZeTPyWbcmCXcGLG302R+pQwrzQvIol9dv3iWrFZ7kGMoOztfigwMb4tcX7gexVsc3W
	 USIc+jyCwKtvgoIHPTzotqcTslaXLDNUN+zCU7QQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfDORGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:06:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfDORGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:06:10 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69B79218FE
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 17:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555347968;
        bh=8AmWko7T1LjNiFsryfxCZUOlHYcmwEq5GAJP/6U+Kz0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kQC3glXMim2s7wvWuoydokEwkg+lQbkink0wDxiIvInS4YEe6aPRUg85exchxBD0Y
         vHtzSbEugrj8DGcg2SMRXGdxZ0hylUm7iohIIAXok3irFaUIhFFHGgCR8v/2qXSJgR
         wsNB1X/BPhnapBDmemqR48LxQ+IFE3hCTSjVPDWs=
Received: by mail-wm1-f44.google.com with SMTP id y197so9605262wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 10:06:08 -0700 (PDT)
X-Gm-Message-State: APjAAAVq65vpmshiG+kxo1RCx5UH1DMaPEGv6yQOC6MG1qTdPgmYFVtr
        eDo/IL9BdRl5I9ktROOlPeopLCCEeNMtC3b7tBTH6g==
X-Google-Smtp-Source: APXvYqwYiLly1GRDGl1neH0GJEGy7or0yAEB12uvhJ5KaM/bPV9DJXBQNW49P2H+K6e8/7qwUvK7dZ7Hl54x5ZbNHtw=
X-Received: by 2002:a1c:99d5:: with SMTP id b204mr22454485wme.95.1555347966888;
 Mon, 15 Apr 2019 10:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190414155936.679808307@linutronix.de> <20190414160143.591255977@linutronix.de>
 <CALCETrUhVc_u3HL-x7wMnk9ukEbwQPvc9N5Na-Q55se0VwcCpw@mail.gmail.com>
 <alpine.DEB.2.21.1904141832400.4917@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1904151101100.1729@nanos.tec.linutronix.de>
 <20190415132339.wiqyzygqklliyml7@treble> <alpine.DEB.2.21.1904151804460.1895@nanos.tec.linutronix.de>
 <20190415161657.2zwboghblj5ducux@treble>
In-Reply-To: <20190415161657.2zwboghblj5ducux@treble>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 15 Apr 2019 10:05:55 -0700
X-Gmail-Original-Message-ID: <CALCETrXLa9ec8Lcz2WPML8qQiStpTtDSAGkW=Rv9bMSiunNNMw@mail.gmail.com>
Message-ID: <CALCETrXLa9ec8Lcz2WPML8qQiStpTtDSAGkW=Rv9bMSiunNNMw@mail.gmail.com>
Subject: Re: [patch V4 01/32] mm/slab: Fix broken stack trace storage
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 9:17 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Apr 15, 2019 at 06:07:44PM +0200, Thomas Gleixner wrote:
> > On Mon, 15 Apr 2019, Josh Poimboeuf wrote:
> > > On Mon, Apr 15, 2019 at 11:02:58AM +0200, Thomas Gleixner wrote:
> > > >   addr = (unsigned long *)&((char *)addr)[obj_offset(cachep)];
> > > >
> > > > - if (size < 5 * sizeof(unsigned long))
> > > > + if (size < 5)
> > > >           return;
> > > >
> > > >   *addr++ = 0x12345678;
> > > >   *addr++ = caller;
> > > >   *addr++ = smp_processor_id();
> > > > - size -= 3 * sizeof(unsigned long);
> > > > + size -= 3;
> > > > +#ifdef CONFIG_STACKTRACE
> > > >   {
> > > > -         unsigned long *sptr = &caller;
> > > > -         unsigned long svalue;
> > > > -
> > > > -         while (!kstack_end(sptr)) {
> > > > -                 svalue = *sptr++;
> > > > -                 if (kernel_text_address(svalue)) {
> > > > -                         *addr++ = svalue;
> > > > -                         size -= sizeof(unsigned long);
> > > > -                         if (size <= sizeof(unsigned long))
> > > > -                                 break;
> > > > -                 }
> > > > -         }
> > > > +         struct stack_trace trace = {
> > > > +                 /* Leave one for the end marker below */
> > > > +                 .max_entries    = size - 1,
> > > > +                 .entries        = addr,
> > > > +                 .skip           = 3,
> > > > +         };
> > > >
> > > > +         save_stack_trace(&trace);
> > > > +         addr += trace.nr_entries;
> > > >   }
> > > > - *addr++ = 0x87654321;
> > > > +#endif
> > > > + *addr = 0x87654321;
> > >
> > > Looks like stack_trace.nr_entries isn't initialized?  (though this code
> > > gets eventually replaced by a later patch)
> >
> > struct initializer initialized the non mentioned fields to 0, if I'm not
> > totally mistaken.
>
> Hm, it seems you are correct.  And I thought I knew C.
>
> > > Who actually reads this stack trace?  I couldn't find a consumer.
> >
> > It's stored directly in the memory pointed to by @addr and that's the freed
> > cache memory. If that is used later (UAF) then the stack trace can be
> > printed to see where it was freed.
>
> Right... but who reads it?

That seems like a reasonable question.  After some grepping and some
git searching, it looks like there might not be any users.  I found
SLAB_STORE_USER, but that seems to be independent.

So maybe the whole mess should just be deleted.  If anyone ever
notices, they can re-add it better.

--Andy
