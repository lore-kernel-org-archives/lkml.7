Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163E4C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6D720692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnQ5W+Qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgAHXS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 18:18:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34108 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726758AbgAHXS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 18:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578525505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RnMKrtmikACgO04qcl4qTXBFDdpzd+CcaRgpR5Lqaoo=;
        b=VnQ5W+QgTt109w+pfvGB86JoNGI0gil6k6K/llJpKfxvNtDE/0CoMEYbdwAU6r6oBamL/J
        H9UfVFSwg7el4JZ6S4tHucvrITs9BeFBSC5vwiFaAVJdggjrgu1BMw9xi0W9nNnPS4aEi2
        8Y3Lv7aYlKKRwoO/9wzz87zpRAiDi1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-zKu6wjKZNuGLpNkPwfHptA-1; Wed, 08 Jan 2020 18:18:22 -0500
X-MC-Unique: zKu6wjKZNuGLpNkPwfHptA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9496477;
        Wed,  8 Jan 2020 23:18:20 +0000 (UTC)
Received: from ovpn-120-231.rdu2.redhat.com (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AC1A60BF7;
        Wed,  8 Jan 2020 23:18:19 +0000 (UTC)
Message-ID: <6d18d7772f9ad1f42444ea936243ce958a1345dc.camel@redhat.com>
Subject: Re: [PATCH 1/4] tick/sched: Forward timer even in nohz mode
From:   Scott Wood <swood@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Date:   Wed, 08 Jan 2020 17:18:09 -0600
In-Reply-To: <20200106221850.GD26097@lenoir>
References: <1576538545-13274-1-git-send-email-swood@redhat.com>
         <20200106221850.GD26097@lenoir>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-01-06 at 23:18 +0100, Frederic Weisbecker wrote:
> On Mon, Dec 16, 2019 at 06:22:22PM -0500, Scott Wood wrote:
> > Currently when exiting nohz, the expiry will be forwarded as if we
> > had just run the timer.  If we re-enter nohz before this new expiry,
> > and exit after, this forwarding will happen again.  If this load pattern
> > recurs the tick can be indefinitely postponed.
> 
> I must be missing something but I don't see why that would be a problem.
> Indeed the tick can be indefinitely postponed but that's as long as it's
> not needed. As soon as it's needed (timer callback expired, RCU, ...), the
> tick will be retained and it will eventually fire.

My main concern was the loadavg recording, which does not prevent entering
nohz.  However, if we're going into and out of nohz then the call to
calc_load_nohz_start() in tick_nohz_stop_tick() should take care of it, so I
guess we only need patches 3 and 4, if there's nothing else in the tick that
doesn't either prevent nohz or get handled during the transition
(psi_task_tick?).

-Scott


