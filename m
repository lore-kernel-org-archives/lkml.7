Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7D0C17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4207F22459
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1bRV0hG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfKMNmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:42:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20321 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726434AbfKMNmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573652536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JgU2e8RT59hEaQw/a6iawkjHzbdgc0u0v1JZhhfT5kU=;
        b=U1bRV0hGlhzyn7KIa2MD0bWHh1j91mybyLpqcIIFndulbD3A4AEbf1yDiuyM6FUfdejAsw
        mPa/quPq2dzOQtcJFyNnByi1IND5L/ESWTOiRm6bfK6iwfh+0+AfOFhqN0mHXGFm9V1ftV
        jDl7+cHeo1QjKfMMIL6rWFmhB9ouUvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-nY7xI--DNa61pN8DDiLq6g-1; Wed, 13 Nov 2019 08:42:13 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D08391852E20;
        Wed, 13 Nov 2019 13:42:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id BD3972B7C5;
        Wed, 13 Nov 2019 13:42:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 13 Nov 2019 14:42:09 +0100 (CET)
Date:   Wed, 13 Nov 2019 14:42:06 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v8 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191113134206.GA4320@redhat.com>
References: <20191113080301.1197762-1-areber@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191113080301.1197762-1-areber@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: nY7xI--DNa61pN8DDiLq6g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13, Adrian Reber wrote:
>
> @@ -175,23 +187,47 @@ struct pid *alloc_pid(struct pid_namespace *ns)
> =20
>  =09for (i =3D ns->level; i >=3D 0; i--) {
>  =09=09int pid_min =3D 1;

Well, this is really minor but again, pid_min is only used in the "else"
branch below, you can move this declaration there.

> +
> +=09=09if (set_tid_size) {
> +=09=09=09tid =3D set_tid[ns->level - i];
> +=09=09=09if (tid < 1 || tid >=3D pid_max)
> +=09=09=09=09return ERR_PTR(-EINVAL);
> +=09=09=09/* Also fail if a PID !=3D 1 is requested and no PID 1 exists *=
/
> +=09=09=09if (tid !=3D 1 && !tmp->child_reaper)
> +=09=09=09=09return ERR_PTR(-EINVAL);
> +=09=09=09if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
> +=09=09=09=09return ERR_PTR(-EPERM);
> +=09=09}
> =20
>  =09=09idr_preload(GFP_KERNEL);
>  =09=09spin_lock_irq(&pidmap_lock);
> =20
> -=09=09/*
> -=09=09 * init really needs pid 1, but after reaching the maximum
> -=09=09 * wrap back to RESERVED_PIDS
> -=09=09 */
> -=09=09if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
> -=09=09=09pid_min =3D RESERVED_PIDS;
> -
> -=09=09/*
> -=09=09 * Store a null pointer so find_pid_ns does not find
> -=09=09 * a partially initialized PID (see below).
> -=09=09 */
> -=09=09nr =3D idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
> -=09=09=09=09      pid_max, GFP_ATOMIC);
> +=09=09if (tid) {
> +=09=09=09nr =3D idr_alloc(&tmp->idr, NULL, tid,
> +=09=09=09=09       tid + 1, GFP_ATOMIC);
> +=09=09=09/*
> +=09=09=09 * If ENOSPC is returned it means that the PID is
> +=09=09=09 * alreay in use. Return EEXIST in that case.
> +=09=09=09 */
> +=09=09=09if (nr =3D=3D -ENOSPC)
> +=09=09=09=09nr =3D -EEXIST;
> +=09=09=09set_tid_size--;
                        ^^^^^^^^^^^^^^^
May I ask you to move this decrement into the "if (set_tid_size)" block abo=
ve?

Oleg.

