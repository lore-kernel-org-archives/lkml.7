Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E20C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE62214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H47Jvw5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfKMICj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:02:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36611 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725996AbfKMICj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573632158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JGmgaddr7lKKt/ylf5c//1s3h7Y5K+L1ZfhRWk4daXU=;
        b=H47Jvw5GRWjINu55aaqMkPpbSuwTuNvwdCxZXR6I+ZN95HskWyoQ5XC4B0IdzmnUk84oB+
        oawz96c+MPqzbL/+pRb9qe8GtZcfVIFDc4KtQ3UYmjlcofpDseUMsCnQC0crGCtEqD1dyy
        wPegAMWrr6lCnuhYsZy2anxMBt0gyWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-W_Xftwb7MeuZrv9730J7wQ-1; Wed, 13 Nov 2019 03:02:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 897938025A1;
        Wed, 13 Nov 2019 08:02:30 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 36C0E5D9E5;
        Wed, 13 Nov 2019 08:02:27 +0000 (UTC)
Date:   Wed, 13 Nov 2019 09:02:25 +0100
From:   Adrian Reber <areber@redhat.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v7 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191113080225.GA1028126@dcbz.redhat.com>
References: <20191111131704.656169-1-areber@redhat.com>
 <cc5f90b6-ea1f-dbdb-e713-cc0fceceafbe@rasmusvillemoes.dk>
MIME-Version: 1.0
In-Reply-To: <cc5f90b6-ea1f-dbdb-e713-cc0fceceafbe@rasmusvillemoes.dk>
X-Operating-System: Linux (5.3.8-300.fc31.x86_64)
X-Load-Average: 3.10 2.24 1.75
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
Organization: Red Hat
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: W_Xftwb7MeuZrv9730J7wQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 09:41:39PM +0100, Rasmus Villemoes wrote:
> On 11/11/2019 14.17, Adrian Reber wrote:
> > The main motivation to add set_tid to clone3() is CRIU.
> >=20
> > To restore a process with the same PID/TID CRIU currently uses
> > /proc/sys/kernel/ns_last_pid. It writes the desired (PID - 1) to
> > ns_last_pid and then (quickly) does a clone(). This works most of the
> > time, but it is racy. It is also slow as it requires multiple syscalls.
> >=20
> > Extending clone3() to support *set_tid makes it possible restore a
> > process using CRIU without accessing /proc/sys/kernel/ns_last_pid and
> > race free (as long as the desired PID/TID is available).
> >=20
> > This clone3() extension places the same restrictions (CAP_SYS_ADMIN)
> > on clone3() with *set_tid as they are currently in place for ns_last_pi=
d.
> >=20
> > The original version of this change was using a single value for
> > set_tid. At the 2019 LPC, after presenting set_tid, it was, however,
> > decided to change set_tid to an array to enable setting the PID of a
> > process in multiple PID namespaces at the same time. If a process is
> > created in a PID namespace it is possible to influence the PID inside
> > and outside of the PID namespace. Details also in the corresponding
> > selftest.
> >=20
>=20
> >  =09/*
> >  =09 * Verify that higher 32bits of exit_signal are unset and that
> >  =09 * it is a valid signal
> > @@ -2556,8 +2561,17 @@ noinline static int copy_clone_args_from_user(st=
ruct kernel_clone_args *kargs,
> >  =09=09.stack=09=09=3D args.stack,
> >  =09=09.stack_size=09=3D args.stack_size,
> >  =09=09.tls=09=09=3D args.tls,
> > +=09=09.set_tid=09=3D kargs->set_tid,
> > +=09=09.set_tid_size=09=3D args.set_tid_size,
> >  =09};
>=20
> This is a bit ugly. And is it even well-defined? I mean, it's a bit
> similar to the "i =3D i++;". So it would be best to avoid.
>=20
> > +=09for (i =3D 0; i < args.set_tid_size; i++) {
> > +=09=09if (copy_from_user(&kargs->set_tid[i],
> > +=09=09    u64_to_user_ptr(args.set_tid + (i * sizeof(args.set_tid))),
> > +=09=09    sizeof(pid_t)))
> > +=09=09=09return -EFAULT;
> > +=09}
> > +
>=20
> If I'm reading this (and your test case) right, you expect the user
> pointer to point at an array of u64, and here you're copying the first
> half of each u64 to the pid_t array. That only works on little-endian.
>=20
> It seems more obvious (since I don't think there's any disagreement
> anywhere on sizeof(pid_t)) to expect the user pointer to point at an
> array of pid_t and then simply copy_from_user() the whole thing in one go=
.

Yes, that was wrong. I changed the test case to use an array of pid_t.

=09=09Adrian

