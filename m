Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B17AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC0020672
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xk0AJMwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfLBUtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:49:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53483 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725781AbfLBUtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575319789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kfI2T/OBDTQMytIjwtIY0Q+iGUUVGvoXu6NKeDy7chI=;
        b=Xk0AJMwPxGkDlp5NznZs/JRkCtrCk9bMsw/w6zOhqTB7/ZGevgHh+0Ak5QoKZQBi47ft7L
        E7y82TbUQacUNSdPS/3D3XVt6O/CP6W3+dILiGsoLiF7UPAI02o4vS+CJoA8JYiV5+GiQc
        kb0DRFDN6rDLc1+qskLc+UEJqzSAIkc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-4uA2vEJoNfGwuU6VLVyczA-1; Mon, 02 Dec 2019 15:49:46 -0500
Received: by mail-qv1-f72.google.com with SMTP id w13so621402qvb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 12:49:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oKfmJh2VfgBUbtlo/gIgdtusRPYrvR5yv1D+kx4rgqU=;
        b=qr8Fd0FGldWS4583LX+zo6VkHluEMvLAEXoWgtCaXWyFKinwE/REAC5O8UpofXh7KO
         qQenIID5gwQl6gxUcVLJTvqqk4pk7X2k6ZkDB8ByHTRTuTt+7amWd4euHgJKjtY3efx6
         3VJp22izkSKNrkvbWxSAECL92phAoMB+9z96pjquoL7knaS3yUu7HDBj5tuYgCNN/wDi
         zpAyGt1NNS5v27bBqfKAgF8/RcZaxMPuBxXvLQUbzXl4zJnMcetUsUyaQkgurEdFkYMk
         8syAdYLLLLGIOIeCOXvCPFpWDbTwSnbXaeIJcg2Gp9Y3yFYX1tQKdYXN4IJ2gqr3eejV
         TPrg==
X-Gm-Message-State: APjAAAW5pgQHhi30MkUoP6VBFIMuYSNOf46q/29CqYO9DxpFXN/Z3Xoq
        lpb68KNBU7UQuxHNq/0hMKbH9L8lukHJfwjcqU98XVtTFoR8jI27GLKx67n1cpWhsC3EtpePqOP
        ++yMWjdBFiAUKIoDl/gdYRwY+
X-Received: by 2002:a05:6214:1709:: with SMTP id db9mr1263731qvb.68.1575319785943;
        Mon, 02 Dec 2019 12:49:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHvfzhOgfr3zCnKSbC9lF3fmLxUBS1vsAQdC++WCkLiU3qHQOwm5+Li7yrZWtEjBlraRaNlw==
X-Received: by 2002:a05:6214:1709:: with SMTP id db9mr1263701qvb.68.1575319785594;
        Mon, 02 Dec 2019 12:49:45 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id j2sm395309qka.88.2019.12.02.12.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 12:49:44 -0800 (PST)
Date:   Mon, 2 Dec 2019 15:49:43 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 02/15] KVM: Add kvm/vcpu argument to
 mark_dirty_page_in_slot
Message-ID: <20191202204943.GC31681@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-3-peterx@redhat.com>
 <20191202193222.GI4063@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191202193222.GI4063@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-MC-Unique: 4uA2vEJoNfGwuU6VLVyczA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 11:32:22AM -0800, Sean Christopherson wrote:
> On Fri, Nov 29, 2019 at 04:34:52PM -0500, Peter Xu wrote:
>=20
> Why?

[1]

>=20
> > From: "Cao, Lei" <Lei.Cao@stratus.com>
> >=20
> > Signed-off-by: Cao, Lei <Lei.Cao@stratus.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  virt/kvm/kvm_main.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index fac0760c870e..8f8940cc4b84 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -145,7 +145,10 @@ static void hardware_disable_all(void);
> > =20
> >  static void kvm_io_bus_destroy(struct kvm_io_bus *bus);
> > =20
> > -static void mark_page_dirty_in_slot(struct kvm_memory_slot *memslot, g=
fn_t gfn);
> > +static void mark_page_dirty_in_slot(struct kvm *kvm,
> > +=09=09=09=09    struct kvm_vcpu *vcpu,
> > +=09=09=09=09    struct kvm_memory_slot *memslot,
> > +=09=09=09=09    gfn_t gfn);
>=20
> Why both?  Passing @vcpu gets you @kvm.

You are right on that I should fill in something at [1]..

Because @vcpu can be NULL (if you continue to read this patch, you'll
see sometimes NULL is passed in), and we at least need a context to
mark the dirty ring.  That's also why we need a per-vm dirty ring to
be the fallback of the cases where we don't have vcpu context.

Thanks,

--=20
Peter Xu

