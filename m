Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B223CECE59E
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8357E2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SvmV5Lle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389528AbfJPBow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 21:44:52 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35013 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfJPBow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 21:44:52 -0400
Received: by mail-il1-f194.google.com with SMTP id j9so801040ilr.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 18:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9cw9NzCx7epGU/Xvw2wyJAAx8RJsP4I6+3SDXP5hV5Y=;
        b=SvmV5LleMFDNduOG3ZnOMQucqdJuqRVjwOZVpPy+uyZWlbkqgM73zq46LfGYZDJdyz
         dlHlBftp3GdbnS1cuXYXRlh3Hq7WQ+BAI92XnMX2Om9PAnPiw3/sathpHMJ439wK4Zjd
         DBc/Zkm/Acqw2RQeO9T60fcVTjsUMu3dhDtl5JgAFSnMlmcfzZoU1C3t5psaQJFBhMit
         /LCO3+HsxI/gqR9aP+16jZv7BjUaDTprjoZGnJX1s4VrAqVp9YbQL7QMrBwgcNBwGJN7
         L1HM5y+VmS/+rHTFUwcKFhTZ+X2oGWzrTuHTWWIHeKl9u12V8JSRhFCUF9oINu7JL4vB
         l7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9cw9NzCx7epGU/Xvw2wyJAAx8RJsP4I6+3SDXP5hV5Y=;
        b=joBkJdq3v4BCXax9aEJWS4tbgyV3SBK+34oY0tFjfBdph6lvAYf1rCVbynikR7hEi+
         eXEqqwaU+0xiXFAMoR9PKu9V+YuuyDldLk/qespfMxJiu82+OP0PPzgLu47fIl2fSwX9
         YrXviF5Shw6NXc9th3Ve6+AAtblr+2yw449C2lDb+ehaXv0YGcjBGv/wYBFRHTXamDn6
         bGVLZpQH7YQrRl3OxTuhgzLjdYd5LS62eY37YEkJsubeom0b+HKLPT3h3JBFQE3aHyIo
         rv9X6+PJtDIV8TcTSDlDzQi0paiLCq9GHiTAWEMVgSGtrzCvoOWVDktFM8xy6diercN8
         f7og==
X-Gm-Message-State: APjAAAUpqT3hsMll3U+JHcXsGhQDVtN0mjicyNHqGtKBCL/vckeyR011
        Lp9B0Lhz4+cQIKSTMNc5PeoDABBcNgBdE4HkpwA=
X-Google-Smtp-Source: APXvYqyU+TBYsARRfZ7iQjAiQwiOiz0lI+XMM1Up+CNpl9TgTQFA0vfAXnaxfGtvljOBJdS3DnGO2D+9AI0FBq4feIo=
X-Received: by 2002:a92:8746:: with SMTP id d6mr9458720ilm.267.1571190290945;
 Tue, 15 Oct 2019 18:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191008093711.3410-1-thomas_os@shipmail.org> <20191015100653.ittq4b2mx7pszky5@box>
In-Reply-To: <20191015100653.ittq4b2mx7pszky5@box>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Oct 2019 18:44:39 -0700
Message-ID: <CAA9_cmcSXYB1jo1=CQ78eXVcyGWm1_TjQKd-Gmg0yAO3tObOFw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: Fix a huge pud insertion race during faulting
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>, Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 3:06 AM Kirill A. Shutemov <kirill@shutemov.name> w=
rote:
>
> On Tue, Oct 08, 2019 at 11:37:11AM +0200, Thomas Hellstr=C3=B6m (VMware) =
wrote:
> > From: Thomas Hellstrom <thellstrom@vmware.com>
> >
> > A huge pud page can theoretically be faulted in racing with pmd_alloc()
> > in __handle_mm_fault(). That will lead to pmd_alloc() returning an
> > invalid pmd pointer. Fix this by adding a pud_trans_unstable() function
> > similar to pmd_trans_unstable() and check whether the pud is really sta=
ble
> > before using the pmd pointer.
> >
> > Race:
> > Thread 1:             Thread 2:                 Comment
> > create_huge_pud()                               Fallback - not taken.
> >                     create_huge_pud()         Taken.
> > pmd_alloc()                                     Returns an invalid poin=
ter.
> >
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Fixes: a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent hu=
gepages")
> > Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> > ---
> > RFC: We include pud_devmap() as an unstable PUD flag. Is this correct?
> >      Do the same for pmds?
>
> I *think* it is correct and we should do the same for PMD, but I may be
> wrong.
>
> Dan, Matthew, could you comment on this?

The _devmap() check in these paths near _trans_unstable() has always
been about avoiding assumptions that the corresponding page might be
page cache or anonymous which for dax it's neither and does not behave
like a typical page.
