Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBE1C1747C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E445221882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cmLn01hJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389474AbfKEODA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:03:00 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:49802 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388428AbfKEODA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=myH3nUXs8MY5+0kwyDTaLgY2LdTUc8u0DBEGTyOkRck=; b=cmLn01hJB1tmlu8+9Dv8zd14YR
        xwgAptI6XaZx+qwB9VBO4q99qWgvMNGM+xZb/wEoamTNgm4c/i9/eUReJvHt6QRQMu+Asnz5RPNMn
        RjsVNScEmHqAlbFwYJi/t7bw2lqUZ0ojc3VpjYzQdmPtU3qNokx1X9qm7zBcsKnPgzAo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iRzQ8-0002AK-Ij; Tue, 05 Nov 2019 15:02:56 +0100
Date:   Tue, 5 Nov 2019 15:02:56 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com
Subject: Re: [PATCH 00/12] staging: dpaa2-ethsw: add support for control
 interface traffic
Message-ID: <20191105140256.GB7189@lunn.ch>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
 <20191105132435.GA2616182@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105132435.GA2616182@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 02:24:35PM +0100, Greg KH wrote:
> On Tue, Nov 05, 2019 at 02:34:23PM +0200, Ioana Ciornei wrote:
> > This patch set adds support for Rx/Tx capabilities on switch port interfaces.
> > Also, control traffic is redirected through ACLs to the CPU in order to
> > enable proper STP protocol handling.
 
> I thought I asked for no new features until this code gets out of
> staging?  Only then can you add new stuff.  Please work to make that
> happen first.

Hi Greg

This is in response to my review of the code in staging. The current
code is missing a core feature for an Ethernet switch driver, being
able to send/receive frames from the host. At the moment it can only
control the hardware for how it switches Ethernet frames coming
into/going out of external ports.

One of the core ideas behind how linux handles Ethernet switches is
that they are just a bunch of network interfaces. And currently, these
network interfaces cannot send/receive. We would never move an
Ethernet driver out of staging which cannot send/receive, so i don't
see why we should move an Ethernet switch driver out of staging which
also cannot send/receive.

Maybe this patchset could be minimised. The STP handling is just nice
to have, and could wait until the driver has moved into the main tree.

   Andrew
