Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F229EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12A3207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552251826;
	bh=q0PUVwOut6IVrnZMVAnvSVuPugbFv1l0jGrQRBXv2MY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZZNk4qDsbHocNBb8nmEpxbKCDidWVxuzIeL4vXVmzluvGQrsrPKaPHldgfJ2d9s+r
	 ZN1u8l9etci1Qqn2Pjiz51cYPQikHpTnFVrucoDuCG7zaR7iNyYtXq61Hz7ncydkVJ
	 GkG0A8EQAjX2P6T+PrbEJHuJq9o2YHG/VGb0K8ZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfCJVDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 17:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfCJVDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 17:03:44 -0400
Received: from localhost (unknown [104.153.224.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB108206BA;
        Sun, 10 Mar 2019 21:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552251823;
        bh=q0PUVwOut6IVrnZMVAnvSVuPugbFv1l0jGrQRBXv2MY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w0J12NO7pJBumbfQjHBiN3c7+guKb1CsNQER8w6nokTEfrC3lHAyuqSc6KiDMXPSO
         vxgIkAy0avn0LAFTGqfqezpRqDKfvPbTGUIe4UZIlB2GG6GugnIxTWg/gs+LhAxkfm
         0jEf+AO0gd6VPsDh/wC81p9mKudaiP+LJ8KgydGk=
Date:   Sun, 10 Mar 2019 22:03:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190310210335.GA5504@kroah.com>
References: <20190310203403.27915-1-sultan@kerneltoast.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310203403.27915-1-sultan@kerneltoast.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 01:34:03PM -0700, Sultan Alsawaf wrote:
> From: Sultan Alsawaf <sultan@kerneltoast.com>
> 
> This is a complete low memory killer solution for Android that is small
> and simple. It kills the largest, least-important processes it can find
> whenever a page allocation has completely failed (right after direct
> reclaim). Processes are killed according to the priorities that Android
> gives them, so that the least important processes are always killed
> first. Killing larger processes is preferred in order to free the most
> memory possible in one go.
> 
> Simple LMK is integrated deeply into the page allocator in order to
> catch exactly when a page allocation fails and exactly when a page is
> freed. Failed page allocations that have invoked Simple LMK are placed
> on a queue and wait for Simple LMK to satisfy them. When a page is about
> to be freed, the failed page allocations are given priority over normal
> page allocations by Simple LMK to see if they can immediately use the
> freed page.
> 
> Additionally, processes are continuously killed by failed small-order
> page allocations until they are satisfied.
> 
> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>

Wait, why?  We just removed the in-kernel android memory killer, we
don't want to add another one back again, right?  Android Go devices
work just fine with the userspace memory killer code, and those are "low
memory" by design.

Why do we need kernel code here at all?

thanks,

greg k-h
