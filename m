Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57279C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC06218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfCURFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:05:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfCURFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:05:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D827C307D840;
        Thu, 21 Mar 2019 17:05:03 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22A521018A30;
        Thu, 21 Mar 2019 17:04:50 +0000 (UTC)
Message-ID: <8698ad583b1cfe86afc3d5440be630fc3e8e0680.camel@redhat.com>
Subject: Re:
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Felipe Franciosi <felipe@nutanix.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Harris, James R" <james.r.harris@intel.com>,
        Liang Cunming <cunming.liang@intel.com>,
        Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thanos Makatos <thanos.makatos@nutanix.com>,
        John Ferlan <jferlan@redhat.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Amnon Ilan <ailan@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Date:   Thu, 21 Mar 2019 19:04:50 +0200
In-Reply-To: <E217011E-C273-442D-AF99-84D3CD63FE77@nutanix.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
         <488768D7-1396-4DD1-A648-C86E5CF7DB2F@nutanix.com>
         <42f444d22363bc747f4ad75e9f0c27b40a810631.camel@redhat.com>
         <20190321161239.GH31434@stefanha-x1.localdomain>
         <20190321162140.GA29342@localhost.localdomain>
         <E217011E-C273-442D-AF99-84D3CD63FE77@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 21 Mar 2019 17:05:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-21 at 16:41 +0000, Felipe Franciosi wrote:
> > On Mar 21, 2019, at 4:21 PM, Keith Busch <kbusch@kernel.org> wrote:
> > 
> > On Thu, Mar 21, 2019 at 04:12:39PM +0000, Stefan Hajnoczi wrote:
> > > mdev-nvme seems like a duplication of SPDK.  The performance is not
> > > better and the features are more limited, so why focus on this approach?
> > > 
> > > One argument might be that the kernel NVMe subsystem wants to offer this
> > > functionality and loading the kernel module is more convenient than
> > > managing SPDK to some users.
> > > 
> > > Thoughts?
> > 
> > Doesn't SPDK bind a controller to a single process? mdev binds to
> > namespaces (or their partitions), so you could have many mdev's assigned
> > to many VMs accessing a single controller.
> 
> Yes, it binds to a single process which can drive the datapath of multiple
> virtual controllers for multiple VMs (similar to what you described for mdev).
> You can therefore efficiently poll multiple VM submission queues (and multiple
> device completion queues) from a single physical CPU.
> 
> The same could be done in the kernel, but the code gets complicated as you add
> more functionality to it. As this is a direct interface with an untrusted
> front-end (the guest), it's also arguably safer to do in userspace.
> 
> Worth noting: you can eventually have a single physical core polling all sorts
> of virtual devices (eg. virtual storage or network controllers) very
> efficiently. And this is quite configurable, too. In the interest of fairness,
> performance or efficiency, you can choose to dynamically add or remove queues
> to the poll thread or spawn more threads and redistribute the work.
> 
> F.

Note though that SPDK doesn't support sharing the device between host and the
guests, it takes over the nvme device, thus it makes the kernel nvme driver
unbind from it.

My driver creates a polling thread per guest, but its trivial to add option to
use the same polling thread for many guests if there need for that.

Best regards,
	Maxim Levitsky


