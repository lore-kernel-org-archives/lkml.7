Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F15C2D0CB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2872C22B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576171976;
	bh=d8T+W80ohSAutSwyvwOIJCoFk70VslbyWmhLhSjuY/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s22pqKpxpEX3su5ZHy0OhCoz4cFtSIv3uK9ryBuAGnH608OSbbn+wqPfVIGimXCGn
	 6qop8X9xIonMrDEQdUCfbCG/rdxzcMNZ+AnpJloUMhP30+APctLrWNFJGbPHRPmzul
	 gh72rbw/Ao43reXRzRI4YKMMWaYbrdDLMfQwQXJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbfLLRcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:32:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730023AbfLLRcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:32:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C21FA21655;
        Thu, 12 Dec 2019 17:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576171974;
        bh=d8T+W80ohSAutSwyvwOIJCoFk70VslbyWmhLhSjuY/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3WTTM5ez2jJGTd/r4ZgkBqS0RQv+WurCDZfPVTAe9IMbQVFSXPGEZ/4/oPfA+PLc
         1HpYJVtHaQxCrhoZlvds+/CWRZStluyP0fTC8gN5/TQhnuz7SLcb54YCtcBgRW/ZqR
         k95AzqrkG069hz1bwHqMckyPeMKhD7tdGsmsMR6M=
Date:   Thu, 12 Dec 2019 18:32:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [RFC 5/5] i3c: add i3cdev module to expose i3c dev in /dev
Message-ID: <20191212173251.GA1702856@kroah.com>
References: <cover.1575977795.git.vitor.soares@synopsys.com>
 <f9f20eaf900ed5629dd3d824bc1e90c7e6b4a371.1575977795.git.vitor.soares@synopsys.com>
 <20191212144459.GB1668196@kroah.com>
 <CH2PR12MB421658E00DF331400728DB6CAE550@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20191212160045.GA1672362@kroah.com>
 <CH2PR12MB4216CB1D650A543A635CC67FAE550@CH2PR12MB4216.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR12MB4216CB1D650A543A635CC67FAE550@CH2PR12MB4216.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 05:25:28PM +0000, Vitor Soares wrote:
> From: Greg KH <gregkh@linuxfoundation.org>
> Date: Thu, Dec 12, 2019 at 16:00:45
> 
> > On Thu, Dec 12, 2019 at 02:56:56PM +0000, Vitor Soares wrote:
> > > Hi Greg,
> > > 
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Date: Thu, Dec 12, 2019 at 14:44:59
> > > 
> > > > On Tue, Dec 10, 2019 at 04:37:33PM +0100, Vitor Soares wrote:
> > > > > +static int __init i3cdev_init(void)
> > > > > +{
> > > > > +	int res;
> > > > > +
> > > > > +	pr_info("i3c /dev entries driver\n");
> > > > 
> > > > Please remove debugging information, kernel code should be quiet unless
> > > > something goes wrong.
> > > 
> > > I will remove it.
> > > 
> > > > 
> > > > > +	/* Dynamically request unused major number */
> > > > > +	res = alloc_chrdev_region(&i3cdev_number, 0, N_I3C_MINORS, "i3c");
> > > > 
> > > > Do you really need a whole major, or will a few minors work?
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > I'm reserving one per device. What do you suggest?
> > 
> > How many devices do you have in a system?
> 
> According to MIPI I3C spec, the maximum number of devices on a bus will 
> depend on trace length, bus load, and clock requirements.
> 
> Frankly, I don't know what is the best compromise because it depends from 
> system to system and the end-use of it. In my case, I started developing 
> this to help me during the HC controller driver development.
> Even If I choose a fixed major, I wouldn't know in which one i3c fits.

Ok, a full major will be fine, I was worried you only wanted 1 or 2
minor numbers, which would mean you could have used a misc device
instead.

This is fine.

thanks,

greg k-h
