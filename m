Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323A9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022EF21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfCTRYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:24:46 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:59595 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726830AbfCTRYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:24:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 4A80D181D3419;
        Wed, 20 Mar 2019 17:24:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tooth04_63629714ab316
X-Filterd-Recvd-Size: 2271
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 20 Mar 2019 17:24:42 +0000 (UTC)
Message-ID: <3e62601417f959c60d7f0c0311afb1d8484a0d1c.camel@perches.com>
Subject: Re: [PATCH v3 2/5] ocxl: Clean up printf formats
From:   Joe Perches <joe@perches.com>
To:     Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Mar 2019 10:24:41 -0700
In-Reply-To: <20190320053448.2098-3-alastair@au1.ibm.com>
References: <20190313040702.14276-1-alastair@au1.ibm.com>
         <20190320053448.2098-1-alastair@au1.ibm.com>
         <20190320053448.2098-3-alastair@au1.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-20 at 16:34 +1100, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Use %# instead of using a literal '0x'

I do not suggest this as reasonable.

There are 10's of thousands of uses of 0x%x in the kernel
and converting them to save a byte seems unnecessary.

$ git grep -P '0x%[\*\d\.]*[xX]' | wc -l
26120

And the %#x style is by far the lesser used form

$ git grep -P '%#[\*\d\.]*[xX]' | wc -l
2726

Also, the sized form of %#[size]x is frequently misused
where the size does not account for the initial 0x output.

> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
[]
> @@ -178,9 +178,9 @@ static int read_dvsec_vendor(struct pci_dev *dev)
>  	pci_read_config_dword(dev, pos + OCXL_DVSEC_VENDOR_DLX_VERS, &dlx);
>  
>  	dev_dbg(&dev->dev, "Vendor specific DVSEC:\n");
> -	dev_dbg(&dev->dev, "  CFG version = 0x%x\n", cfg);
> -	dev_dbg(&dev->dev, "  TLX version = 0x%x\n", tlx);
> -	dev_dbg(&dev->dev, "  DLX version = 0x%x\n", dlx);
> +	dev_dbg(&dev->dev, "  CFG version = %#x\n", cfg);
> +	dev_dbg(&dev->dev, "  TLX version = %#x\n", tlx);
> +	dev_dbg(&dev->dev, "  DLX version = %#x\n", dlx);

etc...


