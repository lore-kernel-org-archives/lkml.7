Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2399AC2D0C1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7B924659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iS/qPmuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLFORD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:17:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37816 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726214AbfLFORD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575641821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZIJx8+mn7hsmuKsrvwqAWlAV7JzTrtDo1L8YffDmDY=;
        b=iS/qPmuc+Pz+5nqRceBzKVp+hhjelEMFphYs+E1csNMCKp0DCJWLqWYBF2GdKwaXuiRP/X
        qPIaUkCIFrvBUbbJsmgEk+Kg2BDG9vAro69B3vlTo8JqSq1N6jdbTSKoBoHzJwVDmGlPRr
        fnaN+9QaI7pcBcKJYsXk3zImdmvOKz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-vhicXEh8O6CvUvqBmFTRSw-1; Fri, 06 Dec 2019 09:16:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3256C800D5B;
        Fri,  6 Dec 2019 14:16:56 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F86960BF4;
        Fri,  6 Dec 2019 14:16:54 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     prarit@redhat.com
Cc:     andrea.parri@amarulasolutions.com, brendanhiggins@google.com,
        gregkh@linuxfoundation.org, john.ogness@linutronix.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, sergey.senozhatsky.work@gmail.com,
        tglx@linutronix.de, torvalds@linux-foundation.org
Subject: Re: [RFC PATCH v5 0/3] printk: new ringbuffer implementation
Date:   Fri,  6 Dec 2019 09:16:53 -0500
Message-Id: <20191206141653.1199-1-prarit@redhat.com>
In-Reply-To: <87zhg6zx31.fsf@linutronix.de>
References: <87zhg6zx31.fsf@linutronix.de>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: vhicXEh8O6CvUvqBmFTRSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  John Ogness <john.ogness@linutronix.de> wrote:
> Hi Prarit,
>=20
> On 2019-12-05, Prarit Bhargava <prarit@redhat.com> wrote:
> > Based on the comments there is going to be a v6 but in any case I am
> > starting testing of this patchset on several large core systems across
> > multiple architectures (x86_64, ARM64, s390, ppc64le).  Some of those
> > systems are known to fail boot due to the large amount of printk output=
 so
> > it will be good to see if these changes resolve those issues.
>=20
> Right now the patches only include the ringbuffer as a separate entity
> with a test module. So they do not yet have any effect on printk.
>=20
> If you apply the patches and then build the "modules" target, you will
> have a new test_prb.ko module. Loading that module will start some heavy
> testing of the ringbuffer. As long as the testing is successful, the
> module will keep testing. During this time the machine will be very
> slow, but should still respond.
>=20
> The test can be stopped by unloading the module. If the test stops on
> its own, then a problem was found. The output of the test is put into
> the ftrace buffer.
>=20
> It would be nice if you could run the test module on some fat machines,
> at least for a few minutes to see if anything explodes. ARM64 and
> ppc64le will probably be the most interesting, due to memory barrier
> testing.
>=20

I've run the module overnight on all 4 arches I mentioned above.  I didn't
see any failures but IIUC the module test runs at max.  I'm going to put a
load test on these systems that introduces a variable load to interfere
with the prbtest module to see if that kicks anything.

> Otherwise I will definitely be reaching out to you when we are ready to
> perform actual printk testing with the newly agreed up semantics
> (lockless, per-console printing threads, synchronous panic
> consoles). Thanks for your help with this.
>

np :) but I should be the one thanking you ;)

P.

> John Ogness

