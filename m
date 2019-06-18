Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F420DC31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC62213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmQfx+N+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfFRPT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:19:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46914 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbfFRPT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:19:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so5834421pls.13;
        Tue, 18 Jun 2019 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fq5VhcilP64BeWXL9owdbnBuYJRBLePLtFWb4+IFtS0=;
        b=VmQfx+N+TXMUHraRKiYJCWtn8k2rkDMD2eDyuw/xku77OWNV4nVWeHoF22oeO9Vnyd
         VsENFxm83rAA7oLlf5/7TjC73E1UDERkvdegTFR2ETWgGKh3FQmq1eK5yJZANaxMdGfw
         W3LXlC7aHVKWI9W47gjrQ4qRWxL0cS3gmTJnZNrJAWQxnnvSFWSq+y74e6ofN0LJGrkb
         Sn+5tr+Tzl6aHgvLkKoufbAy5blzDkNzX/GbTGqMrqJzi/rVwaErwhVBRKBcLJ3mJml1
         FJZ8B7YvD2o939I92W9t/t6h6HFNr637qpGPs75mBYwvVlEt11Qhy2byZvnN69CnOykP
         NsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fq5VhcilP64BeWXL9owdbnBuYJRBLePLtFWb4+IFtS0=;
        b=LPGhzDzFy5XlZ06ATcwMd89PT9jwwzv9404hUfEtiqjJ2eCcZuBb48R4vn1J5AELSK
         vVtMqokP7a6UZ+36uUx2Cm9eR+tTn6MFkNQcexQQDmFkP4OHmyurpdxK4Hht6+M04TyN
         YC/FsGS2v/Gh2WsxZe+UGkQb+J6CjG1HWgyrAfDgiQPgUDcOWKzyvIvO8zI4aWh25qxd
         ZP59FkwfX9fpEXUdhheZt8LwrBzUX9g8IprBpHecyTUAySQGygAhVyBEzEjjyOhfF0KS
         8Gi7C++7ppA0Nuu81p91ycZ7gIU8xvtlr0S8DQSVxIaD6Pnkf0/sVW/7w0TdljVnEklc
         rsow==
X-Gm-Message-State: APjAAAUMuloipnOG7XZeAND45Fq6z+3NxyxgpTmRw1pNCxrrBKeYkfr7
        zaYTH5qNWRLSAQf4TYogqTc=
X-Google-Smtp-Source: APXvYqy7CigQ7qoDxgojxHeK25n9qpTdov7bJ10aWRlbXWEwHg13ccHte6Wg5AP9o6kiA6fB7y+m4Q==
X-Received: by 2002:a17:902:aa03:: with SMTP id be3mr36658303plb.240.1560871195259;
        Tue, 18 Jun 2019 08:19:55 -0700 (PDT)
Received: from geeko ([186.212.50.252])
        by smtp.gmail.com with ESMTPSA id j8sm14613224pfi.148.2019.06.18.08.19.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 08:19:54 -0700 (PDT)
Date:   Tue, 18 Jun 2019 12:17:39 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Kernel development list <linux-kernel@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB MASS STORAGE DRIVER" <linux-usb@vger.kernel.org>,
        "open list:USB MASS STORAGE DRIVER" 
        <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [PATCH 2/2] usb: storage: scsiglue: Do not skip VPD if
 try_vpd_pages is set
Message-ID: <20190618151737.GA16959@geeko>
References: <20190618013146.21961-3-marcos.souza.org@gmail.com>
 <Pine.LNX.4.44L0.1906180946160.1659-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1906180946160.1659-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 09:48:01AM -0400, Alan Stern wrote:
> On Mon, 17 Jun 2019, Marcos Paulo de Souza wrote:
> 
> > If BLIST_TRY_VPD_PAGES is set for a device, even for an USB, it should
> > be honored, so only set skip_vpd_pages is try_vpd_pages is not set.
> > 
> > Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> > ---
> >  drivers/usb/storage/scsiglue.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
> > index 59190d88fa9f..0a9520780771 100644
> > --- a/drivers/usb/storage/scsiglue.c
> > +++ b/drivers/usb/storage/scsiglue.c
> > @@ -195,8 +195,11 @@ static int slave_configure(struct scsi_device *sdev)
> >  		 */
> >  		sdev->skip_ms_page_8 = 1;
> >  
> > -		/* Some devices don't handle VPD pages correctly */
> > -		sdev->skip_vpd_pages = 1;
> > +		/*
> > +		 * Some devices don't handle VPD pages correctly, so skip vpd
> > +		 * pages if not forced by SCSI layer.
> > +		 */
> > +		sdev->skip_vpd_pages = sdev->try_vpd_pages == 0;
> >  
> >  		/* Do not attempt to use REPORT SUPPORTED OPERATION CODES */
> >  		sdev->no_report_opcodes = 1;
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Although I think it would be clearer to write:
> 
> 		sdev->skip_vpd_pages = !sdev->try_vpd_pages;

I agree. Greg, would you like me to send a v2 of this patch with this change, or
can you apply the change suggested by Alan?

Thanks,
Marcos

> 
> But that's just personal preference.  This is okay as it is.
> 
> Alan Stern
> 

-- 
Thanks,
Marcos
