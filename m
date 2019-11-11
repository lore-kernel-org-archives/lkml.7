Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A34CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62562222C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLDB6akg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKKPkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:40:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34153 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726845AbfKKPkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573486840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WE2qSoaU6rMv77NUdEk+fYAcqsHv/qRqfECvV2K4njU=;
        b=GLDB6akgbe16cbkcoKbuYnH4Es9+CnrzaoDoT3Tq2+AVu/ntTqE9lbVRn8zmJ28+fLiShS
        0MOhlAB7F2tmlRt7hkYfpq0NuzkXwYB8NeowOr0xZJEMXcmqqH5P0LQLz7CC4KgDN5N6x2
        qFaCFkjbwGWyu6y+PfCz0raK3RrKm90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-lTx-VP4UPU2sPnhSdZ3KzQ-1; Mon, 11 Nov 2019 10:40:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2E9ADB60;
        Mon, 11 Nov 2019 15:40:35 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88B9449AF;
        Mon, 11 Nov 2019 15:40:30 +0000 (UTC)
Date:   Mon, 11 Nov 2019 16:40:28 +0100
From:   Adrian Reber <areber@redhat.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v7 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191111154028.GF514519@dcbz.redhat.com>
References: <20191111131704.656169-1-areber@redhat.com>
 <20191111152514.GA11389@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191111152514.GA11389@redhat.com>
X-Operating-System: Linux (5.3.8-300.fc31.x86_64)
X-Load-Average: 1.08 1.12 1.23
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
Organization: Red Hat
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: lTx-VP4UPU2sPnhSdZ3KzQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 04:25:15PM +0100, Oleg Nesterov wrote:
> On 11/11, Adrian Reber wrote:
> >
> > v7:
> >  - changed set_tid to be an array to set the PID of a process
> >    in multiple nested PID namespaces at the same time as discussed
> >    at LPC 2019 (container MC)
>=20
> cough... iirc you convinced me this is not needed when we discussed
> the previous version ;) Nevermind, probably my memory fools me.

You are right. You suggested the same thing and we didn't listen ;)

> So far I only have some cosmetic nits,

Thanks for the quick review. I will try to apply your suggestions.

> > @@ -175,6 +187,18 @@ struct pid *alloc_pid(struct pid_namespace *ns)
> >
> >  =09for (i =3D ns->level; i >=3D 0; i--) {
> >  =09=09int pid_min =3D 1;
> > +=09=09int t_pos =3D 0;
>                     ^^^^^
>=20
> I won't insist, but I'd suggest to cache set_tid[t_pos] instead to make
> the code a bit more simple.
>=20
> > @@ -186,12 +210,24 @@ struct pid *alloc_pid(struct pid_namespace *ns)
> >  =09=09if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
> >  =09=09=09pid_min =3D RESERVED_PIDS;
>=20
> You can probably move this code into the "else" branch below.
>=20
> IOW, something like
>=20
>=20
> =09for (i =3D ns->level; i >=3D 0; i--) {
> =09=09int xxx =3D 0;
>=20
> =09=09if (set_tid_size) {
> =09=09=09int pos =3D ns->level - i;
>=20
> =09=09=09xxx =3D set_tid[pos];
> =09=09=09if (xxx < 1 || xxx >=3D pid_max)
> =09=09=09=09return ERR_PTR(-EINVAL);
> =09=09=09/* Also fail if a PID !=3D 1 is requested and no PID 1 exists */
> =09=09=09if (xxx !=3D 1 && !tmp->child_reaper)
> =09=09=09=09return ERR_PTR(-EINVAL);
> =09=09=09if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
> =09=09=09=09return ERR_PTR(-EPERM);
> =09=09=09set_tid_size--;
> =09=09}
>=20
> =09=09idr_preload(GFP_KERNEL);
> =09=09spin_lock_irq(&pidmap_lock);
>=20
> =09=09if (xxx) {
> =09=09=09nr =3D idr_alloc(&tmp->idr, NULL, xxx, xxx + 1,
> =09=09=09=09=09GFP_ATOMIC);
> =09=09=09/*
> =09=09=09 * If ENOSPC is returned it means that the PID is
> =09=09=09 * alreay in use. Return EEXIST in that case.
> =09=09=09 */
> =09=09=09if (nr =3D=3D -ENOSPC)
> =09=09=09=09nr =3D -EEXIST;
> =09=09} else {
> =09=09=09int pid_min =3D 1;
> =09=09=09/*
> =09=09=09 * init really needs pid 1, but after reaching the
> =09=09=09 * maximum wrap back to RESERVED_PIDS
> =09=09=09 */
> =09=09=09if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
> =09=09=09=09pid_min =3D RESERVED_PIDS;
> =09=09=09/*
> =09=09=09 * Store a null pointer so find_pid_ns does not find
> =09=09=09 * a partially initialized PID (see below).
> =09=09=09 */
> =09=09=09nr =3D idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
> =09=09=09=09=09      pid_max, GFP_ATOMIC);
> =09=09}
>=20
> =09=09...
>=20
> This way only the "if (set_tid_size)" block has to play with set_tid_size=
/set_tid.
>=20
> note also that this way we can easily allow set_tid[some_level] =3D=3D 0,=
 we can
> simply do
>=20
> =09-=09if (xxx < 1 || xxx >=3D pid_max)
> =09+=09if (xxx < 0 || xxx >=3D pid_max)
>=20
> although I don't think this is really useful.

Yes. I explicitly didn't allow 0 as a PID as I didn't thought it would
be useful (or maybe even valid).

=09=09Adrian

