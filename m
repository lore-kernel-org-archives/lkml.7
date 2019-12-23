Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B941DC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 20:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D14206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 20:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpmfG9BX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfLWUKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 15:10:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46367 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726805AbfLWUKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 15:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577131831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0qtXzJ7ZTRR2+SWknxQLJ4Je16nI1/Qg+c9ZI9bZMqQ=;
        b=CpmfG9BX7jSjrvpy6q/XMM508JYbDNESKNCM/4oRh3+N+k9wfIETfJMcr/0B138HND6cC4
        g6zm5djNTrXe61rBBcq4jXbbt6/v7DHPRnnD5FjcA44cNZk0XCfXO3Wmh5oVMvLDnSvUfj
        8y1xBAIaJEccAn6j4CxkvKK/KyUD8W4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-hkyP2GXOPcGufmQg39Db_Q-1; Mon, 23 Dec 2019 15:10:28 -0500
X-MC-Unique: hkyP2GXOPcGufmQg39Db_Q-1
Received: by mail-qk1-f197.google.com with SMTP id 11so9614080qkk.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 12:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0qtXzJ7ZTRR2+SWknxQLJ4Je16nI1/Qg+c9ZI9bZMqQ=;
        b=MvSNiCEJGrNmyzSz0tLlU/boAGpytST+a530zgQ2Ma0BuZO9ahLCKvuok+LIJRg88A
         fcBkWG29dE3QJJz6ysseXXbFInLLPMnQIjhDENG5eEtgsgb7JDQD8d8stBg5X+ChnW6l
         1MhXZf6I2IT2qK8PmyP8wF3i0R8N8geyHzANw8zkMub9TbXmtDoFO/y3fW1jtmigiLFf
         KBPjXNwZLn0JVNeQOPOpm9Ip7QZX2bWuM/pBHa9z61SzyXAsKeVETg0qtiYbUm8n5SvW
         2vRPCdkFDe7fw7d93E5/I4rpXq4sj5sITfJX5vvvjKMW8jFG0zp5x4Ewnx/u/42jMJiY
         9iTw==
X-Gm-Message-State: APjAAAV3L+PoSdEx1CyTi1y1yUZNxuyNEspJ5Coygu2B4IGKcPeF3v46
        xJjOo6UHid2hxGzB37Q6N2xF2O4KIyUOEzlkTdo0x0F55nnQoSEknEzvv1m0Tf6P6UA+8/KUQy5
        NhKkQ5/e67HOwYXQD4ribTkfd
X-Received: by 2002:ac8:5143:: with SMTP id h3mr4271600qtn.144.1577131827222;
        Mon, 23 Dec 2019 12:10:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqz8EPclLzs35Mazg0q7YeuMs7p5oxoosgwsGt+91CmWfu3wCXNiWspQrkNOv4zJ1zMg5qVOsA==
X-Received: by 2002:ac8:5143:: with SMTP id h3mr4271587qtn.144.1577131827021;
        Mon, 23 Dec 2019 12:10:27 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id o9sm6120558qko.16.2019.12.23.12.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 12:10:25 -0800 (PST)
Date:   Mon, 23 Dec 2019 15:10:24 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RESEND v2 03/17] KVM: X86: Don't track dirty for
 KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
Message-ID: <20191223201024.GB90172@xz-x1>
References: <20191221014938.58831-1-peterx@redhat.com>
 <20191221014938.58831-4-peterx@redhat.com>
 <cf232ce8-bc07-0192-580f-d08736980273@redhat.com>
 <20191223172737.GA81196@xz-x1>
 <851bd9ed-3ff3-6aef-725c-b586d819211c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <851bd9ed-3ff3-6aef-725c-b586d819211c@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 06:59:01PM +0100, Paolo Bonzini wrote:
> On 23/12/19 18:27, Peter Xu wrote:
> > Yes.  Though it is a bit tricky in that then we'll also need to make
> > sure to take slots_lock or srcu to protect that hva (say, we must drop
> > that hva reference before we release the locks, otherwise the hva
> > could gone under us, iiuc).
> 
> Yes, kvm->slots_lock is taken by x86_set_memory_region.  We need to move
> that to the callers, of which several are already taking the lock (all
> except vmx_set_tss_addr and kvm_arch_destroy_vm).

OK, will do.  I'll directly replace the x86_set_memory_region() calls
in kvm_arch_destroy_vm() to be __x86_set_memory_region() since IIUC
the slots_lock is helpless when destroying the vm... then drop the
x86_set_memory_region() helper in the next version.  Thanks,

-- 
Peter Xu

