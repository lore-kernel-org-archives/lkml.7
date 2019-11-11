Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDB2C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335AE20818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqdEErT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKKJli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:41:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48070 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726857AbfKKJlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573465296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xH9paoH84WAP3S/ATWHs4L3GR0FO8tvE2c1L9kietRg=;
        b=JqdEErT9cwFYr3CMZgBawGC4ZWMKWqG7hNf49a4Zb4h2m5G30ymEJKS8cZVAX2uqGArDE0
        of9xl9Q6q8mFhfMiC9Kga9uiOd3BhvPrXmH0c6PB2jW3VppZy8JjdqC77VjCUK6N05VwKv
        JQmMQJ9YvqrXIaA6TRDQU9ng+ppFejs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-_hgx6tiHOsGX5hz3cbUKkA-1; Mon, 11 Nov 2019 04:41:35 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BA28477;
        Mon, 11 Nov 2019 09:41:34 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 103AE5DA7D;
        Mon, 11 Nov 2019 09:41:34 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id ED0854BB5C;
        Mon, 11 Nov 2019 09:41:33 +0000 (UTC)
Date:   Mon, 11 Nov 2019 04:41:33 -0500 (EST)
From:   Jan Stancek <jstancek@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, ltp@lists.linux.it,
        viro@zeniv.linux.org.uk, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, rfontana@redhat.com
Message-ID: <475677126.11444968.1573465293662.JavaMail.zimbra@redhat.com>
In-Reply-To: <20191107125559.GI4131@hirez.programming.kicks-ass.net>
References: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com> <20191107123224.GA6315@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1911071335320.4256@nanos.tec.linutronix.de> <20191107125559.GI4131@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH] kernel: use ktime_get_real_ts64() to calculate
 acct.ac_btime
MIME-Version: 1.0
X-Originating-IP: [10.43.17.163, 10.4.195.4]
Thread-Topic: kernel: use ktime_get_real_ts64() to calculate acct.ac_btime
Thread-Index: j00i/ne0YYWt2EQwNR0Jpc5QU9IvTg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: _hgx6tiHOsGX5hz3cbUKkA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
> It's wrecked in general. It also jumps around for any REALTIME
> adjustment.
>=20
> > So a CLOCK_REALTIME time stamp at fork would at least be correct
> > vs. suspend resume.
>=20
> But still wrecked vs REALTIME jumps, as in, when DST flips the clock
> back an hour, your timestamp is in the future.
>=20
> Any which way around the whole thing is buggered.  The only real fix is
> not using REALTIME anything. Which is why I'm loath to add that REALTIME
> timestamp at fork(), it just encourages more use.

Thank you for feedback and listing all other problems.
I'll adjust test expectations.

Regards,
Jan

