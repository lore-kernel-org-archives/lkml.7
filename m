Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30E4C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 19:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21C3206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 19:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565811227;
	bh=91O6hgFyoDnKufdomk36oyteRxgbd+1Vn5lYowROPeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mGReLXmHWnLdy5/eHOESFufqGVrmSfQ9FbhzfPRLostddXYZUSQO3G61DzDuSoFEE
	 rkYqPHfLK07j32I4f/1chS7e4cfVcN3NUNm6IbM6jsBBRDX97X3SCBmQqvwRcjri9m
	 G8bhwhsDcnPGnJIvf29IoxI+s9gpoXJnGRCub48M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfHNTdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 15:33:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:36906 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfHNTdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 15:33:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 12:33:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,386,1559545200"; 
   d="scan'208";a="178252246"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2019 12:33:45 -0700
Date:   Wed, 14 Aug 2019 13:31:32 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        "sjg@google.com" <sjg@google.com>,
        Charles Hyde <charles.hyde@dellteam.com>,
        Jared Dominguez <jared.dominguez@dell.com>
Subject: Re: [PATCH] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
Message-ID: <20190814193132.GD3256@localhost.localdomain>
References: <1565798749-15672-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565798749-15672-1-git-send-email-mario.limonciello@dell.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 09:05:49AM -0700, Mario Limonciello wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8f3fbe5..47c7754 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2251,6 +2251,29 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
>  		.vid = 0x1179,
>  		.mn = "THNSF5256GPUK TOSHIBA",
>  		.quirks = NVME_QUIRK_NO_APST,
> +	},
> +	/*
> +	 * This LiteON CL1 firmware version has a race condition associated with
> +	 * actions related to suspend to idle.  LiteON has resolved the problem
> +	 * in future firmware.
> +	 */
> +	{
> +		.vid = 0x14a4,
> +		.mn = "CL1-3D128-Q11 NVMe LITEON 128GB",
> +		.fr = "22301111",
> +		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
> +	},
> +	{
> +		.vid = 0x14a4,
> +		.mn = "CL1-3D256-Q11 NVMe LITEON 256GB",
> +		.fr = "22301111",
> +		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
> +	},
> +	{
> +		.vid = 0x14a4,
> +		.mn = "CL1-3D512-Q11 NVMe LITEON 512GB",
> +		.fr = "22301111",
> +		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
>  	}
>  };

Are there models from this vendor with this same 'fr' that don't need
this quirk? If not, you can leave .mn blank and just use a single entry.
