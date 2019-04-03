Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2389C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C4C2147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554278814;
	bh=eItNLUEv0ksan+vGlykhABLTnhJMPmS7E+NwUiSzAkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fe5XJFsbc1R2KL+W/nB9bRiJrKm/gCJhvPCqMlsu8c33PNxcOAR/ZGdbT7QayRPWM
	 +GVNuJ4BpqVX8w0Q99s/qRe3NOeqxMix3iOxBqLyGu1j1R8i12o6uoRREnhbOm2bL0
	 qXLx5V4JucuOSw+Ah5Y7lAUONk6XLrRV3CP/biqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfDCIGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfDCIGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:06:53 -0400
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADA1121473;
        Wed,  3 Apr 2019 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554278812;
        bh=eItNLUEv0ksan+vGlykhABLTnhJMPmS7E+NwUiSzAkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wTDXpDQTGgJ3ZhBEPnE0wK+wvUOshBtxAJEH6QiX890ugSRmdNbh3rMBNGD6bYipj
         noecYeuXJB/aYSetkS0O0Zw+9lWlx6q7kFwSp5JABBGg+HvVVQuJn0jAq6aTIXW7S7
         ZEydw4G26bQWXYqLD3BZsLQDVRkL6ocMM/+bxWpU=
Date:   Wed, 3 Apr 2019 10:06:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@st.com>
Subject: Re: [PATCH] Revert "tty: fix NULL pointer issue when tty_port ops is
 not set"
Message-ID: <20190403080649.GA12019@kroah.com>
References: <20190403074053.5961-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403074053.5961-1-johan@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 09:40:53AM +0200, Johan Hovold wrote:
> This reverts commit f4e68d58cf2b20a581759bbc7228052534652673.
> 
> TTY drivers using the tty-port abstraction all provide a pointer to a
> set of port operations, which specifically cannot be NULL (or we'd find
> out at first attempt to open a port).
> 
> Revert the recent commit which added unnecessary NULL-checks and whose
> commit message indicated that it was fixing a real problem, which it did
> not.
> 
> Note that even the two tty drivers for virtual devices currently
> providing an empty set of operations probably should be implementing at
> least some of the callbacks.

This was a "future fix" for a driver that is under review for 5.2, see
the email thread:
	Subject: [PATCH 0/2] TTY: add rpmsg tty driver

It didn't want/need the port pointer, if that is incorrect, that's fine,
I'll gladly revert this, but as-is this patch isn't hurting anything,
right?

thanks,

greg k-h
