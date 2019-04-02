Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5B1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274AE217D4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554206506;
	bh=OmkwyPoQeje3hm7RMlllAZzDVtxLJQq6KbHMB9kzzlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rv97QMyd1QP6Bco+qCX4LQqWsQUoiEFyxcJ7vtSDw+ds3VCAnhK2VBdpARS62arsh
	 VoOzA7HCODZvQsPT5fWeBKXqbUAfpWK5l/WRmZTJ3ZAtiGfswFJz4lmOmiHvU0Oarz
	 9Uyd9kCHR5oW94JtP8uI+hoKMsyxXctCnhEefgvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfDBMBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729605AbfDBMBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:01:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACFED20883;
        Tue,  2 Apr 2019 12:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554206503;
        bh=OmkwyPoQeje3hm7RMlllAZzDVtxLJQq6KbHMB9kzzlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CL4UMNAdM8IBzC0/X2CfoGZI8nENKj+KbmmWt6ROYvTIwqTkPk54sQFe0T7uwb+sM
         UXlpgx9/FOjvqgtDB1QBBbBYiQAe7ZhoBvyXo8xbq+mkJc44MDEAyeySe4VfTY1BX5
         oJATFMCwbMiBgp6lZw0ADhjFt+NFNsp6alrGMAKc=
Date:   Tue, 2 Apr 2019 14:01:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Omer Shpigelman <oshpigelman@habana.ai>
Subject: Re: [PATCH 1/2] habanalabs: add new IOCTL for debug, tracing and
 profiling
Message-ID: <20190402120140.GB24119@kroah.com>
References: <20190402113539.23838-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402113539.23838-1-oded.gabbay@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 02:35:38PM +0300, Oded Gabbay wrote:
> From: Omer Shpigelman <oshpigelman@habana.ai>
> 
> Habanalabs ASICs use the ARM coresight infrastructure to support debug,
> tracing and profiling of neural networks topologies.
> 
> Because the coresight is configured using register writes and reads, and
> some of the registers hold sensitive information (e.g. the address in
> the device's DRAM where the trace data is written to), the user must go
> through the kernel driver to configure this mechanism.
> 
> This patch implements the common code of the IOCTL and calls the
> ASIC-specific function for the actual H/W configuration.
> 
> The IOCTL supports configuration of seven coresight components:
> ETR, ETF, STM, FUNNEL, BMON, SPMU and TIMESTAMP
> 
> The user specifies which component he wishes to configure and provides a
> pointer to a structure (located in its process space) that contains the
> relevant configuration.
> 
> The common code copies the relevant data from the user-space to kernel
> space and then calls the ASIC-specific function to do the H/W
> configuration.
> 
> After the configuration is done, which is usually composed
> of several IOCTL calls depending on what the user wanted to trace, the
> user can start executing the topology. The trace data will be written to
> the user's area in the device's DRAM.
> 
> After the tracing operation is complete, and user will call the IOCTL
> again to disable the tracing operation. The user also need to read
> values from registers for some of the components (e.g. the size of the
> trace data in the device's DRAM). In that case, the user will provide a
> pointer to an "output" structure in user-space, which the IOCTL code will
> fill according the to selected component.
> 
> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
>  drivers/misc/habanalabs/device.c              |   2 +-
>  drivers/misc/habanalabs/goya/Makefile         |   3 +-
>  drivers/misc/habanalabs/goya/goya.c           |   1 +
>  drivers/misc/habanalabs/goya/goyaP.h          |   1 +
>  drivers/misc/habanalabs/goya/goya_coresight.c |  13 ++
>  drivers/misc/habanalabs/habanalabs.h          |  25 ++++
>  drivers/misc/habanalabs/habanalabs_ioctl.c    | 123 +++++++++++++++++-
>  include/uapi/misc/habanalabs.h                | 116 ++++++++++++++++-
>  8 files changed, 280 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/misc/habanalabs/goya/goya_coresight.c
> 
> diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> index e3797f582436..6cbfd560721e 100644
> --- a/drivers/misc/habanalabs/device.c
> +++ b/drivers/misc/habanalabs/device.c
> @@ -1044,7 +1044,7 @@ void hl_device_fini(struct hl_device *hdev)
>  			WARN(1, "Failed to remove device because reset function did not finish\n");
>  			return;
>  		}
> -	};
> +	}
>  
>  	/* Mark device as disabled */
>  	hdev->disabled = true;

This change isn't part of this new feature :(

