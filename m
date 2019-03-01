Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84860C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4600820850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551450281;
	bh=iralU0eBxL7L+mvQ4RE6z9p0eNqSQV8RFb4CBd4vlJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TYRZfMRt8C5Whj4yXvCnl4YImDILK89ktdeyfnW7gFX3E1uz1UM7/WikfwY89GZj5
	 T131PDLrDJYG7N/6346qGuIgQNe4XQVS9EFgM3haFEqDW/rl6um0m1jnFw/VHknTgJ
	 iLnpmJ//pS6MjJH9rfK/rClf52pcA6ekCeSgq8uI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbfCAOYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:24:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387536AbfCAOYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:24:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 207482084F;
        Fri,  1 Mar 2019 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551450278;
        bh=iralU0eBxL7L+mvQ4RE6z9p0eNqSQV8RFb4CBd4vlJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRwuh2miFv6poQHWlj+N3a9pxVcrrS9ZHcNFw8zTBBTaLms+6mSzoR78cSUxOVBBD
         EzMAC/gjN3kqwlNKaAx4NuX8/gAQkuU+ol1+qD1iUgLptyQWp/YEgEKBQ3idnyz++T
         0PiP9MDN+UYuk+uP1VonH7Y7d47XsHwmJPVL6n34=
Date:   Fri, 1 Mar 2019 15:24:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sven Van Asbroeck <thesven73@gmail.com>, svendev@arcx.com,
        robh+dt@kernel.org, linus.walleij@linaro.org, lee.jones@linaro.org,
        mark.rutland@arm.com, treding@nvidia.com, david@lechnology.com,
        noralf@tronnes.org, johan@kernel.org, monstr@monstr.eu,
        michal.vokac@ysoft.com, arnd@arndb.de, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/6] fieldbus_dev: add Fieldbus Device subsystem.
Message-ID: <20190301142435.GA12361@kroah.com>
References: <20190122152109.30488-1-TheSven73@googlemail.com>
 <20190122152109.30488-2-TheSven73@googlemail.com>
 <20190122165658.GH26416@windriver.com>
 <2f4406b5-9970-211e-beef-a8b6ad60b99e@suse.de>
 <20190122185246.GA922@kroah.com>
 <20190301133456.GA7456@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301133456.GA7456@amd>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 02:34:56PM +0100, Pavel Machek wrote:
> 
> > > > 
> > > >> +
> > > >> +MODULE_AUTHOR("Sven Van Asbroeck <TheSven73@googlemail.com>");
> > > >> +MODULE_AUTHOR("Jonathan Stiles <jonathans@arcx.com>");
> > > >> +MODULE_DESCRIPTION("Fieldbus Device Driver Core");
> > > >> +MODULE_LICENSE("GPL v2");
> > > 
> > > Sven, as this code appears to be all by ArcX people, any chance you can
> > > make it just GPL (SPDX GPL-2.0-or-later)? Only reason to have it v2-only
> > 
> > SPDX "GPL-2.0+" please.
> > 
> > > would be if this code was derived from v2-only code that can't be
> > > relicensed anymore.
> > 
> > Are you _sure_ you want v2+?  I ask as I am forced to :)
> 
> And I find it pretty nasty. You are trying to push people away from
> GPL V2+, which is not cool.

People do not usually realize what they are agreeing to when they say
"or later" based on the discussions I always end up having.

Do you really trust that GPL v9 is going to look anything like v2?  :)

Anyway, no big deal, just asking as it is good to be sure, especially
when odds are, code for this was copied from non + code.

thanks,

greg k-h
