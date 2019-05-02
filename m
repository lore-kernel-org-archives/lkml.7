Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D4BC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3C02075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556817788;
	bh=t2QvyURycKIiTirpOYn/f0cP4QvJwYDjk22RYCF4a+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nE3vgEIpSYZo9W5LNkLxYjYX06rp+/PLBvknsRqJqFiU4Wg145V24cW9WSOdF6ZeG
	 nW/gTVxW9eH5uUX9PB8T0kdu129u8ywaqVpflAumW/V8Hyrw/JENoU8HWj5EXNVo6C
	 GjGNUvusrtuyh2vkTwKSoujjSKk7ibcOblIemjic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfEBRXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 13:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfEBRXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 13:23:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D7AF20651;
        Thu,  2 May 2019 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556817786;
        bh=t2QvyURycKIiTirpOYn/f0cP4QvJwYDjk22RYCF4a+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0lNIcEHEVT9rbk92gU+FW0N3Qz5n3G1kCyITcS1sJnzAGBVSQuP5hWVsC1PfATO32
         Heunaeq15bx7iceyRMN+Lt13IeCgeNjZbcTF0HwBaRq6MLYek0Vo3tDTx25aDESnlP
         z3FGoKjHRArhzb8Ir2amvCJJBoxSNgA63ocOiPYs=
Date:   Thu, 2 May 2019 19:23:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     arnd@arndb.de, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: Re: [PATCH V3 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Message-ID: <20190502172304.GB1874@kroah.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-5-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556402706-176271-5-git-send-email-dragan.cvetic@xilinx.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 11:04:58PM +0100, Dragan Cvetic wrote:
> +static int xsdfec_dev_open(struct inode *iptr, struct file *fptr)
> +{
> +	struct xsdfec_dev *xsdfec;
> +
> +	xsdfec = container_of(iptr->i_cdev, struct xsdfec_dev, xsdfec_cdev);
> +
> +	if (!atomic_dec_and_test(&xsdfec->open_count)) {

Why do you care about this?

And do you really think it matters?  What are you trying to protect from
here?

> +		atomic_inc(&xsdfec->open_count);
> +		return -EBUSY;
> +	}
> +
> +	fptr->private_data = xsdfec;
> +	return 0;
> +}
> +
> +static int xsdfec_dev_release(struct inode *iptr, struct file *fptr)
> +{
> +	struct xsdfec_dev *xsdfec;
> +
> +	xsdfec = container_of(iptr->i_cdev, struct xsdfec_dev, xsdfec_cdev);
> +
> +	atomic_inc(&xsdfec->open_count);

You increment a number when the device is closed?

You are trying to make it hard to maintain this code over time :)


> +	return 0;
> +}
> +
> +static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
> +			     unsigned long data)
> +{
> +	struct xsdfec_dev *xsdfec = fptr->private_data;
> +	void __user *arg = NULL;
> +	int rval = -EINVAL;
> +	int err = 0;
> +
> +	if (!xsdfec)
> +		return rval;
> +
> +	if (_IOC_TYPE(cmd) != XSDFEC_MAGIC)
> +		return -ENOTTY;
> +
> +	/* check if ioctl argument is present and valid */
> +	if (_IOC_DIR(cmd) != _IOC_NONE) {
> +		arg = (void __user *)data;
> +		if (!arg) {
> +			dev_err(xsdfec->dev,
> +				"xilinx sdfec ioctl argument is NULL Pointer");

You just created a way for userspace to spam the kernel log, please do
not do that :(



> +			return rval;
> +		}
> +	}
> +
> +	if (err) {
> +		dev_err(xsdfec->dev, "Invalid xilinx sdfec ioctl argument");
> +		return -EFAULT;

Wrong error, you did not have a memory fault.

Again, you just created a way to spam the kernel log by a user :(

thanks,

greg k-h
