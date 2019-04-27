Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CBDC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9FD2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556348447;
	bh=vQajaea5nhD91IY5jg21FLw1xRj5+sMwfhWpfk73baQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ndMZL41Ios1SR2CnqMjl9CVfSdIw18J8tcKRtQKWWaUHlQiBpmcBiYyjeM+ew3t9Y
	 B9G0fMQ7Wz43Fz5cwtBHGYD6Vo71ZGE1r4qszUVLix9LrUVpT0C7/yqXhDBk99VdXh
	 uxEa2MrCPe2BVjf4EzTXcgKiN4aX/g/bwSlu8BKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfD0HAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 03:00:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfD0HAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 03:00:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB4892077B;
        Sat, 27 Apr 2019 07:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556348445;
        bh=vQajaea5nhD91IY5jg21FLw1xRj5+sMwfhWpfk73baQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KSoVVUT2szwR/MhdoPdWsJQwgPF1ycZ+gWjS+J4N+f6nVkM7fK3b/WNajFcguI7PG
         ScSXgj9zw8hWkKhGh2JVAEGLeyIqM0LnW4aWyvayu/nFP3Nnz9MFJFigVKhHrEcIkk
         rmzztQyEjsbx0w7ZyZJJiD7iUP14Zr/DqbB7nrhY=
Date:   Sat, 27 Apr 2019 09:00:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Richard Leitner <richard.leitner@skidata.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: usb251xb: Lock i2c-bus segment the hub resides
Message-ID: <20190427070042.GD28250@kroah.com>
References: <20190424144914.10580-1-fancer.lancer@gmail.com>
 <20190426104650.30240-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426104650.30240-1-fancer.lancer@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 01:46:50PM +0300, Serge Semin wrote:
> SMBus slave configuration is activated by CFG_SEL[1:0]=0x1 pins
> state. This is the mode the hub is supposed to be to let this driver
> work correctly. But a race condition might happen right after reset
> is cleared due to CFG_SEL[0] pin being multiplexed with SMBus SCL
> function. In case if the reset pin is handled by a i2c GPIO expander,
> which is also placed at the same i2c-bus segment as the usb251x
> SMB-interface connected to, then the hub reset clearance might
> cause the CFG_SEL[0] being latched in unpredictable state. So
> sometimes the hub configuration mode might be 0x1 (as expected),
> but sometimes being 0x0, which doesn't imply to have the hub SMBus-slave
> interface activated and consequently causes this driver failure.
> 
> In order to fix the problem we must make sure the GPIO-reset chip doesn't
> reside the same i2c-bus segment as the SMBus-interface of the hub. If
> it doesn't, we can safely block the segment for the time the reset is
> cleared to prevent anyone generating a traffic at the i2c-bus SCL lane
> connected to the CFG_SEL[0] pin. But if it does, nothing we can do, so
> just return an error. If we locked the i2c-bus segment and tried to
> communicate with the GPIO-expander, it would cause a deadlock. If we didn't
> lock the i2c-bus segment, it would randomly cause the CFG_SEL[0] bit flip.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I signed off on this?  Where?  When?

never add a s-o-b line that you did not create, that implies a legal
agreement.

greg k-h
