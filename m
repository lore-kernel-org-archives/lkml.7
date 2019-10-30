Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970ACCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7443520717
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfJ3JdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:33:19 -0400
Received: from 8bytes.org ([81.169.241.247]:49992 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:33:16 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3415334A; Wed, 30 Oct 2019 10:33:15 +0100 (CET)
Date:   Wed, 30 Oct 2019 10:33:13 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     John Donnelly <John.P.Donnelly@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 ] iommu/vt-d: Fix panic after kexec -p for kdump
Message-ID: <20191030093313.GA7254@8bytes.org>
References: <f856dfd6-0483-fb97-033c-1cda83ead79f@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f856dfd6-0483-fb97-033c-1cda83ead79f@Oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Mon, Oct 21, 2019 at 09:48:10PM -0500, John Donnelly wrote:
> Fixes: 8af46c784ecfe ("iommu/vt-d: Implement is_attach_deferred iommu ops
> entry")
> Cc: stable@vger.kernel.org # v5.3+
> 
> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> 
> ---
>  drivers/iommu/intel-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index c4e0e4a9ee9e..f83a9a302f8e 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2783,7 +2783,7 @@ static int identity_mapping(struct device *dev)
>  	struct device_domain_info *info;
> 
>  	info = dev->archdata.iommu;
> -	if (info && info != DUMMY_DEVICE_DOMAIN_INFO)
> +	if (info && info != DUMMY_DEVICE_DOMAIN_INFO && info !=
> DEFER_DEVICE_DOMAIN_INFO)
>  		return (info->domain == si_domain);
> 
>  	return 0;

I applied your patch for v5.4, but it needed manual fixup because your
mailer screwed up the patch format by inserting line-breaks and
converting tabs to spaces.

Please consider to setup and use 'git send-email' for your next patches.
This will get it all right and makes life easier for maintainers that
want to apply your patches.

Thanks,

	Joerg
