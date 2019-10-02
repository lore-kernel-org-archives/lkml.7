Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6C9ECE58A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610FB222BE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570022375;
	bh=/IxKG4d+aif/Ftn3ORuLnKizUpdPRlx/1m7XTba4VkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FkCtOew1BZnlHLYxGl0DZkg9BRWCWechMFpIlGnW+v0W1ANK/GHsITkBmhal0wePq
	 izkpaXiZytJ+8XRmKjUWtvliqR7G1MHzgXbq+qEAsc9FLsaKhXDNnGhzxbIeUpuJKw
	 7gtJBPGYP1KyrAIqHI8mMP9bF4hG70yqFtacQi0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfJBNTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfJBNTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:19:34 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3222A21A4A;
        Wed,  2 Oct 2019 13:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570022373;
        bh=/IxKG4d+aif/Ftn3ORuLnKizUpdPRlx/1m7XTba4VkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7MpUKP/m450P3M/bMoO7Q+Ns/rYNWESKUhObRBWZg20UZHhH0pJKPDJSSVSBl4eQ
         tml7kFuvLEbvsXrRSb36FlirfaRf6GSmjUJT8i4q56lRKcbujEV55o1OKwF3D2Inba
         13baHIe7zO0ou1W07xLaN5kYlW5DK+bDThlxC3cY=
Date:   Wed, 2 Oct 2019 14:19:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        andreyknvl@google.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] media: uvc: Avoid cyclic entity chains due to malformed
 USB descriptors
Message-ID: <20191002131928.yp5r4tyvtvwvuoba@willie-the-truck>
References: <20191002112753.21630-1-will@kernel.org>
 <20191002130913.GA5262@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002130913.GA5262@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Wed, Oct 02, 2019 at 04:09:13PM +0300, Laurent Pinchart wrote:
> Thank you for the patch.

And thank you for the quick response.

> On Wed, Oct 02, 2019 at 12:27:53PM +0100, Will Deacon wrote:
> > I don't have a way to reproduce the original issue, so this change is
> > based purely on inspection. Considering I'm not familiar with USB nor
> > UVC, I may well have missed something!
> 
> I may also be missing something, I haven't touched this code for a long
> time :-)

Actually, that is pretty helpful because it will make backporting easier
if we get to that :)

> uvc_scan_chain_entity(), at the end of the function, adds the entity to
> the list of entities in the chain with
> 
> 	list_add_tail(&entity->chain, &chain->entities);

Yes.

> uvc_scan_chain_forward() is then called (from uvc_scan_chain()), and
> iterates over all entities connected to the entity being scanned.
> 
> 	while (1) {
> 		forward = uvc_entity_by_reference(chain->dev, entity->id,
> 			forward);

Yes.

> At this point forward may be equal to entity, if entity references
> itself.

Correct -- that's indicative of a malformed entity which we want to reject,
right?

> 		if (forward == NULL)
> 			break;
> 		if (forward == prev)
> 			continue;
> 		if (forward->chain.next || forward->chain.prev) {
> 			uvc_trace(UVC_TRACE_DESCR, "Found reference to "
> 				"entity %d already in chain.\n", forward->id);
> 			return -EINVAL;
> 		}
> 
> But then this check should trigger, as forward == entity and entity is
> in the chain's list of entities.

Right, but this code is added by my patch, no? In mainline, the code only
has the first two checks, which both end up comparing against NULL the first
time around:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/usb/uvc/uvc_driver.c#n1489

Or are you referring to somewhere else?

Will
