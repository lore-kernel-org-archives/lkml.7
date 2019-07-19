Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CA1C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 15:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14922173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 15:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfGSPOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 11:14:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfGSPOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 11:14:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42B3FB2DDB;
        Fri, 19 Jul 2019 15:14:32 +0000 (UTC)
Received: from redhat.com (ovpn-124-174.rdu2.redhat.com [10.10.124.174])
        by smtp.corp.redhat.com (Postfix) with SMTP id D80FB63F66;
        Fri, 19 Jul 2019 15:14:29 +0000 (UTC)
Date:   Fri, 19 Jul 2019 11:14:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Fei Li <lifei.shirley@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Fam Zheng <zhengfeiran@bytedance.com>
Subject: Re: [PATCH v1 0/2] virtio-mmio: support multiple interrupt vectors
Message-ID: <20190719110852-mutt-send-email-mst@kernel.org>
References: <20190719133135.32418-1-lifei.shirley@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719133135.32418-1-lifei.shirley@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 19 Jul 2019 15:14:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 09:31:33PM +0800, Fei Li wrote:
> Hi,
> 
> This patch series implements multiple interrupt vectors support for
> virtio-mmio device. This is especially useful for multiqueue vhost-net
> device when using firecracker micro-vms as the guest.
> 
> Test result:
> With 8 vcpus & 8 net queues set, one vhost-net device with 8 irqs can
> receive 9 times more pps comparing with only one irq:
> - 564830.38 rxpck/s for 8 irqs on
> - 67665.06 rxpck/s for 1 irq on
> 
> Please help to review, thanks!
> 
> Have a nice day
> Fei


Interesting. The spec says though:

	4.2.3.4
	Notifications From The Device
	The memory mapped virtio device is using a single, dedicated interrupt signal, which is asserted when at
	least one of the bits described in the description of InterruptStatus is set. This is how the device sends a
	used buffer notification or a configuration change notification to the device.


So I'm guessing we need to change the host/guest interface?
If true pls cc virtio-dev.

Also, do we need to update dt bindings documentation?

> 
> Fam Zheng (1):
>   virtio-mmio: Process vrings more proactively
> 
> Fei Li (1):
>   virtio-mmio: support multiple interrupt vectors
> 
>  drivers/virtio/virtio_mmio.c | 238 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 196 insertions(+), 42 deletions(-)
> 
> -- 
> 2.11.0
