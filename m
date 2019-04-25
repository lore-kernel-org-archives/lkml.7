Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233A1C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E09206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556223958;
	bh=cenwiA27vap1/VYbHNX5BoEz4uRg1JH/5Tglhr2eAFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zMP3Rgscj1pxzaqr2freHZzeEGZoI6RJIo/DTFZor/W7gbP4Od32NQ753DlQqcoKn
	 9DXfh8IOD8bz33yQ7yJGxWs+vocszP6JT5ORDDINllVj94mg4PbAkYLFreHdqanGwT
	 Kwlp9vCHPLgNo/2pPrtWijOvbNmZ8LkN6iIb3m9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbfDYUZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbfDYUZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:25:56 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A1A206A3;
        Thu, 25 Apr 2019 20:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556223955;
        bh=cenwiA27vap1/VYbHNX5BoEz4uRg1JH/5Tglhr2eAFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gH+NZYYMzgFjCtl6ti0T3gxc7VoXmbRmexwKU4UyULDrGRQchwyfg9WIVRRUx6Vfq
         9KTpcRQh/YwgJzRdZf64IYskyrFQ6YtIobchgulOC526bFgpRJfgaARFTy3CNTczjG
         5goqYkPSr7OjKpXnEixtb22P4exozkoUM1R1jyaw=
Date:   Thu, 25 Apr 2019 22:25:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     arnd@arndb.de, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: Re: [PATCH V2 02/12] misc: xilinx-sdfec: add core driver
Message-ID: <20190425202552.GB22307@kroah.com>
References: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
 <1554804414-206099-3-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554804414-206099-3-git-send-email-dragan.cvetic@xilinx.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 11:06:44AM +0100, Dragan Cvetic wrote:
> +++ b/include/uapi/misc/xilinx_sdfec.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */

That is not the proper SPDX license for a UAPI kernel header file :(

Please fix this up.

Also, why do you need a uapi file at all?  Who is using these values?

> +/*
> + * Xilinx SD-FEC
> + *
> + * Copyright (C) 2016 - 2017 Xilinx, Inc.
> + *
> + * Description:
> + * This driver is developed for SDFEC16 IP. It provides a char device
> + * in sysfs and supports file operations like open(), close() and ioctl().
> + */
> +#ifndef __XILINX_SDFEC_H__
> +#define __XILINX_SDFEC_H__
> +
> +/**
> + * enum xsdfec_state - State.
> + * @XSDFEC_INIT: Driver is initialized.
> + * @XSDFEC_STARTED: Driver is started.
> + * @XSDFEC_STOPPED: Driver is stopped.
> + * @XSDFEC_NEEDS_RESET: Driver needs to be reset.
> + * @XSDFEC_PL_RECONFIGURE: Programmable Logic needs to be recofigured.
> + *
> + * This enum is used to indicate the state of the driver.
> + */
> +enum xsdfec_state {
> +	XSDFEC_INIT = 0,
> +	XSDFEC_STARTED,
> +	XSDFEC_STOPPED,
> +	XSDFEC_NEEDS_RESET,
> +	XSDFEC_PL_RECONFIGURE,
> +};
> +
> +/**
> + * struct xsdfec_config - Configuration of SD-FEC core.
> + * @fec_id: ID of SD-FEC instance. ID is limited to the number of active
> + *          SD-FEC's in the FPGA and is related to the driver instance
> + *          Minor number.
> + */
> +struct xsdfec_config {
> +	s32 fec_id;

What is this structure for and why are you telling userspace about it?
If you are telling userspace about it, you are using the wrong data
type :(

thanks,

greg k-h
