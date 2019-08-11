Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2673CC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 05:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DC9208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 05:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfHKF4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 01:56:12 -0400
Received: from verein.lst.de ([213.95.11.211]:38698 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfHKF4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 01:56:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0328568BFE; Sun, 11 Aug 2019 07:56:07 +0200 (CEST)
Date:   Sun, 11 Aug 2019 07:56:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ram Pai <linuxram@us.ibm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linuxppc-devel@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is
 encrypted
Message-ID: <20190811055607.GA12488@lst.de>
References: <87zhrj8kcp.fsf@morokweng.localdomain> <20190810143038-mutt-send-email-mst@kernel.org> <20190810220702.GA5964@ram.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810220702.GA5964@ram.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sev_active() is gone now in linux-next, at least as a global API.

And once again this is entirely going in the wrong direction.  The only
way using the DMA API is going to work at all is if the device is ready
for it.  So we need a flag on the virtio device, exposed by the
hypervisor (or hardware for hw virtio devices) that says:  hey, I'm real,
don't take a shortcut.

And that means on power and s390 qemu will always have to set thos if
you want to be ready for the ultravisor and co games.  It's not like we
haven't been through this a few times before, have we?
