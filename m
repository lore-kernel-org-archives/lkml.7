Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43C0C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A639920B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560874049;
	bh=C5HuQ7CclE7PlzKrV0OVkryY20n/Y2J2280bttBpXEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MyCV/LFwovHQ7Yy+LU42BjfVlC4WPA71CECjfPC/uotqzonosdxymlCT+AWSWQrAy
	 Nsr2iF0Dm14ERPF8NHHuNo55lMZRWYu8yFASboLJP35D7bYUArpZa12RQ59AzicAIc
	 oxNRRsNch8vNnVlRXnNyn9qluYo5bKcCrW6+hQQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfFRQH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729209AbfFRQH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:07:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CBB520B1F;
        Tue, 18 Jun 2019 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560874047;
        bh=C5HuQ7CclE7PlzKrV0OVkryY20n/Y2J2280bttBpXEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nkOv1d0Utiuhc2rnfE4ZDut9v8q9VCU2Rl67L7XrCsIik6O+hiMnw429wtLBT5U4n
         p3LAob3yhW1gQ4xKeNFuAcyRe7cKNQT4dv1YlMOAuTrCWumsbtQf24OKmXSibS3SzP
         9O+BULRamYKBO2myKtges0B6CRAFi823C3cSjI+c=
Date:   Tue, 18 Jun 2019 18:07:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        "open list:USB MASS STORAGE DRIVER" <linux-usb@vger.kernel.org>,
        "open list:USB MASS STORAGE DRIVER" 
        <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [PATCH 2/2] usb: storage: scsiglue: Do not skip VPD if
 try_vpd_pages is set
Message-ID: <20190618160724.GB27611@kroah.com>
References: <20190618013146.21961-3-marcos.souza.org@gmail.com>
 <Pine.LNX.4.44L0.1906180946160.1659-100000@iolanthe.rowland.org>
 <20190618151737.GA16959@geeko>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618151737.GA16959@geeko>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 12:17:39PM -0300, Marcos Paulo de Souza wrote:
> On Tue, Jun 18, 2019 at 09:48:01AM -0400, Alan Stern wrote:
> > On Mon, 17 Jun 2019, Marcos Paulo de Souza wrote:
> > 
> > > If BLIST_TRY_VPD_PAGES is set for a device, even for an USB, it should
> > > be honored, so only set skip_vpd_pages is try_vpd_pages is not set.
> > > 
> > > Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> > > ---
> > >  drivers/usb/storage/scsiglue.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
> > > index 59190d88fa9f..0a9520780771 100644
> > > --- a/drivers/usb/storage/scsiglue.c
> > > +++ b/drivers/usb/storage/scsiglue.c
> > > @@ -195,8 +195,11 @@ static int slave_configure(struct scsi_device *sdev)
> > >  		 */
> > >  		sdev->skip_ms_page_8 = 1;
> > >  
> > > -		/* Some devices don't handle VPD pages correctly */
> > > -		sdev->skip_vpd_pages = 1;
> > > +		/*
> > > +		 * Some devices don't handle VPD pages correctly, so skip vpd
> > > +		 * pages if not forced by SCSI layer.
> > > +		 */
> > > +		sdev->skip_vpd_pages = sdev->try_vpd_pages == 0;
> > >  
> > >  		/* Do not attempt to use REPORT SUPPORTED OPERATION CODES */
> > >  		sdev->no_report_opcodes = 1;
> > 
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > Although I think it would be clearer to write:
> > 
> > 		sdev->skip_vpd_pages = !sdev->try_vpd_pages;
> 
> I agree. Greg, would you like me to send a v2 of this patch with this change, or
> can you apply the change suggested by Alan?

I do not hand-edit patches, sorry.  It does not scale, please resend.

greg k-h
