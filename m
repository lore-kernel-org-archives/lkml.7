Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA9C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A50B21743
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563950882;
	bh=51p6sj9EACBV/HaJVhSnzJqh0RByt7lvzLHqxRSkm1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NCuSi6fs6HwW4iv0LGHCUd16uyEwtlAnXTXBrCNb+VoQI51UDmGvG76vUFqYE1jtK
	 UD+4JMGvBK341c5uaLGFfhxHHetq/f1XL0jmxZMqnprttlASn+MAuC4shmWB+mPz53
	 rh//eUOjZLOQGVJ+0ErgwPLjGcLTjgPdfzp/nnt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfGXGsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 02:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfGXGr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:47:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D65A821743;
        Wed, 24 Jul 2019 06:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563950876;
        bh=51p6sj9EACBV/HaJVhSnzJqh0RByt7lvzLHqxRSkm1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zxrsT7E6iAz0Hi5ft7Px1t+JEbuXOMqq791LZnmBbp0XRhH6ht6pxbMrjQ8uTbGbj
         d6AFFhuiZqzKjUZ3AOpd2WcTo+F9dssYYFJp2EMpc1PuSCYZ8ojBHrg32+bvPEkNPq
         hIx2Yr5NrylsU3kqc+jpA61CiP/K7eYR+P8uK4Mk=
Date:   Wed, 24 Jul 2019 08:47:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 1/5] can: m_can: Create a m_can platform framework
Message-ID: <20190724064754.GC22447@kroah.com>
References: <20190509161109.10499-1-dmurphy@ti.com>
 <dbb7bdef-820d-5dcc-d7b5-a82bc1b076fb@ti.com>
 <a8e3f2d3-18c3-3bdb-1318-8964afc7e032@ti.com>
 <93530d94-ec65-de82-448e-f2460dd39fb9@ti.com>
 <0f6c41c8-0071-ed3a-9e65-caf02a0fbefe@ti.com>
 <6fa79302-ad32-7f43-f9d5-af70aa789284@ti.com>
 <f236a88a-485c-9002-1e4a-9a5ad0e1c81f@ti.com>
 <437b6371-8488-a0ff-fa68-d1fb5a81bb8b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <437b6371-8488-a0ff-fa68-d1fb5a81bb8b@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 10:14:14AM -0500, Dan Murphy wrote:
> Hello
> 
> On 7/10/19 7:08 AM, Dan Murphy wrote:
> > Hello
> > 
> > On 6/17/19 10:09 AM, Dan Murphy wrote:
> > > Marc
> > > 
> > > On 6/10/19 11:35 AM, Dan Murphy wrote:
> > > > Bump
> > > > 
> > > > On 6/6/19 8:16 AM, Dan Murphy wrote:
> > > > > Marc
> > > > > 
> > > > > Bump
> > > > > 
> > > > > On 5/31/19 6:51 AM, Dan Murphy wrote:
> > > > > > Marc
> > > > > > 
> > > > > > On 5/15/19 3:54 PM, Dan Murphy wrote:
> > > > > > > Marc
> > > > > > > 
> > > > > > > On 5/9/19 11:11 AM, Dan Murphy wrote:
> > > > > > > > Create a m_can platform framework that peripheral
> > > > > > > > devices can register to and use common code and register sets.
> > > > > > > > The peripheral devices may provide read/write and configuration
> > > > > > > > support of the IP.
> > > > > > > > 
> > > > > > > > Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> > > > > > > > Signed-off-by: Dan Murphy <dmurphy@ti.com>
> > > > > > > > ---
> > > > > > > > 
> > > > > > > > v12 - Update the m_can_read/write functions to
> > > > > > > > create a backtrace if the callback
> > > > > > > > pointer is NULL. - https://lore.kernel.org/patchwork/patch/1052302/
> > > > > > > > 
> > > > > > > Is this able to be merged now?
> > > > > > 
> > > > > > ping
> > > 
> > > Wondering if there is anything else we need to do?
> > > 
> > > The part has officially shipped and we had hoped to have driver
> > > support in Linux as part of the announcement.
> > > 
> > Is this being sent in a PR for 5.3?
> > 
> > Dan
> > 
> Adding Greg to this thread as I have no idea what is going on with this. 

Why me?  What am I supposed to do here?  I see no patches at all to do
anything with :(

thanks,

greg "not a miracle worker" k-h
