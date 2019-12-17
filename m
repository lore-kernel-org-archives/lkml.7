Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C842C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328B621D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHRvw6AZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfLQQmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:42:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45666 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726402AbfLQQmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576600968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CrCf/NwWYpCGoTQAsLWIUU7mZVErqP3JdIsj9e1SaPg=;
        b=SHRvw6AZ4IdvuqPcD6JfuTAuBoE7mWJuOyeo/5aF9o0gx1RHv4J3uWfLEKnSaqOjyqxhPF
        fmVAl6xbChYvOKBB3nYfybDqNjTkYztq5424LHpHIfjsnAXV1qHXL1v0zkmoRZK9DKh1VG
        y8sD51SGUg5K8BuG6Z4LT53FI4205I0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-qzGUAUeKNZ2sinHN9CJh5g-1; Tue, 17 Dec 2019 11:42:47 -0500
X-MC-Unique: qzGUAUeKNZ2sinHN9CJh5g-1
Received: by mail-qk1-f200.google.com with SMTP id 12so7196171qkf.20
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 08:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CrCf/NwWYpCGoTQAsLWIUU7mZVErqP3JdIsj9e1SaPg=;
        b=EynGE/Do5ZNEtipruqkUeP8cl8fAs63cAvtjP6xOJMeMQT4r9bsh7cbcb0mwO5Imfo
         yuMMiYCRhzxZvfV4jwmKnMlymgyGPTuXn50lTUF1XG7qXGsBnWWiJTKJ7cIUKUwrUtlf
         AB85JR0/hkzm4KdVHA0Ia+r20swCPOOUoGDX4jpTVHPt094q8oMo92/9P0Sk+tchPy3m
         LIIMbn07I7OWbWVXkbTjLntBciqYA49pjYqT+8JFJRtZfROruOgAjch9EFMlEyXAxmwX
         boPSRt4fBCwRQ7Y2SoUGy5XV7qmmatDYHRvszm4LFPpAr9J2LZkv61/CSmiiq84/cA3b
         EsMQ==
X-Gm-Message-State: APjAAAUAYoy/V7v8/KRrHp6L+F0B7RO46ZBfFoKO5VptzDbN0JKkbnhk
        oJ5kggU/ub9ng16naEHlDaT63O2b2XrlYtvXyJrhloBBy80NUYBKVsJcb8iYMcuyhUA5Mxid5WJ
        ZQJFyoGPCV9erOp/nG20XvWaM
X-Received: by 2002:ac8:21ec:: with SMTP id 41mr5448845qtz.242.1576600966836;
        Tue, 17 Dec 2019 08:42:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqwDiMxFU/n4dbLE4zkIZGOqGfipV+5VvUOqIWv7WdbeVIwoUMjJm6HdqztecpahePvpe+tBww==
X-Received: by 2002:ac8:21ec:: with SMTP id 41mr5448824qtz.242.1576600966557;
        Tue, 17 Dec 2019 08:42:46 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id t73sm7262985qke.71.2019.12.17.08.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 08:42:45 -0800 (PST)
Date:   Tue, 17 Dec 2019 11:42:44 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        Christophe de Dinechin <christophe.de.dinechin@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191217164244.GE7258@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <m1lfrihj2n.fsf@dinechin.org>
 <20191213202324.GI16429@xz-x1>
 <bc15650b-df59-f508-1090-21dafc6e8ad1@redhat.com>
 <E167A793-B42A-422D-8D46-B992CB6EBE69@redhat.com>
 <d59ac0eb-e65a-a46f-886e-6df80a2b142f@redhat.com>
 <20191217153837.GC7258@xz-x1>
 <ecb949d1-4539-305f-0a84-1704834e37ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ecb949d1-4539-305f-0a84-1704834e37ba@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 05:31:48PM +0100, Paolo Bonzini wrote:
> On 17/12/19 16:38, Peter Xu wrote:
> > There's still time to persuade me to going back to it. :)
> > 
> > (Though, yes I still like current solution... if we can get rid of the
> >  only kvmgt ugliness, we can even throw away the per-vm ring with its
> >  "extra" 4k page.  Then I suppose it'll be even harder to persuade me :)
> 
> Actually that's what convinced me in the first place, so let's
> absolutely get rid of both the per-VM ring and the union.  Kevin and
> Alex have answered and everybody seems to agree.

Yeah that'd be perfect.

However I just noticed something... Note that we still didn't read
into non-x86 archs, I think it's the same question as when I asked
whether we can unify the kvm[_vcpu]_write() interfaces and you'd like
me to read the non-x86 archs - I think it's time I read them, because
it's still possible that non-x86 archs will still need the per-vm
ring... then that could be another problem if we want to at last
spread the dirty ring idea outside of x86.

-- 
Peter Xu

