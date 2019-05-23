Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133AAC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C750F21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558614411;
	bh=HK+MM2tEj5krZ4ZVCzJ1PseSGZxhZ7gCRD7VksuUYZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=06w58WV2zvDcx+fKbo1NY/xshLDcoXg73p8lgDmDIHoieF+qzLSM6VtJOK+8mRuxo
	 ewSHY2QqhSinE7AQgv5aRq0YjXlNzA0wSgDOiENfXwiwm2lq1E6HMhFFjkoj15GwAq
	 mCWR9AfkpDlBWylcDXE+gkeeM4UxmdpEpr6pxHIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfEWM0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730560AbfEWM0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:26:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD2D020851;
        Thu, 23 May 2019 12:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558614410;
        bh=HK+MM2tEj5krZ4ZVCzJ1PseSGZxhZ7gCRD7VksuUYZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rs8PlBDuvJVnF7DqEA6hA8cx19nFcYB9jxFuuFeo9iOC7D19mp2mgSSj9Og88jlLa
         R3be9VphvUgvbw3fevnZixLZTJEwitM0NmdDkhpkuqqghGVtAbZUtFj/rKE4DrdmkH
         yZkFAIQUpt2G/xkMBtplp/hAbxmn6Ach5ROhnR58=
Date:   Thu, 23 May 2019 14:26:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH 2/8] staging: kpc2000: use __func__ in debug messages
Message-ID: <20190523122647.GB26641@kroah.com>
References: <20190523113613.28342-1-simon@nikanor.nu>
 <20190523113613.28342-3-simon@nikanor.nu>
 <20190523115553.GA6953@kroah.com>
 <20190523120937.zq6gif6amslfruna@dev.nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190523120937.zq6gif6amslfruna@dev.nikanor.nu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 02:09:37PM +0200, Simon Sandström wrote:
> On Thu, May 23, 2019 at 01:55:53PM +0200, Greg KH wrote:
> > On Thu, May 23, 2019 at 01:36:07PM +0200, Simon Sandström wrote:
> > > Fixes checkpatch.pl warning "Prefer using '"%s...", __func__' to using
> > > '<function name>', this function's name, in a string".
> > > 
> > > Signed-off-by: Simon Sandström <simon@nikanor.nu>
> > > ---
> > >  drivers/staging/kpc2000/kpc2000/cell_probe.c | 22 +++++++++++++-------
> > >  1 file changed, 14 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
> > > index 95bfbe4aae4d..7b850f3e808b 100644
> > > --- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
> > > +++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
> > > @@ -299,7 +299,8 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
> > >  
> > >  	kudev = kzalloc(sizeof(struct kpc_uio_device), GFP_KERNEL);
> > >  	if (!kudev) {
> > > -		dev_err(&pcard->pdev->dev, "probe_core_uio: failed to kzalloc kpc_uio_device\n");
> > > +		dev_err(&pcard->pdev->dev, "%s: failed to kzalloc kpc_uio_device\n",
> > > +			__func__);
> > 
> > kmalloc and friend error messages should just be deleted.  Didn't
> > checkpatch say something about that?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Yes sorry, it did. Should I delete this chunk from this patch and add
> another patch to this series that just deletes the message, in v2?

Yes please.

thanks,

greg k-h
