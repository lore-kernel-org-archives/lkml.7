Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABD0C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5301420811
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbfDYLlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:41:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfDYLlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:41:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3640C04FFF1;
        Thu, 25 Apr 2019 11:41:06 +0000 (UTC)
Received: from hmswarspite.think-freely.org (ovpn-121-75.rdu2.redhat.com [10.10.121.75])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD23E60C70;
        Thu, 25 Apr 2019 11:41:05 +0000 (UTC)
Date:   Thu, 25 Apr 2019 07:41:04 -0400
From:   Neil Horman <nhorman@redhat.com>
To:     tanhuazhong <tanhuazhong@huawei.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, salil.mehta@huawei.com,
        yisen.zhuang@huawei.com, linuxarm@huawei.com,
        Peng Li <lipeng321@huawei.com>
Subject: Re: [PATCH V2 net-next 08/12] net: hns3: stop schedule reset service
 while unloading driver
Message-ID: <20190425114104.GC15861@hmswarspite.think-freely.org>
References: <1556103931-64031-1-git-send-email-tanhuazhong@huawei.com>
 <1556103931-64031-9-git-send-email-tanhuazhong@huawei.com>
 <20190424135524.GE6661@hmswarspite.think-freely.org>
 <be5ba555-31bb-8803-66fa-51bfab70bde8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be5ba555-31bb-8803-66fa-51bfab70bde8@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 25 Apr 2019 11:41:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 02:06:07PM +0800, tanhuazhong wrote:
> 
> 
> On 2019/4/24 21:55, Neil Horman wrote:
> > On Wed, Apr 24, 2019 at 07:05:27PM +0800, Huazhong Tan wrote:
> > > This patch uses HCLGE_STATE_REMOVING/HCLGEVF_STATE_REMOVING flag to
> > > indicate that the driver is unloading, and we should stop new coming
> > > reset service to be scheduled, otherwise, reset service will access
> > > some resource which has been freed by unloading.
> > > 
> > > Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
> > > Signed-off-by: Peng Li <lipeng321@huawei.com>
> > > ---
> > > V1->V2: fixes a flag setting error
> > > ---
> > >   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 4 +++-
> > >   drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 4 +++-
> > >   drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h | 1 +
> > >   3 files changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> > > index 4d5568e..ead8308 100644
> > > --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> > > +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> > > @@ -2175,7 +2175,8 @@ static void hclge_mbx_task_schedule(struct hclge_dev *hdev)
> > >   static void hclge_reset_task_schedule(struct hclge_dev *hdev)
> > >   {
> > > -	if (!test_and_set_bit(HCLGE_STATE_RST_SERVICE_SCHED, &hdev->state))
> > > +	if (!test_bit(HCLGE_STATE_REMOVING, &hdev->state) &&
> > > +	    !test_and_set_bit(HCLGE_STATE_RST_SERVICE_SCHED, &hdev->state))
> > >   		schedule_work(&hdev->rst_service_task);
> > >   }
> > 
> > In what use case do you need an extra bit for this?  From my read, this work
> > task only gets scheduled from:
> > 1) Interrupt handlers
> > 2) Its own service task
> > 
> > Based on the fact that you are calling cancel_work_sync(...rst_service_task)
> > from the pci teardown routine, irqs should all be disabled on your devices
> > already (meaning interrupts shouldn't schedule it), and cancel_work_sync
> > guarantees that rearming cant happen from within its own service task.
> > 
> > Neil
> > 
> 
> Beside these two cases, when the client detects an error and requests a
> reset, it will call hclge_reset_event and schedule the reset work task to
> deal with the request. This may happen after calling
> cancel_work_sync(...rst_service_task) from the pci teardown routine.
> 
> Best Regards, Huazhong
> 
But that is handled from either:
1) hns_roce_v2_msix_interrupt_abn
or
2) hns3_nic_net_timeout
or
3) hns3_slot_reset

You should be protected from (1) because interrupts should be disabled before
you call cancel_work_syn.

You should be protected from (2) because the network interface will have been
brought down first (disabling the watchdog timer for the any interfaces on this
hardware

You should be protected from (3) because you are tearing down the pci device
anyway, and the pci subsystem should be ignoring resets

Neil

> > 
> > .
> > 
> 
