Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625AEC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA3B21D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ST3hgdQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388646AbfKGNRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:17:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34307 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727278AbfKGNRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573132624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j1MMxDuBA2PT6Y9+w8jTfu629ILAe/OTnOMkshmEPcE=;
        b=ST3hgdQ5RXD6Jy+78NyAamjd2LpilK58QQiT4DFjFRK7WM0wm3+tUXEn60mUjzqd2yz2Kt
        EgussIM6nKXCMKBpZrNI989bYtzyylidsFFRZD+MP1T1HI1WueTvvfR0Ch+v8Ot8j3xhmU
        OYvA/qvNRDS/4NaGz2gZ1pBidi0opSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-Vx7LdW-aOr6GwqnIXiwZcQ-1; Thu, 07 Nov 2019 08:17:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D926E477;
        Thu,  7 Nov 2019 13:16:59 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC8E95D6A0;
        Thu,  7 Nov 2019 13:16:59 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id B390518095FF;
        Thu,  7 Nov 2019 13:16:59 +0000 (UTC)
Date:   Thu, 7 Nov 2019 08:16:59 -0500 (EST)
From:   Jan Stancek <jstancek@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>, longman@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <524359139.10936023.1573132619485.JavaMail.zimbra@redhat.com>
In-Reply-To: <alpine.DEB.2.21.1911070009040.1869@nanos.tec.linutronix.de>
References: <9179dbc3505e1de99ee36b09b0a12995239d73c3.1573079868.git.jstancek@redhat.com> <alpine.DEB.2.21.1911070009040.1869@nanos.tec.linutronix.de>
Subject: Re: [RFC PATCH] futex: don't retry futex_wait() with stale
 uaddr/val after spurious wakeup
MIME-Version: 1.0
X-Originating-IP: [10.43.17.163, 10.4.195.15]
Thread-Topic: futex: don't retry futex_wait() with stale uaddr/val after spurious wakeup
Thread-Index: L7GrCzziNDlfxhA/K3ZluS5Mqhrymw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Vx7LdW-aOr6GwqnIXiwZcQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies for the 'word salad'.

> So you go great length to "fix" the spurious wakeup case, but what happen=
s if
> there is an actual signal?
>=20
> It will return to handle the signal and then run into the exactly same
> situation because it restarts the syscall with the original uaddr1/uval,
> right?

Right, I missed that.

>=20
> That means that the shortcut which was added in commit d58e6576b0de
> ("futex: Handle spurious wake up") is equivalent to the actual signal cas=
e.
>=20
> So the above churn is pretty pointless because it "fixes" not even half o=
f
> the problem and you can't fix the -ERESTARTSYS case at all.
>=20
> IIRC the uaddr1 value is supposed to change on a requeue operation so tha=
t
> a late incoming waiter goes back with -EWOULDBLOCK. And excatly the same
> would happen on the retry.
>=20
> Aside of that you are completely failing to explain in which context you
> observe this problem. Is that failing on libc, some test case or some oth=
er
> maybe experimental code?

It's test case (LTP futex_cmp_requeue01), which keeps uaddr1 value same
across requeue, and then sporadically fails to wake up some child processes=
.

>=20
> If there is an actual use case for keeping the uaddr1 value the same acro=
ss
> a requeue..

It seems both I and test author missed some hint at man page
for FUTEX_CMP_REQUEUE and assumed this was valid use case.

> But let's talk about that once you came up with a proper explanation for
> what you are trying to solve and why you think it's correct.

Thank you for the detailed response.

