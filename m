Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57695C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A8920663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ey6cCVpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfLQOO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:14:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44018 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728546AbfLQOO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576592098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z3WKtHiJ7FkkQLNQo2Osm4wM8wUQdLSRjz4d46zCmMM=;
        b=ey6cCVpCg2A/Gj9bOISdERdo3UHLmixVEejNcIyfuwZRmdp9jG9z2kNh0agC9Yaw8Qh/n2
        uIDCzXTUbFeYJxHAjwP14T+Dzn/m9RKO7jHyd76KHfXL5DMkrTROpGziI5FroiB9/802dB
        P3rIFi/7M3H8vBweuru/hsGsgk2Ij8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-bGQaAXeKOMOsM3xkZYW5cw-1; Tue, 17 Dec 2019 09:14:54 -0500
X-MC-Unique: bGQaAXeKOMOsM3xkZYW5cw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4188F1044804;
        Tue, 17 Dec 2019 14:14:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 79D376016C;
        Tue, 17 Dec 2019 14:14:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 17 Dec 2019 15:14:50 +0100 (CET)
Date:   Tue, 17 Dec 2019 15:14:48 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     qiwuchen55@gmail.com, peterz@infradead.org, mingo@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        chenqiwu@xiaomi.com
Subject: Re: [PATCH v2] kernel/exit: do panic earlier to get coredump if
 global init task exit
Message-ID: <20191217141447.GA23152@redhat.com>
References: <1576466324-6067-1-git-send-email-qiwuchen55@gmail.com>
 <20191216172841.GA10466@redhat.com>
 <20191216174410.xiqurqnqyipbuy4e@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216174410.xiqurqnqyipbuy4e@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16, Christian Brauner wrote:
>
> On Mon, Dec 16, 2019 at 06:28:41PM +0100, Oleg Nesterov wrote:
> >
> > And I am worried atomic_dec_and_test() is called too early...
> >
> > Say, acct_process() can report the exit while some sub-thread sleeps
>
> Hm, I'm not following here. I might just be slow. acct_process() doesn't
> seem to report exit status and has been called after group_dead before.

Yes, but with this patch group_dead becomes true before the process is
"dead enough".

Suppose a process has 2 threads, T1, and T2.

T1 exits, decrements signal->live, and sleeps in PTRACE_EVENT_EXIT.

T2 exits, decrements signal->live, group_dead == T, it calls acct_process()
which reports the fact this process has exited. Probably not a real problem,
but still strange, this process has not exited yet, it is not even a zombie.

Oleg.

