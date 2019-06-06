Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AB2C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CE020868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559827727;
	bh=UHWrtQgpvixRqPbEtkrChsh4DvWxscCBoV1YMgNBxGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2sQInZBB/cLlbMBtlSrg0bILaG4SAi0rJVMEK3iMvq/r3W5sYr9n36BIZWoZZR8ZQ
	 1dobqX9Q9wU05sbr1asvsjtek5ojf3N607S/1JeA0/EDFrjzohkCXbmoQRz3UZ2QIF
	 iE4y09Qi9SIyl+WaZ/gy+j5vAdjn3hqVN5yzlp6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfFFN2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfFFN2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:28:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A539D20866;
        Thu,  6 Jun 2019 13:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559827725;
        bh=UHWrtQgpvixRqPbEtkrChsh4DvWxscCBoV1YMgNBxGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0yjG6Bddq99LhfiaYiI3rJevdiHeIpzCUmVUfkqh052ofns7xizCLJEEC9QW8AWiR
         KwnSd5ZR1pPhnX7ZbkgIru9bVWnT57pk77L+901o8LE12SSIIYQfwZaXMVJHPetSEF
         qLNBBwl2a5cdhPnL08ZRoTAHkkoZZn9s0Ju27f2w=
Date:   Thu, 6 Jun 2019 15:28:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     arnd@arndb.de, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: Re: [PATCH V4 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Message-ID: <20190606132842.GC7943@kroah.com>
References: <1558784245-108751-1-git-send-email-dragan.cvetic@xilinx.com>
 <1558784245-108751-5-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558784245-108751-5-git-send-email-dragan.cvetic@xilinx.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 12:37:17PM +0100, Dragan Cvetic wrote:
> +static int xsdfec_dev_open(struct inode *iptr, struct file *fptr)
> +{
> +	return 0;
> +}
> +
> +static int xsdfec_dev_release(struct inode *iptr, struct file *fptr)
> +{
> +	return 0;
> +}

empty open/close functions are never needed, just drop them.

> +
> +static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
> +			     unsigned long data)
> +{
> +	struct xsdfec_dev *xsdfec;
> +	void __user *arg = NULL;
> +	int rval = -EINVAL;
> +
> +	xsdfec = container_of(fptr->private_data, struct xsdfec_dev, miscdev);
> +	if (!xsdfec)
> +		return rval;

It is impossible for container_of() to return NULL, unless something
very magical and rare just happened.  It's just doing pointer math, you
can never check the return value of it.

> +
> +	if (_IOC_TYPE(cmd) != XSDFEC_MAGIC)
> +		return -ENOTTY;

How can this happen?

> +
> +	/* check if ioctl argument is present and valid */
> +	if (_IOC_DIR(cmd) != _IOC_NONE) {
> +		arg = (void __user *)data;
> +		if (!arg)
> +			return rval;
> +	}
> +
> +	switch (cmd) {
> +	default:
> +		/* Should not get here */
> +		dev_warn(xsdfec->dev, "Undefined SDFEC IOCTL");

Nice that userspace has a way to fill up the kernel log :(

Just return the correct error here, don't log it.

thanks,

greg k-h
