Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F13AC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039DF2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gQB6U321"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfDHSOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:14:33 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46486 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfDHSOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:14:32 -0400
Received: by mail-io1-f66.google.com with SMTP id p23so11257250iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yAux5Ku0F8TRvhryUL3sJjmWLG4xBlH/cwp7PMlXDQ4=;
        b=gQB6U321p5l/j1bhWHg7deKeKkPzJq3JDVM1H/jgmbf5pBBh0E4d6ZZ8Nu6vPs8yyJ
         Thc2griKgGO8Bh/PKRIxYl0aiZDySne4Ur20bcxor2I7eFhUiaWxuzfFcJplwTz23qFr
         UgT6OPKw0vGt1HGM21aY+9Mu0sCOkYEBIvcdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yAux5Ku0F8TRvhryUL3sJjmWLG4xBlH/cwp7PMlXDQ4=;
        b=p9aT36dOYe75AlZp910NoadMHh70pnKkh56fGbUoOCtsHMnaO9Rfgf9Jtp5dgXqDgc
         YGgp4kO0m7Iz6UikBsIJdKEhwJ/IAiaSNo67E4KN56DjCXp2nk9ci031lK78Q/qXtw0t
         WuDAzaHSrb1UtRuDzVM7T5Ld7DCsMvx5+pSUUVnmvP11l3V7rApLQsxFXAmWmL5Ow5R6
         r1hqBrzFfg/91CrH+SheVLEQLtRmwRynkyqO86b6AA/Lqd/0zlMhXvzzImPRYTR0xsLd
         Kn+tw2rA2LJzr0hBPnZa8pA/OfkYv7oUV60fAqfZX62FkBUjZCkNhFRB/0nQLSNTM4gc
         XrFw==
X-Gm-Message-State: APjAAAXXif2k6tXOeKkmYT0C7Ii+hma7ljzHC5xGYkq5WwUoWdfoqY25
        5rZZQDOBD1m5SrGNaXW/6k8jA+YY9jo=
X-Google-Smtp-Source: APXvYqxaTClI+Lp7TGeGXpG9ea784pwPDWyGQSn9YyfY14bPWjO+70PLTDNNWb2eyPEIaeygX60xYw==
X-Received: by 2002:a6b:b797:: with SMTP id h145mr12658227iof.190.1554747271383;
        Mon, 08 Apr 2019 11:14:31 -0700 (PDT)
Received: from mail-it1-f178.google.com (mail-it1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id y24sm11412111iol.8.2019.04.08.11.14.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 11:14:31 -0700 (PDT)
Received: by mail-it1-f178.google.com with SMTP id q14so662683itk.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 11:14:31 -0700 (PDT)
X-Received: by 2002:a24:298b:: with SMTP id p133mr22379438itp.81.1554746949463;
 Mon, 08 Apr 2019 11:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131192533.34130-15-thgarnie@chromium.org>
 <01000168a5b35a86-b79bfe67-191e-43bc-a5c7-0e74eac06195-000000@email.amazonses.com>
 <CAJcbSZGKR7dKVqNEDEO7Qzf7tnNqmL=p1uVKvsUefS=Hs-=iNA@mail.gmail.com>
 <01000168a6e5ab88-0deea73f-387f-4941-bd11-d1c161aac88a-000000@email.amazonses.com>
 <CAJcbSZFvafvNX1pS96jaTBGNJad+NszLwSgKnRQgyT70gUGWqQ@mail.gmail.com>
 <CAJcbSZETNhr=Pv+0daEWUsD2=qnZxT9rbmFaE+y7ag-xKOs89w@mail.gmail.com> <01000169fe18026e-a0951268-516c-4604-a4c3-140f3cbb6f7a-000000@email.amazonses.com>
In-Reply-To: <01000169fe18026e-a0951268-516c-4604-a4c3-140f3cbb6f7a-000000@email.amazonses.com>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Mon, 8 Apr 2019 11:08:58 -0700
X-Gmail-Original-Message-ID: <CAJcbSZFVnJ6qYNsGipf6foa8dtsX_RDykRWK-edP85ySQacsVg@mail.gmail.com>
Message-ID: <CAJcbSZFVnJ6qYNsGipf6foa8dtsX_RDykRWK-edP85ySQacsVg@mail.gmail.com>
Subject: Re: [PATCH v6 14/27] x86/percpu: Adapt percpu for PIE support
To:     Christopher Lameter <cl@linux.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 10:56 AM Christopher Lameter <cl@linux.com> wrote:
>
> On Mon, 8 Apr 2019, Thomas Garnier wrote:
>
> > > It didn't work originally but I will revisit to see if I missed something.
> >
> > I revisited and couldn't find a way to prevent relocations to the
> > percpu section. Without PIE, you can reference absolute address which
> > was convenient for percpu.
>
> Can you switch PIE off for the percpu section? If not maybe the linker
> needs to have an additional option?

I don't think so or I didn't find any option to do that. Changing the
linker might be a bit too much if we have a software solution which
doesn't impact performance.

>
> Cannot imagine that this is not possible. You neeed to be able to
> reference registers that are in fixed memory locations.
>
>
> > Christopher: Did you have something specific in mind?
>
> I thought that we just leave it as is.

I would like to as well. I will try couple things at the assembly
level instead of the linker and come back to this thread.
