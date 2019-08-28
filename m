Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C397EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9216522DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IKaQgq0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfH1V05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:26:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46874 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfH1V05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:26:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id q139so569114pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 14:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DZE+I17WUXfulNqloPBEY+WzSfcCoyev0zgQpc73LBs=;
        b=IKaQgq0yAWh7Vz5wXXFT87FaFZA6kr424RlcH++fA892HsLcwSdYQxjywwnsgGiwus
         /Nwol9uU25m9aZ7BNiQ1rLQL9YbTF2wmgJ9OjrzpJfZFrNPQtwgjSJJpGb8F1HnRcynj
         0zNtvHwjeWoAWwn0Hprajeqh8zULN4yt5WmlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DZE+I17WUXfulNqloPBEY+WzSfcCoyev0zgQpc73LBs=;
        b=PbX8Wy82N7bmKX7FiSHOQ46zYD3EIQwMxSmigB6fnr0576YdWTyEJljYFh5JeY8pBf
         KoiG0bkQr0OfAt/j6hJ78XMuhhTsr1/yDea9iYJL+0vDL+GtlMlFJBLDFAIUfIiQ488/
         sTQa+7ebCezBP5dYflbimI/nkFzQUcECvmwMY4zy+2njd/221ElKeWi1daL8bxwgJbGb
         MGB1zjBHy2gsgWLMKammQP0l1CIvvyBY9MI8LlUlHty3nPjKCH8dsXTd3w2N6weBjNoS
         L3h0AhEINuOPjYx5tVcqSkdH3qkaajehYAzcP9GryMe2GxbxWvXIzsexxYB2WnjI2pMv
         LuGg==
X-Gm-Message-State: APjAAAU6V5wg3aUkS57zegEushe5eKh9CrSEnde1DuTCWYGAkJb6YXhD
        RgvYZ/Ta5xjj9kKHtCZ1VSrdBpXYIis=
X-Google-Smtp-Source: APXvYqxBUeHTOJvoVs0XvB3oXfVECNxjlY8Tvz8jW8mB/fE4F3TwQSIHFH8bxkDvgf6CdOPX7Y+YKQ==
X-Received: by 2002:a17:90a:cc11:: with SMTP id b17mr6240846pju.136.1567027616235;
        Wed, 28 Aug 2019 14:26:56 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 138sm335018pfw.78.2019.08.28.14.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 14:26:55 -0700 (PDT)
Date:   Wed, 28 Aug 2019 17:26:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, byungchul.park@lge.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: Re: [PATCH 0/5] kfree_rcu() additions for -rcu
Message-ID: <20190828212654.GC75931@google.com>
References: <5d657e30.1c69fb81.54250.01dc@mx.google.com>
 <20190828202808.GT26530@linux.ibm.com>
 <20190828203458.GA75931@google.com>
 <20190828204624.GV26530@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828204624.GV26530@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 01:46:24PM -0700, Paul E. McKenney wrote:
> On Wed, Aug 28, 2019 at 04:34:58PM -0400, Joel Fernandes wrote:
> > On Wed, Aug 28, 2019 at 01:28:08PM -0700, Paul E. McKenney wrote:
> > > On Tue, Aug 27, 2019 at 03:01:54PM -0400, Joel Fernandes (Google) wrote:
> > > > Hi,
> > > > 
> > > > This is a series on top of the patch "rcu/tree: Add basic support for kfree_rcu() batching".
> > > > 
> > > > Link: http://lore.kernel.org/r/20190814160411.58591-1-joel@joelfernandes.org
> > > > 
> > > > It adds performance tests, some clean ups and removal of "lazy" RCU callbacks.
> > > > 
> > > > Now that kfree_rcu() is handled separately from call_rcu(), we also get rid of
> > > > kfree "lazy" handling from tree RCU as suggested by Paul which will be unused.
> > > > This also results in a nice negative delta as well.
> > > > 
> > > > Joel Fernandes (Google) (5):
> > > > rcu/rcuperf: Add kfree_rcu() performance Tests
> > > > rcu/tree: Add multiple in-flight batches of kfree_rcu work
> > > > rcu/tree: Add support for debug_objects debugging for kfree_rcu()
> > > > rcu: Remove kfree_rcu() special casing and lazy handling
> > > > rcu: Remove kfree_call_rcu_nobatch()
> > > > 
> > > > Documentation/RCU/stallwarn.txt               |  13 +-
> > > > .../admin-guide/kernel-parameters.txt         |  13 ++
> > > > include/linux/rcu_segcblist.h                 |   2 -
> > > > include/linux/rcutiny.h                       |   5 -
> > > > include/linux/rcutree.h                       |   1 -
> > > > include/trace/events/rcu.h                    |  32 ++--
> > > > kernel/rcu/rcu.h                              |  27 ---
> > > > kernel/rcu/rcu_segcblist.c                    |  25 +--
> > > > kernel/rcu/rcu_segcblist.h                    |  25 +--
> > > > kernel/rcu/rcuperf.c                          | 173 +++++++++++++++++-
> > > > kernel/rcu/srcutree.c                         |   4 +-
> > > > kernel/rcu/tiny.c                             |  29 ++-
> > > > kernel/rcu/tree.c                             | 145 ++++++++++-----
> > > > kernel/rcu/tree.h                             |   1 -
> > > > kernel/rcu/tree_plugin.h                      |  42 +----
> > > > kernel/rcu/tree_stall.h                       |   6 +-
> > > > 16 files changed, 337 insertions(+), 206 deletions(-)
> > > 
> > > Looks like a 131-line positive delta to me.  ;-)
> > 
> > Not if you overlook the rcuperf changes which is just test code. :-D ;-)
> 
> Which suggests that you should move the "nice negative delta" comment
> to the commits that actually have nice negative deltas.  ;-)

Will do!

thanks,

 - Joel

