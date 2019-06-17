Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58812C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2762B208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560803413;
	bh=wWT1OPFjU06mBl7O6HfsS8gMclhi0OwwNHVpelr67DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ejcjzdSzbcNYdsjUHrDkMgqLMlDeF/ZEAww/sGFyXidOU3eWAhtQgbRpyJovBdFde
	 E6jJeQ3gZRaAdGCAW6DjjodcsPQB0Ns+0FW7YoQvpMxHLf3wWYnmd4PvwwE5nbXYpL
	 SmbBmLcbdpLW3cYap3GZWdhkoXhFKfN7Oe36R9tI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfFQUaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfFQUaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:30:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ACB120861;
        Mon, 17 Jun 2019 20:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560803410;
        bh=wWT1OPFjU06mBl7O6HfsS8gMclhi0OwwNHVpelr67DA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pWP4RRuQm+5pI7ktuNnOd5aoMBBARWwR6QdtoEEx+lbJCbjl+EQdFWuDuG5yCh/m4
         jg2Z5WpeNCpGHZ0RhWYIwOqctmNTCl2IdQYx1/FBLYHaR9+jYQ9IinDHET1gXIY/NG
         pp72N3eN2spRV0s4bTZn/Fr7I/1iV4/gbDwZ1h1k=
Date:   Mon, 17 Jun 2019 22:30:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Brown <broonie@kernel.org>, lee.jones@linaro.org,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH 3/4] regulator: Add regulator driver for ATC260x PMICs
Message-ID: <20190617203008.GB8381@kroah.com>
References: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
 <20190617155011.15376-4-manivannan.sadhasivam@linaro.org>
 <20190617163015.GD5316@sirena.org.uk>
 <20190617163413.GA16152@Mani-XPS-13-9360>
 <a38d26d1-213c-31ef-9cc7-1d4bdda4ceab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a38d26d1-213c-31ef-9cc7-1d4bdda4ceab@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 06:38:53PM +0200, Andreas Färber wrote:
> Hi,
> 
> Am 17.06.19 um 18:34 schrieb Manivannan Sadhasivam:
> > On Mon, Jun 17, 2019 at 05:30:15PM +0100, Mark Brown wrote:
> >> On Mon, Jun 17, 2019 at 09:20:10PM +0530, Manivannan Sadhasivam wrote:
> >>
> >>> +++ b/drivers/regulator/atc260x-regulator.c
> >>> @@ -0,0 +1,389 @@
> >>> +// SPDX-License-Identifier: GPL-2.0+
> >>> +/*
> >>> + * Regulator driver for ATC260x PMICs
> >>
> >> Please make the entire comment a C++ one so this looks more intentional.
> 
> No, this is intentional and the official style requested by GregKH.

Mark likes them all to be // at the top of the file.

I only required that the SPDX line be that way.

Mark can ask for more if he wants to :)

thanks,

greg k-h
