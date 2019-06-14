Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4662C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6422168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfFNNmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:42:39 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:22443 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfFNNmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:42:38 -0400
Received: from localhost (varun.asicdesigners.com [10.193.190.56])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x5EDfkhn025181;
        Fri, 14 Jun 2019 06:41:47 -0700
Date:   Fri, 14 Jun 2019 19:11:44 +0530
From:   Varun Prakash <varun@chelsio.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Christie <mchristi@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        varun@chelsio.com
Subject: Re: [PATCH -next] cxgbit: remove set but not used variable 'ppmax'
Message-ID: <20190614134143.GA1630@chelsio.com>
References: <20190614024413.110449-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614024413.110449-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 02:44:13AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/target/iscsi/cxgbit/cxgbit_ddp.c: In function 'cxgbit_ddp_init':
> drivers/target/iscsi/cxgbit/cxgbit_ddp.c:303:15: warning:
>  variable 'ppmax' set but not used [-Wunused-but-set-variable]
> 
> It's not used since commit a248384e6420 ("cxgb4/libcxgb/cxgb4i/cxgbit:
> enable eDRAM page pods for iSCSI")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/target/iscsi/cxgbit/cxgbit_ddp.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/target/iscsi/cxgbit/cxgbit_ddp.c b/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
> index 1443ef045a5f..fe1be5feaf21 100644
> --- a/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
> +++ b/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
> @@ -300,7 +300,6 @@ int cxgbit_ddp_init(struct cxgbit_device *cdev)
>  	struct cxgb4_lld_info *lldi = &cdev->lldi;
>  	struct net_device *ndev = cdev->lldi.ports[0];
>  	struct cxgbi_tag_format tformat;
> -	unsigned int ppmax;
>  	int ret, i;
>  
>  	if (!lldi->vr->iscsi.size) {
> @@ -308,8 +307,6 @@ int cxgbit_ddp_init(struct cxgbit_device *cdev)
>  		return -EACCES;
>  	}
>  
> -	ppmax = lldi->vr->iscsi.size >> PPOD_SIZE_SHIFT;
> -
>  	memset(&tformat, 0, sizeof(struct cxgbi_tag_format));
>  	for (i = 0; i < 4; i++)
>  		tformat.pgsz_order[i] = (lldi->iscsi_pgsz_order >> (i << 3))
> 

Acked-by: Varun Prakash <varun@chelsio.com>

This patch is for net-next tree.
