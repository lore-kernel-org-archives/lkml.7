Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57A1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A781821473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfDHNcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:32:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfDHNcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:32:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6BB29301D680;
        Mon,  8 Apr 2019 13:32:42 +0000 (UTC)
Received: from localhost (dhcp-192-206.str.redhat.com [10.33.192.206])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F20D61001DC7;
        Mon,  8 Apr 2019 13:32:39 +0000 (UTC)
Date:   Mon, 8 Apr 2019 15:32:38 +0200
From:   Jens Freimann <jfreimann@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] virtio: Honour 'may_reduce_num' in vring_create_virtqueue
Message-ID: <20190408133238.2ahk6u3k7mv7nd5g@jenstp.localdomain>
References: <20190408123322.24086-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190408123322.24086-1-cohuck@redhat.com>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 08 Apr 2019 13:32:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 02:33:22PM +0200, Cornelia Huck wrote:
>vring_create_virtqueue() allows the caller to specify via the
>may_reduce_num parameter whether the vring code is allowed to
>allocate a smaller ring than specified.
>
>However, the split ring allocation code tries to allocate a
>smaller ring on allocation failure regardless of what the
>caller specified. This may cause trouble for e.g. virtio-pci
>in legacy mode, which does not support ring resizing. (The
>packed ring code does not resize in any case.)
>
>Let's fix this by bailing out immediately in the split ring code
>if the requested size cannot be allocated and may_reduce_num has
>not been specified.
>
>While at it, fix a typo in the usage instructions.
>
>Fixes: 2a2d1382fe9d ("virtio: Add improved queue allocation API")
>Cc: stable@vger.kernel.org # v4.6+
>Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>---
> drivers/virtio/virtio_ring.c | 2 ++
> include/linux/virtio_ring.h  | 2 +-
> 2 files changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Jens Freimann <jfreimann@redhat.com>


