Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E953C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079822183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/AYdV4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbfDRFl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:41:59 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:38669 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfDRFl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 01:41:59 -0400
Received: by mail-vk1-f195.google.com with SMTP id h71so219450vkf.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 22:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQ9PhXUre7lv39dhKUe3RnNugaLVkc5Fpp+aduMWHKc=;
        b=R/AYdV4IFItQnfjUNNubyf9+5USGcILzz8B1DmWPKSECRCluWxSP8rnztSiAw/nHbx
         OgWc7upQI8/4NLGzsj8XCYD8CtK21EXPUD3kqVz8L9yqhXJs06gDEQL5f14t98XkKrDi
         zZLGfesRzIi7SEtmDIBJc/zWHSSeITVGpq4qWo6pCUtYoX+1nKYsEkGc/aMtjhfeYPaR
         zpe5obPY5UDXKnX5Ux3km1WyEqJmPrsvxZPBHysfpd+ZMjsl8a01eFzYpNC5mgWQOQvs
         wfgj8VJjyeSiWxP7AB+2Th18IJzOpvgz45GRbENtjjUmOZDRpabHmRe+wBMg/KPgX8r9
         SNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQ9PhXUre7lv39dhKUe3RnNugaLVkc5Fpp+aduMWHKc=;
        b=WDUxQaUrSkMijcaPwp2sJVrUWYHsInToEM2/oREHH7CfxzH2Z2j16Hx0XY2lx8SHiT
         DnwWdSnW7eNqB0ByvdSWa8xwZ9YYcI2LH5NCgC61nCXDqPHmvqZvB7kDKpSQ7FiJsvKv
         jnbwLUGiIGiI+HMnIaRuC+vnKUGwAErhFiZ/wVupypyhQzL+lyYlKLAv7Xy0N2zeodEN
         b8XtBovqlchN39HrV4u5PG5vdBCPKxbP9s18QN55TD0Qcr7iwgOmfMXO3rjJtRRuFaO/
         bte1COYmDdZ/sNIW3tMq8pDrbhxutcnS1+6asI40vO0BPWquWY7N0o/XX2PsIPw+IqV5
         KfbA==
X-Gm-Message-State: APjAAAUcTflXi2AFT5JW7yd0LIKGDxWl/2YsY4nVdNGqPzZyVhgp9U8A
        p4kJ8qAl32Lz2WjAF/OH3YBODZE6lfRctGEtyxH1PA==
X-Google-Smtp-Source: APXvYqzZLwtZBmPJJ/5v5RygK+/cFMwA6/cdqWVv/GY3jUCoHNshsVXhYcdmHi4zwosCo3mHVhlDcSu086Z/Mts0mIg=
X-Received: by 2002:a1f:a4d:: with SMTP id 74mr51091145vkk.13.1555566117779;
 Wed, 17 Apr 2019 22:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554248001.git.khalid.aziz@oracle.com> <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com> <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <20190417170918.GA68678@gmail.com> <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
 <20190417172632.GA95485@gmail.com> <063753CC-5D83-4789-B594-019048DE22D9@gmail.com>
 <alpine.DEB.2.21.1904172317460.3174@nanos.tec.linutronix.de>
 <CAHk-=wgBMg9P-nYQR2pS0XwVdikPCBqLsMFqR9nk=wSmAd4_5g@mail.gmail.com>
 <alpine.DEB.2.21.1904180129000.3174@nanos.tec.linutronix.de>
 <CAHk-=whUwOjFW6RjHVM8kNOv1QVLJuHj2Dda0=mpLPdJ1UyatQ@mail.gmail.com> <CALCETrXm9PuUTEEmzA8bQJmg=PHC_2XSywECittVhXbMJS1rSA@mail.gmail.com>
In-Reply-To: <CALCETrXm9PuUTEEmzA8bQJmg=PHC_2XSywECittVhXbMJS1rSA@mail.gmail.com>
From:   Kees Cook <keescook@google.com>
Date:   Thu, 18 Apr 2019 00:41:45 -0500
Message-ID: <CAGXu5jL-qJtW7eH8S2yhqciE+J+FWz8HHzTrGJTgVUbd55n6dQ@mail.gmail.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Juerg Haefliger <juergh@gmail.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Julian Stecklina <jsteckli@amazon.de>,
        Kees Cook <keescook@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris hyser <chris.hyser@oracle.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jon Masters <jcm@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        iommu <iommu@lists.linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave@sr71.net>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:41 PM Andy Lutomirski <luto@kernel.org> wrote:
> I don't think this type of NX goof was ever the argument for XPFO.
> The main argument I've heard is that a malicious user program writes a
> ROP payload into user memory (regular anonymous user memory) and then
> gets the kernel to erroneously set RSP (*not* RIP) to point there.

Well, more than just ROP. Any of the various attack primitives. The NX
stuff is about moving RIP: SMEP-bypassing. But there is still basic
SMAP-bypassing for putting a malicious structure in userspace and
having the kernel access it via the linear mapping, etc.

> I find this argument fairly weak for a couple reasons.  First, if
> we're worried about this, let's do in-kernel CFI, not XPFO, to

CFI is getting much closer. Getting the kernel happy under Clang, LTO,
and CFI is under active development. (It's functional for arm64
already, and pieces have been getting upstreamed.)

> mitigate it.  Second, I don't see why the exact same attack can't be
> done using, say, page cache, and unless I'm missing something, XPFO
> doesn't protect page cache.  Or network buffers, or pipe buffers, etc.

My understanding is that it's much easier to feel out the linear
mapping address than for the others. But yes, all of those same attack
primitives are possible in other memory areas (though most are NX),
and plenty of exploits have done such things.

-- 
Kees Cook
