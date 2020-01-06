Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F623C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C426207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcZdrnAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgAFUMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:12:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31979 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726657AbgAFUMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578341543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdEgty3CE7PdK55uX5qyqvzB3E0+BaCykDG5H4EW69Y=;
        b=dcZdrnAUwOfUXFLh2EyyIsZ5F3MMAyHJIYVmVKd6IyYyfPVeOakTkj5KFu4eUSNgj2EAQ1
        AxAUR3L7tLTLI3cTwQT/ksgVYUQhKUaXX/KPO2lzNmwQxmY8ZPhARymk1KFgLvcWX/Hnf3
        34PP3fDU/wP/80Dk9EeaM+7mROB9Oes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-SCAqrdTOOiiypzT3olz16A-1; Mon, 06 Jan 2020 15:12:21 -0500
X-MC-Unique: SCAqrdTOOiiypzT3olz16A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 584B6107ACC7;
        Mon,  6 Jan 2020 20:12:20 +0000 (UTC)
Received: from ovpn-117-103.phx2.redhat.com (ovpn-117-103.phx2.redhat.com [10.3.117.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C76E67DB55;
        Mon,  6 Jan 2020 20:12:19 +0000 (UTC)
Message-ID: <8f0763efd927f791b1c13ca65712a2380985297a.camel@redhat.com>
Subject: Re: [PATCH 1/4] tick/sched: Forward timer even in nohz mode
From:   Scott Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 06 Jan 2020 14:12:19 -0600
In-Reply-To: <1576538545-13274-1-git-send-email-swood@redhat.com>
References: <1576538545-13274-1-git-send-email-swood@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-16 at 18:22 -0500, Scott Wood wrote:
> Currently when exiting nohz, the expiry will be forwarded as if we
> had just run the timer.  If we re-enter nohz before this new expiry,
> and exit after, this forwarding will happen again.  If this load pattern
> recurs the tick can be indefinitely postponed.
> 
> To avoid this, use last_tick as-is rather than calling hrtimer_forward().
> However, in some cases the tick *will* have just run (despite being
> "stopped"), and leading to double timer execution.
> 
> To avoid that, forward the timer after every tick (regardless of nohz
> status) and keep last_tick up-to-date.  During nohz, last_tick will
> reflect what the expiry would have been if not in nohz mode.
> 
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
>  kernel/time/tick-sched.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Any comments on these patches?

Thanks,
Scott


