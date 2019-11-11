Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FE2C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AC8206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsIelPnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfKKJtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:49:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49875 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726768AbfKKJtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573465744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rU7ZvQu8Y9X/WtpvD+LowCBFcWPggXEpG4n/i5wP10M=;
        b=BsIelPnUDKhoNoypKuJtPzd5s5AbcEY2MkjRAaJE9lanKgR4waygTABx/M2nyu9DIu5Juk
        JAeywv+oABPNTaYygp84MWrW+pvDhiEqIIqy77+G4IknMXqM54hciuzNKs/0vUbnkr6ANV
        xEjwKXdRboXKLvfCEvvjGcMzwmYKgeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-z1z6JdrMP3CBCfUiw9R3xQ-1; Mon, 11 Nov 2019 04:49:03 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8CA81005509;
        Mon, 11 Nov 2019 09:49:01 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-200.str.redhat.com [10.33.192.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A90CF5D6A3;
        Mon, 11 Nov 2019 09:48:54 +0000 (UTC)
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
        <87v9rv8g44.fsf@oldenburg2.str.redhat.com>
        <87o8xm95rt.fsf@oldenburg2.str.redhat.com>
        <alpine.DEB.2.21.1911080912520.27903@nanos.tec.linutronix.de>
        <87o8xm65ar.fsf@oldenburg2.str.redhat.com>
        <alpine.DEB.2.21.1911081136450.26566@nanos.tec.linutronix.de>
        <alpine.DEB.2.21.1911081223110.26566@nanos.tec.linutronix.de>
Date:   Mon, 11 Nov 2019 10:48:53 +0100
In-Reply-To: <alpine.DEB.2.21.1911081223110.26566@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Fri, 8 Nov 2019 12:51:53 +0100 (CET)")
Message-ID: <87woc6yc8q.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: z1z6JdrMP3CBCfUiw9R3xQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Gleixner:

> pthread_create() returns EAGAIN while the underlying problem is ENOMEM
> which causes this bonkers output:
>
>   error: pthread_create for thread 253 failed: Resource temporarily unava=
ilable
>
> There is nothing temporarily. The process has its address space exhausted=
.

Thanks for analyzing the failure.  I thought we had already covered
that.  I've fixed the test locally and will submit the changes.  The
fixed test passes, as expected.

I expected that we've fixed all such occurrences of per-CPU thread
creation, but apparently not. 8-(

> That test's output is anyway strange:
>
>  info: Detected CPU set size (in bits): 225
>  info: Maximum test CPU: 255
>
> Interesting how it fits 256 CPUs into a cpuset with a size of 225 bits.

That's an unfortunate side effect of how the CPU set allocation works in
userspace.  The allocation uses a size meaured in bits (which are
rounded up, out of necessity), but the kernel interface is byte-based.
The kernel does not not know that some bits are padding, and happily
writes result data there.  So we get bits back for which no space had
been allocated explicitly.

I hesitated to clean this up because the story on the kernel side was
equally mystifying.  getaffinity requires space in the mask for CPUs
that are currently not present and whose affinity bits are not set.  Due
to firmware bugs, this means that we can cross the magic 1024 bits
boundary (corresponding to the 128 byte legacy mask size), and some
applications will refuse to start. 8-( There was considerable
controversy on the kernel side the last time this came up IIRC.

Thanks,
Florian

