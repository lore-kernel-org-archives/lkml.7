Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429EEC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B84C206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfDZJh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:37:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:56166 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfDZJhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:37:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A703AF95;
        Fri, 26 Apr 2019 09:37:53 +0000 (UTC)
Date:   Fri, 26 Apr 2019 11:37:51 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     <bp@alien8.de>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [RFC PATCH RESEND] i2c-piix4: Add Hygon Dhyana SMBus support
Message-ID: <20190426113751.77befab1@endymion>
In-Reply-To: <1555938607-2865-1-git-send-email-puwen@hygon.cn>
References: <1555938607-2865-1-git-send-email-puwen@hygon.cn>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pu,

On Mon, 22 Apr 2019 21:10:07 +0800, Pu Wen wrote:
> The Hygon Dhyana CPU has the SMBus device with PCI device ID 0x790b,
> which is the same as AMD CZ SMBus device. So add Hygon Dhyana support
> to the i2c-piix4 driver by using the code path of AMD.

Sorry for the late answer.

> Cc: <stable@vger.kernel.org> # v5.0+

I object to adding this to stable. It's not fixing any bug, and it's
far from being a one-liner. I'd rather let distributions backport it as
they see fit.

> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  drivers/i2c/busses/i2c-piix4.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 90946a8..9db9d9d 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -289,6 +289,9 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
>  	     PIIX4_dev->revision >= 0x41) ||
>  	    (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD &&
>  	     PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
> +	     PIIX4_dev->revision >= 0x49) ||
> +	    (PIIX4_dev->vendor == PCI_VENDOR_ID_HYGON &&
> +	     PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
>  	     PIIX4_dev->revision >= 0x49))
>  		smb_en = 0x00;

Does the compatibility with the original AMD chipset include the
revision number?

>  	else
> @@ -361,7 +364,8 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
>  		 piix4_smba, i2ccfg >> 4);
>  
>  	/* Find which register is used for port selection */
> -	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD) {
> +	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD ||
> +	    PIIX4_dev->vendor == PCI_VENDOR_ID_HYGON) {
>  		switch (PIIX4_dev->device) {
>  		case PCI_DEVICE_ID_AMD_KERNCZ_SMBUS:
>  			piix4_port_sel_sb800 = SB800_PIIX4_PORT_IDX_KERNCZ;
> @@ -794,6 +798,7 @@ static const struct pci_device_id piix4_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
>  		     PCI_DEVICE_ID_SERVERWORKS_OSB4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
> @@ -904,11 +909,13 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if ((dev->vendor == PCI_VENDOR_ID_ATI &&
>  	     dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
>  	     dev->revision >= 0x40) ||
> -	    dev->vendor == PCI_VENDOR_ID_AMD) {
> +	    dev->vendor == PCI_VENDOR_ID_AMD ||
> +	    dev->vendor == PCI_VENDOR_ID_HYGON) {
>  		bool notify_imc = false;
>  		is_sb800 = true;
>  
> -		if (dev->vendor == PCI_VENDOR_ID_AMD &&
> +		if ((dev->vendor == PCI_VENDOR_ID_AMD ||
> +		     dev->vendor == PCI_VENDOR_ID_HYGON) &&
>  		    dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
>  			u8 imc;
>  

Patch looks good. I assume you have tested it on real hardware?

I would like you to also document the new supported chipset in
drivers/i2c/busses/Kconfig and Documentation/i2c/busses/i2c-piix4 as
well as in the header comment of i2c-piix4.c itself. I know it seems
redundant but it helps the user know which driver they need.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
