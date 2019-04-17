Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79748C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43ACD205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 19:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555530560;
	bh=un9JngdqTRaqtIrvykfJj/MFL9SGLhvcacMgNjMe4H4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q3yhXhrSolo0Aga5b47bVoD0rlURE0OYmsRM8g2fSTyqk+grwIvX1SAXmcYPxIjXv
	 DS/l1ATUPZT366dTK2nz8UofZd8x+XMUDcYt0c8MuFVOPCTBHy5NyzZyMofuUsBHlh
	 MFsvEQ0uwZ9x6zcO5XrKCAu+khGyV6hJi689M8wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbfDQTtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733114AbfDQTtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 15:49:18 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD5EF2183E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 19:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555530558;
        bh=un9JngdqTRaqtIrvykfJj/MFL9SGLhvcacMgNjMe4H4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LuNxcF2SUejG3RCYnUi84IwHnSzvhZp333Yg4ShU6P0MGaUA/NTDr3XUm3g4BgmlR
         20fu2r8qucKNLAcc3nIREAGx4JbBDxDsqw+oIgiaf6dgKbEh7HbcW8o6Zb/6eLfwFB
         EE4oZsHUpTpm4eio5i/zvi+yd5mLeu6dUBhVLC4I=
Received: by mail-wr1-f43.google.com with SMTP id k11so33517233wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 12:49:17 -0700 (PDT)
X-Gm-Message-State: APjAAAUf3zJTf7n1e3VRxWNjbUHp7lipyvFVCsuvYk3NLUKfBB7zWFSg
        MTWDOSqOT9CzVN8TTTxWLpP7LMbk+FrRI7b+ktl8xQ==
X-Google-Smtp-Source: APXvYqwslPQOOCGBluAyQ370prOUXMhL8otOt2EJTpreLpaaBphk3bN4/Rpkbdm1dLisarFpIiIJANwuHztMcLGcdZw=
X-Received: by 2002:adf:f344:: with SMTP id e4mr23917370wrp.77.1555530556240;
 Wed, 17 Apr 2019 12:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554248001.git.khalid.aziz@oracle.com> <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com> <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <20190417170918.GA68678@gmail.com> <8d314750-251c-7e6a-7002-5df2462ada6b@oracle.com>
In-Reply-To: <8d314750-251c-7e6a-7002-5df2462ada6b@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 17 Apr 2019 12:49:04 -0700
X-Gmail-Original-Message-ID: <CALCETrXFzWFMrV-zDa4QFjB=4WnC9RZmorBko65dLGhymDpeQw@mail.gmail.com>
Message-ID: <CALCETrXFzWFMrV-zDa4QFjB=4WnC9RZmorBko65dLGhymDpeQw@mail.gmail.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Juerg Haefliger <juergh@gmail.com>,
        Tycho Andersen <tycho@tycho.ws>, jsteckli@amazon.de,
        Kees Cook <keescook@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris hyser <chris.hyser@oracle.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jon Masters <jcm@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        iommu@lists.linux-foundation.org, X86 ML <x86@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
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

On Wed, Apr 17, 2019 at 10:33 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>
> On 4/17/19 11:09 AM, Ingo Molnar wrote:
> >
> > * Khalid Aziz <khalid.aziz@oracle.com> wrote:
> >
> >>> I.e. the original motivation of the XPFO patches was to prevent execution
> >>> of direct kernel mappings. Is this motivation still present if those
> >>> mappings are non-executable?
> >>>
> >>> (Sorry if this has been asked and answered in previous discussions.)
> >>
> >> Hi Ingo,
> >>
> >> That is a good question. Because of the cost of XPFO, we have to be very
> >> sure we need this protection. The paper from Vasileios, Michalis and
> >> Angelos - <http://www.cs.columbia.edu/~vpk/papers/ret2dir.sec14.pdf>,
> >> does go into how ret2dir attacks can bypass SMAP/SMEP in sections 6.1
> >> and 6.2.
> >
> > So it would be nice if you could generally summarize external arguments
> > when defending a patchset, instead of me having to dig through a PDF
> > which not only causes me to spend time that you probably already spent
> > reading that PDF, but I might also interpret it incorrectly. ;-)
>
> Sorry, you are right. Even though that paper explains it well, a summary
> is always useful.
>
> >
> > The PDF you cited says this:
> >
> >   "Unfortunately, as shown in Table 1, the W^X prop-erty is not enforced
> >    in many platforms, including x86-64.  In our example, the content of
> >    user address 0xBEEF000 is also accessible through kernel address
> >    0xFFFF87FF9F080000 as plain, executable code."
> >
> > Is this actually true of modern x86-64 kernels? We've locked down W^X
> > protections in general.
> >
> > I.e. this conclusion:
> >
> >   "Therefore, by simply overwriting kfptr with 0xFFFF87FF9F080000 and
> >    triggering the kernel to dereference it, an attacker can directly
> >    execute shell code with kernel privileges."
> >
> > ... appears to be predicated on imperfect W^X protections on the x86-64
> > kernel.
> >
> > Do such holes exist on the latest x86-64 kernel? If yes, is there a
> > reason to believe that these W^X holes cannot be fixed, or that any fix
> > would be more expensive than XPFO?
>
> Even if physmap is not executable, return-oriented programming (ROP) can
> still be used to launch an attack. Instead of placing executable code at
> user address 0xBEEF000, attacker can place an ROP payload there. kfptr
> is then overwritten to point to a stack-pivoting gadget. Using the
> physmap address aliasing, the ROP payload becomes kernel-mode stack. The
> execution can then be hijacked upon execution of ret instruction. This
> is a gist of the subsection titled "Non-executable physmap" under
> section 6.2 and it looked convincing enough to me. If you have a
> different take on this, I am very interested in your point of view.

My issue with all this is that XPFO is really very expensive.  I think
that, if we're going to seriously consider upstreaming expensive
exploit mitigations like this, we should consider others first, in
particular CFI techniques.  grsecurity's RAP would be a great start.
I also proposed using a gcc plugin (or upstream gcc feature) to add
some instrumentation to any code that pops RSP to verify that the
resulting (unsigned) change in RSP is between 0 and THREAD_SIZE bytes.
This will make ROP quite a bit harder.
