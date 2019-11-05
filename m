Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1608C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838CC20656
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572967933;
	bh=8QBM5P0flv1we6e9LYSanSHn4Dn5kSuOJJrqooSAN0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d8ifB92FwI6Y56WYiQuZWtVG3sbq1Ui6rZlyXmKcChIBDTo6K1iy8abTYmwAem89A
	 4JUw1FJv+z7Wl/XQKKy4+Ww8Su2raeE5GlA/wxFJOSp/lGGRFE3f/hRTsFt/fFpaSf
	 UDQk0vB5LWpUdaAPFvINGSm+z3F7b7J5m1l3zFCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389721AbfKEPcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:32:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731074AbfKEPcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:32:12 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6229D20650;
        Tue,  5 Nov 2019 15:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572967931;
        bh=8QBM5P0flv1we6e9LYSanSHn4Dn5kSuOJJrqooSAN0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AGYV1hB7hST6Cda6NKrHlv9hJR7MVgUVC0b75GuwgJB/Lu8rEm09BLBQ5iqCQzSZ+
         vt23pTH3xEGPItrW1JqUuBckayflOZEairIJ4QOKLVkJItGpfJVflmy452QqTYrZ4s
         bIqsq85i5D4L1CAKvzqpfEDF6omyCDIcALRh/3kI=
Date:   Tue, 5 Nov 2019 16:32:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com
Subject: Re: [PATCH 00/12] staging: dpaa2-ethsw: add support for control
 interface traffic
Message-ID: <20191105153205.GA2617647@kroah.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
 <20191105132435.GA2616182@kroah.com>
 <20191105140256.GB7189@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105140256.GB7189@lunn.ch>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 03:02:56PM +0100, Andrew Lunn wrote:
> On Tue, Nov 05, 2019 at 02:24:35PM +0100, Greg KH wrote:
> > On Tue, Nov 05, 2019 at 02:34:23PM +0200, Ioana Ciornei wrote:
> > > This patch set adds support for Rx/Tx capabilities on switch port interfaces.
> > > Also, control traffic is redirected through ACLs to the CPU in order to
> > > enable proper STP protocol handling.
>  
> > I thought I asked for no new features until this code gets out of
> > staging?  Only then can you add new stuff.  Please work to make that
> > happen first.
> 
> Hi Greg
> 
> This is in response to my review of the code in staging. The current
> code is missing a core feature for an Ethernet switch driver, being
> able to send/receive frames from the host. At the moment it can only
> control the hardware for how it switches Ethernet frames coming
> into/going out of external ports.
> 
> One of the core ideas behind how linux handles Ethernet switches is
> that they are just a bunch of network interfaces. And currently, these
> network interfaces cannot send/receive. We would never move an
> Ethernet driver out of staging which cannot send/receive, so i don't
> see why we should move an Ethernet switch driver out of staging which
> also cannot send/receive.
> 
> Maybe this patchset could be minimised. The STP handling is just nice
> to have, and could wait until the driver has moved into the main tree.

Ok, if the netdev developers say that this is needed before it can move
out of staging, then that's fine, I didn't get that from this
submission, sorry.

greg k-h
