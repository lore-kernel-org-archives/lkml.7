Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F62C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0A2208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfHLMN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:13:29 -0400
Received: from verein.lst.de ([213.95.11.211]:47869 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfHLMN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:13:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 32BC4227A81; Mon, 12 Aug 2019 14:13:25 +0200 (CEST)
Date:   Mon, 12 Aug 2019 14:13:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ram Pai <linuxram@us.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linuxppc-devel@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is
 encrypted
Message-ID: <20190812121324.GA9405@lst.de>
References: <87zhrj8kcp.fsf@morokweng.localdomain> <20190810143038-mutt-send-email-mst@kernel.org> <20190810220702.GA5964@ram.ibm.com> <20190811055607.GA12488@lst.de> <20190811064621.GB5964@ram.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811064621.GB5964@ram.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 11:46:21PM -0700, Ram Pai wrote:
> If the hypervisor (hardware for hw virtio devices) does not mandate a
> DMA API, why is it illegal for the driver to request, special handling
> of its i/o buffers? Why are we associating this special handling to
> always mean, some DMA address translation? Can't there be 
> any other kind of special handling needs, that has nothing to do with
> DMA address translation?

I don't think it is illegal per se.  It is however completely broken
if we do that decision on a system weide scale rather than properly
requesting it through a per-device flag in the normal virtio framework.
