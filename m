Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22ABC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A14A21902
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfDXNze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:55:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730803AbfDXNzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:55:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C91530BCE59;
        Wed, 24 Apr 2019 13:55:32 +0000 (UTC)
Received: from hmswarspite.think-freely.org (ovpn-121-115.rdu2.redhat.com [10.10.121.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A02561D01;
        Wed, 24 Apr 2019 13:55:30 +0000 (UTC)
Date:   Wed, 24 Apr 2019 09:55:24 -0400
From:   Neil Horman <nhorman@redhat.com>
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, salil.mehta@huawei.com,
        yisen.zhuang@huawei.com, linuxarm@huawei.com,
        Peng Li <lipeng321@huawei.com>
Subject: Re: [PATCH V2 net-next 08/12] net: hns3: stop schedule reset service
 while unloading driver
Message-ID: <20190424135524.GE6661@hmswarspite.think-freely.org>
References: <1556103931-64031-1-git-send-email-tanhuazhong@huawei.com>
 <1556103931-64031-9-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556103931-64031-9-git-send-email-tanhuazhong@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 24 Apr 2019 13:55:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 07:05:27PM +0800, Huazhong Tan wrote:
> This patch uses HCLGE_STATE_REMOVING/HCLGEVF_STATE_REMOVING flag to
> indicate that the driver is unloading, and we should stop new coming
> reset service to be scheduled, otherwise, reset service will access
> some resource which has been freed by unloading.
> 
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
> Signed-off-by: Peng Li <lipeng321@huawei.com>
> ---
> V1->V2: fixes a flag setting error
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 4 +++-
>  drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 4 +++-
>  drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index 4d5568e..ead8308 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -2175,7 +2175,8 @@ static void hclge_mbx_task_schedule(struct hclge_dev *hdev)
>  
>  static void hclge_reset_task_schedule(struct hclge_dev *hdev)
>  {
> -	if (!test_and_set_bit(HCLGE_STATE_RST_SERVICE_SCHED, &hdev->state))
> +	if (!test_bit(HCLGE_STATE_REMOVING, &hdev->state) &&
> +	    !test_and_set_bit(HCLGE_STATE_RST_SERVICE_SCHED, &hdev->state))
>  		schedule_work(&hdev->rst_service_task);
>  }
>  

In what use case do you need an extra bit for this?  From my read, this work
task only gets scheduled from:
1) Interrupt handlers
2) Its own service task

Based on the fact that you are calling cancel_work_sync(...rst_service_task)
from the pci teardown routine, irqs should all be disabled on your devices
already (meaning interrupts shouldn't schedule it), and cancel_work_sync
guarantees that rearming cant happen from within its own service task.

Neil

