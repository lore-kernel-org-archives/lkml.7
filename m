Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C188C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D88218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552751370;
	bh=zyiMt94slNDL609O6muiFMuaVvrUYx6UStlu7Ga8z0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OBCvqdn8F3Yfiu0rBpyiE8+CaRNtvfE6vQ/wGoYhc+4RZI4z1ri0WZ02smLtm6i/Z
	 bMQwuNOfpnxqtInQh2kMxTgP1C8uh5VCNhHQf6b0aZmp3LDWXkFcMTs0y81K86jjrL
	 8XdAFIAbPsYiea9fj5DrHm2jgjJNo4zoYOXl1fcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfCPPt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfCPPt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 11:49:28 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F40B2064C;
        Sat, 16 Mar 2019 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552751367;
        bh=zyiMt94slNDL609O6muiFMuaVvrUYx6UStlu7Ga8z0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1QfFM4BDG8qVRN3KqHNDSaf4x/bJIRmJevysHH1gynCrrPdU2lqhnytu15oULcL8d
         iTnsV/4PF5G9DYLQdzs2ruEg+yGB3gHdaj9PIM/6aaLysK+d1MaMWL8z/jAcnsaI91
         KYuyJAQCfpjpqCCcc4V+ll3t6gNNgzX870JJ6/Xc=
Date:   Sat, 16 Mar 2019 15:49:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: xilinx: fix potential use-after-free on
 probe
Message-ID: <20190316154921.1745de59@archlinux>
In-Reply-To: <20190310185826.25916-2-TheSven73@gmail.com>
References: <20190310185826.25916-1-TheSven73@gmail.com>
        <20190310185826.25916-2-TheSven73@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Mar 2019 14:58:25 -0400
Sven Van Asbroeck <thesven73@gmail.com> wrote:

> If probe errors out after request_irq(), its error path
> does not explicitly cancel the delayed work, which may
> have been scheduled by the interrupt handler.
> 
> This means the delayed work may still be running when
> the core frees the private structure (struct xadc).
> This is a potential use-after-free.
> 
> Fix by inserting cancel_delayed_work_sync() in the probe
> error path.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
Again, seems fine to me.

Applied to the fixes-togreg branch of iio.git.

thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 1960694e8007..15e1a103f37d 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1290,6 +1290,7 @@ static int xadc_probe(struct platform_device *pdev)
>  
>  err_free_irq:
>  	free_irq(xadc->irq, indio_dev);
> +	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
>  err_clk_disable_unprepare:
>  	clk_disable_unprepare(xadc->clk);
>  err_free_samplerate_trigger:

