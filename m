Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FD5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13B821582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdxRijRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfLQPXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:23:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53370 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728320AbfLQPXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576596223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FISSAqDTrddEYk3QkzjWh3id0BIOLIODLvyAsnqqLws=;
        b=YdxRijRcNpr+IjhbHIGk4ipssPl6RBO+4iu8/j0f0bCWNHsFqeP7HQa3/MYyxUr9bqXKKC
        zvq21zWmPAUKdDV7LXwTWuut8AMLgswO7iBfVsxan8TxBmkbBOqDpd/rSbNyNZnaLaaLIu
        yts1tfd2Dc5NwJHkDFr10eBNvRvUBGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-DbcCpax7PwGxjiiKDTHHig-1; Tue, 17 Dec 2019 10:23:40 -0500
X-MC-Unique: DbcCpax7PwGxjiiKDTHHig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80B578DC1A0;
        Tue, 17 Dec 2019 15:23:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id D698360BE0;
        Tue, 17 Dec 2019 15:23:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 17 Dec 2019 16:23:35 +0100 (CET)
Date:   Tue, 17 Dec 2019 16:23:33 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     chenqiwu <qiwuchen55@gmail.com>
Cc:     christian.brauner@ubuntu.com, peterz@infradead.org,
        mingo@kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, chenqiwu@xiaomi.com
Subject: Re: [PATCH v2] kernel/exit: do panic earlier to get coredump if
 global init task exit
Message-ID: <20191217152333.GC23152@redhat.com>
References: <1576466324-6067-1-git-send-email-qiwuchen55@gmail.com>
 <20191216172841.GA10466@redhat.com>
 <20191216174410.xiqurqnqyipbuy4e@wittgenstein>
 <20191217105042.GA21784@cqw-OptiPlex-7050>
 <20191217142515.GB23152@redhat.com>
 <20191217145620.GA26585@cqw-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217145620.GA26585@cqw-OptiPlex-7050>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17, chenqiwu wrote:
>
> But in fact, I think atomic_read()
> can avoid the racy even if both threads exit in parallel, since it is
> an atomic operation forever.

Hmm, not sure I understand. atomic_read() is just READ_ONCE(), it can't be
re-ordered but that is all.

How can it avoid the race if it is called before atomic_dec_and_test() ?

Again, suppose that we have 2 exiting threads and signal->live == 2. With
your patch each thread does atomic_read() before atomic_dec_and_test(),
both threads can observe atomic_read(signal->live) == 2 simply because
the counter was not decremented yet.

Oleg.

