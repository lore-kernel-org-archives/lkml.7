Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C475C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 09:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C4C2084A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 09:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556960528;
	bh=0HZkZL9+I1+nEWaQ8L+l+Qk9L37TE+cDxjDKQFi3lR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wxPhivFoGtIcD471Gh7kpCMGFEO73YQY2BK9ZVhAFlwDos2+mFI8ov1D+3gZXwg8K
	 i4NC+bmp2HdwGxuDIAEPHAcov5JxcquaqCI2JfpxefZbkwt210FhX2hZMtLHi8yxrg
	 b2C1Fi4ZU/OD+HddDU0e+FQIYB65k/vZqEHslA88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfEDJCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 05:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfEDJCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 05:02:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 328C9206BB;
        Sat,  4 May 2019 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556960525;
        bh=0HZkZL9+I1+nEWaQ8L+l+Qk9L37TE+cDxjDKQFi3lR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sXlFYt/gekvCpmVrEJ1kh89YcejLx5OXMuCHj+pbUfveEorE7uUURo5+Xd/QOxshh
         G7VAjy4dYKRuRrzpQHjwHAKPFQ4/vrWfLXOkCAnixni9c/QCKftw4UKHQ9XNIbOpz8
         wypPlbeEvAs5LS+Zb2lCGAUnaMtzuuqNqRsTNA+k=
Date:   Sat, 4 May 2019 11:02:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <draganc@xilinx.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: Re: [PATCH V3 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Message-ID: <20190504090203.GD13840@kroah.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-5-git-send-email-dragan.cvetic@xilinx.com>
 <20190502172304.GB1874@kroah.com>
 <BL0PR02MB5681F4C4AF4786AC6241DDA1CB350@BL0PR02MB5681.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR02MB5681F4C4AF4786AC6241DDA1CB350@BL0PR02MB5681.namprd02.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 04:44:57PM +0000, Dragan Cvetic wrote:
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Thursday 2 May 2019 18:23
> > To: Dragan Cvetic <draganc@xilinx.com>
> > Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org; robh+dt@kernel.org;
> > mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Derek Kiernan <dkiernan@xilinx.com>
> > Subject: Re: [PATCH V3 04/12] misc: xilinx_sdfec: Add open, close and ioctl
> > 
> > On Sat, Apr 27, 2019 at 11:04:58PM +0100, Dragan Cvetic wrote:
> > > +static int xsdfec_dev_open(struct inode *iptr, struct file *fptr)
> > > +{
> > > +	struct xsdfec_dev *xsdfec;
> > > +
> > > +	xsdfec = container_of(iptr->i_cdev, struct xsdfec_dev, xsdfec_cdev);
> > > +
> > > +	if (!atomic_dec_and_test(&xsdfec->open_count)) {
> > 
> > Why do you care about this?
> > 
> > And do you really think it matters?  What are you trying to protect from
> > here?
> 
> There is a request to increase the driver security. 

How does this affect "security" in any way?

> It is acceptable for us for now, even with non-perfections (will not
> be protected if opened twice with dup() or fork()).  This is covered
> in the documentation.

As this really "does nothing", no need to bother the kernel with trying
to keep this logic working properly.  So please just drop it.

thanks,

greg k-h
