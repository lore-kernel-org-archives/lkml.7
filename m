Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03705C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C607622CEB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfHSUwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:52:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbfHSUwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:52:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE54111A06;
        Mon, 19 Aug 2019 20:51:59 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31BEA52CE;
        Mon, 19 Aug 2019 20:51:55 +0000 (UTC)
Date:   Mon, 19 Aug 2019 14:51:50 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Ben Luo <luoben@linux.alibaba.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com, linyunsheng@huawei.com
Subject: Re: [PATCH v3 0/3] genirq/vfio: Introduce update_irq_devid and
 optimize VFIO irq ops
Message-ID: <20190819145150.2d30669b@x1.home>
In-Reply-To: <cover.1565857737.git.luoben@linux.alibaba.com>
References: <cover.1565857737.git.luoben@linux.alibaba.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 19 Aug 2019 20:52:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2019 21:02:58 +0800
Ben Luo <luoben@linux.alibaba.com> wrote:

> Currently, VFIO takes a lot of free-then-request-irq actions whenever
> a VM (with device passthru via VFIO) sets irq affinity or mask/unmask
> irq. Those actions only change the cookie data of irqaction or even
> change nothing. The free-then-request-irq not only adds more latency,
> but also increases the risk of losing interrupt, which may lead to a
> VM hung forever in waiting for IO completion

What guest environment is generating this?  Typically I don't see that
Windows or Linux guests bounce the interrupt configuration much.
Thanks,

Alex

> 
> This patchset solved the issue by:
> Patch 2 introduces update_irq_devid to only update dev_id of irqaction
> Patch 3 make use of update_irq_devid and optimize irq operations in VFIO
> 
> changes from v2:
>  - reformat to avoid quoted string split across lines and etc.
> 
> changes from v1:
>  - add Patch 1 to enhance error recovery etc. in free irq per tglx's comments
>  - enhance error recovery code and debugging info in update_irq_devid
>  - use __must_check in external referencing of update_irq_devid
>  - use EXPORT_SYMBOL_GPL for update_irq_devid
>  - reformat code of patch 3 for better readability
> 
> Ben Luo (3):
>   genirq: enhance error recovery code in free irq
>   genirq: introduce update_irq_devid()
>   vfio_pci: make use of update_irq_devid and optimize irq ops
> 
>  drivers/vfio/pci/vfio_pci_intrs.c | 101 +++++++++++++++++++++-------------
>  include/linux/interrupt.h         |   3 ++
>  kernel/irq/manage.c               | 110 +++++++++++++++++++++++++++++++++-----
>  3 files changed, 164 insertions(+), 50 deletions(-)
> 

