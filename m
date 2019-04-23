Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAA0C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB2E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9GKDDVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfDWQRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:17:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43593 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWQRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:17:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so7839257pgu.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uoo4zU9bRplcM88Gy3z7EAgvGkM989NlmEdwPQZGae8=;
        b=W9GKDDVjS0xCeXhVdmlvraJ8iHMF2HFs55cDzBQfSwOCPCNMaIUDSPsuO1sWbTjYBI
         fB+rcF1uQTc//aGnRJ1Sp719J0Fmm8KmACXUp76lWkPL/fu2dOkc0CWrtSsqeulCXkaS
         0iSz6vf1Ci/2s9h91MCgVNrWKqit3HoPETw4E4DWlumY4ya5ISwpx8fm48hsJbUhIh98
         6Qzv1gzbt6cC2uL77BTK87Z9aB2/5xmvi5NQa00pdEGAFJp1peNef7FyMqUdkICrb5yB
         Rhd0tnEfeZhX+aKVxtA7lHsfFY3GJfm+gc5VwAB9Ca8xqBwSXIBdjoR2RPjbJ9f7pRCj
         WKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uoo4zU9bRplcM88Gy3z7EAgvGkM989NlmEdwPQZGae8=;
        b=ZBc+MjqRObqzqNttj4gHgR6L2NysMEB+g+jP2Jp4DcBxAtcHXXET3W6NevsRJC2iUY
         N+HUyXn4ChfNfXeaKoOntL9X6wAbSAVv856OreIGuwlYsGzXnhTF0qAist1SdJajgamh
         nkoCFg7RnBN8VWWR5b/jQk/gkMBBisidfqvdU0S+S56cTtVetVSGXxrjH8UP8n17OAc+
         qb1g3amfYLDYpgqdO7LiuQ/7whcQM9gaozKTnMUNzoWzQsl9MvPmUlPk5O0VlJpV0NpL
         LVPodbYJtgZ1QwTn2n8g8hvN2bxB3KypLSo8+mhmQf5DX5oUdBUpDw10n3LBWs8Ffsnn
         EUkg==
X-Gm-Message-State: APjAAAWPpl9ctO3RPMKZM8llvtmN+ZhJ0Uo9/Zm6oLhJ7ep/UVvEpTm3
        CtOZthSeut4phx6Bn9KJ6ryakg==
X-Google-Smtp-Source: APXvYqwt+NHYDXHs8rvq7qzJYUyXlRSTBxHgj1E7lSJ1DIGbF4MuoRd9x2YDkzTgS6GI+BAixC4LGQ==
X-Received: by 2002:a63:6fc1:: with SMTP id k184mr25772523pgc.239.1556036231587;
        Tue, 23 Apr 2019 09:17:11 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f13sm8045094pgr.35.2019.04.23.09.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 09:17:10 -0700 (PDT)
Date:   Tue, 23 Apr 2019 10:17:08 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 28/36] coresight: platform: Use fwnode handle for
 device search
Message-ID: <20190423161708.GB21070@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-29-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-29-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:04:11PM +0100, Suzuki K Poulose wrote:
> We match of_node while searching for a device. Make this
> more generic in preparation for the ACPI support by using
> fwnode_handle.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index a408b01..318a6ff 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -36,14 +36,8 @@ static int coresight_alloc_conns(struct device *dev,
>  	return 0;
>  }
>  
> -#ifdef CONFIG_OF
> -static int of_dev_node_match(struct device *dev, void *data)
> -{
> -	return dev->of_node == data;
> -}
> -
>  static struct device *
> -of_coresight_get_endpoint_device(struct device_node *endpoint)
> +coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
>  {
>  	struct device *dev = NULL;
>  
> @@ -52,7 +46,7 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
>  	 * platform bus.
>  	 */
>  	dev = bus_find_device(&platform_bus_type, NULL,
> -			      endpoint, of_dev_node_match);
> +			      fwnode, device_fwnode_match);
>  	if (dev)
>  		return dev;
>  
> @@ -61,9 +55,10 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
>  	 * looking for the device that matches the endpoint node.
>  	 */
>  	return bus_find_device(&amba_bustype, NULL,
> -			       endpoint, of_dev_node_match);
> +			       fwnode, device_fwnode_match);
>  }
>  
> +#ifdef CONFIG_OF
>  static inline bool of_coresight_legacy_ep_is_input(struct device_node *ep)
>  {
>  	return of_property_read_bool(ep, "slave-mode");
> @@ -191,6 +186,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
>  	struct device_node *rparent = NULL;
>  	struct device_node *rep = NULL;
>  	struct device *rdev = NULL;
> +	struct fwnode_handle *rdev_fwnode;
>  
>  	do {
>  		/* Parse the local port details */
> @@ -209,8 +205,9 @@ static int of_coresight_parse_endpoint(struct device *dev,
>  		if (of_graph_parse_endpoint(rep, &rendpoint))
>  			break;
>  
> +		rdev_fwnode = of_fwnode_handle(rparent);
>  		/* If the remote device is not available, defer probing */
> -		rdev = of_coresight_get_endpoint_device(rparent);
> +		rdev = coresight_find_device_by_fwnode(rdev_fwnode);
>  		if (!rdev) {
>  			ret = -EPROBE_DEFER;
>  			break;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.7.4
> 
