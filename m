Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACBFC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C977205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXcuPiep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfLPP0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:26:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44538 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728173AbfLPP0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576510010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iGwZfkSSJJnwVp/7Ati+2Sz+85Pj+b7tepwX8oznNuk=;
        b=EXcuPiepVCmoQOdqSBUA9VAzf8EVZI0IfmVD1ILFrAiPRaSW157lgp6vYt5f9JTzzjy+p4
        3cqCeBbIRE83TYRJVqrxasZ0AgYydBMzqH0N/mTGxlrNQ+17zQTXDwvGcx/+/JUFWBymKy
        2fFwypLv5ZQ4hz85AXXZ4Lp8wk+Jo/I=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-Mrm8-0GpNWqb7ulUkUOjIQ-1; Mon, 16 Dec 2019 10:26:48 -0500
X-MC-Unique: Mrm8-0GpNWqb7ulUkUOjIQ-1
Received: by mail-qt1-f198.google.com with SMTP id l4so4804979qte.18
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 07:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iGwZfkSSJJnwVp/7Ati+2Sz+85Pj+b7tepwX8oznNuk=;
        b=qm6JnWthiV+FZsb891UelrXTndY94OBkJxXwGvcoVJa2/0/uB6FxDWrRTL9Kr2yFJZ
         wLXVMziYTjct9HGVFI/GYBIMZIy3yLX3ug66E8UaA17iKvyURL/79Ozee6zuMu2QP/nV
         Q2Uz8UqIDw+Y+R6hobLNtMu/30xqdr57DnOlrayElY+9j1znCHKqGvULjLMtI+0zqgqg
         dxz6wXLF/UKL04Crrx9xJoqBCSaEcOAlOSxtqKUtJ9E4v1u8/qlJLczl4S9myMEDy+tt
         DMCAHl5+VQzhKlxaeqTXx3arR28UV2hrUtKBUXR000uCXn4XFEH8HaOCy0iWeZAk/LVg
         28Og==
X-Gm-Message-State: APjAAAU1ZKgNFkrumOoU1WvAuaevCYokrIKeSnF2JEo8/Nf6eUVY/HHc
        qpvYj52X4aEykjbLYlGE2O5GeldniqXsgX6X+7iXuH5GRYp4IFzzV/DUbq5aEQPwIAbVHwmbfVU
        HEQmqzr4NNcNyGT+ccQ2Mpbkr
X-Received: by 2002:ac8:5257:: with SMTP id y23mr12518064qtn.88.1576510008518;
        Mon, 16 Dec 2019 07:26:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqzjZKLtqnKl3UUpSm2cxHKwBagl6vJ99FCgj6lDTxMrEQ4zqr3hHWPw+ZrHloqvoZLMECC06A==
X-Received: by 2002:ac8:5257:: with SMTP id y23mr12518048qtn.88.1576510008236;
        Mon, 16 Dec 2019 07:26:48 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:3f::2])
        by smtp.gmail.com with ESMTPSA id u15sm6007057qku.67.2019.12.16.07.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 07:26:46 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:26:47 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christophe de Dinechin <christophe.de.dinechin@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191216152647.GD83861@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <m1lfrihj2n.fsf@dinechin.org>
 <20191213202324.GI16429@xz-x1>
 <bc15650b-df59-f508-1090-21dafc6e8ad1@redhat.com>
 <20191214162644.GK16429@xz-x1>
 <0f084179-2a5d-e8d9-5870-3cc428105596@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f084179-2a5d-e8d9-5870-3cc428105596@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:29:36AM +0100, Paolo Bonzini wrote:
> On 14/12/19 17:26, Peter Xu wrote:
> > On Sat, Dec 14, 2019 at 08:57:26AM +0100, Paolo Bonzini wrote:
> >> On 13/12/19 21:23, Peter Xu wrote:
> >>>> What is the benefit of using u16 for that? That means with 4K pages, you
> >>>> can share at most 256M of dirty memory each time? That seems low to me,
> >>>> especially since it's sufficient to touch one byte in a page to dirty it.
> >>>>
> >>>> Actually, this is not consistent with the definition in the code ;-)
> >>>> So I'll assume it's actually u32.
> >>> Yes it's u32 now.  Actually I believe at least Paolo would prefer u16
> >>> more. :)
> >>
> >> It has to be u16, because it overlaps the padding of the first entry.
> > 
> > Hmm, could you explain?
> > 
> > Note that here what Christophe commented is on dirty_index,
> > reset_index of "struct kvm_dirty_ring", so imho it could really be
> > anything we want as long as it can store a u32 (which is the size of
> > the elements in kvm_dirty_ring_indexes).
> > 
> > If you were instead talking about the previous union definition of
> > "struct kvm_dirty_gfns" rather than "struct kvm_dirty_ring", iiuc I've
> > moved those indices out of it and defined kvm_dirty_ring_indexes which
> > we expose via kvm_run, so we don't have that limitation as well any
> > more?
> 
> Yeah, I meant that since the size has (had) to be u16 in the union, it
> need not be bigger in kvm_dirty_ring.
> 
> I don't think having more than 2^16 entries in the *per-CPU* ring buffer
> makes sense; lagging in recording dirty memory by more than 256 MiB per
> CPU would mean a large pause later on resetting the ring buffers (your
> KVM_CLEAR_DIRTY_LOG patches found the sweet spot to be around 1 GiB for
> the whole system).

That's right, 1G could probably be a "common flavor" for guests in
that case.

Though I wanted to use u64 only because I wanted to prepare even
better for future potential changes as long as it won't hurt much.
Here I'm just afraid 16bit might not be big enough for this 64bit
world, at the meantime I'd confess some of the requirement could be
really unimaginable before we know it..  I'm trying to forge one here:
what if the customer wants to handle 4G burst dirtying workload during
a migration (besides the burst IOs, mostly idle guests), while the
customer also want good responsiveness during the burst dirtying?  In
that case even if we use 256MiB ring we'll still need to freqently
pause for the harvesting, but actually this case really suites for a
8G ring size.

My example could be nonsense actually, just to show that if we can
extend something to u64 from u16 without paying much, then why not. :-)

> 
> So I liked the union, but if you removed it you might as well align the
> producer and consumer indices to 64 bytes so that they are in separate
> cache lines.

Yeh that I can do.  Thanks,

-- 
Peter Xu

