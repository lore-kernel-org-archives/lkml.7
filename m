Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E119FC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E51221655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtWevhR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfD2UuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:50:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37875 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfD2UuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:50:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id g3so5924428pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QZjm0VzrnSvwe97DuwwpcavJl5EQRlmhXI1RmRaEyjk=;
        b=AtWevhR8eHQwR/Z00Klhp5XhCOOsXOC4OLcZNjjSClBrtGoGKYb7iE/GkT+0vb+0Jg
         ji312WjRUdY/opghNrx2By4FaQM5bNXmUlyc5iPkD6GVRCalKF8X45GdlJk4J6n9kVnd
         XHO5uoqRcLoYIYQ2bpb6ffCxOaT4205FRMLl3Q+PZWyTR3o7KHF6uuvmuxFV0ZhI4d64
         hrOGtKX08joyESxBQWO+Uvef5DRsfrxhWterdrd7RzoRFHQx3UTVeH80jOXXdeAHuFAc
         y02Ap11etKatqteHSa6IaIPDlA6fC/WICtYD8N3zXk70dEmxZ6BIhzm/L+Ur1SHto3sp
         jKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QZjm0VzrnSvwe97DuwwpcavJl5EQRlmhXI1RmRaEyjk=;
        b=D5Xn6hahj0BWsTHNs+OWTiih215WRSt2L/wbDHLNmTfah8xcM7yk5ER1N06viOVdc+
         3PAFUtVLaHSqIX98oAtNFSaNZqwmtRs/XtKWc0tuTtGSu9g8LHfH55FtLdlAA1zfsJ7g
         YQnW5bjF7PcND03hbpfTAAvx/LtVzfFlhyVPpu49qatHFinCEDornx9sMv5XgeLsadtF
         iRlMTq1jFvDFaLGDSwnZOVbaYA7D8fid41Rtjh07y68st86u6yJ6F4exP8xxuyEEeaSN
         kfMztCSzLE+qjCYicKA/fJ1yP8JEroki3TF7IsXbFSjD2S9i5YHT7sAD1J+Y6Syl/538
         FMFw==
X-Gm-Message-State: APjAAAVaqDPmnigsC4F9voAHdQEcbm+d1LH3xX0L0gtRLiQOAWwhSLpZ
        hQrkRBpFwZcIDaKdG8G5FDmTWA==
X-Google-Smtp-Source: APXvYqygrPwXaE+up3MdXge6v5jIRFdaqsaYpWFoHisXBYFFlgufGwWsHu/SQNGoLrAoDoSpguFj1g==
X-Received: by 2002:a63:514f:: with SMTP id r15mr23361606pgl.450.1556571012368;
        Mon, 29 Apr 2019 13:50:12 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o81sm64300738pfa.156.2019.04.29.13.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 13:50:11 -0700 (PDT)
Date:   Mon, 29 Apr 2019 14:50:09 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
Subject: Re: [PATCH v2 36/36] [RFC] coresight: Expose device connections via
 sysfs
Message-ID: <20190429205009.GC18807@xps15>
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-37-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555344260-12375-37-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:04:19PM +0100, Suzuki K Poulose wrote:
> Coresight device connections are a bit complicated and is not
> exposed currently to the user. One has to look at the platform
> descriptions (DT bindings or ACPI bindings) to make an understanding.
> Given the new naming scheme, it will be helpful to have this information
> to choose the appropriate devices for tracing. This patch exposes
> the device connections via links in the sysfs directories.
> 
> e.g, for a connection devA[OutputPort_X] -> devB[InputPort_Y]
> is represented as two symlinks:
> 
>   /sys/bus/coresight/.../devA/out:X -> /sys/bus/coresight/.../devB
>   /sys/bus/coresight/.../devB/in:Y  -> /sys/bus/coresight/.../devA
> 
> We could have segregated the links to separate directories aka
> attribute_groups, for input_ports and output_ports. But the sysfs won't
> let you create empty attribute_groups and thus it becomes complicated to
> dynamically create the attribute_groups.

While testing this set I noticed entries in /sys/bus/event_source/sinks still
advertise platform device names.  To fix this etm_perf_add_symlink_sink()
needs to be modified, more specifically:

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 4d5a2b9f9d6a..b6d8b8c2ceb9 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -507,7 +507,7 @@ int etm_perf_add_symlink_sink(struct coresight_device *csdev)
        unsigned long hash;
        const char *name;
        struct device *pmu_dev = etm_pmu.dev;
-       struct device *pdev = csdev->dev.parent;
+       struct device *dev = &csdev->dev;
        struct dev_ext_attribute *ea;
 
        if (csdev->type != CORESIGHT_DEV_TYPE_SINK &&
@@ -520,15 +520,15 @@ int etm_perf_add_symlink_sink(struct coresight_device *csdev)
        if (!etm_perf_up)
                return -EPROBE_DEFER;
 
-       ea = devm_kzalloc(pdev, sizeof(*ea), GFP_KERNEL);
+       ea = devm_kzalloc(dev, sizeof(*ea), GFP_KERNEL);
        if (!ea)
                return -ENOMEM;
 
-       name = dev_name(pdev);
+       name = dev_name(dev);
        /* See function coresight_get_sink_by_id() to know where this is used */
        hash = hashlen_hash(hashlen_string(NULL, name));
 
-       ea->attr.attr.name = devm_kstrdup(pdev, name, GFP_KERNEL);
+       ea->attr.attr.name = devm_kstrdup(dev, name, GFP_KERNEL);
        if (!ea->attr.attr.name)
                return -ENOMEM;

Mike Leach was also working on a way to represent connections between CTI/CTM
devices.  It would be desirable to get the same kind of topology representation
for both "normal" devices and CTI/CTMs.  I like how this set represent the
topology but I also want Mike to have his say as well.

Before moving forward I will need to get a "Reviewed-by" from him.

Thanks,
Mathieu

> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight.c | 120 +++++++++++++++++++++++++++++---
>  include/linux/coresight.h               |   4 ++
>  2 files changed, 113 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 4d63063..50a1f29 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -981,9 +981,92 @@ static void coresight_device_release(struct device *dev)
>  	kfree(csdev);
>  }
>  
> +
> +/*
> + * coresight_make_links: Make a link for a connection from a @orig
> + * device to @target, represented by @conn.
> + *
> + *   e.g, for devOrig[output_X] -> devTarget[input_Y] is represented
> + *   as two symbolic links :
> + *
> + *	/sys/.../devOrig/out:X	-> /sys/.../devTarget/
> + *	/sys/.../devTarget/in:Y	-> /sys/.../devOrig/
> + *
> + * The link names are allocated for a device where it appears. i.e, the
> + * "out" link on the master and "in" link on the slave device.
> + * The link names are stored in the connection record for avoiding
> + * the reconstruction of names for removal.
> + */
> +static int coresight_make_links(struct coresight_device *orig,
> +				struct coresight_connection *conn,
> +				struct coresight_device *target)
> +{
> +	int ret = -ENOMEM;
> +	char *outs = NULL, *ins = NULL;
> +
> +	do {
> +		outs = devm_kasprintf(&orig->dev, GFP_KERNEL,
> +				      "out:%d", conn->outport);
> +		if (!outs)
> +			break;
> +		ins = devm_kasprintf(&target->dev, GFP_KERNEL,
> +				     "in:%d", conn->child_port);
> +		if (!ins)
> +			break;
> +		ret = sysfs_create_link(&orig->dev.kobj,
> +					&target->dev.kobj, outs);
> +		if (ret)
> +			break;
> +
> +		ret = sysfs_create_link(&target->dev.kobj,
> +					&orig->dev.kobj, ins);
> +		if (ret) {
> +			sysfs_remove_link(&orig->dev.kobj, outs);
> +			break;
> +		}
> +
> +		conn->inlink_name = ins;
> +		conn->outlink_name = outs;
> +		/*
> +		 * Install the device connection. This also indicates that
> +		 * the links are operational on both ends.
> +		 */
> +		conn->child_dev = target;
> +		return 0;
> +	} while (0);
> +
> +	if (outs)
> +		devm_kfree(&orig->dev, outs);
> +	if (ins)
> +		devm_kfree(&target->dev, ins);
> +	return ret;
> +}
> +
> +/*
> + * coresight_remove_links: Remove the sysfs links for a given connection @conn,
> + * from @orig device to @target device. See coresight_make_links() for more
> + * details.
> + */
> +static void coresight_remove_links(struct coresight_device *orig,
> +				   struct coresight_connection *conn)
> +{
> +	struct coresight_device *target = conn->child_dev;
> +
> +	if (!orig || !target)
> +		return;
> +
> +	sysfs_remove_link(&orig->dev.kobj, conn->outlink_name);
> +	sysfs_remove_link(&target->dev.kobj, conn->inlink_name);
> +
> +	devm_kfree(&target->dev, conn->inlink_name);
> +	devm_kfree(&orig->dev, conn->outlink_name);
> +	conn->inlink_name = conn->outlink_name = NULL;
> +	conn->child_dev = NULL;
> +}
> +
>  static int coresight_orphan_match(struct device *dev, void *data)
>  {
> -	int i;
> +	int i, ret = 0;
>  	bool still_orphan = false;
>  	struct coresight_device *csdev, *i_csdev;
>  	struct coresight_connection *conn;
> @@ -1008,19 +1091,23 @@ static int coresight_orphan_match(struct device *dev, void *data)
>  		/* We have found at least one orphan connection */
>  		if (conn->child_dev == NULL) {
>  			/* Does it match this newly added device? */
> -			if (conn->child_fwnode ==  csdev->dev.fwnode)
> -				conn->child_dev = csdev;
> -			else
> +			if (conn->child_fwnode ==  csdev->dev.fwnode) {
> +				ret = coresight_make_links(i_csdev,
> +							   conn, csdev);
> +				if (ret)
> +					return ret;
> +			} else {
>  				/* This component still has an orphan */
>  				still_orphan = true;
> +			}
>  		}
>  	}
>  
>  	i_csdev->orphan = still_orphan;
>  
>  	/*
> -	 * Returning '0' ensures that all known component on the
> -	 * bus will be checked.
> +	 * Returning '0' in case we didn't encounter any error,
> +	 * ensures that all known component on the bus will be checked.
>  	 */
>  	return 0;
>  }
> @@ -1038,7 +1125,7 @@ static int coresight_fixup_orphan_conns(struct coresight_device *csdev)
>  
>  static int coresight_fixup_device_conns(struct coresight_device *csdev)
>  {
> -	int i;
> +	int i, ret = 0;
>  
>  	for (i = 0; i < csdev->pdata->nr_outport; i++) {
>  		struct coresight_connection *conn = &csdev->pdata->conns[i];
> @@ -1048,9 +1135,12 @@ static int coresight_fixup_device_conns(struct coresight_device *csdev)
>  				      (void *)conn->child_fwnode,
>  				      device_fwnode_match);
>  		if (dev) {
> -			conn->child_dev = to_coresight_device(dev);
> +			ret = coresight_make_links(csdev, conn,
> +						   to_coresight_device(dev));
>  			/* and put reference from 'bus_find_device()' */
>  			put_device(dev);
> +			if (ret)
> +				break;
>  		} else {
>  			csdev->orphan = true;
>  			conn->child_dev = NULL;
> @@ -1085,7 +1175,7 @@ static int coresight_remove_match(struct device *dev, void *data)
>  
>  		if (csdev->dev.fwnode == conn->child_fwnode) {
>  			iterator->orphan = true;
> -			conn->child_dev = NULL;
> +			coresight_remove_links(iterator, conn);
>  			/*
>  			 * Drop the reference to the handle for the remote
>  			 * device acquired in parsing the connections from
> @@ -1179,10 +1269,18 @@ void coresight_release_platform_data(struct coresight_device *csdev,
>  				     struct coresight_platform_data *pdata)
>  {
>  	int i;
> +	struct coresight_connection *conns = pdata->conns;
>  
>  	for (i = 0; i < pdata->nr_outport; i++) {
> -		if (pdata->conns[i].child_fwnode) {
> -			fwnode_handle_put(pdata->conns[i].child_fwnode);
> +		/* If we have made the links, remove them now */
> +		if (csdev && conns[i].child_dev)
> +			coresight_remove_links(csdev, &conns[i]);
> +		/*
> +		 * Drop the refcount and clear the handle as this device
> +		 * is going away
> +		 */
> +		if (conns[i].child_fwnode) {
> +			fwnode_handle_put(conns[i].child_fwnode);
>  			pdata->conns[i].child_fwnode = 0;
>  		}
>  	}
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index d6367a0..284d783 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -130,12 +130,16 @@ struct coresight_desc {
>   * @chid_fwnode: remote component's fwnode handle.
>   * @child_dev:	a @coresight_device representation of the component
>  		connected to @outport.
> + * @inlink_name: Name for the "input" link
> + * @outlink_name: Name for the "output" link
>   */
>  struct coresight_connection {
>  	int outport;
>  	int child_port;
>  	struct fwnode_handle *child_fwnode;
>  	struct coresight_device *child_dev;
> +	const char *inlink_name;
> +	const char *outlink_name;
>  };
>  
>  /**
> -- 
> 2.7.4
> 
