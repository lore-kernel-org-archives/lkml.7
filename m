Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369CDC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1679D20873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390941AbfGRShT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:37:19 -0400
Received: from smtprelay0099.hostedemail.com ([216.40.44.99]:40318 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726649AbfGRShT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:37:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E6E7A100E86C1;
        Thu, 18 Jul 2019 18:37:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: story87_557edf194a62
X-Filterd-Recvd-Size: 3234
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu, 18 Jul 2019 18:37:16 +0000 (UTC)
Message-ID: <649403d7dbf2e4e21a96bd9a20b7cb659b97fe38.camel@perches.com>
Subject: Re: [PATCH] scsi: pmcraid: Use dma_pool_zalloc rather than
 dma_pool_alloc
From:   Joe Perches <joe@perches.com>
To:     Vasyl Gomonovych <gomonovych@gmail.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 18 Jul 2019 11:37:14 -0700
In-Reply-To: <20190718181051.22882-1-gomonovych@gmail.com>
References: <20190718181051.22882-1-gomonovych@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-18 at 20:10 +0200, Vasyl Gomonovych wrote:
> Use *_pool_zalloc rather than *_pool_alloc followed by memset with 0
> The semantic patch that makes this change is available
> in scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci.
[]
> diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
[]
> @@ -4653,9 +4653,7 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < PMCRAID_MAX_CMD; i++) {
> -		pinstance->cmd_list[i]->ioa_cb =
> -			dma_pool_alloc(
> -				pinstance->control_pool,
> +		pinstance->cmd_list[i]->ioa_cb = dma_pool_zalloc(pinstance->control_pool,
>  				GFP_KERNEL,
>  				&(pinstance->cmd_list[i]->ioa_cb_bus_addr));
>  
> @@ -4663,8 +4661,6 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
>  			pmcraid_release_control_blocks(pinstance, i);
>  			return -ENOMEM;
>  		}
> -		memset(pinstance->cmd_list[i]->ioa_cb, 0,
> -			sizeof(struct pmcraid_control_block));
>  	}
>  	return 0;
>  }

While this change is somewhat overdone as only
dma_pool_alloc could be changed to dma_pool_zalloc
on the same line without rewrapping other arguments,
I'd generally write this with a temporary like:
---
 drivers/scsi/pmcraid.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 71ff3936da4f..88e7b18ad44d 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4653,19 +4653,17 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
 		return -ENOMEM;
 
 	for (i = 0; i < PMCRAID_MAX_CMD; i++) {
-		pinstance->cmd_list[i]->ioa_cb =
-			dma_pool_alloc(
-				pinstance->control_pool,
-				GFP_KERNEL,
-				&(pinstance->cmd_list[i]->ioa_cb_bus_addr));
+		struct pmcraid_cmd *cmd = pinstance->cmd_list[i];
 
-		if (!pinstance->cmd_list[i]->ioa_cb) {
+		cmd->ioa_cb = dma_pool_zalloc(pinstance->control_pool,
+					      GFP_KERNEL,
+					      &cmd->ioa_cb_bus_addr);
+		if (!cmd->ioa_cb) {
 			pmcraid_release_control_blocks(pinstance, i);
 			return -ENOMEM;
 		}
-		memset(pinstance->cmd_list[i]->ioa_cb, 0,
-			sizeof(struct pmcraid_control_block));
 	}
+
 	return 0;
 }
 

