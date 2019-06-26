Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A1CC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CC820645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520130;
	bh=bwu3JRlFer6tfX9zJIfIQ3eGTj7LyoViGNSc3TpVHm8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=elb+pLrIftHbI4SS1KJHBy57WqQlhSaeJoxaH4KIEBzQVtLdNPM9cV38ftk3xLGbB
	 HiK3DGSaVW2C6WGVJ8knLpR4KB1IUAE8Xd4KlkOYjvxWes0aQUVGymxNhlJLJx16/3
	 TciWY10sDfviP+c3P6KI0HjNVWkFU+nSAO8gvMSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFZDf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfFZDf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:35:28 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CD8220645
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 03:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520127;
        bh=bwu3JRlFer6tfX9zJIfIQ3eGTj7LyoViGNSc3TpVHm8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WE58dK3c6MNpnTrS4KSJWik2GvESmqMTeagxMaC8n8fZVsXqOhTRbSE+b6G+zmuAl
         PDMkTukU98Ue+cYhuXEnR4lgQHD5JaeNV7j9TsgLPQK1OmJw81wwx1hDPP293Ci8z6
         nS9R+PbHInk//CeqpJJYUqDPB4kFAPh1XswQ71T4=
Received: by mail-wm1-f44.google.com with SMTP id w9so3579146wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 20:35:27 -0700 (PDT)
X-Gm-Message-State: APjAAAUDZh2mf256CTfbv0taNcOZnFxhAvR4SgYWcDU2czk7UqO+NxAV
        Umlvgnqvz7qQoTfntheE6BvUzJxeNPF693SwUWflDQ==
X-Google-Smtp-Source: APXvYqyZfAzCoJd4al+vWzkiAXWWs0slSD3ODOvqgBz63WxXJbiB546K22w0eDleP0Lby5Z7+6R6o3RBB/Hb4ZSAXVI=
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr755114wmj.79.1561520125983;
 Tue, 25 Jun 2019 20:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190613064813.8102-1-namit@vmware.com> <20190613064813.8102-7-namit@vmware.com>
 <cb28f2b4-92f0-f075-648e-dddfdbdd2e3c@intel.com> <401C4384-98A1-4C27-8F71-4848F4B4A440@vmware.com>
In-Reply-To: <401C4384-98A1-4C27-8F71-4848F4B4A440@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 25 Jun 2019 20:35:12 -0700
X-Gmail-Original-Message-ID: <CALCETrWcUWw8ep-n6RaOeojnL924xOM7g7eb9g=3DRwOHQAgnA@mail.gmail.com>
Message-ID: <CALCETrWcUWw8ep-n6RaOeojnL924xOM7g7eb9g=3DRwOHQAgnA@mail.gmail.com>
Subject: Re: [PATCH 6/9] KVM: x86: Provide paravirtualized flush_tlb_multi()
To:     Nadav Amit <namit@vmware.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 7:39 PM Nadav Amit <namit@vmware.com> wrote:
>
> > On Jun 25, 2019, at 2:40 PM, Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 6/12/19 11:48 PM, Nadav Amit wrote:
> >> Support the new interface of flush_tlb_multi, which also flushes the
> >> local CPU's TLB, instead of flush_tlb_others that does not. This
> >> interface is more performant since it parallelize remote and local TLB
> >> flushes.
> >>
> >> The actual implementation of flush_tlb_multi() is almost identical to
> >> that of flush_tlb_others().
> >
> > This confused me a bit.  I thought we didn't support paravirtualized
> > flush_tlb_multi() from reading earlier in the series.
> >
> > But, it seems like that might be Xen-only and doesn't apply to KVM and
> > paravirtualized KVM has no problem supporting flush_tlb_multi().  Is
> > that right?  It might be good to include some of that background in the
> > changelog to set the context.
>
> I=E2=80=99ll try to improve the change-logs a bit. There is no inherent r=
eason for
> PV TLB-flushers not to implement their own flush_tlb_multi(). It is left
> for future work, and here are some reasons:
>
> 1. Hyper-V/Xen TLB-flushing code is not very simple
> 2. I don=E2=80=99t have a proper setup
> 3. I am lazy
>

In the long run, I think that we're going to want a way for one CPU to
do a remote flush and then, with appropriate locking, update the
tlb_gen fields for the remote CPU.  Getting this right may be a bit
nontrivial.
