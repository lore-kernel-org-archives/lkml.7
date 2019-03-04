Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CD6C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCF82082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551689813;
	bh=8mBBQ/2gmb9gLqS8Y88FGtHKy9SyU79H2nRW5jzEHHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eQqNf0I4grXrNkibj5mPaeOf0ui9e367CPddlTnGtO5mXJ7zG6umPw849qynhO0j9
	 demfJyjsZxua5asPZJdkK323j1ZPHxC2Q9scMmLOBL4z79jXh5CJYtj61a2Bqi09QK
	 8m6xVqmndL+Hkk9nva7SNGn06EaRjNb+7kZhxgDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfCDI4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:56:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:57786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfCDI4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:56:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEEAE20823;
        Mon,  4 Mar 2019 08:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551689811;
        bh=8mBBQ/2gmb9gLqS8Y88FGtHKy9SyU79H2nRW5jzEHHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rfc2ZDJVtso50gzn8P0QsFJeX8OhKLbDuxArFB9pSuS7IawrNAYjNq9GjRdJeMrrJ
         9D3dG7MvrgitqFuiGzxqoVDJ2ptPiS/cZ5jb9OkV0BZPcLFKhcFE7fKrSpKF72pMfq
         /sV2A9mwO2zClVlsRO+8rTvph6M+dEBZK7D/TAp8=
Date:   Mon, 4 Mar 2019 09:53:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "He, Bo" <bo.he@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Wang, Yu Y" <yu.y.wang@intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.20 12/88] usb: dwc3: gadget: synchronize_irq dwc irq in
 suspend
Message-ID: <20190304085350.GA18354@kroah.com>
References: <20190304081630.610632175@linuxfoundation.org>
 <20190304081631.046461963@linuxfoundation.org>
 <CD6925E8781EFD4D8E11882D20FC406D52A5C632@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D52A5C632@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 08:46:30AM +0000, He, Bo wrote:
> Hi, Greg:
> 	Marek Szyprowski report the patch has issue that calling synchronize_irq() under dwc->lock spinlock, he has upload the below patch for the issue:
> 
> dwc3_gadget_suspend() is called under dwc->lock spinlock. In such context calling synchronize_irq() is not allowed. Move the problematic call out of the protected block to fix the following kernel BUG during system

<snip>

Is this patch in Linus's tree yet?  If so, what is the git commit id?

If not, is this also an issue in 5.0?

thanks,

greg k-h
