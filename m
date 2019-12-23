Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9D7C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43159206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlDgbEMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfLWR1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 12:27:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24040 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726754AbfLWR1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577122061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2FQpGKHqmKgP8roRbgRwKHYu0GCskB3t0E3YVUxgG0w=;
        b=ZlDgbEMsk/Z8Zas4xcpQE7OkH2+XW4TGyCqJ5E8cmFqgPqsUvA6a2zLnCVBVqKngelaSvo
        MTvIHSxy7eGgTGWkGNgQZ+wv22SZbSj+V2FhZHuoTR7bXLA9O3SNWE6bTTLXpuNZy943QX
        n/9DQZm7kwJQ4v4DLaHK0u8i5bIDUDI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-hq4f1rARP_WixaF5Awi55g-1; Mon, 23 Dec 2019 12:27:40 -0500
X-MC-Unique: hq4f1rARP_WixaF5Awi55g-1
Received: by mail-qt1-f199.google.com with SMTP id g21so8852325qtq.18
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 09:27:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2FQpGKHqmKgP8roRbgRwKHYu0GCskB3t0E3YVUxgG0w=;
        b=cDCMk9TuhLc11dnF5rTvJaZLI9TPxvK+l5ztqn0RjtoApjsZq4GCUzXi2K9MKkf8W9
         YBC2CPa/0vNDj3JSAGJnRYDuRq5A+R4n5kWw2HtzC0RjO/G3URtxf/M1mXnlTuYBruHR
         7g9qbgr0PqFabyh7+R88HOQoyB3RDcdj/DRRApncu3gT84esyMqTucijgV/vxbVy/T5o
         uFsM8GFaVqaxtDMKSv/lvGStfRG3nMcfo+RNd9YOmRMnYdKN1YwkLX+fccr0i+xCrp96
         MdTjdYb1vk8d18In6ogw1rqfe7unKuMY82jES/oNcTqdb5sucvGKSSwg2wnZ4l7fyBg7
         YCwg==
X-Gm-Message-State: APjAAAXQtq3Yyx800uc5cY3UeGIrq58R203KJOHAQHwaxjpIAaUved/p
        b4YV7hBgJ4Way54rxtrZrl3QP1OTYnQtAjr9xBYMeFUo+0uQJMsnjXMouoZYfeGNrhVQz+fx+Lk
        BjEn2OSdMC3JpRleyEY7LvHed
X-Received: by 2002:a37:a70c:: with SMTP id q12mr15555620qke.484.1577122059614;
        Mon, 23 Dec 2019 09:27:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYzt7+Hss5QmOIfwnIr/JMapF2vhOFE7agaZrdLdvNu9aXaC3w6bEL5ww3BUrHUWO1SQNPIw==
X-Received: by 2002:a37:a70c:: with SMTP id q12mr15555594qke.484.1577122059322;
        Mon, 23 Dec 2019 09:27:39 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id l4sm422045qkb.37.2019.12.23.09.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 09:27:38 -0800 (PST)
Date:   Mon, 23 Dec 2019 12:27:37 -0500
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
Message-ID: <20191223172737.GA81196@xz-x1>
References: <20191221014938.58831-1-peterx@redhat.com>
 <20191221014938.58831-4-peterx@redhat.com>
 <cf232ce8-bc07-0192-580f-d08736980273@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf232ce8-bc07-0192-580f-d08736980273@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 21, 2019 at 02:51:52PM +0100, Paolo Bonzini wrote:
> On 21/12/19 02:49, Peter Xu wrote:
> > Originally, we have three code paths that can dirty a page without
> > vcpu context for X86:
> > 
> >   - init_rmode_identity_map
> >   - init_rmode_tss
> >   - kvmgt_rw_gpa
> > 
> > init_rmode_identity_map and init_rmode_tss will be setup on
> > destination VM no matter what (and the guest cannot even see them), so
> > it does not make sense to track them at all.
> > 
> > To do this, a new parameter is added to kvm_[write|clear]_guest_page()
> > to show whether we would like to track dirty bits for the operations.
> > With that, pass in "false" to this new parameter for any guest memory
> > write of the ioctls (KVM_SET_TSS_ADDR, KVM_SET_IDENTITY_MAP_ADDR).
> 
> We can also return the hva from x86_set_memory_region and
> __x86_set_memory_region.

Yes.  Though it is a bit tricky in that then we'll also need to make
sure to take slots_lock or srcu to protect that hva (say, we must drop
that hva reference before we release the locks, otherwise the hva
could gone under us, iiuc).  So if we want to do that we'd better
comment on that hva value very explicitly, just in case some future
callers of __x86_set_memory_region could cache it somewhere.

(Side topic: I feel like the srcu_read_lock() pair in
 init_rmode_identity_map() is redundant..)

-- 
Peter Xu

