Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E04C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0812B2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 09:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="sfMz+uj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfHPJ6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 05:58:51 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36866 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfHPJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 05:58:51 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BE8AD2AF;
        Fri, 16 Aug 2019 11:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1565949530;
        bh=MdSDWBvW2MRlClWqWR9NNzBT2rTDlU0t5ijPFdChgoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sfMz+uj7gqeE3hmQ0hFrUHz3X6evmaWEf4NBMKEvpkmkIi2hDxJAoJ4U6F/VLOkOM
         wlj19XR3xjKA3jdsMJisgBh+6QY8EdFd6X+3GK5d/T/5Ddqn5s+raXzisFg19ZGxot
         Zs1yz3cRbdLJK3LzTq+3Dv3bfYF2s44q8hQA7En4=
Date:   Fri, 16 Aug 2019 12:58:45 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Nathaniel Russell <naterussell83@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>
Subject: Re: Linux Kernel 5.2.8 (uvc or i915? <<<)
Message-ID: <20190816095845.GC5020@pendragon.ideasonboard.com>
References: <CAONH+Jm-O6=DQ+K2n5pNTNMg2Sq1KcVNFLuweVh6W82OPEFJoQ@mail.gmail.com>
 <abcae5c9-b3dc-7403-d628-5d7543d19702@infradead.org>
 <CAONH+JnZpbpdiwdajP7ke7X7wQGU7m4YoyZRDbLHKmRufkD6mQ@mail.gmail.com>
 <5d637638-12d1-6c39-8f76-824a0e875feb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d637638-12d1-6c39-8f76-824a0e875feb@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Thu, Aug 15, 2019 at 08:10:03PM -0700, Randy Dunlap wrote:
> [adding mailing lists etc. with Nathaniel's test info]
> 
> On 8/15/19 7:21 PM, Nathaniel Russell wrote:
> > Well i surpressed the uvcvideo driver and you are right Randy it
> > definitely is not the uvcvideo driver. There is something going on in
> > the i915 driver.
> > 
> > On 8/15/19, Randy Dunlap <rdunlap@infradead.org> wrote:
> >> On 8/15/19 6:15 PM, Nathaniel Russell wrote:
> >>> I would really like help with the kernel error with my uvcvideo driver.
> >>
> >> Hi again.
> >>
> >> What makes you think that the problem is related to the uvcvideo driver?
> >> Does some previous kernel version work correctly?  If so, what version(s)?
> >>
> >>
> >> Does this warning message only happen when the uvcvideo driver is being
> >> loaded?
> >> Can you suppress loading of the uvcvideo driver to find out?
> >>
> >> Most of the problems/errors/warnings that I see are related to the i915
> >> driver:
> >>
> >> [   13.032341] timed out waiting for port C ready: got 0x20, expected 0xe0
> >> [   13.032872] WARNING: CPU: 1 PID: 239 at
> >> drivers/gpu/drm/i915/intel_display.c:1597 vlv_wait_port_ready+0x99/0xe0
> >> [i915]
> >> [   13.033632] RIP: 0010:vlv_wait_port_ready+0x99/0xe0 [i915]
> >>
> >> although there are a few uvcvideo warnings:
> >> [   13.039305] uvcvideo 1-5:1.0: Entity type for entity Extension 4 was not
> >> initialized!
> >> [   13.039318] uvcvideo 1-5:1.0: Entity type for entity Extension 3 was not
> >> initialized!
> >> [   13.039330] uvcvideo 1-5:1.0: Entity type for entity Processing 2 was not
> >> initialized!
> >> [   13.039339] uvcvideo 1-5:1.0: Entity type for entity Camera 1 was not
> >> initialized!
> >>
> >> Laurent, do you see any uvc issues here?  Any ideas/suggestions?

No, uvcvideo seems completely reunlated.

> >> @intel-gfx:  any ideas about what is going on here with the i915 driver?
> >>
> >> Original message to lkml:
> >> https://lore.kernel.org/lkml/CAONH+Jm-O6=DQ+K2n5pNTNMg2Sq1KcVNFLuweVh6W82OPEFJoQ@mail.gmail.com/T/#u
> >>
> >> Previous message for 5.1.21 kernel:
> >> https://lore.kernel.org/lkml/CAONH+JkTFujY9vEyNNuem+9rJ2qBKkf-PbKk9=DBSVEp6kW=yw@mail.gmail.com/

-- 
Regards,

Laurent Pinchart
