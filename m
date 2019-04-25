Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C0AC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54EC206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556224251;
	bh=30cPmhYk9+IDH3/xSH5F9qo31Czy69WZicE1p5RCi+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EyJg6OV1Bdb9JTElxy4c7AQ6JPdFFVfkyvk/REbNwhI7k1Jsi52lesiBmKW1Z1mTQ
	 4eLge753XIE6gV8FdRnDCA9hXrdf3g/zgpldclNp72KqnaYHrfSFKin3YuV6X75N3r
	 MilRyw+p3CGGlzwGrlmNikXHBlmr/oQjvkquyX0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbfDYUau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730991AbfDYUat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:30:49 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4438206A3;
        Thu, 25 Apr 2019 20:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556224249;
        bh=30cPmhYk9+IDH3/xSH5F9qo31Czy69WZicE1p5RCi+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0SSdAS4CWR+ZMG4GTP/ZMxPkJQvvIVWspLmrHd4D5v+b/dDHretkTK2CBHT7moGB
         qCvCfuRRlXiQGhpnkOGeR5r1B4Kx+JQ2d90t6PvplvFpD9ZKuTqBkZHtThJdtcjdji
         voZ5JB3taSj934XtmvEtQWv52nwvLNS+xsgDSXLA=
Date:   Thu, 25 Apr 2019 22:30:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     richard.gong@linux.intel.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1 4/6] firmware: add Intel Stratix10 remote system update
 driver
Message-ID: <20190425203046.GE22307@kroah.com>
References: <1554835562-25056-1-git-send-email-richard.gong@linux.intel.com>
 <1554835562-25056-5-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554835562-25056-5-git-send-email-richard.gong@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 01:46:00PM -0500, richard.gong@linux.intel.com wrote:
> +/*
> + * This driver exposes some optional features of the Intel Stratix 10 SoC FPGA.
> + * The SysFS interfaces exposed here are FPGA Remote System Update (RSU)

It has never been "SysFS", it has always been "sysfs".

> + * related.  They allow user space software to query the configuration system
> + * status and to request optional reboot behavior specific to Intel FPGAs.
> + */
> +
> +static ssize_t current_image_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
> +
> +	if (!priv)
> +		return -ENODEV;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%ld", priv->status.current_image);

While it is all nice and fine to try to be "safe" and use scnprintf() it
turns out that if you EVER care about the size of a sysfs buffer, your
code is doing something wrong.  This can just be a simple sprintf()
call.

Same goes for everywhere in this file.

thanks,

greg k-h
