Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F529C49ED6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3865521A4A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568069973;
	bh=wnGFbFCsHYNvoXpyoyWnpL1YlHr9TO1GLdw1SaXPCGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UEaMKTJOFqzojSXPNTihCviBqwpbYQ1/CZ1ZMW/wuE4aHWiIsPITwvTI9fYK0heQQ
	 frMbhKAdDPBLhj5yv/w5czfkXzK/8Qzp4s8Yv2RCc3DkXpqggZmNXMGd0EJpLKuAzb
	 kIGoesuX6Nh4hzji/g9yX2tygDmYjuevMFQyECzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfIIW7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbfIIW7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:59:32 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E334E21479;
        Mon,  9 Sep 2019 22:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568069971;
        bh=wnGFbFCsHYNvoXpyoyWnpL1YlHr9TO1GLdw1SaXPCGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mroRduAdLebUkfpP2PySv8Oug2YNSPLDoV0+hXxO+FmI31yayf0HCt4bVcRpqlm0f
         b8Dgs+SMGaAgD/c5vYd0PQGR2h1J0Tn372p0LK4z/UXySK1WDe5xeuNWIXTst8yAXG
         kLhYov+tgKolfGqK6TsTsJf7it9XlaexmeacTbWA=
Date:   Mon, 9 Sep 2019 23:59:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Fabian Henneke <fabian.henneke@gmail.com>
Cc:     Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 19/57] Bluetooth: hidp: Let hidp_send_message return
 number of queued bytes
Message-ID: <20190909225929.GC26405@kroah.com>
References: <20190908121125.608195329@linuxfoundation.org>
 <20190908121132.859238319@linuxfoundation.org>
 <20190909121555.GA18869@amd>
 <8e7731e0-f0ad-8cbb-799e-dd585e6b7ed6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e7731e0-f0ad-8cbb-799e-dd585e6b7ed6@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 03:00:46PM +0200, Fabian Henneke wrote:
> Hi,
> 
> On Mon, Sep 9, 2019 at 2:15 PM Pavel Machek <pavel@denx.de> wrote:
> 
> > Hi!
> >
> > > [ Upstream commit 48d9cc9d85dde37c87abb7ac9bbec6598ba44b56 ]
> > >
> > > Let hidp_send_message return the number of successfully queued bytes
> > > instead of an unconditional 0.
> > >
> > > With the return value fixed to 0, other drivers relying on hidp, such as
> > > hidraw, can not return meaningful values from their respective
> > > implementations of write(). In particular, with the current behavior, a
> > > hidraw device's write() will have different return values depending on
> > > whether the device is connected via USB or Bluetooth, which makes it
> > > harder to abstract away the transport layer.
> >
> > So, does this change any actual behaviour?
> >
> > Is it fixing a bug, or is it just preparation for a patch that is not
> > going to make it to stable?
> >
> 
> I created this patch specifically in order to ensure that user space
> applications can use HID devices with hidraw without needing to care about
> whether the transport is USB or Bluetooth. Without the patch, every
> hidraw-backed Bluetooth device needs to be treated specially as its write()
> violates the usual return value contract, which could be viewed as a bug.
> 
> Please note that a later patch (
> https://www.spinics.net/lists/linux-input/msg63291.html) fixes some
> important error checks that were relying on the old behavior (and were
> unfortunately missed by me).

As that patch doesn't seem to be in Linus's tree yet, we should postpone
taking this one in the stable tree right now, correct?

thanks,

greg k-h
