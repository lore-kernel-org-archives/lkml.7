Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E23C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 16:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C0420706
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 16:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WizkkZB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfLNQ0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 11:26:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44138 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725884AbfLNQ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 11:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576340808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xTCcQEsnViYyDThiiPsB7XBVprrCPkwPyCcp1A4bdWA=;
        b=WizkkZB/8YOV783Jz/x9qmAk6cH/8/1Awg4zMmJ/srhkIXvNLA34fV2bDWjLAV/QZzsFvD
        NlQS/LbQQoakPmXtj2cQLG6nHA8zYnppm0R6p5tc+n0BNmlVpgb1dCYzFJYAeVy37UG0b2
        WcUJQaKwXiRLqNhjcWOy5EvY/epvAsQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-NVir-X9MOmSMmyF3d1y8yQ-1; Sat, 14 Dec 2019 11:26:47 -0500
X-MC-Unique: NVir-X9MOmSMmyF3d1y8yQ-1
Received: by mail-qt1-f199.google.com with SMTP id v25so1602991qtq.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 08:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xTCcQEsnViYyDThiiPsB7XBVprrCPkwPyCcp1A4bdWA=;
        b=YMxY1eWteETwEBhcJ/ZZfRWazxkdnJucq4Og3+aukMuDoFe71DwKqQn3r9+MWJ2svD
         O1lLcraDrt0w5503q2r+pTYPMqEJuQDBE0TIoP3YYe2Ck3+8attvb0W3bTtblQK+c4hm
         J/4syaYpP0XGElRPrY2ioP6Cu95YCCpcW6ZZe7sj6C0hiAFL7uuAL0NnHZ3M3jXYz9hG
         jwIlW/+IoQJUCXAusw4ylBp0YcJ1uQJ1lnR38j5oDhrt8AY1nswPdtkGleOMWCyDlU0K
         nFAStXFMxoUfLqqDH33cEKTx0woQ0q1euRZ0+fz1Ze9OABrR7fLPmabLfrt6UsRFoggb
         iuyA==
X-Gm-Message-State: APjAAAXRFH5NUpjQLlZwqwSv7kj6zGX6R1eJ6HzHZ7EMYokL6w3prRe7
        vnl8qqtWcEl+9J64FNnHcfx9yhRXp2vRpi675kXIpDLC5tV5HiOC0tvChC53suOBQDJdlAIoNxn
        NpvRgk0J6rwfVpYs/4g/1LIju
X-Received: by 2002:a05:620a:1265:: with SMTP id b5mr19414255qkl.172.1576340807180;
        Sat, 14 Dec 2019 08:26:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqwA2tHOzVlmpWM+CIZirOCbes2W7tLaOKsaXQYrNj6bJsXvt9XDex8gVHvcT7KB17uqRPfWdg==
X-Received: by 2002:a05:620a:1265:: with SMTP id b5mr19414237qkl.172.1576340806921;
        Sat, 14 Dec 2019 08:26:46 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:3f::2])
        by smtp.gmail.com with ESMTPSA id z141sm2911860qkb.63.2019.12.14.08.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 08:26:46 -0800 (PST)
Date:   Sat, 14 Dec 2019 11:26:44 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christophe de Dinechin <christophe.de.dinechin@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191214162644.GK16429@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <m1lfrihj2n.fsf@dinechin.org>
 <20191213202324.GI16429@xz-x1>
 <bc15650b-df59-f508-1090-21dafc6e8ad1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc15650b-df59-f508-1090-21dafc6e8ad1@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 08:57:26AM +0100, Paolo Bonzini wrote:
> On 13/12/19 21:23, Peter Xu wrote:
> >> What is the benefit of using u16 for that? That means with 4K pages, you
> >> can share at most 256M of dirty memory each time? That seems low to me,
> >> especially since it's sufficient to touch one byte in a page to dirty it.
> >>
> >> Actually, this is not consistent with the definition in the code ;-)
> >> So I'll assume it's actually u32.
> > Yes it's u32 now.  Actually I believe at least Paolo would prefer u16
> > more. :)
> 
> It has to be u16, because it overlaps the padding of the first entry.

Hmm, could you explain?

Note that here what Christophe commented is on dirty_index,
reset_index of "struct kvm_dirty_ring", so imho it could really be
anything we want as long as it can store a u32 (which is the size of
the elements in kvm_dirty_ring_indexes).

If you were instead talking about the previous union definition of
"struct kvm_dirty_gfns" rather than "struct kvm_dirty_ring", iiuc I've
moved those indices out of it and defined kvm_dirty_ring_indexes which
we expose via kvm_run, so we don't have that limitation as well any
more?

-- 
Peter Xu

