Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0655C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECE320857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tgx5xyCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfDHQF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:05:28 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53920 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfDHQF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:05:27 -0400
Received: by mail-it1-f196.google.com with SMTP id y204so21567988itf.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 09:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITlIss5JlNmHr6h7/GJ+WO1zukGFR0T0+8FXF5kIEW8=;
        b=Tgx5xyCIuznHAa4L24TZv/ZXknLAgPoKsLc/o/EbVrGqDZ/IN2ScTuyKe67ag7gDrR
         5Sxq9BRZbRN+0b2otaUVhJFIA7x/W1hQq5bTTjw1NjVjcaVjRj/CHBb8fkeNipls21GN
         iDfR1soX16kDdbf6ROSyg34ynic1/EOIhZPeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITlIss5JlNmHr6h7/GJ+WO1zukGFR0T0+8FXF5kIEW8=;
        b=mTDTIx9s4YIVU1fiXwbayYP1pGm47R5ZCqwHaFvZhMB0PvF5UL6SRuEWa67UpnNOHa
         8fTJU+PwfWjmaoZOX5QIHXDw2PM19eV3FnCJDPkszdIO6i/br0j2GU452xl7MFS5B3NC
         H5uOlCV/VHmWn2yS4TpYRVZZ/I+VuHkLPZK78ea+6Hap39CesDP/XPf7IZ+0jF4KfNae
         5BObamx65yyCjS0CbsdIDyzoJ1ysg6ANiblasuG9kbb8Pezjwx3ZdPtqdMoT8Uug6gVK
         jPmapIoA4tyjmLK7ZXQ8G1lQEZuNR9cvrPRwutGxKPgAh/C77O4LNzvkLKpYyeUkTtYM
         Lg+A==
X-Gm-Message-State: APjAAAWkY07AzrCvatUWws8/N9IQOodfc+9DBuuJfsHUyuSCO39K+VWV
        0nxphvckjzgyIevg8czSpfj5kyZh02k=
X-Google-Smtp-Source: APXvYqys/5/6dTcpDcjDundWtPPID/pvoWbUbVuMwB6YLU3OFBweKVxuliRfY9F3ftwQsQe5B5i/hg==
X-Received: by 2002:a02:711f:: with SMTP id n31mr20933503jac.126.1554739526949;
        Mon, 08 Apr 2019 09:05:26 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id s3sm10788777ioo.65.2019.04.08.09.05.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 09:05:26 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id f6so11532976iop.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 09:05:26 -0700 (PDT)
X-Received: by 2002:a6b:6509:: with SMTP id z9mr21038168iob.43.1554739145445;
 Mon, 08 Apr 2019 08:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131192533.34130-15-thgarnie@chromium.org>
 <01000168a5b35a86-b79bfe67-191e-43bc-a5c7-0e74eac06195-000000@email.amazonses.com>
 <CAJcbSZGKR7dKVqNEDEO7Qzf7tnNqmL=p1uVKvsUefS=Hs-=iNA@mail.gmail.com>
 <01000168a6e5ab88-0deea73f-387f-4941-bd11-d1c161aac88a-000000@email.amazonses.com>
 <CAJcbSZFvafvNX1pS96jaTBGNJad+NszLwSgKnRQgyT70gUGWqQ@mail.gmail.com>
In-Reply-To: <CAJcbSZFvafvNX1pS96jaTBGNJad+NszLwSgKnRQgyT70gUGWqQ@mail.gmail.com>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Mon, 8 Apr 2019 08:58:54 -0700
X-Gmail-Original-Message-ID: <CAJcbSZETNhr=Pv+0daEWUsD2=qnZxT9rbmFaE+y7ag-xKOs89w@mail.gmail.com>
Message-ID: <CAJcbSZETNhr=Pv+0daEWUsD2=qnZxT9rbmFaE+y7ag-xKOs89w@mail.gmail.com>
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

On Fri, Feb 1, 2019 at 9:13 AM Thomas Garnier <thgarnie@chromium.org> wrote:
>
> On Thu, Jan 31, 2019 at 6:31 PM Christopher Lameter <cl@linux.com> wrote:
> >
> > On Thu, 31 Jan 2019, Thomas Garnier wrote:
> >
> > > The per-cpu symbols are in a section that is zero based to create
> > > offsets. The compiler doesn't see them as offsets but as relative
> > > symbol and try to relocate them. Given the distance between zero and
> > > the mapped kernel is much larger than the instruction offset range, it
> > > fails to do it.
> >
> > We switch that off in the linker. If that does not work with your
> > modifications then you need to figure out how to update the link
> > configuration.
> >
>
> It didn't work originally but I will revisit to see if I missed something.

I revisited and couldn't find a way to prevent relocations to the
percpu section. Without PIE, you can reference absolute address which
was convenient for percpu.

Christopher: Did you have something specific in mind?

I checked the following:
 - Changing the FLAGS() on the PHDRS.
 - using -z noreloc-overflow which actually doesn't seem to apply to
PC32 relocations.
 - Look at all linker options and script format for anything around that.
