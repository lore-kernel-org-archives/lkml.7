Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929F8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F8D21976
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 05:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfFDFmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 01:42:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfFDFmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 01:42:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 309DB3086239;
        Tue,  4 Jun 2019 05:42:23 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF00B196AD;
        Tue,  4 Jun 2019 05:42:18 +0000 (UTC)
Date:   Tue, 4 Jun 2019 13:42:16 +0800
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] timers: Fix up get_target_base() to use old base properly
Message-ID: <20190604054216.GB15459@xz-x1>
References: <20190603132944.9726-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190603132944.9726-1-peterx@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 04 Jun 2019 05:42:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:29:44PM +0800, Peter Xu wrote:
> get_target_base() in the timer code is not using the "base" parameter
> at all.  My gut feeling is that instead of removing that extra
> parameter, what we really want to do is "return the old base if it
> does not suite for a new one".

I'm trying to think of a detailed scenario of this patch:

  1. setup a timer T1 with TIMER_PINNED on cpu 3 and arm it

  2. on another cpu (e.g., cpu 4), call mod_timer() upon T1 before the
     timer fires itself

     2.1. in __mod_timer(), lock_timer_base() will return cpu 3's
          timer base because it was pinned with cpu 3

     2.2. in the same __mod_timer(), get_target_base() will return cpu
          4's timer base if without this patch, and will return cpu
          3's timer base if with this patch

I don't know whether step 2 is easy to happen but I don't see why it
was forbidden so I'm assuming it could still happen... Then IMHO if
without this patch, the timer T1 will be queued on cpu 4's timer base
rather than cpu 3's, which seems to break TIMER_PINNED.

And just in case if this patch makes sense - get_timer_this_cpu_base()
can be dropped together since not used any more.

-- 
Peter Xu
