Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFDDCA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43E5214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572270005;
	bh=UZ8dGa7oJwy+aRMXt45rmpZRu20mhvclaF5fSnAE4dg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=XOE+s9fabGkcG6WLHiDfH0iitzBhDxiKpn4G0icnxTfFqhjLTnii1A8pzJIGSDhCm
	 Zp03XBAoumQUUYnPbWMNcmno9tE8CaVVyOtajhvZB5a2lYq7HgaxQonGp6yvSxu0SK
	 a0RvFbjkkVjF/a2ZUfLXzK1w3ApC9sj837X4+0+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389606AbfJ1NkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 09:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729742AbfJ1NkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:40:04 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B1F4214B2;
        Mon, 28 Oct 2019 13:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572270003;
        bh=UZ8dGa7oJwy+aRMXt45rmpZRu20mhvclaF5fSnAE4dg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hOdD2adQ1NIAyqHNn+N1EINazgzUM2evLaa4K9JbledZF+4UJtlYQaRv4P011M0mQ
         p3fZykUE+sawKaWceaxyB/s3h5CDCdx79SjuQYT6zURxIfzBF7neo5dre3aNdivcut
         hV0sDP/d4IYuOo2kw4Ij1S40dxvwE09NyS95e+NA=
Date:   Mon, 28 Oct 2019 06:40:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH tip/core/rcu 03/10] drivers/gpu: Replace
 rcu_swap_protected() with rcu_replace()
Message-ID: <20191028134001.GM4465@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191022191136.GA25627@paulmck-ThinkPad-P72>
 <20191022191215.25781-3-paulmck@kernel.org>
 <157226744651.5420.128752979550120657@jlahtine-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157226744651.5420.128752979550120657@jlahtine-desk.ger.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 02:57:26PM +0200, Joonas Lahtinen wrote:
> Quoting paulmck@kernel.org (2019-10-22 22:12:08)
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > This commit replaces the use of rcu_swap_protected() with the more
> > intuitively appealing rcu_replace() as a step towards removing
> > rcu_swap_protected().
> > 
> > Link: https://lore.kernel.org/lkml/CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com/
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > [ paulmck: From rcu_replace() to rcu_replace_pointer() per Ingo Molnar. ]
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> > Cc: <intel-gfx@lists.freedesktop.org>
> > Cc: <dri-devel@lists.freedesktop.org>
> 
> "drm/i915:" preferred as the subject prefix for increased specificity.

"drm/i915" it is!

> Let me know which tree you end up merging with.

I expect to be sending a pull request for inclusion into the -tip
tree in a day or three.

> Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

Applied, thank you!

							Thanx, Paul
