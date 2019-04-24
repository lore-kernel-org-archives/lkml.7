Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714E3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462C221773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556102320;
	bh=P4JmODgy6DOZ9J8MAkslQJQSwVzWQG214oKF9MLJut8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ctJJF3T9wnDNN6bW1uYf/qlXP1ZD/rw+6m183frF7m1TOF3YWNdSl45cngYTUVwmB
	 IUswZ5gYJSela4X7JcIs/T1+ZdIYp2d2HgUgKzu4bbhUbqv00kpztojRGB2lMtFMPu
	 VTXw09ZfWpKx9yBj0+hrgRDqYTH7exDiG6p43xvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfDXKij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:38:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37714 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfDXKii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:38:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so4324771wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wsgyHyZE+jfFydeBCeq6GdpD8XqGO5uZiHSAewvYEX8=;
        b=M6sbW3Jrs1vBKu5c8UAYdi23vVgcx6USFi/sNaLjvC5FlThXpLGjkkXWEuHftUDu2j
         vpkNY/xpz/t886CpkkYVYO5BglG/uumIXnMrIzjoniUNFAeICIFshyKyEXNSl5vPVIvG
         1Y8H8SGlVE3UO1j27ZJSWa9i1k9GbIm9hht+1GSJ1LYbIqKOJDkcS4jXL9+40w89N/k/
         Y0aq85DcQAZYvRf1OokAiUuEwjh2nHZSv9Nc0XlFAXvLGmYtm6f+d7DqtwDgyOkqvecz
         d5aD/5EDTmWmhEQNixNIZE1mc0c7eCRU7MTrh48T4HQNgjrjbDMTp938LTy5GA92/8Bm
         j4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wsgyHyZE+jfFydeBCeq6GdpD8XqGO5uZiHSAewvYEX8=;
        b=Zg2C8rvd6AzM/W5sW6cgcsg+i3AtpfjJ5/4PDly9Dt/rhg46kHl+rKay5KoaPw6NkJ
         PEbVmdATIPG2cvROP0f1lftpCOsMFG7kMzwUqeqZLbVwJe2n4hw1d23UlrnrVJ61V9TZ
         iQM2LK2AqpaSz0+48oqUhcIPpE43j0YfSy9txLpMe46kignTmrQWsQZYvktx+v2/C7iU
         p1umdmS7/r4I8MIGpIj3d90ftxki9hopWe1wC9S3YxDkvCSmMDlnTz4ftaDMYLMSTZsX
         ApqF9EmqvVOr+S647/3HgbeVK4x7rer1I5Jqki2862TnQJs9KeLr0EtuLMsF9JUFvFTT
         BAoQ==
X-Gm-Message-State: APjAAAVcDNVZTRdKRiIkIegNfF8zuyO/XHPjXedhzd++ahheOyMVi9nj
        XKw34JCRxpEqsqkDeDXw3XE=
X-Google-Smtp-Source: APXvYqzaiiyIDAk4P9RmNdC1L/tFUaM0Ts00RUuUURdyK3oWNHlktIY5ZKkY/g/LAoLTQzG0qtmp6w==
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr5684781wmj.121.1556102316608;
        Wed, 24 Apr 2019 03:38:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y4sm6204645wrh.20.2019.04.24.03.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 03:38:35 -0700 (PDT)
Date:   Wed, 24 Apr 2019 12:38:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] x86_64: uninline TASK_SIZE
Message-ID: <20190424103833.GB9642@gmail.com>
References: <20190421160600.GA31092@avx2>
 <20190421182842.GD35603@gmail.com>
 <8B42CD57-9343-4234-A96D-80337BFFDF0E@zytor.com>
 <20190421211007.GA30444@avx2>
 <20190422103449.GA75723@gmail.com>
 <BFD71398-0BDC-4045-91E9-C70A22FF6E73@amacapital.net>
 <20190422220948.GB26031@avx2>
 <CALCETrWqPStQqv2xCJZLzsqTE-9L9U08CMApWyKD1zwjrrH4ow@mail.gmail.com>
 <20190423111258.GA23410@gmail.com>
 <CALCETrWtK4G7-o=pQoeyzLFTpiR9giGy2jYTU10xt6S8FsMk+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWtK4G7-o=pQoeyzLFTpiR9giGy2jYTU10xt6S8FsMk+Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@kernel.org> wrote:

> > Or am I missing some complication?
> 
> Seems like a great idea to me.
> 
> BTW, what the heck is up with get_gate_page()?  I'm struggling to
> understand what it's even trying to do.  If there's an architecture
> that allows a user program to mremap() or otherwise position its gate
> VMA between TASK_SIZE and TASK_SIZE_MAX, then that code is going to
> explode horribly.

I believe it was an old attempt from the times when the vsyscall area 
*didn't* have a vma, at all, and only get_gate_page() kept the mmap 
allocator from overlapping it with a user vma?

Should IMHO be entirely solved by the vma-ification of all things 
vsyscall and vdso, and we can remove this remnant.

> A whole bunch of work in this direction is here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/fixes
> 
> It's almost entirely untested.

Please post it as patches once you are somewhat confident in the outcome 
and general direction.

Thanks,

	Ingo
