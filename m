Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CC0C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE87124071
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559638799;
	bh=QeWEOfvvFgd6D5xz67dJiwIAbjDuXSoQfBcQfqCx6vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q0aLhkJaYPv9HAWacnwxPEq0nGgVVEL0YQgS9ogsyxRt3Y6thVEACg5XS4GD/D6E+
	 /Aq25cRIMCWIqMgdYEFz8iEwo8awMsfL0JWWphio9/kdnsfE2FBelC2Od2zM5kzBQE
	 Rxo2Afy9/CabmXYQZ7X4mqyn2puDzsmpn1yIO1v0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfFDI76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:59:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfFDI76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:59:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46FCF2404B;
        Tue,  4 Jun 2019 08:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559638797;
        bh=QeWEOfvvFgd6D5xz67dJiwIAbjDuXSoQfBcQfqCx6vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GgEO2+cNZkyKCAwZi4LKgJM6Ldf1AnZDfToPs6lQHtApD4dbm+htN3/5F5fu6p1qG
         0DtrLMsX/FhL4V0md2kS1IyHzxWUeoE39HEFzfTfobE2y0OOK4abvT9DnzZ54Ya/nZ
         9wC0Ivn1Sq0ttlnzEZdWyGKCRMxvBh146YOL7IVk=
Date:   Tue, 4 Jun 2019 10:59:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Lin <jilin@nvidia.com>
Cc:     stern@rowland.harvard.edu, mathias.nyman@intel.com,
        kai.heng.feng@canonical.com, drinkcat@chromium.org,
        Thinh.Nguyen@synopsys.com, nsaenzjulienne@suse.de,
        jflat@chromium.org, malat@debian.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 0/2] usb: xhci: Add Clear_TT_Buffer
Message-ID: <20190604085955.GA2855@kroah.com>
References: <1559559224-9845-1-git-send-email-jilin@nvidia.com>
 <20190603122303.GA16267@kroah.com>
 <e7ccbc27-2ff4-b1b9-aa1b-c77da5e122ca@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7ccbc27-2ff4-b1b9-aa1b-c77da5e122ca@nvidia.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 04:53:54PM +0800, Jim Lin wrote:
> 
> 
> On 2019年06月03日 20:23, Greg KH wrote:
> > On Mon, Jun 03, 2019 at 06:53:42PM +0800, Jim Lin wrote:
> > > USB 2.0 specification chapter 11.17.5 says "as part of endpoint halt
> > > processing for full-/low-speed endpoints connected via a TT, the host
> > > software must use the Clear_TT_Buffer request to the TT to ensure
> > > that the buffer is not in the busy state".
> > > 
> > > In our case, a full-speed speaker (ConferenceCam) is behind a high-
> > > speed hub (ConferenceCam Connect), sometimes once we get STALL on a
> > > request we may continue to get STALL with the folllowing requests,
> > > like Set_Interface.
> > > 
> > > Solution is to invoke usb_hub_clear_tt_buffer() to send
> > > Clear_TT_Buffer request to the hub of the device for the following
> > > Set_Interface requests to the device to get ACK successfully.
> > > 
> > > The Clear_TT_Buffer request sent to the hub includes the address of
> > > the LS/FS child device in wValue field. usb_hub_clear_tt_buffer()
> > > uses udev->devnum to set the address wValue. This won't work for
> > > devices connected to xHC.
> > > 
> > > For other host controllers udev->devnum is the same as the address of
> > > the usb device, chosen and set by usb core. With xHC the controller
> > > hardware assigns the address, and won't be the same as devnum.
> > > 
> > > Here we have two patches.
> > > One is to add devaddr in struct usb_device for
> > > usb_hub_clear_tt_buffer() to use.
> > > Another is to invoke usb_hub_clear_tt_buffer() for halt processing.
> > Why did you resend patch series 11?
> Didn't get response in 2 or 3 days.
> Will be more patient next time.

Please do, only resend if you do not get a response after 2 weeks.

thanks,

greg k-h
