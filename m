Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D17C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C096218A3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562331009;
	bh=SkovIuVVyMzxFaOZoi3i2O3ZZrHSAu1M22ejXxbkKQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=AiiSw0AfqVhuK7kBcDUpj54yUxZL9knFqZsjb6Kz3yG8zLfl/PFduzedaIyhzUxFx
	 TDVUGpeWMiHEzmc+Ny0OicSCOwziuoV1V784JyT/dlmTSXRcFeo4laCRMkVx9GaaKD
	 SLf9xycNAjYfCXv58Kswd0I6Pqh1gqo5XCeWj+4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfGEMuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbfGEMuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:50:07 -0400
Received: from localhost (unknown [122.167.76.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C2E62184C;
        Fri,  5 Jul 2019 12:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562331006;
        bh=SkovIuVVyMzxFaOZoi3i2O3ZZrHSAu1M22ejXxbkKQw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bCrhMQNjtA9DVZoUzobukEaip6FmeXbLASfbZAuxtV8yRQgYaUCv6wTUQMIYNZgGU
         tfrpEoPDeuagdnvy4wjXW5nsfjkaVrp72kkqyPXvjJjXphh2ei+eBpCPsofGJGhILQ
         XOdUk4T3JIfbFC4y2LBBSZGE4lVYSsAhDg8Obk5w=
Date:   Fri, 5 Jul 2019 18:16:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Robin Gong <yibin.gong@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: imx-sdma: fix use-after-free on probe error
 path
Message-ID: <20190705124646.GD2911@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiVsUZwCUEsqRk-YtZPGYxsqzHzD7U5GeeHyAa2Yw9Z6WA@mail.gmail.com>
 <20190624140731.24080-1-TheSven73@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-06-19, 10:07, Sven Van Asbroeck wrote:

Quoting orignal patch for better context:

> +	if (pdata) {
> +		ret = sdma_get_firmware(sdma, pdata->fw_name);
> +		if (ret)
> +			dev_warn(&pdev->dev, "failed to get firmware from platform data\n");
> +	} else {
> +		/*
> +		 * Because that device tree does not encode ROM script address,
> +		 * the RAM script in firmware is mandatory for device tree
> +		 * probe, otherwise it fails.
> +		 */
> +		ret = of_property_read_string(np, "fsl,sdma-ram-script-name",
> +					      &fw_name);
> +		if (ret)
> +			dev_warn(&pdev->dev, "failed to get firmware name\n");
> +		else {
> +			ret = sdma_get_firmware(sdma, fw_name);
> +			if (ret)
> +				dev_warn(&pdev->dev, "failed to get firmware from device tree\n");
> +		}
> +	}
> +

On 05-07-19, 08:26, Sven Van Asbroeck wrote:
> Hi Vinod,
> 
> On Fri, Jul 5, 2019 at 3:32 AM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > > +             if (ret)
> > > +                     dev_warn(&pdev->dev, "failed to get firmware name\n");
> >
> > if should have braces!
> > Applied after fixing braces!
> 
> checkpatch.pl output after adding braces:
> 
> WARNING: braces {} are not necessary for single statement blocks
> #102: FILE: drivers/dma/imx-sdma.c:2165:
> + if (ret) {
> + dev_warn(&pdev->dev, "failed to get firmware from device tree\n");
> + }

there is an else here too!

With the patch the checkpatch warns:

CHECK: braces {} should be used on all arms of this statement
#201: FILE: drivers/dma/imx-sdma.c:2161:
+		if (ret)
[...]
+		else {
[...]


Even if the if is a single block and else being multi block, if would
need matching brances. With the change pushed:

total: 0 errors, 0 warnings, 0 checks, 60 lines checked


-- 
~Vinod
