Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0E0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAEF206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="1lTs7P18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfC2FMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 01:12:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46954 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfC2FMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 01:12:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so914074wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 22:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKnBSoZi4LuxrMzM4MLMIkqICF16Xx9TbrvGnGEfgAc=;
        b=1lTs7P18qM8kl6W9FeGm7vqIwvdzpq6ues9WS7N3DmJgrrTLKeM/F2z7fxzY3S1GH/
         aJceLriqerUByopmqeCCOW0Mrm6NnHde7SOcd842QvzI7rEfV4wnhchbqew3VYQIKF3D
         lIuthnPSTxVMfcVz6yvqyAZub8zQ6AvMM1bJk+Hy9LO5zXC4nDFzz+hKo9Prija3xU60
         HeLPRpecdOD+uSyu60bKNTeATIEKkoI5mVQY/iYUojndjR6dhDEstcmyfZHXZT0hahy2
         aUAFIw1ret3rhx+IR9MQGfp6iN2E2eFtRDYoaJDSpYme8/lwccZEkRCY4qskXg3Dkhh/
         ucuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKnBSoZi4LuxrMzM4MLMIkqICF16Xx9TbrvGnGEfgAc=;
        b=hm/KDUpVaNzpQioRLprxndikmL3y7/+iTrufViKiYrG4fRP6kYy3f7g/FNjh/lU85d
         QPHg4KQq6cjtQ8yjJ1eYCM6Te6LOO3ElxHrqbx+/MU8FsygNeVxTxnHlP/quQnv2Bu8a
         IIQ5qyD5/j9MRLZHHxHQt0Cx3Lw9hlCymMR2PXxESe59GVPwbRTgRstFmfd5yAEVeXgM
         PML/dUuIJIEB+XKSyh82nXR9gW5qgJnNyXl/FuCd9KEtK03OXjmOan/JIeMbhvlx2GlZ
         tghIHlgai255kKkddzlnl4+wWgFjVAhLMJCql7BvkIYyE5CaZwp8CHF0OTbR5/4EzdFh
         yBZg==
X-Gm-Message-State: APjAAAWY9Mh48AYDr6dVNGl6wWAyAh4kYCyffXrKGyX0OlTP8+wX/LRt
        8sBIXpMJ2c05dTCB4ry7GZwLU8C589S9sLrIcGtzNg==
X-Google-Smtp-Source: APXvYqyXJQK6XhqSNAYTj8EBUc5LyJC8lYYf5FwLRTgFVcq4mP9C+QFjhsvK76sYP2ZuIAZOWE0TA/13qu9pS12bLug=
X-Received: by 2002:adf:fe03:: with SMTP id n3mr18569004wrr.59.1553836337710;
 Thu, 28 Mar 2019 22:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190328063211.13052-1-anup.patel@wdc.com> <alpine.DEB.2.21.9999.1903282158510.25278@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1903282158510.25278@viisi.sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 29 Mar 2019 10:42:06 +0530
Message-ID: <CAAhSdy2VaUJeMx0S=PA0NrX8s1eqvbNkknHi0cqX_OS4+y7u+g@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Implement ASID allocator
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gary Guo <gary@garyguo.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 10:34 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>
> On Thu, 28 Mar 2019, Anup Patel wrote:
>
> > Signed-off-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> > Changes since v1:
> > - We adapt good aspects from Gary Guo's ASID allocator implementation
> >   and provide due credit to him by adding his SoB.
>
> This isn't the right way to use Signed-off-by: lines in the kernel.  See
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst#n213
>
> and
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n418
>
> The only people who should be listed in Signed-off-by: lines are patch
> authors.
>
> If your intention is to give Gary credit for changes in your patch,
> describe what ideas or code snippets you've taken in the patch description
> itself, above your Signed-off-by: lines so they would be included in the
> git commit description should your patch be merged.

Thanks for clarifying...

Under "Changes since v1" I have clarified what suggestions I have
taken from Gray.

Gray insist that I use "Co-developed-by:" so I have posted v3 with
"Co-developed-by:". Honestly, I don't mind "Signed-off-by: " or
"Co-developed-by:" as long as I am acknowledging other person's
efforts.

Regards,
Anup
