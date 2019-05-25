Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12B0C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873AA20862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfEYRTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 13:19:33 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:51064 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfEYRTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 13:19:33 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 3EF86803C0;
        Sat, 25 May 2019 19:19:30 +0200 (CEST)
Date:   Sat, 25 May 2019 19:19:28 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 00/33] fbcon notifier begone!
Message-ID: <20190525171928.GA13526@ravnborg.org>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=ZE5gt9_PBDywe7APGxUA:9 a=FsULZnL4HXkDZy8N:21 a=dmQ2iDlEpyUWv4jE:21
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel.

Good work, nice cleanup all over.

A few comments to a few patches - not something that warrant a
new series to be posted as long as it is fixed before the patches are
applied.


> btw for future plans: I think this is tricky enough (it's old code and all
> that) that we should let this soak for 2-3 kernel releases. I think the
> following would be nice subsequent cleanup/fixes:
> 
> - push the console lock completely from fbmem.c to fbcon.c. I think we're
>   mostly there with prep, but needs to pondering of corner cases.
I wonder - should this code consistently use __acquire() etc so we could
get a little static analysis help for the locking?

I have not played with this for several years and I do not know the
maturity of this today.

> - move fbcon.c from using indices for tracking fb_info (and accessing
>   registered_fbs without proper locking all the time) to real fb_info
>   pointers with the right amount of refcounting. Mostly motivated by the
>   fun I had trying to simplify fbcon_exit().
> 
> - make sure that fbcon call lock/unlock_fb when it calls fbmem.c
>   functions, and sprinkle assert_lockdep_held around in fbmem.c. This
>   needs the console_lock cleanups first.
> 
> But I think that's material for maybe next year or so.
Or maybe after next kernel release.
Could we put this nice plan into todo.rst or similar so we do not have
to hunt it down by asking google?

For the whole series you can add my:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Some parts are reviewed as "this looks entirely correct", other parts
I would claim that I actually understood.
And after having spend some hours on this a r-b seems in order.

	Sam
