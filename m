Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3322EC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1235620651
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfHLMPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:15:40 -0400
Received: from verein.lst.de ([213.95.11.211]:47888 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfHLMPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:15:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EC352227A8C; Mon, 12 Aug 2019 14:15:33 +0200 (CEST)
Date:   Mon, 12 Aug 2019 14:15:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is
 encrypted
Message-ID: <20190812121532.GB9405@lst.de>
References: <87zhrj8kcp.fsf@morokweng.localdomain> <20190810143038-mutt-send-email-mst@kernel.org> <20190810220702.GA5964@ram.ibm.com> <20190811055607.GA12488@lst.de> <20190811044431-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811044431-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 04:55:27AM -0400, Michael S. Tsirkin wrote:
> On Sun, Aug 11, 2019 at 07:56:07AM +0200, Christoph Hellwig wrote:
> > So we need a flag on the virtio device, exposed by the
> > hypervisor (or hardware for hw virtio devices) that says:  hey, I'm real,
> > don't take a shortcut.
> 
> The point here is that it's actually still not real. So we would still
> use a physical address. However Linux decides that it wants extra
> security by moving all data through the bounce buffer.  The distinction
> made is that one can actually give device a physical address of the
> bounce buffer.

Sure.  The problem is just that you keep piling hacks on top of hacks.
We need the per-device flag anyway to properly support hardware virtio
device in all circumstances.  Instead of coming up with another ad-hoc
hack to force DMA uses implement that one proper bit and reuse it here.
