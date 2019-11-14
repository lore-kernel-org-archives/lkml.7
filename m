Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4031DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A4420637
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tv9DlHVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKNPvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:51:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55092 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726852AbfKNPvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573746661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8E5cXowWr1O13DnEmVkHrlVMAGQPuBVPxrFRLhWJ1k=;
        b=Tv9DlHVkBehsR3KbbSZGChG7rtzju4ahFnjwEZIoup7UmftsF18/WY1ZVVr+eJxybx1xW8
        sL46Agu9xsy1TUaqKxvXaLb3CCqyEKcU6avm6cIDxxmx6s6Qm+Cy8pLJPXjqhXsgIoGI8K
        6KkZdzOa0FHB6p/TF9wz0hSbn3MASIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-1-d2r7wZMWmKVJxEHzlvuA-1; Thu, 14 Nov 2019 10:50:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5C218CA4D6;
        Thu, 14 Nov 2019 15:50:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id BD6406117F;
        Thu, 14 Nov 2019 15:50:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 14 Nov 2019 16:50:55 +0100 (CET)
Date:   Thu, 14 Nov 2019 16:50:52 +0100
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
Subject: Re: [PATCH v10 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191114155052.GA13149@redhat.com>
References: <20191114142707.1608679-1-areber@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191114142707.1608679-1-areber@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 1-d2r7wZMWmKVJxEHzlvuA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14, Adrian Reber wrote:
>
> @@ -2600,6 +2602,15 @@ noinline static int copy_clone_args_from_user(stru=
ct kernel_clone_args *kargs,
>  =09if (err)
>  =09=09return err;
>
> +=09if (unlikely(args.set_tid_size > MAX_PID_NS_LEVEL))
> +=09=09return -EINVAL;

so we need this to because copy_from_user() below writes into the
set_tid[MAX_PID_NS_LEVEL] on the caller's stack, then later alloc_pid()
does another "correct" check... We could simply shift that check here,
but probably this would be less clear, so I won't argue.

> @@ -2617,8 +2628,16 @@ noinline static int copy_clone_args_from_user(stru=
ct kernel_clone_args *kargs,
>  =09=09.stack=09=09=3D args.stack,
>  =09=09.stack_size=09=3D args.stack_size,
>  =09=09.tls=09=09=3D args.tls,
> +=09=09.set_tid_size=09=3D args.set_tid_size,
>  =09};
...
> +=09kargs->set_tid =3D kset_tid;

this looks a bit strange, you could simply do

=09=09.set_tid_size   =3D args.set_tid_size,
=09=09.set_tid=09=3D kset_tid,

but this is really minor.

Looks good to me,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

