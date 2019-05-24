Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75063C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BC421851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558724343;
	bh=FXyHqZv9AoEoKKx2HiWPcCTBKjBsIHHJ+fKkrvtAwEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XhmjGhmPqD4OqTGEh1kWIIo3u77QRQSg98a7UtCIMs4Ues/QGWDdxyUfrjx37QDLo
	 u6RukVjLTixzzTCRuJcOJ3CGKUrV5vxrGsBu1XsaqvwXZl9luFYnp+fI4XvUwV4Jwf
	 SDtYci72AwwKt609CATGcK5gvCyOUhc7mGEEDcUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391473AbfEXS7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729416AbfEXS7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:59:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DD082184E;
        Fri, 24 May 2019 18:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558724340;
        bh=FXyHqZv9AoEoKKx2HiWPcCTBKjBsIHHJ+fKkrvtAwEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k8lWmisXxYgrd1wQoQJaGzDwVjbUmDYHxkNucYNCOGlmAA9Ym6N5wWtEoSEuvras9
         1AQAZVu/JwLwNi3aGvoaYR+DP7K4ZpeiowJNuN7UOJTn1hEtjJeJhAGIseqFzu7q72
         gNox1tdXJ+PkMHQ+yvbl5jX0N1ubWtHQF6hb9fVA=
Date:   Fri, 24 May 2019 20:58:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     richard.gong@linux.intel.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sen.li@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv3 2/4] firmware: add Intel Stratix10 remote system update
 driver
Message-ID: <20190524185858.GB13200@kroah.com>
References: <1558616610-499-1-git-send-email-richard.gong@linux.intel.com>
 <1558616610-499-3-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558616610-499-3-git-send-email-richard.gong@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 08:03:28AM -0500, richard.gong@linux.intel.com wrote:
> +static int stratix10_rsu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct stratix10_rsu_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->client.dev = dev;
> +	priv->client.receive_cb = NULL;
> +	priv->client.priv = priv;
> +	priv->status.current_image = 0;
> +	priv->status.fail_image = 0;
> +	priv->status.error_location = 0;
> +	priv->status.error_details = 0;
> +	priv->status.version = 0;
> +	priv->status.state = 0;
> +
> +	mutex_init(&priv->lock);
> +	priv->chan = stratix10_svc_request_channel_byname(&priv->client,
> +							  SVC_CLIENT_RSU);
> +	if (IS_ERR(priv->chan)) {
> +		dev_err(dev, "couldn't get service channel %s\n",
> +			SVC_CLIENT_RSU);
> +		return PTR_ERR(priv->chan);
> +	}
> +
> +	init_completion(&priv->completion);
> +	platform_set_drvdata(pdev, priv);
> +
> +	/* status is only updated after reboot */
> +	ret = rsu_send_msg(priv, COMMAND_RSU_STATUS,
> +			   0, rsu_status_callback);
> +	if (ret) {
> +		dev_err(dev, "Error, getting RSU status %i\n", ret);
> +		stratix10_svc_free_channel(priv->chan);
> +	}
> +
> +	ret = devm_device_add_groups(dev, rsu_groups);
> +	if (ret) {
> +		dev_err(dev, "unable to create sysfs group");
> +		stratix10_svc_free_channel(priv->chan);
> +	}
> +
> +	return ret;
> +}
> +
> +static int stratix10_rsu_remove(struct platform_device *pdev)
> +{
> +	struct stratix10_rsu_priv *priv = platform_get_drvdata(pdev);
> +
> +	stratix10_svc_free_channel(priv->chan);
> +	devm_device_remove_groups(&pdev->dev, rsu_groups);

When you are the only caller of a function in the kernel, that's a HUGE
flag that maybe you should not be calling it...

Which reminds me, I need to go remove this...

Anyway, no, don't do this, you are racing userspace with your sysfs
files.  Reference the groups in the platform_driver structure and the
driver core will properly create, and remove, them for you, and
userspace will be happy they show up at the correct time.

This also makes your probe/remove function smaller.

thanks,

greg k-h
