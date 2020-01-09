Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E513C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D599E20661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b412CnJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbgAIQRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:17:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47963 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730483AbgAIQRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=utdlm/aKlY7xAQfEyR3w7Eafs4aRDid1gJnviBYktXw=;
        b=b412CnJIyZx0RcnAjmPw1hVXuHrWKydt40cxRNZhmiEfn9bDrBoR/LFo4SdbNXv/C3UF6b
        cq1nsF6Uhi8ewafwQz9Kb3bL4kMQ3d7m+CJUDzTH0QSN3ogelNOo38m9Ayipl9X6m3M9w/
        LlhxPuMRKNaQH6xM+p1hmQ/xWZWABcE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-8gmgBvSWP3-oSv7hUfqH4A-1; Thu, 09 Jan 2020 11:17:45 -0500
X-MC-Unique: 8gmgBvSWP3-oSv7hUfqH4A-1
Received: by mail-qk1-f199.google.com with SMTP id x127so4477017qkb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=utdlm/aKlY7xAQfEyR3w7Eafs4aRDid1gJnviBYktXw=;
        b=FOeoHBxZiQFYWH3WnSfR1vO/j8ft9vBqxAXN9ACKZQdan78wabhPPD3R1NQg2Sneev
         vVDW6QmD8RxzvCo6ezvBN9Ad2zffyVNSXG8bhuXSaUjxNsBCfWdYMCgsouvVt0qU/250
         l3X49dzcCoR8nGyWAGNeNRXQLsf2fwT7gylGYQgY8zEip595ht30j9nOyPwvRAw4wrwT
         0IE4UfPXsuFZiw0yDHWqj7RMp+C3bupB/KpU/Y+/qUrNSrm2E8tXIuFP08klNF9VVRia
         Lsw2PzTdpAhLyWUqawBVg6GaYnvKnOXOeb4XYylY7KNH2HT4PAy6IsX5OD0/d0eXPGem
         7uWQ==
X-Gm-Message-State: APjAAAXBFiVKI1hLl7zwoYmaci+px9s2ybYNstZTlFQAoXFCEmrV9MF0
        w9/8SVpQd5d61XVH/tEZHTDaZa7bCWrdKJSveqO1Je7vnnhs+vZlai0S2laUFlCPr/oVL1T8sYe
        Ut+Ftad7BPRpmMoN/e/xPF6zq
X-Received: by 2002:ac8:544f:: with SMTP id d15mr8718695qtq.53.1578586665331;
        Thu, 09 Jan 2020 08:17:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxOO77lSOX4HB1VsYJg95F5t9IBQf4gOicmO1+VK8TA5tARhYVtiz9nWGF7JPyZNSOqo/KKIw==
X-Received: by 2002:ac8:544f:: with SMTP id d15mr8718671qtq.53.1578586665141;
        Thu, 09 Jan 2020 08:17:45 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id m8sm3602484qtk.60.2020.01.09.08.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:17:43 -0800 (PST)
Date:   Thu, 9 Jan 2020 11:17:42 -0500
From:   Peter Xu <peterx@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 00/21] KVM: Dirty ring interface
Message-ID: <20200109161742.GC15671@xz-x1>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109105443-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200109105443-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 10:59:50AM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 09, 2020 at 09:57:08AM -0500, Peter Xu wrote:
> > Branch is here: https://github.com/xzpeter/linux/tree/kvm-dirty-ring
> > (based on kvm/queue)
> > 
> > Please refer to either the previous cover letters, or documentation
> > update in patch 12 for the big picture.
> 
> I would rather you pasted it here. There's no way to respond otherwise.

Sure, will do in the next post.

> 
> For something that's presumably an optimization, isn't there
> some kind of testing that can be done to show the benefits?
> What kind of gain was observed?

Since the interface seems to settle soon, maybe it's time to work on
the QEMU part so I can give some number.  It would be interesting to
know the curves between dirty logging and dirty ring even for some
small vms that have some workloads inside.

> 
> I know it's mostly relevant for huge VMs, but OTOH these
> probably use huge pages.

Yes huge VMs could benefit more, especially if the dirty rate is not
that high, I believe.  Though, could you elaborate on why huge pages
are special here?

Thanks,

-- 
Peter Xu

