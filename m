Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAD4FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 07:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4544620679
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 07:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2JW1z0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfKHHjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 02:39:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23788 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725975AbfKHHjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 02:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573198740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OTFfW9HQvGLEHBAUp1KYnpCkwNX8J7r1nDj0/Qrq4P0=;
        b=W2JW1z0iwLH11yLi/Bp1N/4OCHAmGwJ3xubz5J3HssgxaA4UGfAhoWRp9uWMnlcTgvf7ce
        +MkUx6PQsfJ2w08XgXiDAqn2i4Ohzfd4cKnybIKGN5qdZAlLSl9x0ch+nOEntbefbLPPL+
        BmwACSvPc3uiNHPFaiPAQdn16IoU7KI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-8W9nSN_yMsGLLGW_FTba6g-1; Fri, 08 Nov 2019 02:38:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A199E800C72;
        Fri,  8 Nov 2019 07:38:55 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-225.ams2.redhat.com [10.36.116.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FF376084E;
        Fri,  8 Nov 2019 07:38:47 +0000 (UTC)
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
Date:   Fri, 08 Nov 2019 08:38:46 +0100
In-Reply-To: <87v9rv8g44.fsf@oldenburg2.str.redhat.com> (Florian Weimer's
        message of "Thu, 07 Nov 2019 23:40:43 +0100")
Message-ID: <87o8xm95rt.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 8W9nSN_yMsGLLGW_FTba6g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Florian Weimer:

> * Florian Weimer:
>
>> * Thomas Gleixner:
>>
>>> The series is also available from git:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.locking=
/futex
>>
>> I ran the glibc upstream test suite (which has some robust futex tests)
>> against b21be7e942b49168ee15a75cbc49fbfdeb1e6a97 on x86-64, both native
>> and 32-bit/i386 compat mode.
>>
>> compat mode seems broken, nptl/tst-thread-affinity-pthread fails.  This
>> is probably *not* due to
>> <https://bugzilla.kernel.org/show_bug.cgi?id=3D154011> because the failu=
re
>> is non-sporadic, but reliable fails for thread 253:
>>
>> info: Detected CPU set size (in bits): 225
>> info: Maximum test CPU: 255
>> error: pthread_create for thread 253 failed: Resource temporarily unavai=
lable
>>
>> I'm running this on a large box as root, so ulimits etc. do not apply.
>>
>> I did not see this failure with the x86-64 test.
>>
>> You should be able to reproduce with (assuming you've got a multilib gcc=
):
>>
>> git clone git://sourceware.org/git/glibc.git git
>> mkdir build
>> cd build
>> ../git/configure --prefix=3D/usr CC=3D"gcc -m32" CXX=3D"g++ -m32" --buil=
d=3Di686-linux
>> make -j`nproc`
>> make test t=3Dnptl/tst-thread-affinity-pthread
>
> Sorry, I realized that I didn't actually verify that this is a
> regression caused by your patches.  Maybe I can do that tomorrow.

Confirmed as a regression caused by the patches.  Depending on the
nature of the bug, you need a machine which has or pretends to have many
CPUs (this one has 256 CPUs).

Please let me know if you need more information.

Thanks,
Florian

