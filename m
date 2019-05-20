Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF607C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DC5214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390115AbfETNwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:52:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731648AbfETNwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:52:18 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1F7CA5F45FA0FA683575;
        Mon, 20 May 2019 21:52:16 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 May 2019
 21:52:04 +0800
Subject: Re: [PATCH v2] scsi: libsas: no need to join wide port again in
 sas_ex_discover_dev()
To:     Jason Yan <yanaijie@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.vnet.ibm.com>
References: <20190520140600.22861-1-yanaijie@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.com>, <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        <hch@lst.de>, <huangdaode@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <miaoxie@huawei.com>,
        <zhaohongjiang@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7b7c51db-15f3-d06b-ba58-8b6ef618f7d2@huawei.com>
Date:   Mon, 20 May 2019 14:51:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190520140600.22861-1-yanaijie@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2019 15:06, Jason Yan wrote:
> Since we are processing events synchronously now, the second call of
> sas_ex_join_wide_port() in sas_ex_discover_dev() is not needed. There
> will be no races with other works in disco workqueue. So remove the
> second sas_ex_join_wide_port().
>
> I did not change the return value of 'res' to error when discover failed
> because we need to continue to discover other phys if one phy discover
> failed. So let's keep that logic as before and just add a debug log to
> detect the failure. And directly return if second fanout expander
> attatched to the parent expander because it has nothing to do after the
> phy is disabled.
>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---

Reviewed-by: John Garry <john.garry@huawei.com>

