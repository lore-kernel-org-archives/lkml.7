Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D92AC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3372077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C23jZjZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgAIWVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 17:21:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30237 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725951AbgAIWVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578608469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KrbLj9z4yqBQ3htnZz63X4SfIdII5Nbzh4nyBI5aBeA=;
        b=C23jZjZ5rZk5CTCwAtceRHolLL9/jEy06+AgWshn0sF3lyvcXfqkTvOZ73IDNdWSHEyVTY
        hu/BjCCEwIqgpz2QEJLDiDrxbWZruASw/2PTb1EQNmJ018qN1QIN2V7DnnDbYa8DJDVelT
        yL++dCViJUeV34tBSf1MNPnl7/p1WSA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-IBv5Sj56PBeaabppKdp47A-1; Thu, 09 Jan 2020 17:21:08 -0500
X-MC-Unique: IBv5Sj56PBeaabppKdp47A-1
Received: by mail-qt1-f198.google.com with SMTP id m18so57564qtq.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 14:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KrbLj9z4yqBQ3htnZz63X4SfIdII5Nbzh4nyBI5aBeA=;
        b=LqvbDwZkaN1JwqA7ISt9Ez1tGfLwiPy/eXsk6lzSkR3ixbUp4WH439h7IfqwdPc90b
         G70iW93tmgVdmDGgcFk7i9S7j7EgIiesRhg5hTH20vXST6LlGKOWBGR2tM01HO7Jotl8
         0C47R11VLrhQFcqq7FpgxVDKwm3a1AjzGZ5KnqiBAqaOHWAfkHHoDFOrnqjp2Ti6RK80
         GlmzBEFSynkDRi/0ByemEj6lyP2V+n40n1w8ffGK9PPeGsuJ9aH76EgtLBVj+d4b9z4Z
         2PsnwbFFdPsKQBJRlW62PZyZLiXCuvliAj1y/5m0onr960GCjubkypAJfpieVSaf+uiD
         PGOg==
X-Gm-Message-State: APjAAAV+8XcsRKdD9uEDYTx1t1WmSSZ/gBFF5RQSNunzglYgVdCV+5i4
        MP/5GNSCgyumPHFigXlNxeUFor17TiCfPamdgqFh04HLBn6EAiTFDroxnM4FXj1V7tPqEhgBzt3
        dZkIB/KOgHCzbGf9MVncHmpVe
X-Received: by 2002:a37:a215:: with SMTP id l21mr123407qke.87.1578608468187;
        Thu, 09 Jan 2020 14:21:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqxAw0CC9AMs/pJaro1FKYoAWnhL0tKTTWnBksnGURkcooXbK13YeBPG/xcWbNV7Lj7knw5qOA==
X-Received: by 2002:a37:a215:: with SMTP id l21mr123392qke.87.1578608467999;
        Thu, 09 Jan 2020 14:21:07 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id n20sm3629669qkk.54.2020.01.09.14.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 14:21:07 -0800 (PST)
Date:   Thu, 9 Jan 2020 17:21:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v3 00/21] KVM: Dirty ring interface
Message-ID: <20200109171909-mutt-send-email-mst@kernel.org>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109094711.00eb96b1@w520.home>
 <20200109175808.GC36997@xz-x1>
 <20200109140948-mutt-send-email-mst@kernel.org>
 <feffe012-0407-128a-185a-42cb9d5aac5c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feffe012-0407-128a-185a-42cb9d5aac5c@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 09:51:50PM +0100, Paolo Bonzini wrote:
> On 09/01/20 20:13, Michael S. Tsirkin wrote:
> > That's one of the reasons I called for using something
> > resembling vring_packed_desc.
> 
> In principle it could make sense to use the ring-wrap detection
> mechanism from vring_packed_desc instead of the producer/consumer
> indices.  However, the element address/length indirection is unnecessary.
> 
> Also, unlike virtio, KVM needs to know if there are N free entries (N is
> ~512) before running a guest.  I'm not sure if that is possible with
> ring-wrap counters, while it's trivial with producer/consumer indices.
> 
> Paolo

Yes it's easy: just check whether current entry + 500 has been consumed.
Unless scatter/father is used, but then the answer is simple - just
don't use it :)

-- 
MST

