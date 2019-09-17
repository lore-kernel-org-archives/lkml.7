Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F855C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 21:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6A92054F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 21:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568755468;
	bh=n6chQUAGcWJ80WhhviuIXFNGVNjiz/fYMESfpx36ZXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S3JS1LkDdB6gUFhtpBPfdr5ytLuVlGWIveQiaAQtDg8Y1IP+M2coMgqJ6fFgtjVrj
	 WCmgrpKrggG3e9Ojn7r/2Dby1daD90YtVN1NoZEArGiEQ1bj+iQnJ2IUCep1JQaYw0
	 QkeIPQv7KNuDjvMeOenh8WjtOzUlYUjJrRMsjFA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfIQVYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 17:24:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfIQVYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 17:24:18 -0400
Received: from C02WT3WMHTD6.wdl.wdc.com (unknown [199.255.45.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8A032054F;
        Tue, 17 Sep 2019 21:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568755457;
        bh=n6chQUAGcWJ80WhhviuIXFNGVNjiz/fYMESfpx36ZXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=joStA6mlr6RJeqaPM3eDWc80PfaUONRdiZPh88bve37kvStjrCIV2lORXNgGbXcr5
         N5E1rp9/KYxLshbuVewfnXXWw+RViRkv5sz4B9WUXLFj98ceFYpVhSr16fCf7Zf3JA
         NjAa2S7GATgBCnQ39O4+Q/1AeThBd5pGD8+QZN1Y=
Date:   Tue, 17 Sep 2019 15:24:14 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        sjg@google.com, Jared Dominguez <jared.dominguez@dell.com>
Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into
 deepest state
Message-ID: <20190917212414.GB39848@C02WT3WMHTD6.wdl.wdc.com>
References: <1568245353-13787-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568245353-13787-1-git-send-email-mario.limonciello@dell.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 06:42:33PM -0500, Mario Limonciello wrote:
> The action of saving the PCI state will cause numerous PCI configuration
> space reads which depending upon the vendor implementation may cause
> the drive to exit the deepest NVMe state.
> 
> In these cases ASPM will typically resolve the PCIe link state and APST
> may resolve the NVMe power state.  However it has also been observed
> that this register access after quiesced will cause PC10 failure
> on some device combinations.
> 
> To resolve this, move the PCI state saving to before SetFeatures has been
> called.  This has been proven to resolve the issue across a 5000 sample
> test on previously failing disk/system combinations.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  drivers/nvme/host/pci.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 732d5b6..9b3fed4 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2894,6 +2894,13 @@ static int nvme_suspend(struct device *dev)
>  	if (ret < 0)
>  		goto unfreeze;
>  
> +	/*
> +	 * A saved state prevents pci pm from generically controlling the
> +	 * device's power. If we're using protocol specific settings, we don't
> +	 * want pci interfering.
> +	 */
> +	pci_save_state(pdev);
> +
>  	ret = nvme_set_power_state(ctrl, ctrl->npss);
>  	if (ret < 0)
>  		goto unfreeze;
> @@ -2908,12 +2915,6 @@ static int nvme_suspend(struct device *dev)
>  		ret = 0;
>  		goto unfreeze;
>  	}
> -	/*
> -	 * A saved state prevents pci pm from generically controlling the
> -	 * device's power. If we're using protocol specific settings, we don't
> -	 * want pci interfering.
> -	 */
> -	pci_save_state(pdev);
>  unfreeze:
>  	nvme_unfreeze(ctrl);
>  	return ret;

In the event that something else fails after the point you've saved
the state, we need to fallback to the behavior for when the driver
doesn't save the state, right?
