Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4075EC41514
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1824021E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565182932;
	bh=2DCjOM6r9M7Xc5WlhAo8bX6r9K5qrkB9ragQQ2r/r1c=;
	h=Subject:From:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=K6NcJBhOdDS2j0LeLwDZefZD5GdvtlkpTSYtfiIgp4oVTkaTfwBWBZOJRfCP6AysB
	 vjD07fg3DJxazAIywSYkvGzsJKdfzaegWPSGeu5wK3sQu+76o+2XpmVSqz5IyvXoBY
	 JeKXZroGWG3jWeRq2qrGuy18zvBxPMgbthY6weHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387996AbfHGNCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:02:10 -0400
Received: from foss.arm.com ([217.140.110.172]:48110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387799AbfHGNCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:02:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99D7528;
        Wed,  7 Aug 2019 06:02:09 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D0C83F575;
        Wed,  7 Aug 2019 06:02:07 -0700 (PDT)
Subject: Re: [PATCH 7/8] PCI: hv: Allocate a named fwnode instead of an
 address-based one
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
References: <20190806145716.125421-1-maz@kernel.org>
 <20190806145716.125421-8-maz@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=maz@kernel.org; prefer-encrypt=mutual; keydata=
 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
 2Y3aFlL+gnr1zUMjlFzD
Organization: Approximate
Message-ID: <dce13cf7-2be6-e51e-974c-3c87b0190618@kernel.org>
Date:   Wed, 7 Aug 2019 14:02:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806145716.125421-8-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2019 15:57, Marc Zyngier wrote:
> To allocate its fwnode that is then used to allocate an irqdomain,
> the driver uses irq_domain_alloc_fwnode(), passing it a VA as an
> identifier. This is a rather bad idea, as this address ends up
> published in debugfs (and we want to move away from VAs there
> anyway).
> 
> Instead, let's allocate a named fwnode by using the device GUID as
> an identifier. It is allegedly unique, and can be traced back to
> the original device.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/pci/controller/pci-hyperv.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 40b625458afa..f6ed2583167a 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2521,6 +2521,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  			const struct hv_vmbus_device_id *dev_id)
>  {
>  	struct hv_pcibus_device *hbus;
> +	char *name;
>  	int ret;
>  
>  	/*
> @@ -2589,7 +2590,14 @@ static int hv_pci_probe(struct hv_device *hdev,
>  		goto free_config;
>  	}
>  
> -	hbus->sysdata.fwnode = irq_domain_alloc_fwnode(hbus);
> +	name = kasprintf("%pUL", &hdev->dev_instance);

Of course, this is bogus. It needs a GFP_KERNEL as the first parameter.

/me adds HYPERV to .config, and fixes it locally.

	M.
-- 
Jazz is not dead, it just smells funny...
