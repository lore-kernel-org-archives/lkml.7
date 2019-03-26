Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43653C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E3E2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbfCZQyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:54:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42498 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCZQyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:54:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id b74so8043353qkg.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AT7xvjAWIyJCcePl132t7T+n+TzpQQuXNXm3pdI4blo=;
        b=uRbPhYYIDiMv04qKSRSjhNHs8Fw2agg6a3DRRw5aByJ/GGImTFu2c9RAmjon+fE73T
         ynX8k8y9YqZCHCtxPniAsJ91tmEyhu3tky5HRsfkKccD0RTTcT90B8qggDYcmbd7GNK7
         hMiwQzvQ9erBf8R/qTv2jIibeD7RUNNQVLU3XGDp+JYgT8bQrV5/kQ0XOzEwaVLc+37h
         +/3SIGzSO9FqW+64oeHNBocCVMs2lpCYTghS4x1R3l7UBayRNxy140YYLWCz0iwM12D5
         Jg87ICBspXMn7hCvEOV3SMEQv5c/xx+ETsHKU/YO3RTLPneohrtre2lm7aEqFl8h6zSz
         0o2g==
X-Gm-Message-State: APjAAAW52wafS+m9YW9lJTqXWF6YxaoKi6Hn4hpYFab6nZaVst4xEId6
        hS7Rhl7IJaGSId3fCCrWv7EDCA==
X-Google-Smtp-Source: APXvYqx5UHQ8nanghfhzg0pFdZd+8kyMjawRO91F3JXx/Hibg1pKAb4WUAy68WuyCcKrcSt7axztAQ==
X-Received: by 2002:a05:620a:1597:: with SMTP id d23mr25900044qkk.226.1553619243524;
        Tue, 26 Mar 2019 09:54:03 -0700 (PDT)
Received: from redhat.com ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id o68sm10908092qkc.89.2019.03.26.09.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 09:54:02 -0700 (PDT)
Date:   Tue, 26 Mar 2019 12:53:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Wang <jasowang@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        eric.auger@redhat.com, joro@8bytes.org,
        tnowicki@caviumnetworks.com, kevin.tian@intel.com,
        Lorenzo.Pieralisi@arm.com, bharat.bhushan@nxp.com,
        Will.Deacon@arm.com, Robin.Murphy@arm.com, Marc.Zyngier@arm.com
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190325084348-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
 <87womn8inf.fsf@morokweng.localdomain>
 <20190129134750-mutt-send-email-mst@kernel.org>
 <6c68f7f7-1b28-6eba-9b8b-2c32efac9701@redhat.com>
 <20190129213137-mutt-send-email-mst@kernel.org>
 <20190130074427.GA29516@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130074427.GA29516@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 08:44:27AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 29, 2019 at 09:36:08PM -0500, Michael S. Tsirkin wrote:
> > This has been discussed ad nauseum. virtio is all about compatibility.
> > Losing a couple of lines of code isn't worth breaking working setups.
> > People that want "just use DMA API no tricks" now have the option.
> > Setting a flag in a feature bit map is literally a single line
> > of code in the hypervisor. So stop pushing for breaking working
> > legacy setups and just fix it in the right place.
> 
> I agree with the legacy aspect.  What I am missing is an extremely
> strong wording that says you SHOULD always set this flag for new
> hosts, including an explanation why.


So as far as power is concerned, IIUC the issue they are struggling with is
that some platforms do not support pass-through mode in the emulated IOMMU.
Disabling PLATFORM_ACCESS is so far a way around that, unfortunately just for
virtio devices.  I would like virtio-iommu to be able to address that need as
well.

-- 
MST
