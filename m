Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1996CC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD52E21835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9s/oKBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfLQWsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 17:48:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27131 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726454AbfLQWsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576622889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9n/i9QgxhO0hGtWuQAcaruEVu8v3TGl7tcrGGNBkk0M=;
        b=N9s/oKBbS4pdR4Rqz1LY388BL6r3Opre67dlkM25I6XFeQ73XNhEyKmeM48676fQF9m/9N
        cxOoiyCS0UdkXgN8pPctGrRca2ciyd84LijoOuWSXPv+S0zAQvA5LorjoMPldoAV0I+eIQ
        /tfvJf7WvDWlCntR1T56yXyvHxdkIbk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-g4PWi9OANxaMWBOnLOhjTQ-1; Tue, 17 Dec 2019 17:48:08 -0500
X-MC-Unique: g4PWi9OANxaMWBOnLOhjTQ-1
Received: by mail-qk1-f199.google.com with SMTP id n128so45497qke.19
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 14:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9n/i9QgxhO0hGtWuQAcaruEVu8v3TGl7tcrGGNBkk0M=;
        b=Vxs0Lvz327tCoojTKF0UOpfNgqjMqcjRiVboTZ2l++c5dQVvpXwSc7jnWvgPZQ6Qp+
         h4hkQBJNYCRAUHTuqG3+E37DXaI7CVz+ZjE8I1JwNNQ4gx8vM4uQh+RjzXdZ/gspY5qe
         4aR1Q52rF6XOulV6EgT2lDCg3lZa46zJIUrN7EQPGaGOPW6aZuUQKbINzYxWSjnz8CPw
         doSBejvtsONNsBQ52WEQuh1h1kuGARv0BdWqTbq8JqM0hsS0fLNTtH7VyDXyTvQgSOVl
         lCSqinRXo0+/sKhrFT+GMaAV5oRrQ8XNPeBrx8EK95FqQGXbE2iD0OY8GC4JmgrLT6AO
         oBDQ==
X-Gm-Message-State: APjAAAWFudfRfgOgzlKenfFNZewi/gG20ixYznlqAwM8hna0K94LclHe
        j+T8HD7yASxiPLKyReNx6a2FWwn/LRzuZ/+lWFEFD9z1AiTSYq3kQNkrVSrs8/pXfolcu8z69Ep
        Fc/dyiSz4pP0ML/jFwXop2/Dr
X-Received: by 2002:a37:7685:: with SMTP id r127mr461132qkc.166.1576622885311;
        Tue, 17 Dec 2019 14:48:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqzzAlgi3q/A/lG8/yssi/9qke3Y+PomWjoA6OIsiWSdyH+oKnvcw0q0J4LOd+HEQncOFra+UA==
X-Received: by 2002:a37:7685:: with SMTP id r127mr461111qkc.166.1576622885122;
        Tue, 17 Dec 2019 14:48:05 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id 63sm15645qki.57.2019.12.17.14.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 14:48:04 -0800 (PST)
Date:   Tue, 17 Dec 2019 17:48:02 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Cornelia Huck <cohuck@redhat.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvmarm@lists.cs.columbia.edu, Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v4 11/19] KVM: x86: Free arrays for old memslot when
 moving memslot's base gfn
Message-ID: <20191217224802.GA26669@xz-x1>
References: <20191217204041.10815-1-sean.j.christopherson@intel.com>
 <20191217204041.10815-12-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217204041.10815-12-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:40:33PM -0800, Sean Christopherson wrote:
> Explicitly free the metadata arrays (stored in slot->arch) in the old
> memslot structure when moving the memslot's base gfn is committed.  This
> eliminates x86's dependency on kvm_free_memslot() being called when a
> memlsot move is committed, and paves the way for removing the funky code
> in kvm_free_memslot() that conditionally frees structures based on its
> @dont param.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

