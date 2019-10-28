Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA1DCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CB3208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGbD6zck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403915AbfJ1QtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:49:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47737 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730420AbfJ1QtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572281342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zC96JpHgiS+yZo6jp/+Ia31ekU5q3/EGbvHcijytztM=;
        b=eGbD6zckccL/Vn1Qxwrza4SbViFGsjyuRmCrWfKmtG/NSX2b7cH1U+s/BgQ0v6G3KfCHON
        Q/FbrQSFYjCw+kidG86cc+IKA6t4hXo9DPt5FeKA3Uq8jRc9lROzMeD79HnKFM5P0uru0k
        9N0nsVsbpuzXXZcPMKkhrDk+UK0DulU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-dK_ryb4OOTOoglGiyims9w-1; Mon, 28 Oct 2019 12:48:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 345DD8017DD;
        Mon, 28 Oct 2019 16:48:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9FA515D6AE;
        Mon, 28 Oct 2019 16:48:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 28 Oct 2019 17:48:55 +0100 (CET)
Date:   Mon, 28 Oct 2019 17:48:52 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     dvyukov@google.com, ebiederm@xmission.com, elver@google.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH cgroup/for-5.5] cgroup: remove
 cgroup_enable_task_cg_lists() optimization
Message-ID: <20191028164852.GA17900@redhat.com>
References: <0000000000003b1e8005956939f1@google.com>
 <20191021142111.GB1339@redhat.com>
 <20191024190351.GD3622521@devbig004.ftw2.facebook.com>
 <20191025125606.GI3622521@devbig004.ftw2.facebook.com>
 <20191025133358.pxpzxkhqc3mboi5x@wittgenstein>
 <20191025141325.GB6020@redhat.com>
 <20191025143224.wtwkkimqq4644iqq@wittgenstein>
 <20191025155224.GC6020@redhat.com>
 <20191025170523.u43rkulrui22ynix@wittgenstein>
MIME-Version: 1.0
In-Reply-To: <20191025170523.u43rkulrui22ynix@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: dK_ryb4OOTOoglGiyims9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25, Christian Brauner wrote:
>
> On Fri, Oct 25, 2019 at 05:52:25PM +0200, Oleg Nesterov wrote:
> > On 10/25, Christian Brauner wrote:
> > >
> > > On Fri, Oct 25, 2019 at 04:13:25PM +0200, Oleg Nesterov wrote:
> > > > Almost every usage of task->flags (load or sore) can be reported as=
 "data race".
> > > >
> > > > Say, you do
> > > >
> > > > =09if (task->flags & PF_KTHREAD)
> > > >
> > > > while this task does
> > > >
> > > > =09current->flags |=3D PF_FREEZER_SKIP;
> > > > =09schedule().
> > > >
> > > > this is data race.
> > >
> > > Right, but I thought we agreed on WONTFIX in those scenarios?
> > > The alternative is to READ_ONCE()/WRITE_ONCE() all of these.
> >
> > Well, in my opinion this is WONTFIX, but I won't argue if someone
> > adds _ONCE to all of these. Same for task->state, exit_state, and
> > more.
>
> Well, I honestly think that state and exit_state would make sense.

Heh. Again, I am not arguing, but...

OK, lets suppose we blindly add READ_ONCE() to every access of
task->state/exit_state.

Yes, this won't hurt and possibly can fix some bugs we are not aware of.

However,

> There already were issues that got fixed for example in 3245d6acab98
> ("exit: fix race between wait_consider_task() and wait_task_zombie()")

The change above can't fix the problem like this.

It is not that this code lacked READ_ONCE(). I am sure me and others
understood that this code can read ->exit_state more than once, just
nobody noticed that in this case this is really wrong.

IOW, if we simply change the code before 3245d6acab98 to use READ_ONCE()
the code will be equally wrong, and

> and as far as I understand this would also help kcsan to better detect
> races.

this change will simply hide the problem from kcsan.

Oleg.

