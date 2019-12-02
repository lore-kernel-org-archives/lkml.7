Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1342C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954F52071E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575310509;
	bh=jPiVcuaAidjifO58kG4+hCHpnuzdzZqrqEC+SolpAOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WfG9CHQMwnn0W1vA4vbW1KqdO2Gc0cC01hNxHHAEkdHkd2rKtVgDP6sOx+wQSI2Pg
	 YBIyzrrN+5Z7HkR08ZrBuBJng2kYOO2VE+mEqpX8sBVZvopqcuH+3COwBHfJT4gi53
	 jkXDd0BUeAyOgrsYRqaVyAM3GppDRRwO86UK2LCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfLBSPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:15:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbfLBSPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:15:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 074A420718;
        Mon,  2 Dec 2019 18:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575310507;
        bh=jPiVcuaAidjifO58kG4+hCHpnuzdzZqrqEC+SolpAOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P6bhaZwzCNYqu2wRmSwVWP1lQj0PvgQZV5Kj5fZcXqVbd+NH3/s4kDXSgJK/FgUHi
         2Q61RLf0BQrpim/TpxKnTJUuz3Y80S4xiDyJ5+mYNPHw3LKysj92FXM7TI2d/NdTwS
         eKuSaewyR5BgM1svvcAdcYqzBeYkaIKP26jHMjHk=
Date:   Mon, 2 Dec 2019 19:15:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devel@driverdev.osuosl.org, Julia Lawall <julia.lawall@lip6.fr>,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [PATCH] staging/octeon: Mark Ethernet driver as BROKEN
Message-ID: <20191202181505.GA732872@kroah.com>
References: <20191202141836.9363-1-linux@roeck-us.net>
 <20191202165231.GA728202@kroah.com>
 <20191202173620.GA29323@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202173620.GA29323@roeck-us.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 09:36:20AM -0800, Guenter Roeck wrote:
> On Mon, Dec 02, 2019 at 05:52:31PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Dec 02, 2019 at 06:18:36AM -0800, Guenter Roeck wrote:
> > > The code doesn't compile due to incompatible pointer errors such as
> > > 
> > > drivers/staging/octeon/ethernet-tx.c:649:50: error:
> > > 	passing argument 1 of 'cvmx_wqe_get_grp' from incompatible pointer type
> > > 
> > > This is due to mixing, for example, cvmx_wqe_t with 'struct cvmx_wqe'.
> > > 
> > > Unfortunately, one can not just revert the primary offending commit, as doing so
> > > results in secondary errors. This is made worse by the fact that the "removed"
> > > typedefs still exist and are used widely outside the staging directory,
> > > making the entire set of "remove typedef" changes pointless and wrong.
> > 
> > Ugh, sorry about that.
> > 
> > > Reflect reality and mark the driver as BROKEN.
> > 
> > Should I just delete this thing?  No one seems to be using it and there
> > is no move to get it out of staging at all.
> > 
> > Will anyone actually miss it?  It can always come back of someone
> > does...
> > 
> 
> All it does is causing trouble and misguided attempts to clean it up.
> If anything, the whole thing goes into the wrong direction (declare a
> complete set of dummy functions just to be able to build the driver
> with COMPILE_TEST ? Seriously ?).
> 
> I second the motion to drop it. This has been in staging for 10 years.
> Don't we have some kind of time limit for code in staging ? If not,
> should we ? If anyone really needs it, that person or group should
> really invest the time to get it out of staging for good.

10 years?  Ugh, yes, it's time to drop the thing, I'll do so after -rc1
is out.

thanks,

greg k-h
