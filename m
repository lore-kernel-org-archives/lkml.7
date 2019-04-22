Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231FBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E292A205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vl0fYQ0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfDVWXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:23:47 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:40198 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfDVWXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 18:23:46 -0400
Received: by mail-vk1-f196.google.com with SMTP id l17so2755965vke.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 15:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Apsh13b43ex5kM603MFVFBzVRJeAAR6IMS53yCHVuRM=;
        b=Vl0fYQ0UCHGtndl0jafErZw5vqbDAq4DrFX3SfBAIMhEhneL9rXawPTcud8fgV5g3D
         W/sHE49ARVD9KYD5FloU01n2RfA2pTgnKMthR4SE5EVifhT+Zv7f89iMoQqyLkH17UHR
         Ufjeoo3iZe8A1ywqY/dQX9OJ6hQY+RdFMicuSiIFmS2kjW0kxDgF0PQchZJoFDeQwLJ4
         Bu9iNZw8/m1h5Vvq6bsIi0oFDRabTh4fUKE/VXZ1BpEeHCWZiVc862ytrlz+nAaTR+Cp
         kF/vZydc6r2yg2X0nSiZbBoPzLhOuIzzabOzb88ffPr/VLLo66HUZNIe7JxAbYTKUz7T
         O38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Apsh13b43ex5kM603MFVFBzVRJeAAR6IMS53yCHVuRM=;
        b=cK8b/Gs3lxWC8ZjuCKYtO6bMHQNgAftcIlEdZxdiAka7Bz7go5OQxanLvTx/P6h8Q3
         f47mewUtY4fpXDD7GEKjVcG9e/2xZtiEdPg9RfvGzMk+fbhRVweuYk2FHzeco4z++xHA
         Ok3/J2UzxGCf3woyjiZrbd6Z8z2MM9cecUtROCgvvJlcrjkFeFobTyVu5XaNxOKhfGc3
         ZBBRCLvqpwpzpbcr4mIn6NnCQeLjCZHQQMLk6Ob2wlQ1+q9k4nFMvTAXqwqULcxL3At4
         Qu9I6rEI3R/utoGiC3DvABPx96dX4LJmFLcM3IZFgZfCBDowNwV6wz5aoxPY7NDgBBPB
         A0ug==
X-Gm-Message-State: APjAAAUHK+zIz0EKYcHs3mffWtPjyXMaLW/xNLXyRdiwXajQVp32Gbyn
        d+SzXFZChJc+phBUfUaFyCsKxnzLprMfiKGIb4U5RQ==
X-Google-Smtp-Source: APXvYqxiq50qJu8wanUuH+yOCTaJNMUpHEhGXVEwCujnFscJAmlLegU3s6VeZj+61I7iVGG+tUCCywSMlxsTtse/mUo=
X-Received: by 2002:a1f:2e07:: with SMTP id u7mr11692664vku.44.1555971825052;
 Mon, 22 Apr 2019 15:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554248001.git.khalid.aziz@oracle.com> <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com> <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <20190417170918.GA68678@gmail.com> <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
 <20190417172632.GA95485@gmail.com> <063753CC-5D83-4789-B594-019048DE22D9@gmail.com>
 <alpine.DEB.2.21.1904172317460.3174@nanos.tec.linutronix.de>
 <CAHk-=wgBMg9P-nYQR2pS0XwVdikPCBqLsMFqR9nk=wSmAd4_5g@mail.gmail.com>
 <alpine.DEB.2.21.1904180129000.3174@nanos.tec.linutronix.de>
 <CAHk-=whUwOjFW6RjHVM8kNOv1QVLJuHj2Dda0=mpLPdJ1UyatQ@mail.gmail.com>
 <CALCETrXm9PuUTEEmzA8bQJmg=PHC_2XSywECittVhXbMJS1rSA@mail.gmail.com>
 <CAGXu5jL-qJtW7eH8S2yhqciE+J+FWz8HHzTrGJTgVUbd55n6dQ@mail.gmail.com> <8f9d059d-e720-cd24-faa6-45493fc012e0@oracle.com>
In-Reply-To: <8f9d059d-e720-cd24-faa6-45493fc012e0@oracle.com>
From:   Kees Cook <keescook@google.com>
Date:   Mon, 22 Apr 2019 15:23:32 -0700
Message-ID: <CAGXu5jLPkD_6BL1m2=13KVTfZ7znr-xAyz+CB23eoeboFgCSOg@mail.gmail.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juerg Haefliger <juergh@gmail.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Julian Stecklina <jsteckli@amazon.de>,
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

On Thu, Apr 18, 2019 at 7:35 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>
> On 4/17/19 11:41 PM, Kees Cook wrote:
> > On Wed, Apr 17, 2019 at 11:41 PM Andy Lutomirski <luto@kernel.org> wrote:
> >> I don't think this type of NX goof was ever the argument for XPFO.
> >> The main argument I've heard is that a malicious user program writes a
> >> ROP payload into user memory (regular anonymous user memory) and then
> >> gets the kernel to erroneously set RSP (*not* RIP) to point there.
> >
> > Well, more than just ROP. Any of the various attack primitives. The NX
> > stuff is about moving RIP: SMEP-bypassing. But there is still basic
> > SMAP-bypassing for putting a malicious structure in userspace and
> > having the kernel access it via the linear mapping, etc.
> >
> >> I find this argument fairly weak for a couple reasons.  First, if
> >> we're worried about this, let's do in-kernel CFI, not XPFO, to
> >
> > CFI is getting much closer. Getting the kernel happy under Clang, LTO,
> > and CFI is under active development. (It's functional for arm64
> > already, and pieces have been getting upstreamed.)
> >
>
> CFI theoretically offers protection with fairly low overhead. I have not
> played much with CFI in clang. I agree with Linus that probability of
> bugs in XPFO implementation itself is a cause of concern. If CFI in
> Clang can provide us the same level of protection as XPFO does, I
> wouldn't want to push for an expensive change like XPFO.
>
> If Clang/CFI can't get us there for extended period of time, does it
> make sense to continue to poke at XPFO?

Well, I think CFI will certainly vastly narrow the execution paths
available to an attacker, but what I continue to see XPFO useful for
is stopping attacks that need to locate something in memory. (i.e. not
ret2dir but, like, read2dir.) It's arguable that such attacks would
just use heap, stack, etc to hold such things, but the linear map
remains relatively easy to find/target. But I agree: the protection is
getting more and more narrow (especially with CFI coming down the
pipe), and if it's still a 28% hit, that's not going to be tenable for
anyone but the truly paranoid. :)

All that said, there isn't a very good backward-edge CFI protection
(i.e. ROP defense) on x86 in Clang. The forward-edge looks decent, but
requires LTO, etc. My point is there is still a long path to gaining
CFI in upstream.

-- 
Kees Cook
