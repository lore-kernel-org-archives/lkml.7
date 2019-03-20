Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB570C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C292186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfCTMuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:50:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfCTMuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:50:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3364F308792D;
        Wed, 20 Mar 2019 12:50:18 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61E855D788;
        Wed, 20 Mar 2019 12:50:04 +0000 (UTC)
Message-ID: <f55b768e86e77fd9dc36aa7e2602c4f1fd7cd3b1.camel@redhat.com>
Subject: Re: [PATCH 7/9] nvme/core: add mdev interfaces
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liang Cunming <cunming.liang@intel.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        Fam Zheng <fam@euphon.net>, Amnon Ilan <ailan@redhat.com>,
        John Ferlan <jferlan@redhat.com>
Date:   Wed, 20 Mar 2019 14:50:04 +0200
In-Reply-To: <20190320114621.GC5542@stefanha-x1.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
         <20190319144116.400-8-mlevitsk@redhat.com>
         <20190320114621.GC5542@stefanha-x1.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 20 Mar 2019 12:50:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-20 at 11:46 +0000, Stefan Hajnoczi wrote:
> On Tue, Mar 19, 2019 at 04:41:14PM +0200, Maxim Levitsky wrote:
> > +int nvme_core_register_mdev_driver(struct nvme_mdev_driver *driver_ops)
> > +{
> > +	struct nvme_ctrl *ctrl;
> > +
> > +	if (mdev_driver_interface)
> > +		return -EEXIST;
> > +
> > +	mdev_driver_interface = driver_ops;
> 
> Can mdev_driver_interface be accessed from two CPUs at the same time?
> mdev_driver_interface isn't protected by the mutex.  The state_changed
> functions below also don't protect mdev_driver_interface.

It can be for sure.
However the only time it is updated is when the mdev core module load/unload
routines.

On module load the interface flips from NULL to a pointer to inside of the
module, so this should be safe, and when mdev module unloads, its reference
counter is 0, and all the callers first try to increase it and fail, they don't
call using this interface.

I might still be wrong with this reasoning though.

Best regards,
	Maxim Levitsky

