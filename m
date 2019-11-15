Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA7AC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C609D20748
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ha4DEbaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfKOKtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:49:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46575 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726983AbfKOKtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573814958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2WZELhR2mEJomYhrXFHphMnsP0bhd8Y9CxfJQCgTBVA=;
        b=ha4DEbaO4HgsIX7pCvGLBJTsAkBZh3Lqv7hNp4CyEUPN6PIaxGfipszTCi3evOiFVJzOLh
        VpwTO99086ffIW+xqbtRWA1ZeMKyjPD/FfCvDfG8cxCwwYkTq6+I7vwZLYSYp7LC0CEJxX
        PBwjlvUntAwYVbVYBKlY6Ja7ziYfc4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-pf5Z2PPWPXeyXz7k8RXRdQ-1; Fri, 15 Nov 2019 05:49:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C66E1802CE0;
        Fri, 15 Nov 2019 10:49:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id C83C369185;
        Fri, 15 Nov 2019 10:49:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 15 Nov 2019 11:49:13 +0100 (CET)
Date:   Fri, 15 Nov 2019 11:49:10 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Andrei Vagin <avagin@gmail.com>, Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v10 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191115104909.GB25528@redhat.com>
References: <20191114142707.1608679-1-areber@redhat.com>
 <20191114191538.GC171963@gmail.com>
 <20191115093419.GA25528@redhat.com>
 <20191115095854.4vr6bgfz6ny5zbpd@wittgenstein>
MIME-Version: 1.0
In-Reply-To: <20191115095854.4vr6bgfz6ny5zbpd@wittgenstein>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: pf5Z2PPWPXeyXz7k8RXRdQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15, Christian Brauner wrote:
>
> +static int set_tid_next(pid_t *set_tid, size_t *size, int idx)
> +{
> +=09int tid =3D 0;
> +
> +=09if (*size) {
> +=09=09tid =3D set_tid[idx];
> +=09=09if (tid < 1 || tid >=3D pid_max)
> +=09=09=09return -EINVAL;
> +
> +=09=09/*
> +=09=09 * Also fail if a PID !=3D 1 is requested and
> +=09=09 * no PID 1 exists.
> +=09=09 */
> +=09=09if (tid !=3D 1 && !tmp->child_reaper)
> +=09=09=09return -EINVAL;
> +
> +=09=09if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
> +=09=09=09return -EPERM;
> +
> +=09=09(*size)--;
> +=09}

this needs more args, struct pid_namespace *tmp + pid_t pid_max

> +
> +=09return tid;
> +}
> +
>  struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  =09=09      size_t set_tid_size)
>  {
> @@ -188,20 +213,10 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid=
_t *set_tid,
>  =09for (i =3D ns->level; i >=3D 0; i--) {
>  =09=09int tid =3D 0;
> =20
> -=09=09if (set_tid_size) {
> -=09=09=09tid =3D set_tid[ns->level - i];
> -=09=09=09if (tid < 1 || tid >=3D pid_max)
> -=09=09=09=09return ERR_PTR(-EINVAL);
> -=09=09=09/*
> -=09=09=09 * Also fail if a PID !=3D 1 is requested and
> -=09=09=09 * no PID 1 exists.
> -=09=09=09 */
> -=09=09=09if (tid !=3D 1 && !tmp->child_reaper)
> -=09=09=09=09return ERR_PTR(-EINVAL);
> -=09=09=09if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
> -=09=09=09=09return ERR_PTR(-EPERM);
> -=09=09=09set_tid_size--;
> -=09=09}
> +=09=09retval =3D set_tid_next(set_tid, &set_tid_size, ns->level - i);
> +=09=09if (retval < 0)
> +=09=09=09goto out_free;
> +=09=09tid =3D retval;

Well, if we add a helper then

=09static inline int check_tid(tid, max, ns)
=09{
=09=09if (tid < 1 || tid >=3D max)
=09=09=09return ERR_PTR(-EINVAL);
=09=09/*
=09=09 * Also fail if a PID !=3D 1 is requested and
=09=09 * no PID 1 exists.
=09=09 */
=09=09if (tid !=3D 1 && !ns->child_reaper)
=09=09=09return ERR_PTR(-EINVAL);
=09=09if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
=09=09=09return ERR_PTR(-EPERM);
=09=09return 0;
=09}

=09... alloc_pid() ...

=09=09if (set_tid_size) {
=09=09=09tid =3D set_tid[ns->level - i];
=09=09=09retval =3D check_tid(tid, pid_max, tmp);
=09=09=09if (retval)
=09=09=09=09goto out_free;
=09=09=09set_tid_size--;
=09=09}

looks more clean to me. But still ugly. IMO,

=09=09if (set_tid_size) {
=09=09=09tid =3D set_tid[ns->level - i];

=09=09=09retval =3D -EINVAL;
=09=09=09if (tid < 1 || tid >=3D pid_max)
=09=09=09=09goto out_free;
=09=09=09/*
=09=09=09 * Also fail if a PID !=3D 1 is requested and
=09=09=09 * no PID 1 exists.
=09=09=09 */
=09=09=09if (tid !=3D 1 && !tmp->child_reaper)
=09=09=09=09goto out_free;
=09=09=09retval =3D -EPERM;
=09=09=09if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
=09=09=09=09goto out_free;
=09=09=09set_tid_size--;
=09=09}

makes more sense.

Oleg.

