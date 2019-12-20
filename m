Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EE1C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D82620866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDTlNi0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfLTSTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:19:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35336 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727402AbfLTSTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576865958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wRPsI5uu/RlvtNtQkmdecNgQ+higXOu9C0HzOxCB15M=;
        b=QDTlNi0Zbv8Hh7JDrN1op9IZw4fQDsVhsgwWu8y1bLOLYSsryb4nWw+3z2frZ3bOBjGDLK
        tA18XXVwmu68WfFfuEZ6x/3y3ua/tH42DOJbWGe+yxgdMnhOvKq5nGNzPwWCrM3+jypC8i
        +xPQI/AXJ+/0nAxdilR6tvLvD0xDT9U=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147--c51YUmjOSmlLjwblmQO5g-1; Fri, 20 Dec 2019 13:19:17 -0500
X-MC-Unique: -c51YUmjOSmlLjwblmQO5g-1
Received: by mail-qt1-f200.google.com with SMTP id g21so3787532qtq.18
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 10:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wRPsI5uu/RlvtNtQkmdecNgQ+higXOu9C0HzOxCB15M=;
        b=rxrPWnDlNwV9wQZIcJccQOtSneYixViKMkngexz3n5gJvLcQGIfdUct86WplklT1Gz
         dwDZTSGNttXeJj5kZAAo8hHou1gT4QPdlDEy+UrkhX2Lxm0anGmTy1AB7ZbF7UVRpcY4
         euHXlYGGxYezm1YhTJ4CPc72P6nqHTki+/4IK154Uf4AeDaPHFCRCmtD2cHxZLeolek8
         UIl4Xoh9JE8c7/Af7JjmpyEEHDihrWxJbuLWndu+2AcrO9zMnPiXtzclcU9ZgiYCtUGK
         uha/oik/PJNSqLQ97lG4tn8OF5X/mP9ufkijAnK2vTIEWMWqAy0au9XSSfQaxDioEfJI
         9/RA==
X-Gm-Message-State: APjAAAVCYQ2Xv1QJAZm5Kll5mX0g+NiEVszVDayVV1xz/hWyYgCmxuxE
        gnWPPhPyBsuSMWPgFmPOsLrLcAfiMM0auPoTanHbwGewtdVUcCPZAxudN6nZr2Z96r0mpWBqx60
        1QkdHjFgP2GTt1fYdxq5ByUeg
X-Received: by 2002:aed:3c16:: with SMTP id t22mr12486453qte.92.1576865956869;
        Fri, 20 Dec 2019 10:19:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqxhZQS6vB9mGEB6JcCGztbXsAUJN86mcE/m9Xumhu7+42YFiz9lJtvxy372U/8V1JAbBGeXBA==
X-Received: by 2002:aed:3c16:: with SMTP id t22mr12486417qte.92.1576865956609;
        Fri, 20 Dec 2019 10:19:16 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id l49sm3326579qtk.7.2019.12.20.10.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 10:19:15 -0800 (PST)
Date:   Fri, 20 Dec 2019 13:19:14 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Christophe de Dinechin <christophe.de.dinechin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191220181914.GB3780@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <m1lfrihj2n.fsf@dinechin.org>
 <20191213202324.GI16429@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191213202324.GI16429@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 03:23:24PM -0500, Peter Xu wrote:
> > > +If one of the ring buffers is full, the guest will exit to userspace
> > > +with the exit reason set to KVM_EXIT_DIRTY_LOG_FULL, and the
> > > +KVM_RUN ioctl will return -EINTR. Once that happens, userspace
> > > +should pause all the vcpus, then harvest all the dirty pages and
> > > +rearm the dirty traps. It can unpause the guest after that.
> > 
> > Except for the condition above, why is it necessary to pause other VCPUs
> > than the one being harvested?
> 
> This is a good question.  Paolo could correct me if I'm wrong.
> 
> Firstly I think this should rarely happen if the userspace is
> collecting the dirty bits from time to time.  If it happens, we'll
> need to call KVM_RESET_DIRTY_RINGS to reset all the rings.  Then the
> question actually becomes to: Whether we'd like to have per-vcpu
> KVM_RESET_DIRTY_RINGS?

Hmm when I'm rethinking this, I could have errornously deduced
something from Christophe's question.  Christophe was asking about why
kicking other vcpus, while it does not mean that the RESET will need
to do per-vcpu.

So now I tend to agree here with Christophe that I can't find a reason
why we need to kick all vcpus out.  Even if we need to do tlb flushing
for all vcpus when RESET, we can simply collect all the rings before
sending the RESET, then it's not really a reason to explicitly kick
them from userspace.  So I plan to remove this sentence in the next
version (which is only a document update).

-- 
Peter Xu

