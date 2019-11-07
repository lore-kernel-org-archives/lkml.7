Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B3FC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291AE21D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573116053;
	bh=5UXATmHfJ4Sv3v2y4iqCmaHYxknDg4YaP8YhAQf2jHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cwU8eXi9jM/4wUlDuI/35czmtLiz+SANtnFs41ZDFg9fsH71JdpeOwAWybZ+oqBww
	 qFr2FbHO0CFA4m2FFae3YPlaVIoOOI4a1QWmq36roLbOKCw6C8DYN/i1lQQZSkS4M6
	 w14dsuqXdhqYesC2zcs69jlVls0yKwcnKjEMCaGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbfKGIkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:40:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:44254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbfKGIkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:40:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA38321D79;
        Thu,  7 Nov 2019 08:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573116050;
        bh=5UXATmHfJ4Sv3v2y4iqCmaHYxknDg4YaP8YhAQf2jHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fOthM6XmtGHNJeSt/0HirzaKkvhp+sVzK0g8L6zA5YgJT9lFDQXhvVcl5HPVstqb/
         XPNfXaybhhUQQka2do1k5GATqsjRJ8mNBaew0ZJ/Xs6Kp2uVE9CA40KHH2Mp8i4vfG
         ArYmC9P4vu1X4xy1rPuUj+F8+LqX4PGJ5n1ZahV4=
Date:   Thu, 7 Nov 2019 09:40:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] of_devlink: Minor fixes and new properties
Message-ID: <20191107084047.GB1203521@kroah.com>
References: <20191105065000.50407-1-saravanak@google.com>
 <CAGETcx-X4OTrGfBkP6CtC6=GV=KA147VO6jJL+o6hkC1iCkeeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-X4OTrGfBkP6CtC6=GV=KA147VO6jJL+o6hkC1iCkeeA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 09:53:40PM -0800, Saravana Kannan wrote:
> On Mon, Nov 4, 2019 at 10:50 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Sending again since the cover letter missed everyone/mailing lists.
> >
> > First two patches are just code clean up and logging with no functional
> > difference. The 3rd patch adds support for the following DT properties:
> > iommus, mboxes and io-channels.
> >
> > These patches are on top of driver-core-next since that's where the rest
> > of the of_devlink patches are.
> >
> > Greg and Rob,
> > On a side note, I was wondering if I should rename the of_devlink kernel
> > command line to fw_devlink and move it out of drivers/of/property.c and
> > into drivers/base/core.c. This feature isn't really limited to
> > devicetree, so I don't see a need to have devicetree specific kernel
> > command line option.  Please let me know if that sounds okay to you.
> 
> Hi Rob,
> 
> Thanks for the reviews. Can you let me know what you think of this too?
> 
> Rob/Greg,
> 
> If I rename of_devlink to fw_devlink, I might also make it a setting
> like fw_devlink=none/permissive/enforce
> - none would be same as disabled completely.
> - permissive would use SYNC_STATE_ONLY for all device links created by
> firmware. So it won't block any probes even with cycles but
> sync_state() will still work correctly.
> - enforce would be the current "of_devlinkg=1" behavior where direct
> dependencies would block probing and the child dependencies would use
> SYNC_STATE_ONLY.

Renaming makes sense to me, and all of the above is fine as well.

thanks,

greg k-h
