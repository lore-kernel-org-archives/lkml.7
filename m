Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F169C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8642084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfDZNiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:38:54 -0400
Received: from 8bytes.org ([81.169.241.247]:37616 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfDZNit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:38:49 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id AC762447; Fri, 26 Apr 2019 15:38:48 +0200 (CEST)
Date:   Fri, 26 Apr 2019 15:38:46 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Pan Bian <bianpan2016@163.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: iommu/vt-d: drop mm use count if address is not canonical
Message-ID: <20190426133846.GC24576@8bytes.org>
References: <1555492377-79859-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555492377-79859-1-git-send-email-bianpan2016@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding more people. ]

On Wed, Apr 17, 2019 at 05:12:57PM +0800, Pan Bian wrote:
> The use count of svm->mm is incremented by mmget_not_zero. However, it
> is not dropped when the address is not canonical. This patch fixes the
> bug.
> 
> Fixes: 9d8c3af31607("iommu/vt-d: IOMMU Page Request needs to check if
> address is canonical.")
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/iommu/intel-svm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 3a4b09a..2630d2e 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -574,8 +574,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  			goto bad_req;
>  
>  		/* If address is not canonical, return invalid response */
> -		if (!is_canonical_address(address))
> +		if (!is_canonical_address(address)) {
> +			mmput(svm->mm);
>  			goto bad_req;
> +		}
>  
>  		down_read(&svm->mm->mmap_sem);
>  		vma = find_extend_vma(svm->mm, address);

I think it is better to move the canonical address check before
mmget_not_zero() like in the diff below. But I let David and Jacob
comment on this.

Regards,

	Joerg

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 8f87304f915c..5e9e1eee8336 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -586,14 +586,15 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		 * any faults on kernel addresses. */
 		if (!svm->mm)
 			goto bad_req;
-		/* If the mm is already defunct, don't handle faults. */
-		if (!mmget_not_zero(svm->mm))
-			goto bad_req;
 
 		/* If address is not canonical, return invalid response */
 		if (!is_canonical_address(address))
 			goto bad_req;
 
+		/* If the mm is already defunct, don't handle faults. */
+		if (!mmget_not_zero(svm->mm))
+			goto bad_req;
+
 		down_read(&svm->mm->mmap_sem);
 		vma = find_extend_vma(svm->mm, address);
 		if (!vma || address < vma->vm_start)
