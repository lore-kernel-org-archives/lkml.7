Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E62EC5B57B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3812216FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJefxaei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfF2TCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 15:02:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46426 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfF2TCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 15:02:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so5048611pls.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 12:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Xt6oJ4rqeV//6ip/qRk5SdVKABuf54Hmb4LWe8YOxc=;
        b=JJefxaei4WAgDvs0L3wnRVqUUTC2aI0iS03TBKzed1/a7oZxyIEBC+0qYB3JS5KDqS
         u9bR4vt4pr+eQL71FoQovXJckOSicmJtW9ReYQnt9H/F+t3i7us1BjYioLtKUlfATb7t
         aDrvgu2fNE/h06hYEr7hWHpgUkYmdYf2q1J39VInPrYqDUF7JfMk4sP2eo250XuYhmMN
         D0LWM3ZQNImgPKHFIDfBP+Y6pJ7gVfRM0LYvFloQkptmvVwhLlUgnxuXc+PequBGAEt6
         YwtMWzSSaoMJnX+LAzPeevYI1ajp3IvhhCRehR9+6Q5ksDGONfdPlrLGdZ3Y8/A4oGey
         +++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Xt6oJ4rqeV//6ip/qRk5SdVKABuf54Hmb4LWe8YOxc=;
        b=Tx+Ke0lmXEstlmBQN4vYKOixZNyajd4TGxIoZnkIEKxtfsljF5BG7JXwrzva1fgLX7
         wKmvV3OW8AItduhWnVehtcF9qaC1P4YglTRNP8gbfllqXT+lYtH/xyc87+0sq9DZlExA
         WuUr1eOy5lcc+D9d6yE2Ca2MckTRx9DiB2SrsVFYqXvrvTcgUpJd2YZTeGWG0WNh7mHY
         Zkh4M2pA/M8vJ50YKc5kzPqaEPNjgosavpDHWFeTsMg8HgILUv/QpdqG429ZnfboqUDj
         6hRgAZSAq0kdxlQfU9JIGbLGAFgHfCA3hduRpw48zadO4S1lC82EdSwtSjexrNMplbgs
         HJIQ==
X-Gm-Message-State: APjAAAVhi3LL3GeIBYYslt+hzBDb2358tpa4W9DLDSAM2sedCHrp7nyD
        7tfvDo0VbH7Cv/KanEMmif8IWA==
X-Google-Smtp-Source: APXvYqxhYerUFPI/0du3RWdaDX0p6ghX/jXnKqzWCBx77bV7RNL5W0Ax4HOPUzJKHfSGK0XTE0ZILw==
X-Received: by 2002:a17:902:542:: with SMTP id 60mr19347310plf.68.1561834952687;
        Sat, 29 Jun 2019 12:02:32 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d4sm5342794pju.19.2019.06.29.12.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Jun 2019 12:02:32 -0700 (PDT)
Date:   Sat, 29 Jun 2019 12:02:29 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Clement Leger <cleger@kalray.eu>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Loic PALLARDY <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH] remoteproc: add vendor resources handling
Message-ID: <20190629190229.GE23094@builder>
References: <20190617125730.23688-1-cleger@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617125730.23688-1-cleger@kalray.eu>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17 Jun 05:57 PDT 2019, Clement Leger wrote:

> In order to allow rproc backend to handle vendor resources such as in
> OpenAMP, add a handle_rsc hook. This hook allow the rproc backends to
> handle vendor resources as they like. The hook will be called only for
> vendor resources and should return RSC_HANDLED on successful resource
> handling, RSC_IGNORED if resource was ignored, or a negative value on
> error.
> 
> Signed-off-by: Clement Leger <cleger@kalray.eu>

Applied

Thanks,
Bjorn

> ---
>  Documentation/remoteproc.txt             | 14 +++++++++-----
>  drivers/remoteproc/remoteproc_core.c     | 14 ++++++++++++++
>  drivers/remoteproc/remoteproc_internal.h | 11 +++++++++++
>  include/linux/remoteproc.h               | 32 ++++++++++++++++++++++++++------
>  4 files changed, 60 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/remoteproc.txt b/Documentation/remoteproc.txt
> index 77fb03acdbb4..03c3d2e568b0 100644
> --- a/Documentation/remoteproc.txt
> +++ b/Documentation/remoteproc.txt
> @@ -314,6 +314,8 @@ Here are the various resource types that are currently supported::
>     * @RSC_VDEV:       declare support for a virtio device, and serve as its
>     *		    virtio header.
>     * @RSC_LAST:       just keep this one at the end
> +   * @RSC_VENDOR_START:	start of the vendor specific resource types range
> +   * @RSC_VENDOR_END:	end of the vendor specific resource types range
>     *
>     * Please note that these values are used as indices to the rproc_handle_rsc
>     * lookup table, so please keep them sane. Moreover, @RSC_LAST is used to
> @@ -321,11 +323,13 @@ Here are the various resource types that are currently supported::
>     * please update it as needed.
>     */
>    enum fw_resource_type {
> -	RSC_CARVEOUT	= 0,
> -	RSC_DEVMEM	= 1,
> -	RSC_TRACE	= 2,
> -	RSC_VDEV	= 3,
> -	RSC_LAST	= 4,
> +	RSC_CARVEOUT		= 0,
> +	RSC_DEVMEM		= 1,
> +	RSC_TRACE		= 2,
> +	RSC_VDEV		= 3,
> +	RSC_LAST		= 4,
> +	RSC_VENDOR_START	= 128,
> +	RSC_VENDOR_END		= 512,
>    };
>  
>  For more details regarding a specific resource type, please see its
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 48feebd6d0a2..263e9c9614a8 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1066,6 +1066,20 @@ static int rproc_handle_resources(struct rproc *rproc,
>  
>  		dev_dbg(dev, "rsc: type %d\n", hdr->type);
>  
> +		if (hdr->type >= RSC_VENDOR_START &&
> +		    hdr->type <= RSC_VENDOR_END) {
> +			ret = rproc_handle_rsc(rproc, hdr->type, rsc,
> +					       offset + sizeof(*hdr), avail);
> +			if (ret == RSC_HANDLED)
> +				continue;
> +			else if (ret < 0)
> +				break;
> +
> +			dev_warn(dev, "unsupported vendor resource %d\n",
> +				 hdr->type);
> +			continue;
> +		}
> +
>  		if (hdr->type >= RSC_LAST) {
>  			dev_warn(dev, "unsupported resource %d\n", hdr->type);
>  			continue;
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 45ff76a06c72..4c77bdd517b9 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -106,6 +106,17 @@ static inline int rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
>  	return 0;
>  }
>  
> +static inline
> +int rproc_handle_rsc(struct rproc *rproc, u32 rsc_type, void *rsc, int offset,
> +		     int avail)
> +{
> +	if (rproc->ops->handle_rsc)
> +		return rproc->ops->handle_rsc(rproc, rsc_type, rsc, offset,
> +					      avail);
> +
> +	return RSC_IGNORED;
> +}
> +
>  static inline
>  struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
>  						   const struct firmware *fw)
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 04d04709f2bd..16ad66683ad0 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -100,7 +100,9 @@ struct fw_rsc_hdr {
>   *		    the remote processor will be writing logs.
>   * @RSC_VDEV:       declare support for a virtio device, and serve as its
>   *		    virtio header.
> - * @RSC_LAST:       just keep this one at the end
> + * @RSC_LAST:       just keep this one at the end of standard resources
> + * @RSC_VENDOR_START:	start of the vendor specific resource types range
> + * @RSC_VENDOR_END:	end of the vendor specific resource types range
>   *
>   * For more details regarding a specific resource type, please see its
>   * dedicated structure below.
> @@ -111,11 +113,13 @@ struct fw_rsc_hdr {
>   * please update it as needed.
>   */
>  enum fw_resource_type {
> -	RSC_CARVEOUT	= 0,
> -	RSC_DEVMEM	= 1,
> -	RSC_TRACE	= 2,
> -	RSC_VDEV	= 3,
> -	RSC_LAST	= 4,
> +	RSC_CARVEOUT		= 0,
> +	RSC_DEVMEM		= 1,
> +	RSC_TRACE		= 2,
> +	RSC_VDEV		= 3,
> +	RSC_LAST		= 4,
> +	RSC_VENDOR_START	= 128,
> +	RSC_VENDOR_END		= 512,
>  };
>  
>  #define FW_RSC_ADDR_ANY (-1)
> @@ -339,6 +343,16 @@ struct rproc_mem_entry {
>  
>  struct firmware;
>  
> +/**
> + * enum rsc_handling_status - return status of rproc_ops handle_rsc hook
> + * @RSC_HANDLED:	resource was handled
> + * @RSC_IGNORED:	resource was ignored
> + */
> +enum rsc_handling_status {
> +	RSC_HANDLED	= 0,
> +	RSC_IGNORED	= 1,
> +};
> +
>  /**
>   * struct rproc_ops - platform-specific device handlers
>   * @start:	power on the device and boot it
> @@ -346,6 +360,10 @@ struct firmware;
>   * @kick:	kick a virtqueue (virtqueue id given as a parameter)
>   * @da_to_va:	optional platform hook to perform address translations
>   * @parse_fw:	parse firmware to extract information (e.g. resource table)
> + * @handle_rsc:	optional platform hook to handle vendor resources. Should return
> + * RSC_HANDLED if resource was handled, RSC_IGNORED if not handled and a
> + * negative value on error
> + * @load_rsc_table:	load resource table from firmware image
>   * @find_loaded_rsc_table: find the loaded resouce table
>   * @load:		load firmware to memory, where the remote processor
>   *			expects to find it
> @@ -358,6 +376,8 @@ struct rproc_ops {
>  	void (*kick)(struct rproc *rproc, int vqid);
>  	void * (*da_to_va)(struct rproc *rproc, u64 da, int len);
>  	int (*parse_fw)(struct rproc *rproc, const struct firmware *fw);
> +	int (*handle_rsc)(struct rproc *rproc, u32 rsc_type, void *rsc,
> +			  int offset, int avail);
>  	struct resource_table *(*find_loaded_rsc_table)(
>  				struct rproc *rproc, const struct firmware *fw);
>  	int (*load)(struct rproc *rproc, const struct firmware *fw);
> -- 
> 2.15.0.276.g89ea799
> 
