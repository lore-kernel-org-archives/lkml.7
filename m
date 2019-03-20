Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5ECC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBC5213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfCTQs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:48:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfCTQs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:48:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E34BB307D981;
        Wed, 20 Mar 2019 16:48:25 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE7CD5D71B;
        Wed, 20 Mar 2019 16:48:17 +0000 (UTC)
Message-ID: <e0491452300bca37a716499b6ecd4e9f1c2f8c99.camel@redhat.com>
Subject: Re: [PATCH 0/9] RFC: NVME VFIO mediated device
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        linux-nvme@lists.infradead.org
Cc:     Fam Zheng <fam@euphon.net>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, kvm@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang Cunming <cunming.liang@intel.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        John Ferlan <jferlan@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Amnon Ilan <ailan@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Date:   Wed, 20 Mar 2019 18:48:17 +0200
In-Reply-To: <1553094528.65329.29.camel@acm.org>
References: <20190319144116.400-1-mlevitsk@redhat.com>
         <1553094528.65329.29.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 20 Mar 2019 16:48:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-20 at 08:08 -0700, Bart Van Assche wrote:
> On Tue, 2019-03-19 at 16:41 +0200, Maxim Levitsky wrote:
> > * Polling kernel thread is used. The polling is stopped after a 
> > predefined timeout (1/2 sec by default).
> > Support for all interrupt driven mode is planned, and it shows promising
> > results.
> 
> Which cgroup will the CPU cycles used for polling be attributed to? Can the
> polling code be moved into user space such that it becomes easy to identify
> which process needs most CPU cycles for polling and such that the polling
> CPU cycles are attributed to the proper cgroup?


Currently there is a single IO thread per each virtual controller instance.
I would prefer to keep all the driver in the kernel, but I think I can make it
cgroup aware, in a simiar way this is done in vhost-net, and vhost-scsi.

Best regards,
	Maxim Levitsky


> Thanks,
> 
> Bart.

