Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C98C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DCD2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg2UJ6zY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfFRK5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:57:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35568 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729507AbfFRK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:57:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so14682214qto.2;
        Tue, 18 Jun 2019 03:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iNtD4nqgdcjPq+QbDW9ufam1Yl9j9a7cFfLokrIpxow=;
        b=Hg2UJ6zYatddEJUePiDtn1leIbAiQveIqQogq/ccMmVFikaKELdmz0Nj7Us3EywoE3
         cxRfBgJkvpxi+ol73OHAMeMF6jnw4ppS5HPJpzhv7Tvq4RKXVSSL2gG9Mxtyu1hiWupk
         mlqWXC+vNKf3v8JlAcfGSV5HLefd5W9hJq6+diAmmDba3ktN5hMWyD3paNr2jVUbgW2l
         GrMnxTW4g7mr4QcAR39XhYqD0sgotTWC9ZECcQiFT9t01kEdzVy8zIw1Kc2XiAOfQYNV
         zSzaDgTKKVb0gCjG4ulsKx8fekLbBZbsNrRRwr9MazmF2Ds2wodDjbbbjViAgHx/qlCs
         LGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iNtD4nqgdcjPq+QbDW9ufam1Yl9j9a7cFfLokrIpxow=;
        b=U0KGFqtRy469MRo4NWUZNtM9x+6xdCPcCfArmGoIS7pr5tzEbTGpBIVyvO6xzviz6m
         b0Rt5zZ12sb1uvSBiVEY5Vcmy3aRCdkgP3D7EmMYHUrIW9D0ALFGvoikV7fpmCcJJryv
         HansbobJP2mFASiE9f0dqiZgToMyILXsytDJSkC1B61/+lod88afKlH+BpgA8Vwxn+J7
         QPAEX0KejUgQtLBnYyUYWUWFHK3WT1tIDlgnbQp2K897zqOyloZ8lrgLUEzHTi4IcvPV
         bagqQwoDa71/OEpnjKWOqVHGDWXKtozLVTDNlRtmN4zVZgxFG03nSJWB93QWNWoAEHIU
         tpUA==
X-Gm-Message-State: APjAAAVLIYT3iwaRRJRYVfWXXEUJ9nIP20NZB3Q6tdtnclkD7fl9ZF/7
        T2ZP1+m0dB9z/syuXh9QYcXShAToyIM=
X-Google-Smtp-Source: APXvYqz133Gc8bVKrmUTYrRI8fbiciUcJ6gGBNxtrfY0FrDsAY5v8xnU1h1yCQ+jJVHjCdNqa0ZyjA==
X-Received: by 2002:aed:39e7:: with SMTP id m94mr19891860qte.0.1560855423728;
        Tue, 18 Jun 2019 03:57:03 -0700 (PDT)
Received: from geeko ([186.212.50.252])
        by smtp.gmail.com with ESMTPSA id g35sm2874993qtg.92.2019.06.18.03.56.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 03:57:03 -0700 (PDT)
Date:   Tue, 18 Jun 2019 07:56:33 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        "open list:USB MASS STORAGE DRIVER" <linux-usb@vger.kernel.org>,
        "open list:USB MASS STORAGE DRIVER" 
        <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [PATCH 2/2] usb: storage: scsiglue: Do not skip VPD if
 try_vpd_pages is set
Message-ID: <20190618105631.GB9372@geeko>
References: <20190618013146.21961-1-marcos.souza.org@gmail.com>
 <20190618013146.21961-3-marcos.souza.org@gmail.com>
 <20190618064947.GB22457@kroah.com>
 <20190618103001.GA9372@geeko>
 <20190618105203.GA18349@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618105203.GA18349@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 12:52:03PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 18, 2019 at 07:30:04AM -0300, Marcos Paulo de Souza wrote:
> > On Tue, Jun 18, 2019 at 08:49:47AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Jun 17, 2019 at 10:31:46PM -0300, Marcos Paulo de Souza wrote:
> > > > If BLIST_TRY_VPD_PAGES is set for a device, even for an USB, it should
> > > > be honored, so only set skip_vpd_pages is try_vpd_pages is not set.
> > > > 
> > > > Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> > > > ---
> > > >  drivers/usb/storage/scsiglue.c | 7 +++++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > Where is patch 1/2 of this series?
> > 
> > You can find it here:
> > https://lore.kernel.org/lkml/20190618013146.21961-2-marcos.souza.org@gmail.com/
> 
> So is this 2/2 patch independant of 1/2 and can go throught the USB
> tree, or do they both need to be together?

I think it is, since we are not dealing with something specific to a device in
this patch.

> 
> As it is, I have no idea what to do with this patch :(
Sorry, I relied in get_maintainer.pl only, so you weren't CCed in both patches.
But feel free to grab this patch in your tree.
> 
> thanks,
> 
> greg k-h

-- 
Thanks,
Marcos
