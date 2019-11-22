Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E46FC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA5820708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574422743;
	bh=S8YSy/ai1WXllwXqyBcZhi6USknPsNtdTGIyQ9A5nUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E2fWiod8tDFuMaABPj8PZtQy24CkVS8pw0tgMa6US13EDjBUhIKSsR6mYC3ZZSpjA
	 HsRBnEHD5MMJjHGwUOiTCYD2Y/d/1mkZJf+AjdfW6gDTNnSb7m/KVaLfzR4lHJJVWe
	 ITlmypxTcDIwTGlcB8De0wcV5ZlbzXKFlBDy4RMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfKVLjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:39:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfKVLjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:39:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25C5B20704;
        Fri, 22 Nov 2019 11:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574422741;
        bh=S8YSy/ai1WXllwXqyBcZhi6USknPsNtdTGIyQ9A5nUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WPesMX3vTs6GUUlwSXkYKH5F2cm7j6BMSdoGnVsX62f+mwj43TcUVRS2x/T8cAcEj
         saqXOSJQ5ArTLBA+9yefTmEADffF7BiSTT5PQ2dzeyye0y7atF+2G6ydIiqaFTw3yY
         Zncgo9zyJ8I31FDufCab5ePFQ0zIhFmiznwaIMlU=
Date:   Fri, 22 Nov 2019 12:38:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] {tty: serial, nand: onenand}: remove variable 'ufstat'
 set but not used
Message-ID: <20191122113859.GA2026910@kroah.com>
References: <1574421159-113624-1-git-send-email-chenwandun@huawei.com>
 <20191122111410.GA2024666@kroah.com>
 <62b2cfc1-416c-f7c7-3029-6dd7ad12ea46@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62b2cfc1-416c-f7c7-3029-6dd7ad12ea46@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 07:33:47PM +0800, Chen Wandun wrote:
> 
> 
> On 2019/11/22 19:14, Greg KH wrote:
> > On Fri, Nov 22, 2019 at 07:12:39PM +0800, Chen Wandun wrote:
> > > Fixes gcc '-Wunused-but-set-variable' warning:
> > > 
> > > drivers/tty/serial/samsung_tty.c: In function s3c24xx_serial_rx_chars_dma:
> > > drivers/tty/serial/samsung_tty.c:549:24: warning: variable ufstat set but not used [-Wunused-but-set-variable]
> > > 
> > > Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> > 
> > Your subject line is really odd, can you please fix that up and resend?
> I check the git log of drivers/tty/serial/samsung_tty.c,
> it seem like the subject line should be:
> {tty: serial, nand: onenand}: samsung: remove variable 'ufstat' set but not used
> 
> Is that OK?

No.  What does this patch have to do with nand?

That was from a previous patch that modified two drivers at once.  You
are not touching the nand driver.

thanks,

greg k-h
