Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9069C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA1720657
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559923057;
	bh=moVjOQu+0fxwl4+qBFcaT5nSX69Y7SsHo95mn91RMHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gAnyWqUE+OQfdkCYZ27siEinou9taGPvcN2I8jQGgDFzlc2z21ebK/+29IWVAPxXi
	 8VfpzgXUeM7AL4elTyTDk48nevkKZ17UpAhetsR3xoq7tF07m2n28s1VnX/SQbiw4k
	 rbz3OUF7i5x0RHlaeWmCBOIzxiHADHbaD1iNewyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbfFGP5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:57:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbfFGP5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:57:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 176DA20657;
        Fri,  7 Jun 2019 15:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559923054;
        bh=moVjOQu+0fxwl4+qBFcaT5nSX69Y7SsHo95mn91RMHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PnGgQlJFu52ZBRKJpAN9rhg2ncvxnPs76IhL3/WakJ2O3M2BtbHjQWErDkxeGpUF+
         bespNOJSQEEziWFq+cSe6WmQOh5vTwd68C0aNND520a/ipC1JWK6SLnPjqnZ6p0jvL
         LPAK2XM8gVoPaLkso8Zs9BEZjgYJVqd5LGUtXTrw=
Date:   Fri, 7 Jun 2019 17:57:31 +0200
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
Subject: Re: [PATCH V4 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Message-ID: <20190607155731.GB8752@kroah.com>
References: <1558784245-108751-1-git-send-email-dragan.cvetic@xilinx.com>
 <1558784245-108751-5-git-send-email-dragan.cvetic@xilinx.com>
 <20190606132842.GC7943@kroah.com>
 <CH2PR02MB6359747C72220A978CCA807BCB100@CH2PR02MB6359.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR02MB6359747C72220A978CCA807BCB100@CH2PR02MB6359.namprd02.prod.outlook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 10:58:34AM +0000, Dragan Cvetic wrote:
> > On Sat, May 25, 2019 at 12:37:17PM +0100, Dragan Cvetic wrote:
> > > +static int xsdfec_dev_open(struct inode *iptr, struct file *fptr)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static int xsdfec_dev_release(struct inode *iptr, struct file *fptr)
> > > +{
> > > +	return 0;
> > > +}
> > 
> > empty open/close functions are never needed, just drop them.
> > 
> 
> open() is needed to allocate file descriptor eg.
> fd = open(dev_name, O_RDWR);

But you do nothing in those open/release callbacks.  Remove them and see
that the code works just fine :)

thanks,

greg k-h
