Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA190CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9994214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Suol0hHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfJUNrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:47:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25792 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728083AbfJUNrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571665629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rO/O10MdAqoNhorXBny5B06tfBtdVmzTbFkBdZmSP0=;
        b=Suol0hHwnaUwaFkCA7s2RO64mT/qhfui0zPBaYrVp2rqU7Q49ojJO3VKyxBq1dX5qvDaxg
        rJfzNlYEk0SFnylRC/Y6y4O5vOHHzkTy1JK+UlHpmUQPRt/jIpFQ3JXcxsnU0lcEJ2jvuI
        qZS/en1BsfY37pwllrJp48k1A7hZ4As=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-sQlMYvpEPQusM1aD1O9A0A-1; Mon, 21 Oct 2019 09:47:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD173800D41;
        Mon, 21 Oct 2019 13:47:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 711855C207;
        Mon, 21 Oct 2019 13:47:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 21 Oct 2019 15:47:03 +0200 (CEST)
Date:   Mon, 21 Oct 2019 15:47:00 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Marco Elver <elver@google.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        syzbot <syzbot+492a4acccd8fc75ddfd0@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, christian@brauner.io,
        deepa.kernel@gmail.com, ebiederm@xmission.com, guro@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Will Deacon <will@kernel.org>
Subject: Re: KCSAN: data-race in exit_signals / prepare_signal
Message-ID: <20191021134659.GA1339@redhat.com>
References: <0000000000003b1e8005956939f1@google.com>
 <20191021111920.frmc3njkha4c3a72@wittgenstein>
 <20191021120029.GA24935@redhat.com>
 <CANpmjNMfCK99DoUuR2qRBTLLhrGsYVcpKdtXW7S559tNJ-MO7A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANpmjNMfCK99DoUuR2qRBTLLhrGsYVcpKdtXW7S559tNJ-MO7A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: sQlMYvpEPQusM1aD1O9A0A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21, Marco Elver wrote:
>
> On Mon, 21 Oct 2019 at 14:00, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > I think this is WONTFIX.
>
> If taking the spinlock is unnecessary (which AFAIK it probably is) and
> there are no other writers to this flag, you will still need a
> WRITE_ONCE(tsk->flags, tsk->flags | PF_EXITING) to avoid the
> data-race.

Or even WRITE_ONCE(tsk->flags, READ_ONCE(tsk->flags) | PF_EXITING) in
theory. But in practice, I do not think compiler can turn

=09curent->flags |=3D PF_EXITING;

into something which temporary clears another flag, say, PF_KTHREAD.

> However, if it is possible that there are concurrent writers setting
> other bits in flags,

No, only current taks should change its ->flags.

Oleg.

