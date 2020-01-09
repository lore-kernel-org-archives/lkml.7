Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0229C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5867206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLOkx0/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbgAIQrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:47:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60687 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730602AbgAIQrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578588466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H7yvRcnHtdyGEcTJgOAUtJzzkjbm96l99F3Bt+eWI8s=;
        b=eLOkx0/25wcZZXqItnaKFHUKg4gnQ+XN0EhVox4w+7ko7reHjUcVtS/fD8zfKQ3wa3NS/m
        ys8tGcyi0X23Lxa0jQjGa3xyav8Iqx+7+7+ijBkoJMm0U/BaO8q2hfcs6OPXP0+cpaO4Tz
        mb5nPxB/NYMzcu0+xBkwCP2r5KvDffc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-PPGhbvvvOrSIrVG1C-5OsQ-1; Thu, 09 Jan 2020 11:47:22 -0500
X-MC-Unique: PPGhbvvvOrSIrVG1C-5OsQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 965E51132C9E;
        Thu,  9 Jan 2020 16:47:20 +0000 (UTC)
Received: from w520.home (ovpn-116-128.phx2.redhat.com [10.3.116.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1E1A10013A7;
        Thu,  9 Jan 2020 16:47:12 +0000 (UTC)
Date:   Thu, 9 Jan 2020 09:47:11 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v3 00/21] KVM: Dirty ring interface
Message-ID: <20200109094711.00eb96b1@w520.home>
In-Reply-To: <20200109145729.32898-1-peterx@redhat.com>
References: <20200109145729.32898-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Jan 2020 09:57:08 -0500
Peter Xu <peterx@redhat.com> wrote:

> Branch is here: https://github.com/xzpeter/linux/tree/kvm-dirty-ring
> (based on kvm/queue)
> 
> Please refer to either the previous cover letters, or documentation
> update in patch 12 for the big picture.  Previous posts:
> 
> V1: https://lore.kernel.org/kvm/20191129213505.18472-1-peterx@redhat.com
> V2: https://lore.kernel.org/kvm/20191221014938.58831-1-peterx@redhat.com
> 
> The major change in V3 is that we dropped the whole waitqueue and the
> global lock. With that, we have clean per-vcpu ring and no default
> ring any more.  The two kvmgt refactoring patches were also included
> to show the dependency of the works.

Hi Peter,

Would you recommend this style of interface for vfio dirty page
tracking as well?  This mechanism seems very tuned to sparse page
dirtying, how well does it handle fully dirty, or even significantly
dirty regions?  We also don't really have "active" dirty page tracking
in vfio, we simply assume that if a page is pinned or otherwise mapped
that it's dirty, so I think we'd constantly be trying to re-populate
the dirty ring with pages that we've seen the user consume, which
doesn't seem like a good fit versus a bitmap solution.  Thanks,

Alex

