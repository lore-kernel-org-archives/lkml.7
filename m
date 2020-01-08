Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D073AC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FAE20705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZGgYggq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgAHPwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:52:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32662 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727090AbgAHPwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:52:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578498735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Evzwb36HtckuGOEG5Qs7DyOdRE+yUkO/doQt26KVrXo=;
        b=fZGgYggq0x7SIzTlUR0YPfzzOGHcw9k7u8XI76JWog/01R9T8aaoieDoWkLawbyvIBKgF6
        O2EKexBA+TgkzNq69KpjCRc0o2NugjntjRd4wOJqlLq+2jskTbG6AH9Y6NNKcLdsnHpaat
        vyIJ6TOYCJPbsVbifNp8ExqyiKe8YhE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-yEbMiA8OPvq8oB7PpiW1eA-1; Wed, 08 Jan 2020 10:52:13 -0500
X-MC-Unique: yEbMiA8OPvq8oB7PpiW1eA-1
Received: by mail-qv1-f70.google.com with SMTP id g15so2181058qvk.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 07:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Evzwb36HtckuGOEG5Qs7DyOdRE+yUkO/doQt26KVrXo=;
        b=E4a1pESPh69+0W86RpafrL58nCeTCINkSf4Y7h+0zUr/Vd3EMvMK+ScRhdl87m/8B1
         juKIKCgWoVKrO9GzbHgjnw1Ff2QhvYNxu3R51BdxLYtL8D+JQDl9OCHv67Mt9LEahJRG
         0jpHN20IQ4mmZhyA8b6l+icSSl1gEcHZAM8eemv4wqeEDXz8YkyE9fdzYNuMmc2u+lHR
         fEL45IhyA17Hqtw6/5qafVDUcK4LETDcqrZqfURQ1xVaNFsd90vqORyEvwCQrFwc9ZAZ
         cpQhiahHWE9syunJKvo9YAysM6FzkVzlDuNc5av3NGgOxo7zm+yseXLSBLWw6UPyq+Ot
         DiaQ==
X-Gm-Message-State: APjAAAUsl1EHTQ7G703DvdJnMLK+U2czCQBr2jtLsOnslUL1xm4ClieR
        YFWdaKDm3BSqJKRVBrDlr8hEhxXau7RBLtoepmL49keCEbuBl6B6o4nMReJte/6rWogSyWGSxcd
        LbTaZ4Ob5WuYxJB1XlNhetAwC
X-Received: by 2002:ad4:40c7:: with SMTP id x7mr4822608qvp.176.1578498732895;
        Wed, 08 Jan 2020 07:52:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjS5NH4TYqHmq2a3gtG1MUvRpvaKlgnlgJSexza/h1pH4XW1r3TEGv4O2f8Ty8j7f9lGQzKQ==
X-Received: by 2002:ad4:40c7:: with SMTP id x7mr4822581qvp.176.1578498732594;
        Wed, 08 Jan 2020 07:52:12 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id c84sm1569751qkg.78.2020.01.08.07.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 07:52:11 -0800 (PST)
Date:   Wed, 8 Jan 2020 10:52:10 -0500
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Lei Cao <lei.cao@stratus.com>
Subject: Re: [PATCH RESEND v2 08/17] KVM: X86: Implement ring-based dirty
 memory tracking
Message-ID: <20200108155210.GA7096@xz-x1>
References: <20191221014938.58831-1-peterx@redhat.com>
 <20191221014938.58831-9-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191221014938.58831-9-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 08:49:29PM -0500, Peter Xu wrote:
> +int kvm_dirty_ring_push(struct kvm_dirty_ring *ring, u32 slot, u64 offset)
> +{
> +	struct kvm_dirty_gfn *entry;
> +	struct kvm_dirty_ring_indices *indices = ring->indices;
> +
> +	/*
> +	 * Note: here we will start waiting even soft full, because we
> +	 * can't risk making it completely full, since vcpu0 could use
> +	 * it right after us and if vcpu0 context gets full it could
> +	 * deadlock if wait with mmu_lock held.
> +	 */
> +	if (kvm_get_running_vcpu() == NULL &&
> +	    kvm_dirty_ring_soft_full(ring))
> +		return -EBUSY;

I plan to repost next week, but before that I'd like to know whether
there's any further (negative) feedback from design-wise, especially
here, which is still a bit tricky to makeup the kvmgt issue.

Now we still have the waitqueue but it'll only be used for
no-vcpu-context dirtyings, so:

- For no-vcpu-context: thread could wait in the waitqueue if it makes
  vcpu0's ring soft-full (note, previously it was hard-full, so here
  we make it easier to wait so we make sure )

- For with-vcpu-context: we should never wait, guaranteed by the fact
  that KVM_RUN will return now if soft-full for that vcpu ring, and
  above waitqueue will make sure even vcpu0's waitqueue won't be
  filled up by kvmgt

Again this is still a workaround for kvmgt and I think it should not
be needed after the refactoring.  It's just a way to not depend on
that work so this should work even with current kvmgt.

> +
> +	/* It will never gets completely full when with a vcpu context */
> +	WARN_ON_ONCE(kvm_dirty_ring_full(ring));
> +
> +	entry = &ring->dirty_gfns[ring->dirty_index & (ring->size - 1)];
> +	entry->slot = slot;
> +	entry->offset = offset;
> +	smp_wmb();
> +	ring->dirty_index++;
> +	WRITE_ONCE(indices->avail_index, ring->dirty_index);
> +
> +	trace_kvm_dirty_ring_push(ring, slot, offset);
> +
> +	return 0;
> +}

-- 
Peter Xu

