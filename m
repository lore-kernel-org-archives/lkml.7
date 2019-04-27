Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E258EC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 21:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF8A208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 21:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556401769;
	bh=ad4NRf2D1FTn7+5by/ebxnREERSQZJsRoAGBTwdZ7K4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pKhpl9krA31wbbd3mWfI9WBUVy2ikyitK7GHQeteUyIJAvtSf+IspOVcQdgZtn27p
	 xvec2DYdq6qdOiJumIS/Lec8txF5XIeU5PXCGcVL8V5kgEXgdDdxbGq47N5wZ+rWK6
	 2Mf6Mf5DIqVQl9mUeWH8HGNghMOH+Xim/VYFMYZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfD0Vt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 17:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfD0Vt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 17:49:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB39620645;
        Sat, 27 Apr 2019 21:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556401767;
        bh=ad4NRf2D1FTn7+5by/ebxnREERSQZJsRoAGBTwdZ7K4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dq89bU2UJRp3k78iGEbCoJWQNVPkrxfNzNex5TBzfb5CKbmQ8ebcusXSQS/4FEm4g
         Nwrm1da3E1DtofGW7FdXzw7ncTI09feAE8QR9ENn7DkNLHThOv+THrOGT27WutXD97
         O9u7hApR9qV7Ae3sb24mah5W0Rf/BTT//XfZV520=
Date:   Sat, 27 Apr 2019 23:49:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     PanBian <bianpan2016@163.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: EDAC: Fix memory leak in creating CSROW object
Message-ID: <20190427214925.GE16338@kroah.com>
References: <1555554438-103953-1-git-send-email-bianpan2016@163.com>
 <20190418172548.GL27160@zn.tnic>
 <20190419003536.GA57795@bianpan2016@163.com>
 <20190419004516.GC559@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419004516.GC559@zn.tnic>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 02:45:16AM +0200, Borislav Petkov wrote:
> On Fri, Apr 19, 2019 at 08:35:36AM +0800, PanBian wrote:
> > Yes, I see that. Because the loop start with (--i), there is no put
> > operation for the device that fails to create. So, I think we cannot
> > rule out the possibility of memory leak.
> 
> Ok, so this is not something you trigger - you're basically staring at
> the code?
> 
> Well, there's something else questionable in that code which I asked
> Greg about today but we didn't finish that conversation, let me CC him.
> 
> So AFAIU, devices for which device_add() has returned success,
> should be removed with their counterpart device_del().
> edac_create_csrow_objects(), however, does put_device() on those in the
> "unwinding" loop.
> 
> And for the case where device_add() fails, you should do put_device() to
> it. I.e., what you're saying.
> 
> So I think we need to figure what needs to be done when before fixing
> this properly.
> 
> Greg?

How about this patch, I think it fixes up everything you need to do
here, right?


diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 464174685589..0fb2d1de6d0e 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -404,6 +404,8 @@ static inline int nr_pages_per_csrow(struct csrow_info *csrow)
 static int edac_create_csrow_object(struct mem_ctl_info *mci,
 				    struct csrow_info *csrow, int index)
 {
+	int retval;
+
 	csrow->dev.type = &csrow_attr_type;
 	csrow->dev.groups = csrow_dev_groups;
 	device_initialize(&csrow->dev);
@@ -415,7 +417,10 @@ static int edac_create_csrow_object(struct mem_ctl_info *mci,
 	edac_dbg(0, "creating (virtual) csrow node %s\n",
 		 dev_name(&csrow->dev));
 
-	return device_add(&csrow->dev);
+	retval = device_add(&csrow->dev);
+	if (retval)
+		put_device(&csrow->dev);
+	return retval;
 }
 
 /* Create a CSROW object under specifed edac_mc_device */
@@ -649,6 +654,8 @@ static int edac_create_dimm_object(struct mem_ctl_info *mci,
 
 	edac_dbg(0, "creating rank/dimm device %s\n", dev_name(&dimm->dev));
 
+	if (err)
+		put_device(&dimm->dev);
 	return err;
 }
 
@@ -928,6 +935,7 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 	err = device_add(&mci->dev);
 	if (err < 0) {
 		edac_dbg(1, "failure: create device %s\n", dev_name(&mci->dev));
+		put_device(mci->dev);
 		goto out;
 	}
 
