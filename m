Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BFCC28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0287520B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559129558;
	bh=2TbrFHiXFkXm4q/NQZERH53V5I9m628QDOWG/YoadTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=umePCj/dFJPPG4np8NY4Y0NTTpnCXlBIZG/hNtDUPdTVjSZ8GkPhA5p1MpZnzPnWX
	 +FdRJbX+ylmKcGOovj3/3insjFTluDmYz+s+x6ubh7ROYx1Ith0B6cAeKDw49cCXNJ
	 H6rWRHwcvBo1kcgRSrkaHE46C58CQBqCsXoJQDj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfE2Lch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 07:32:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfE2Lch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 07:32:37 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66FBF2054F;
        Wed, 29 May 2019 11:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559129556;
        bh=2TbrFHiXFkXm4q/NQZERH53V5I9m628QDOWG/YoadTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wDsggyExHH91I4WaB+WKeKCLf5m/lo5oxuuaxY0/dxuHrD0vBtrhBdfrjPV2MAj9k
         0EcpGe5LqTI38DqLObyPO5+0V3ALCGhSdCF3HoKH29X7QHrRqy8YyvdwVCGJH8Jhyl
         DykGjOzC173qLQ4EZEbZnMMsizC2OcnAWdvy7fxA=
Date:   Wed, 29 May 2019 04:32:36 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "hch@lst.de" <hch@lst.de>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "noring@nocrew.org" <noring@nocrew.org>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>
Subject: Re: [PATCH v7 2/5] USB: use genalloc for USB HCs with local memory
Message-ID: <20190529113236.GA11952@kroah.com>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
 <20190529102843.13174-3-laurentiu.tudor@nxp.com>
 <20190529103838.GC7383@kroah.com>
 <34a83e74-4c85-cf9f-54c3-b69b0dcb628e@nxp.com>
 <20190529112334.GA11368@kroah.com>
 <20190529112515.GA8982@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529112515.GA8982@lst.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 01:25:15PM +0200, hch@lst.de wrote:
> On Wed, May 29, 2019 at 04:23:34AM -0700, Greg KH wrote:
> > As long as GENERIC_ALLOCATOR works on all arches, yes, that's fine, but
> > please verify that this is the case.
> 
> It works everywhere.  The issue here is just that it get pulled in
> by default on most architetures, but not on all.

Ah, ok, that's fine then, no objection from me, let me go review the
patches again...

thanks,

greg k-h
