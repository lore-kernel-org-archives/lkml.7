Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55950C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208922077B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfCRGV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 02:21:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfCRGV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 02:21:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09387308219C;
        Mon, 18 Mar 2019 06:21:59 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D32BC5D9C8;
        Mon, 18 Mar 2019 06:21:52 +0000 (UTC)
Date:   Mon, 18 Mar 2019 14:21:50 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Wang <jasowang@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Virtio-scsi multiqueue irq affinity
Message-ID: <20190318062150.GC6654@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 18 Mar 2019 06:21:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christoph & all,

I noticed that starting from commit 0d9f0a52c8b9 ("virtio_scsi: use
virtio IRQ affinity", 2017-02-27) the virtio scsi driver is using a
new way (via irq_create_affinity_masks()) to automatically initialize
IRQ affinities for the multi-queues, which is different comparing to
all the other virtio devices (like virtio-net, which still uses
virtqueue_set_affinity(), which is actually, irq_set_affinity_hint()).

Firstly, it will definitely broke some of the userspace programs with
that when the scripts wanted to do the bindings explicitly like before
and they could simply fail with -EIO now every time when echoing to
/proc/irq/N/smp_affinity of any of the multi-queues (see
write_irq_affinity()).

Is there any specific reason to do it with the new way?  Since AFAIU
we should still allow the system admins to decide what to do for such
configurations, .e.g., what if we only want to provision half of the
CPU resources to handle IRQs for a specific virtio-scsi controller?
We won't be able to achieve that with current policy.  Or, could this
be a question for the IRQ system (irq_create_affinity_masks()) in
general?  Any special considerations behind the big picture?

I believe I must have missed some contexts here and there... but I'd
like to raise the question up.  Say, if the new way is preferred and
attempted, maybe it would worth it to spread the idea to the rest of
the virtio drivers who support multi-queues as well.

Thanks,

-- 
Peter Xu
