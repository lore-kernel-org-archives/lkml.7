Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A44C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B9220869
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzxpbIWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfKGWk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:40:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52613 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725945AbfKGWk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573166457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qp0hliiBVCBl2TWF6Q+D6M1TDWdWYIueXrNe0KhBawg=;
        b=DzxpbIWghh3ztXidNl2kqK5vdMkHtIFCeGA5PESNXGHboS2rzqw/IJ/Zq5er37/5QB9eCe
        ThjrywYL6WOHmubwJTFVs0/z9e3znMYKWw1oLr4sKgIFPRkhdRuJD1ZvL6AYUSFzG6mvqT
        VDDVNSemFt7IE2F+HqfUZDGCrZYLTDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-u_p2t8psPXuVYLjcNZM6-w-1; Thu, 07 Nov 2019 17:40:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26C951005500;
        Thu,  7 Nov 2019 22:40:53 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-48.ams2.redhat.com [10.36.116.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 874776084E;
        Thu,  7 Nov 2019 22:40:45 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <darren@dvhart.com>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Yang Tao <yang.tao172@zte.com.cn>,
        Oleg Nesterov <oleg@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [patch 00/12] futex: Cure robust/PI futex exit races
References: <20191106215534.241796846@linutronix.de>
        <87zhh78gnf.fsf@oldenburg2.str.redhat.com>
Date:   Thu, 07 Nov 2019 23:40:43 +0100
In-Reply-To: <87zhh78gnf.fsf@oldenburg2.str.redhat.com> (Florian Weimer's
        message of "Thu, 07 Nov 2019 23:29:08 +0100")
Message-ID: <87v9rv8g44.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: u_p2t8psPXuVYLjcNZM6-w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Florian Weimer:

> * Thomas Gleixner:
>
>> The series is also available from git:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.locking/=
futex
>
> I ran the glibc upstream test suite (which has some robust futex tests)
> against b21be7e942b49168ee15a75cbc49fbfdeb1e6a97 on x86-64, both native
> and 32-bit/i386 compat mode.
>
> compat mode seems broken, nptl/tst-thread-affinity-pthread fails.  This
> is probably *not* due to
> <https://bugzilla.kernel.org/show_bug.cgi?id=3D154011> because the failur=
e
> is non-sporadic, but reliable fails for thread 253:
>
> info: Detected CPU set size (in bits): 225
> info: Maximum test CPU: 255
> error: pthread_create for thread 253 failed: Resource temporarily unavail=
able
>
> I'm running this on a large box as root, so ulimits etc. do not apply.
>
> I did not see this failure with the x86-64 test.
>
> You should be able to reproduce with (assuming you've got a multilib gcc)=
:
>
> git clone git://sourceware.org/git/glibc.git git
> mkdir build
> cd build
> ../git/configure --prefix=3D/usr CC=3D"gcc -m32" CXX=3D"g++ -m32" --build=
=3Di686-linux
> make -j`nproc`
> make test t=3Dnptl/tst-thread-affinity-pthread

Sorry, I realized that I didn't actually verify that this is a
regression caused by your patches.  Maybe I can do that tomorrow.

Florian

