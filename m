Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133D3C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D9320733
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576589918;
	bh=WNkZjk1VwTkTHxwnzJkDUEB6bsaYihg2Y7a0M0jOK4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KkdBn3e5FCScrYvmfExErJoba+TQpq0NgXFyspWueIUWpwyYKjvyzfmo/bpaJ4zsz
	 iOSrGC59mx8mEjXxp0227cbIFB5POuWjAoruhLZnajA2GCIfQA4DjaauDy5FgGYbw2
	 IgisJYoav9TEo18Uk+Xv4vj5lTDvFGsTi+lvlru8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfLQNih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:38:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfLQNih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:38:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B438206B7;
        Tue, 17 Dec 2019 13:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576589916;
        bh=WNkZjk1VwTkTHxwnzJkDUEB6bsaYihg2Y7a0M0jOK4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=msUUD7HueBw95SrCbB87rW0kDcbGTENGbMoeUf+/mz0pWLlbYeLv9cFyTQXFBrfzz
         nrT+9FAdYE+y57dxUgyR/cJLCGVmVCtehaAixnKF4ut3YTnYJO5DruJTfLABSfCIFi
         GEpHMBsXcYVBTZSoaShKDlX03xA64/Ma99j+F6nA=
Date:   Tue, 17 Dec 2019 14:38:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Kim <david.kim@ncipher.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Tim Magee <tim.magee@ncipher.com>
Subject: Re: [PATCH 1/1] drivers: misc: Add support for nCipher HSM devices
Message-ID: <20191217133834.GE3362771@kroah.com>
References: <20191217132244.14768-1-david.kim@ncipher.com>
 <20191217132244.14768-2-david.kim@ncipher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217132244.14768-2-david.kim@ncipher.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:22:44PM +0000, Dave Kim wrote:
> +/**
> + * PCI device ID table.  We use the driver_data field to hold an index into
> + * nfp_drvlist, so bear than in mind when editing either.
> + */
> +static struct pci_device_id nfp_pci_tbl[] = {
> +	{
> +		PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_21555,
> +		PCI_VENDOR_ID_NCIPHER, PCI_SUBSYSTEM_ID_NFAST_REV1, 0,
> +		0, /* Ignore class */
> +		0 /* Index into nfp_drvlist */

Please use the correct PCI_DEVICE() macros, that should work here,
right?

And you are grabbing an Intel PCI device id?

> +	},
> +	{
> +		PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_FREESCALE_T1022,
> +		PCI_VENDOR_ID_NCIPHER, PCI_SUBSYSTEM_ID_NFAST_REV1, 0,
> +		0, /* Ignore class */
> +		1 /* Index into nfp_drvlist */

Again, PCI_DEVICE() macros please.

And kerneldoc everywhere, your commenting format for all of the code is
a bit "odd".

thanks,

greg k-h
