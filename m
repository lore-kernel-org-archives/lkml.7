Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9218BC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69516206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 17:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfIMRoz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 13:44:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731061AbfIMRoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 13:44:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8BB0418C4260;
        Fri, 13 Sep 2019 17:44:54 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3AF95C28C;
        Fri, 13 Sep 2019 17:44:53 +0000 (UTC)
Date:   Fri, 13 Sep 2019 11:44:52 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Ben Luo <luoben@linux.alibaba.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com
Subject: Re: [PATCH v6 0/3] genirq/vfio: Introduce irq_update_devid() and
 optimize VFIO irq ops
Message-ID: <20190913114452.5e05d8c4@x1.home>
In-Reply-To: <abb4080f-dfe2-1882-4bde-51bb7e660d4a@linux.alibaba.com>
References: <cover.1567394624.git.luoben@linux.alibaba.com>
        <abb4080f-dfe2-1882-4bde-51bb7e660d4a@linux.alibaba.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Fri, 13 Sep 2019 17:44:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2019 14:30:16 +0800
Ben Luo <luoben@linux.alibaba.com> wrote:

> A friendly reminder.

The vfio patch looks ok to me.  Thomas, do you have further comments or
a preference on how to merge these?  I'd tend to prefer the vfio
changes through my branch for testing and can pull the irq changes with
your approval, but we could do the reverse or split them and I could
follow with the vfio change once the irq changes are in mainline.
Thanks,

Alex

> 在 2019/9/2 下午12:01, Ben Luo 写道:
> > Currently, VFIO takes a free-then-request-irq way to do interrupt
> > affinity setting and masking/unmasking for a VM with device passthru
> > via VFIO. Sometimes it only changes the cookie data of irqaction or even
> > changes nothing. The free-then-request-irq not only adds more latency,
> > but also increases the risk of losing interrupt, which may lead to a
> > VM hang forever in waiting for IO completion
> >
> > This patchset solved the issue by:
> > Patch 2 introduces irq_update_devid() to only update dev_id of irqaction
> > Patch 3 make use of this function and optimize irq operations in VFIO
> >
> > changes from v5:
> >   - Patch 3: remove an error log to avoid potential DDoS attacking
> >   _ Patch 3: fix typo in comment
> >
> > changes from v4:
> >   - Patch 3: follow the previous behavior to disable interrupt on error path
> >   - Patch 3: do irqbypass registration before update or free the interrupt
> >   - Patch 3: add more comments
> >
> > changes from v3:
> >   - Patch 2: rename the new function to irq_update_devid()
> >   - Patch 2: use disbale_irq() to avoid a twist for threaded interrupt
> >   - ALL: amend commit messages and code comments
> >
> > changes from v2:
> >   - reformat to avoid quoted string split across lines and etc.
> >
> > changes from v1:
> >   - add Patch 1 to enhance error recovery etc. in free irq per tglx's comments
> >   - enhance error recovery code and debugging info in irq_update_devid
> >   - use __must_check in external referencing of this function
> >   - use EXPORT_SYMBOL_GPL for irq_update_devid
> >   - reformat code of patch 3 for better readability
> >
> > Ben Luo (3):
> >    genirq: enhance error recovery code in free irq
> >    genirq: introduce irq_update_devid()
> >    vfio/pci: make use of irq_update_devid() and optimize irq ops
> >
> >   drivers/vfio/pci/vfio_pci_intrs.c | 118 ++++++++++++++++++++++++++------------
> >   include/linux/interrupt.h         |   3 +
> >   kernel/irq/manage.c               | 105 +++++++++++++++++++++++++++++----
> >   3 files changed, 177 insertions(+), 49 deletions(-)
> >  

