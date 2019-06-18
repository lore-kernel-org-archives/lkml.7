Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A44C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04362085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560855128;
	bh=J0Lun6i6fIgucD20SF/FNzWUD+MvjLFZOAudnlwwWfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i5sb3vT4EOMlkHMxmJXe/4z9hOu42pmFsbNKu8wO23L71UbnhP78w3cksIQw89Ser
	 85Nt7caLC0deW6pnEBULNvnVazIr+XH0Dv2c4V1Iej88JaWdG2vA2Z8Hr5tyVygPhF
	 GvjZy1TtPy6gO9tXOWFjD1XMkVyF5iZEknOP26nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbfFRKwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfFRKwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:52:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A6B52080C;
        Tue, 18 Jun 2019 10:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560855126;
        bh=J0Lun6i6fIgucD20SF/FNzWUD+MvjLFZOAudnlwwWfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0LE4FpVjNlT7uuhzEwQTmd8tmzf2u6Jd2FxCM/vhwFgnb/8xv2PAfYjn6ltYHR4Kh
         18txgdSNOEnTThNIs/uO4/c16CRaUXJkf77OAZKO90DsidaEH7UbvQqSMvdBipU+vc
         Y2RVrd62MD1qB6cpWxBGMc3uUb0VO51qgKibybWo=
Date:   Tue, 18 Jun 2019 12:52:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        "open list:USB MASS STORAGE DRIVER" <linux-usb@vger.kernel.org>,
        "open list:USB MASS STORAGE DRIVER" 
        <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [PATCH 2/2] usb: storage: scsiglue: Do not skip VPD if
 try_vpd_pages is set
Message-ID: <20190618105203.GA18349@kroah.com>
References: <20190618013146.21961-1-marcos.souza.org@gmail.com>
 <20190618013146.21961-3-marcos.souza.org@gmail.com>
 <20190618064947.GB22457@kroah.com>
 <20190618103001.GA9372@geeko>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618103001.GA9372@geeko>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 07:30:04AM -0300, Marcos Paulo de Souza wrote:
> On Tue, Jun 18, 2019 at 08:49:47AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jun 17, 2019 at 10:31:46PM -0300, Marcos Paulo de Souza wrote:
> > > If BLIST_TRY_VPD_PAGES is set for a device, even for an USB, it should
> > > be honored, so only set skip_vpd_pages is try_vpd_pages is not set.
> > > 
> > > Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> > > ---
> > >  drivers/usb/storage/scsiglue.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > Where is patch 1/2 of this series?
> 
> You can find it here:
> https://lore.kernel.org/lkml/20190618013146.21961-2-marcos.souza.org@gmail.com/

So is this 2/2 patch independant of 1/2 and can go throught the USB
tree, or do they both need to be together?

As it is, I have no idea what to do with this patch :(

thanks,

greg k-h
