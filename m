Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D79C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8AA2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pb6uEJnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfDVRGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:06:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46020 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfDVRGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 13:06:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so6117721pgk.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UmVQ/Kb+D3agxEJmcF1RGJiBZEdZhtAXjz7AnW27M3E=;
        b=Pb6uEJnt2ViK0QG8dAl9/5PJrW6CbePJCFvHiuVHcYhwHrBB03VpexFNYgObPoEouy
         iHvosR/+6sg7BtepjY/hTfDoOCAeQ2Dy3NP17PtQY7pgwVF0e3+AnXcmjp10MJsvtHOi
         IOSZFvkfLnadis9Rp7xx6JPU3w3JFJO4VeMXZ3cZ/Y0+fls23LVRszBXjhGtP/8/6W8M
         Xg9HIBkkXKPXsaZap8mGFYGHs3ck7jebvdoSI8syxIWPoPn9SGQmwLiaJ+kVYCenfH6d
         r5S9m0CFv260qWcECdm5MX7XuJurIgsSSqX9X8uC7AZztbG9ibrrWm0WGVNbXjjYIG1G
         NFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UmVQ/Kb+D3agxEJmcF1RGJiBZEdZhtAXjz7AnW27M3E=;
        b=cbicqR3DeOrIihCGpigQP2VeBpkOFBjDwzyXxPIFqB8LjNcGNiAxO5PE76hCaSf/1c
         UaDkQ+C+cMxeHPW4WJwixGvXsmAfuqGdvJhMezn/ZsS98Uz7aGVZBGUrI+kWY1Z7vPld
         ZoJWRSiTQMYtNTTiveVE1yUdKcoCQltqiwO8IgUlOulBl2ALyxEqXanP905XeUIZWR6Z
         z5IXjB5jbXrVue+EXosUDwqxAGk/5BxSLZ1jnUJ1Nm6mJV5mGxM5/dahxYTOGk3C/uim
         28Ln1gs4qCG9Srr8Z81E9ODDqibSBL/uUTlHnl114q7Ci1I69569/VDW0Kz+4d4ItVA7
         AHaA==
X-Gm-Message-State: APjAAAWhYU+CfDSKBquqMoOoSWRGhUxQcha9waiQ3sduulYgVz0bAP+o
        YNj27IuV7K7HtNhsirRveOxe3A==
X-Google-Smtp-Source: APXvYqybbcm5zbKayfq6GH7v8JSuiDlnXTzD+OMEm+OrpNuytSBmZZsH3ENZcNpFf5ggNIyAsu2+JA==
X-Received: by 2002:a65:44c6:: with SMTP id g6mr19591461pgs.157.1555952790548;
        Mon, 22 Apr 2019 10:06:30 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j28sm16244144pgb.46.2019.04.22.10.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 10:06:29 -0700 (PDT)
Date:   Mon, 22 Apr 2019 11:06:27 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 24/36] coresight: Reuse platform data structure for
 connection tracking
Message-ID: <20190422170627.GA6402@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-25-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-25-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:04:07PM +0100, Suzuki K Poulose wrote:
> The platform specific information describes the connections and
> the ports of a given coresigh device. This information is also
> recorded in the coresight device as separate fields. Let us reuse
> the original platform description to streamline the handling
> of the data.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c |  4 +--
>  drivers/hwtracing/coresight/coresight.c         | 46 ++++++++++++-------------
>  include/linux/coresight.h                       |  8 ++---
>  3 files changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 0911f9c..d3ff2c7 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -747,8 +747,8 @@ tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
>  	if (!IS_ENABLED(CONFIG_CORESIGHT_CATU))
>  		return NULL;
>  
> -	for (i = 0; i < etr->nr_outport; i++) {
> -		tmp = etr->conns[i].child_dev;
> +	for (i = 0; i < etr->pdata->nr_outport; i++) {
> +		tmp = etr->pdata->conns[i].child_dev;
>  		if (tmp && coresight_is_catu_device(tmp))
>  			return tmp;
>  	}
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 530ad69..f6c5244 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -100,8 +100,8 @@ static int coresight_find_link_inport(struct coresight_device *csdev,
>  	int i;
>  	struct coresight_connection *conn;
>  
> -	for (i = 0; i < parent->nr_outport; i++) {
> -		conn = &parent->conns[i];
> +	for (i = 0; i < parent->pdata->nr_outport; i++) {
> +		conn = &parent->pdata->conns[i];
>  		if (conn->child_dev == csdev)
>  			return conn->child_port;
>  	}
> @@ -118,8 +118,8 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
>  	int i;
>  	struct coresight_connection *conn;
>  
> -	for (i = 0; i < csdev->nr_outport; i++) {
> -		conn = &csdev->conns[i];
> +	for (i = 0; i < csdev->pdata->nr_outport; i++) {
> +		conn = &csdev->pdata->conns[i];
>  		if (conn->child_dev == child)
>  			return conn->outport;
>  	}
> @@ -304,10 +304,10 @@ static void coresight_disable_link(struct coresight_device *csdev,
>  
>  	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
>  		refport = inport;
> -		nr_conns = csdev->nr_inport;
> +		nr_conns = csdev->pdata->nr_inport;
>  	} else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT) {
>  		refport = outport;
> -		nr_conns = csdev->nr_outport;
> +		nr_conns = csdev->pdata->nr_outport;
>  	} else {
>  		refport = 0;
>  		nr_conns = 1;
> @@ -593,9 +593,10 @@ static void coresight_grab_device(struct coresight_device *csdev)
>  {
>  	int i;
>  
> -	for (i = 0; i < csdev->nr_outport; i++) {
> -		struct coresight_device *child = csdev->conns[i].child_dev;
> +	for (i = 0; i < csdev->pdata->nr_outport; i++) {
> +		struct coresight_device *child;
>  
> +		child  = csdev->pdata->conns[i].child_dev;
>  		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
>  			pm_runtime_get_sync(child->dev.parent);
>  	}
> @@ -611,9 +612,10 @@ static void coresight_drop_device(struct coresight_device *csdev)
>  	int i;
>  
>  	pm_runtime_put(csdev->dev.parent);
> -	for (i = 0; i < csdev->nr_outport; i++) {
> -		struct coresight_device *child = csdev->conns[i].child_dev;
> +	for (i = 0; i < csdev->pdata->nr_outport; i++) {
> +		struct coresight_device *child;
>  
> +		child  = csdev->pdata->conns[i].child_dev;
>  		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
>  			pm_runtime_put(child->dev.parent);
>  	}
> @@ -643,9 +645,10 @@ static int _coresight_build_path(struct coresight_device *csdev,
>  		goto out;
>  
>  	/* Not a sink - recursively explore each port found on this element */
> -	for (i = 0; i < csdev->nr_outport; i++) {
> -		struct coresight_device *child_dev = csdev->conns[i].child_dev;
> +	for (i = 0; i < csdev->pdata->nr_outport; i++) {
> +		struct coresight_device *child_dev;
>  
> +		child_dev = csdev->pdata->conns[i].child_dev;
>  		if (child_dev &&
>  		    _coresight_build_path(child_dev, sink, path) == 0) {
>  			found = true;
> @@ -998,8 +1001,8 @@ static int coresight_orphan_match(struct device *dev, void *data)
>  	 * Circle throuch all the connection of that component.  If we find
>  	 * an orphan connection whose name matches @csdev, link it.
>  	 */
> -	for (i = 0; i < i_csdev->nr_outport; i++) {
> -		conn = &i_csdev->conns[i];
> +	for (i = 0; i < i_csdev->pdata->nr_outport; i++) {
> +		conn = &i_csdev->pdata->conns[i];
>  
>  		/* We have found at least one orphan connection */
>  		if (conn->child_dev == NULL) {
> @@ -1038,8 +1041,8 @@ static void coresight_fixup_device_conns(struct coresight_device *csdev)
>  {
>  	int i;
>  
> -	for (i = 0; i < csdev->nr_outport; i++) {
> -		struct coresight_connection *conn = &csdev->conns[i];
> +	for (i = 0; i < csdev->pdata->nr_outport; i++) {
> +		struct coresight_connection *conn = &csdev->pdata->conns[i];
>  		struct device *dev = NULL;
>  
>  		if (conn->child_name)
> @@ -1073,8 +1076,8 @@ static int coresight_remove_match(struct device *dev, void *data)
>  	 * Circle throuch all the connection of that component.  If we find
>  	 * a connection whose name matches @csdev, remove it.
>  	 */
> -	for (i = 0; i < iterator->nr_outport; i++) {
> -		conn = &iterator->conns[i];
> +	for (i = 0; i < iterator->pdata->nr_outport; i++) {
> +		conn = &iterator->pdata->conns[i];
>  
>  		if (conn->child_dev == NULL)
>  			continue;
> @@ -1106,7 +1109,7 @@ static void coresight_remove_conns(struct coresight_device *csdev)
>  	 * doesn't have at least one input port, there is no point
>  	 * in searching all the devices.
>  	 */
> -	if (csdev->nr_inport)
> +	if (csdev->pdata->nr_inport)
>  		bus_for_each_dev(&coresight_bustype, NULL,
>  				 csdev, coresight_remove_match);
>  }
> @@ -1193,10 +1196,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>  
>  	csdev->refcnt = refcnts;
>  
> -	csdev->nr_inport = desc->pdata->nr_inport;
> -	csdev->nr_outport = desc->pdata->nr_outport;
> -
> -	csdev->conns = desc->pdata->conns;
> +	csdev->pdata = desc->pdata;
>  
>  	csdev->type = desc->type;
>  	csdev->subtype = desc->subtype;
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 84a2137..8c10def 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -140,9 +140,7 @@ struct coresight_connection {
>  
>  /**
>   * struct coresight_device - representation of a device as used by the framework
> - * @conns:	array of coresight_connections associated to this component.
> - * @nr_inport:	number of input port associated to this component.
> - * @nr_outport:	number of output port associated to this component.
> + * @pdata:	Platform data with device connections associated to this device.
>   * @type:	as defined by @coresight_dev_type.
>   * @subtype:	as defined by @coresight_dev_subtype.
>   * @ops:	generic operations for this component, as defined
> @@ -157,9 +155,7 @@ struct coresight_connection {
>   * @ea:		Device attribute for sink representation under PMU directory.
>   */
>  struct coresight_device {
> -	struct coresight_connection *conns;
> -	int nr_inport;
> -	int nr_outport;
> +	struct coresight_platform_data *pdata;
>  	enum coresight_dev_type type;
>  	union coresight_dev_subtype subtype;
>  	const struct coresight_ops *ops;

For patches 21 to 24:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.7.4
> 
