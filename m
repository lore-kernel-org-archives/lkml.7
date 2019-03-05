Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138A8C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D527E20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ry0SfRM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfCERcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:32:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39024 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfCERct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:32:49 -0500
Received: from zn.tnic (p200300EC2BCD6B0038F240D7E20AD2C8.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:6b00:38f2:40d7:e20a:d2c8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2674F1EC08EF;
        Tue,  5 Mar 2019 18:32:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551807167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZqDsZGwEkLLmS+dUk/aAo0WMu//cFVMwDZOfseFp/Ic=;
        b=Ry0SfRM2+pfi+SRGd0LNSLaTGEZFm8HVyYXydBxVWRBleZKyyVYDFKkFIC0fuUvMG0Q5Yc
        Cg8/q/VLAuyQea8SyiiRCEe2b/hx2HaLY0Yb/trUasHYBM9l6kKnEXgkGo2jI7DjMbs5R1
        NNNoHm6FlGeMpNDXzpFjpE24nHB+8/I=
Date:   Tue, 5 Mar 2019 18:32:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jann Horn <jannh@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH] x86: Deprecate a.out support
Message-ID: <20190305173249.GF8256@zn.tnic>
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic>
 <20190305122218.GD13380@bombadil.infradead.org>
 <20190305134347.4be2449c@alans-desktop>
 <20190305145717.GD8256@zn.tnic>
 <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
 <CAG48ez0=AWipDy+aDBtxwEs6h8AmiBnfoU7GMi=_yW3sS14MNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez0=AWipDy+aDBtxwEs6h8AmiBnfoU7GMi=_yW3sS14MNQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 05:30:13PM +0100, Jann Horn wrote:
> We might want to also delete the then-unused aout_dump_thread()
> implementations from the various arch trees. We probably want to
> delete arch/*/include/asm/a.out-core.h, since that seems to be the
> only thing these headers do, and the only thing that uses them is
> fs/binfmt_aout.c?

Right.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
