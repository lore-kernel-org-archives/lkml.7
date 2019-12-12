Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25ADC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C17A20637
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576161758;
	bh=ck563JxppjwUrfE3D/tbAxjKAXIW9YCI6JybTAijvFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YIYbNq5OPcMgcy0QeC6MekKBdhCizejkfGbIdqCIW6lFvra7YXlUmSYs0vC1nG9og
	 EzQbLRLDmVcH4geuHMFZNVnFrNkrPoFWzSrCg1sHl0G50AgfF27nnYQEFNUPqVPY5h
	 Jvp7+yszf47Ougqjv0NqL5Sbh2F69zWM8LtORX9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfLLOmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:42:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:53426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729266AbfLLOmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:42:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C2E020637;
        Thu, 12 Dec 2019 14:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576161755;
        bh=ck563JxppjwUrfE3D/tbAxjKAXIW9YCI6JybTAijvFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=diM2SA6uv924om3crOT9thcoY4Fb421uI5NehQWj7fpPAhf+gd1OZ4zhkFH9vbhop
         sGXQtfYFoHJth1IbutmDeROzPxdpvK87+0hjqKVLPPjV6pZMSAT3NY35E0Fip3ZgsN
         cJLaPPxSd2YSoFiTjaLoau+ii/PKczv7tL91N4aE=
Date:   Thu, 12 Dec 2019 15:42:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
        Joao.Pinto@synopsys.com, bbrezillon@kernel.org, wsa@the-dreams.de,
        arnd@arndb.de, broonie@kernel.org
Subject: Re: [RFC 3/5] i3c: device: expose transfer strutures to uapi
Message-ID: <20191212144233.GA1668196@kroah.com>
References: <cover.1575977795.git.vitor.soares@synopsys.com>
 <fcc51a2758fd7920e1c0163a818fe7c12bd33765.1575977795.git.vitor.soares@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcc51a2758fd7920e1c0163a818fe7c12bd33765.1575977795.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 04:37:31PM +0100, Vitor Soares wrote:
> --- /dev/null
> +++ b/include/uapi/linux/i3c/device.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Not a valid uapi SPDX license :(


> +/*
> + * Copyright (c) 2019 Synopsys, Inc. and/or its affiliates.
> + *
> + * Author: Vitor Soares <vitor.soares@synopsys.com>
> + */
> +
> +#ifndef _UAPI_LINUX_I3C_DEVICE_H
> +#define _UAPI_LINUX_I3C_DEVICE_H
> +
> +#include <linux/types.h>
> +
> +/**
> + * enum i3c_error_code - I3C error codes
> + *
> + * These are the standard error codes as defined by the I3C specification.
> + * When -EIO is returned by the i3c_device_do_priv_xfers() or
> + * i3c_device_send_hdr_cmds() one can check the error code in
> + * &struct_i3c_priv_xfer.err or &struct i3c_hdr_cmd.err to get a better idea of
> + * what went wrong.
> + *
> + * @I3C_ERROR_UNKNOWN: unknown error, usually means the error is not I3C
> + *		       related
> + * @I3C_ERROR_M0: M0 error
> + * @I3C_ERROR_M1: M1 error
> + * @I3C_ERROR_M2: M2 error
> + */
> +enum i3c_error_code {
> +	I3C_ERROR_UNKNOWN = 0,
> +	I3C_ERROR_M0 = 1,
> +	I3C_ERROR_M1,
> +	I3C_ERROR_M2,

You have to specify all of these.

> +};
> +
> +/**
> + * enum i3c_hdr_mode - HDR mode ids
> + * @I3C_HDR_DDR: DDR mode
> + * @I3C_HDR_TSP: TSP mode
> + * @I3C_HDR_TSL: TSL mode
> + */
> +enum i3c_hdr_mode {
> +	I3C_HDR_DDR,
> +	I3C_HDR_TSP,
> +	I3C_HDR_TSL,

same here.


> +};
> +
> +/**
> + * struct i3c_priv_xfer - I3C SDR private transfer
> + * @rnw: encodes the transfer direction. true for a read, false for a write
> + * @len: transfer length in bytes of the transfer
> + * @data: input/output buffer
> + * @data.in: input buffer. Must point to a DMA-able buffer
> + * @data.out: output buffer. Must point to a DMA-able buffer
> + * @err: I3C error code
> + */
> +struct i3c_priv_xfer {
> +	u8 rnw;
> +	u16 len;
> +	union {
> +		void *in;
> +		const void *out;
> +	} data;
> +	enum i3c_error_code err;

Ick, that's a horrid user/kernel api structure that will not work at
all.

Please fix.

thanks,

greg k-h
