Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F31C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3883821924
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568827743;
	bh=M7SNZBXcCiFOmpNM1RhyX6kmDyGHg4qu/nFa+CO6J5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YZMT4M9TApxauIdmNDMB3ssofT6lQdRzJBRkcz2N5rhGYiy3dRJLpH8CRDzpEjXdt
	 CyrHPq83qvhhzxxWHZjDJ6djcqpl07HyATI9uD8sDkQYDdI/Wi6SsFokGwajfcNleX
	 U+LXX5EnjDUmwpSlSHxRFBinGFyR7X8qkT+hcwTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbfIRR3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbfIRR3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:29:02 -0400
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D55BB208C0;
        Wed, 18 Sep 2019 17:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568827741;
        bh=M7SNZBXcCiFOmpNM1RhyX6kmDyGHg4qu/nFa+CO6J5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1t5g0jOYSizU0QAnxEcRb0YGK1Fa0yF/Sa4zBR6ZOzFbOJW1G32upZ9VbqXRgm/Ka
         1lD6GlVA7SNvHCgqk3OKQmROEglF1emr5Fhs+z+T+69nfpPoMf6hw5RDNxKjQlSZfT
         4RscS47PEHrlFiExw8REs7biCMuAUU/vO5SQBZLo=
Date:   Wed, 18 Sep 2019 11:28:59 -0600
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
Message-ID: <20190918172859.GA51420@C02WT3WMHTD6>
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

We would need to clear the saved state here, though. You can also
infact remove the unfreeze label and goto.

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
> -- 
