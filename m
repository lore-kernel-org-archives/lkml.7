Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A051CC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7382B21A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zw7ktJVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfKEPhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:37:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35161 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727779AbfKEPhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572968261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=llQqP/MIKLwYmmOq7Ay07ojdKO0cDkSl+N2wZY18JQY=;
        b=Zw7ktJVt/mVElyzinUqSP7Hmrkc/caqlJc2jCV4MLD5CfA1cI43NaV7ckGT2bkjW0MwoOU
        QcPIfUeDapg4K9cUdYvTl9jOUQP2yTIqFP6JgZiOy0pCezCML2932U8kvjYJkWur1nu1ZM
        83VrmfODLUAnohSc6rjsC280bqt3zVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-N41daoeQO8a46iXCKb8-vw-1; Tue, 05 Nov 2019 10:37:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 193C6477;
        Tue,  5 Nov 2019 15:37:36 +0000 (UTC)
Received: from mail (ovpn-121-157.rdu2.redhat.com [10.10.121.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C8676608B4;
        Tue,  5 Nov 2019 15:37:35 +0000 (UTC)
Date:   Tue, 5 Nov 2019 10:37:35 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Tim Murray <timmurray@google.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for
 UFFD_FEATURE_EVENT_FORK
Message-ID: <20191105153735.GF30717@redhat.com>
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1572967777-8812-2-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: N41daoeQO8a46iXCKb8-vw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

On Tue, Nov 05, 2019 at 05:29:37PM +0200, Mike Rapoport wrote:
> Current implementation of UFFD_FEATURE_EVENT_FORK modifies the file
> descriptor table from the read() implementation of uffd, which may have
> security implications for unprivileged use of the userfaultfd.
>=20
> Limit availability of UFFD_FEATURE_EVENT_FORK only for callers that have
> CAP_SYS_PTRACE.
>=20
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  fs/userfaultfd.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index f9fd18670e22..d99d166fd892 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1834,13 +1834,12 @@ static int userfaultfd_api(struct userfaultfd_ctx=
 *ctx,
>  =09if (copy_from_user(&uffdio_api, buf, sizeof(uffdio_api)))
>  =09=09goto out;
>  =09features =3D uffdio_api.features;
> -=09if (uffdio_api.api !=3D UFFD_API || (features & ~UFFD_API_FEATURES)) =
{
> -=09=09memset(&uffdio_api, 0, sizeof(uffdio_api));
> -=09=09if (copy_to_user(buf, &uffdio_api, sizeof(uffdio_api)))
> -=09=09=09goto out;
> -=09=09ret =3D -EINVAL;
> -=09=09goto out;
> -=09}
> +=09ret =3D -EINVAL;
> +=09if (uffdio_api.api !=3D UFFD_API || (features & ~UFFD_API_FEATURES))
> +=09=09goto err_out;
> +=09ret =3D -EPERM;
> +=09if ((features & UFFD_FEATURE_EVENT_FORK) && !capable(CAP_SYS_PTRACE))
> +=09=09goto err_out;
>  =09/* report all available features and ioctls to userland */
>  =09uffdio_api.features =3D UFFD_API_FEATURES;
>  =09uffdio_api.ioctls =3D UFFD_API_IOCTLS;
> @@ -1853,6 +1852,11 @@ static int userfaultfd_api(struct userfaultfd_ctx =
*ctx,
>  =09ret =3D 0;
>  out:
>  =09return ret;
> +err_out:
> +=09memset(&uffdio_api, 0, sizeof(uffdio_api));
> +=09if (copy_to_user(buf, &uffdio_api, sizeof(uffdio_api)))
> +=09=09ret =3D -EFAULT;
> +=09goto out;
>  }
> =20
>  static long userfaultfd_ioctl(struct file *file, unsigned cmd,

Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>

Thanks,
Andrea

