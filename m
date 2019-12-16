Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C94CC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E3F2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkeptxGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfLPSzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:55:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52296 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726281AbfLPSy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576522498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NhNCILKQC2H9fPsP601CjhPIiTCmYV9tPKtKDaQC5bE=;
        b=KkeptxGl+30Rz8EnffiVlcY+7LL1CBSVPIXX1MOHmbLnvxWHM1rqGJn22LcGEl6fktmKaN
        J5g2TMjBheFwwWqkyKECyRP3VyrTwuMSZrPc+BhZw8Jm25lpzubVSmS3fcE83ElZIoKP1L
        StdxWR/jPDvZsN00brJQl4+7yac0lQo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-nHFPDRrfPQCnblpZRh4BXg-1; Mon, 16 Dec 2019 13:54:57 -0500
X-MC-Unique: nHFPDRrfPQCnblpZRh4BXg-1
Received: by mail-qt1-f200.google.com with SMTP id l1so5205594qtp.21
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 10:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NhNCILKQC2H9fPsP601CjhPIiTCmYV9tPKtKDaQC5bE=;
        b=gDqLh53S535pKTzeFccPq+nAROwp8zb+4hThryCQ/y+vUFfZ946gVkGXdl+iYlblA7
         43wBNzUUXrSnAkp98J5gZ+4djFwJurZFMnBCJP3JiSk7zo9lDD4P/5K0acbmK9gRTTs0
         sxJJPXkiWJE4oJuqOo0A80mM48l2p/KOx9T7OpttFNd/1q3oVpaiZo1V2SMZeBuqL0uH
         qsHYgPtFW00pRet0vxk5YBMgT5wjAFPTNaXsSrS+As62ZfGhBcpYK1netMmWG+H09zJ5
         WMohBjURC4ronYZPXznaUEJYVHwxWObvFiEorvcWl1niSJC1B1qIxMgFzbsrBQQPyBt2
         rUpQ==
X-Gm-Message-State: APjAAAVAVNy/7rJeMo9CIjDh+il4rKSYw/GoZuTGVZ+M6DKchXyBwUfQ
        3VyRtqJcfJc3YQd5ExOYfxAKBtzGI2Ed5KorQWqWSUd9fvGObsF5UrLBCEQ+TtLd5a4SxX75s47
        n1gsMSzs91A8DRvrSnuOTyDsV
X-Received: by 2002:a37:7005:: with SMTP id l5mr799919qkc.334.1576522497087;
        Mon, 16 Dec 2019 10:54:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqyH0oFJ6c/tHu5L8t62L3+lM4YKWvmKqoFPMrWv4pPK2XFRQ3+IEt11Cj64BFmXY9R+r9srzg==
X-Received: by 2002:a37:7005:: with SMTP id l5mr799900qkc.334.1576522496747;
        Mon, 16 Dec 2019 10:54:56 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id v4sm2170135qtd.24.2019.12.16.10.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 10:54:55 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:54:54 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191216185454.GG83861@xz-x1>
References: <20191202215049.GB8120@linux.intel.com>
 <fd882b9f-e510-ff0d-db43-eced75427fc6@redhat.com>
 <20191203184600.GB19877@linux.intel.com>
 <374f18f1-0592-9b70-adbb-0a72cc77d426@redhat.com>
 <20191209215400.GA3352@xz-x1>
 <affd9d84-1b84-0c25-c431-a075c58c33dc@redhat.com>
 <20191210155259.GD3352@xz-x1>
 <3e6cb5ec-66c0-00ab-b75e-ad2beb1d216d@redhat.com>
 <20191215172124.GA83861@xz-x1>
 <f117d46a-7528-ce32-8e46-4f3f35937079@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f117d46a-7528-ce32-8e46-4f3f35937079@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 11:08:15AM +0100, Paolo Bonzini wrote:
> > Although now because we have kvm_get_running_vcpu() all cases for [&]
> > should be fine without changing anything, but I tend to add another
> > patch in the next post to convert all the [&] cases explicitly to pass
> > vcpu pointer instead of kvm pointer to be clear if no one disagrees,
> > then we verify that against kvm_get_running_vcpu().
> 
> This is a good idea but remember not to convert those to
> kvm_vcpu_write_guest, because you _don't_ want these writes to touch
> SMRAM (most of the addresses are OS-controlled rather than
> firmware-controlled).

OK.  I think I only need to pass in vcpu* instead of kvm* in
kvm_write_guest_page() just like kvm_vcpu_write_guest(), however we
still keep to only write to address space id==0 for that.

> 
> > init_rmode_tss or init_rmode_identity_map.  But I've marked them as
> > unimportant because they should only happen once at boot.
> 
> We need to check if userspace can add an arbitrary number of entries by
> calling KVM_SET_TSS_ADDR repeatedly.  I think it can; we'd have to
> forbid multiple calls to KVM_SET_TSS_ADDR which is not a problem in general.

Will do that altogether with the series.  I can further change both of
these calls to not track dirty at all, which shouldn't be hard, after
all userspace didn't even know them, as you mentioned below.

Is there anything to explain what KVM_SET_TSS_ADDR is used for?  This
is the thing I found that is closest to useful (from api.txt):

        This ioctl is required on Intel-based hosts.  This is needed
        on Intel hardware because of a quirk in the virtualization
        implementation (see the internals documentation when it pops
        into existence).

So... has it really popped into existance somewhere?  It would be good
at least to know why it does not need to be migrated.

> >> I don't think that's possible, most writes won't come from a page fault
> >> path and cannot retry.
> > 
> > Yep, maybe I should say it in the other way round: we only wait if
> > kvm_get_running_vcpu() == NULL.  Then in somewhere near
> > vcpu_enter_guest(), we add a check to wait if per-vcpu ring is full.
> > Would that work?
> 
> Yes, that should work, especially if we know that kvmgt is the only case
> that can wait.  And since:
> 
> 1) kvmgt doesn't really need dirty page tracking (because VFIO devices
> generally don't track dirty pages, and because kvmgt shouldn't be using
> kvm_write_guest anyway)
> 
> 2) the real mode TSS and identity map shouldn't even be tracked, as they
> are invisible to userspace
> 
> it seems to me that kvm_get_running_vcpu() lets us get rid of the per-VM
> ring altogether.

Yes, it would be perfect if so.

-- 
Peter Xu

