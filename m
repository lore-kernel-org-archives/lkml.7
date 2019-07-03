Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40188C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E13218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562171953;
	bh=SE+Je5EFsMdGD+TiwNqygLRpk2ISs/GklnKAT/Yq7NI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i9/X5rwdegp4dBpVHynHtD3KQSVlWDQ+YB0eZm2t9CSQkuu++Xpe0x1sl6yUiMeWz
	 W8QYWF9X4lFZUVNjFiYIDacAL8j3nLkls3nVJw4TOVr1neRNOZDAYfyxoM6ld5mD+0
	 ZUL8JOT4gu6J1IbDDNDWNOrRKn6Bso6iG1P4EFUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfGCQjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfGCQjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:39:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95C772189E;
        Wed,  3 Jul 2019 16:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562171951;
        bh=SE+Je5EFsMdGD+TiwNqygLRpk2ISs/GklnKAT/Yq7NI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bE/PhhxKetWxBnBk54zBTk1TxofIZkp3rz4c1cqtxi5BOtKVqDiRiPLRkbWvxIeDE
         CvmZNTpecsETwCJWZ0mDgpPnayMUIrjZ95qst79wOUmLsTlbIQtv0l0kc9TJSprYWT
         6WY+1OMHUsfKrI81jp6FBnIWnyKis9Leala/5hxU=
Date:   Wed, 3 Jul 2019 18:39:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikolaus Voss <nv@vosn.de>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers/usb/typec/tps6598x.c: fix portinfo width
Message-ID: <20190703163908.GB17160@kroah.com>
References: <20190628083417.GA21701@kuha.fi.intel.com>
 <f8daf204d49fff00db33e2b417a20afcc58ad56e.1561712364.git.nikolaus.voss@loewensteinmedical.de>
 <20190628095843.GB21701@kuha.fi.intel.com>
 <alpine.DEB.2.20.1906281208190.21573@fox.voss.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1906281208190.21573@fox.voss.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 12:10:41PM +0200, Nikolaus Voss wrote:
> On Fri, 28 Jun 2019, Heikki Krogerus wrote:
> > On Fri, Jun 28, 2019 at 11:01:08AM +0200, Nikolaus Voss wrote:
> > > Portinfo bit field is 3 bits wide, not 2 bits. This led to
> > > a wrong driver configuration for some tps6598x configurations.
> > > 
> > > Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
> > > Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> > 
> > Shouldn't this be applied to the stable trees as well?
> 
> Oh, yes, forgot that again... Greg, could you...?

It's not like I have anything else to do... :)

