Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5709C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A74D20733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWe3Om0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfKOPOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:14:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40681 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727429AbfKOPOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573830870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRI7hzbYQQAGOZWSyPBQQ1xIiuvBL9bck/KjwaW/r+Y=;
        b=FWe3Om0jSLWTKovYOcI3IIlHe943GK6KXQ26+/GmS0ywuN8CrsPsbnmEeBX0mZhTobjV5v
        5IKZ1LyEZjM4u/kp31d/AgDyXsJ87cW6opZJHn/In1y7Xt5KxiQpfr0hqQfcXkv7BCW4/O
        RZ+T+XnNdaVRXcu6X6XKvlV4hplmSoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-yaz7qSmkOgSx8zd1Rsx6iQ-1; Fri, 15 Nov 2019 10:14:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 063CC8EF717;
        Fri, 15 Nov 2019 15:14:25 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-116-116.ams2.redhat.com [10.36.116.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D4CFA5C1B0;
        Fri, 15 Nov 2019 15:14:22 +0000 (UTC)
Date:   Fri, 15 Nov 2019 16:14:20 +0100
From:   Adrian Reber <areber@redhat.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v10 2/2] selftests: add tests for clone3() with *set_tid
Message-ID: <20191115151420.GC20767@dcbz.redhat.com>
References: <20191114142707.1608679-1-areber@redhat.com>
 <20191114142707.1608679-2-areber@redhat.com>
 <20191114183421.GA171963@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191114183421.GA171963@gmail.com>
X-Operating-System: Linux (5.3.11-300.fc31.x86_64)
X-Load-Average: 1.53 1.49 1.89
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
X-Url:  <http://lisas.de/~adrian/>
Organization: Red Hat
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: yaz7qSmkOgSx8zd1Rsx6iQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:34:21AM -0800, Andrei Vagin wrote:
> > +=09=09/*
> > +=09=09 * This should work and from the parent we should see
> > +=09=09 * something like 'NSpid:=09pid=0942=091'.
> > +=09=09 */
> > +=09=09test_clone3_set_tid(set_tid, 3, CLONE_NEWPID, 0, 42, true);
> > +
> > +=09=09_exit(ksft_cnt.ksft_pass);
> > +=09}
> > +
> > +=09close(pipe_1[1]);
> > +=09close(pipe_2[0]);
> > +=09while (read(pipe_1[0], &buf, 1) > 0) {
>=20
> If a child process will crash, this will be a busyloop.

No. To be honest the whole loop is unnecessary. If the loop is entered
there is immediately a break.

> > +=09=09ksft_print_msg("[%d] Child is ready and waiting\n", getpid());
> > +=09=09break;
> > +=09}

If the loop is not entered it does not loop. So the whole thing is
useless. I think I was expecting it to block, but it doesn't work that
way.

> > +=09snprintf(proc_path, sizeof(proc_path), "/proc/%d/status", pid);
> > +=09f =3D fopen(proc_path, "r");
> > +=09if (f =3D=3D NULL)
> > +=09=09ksft_exit_fail_msg(
> > +=09=09=09"%s - Could not open %s\n",
> > +=09=09=09strerror(errno), proc_path);

If the child does not exist anymore, the test will fail here and exit.

Besides this while() I tried to address all your comments in v11. Any
further comments on the test?

=09=09Adrian

