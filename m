Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75193ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA5A2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570465637;
	bh=qkPwaifvDP84GW7cD+F3JRfGMTnA8T3MOxCOa4QrBpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1T/k1U1X7VYGk0fwa8Z8yW3K6xvlzS7pci5jDTwTS+s7mI31fbGqkhigMOekraYtp
	 S6MOyikIsXj/lmhOxdwsW/jF6nmewa6Jp1ix4+4ZcTRSloP0bpFB3Xl3WJbp6ynmc1
	 uce/FXNkBg/4ObzlK+B6zJxoOgF8sj5vnocmfry4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfJGQ1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfJGQ1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:27:16 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F319206C0;
        Mon,  7 Oct 2019 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570465635;
        bh=qkPwaifvDP84GW7cD+F3JRfGMTnA8T3MOxCOa4QrBpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1fPp3LLq8WpQ3cVRHDVr1luJR17NmuqeTva4l2taEfkyZ1QAwT8/xIu2UEiWgRi5b
         EpAJTPPWL72mKGJqgZlHdhKbmvyW3gcWiN5QWC/teWy1c6/Ppe7o0FShfQIgo+UunD
         vg9v5LjwZ5tKqn9FIIdIO6E4esYz5aQm2I1qvNww=
Date:   Mon, 7 Oct 2019 17:27:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        andreyknvl@google.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] media: uvc: Avoid cyclic entity chains due to malformed
 USB descriptors
Message-ID: <20191007162709.3vrtbcpoymmnqikl@willie-the-truck>
References: <20191002112753.21630-1-will@kernel.org>
 <20191002130913.GA5262@pendragon.ideasonboard.com>
 <20191002131928.yp5r4tyvtvwvuoba@willie-the-truck>
 <20191002185604.GF5262@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002185604.GF5262@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Sorry for the delay, I got tied up with other patches.

On Wed, Oct 02, 2019 at 09:56:04PM +0300, Laurent Pinchart wrote:
> On Wed, Oct 02, 2019 at 02:19:29PM +0100, Will Deacon wrote:
> > > uvc_scan_chain_forward() is then called (from uvc_scan_chain()), and
> > > iterates over all entities connected to the entity being scanned.
> > > 
> > > 	while (1) {
> > > 		forward = uvc_entity_by_reference(chain->dev, entity->id,
> > > 			forward);
> > 
> > Yes.
> > 
> > > At this point forward may be equal to entity, if entity references
> > > itself.
> > 
> > Correct -- that's indicative of a malformed entity which we want to reject,
> > right?
> 
> Right. We can reject the whole chain in that case. There's one case
> where we still want to succeed though, which is handled by
> uvc_scan_fallback().
> 
> Looking at the code, uvc_scan_device() does
> 
>                 if (uvc_scan_chain(chain, term) < 0) {
>                         kfree(chain);
>                         continue;
>                 }
> 
> It seems that's missing removal of all entities that would have been
> successfully added to the chain. This prevents, I think,
> uvc_scan_fallback() from working properly in some cases.

I started trying to hack something up here, but I'm actually not sure
there's anything to do!

I agree that 'uvc_scan_chain()' can fail after adding entities to the
chain, however, 'uvc_scan_fallback()' allocates a new chain and calls
only 'uvc_scan_chain_entity()' to add entities to it. This doesn't fail
on pre-existing 'list_head' structures, so the dangling pointers shouldn't
pose a problem there. My patch only adds the checks to
'uvc_scan_chain_forward()' and 'uvc_scan_chain_backward()', neither of
which are invoked on the fallback path.

The fallback also seems like a best-effort thing, since it isn't even
invoked if we managed to initialise *any* chains successfully.

Does that make sense, or did you have another failure case in mind?

> > > 		if (forward == NULL)
> > > 			break;
> > > 		if (forward == prev)
> > > 			continue;
> > > 		if (forward->chain.next || forward->chain.prev) {
> > > 			uvc_trace(UVC_TRACE_DESCR, "Found reference to "
> > > 				"entity %d already in chain.\n", forward->id);
> > > 			return -EINVAL;
> > > 		}
> > > 
> > > But then this check should trigger, as forward == entity and entity is
> > > in the chain's list of entities.
> > 
> > Right, but this code is added by my patch, no? In mainline, the code only
> > has the first two checks, which both end up comparing against NULL the first
> > time around:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/usb/uvc/uvc_driver.c#n1489
> > 
> > Or are you referring to somewhere else?
> 
> Oops. This is embarassing... :-) You're of course right. The second hunk
> seems fine too, even if I would have preferred centralising the check in
> a single place. That should be possible, but it would involve
> refactoring that isn't worth it at the moment.

Agreed, thanks.

Will
