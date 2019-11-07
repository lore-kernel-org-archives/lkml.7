Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CB6C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D037F2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573163109;
	bh=x11u5RvniuvSAf7h2cGzWMnSypZiJGq/Gbh/0nLTNwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W0ED4+X4i1KT1Mysf7GJoEBA3chzNqg1t5Qv2SX98ELZA6mudyMNVUQaSjfmRwRhs
	 ie9oBBzdsAa0fo0ge99BHK3EYaZvUzrPes6NNDfvBWEST7oySI3e64X+DHrDlME5AT
	 ndzU5soX9sDkBE1qNU6BMLwKDOJ3MJ9PNruGJFxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfKGVpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:45:08 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43459 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfKGVpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:45:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id y23so3929541ljh.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 13:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7bkoIfmChxAzW1ksec2xFter3BulfhV3l8t8jMt0o8=;
        b=J4Q5rwkR0WSSlDmDqYN9Kqe/AJ3WCJnx1cqvE9HtXpewbCpG5f9IJFYCHTKIpv34kx
         DHm07h87q/aD2rSKrES3gUnpaKOGs88rHCOpdXLXBY21/nAT8sTC8cmHC/t5Tx40Ct2G
         GlijRx9m/QGJMeUhMbd8aquNuU/aqEXSTspdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7bkoIfmChxAzW1ksec2xFter3BulfhV3l8t8jMt0o8=;
        b=NCBA223wIDefnqG2vbAH/c/1EpIXwo5VphVwXtYBhd/0P249e2vDHy+lhDCZsyBdvg
         +7eeaaH5JjCcfJQUb7IuNNIQB/pHs8SLmt9qyrDRjqZrNLRE1/qxsAQxHiOpJl4iESkj
         qGVtXetbFWTgZRpeVXklJbAbwhU4+hXyJCPJCp9QOzZDq/a9aXHIhjjyA1f1z5Isumoe
         Wzztrfl/YGcZvm2nlTDebAZqZL11sCqy9IbKnUXwjW0MiO9ak4puZZeA3arBTpuCC1Pp
         /E3daxnnMdD8X21FKwEhxNp6MHEEvR+MtcnB1rGKWD13MRUcuZReaTCMRLu8L2ZeCy+8
         WRLA==
X-Gm-Message-State: APjAAAWgtEI03cV0NbALOoGQC423O2csC5ZbG4pSUx6rA5JFvLfY60R2
        ywORxQ6DAbkoq/HsJG1DAF6X7nFSmWg=
X-Google-Smtp-Source: APXvYqzm/KNf9R+vTrNVyokLzYmK8IBioWOudmiApH+KczjOt9PLIsdaqFl0+UgFhEAbb3Z4+ZrbFA==
X-Received: by 2002:a2e:89c4:: with SMTP id c4mr4108599ljk.197.1573163105106;
        Thu, 07 Nov 2019 13:45:05 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id g25sm1724191ljk.36.2019.11.07.13.45.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 13:45:03 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id l20so3953069lje.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 13:45:03 -0800 (PST)
X-Received: by 2002:a2e:22c1:: with SMTP id i184mr4191987lji.1.1573163103162;
 Thu, 07 Nov 2019 13:45:03 -0800 (PST)
MIME-Version: 1.0
References: <20191106193459.581614484@linutronix.de> <20191106202806.241007755@linutronix.de>
 <CAMzpN2juuUyLuQ-tiV7hKZvG4agsHKP=rRAt_V4sZhpZW7cv9g@mail.gmail.com>
 <CAHk-=wiGO=+mmEb-sfCsD5mxmL5++gdwkFj_aXcfz1R41MJnEg@mail.gmail.com> <CAMzpN2gt4qM41=96GpNHL-kbgBsjD-zphq+5oK0BXqoCFN4F4Q@mail.gmail.com>
In-Reply-To: <CAMzpN2gt4qM41=96GpNHL-kbgBsjD-zphq+5oK0BXqoCFN4F4Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Nov 2019 13:44:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjocTzo+8OMwyKPX0MCVV=N4wtU8ifwSZ_qJJnDBgKJ8Q@mail.gmail.com>
Message-ID: <CAHk-=wjocTzo+8OMwyKPX0MCVV=N4wtU8ifwSZ_qJJnDBgKJ8Q@mail.gmail.com>
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage further
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 1:00 PM Brian Gerst <brgerst@gmail.com> wrote:
>
> There wouldn't have to be a flush on every task switch.

No. But we'd have to flush on any switch that currently does that memcpy.

And my point is that a tlb flush (even the single-page case) is likely
more expensive than the memcpy.

> Going a step further, we could track which task is mapped to the
> current cpu like proposed above, and only flush when a different task
> needs the IO bitmap, or when the bitmap is being freed on task exit.

Well, that's exactly my "track the last task" optimization for copying
the thing.

IOW, it's the same optimization as avoiding the memcpy.

Which I think is likely very effective, but also makes it fairly
pointless to then try to be clever..

So the basic issue remains that playing VM games has almost
universally been slower and more complex than simply not playing VM
games. TLB flushes - even invlpg - tends to be pretty slow.

Of course, we probably end up invalidating the TLB's anyway, so maybe
in this case we don't care. The ioperm bitmap is _technically_
per-thread, though, so it should be flushed even if the VM isn't
flushed...

             Linus
