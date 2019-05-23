Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5CCC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A172133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558589807;
	bh=T5rbljQ/TpWOK/SheWHZacX0s9uGf+CMLU0n9yVBEw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wsMVFSwNvdiVRkflYFJTbtKImF531pipZNo1sOyk40Jt9RhF8P5awag8TxkKve7PQ
	 lmRP1ndVe9IHtJFZiOEZcBHYDVosK3QvK2jL1tY79oeb6fx1oCVKt7oOICV9/PACqz
	 8acj+CbPIzJoN6keNJeJ9KXwFAZhL1Nby7Xpu8vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfEWFgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 01:36:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfEWFgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 01:36:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEA3620881;
        Thu, 23 May 2019 05:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558589806;
        bh=T5rbljQ/TpWOK/SheWHZacX0s9uGf+CMLU0n9yVBEw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ooNbLRJD3kh3DFoMD5WXtuYc1PKpdqZOddzQSIG6mFIWeRNLFSAPhUwuaXMaFeirf
         7Gv1Y/jmgQs/vzdj/BFt59+oRdT27RUSOa795l4i/SQm6xrNzpIdSLWDDBpG5ZgdTL
         1oWZKZEsq2N2LzFa5orDlKbsZ2JdU3RtUHzIZNy0=
Date:   Thu, 23 May 2019 07:36:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geordan Neukum <gneukum1@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/6] staging: kpc2000: make kconfig symbol 'KPC2000'
 select dependencies
Message-ID: <20190523053643.GA14465@kroah.com>
References: <cover.1558526487.git.gneukum1@gmail.com>
 <932843299b814f3a22dd176771b46be14ceefeea.1558526487.git.gneukum1@gmail.com>
 <20190522122714.GA2270@kroah.com>
 <CA+T6rvEXCBukwmFS-Z4DFNoFBv9OToWwAYA2AXWBVa5mUG10zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+T6rvEXCBukwmFS-Z4DFNoFBv9OToWwAYA2AXWBVa5mUG10zA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 01:35:02AM +0000, Geordan Neukum wrote:
> On Wed, May 22, 2019 at 12:27 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > depends on is better than select.  There's a change to depend on UIO for
> > this code already in my -linus branch which will show up in Linus's tree
> > in a week or so.
> 
> Noted on both accounts. Thanks for the feedback and sorry for the
> inconvenience on the latter.
> 
> > Are you sure we need MFD_CORE as well for this code?
> 
> I noticed the build issue when working locally. I was doing
> something along the lines of: 'make distclean && make x86_64_defconfig',
> selecting 'CONFIG_KPC2000' and 'CONFIG_UIO' via menuconfig, then
> running a good old 'make'. From make, I received an error along the
> lines of:
> 
> ERROR: "mfd_remove_devices"
> [drivers/staging/kpc2000/kpc2000/kpc2000.ko] undefined!
> ERROR: "mfd_add_devices" [drivers/staging/kpc2000/kpc2000/kpc2000.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:91: __modpost] Error 1
> make: *** [Makefile:1290: modules] Error 2
> 
> which appears to indicate that those two symbols are undefined. When
> I looked, it appeared that those symbols were exported from the
> mfd-core which is why I also threw in a select for that Kconfig
> symbol. Assuming that I didn't do something silly above, I'd be happy
> to submit a new patch (with only a depends on for MFD_CORE) as I
> continue trying to fix up the i2c driver.

Yes, a depends for MFD_CORE would be good, can you base it against my
staging-linus branch so that fix can go to Linus for this release?

thanks,

greg k-h
