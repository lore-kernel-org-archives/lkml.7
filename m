Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905D5C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631A02084D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMWtH1wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfFRWqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:46:08 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39962 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbfFRWqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:46:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id c70so9683600qkg.7;
        Tue, 18 Jun 2019 15:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mUtA9/6/AAD1eIEyzfXACbNQ2OjUtf2oEBKdRu1pSvE=;
        b=aMWtH1wgzkBsvyxHVfGHmna9Wm1HpsWZ+/lQ9BW2bi8ZUL2zzk3ngIU5HhyMhFb+P/
         phzt8WY5qRqZWszJubM7TkNavlcMNn/6/vDIG49wUbXTyA15XsBd3w9G6uzuENpKtmZx
         jTxe90cWudI4fPaBfFsLzLGh8PlRgdYlwh8XqEzXh/lvLGdZMO3I+ZVnLu61845DlupN
         1GxkBj7vAekEDtMRrzybnsEAeGWh2K5COTOKWVFMMO/9xF0oMm/rH0KGX01TceV/cBEq
         UYSVP6fNwbt3kEa/hHLAHzA/UIetWuYprkGbA5/IsXRJep7VLmHlWrtsFg02r+bXmls/
         FWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mUtA9/6/AAD1eIEyzfXACbNQ2OjUtf2oEBKdRu1pSvE=;
        b=Q/DRrUtOpNwxbbXF/EQqg2lDgq9gy7JmXWXTNMUpPHfo3eMsYlD7cWoRpu6ztDq0ZM
         flco8NR8A21jfaMwydSf297/XfUspeFoz30ZqJEDTr0t7iBpjzGulF7oTK/0uU/euMsQ
         ZGUoRi4o5Sp4ZWCJ1HfqOB1wxR419gnxvC4i/MIAvQnxJnCTuxSc1K3etvAB8ixWSamI
         J/mJ8J81zPhv72DGooJ2JUV4TQSJqivUdoAAOlHX8ucRduB819N/7k08N32T+BFg1ETV
         FKCmmUHbZj16OuBcrUDbUOxkKeLLAGcWknjOEjEWiY75S/Niia5O5H2vGocMaLuV45ul
         MMSw==
X-Gm-Message-State: APjAAAXdXnXT5bHWW2YumutSc9BMmnhP1Fi1tcAR3Qq9MBKfHTilYjYx
        T7oi+3E/kov2CJQ/SgzjNc4=
X-Google-Smtp-Source: APXvYqzJEZ1IXIuiNmNnD3CyA/zcqjUGKEPvX/WWrxHWTq2mYXL9qnaqZFXzBzBCqvpfh62vrhQXYA==
X-Received: by 2002:a05:620a:119c:: with SMTP id b28mr45261206qkk.104.1560897966524;
        Tue, 18 Jun 2019 15:46:06 -0700 (PDT)
Received: from continental ([186.212.50.252])
        by smtp.gmail.com with ESMTPSA id s66sm9090841qkh.17.2019.06.18.15.46.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 15:46:05 -0700 (PDT)
Date:   Tue, 18 Jun 2019 19:46:35 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        "open list:USB MASS STORAGE DRIVER" <linux-usb@vger.kernel.org>,
        "open list:USB MASS STORAGE DRIVER" 
        <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [PATCH 2/2] usb: storage: scsiglue: Do not skip VPD if
 try_vpd_pages is set
Message-ID: <20190618224633.GA11899@continental>
References: <20190618013146.21961-3-marcos.souza.org@gmail.com>
 <Pine.LNX.4.44L0.1906180946160.1659-100000@iolanthe.rowland.org>
 <20190618151737.GA16959@geeko>
 <20190618160724.GB27611@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618160724.GB27611@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 06:07:24PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 18, 2019 at 12:17:39PM -0300, Marcos Paulo de Souza wrote:
> > On Tue, Jun 18, 2019 at 09:48:01AM -0400, Alan Stern wrote:
> > > On Mon, 17 Jun 2019, Marcos Paulo de Souza wrote:
> > > 
> > > > If BLIST_TRY_VPD_PAGES is set for a device, even for an USB, it should
> > > > be honored, so only set skip_vpd_pages is try_vpd_pages is not set.
> > > > 
> > > > Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> > > > ---
> > > >  drivers/usb/storage/scsiglue.c | 7 +++++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
> > > > index 59190d88fa9f..0a9520780771 100644
> > > > --- a/drivers/usb/storage/scsiglue.c
> > > > +++ b/drivers/usb/storage/scsiglue.c
> > > > @@ -195,8 +195,11 @@ static int slave_configure(struct scsi_device *sdev)
> > > >  		 */
> > > >  		sdev->skip_ms_page_8 = 1;
> > > >  
> > > > -		/* Some devices don't handle VPD pages correctly */
> > > > -		sdev->skip_vpd_pages = 1;
> > > > +		/*
> > > > +		 * Some devices don't handle VPD pages correctly, so skip vpd
> > > > +		 * pages if not forced by SCSI layer.
> > > > +		 */
> > > > +		sdev->skip_vpd_pages = sdev->try_vpd_pages == 0;
> > > >  
> > > >  		/* Do not attempt to use REPORT SUPPORTED OPERATION CODES */
> > > >  		sdev->no_report_opcodes = 1;
> > > 
> > > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > > 
> > > Although I think it would be clearer to write:
> > > 
> > > 		sdev->skip_vpd_pages = !sdev->try_vpd_pages;
> > 
> > I agree. Greg, would you like me to send a v2 of this patch with this change, or
> > can you apply the change suggested by Alan?
> 
> I do not hand-edit patches, sorry.  It does not scale, please resend.

No problem, v2 just sent:
https://lore.kernel.org/linux-usb/20190618224454.16595-1-marcos.souza.org@gmail.com/T/#u

Thanks Alan for the quick review!

> 
> greg k-h
