Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A434C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C5C20715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yh+UhUkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfKNIWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:22:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50726 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725920AbfKNIWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573719741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+gjoRZFd9fcf4fNPEnFiVwdYJ8OpN8yWTmi0PkOyr8=;
        b=Yh+UhUkYOPUhtLaOirzb2OeF2Iaourvimo8BqPo6aPrq4jO7XOL9YkaIflkJzPm3mx2w1o
        sGb/IUzzQh5lzASvDldLvARRjDreL6Zk6xXmQwnM5+kt25jzZVhMBj54XhYf/lyNM1s4KQ
        YtrLsj+y5Kh17tP8miXlx57EEV10BfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-VpzJs5T0NkeKq_Cdh5Fzcw-1; Thu, 14 Nov 2019 03:22:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D5EE107ACC9;
        Thu, 14 Nov 2019 08:22:16 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 99C4F6FDDF;
        Thu, 14 Nov 2019 08:22:11 +0000 (UTC)
Date:   Thu, 14 Nov 2019 09:22:09 +0100
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v9 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191114082209.GE1252861@dcbz.redhat.com>
References: <20191114070709.1504202-1-areber@redhat.com>
 <20191114081359.axnoioa25grf3ffv@wittgenstein>
MIME-Version: 1.0
In-Reply-To: <20191114081359.axnoioa25grf3ffv@wittgenstein>
X-Operating-System: Linux (5.3.8-300.fc31.x86_64)
X-Load-Average: 1.11 1.35 1.24
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
Organization: Red Hat
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: VpzJs5T0NkeKq_Cdh5Fzcw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 09:14:00AM +0100, Christian Brauner wrote:
> On Thu, Nov 14, 2019 at 08:07:08AM +0100, Adrian Reber wrote:
> >   * The structure is versioned by size and thus extensible.
> >   * New struct members must go at the end of the struct and
> > @@ -71,6 +85,8 @@ struct clone_args {
> >  =09__aligned_u64 stack;
> >  =09__aligned_u64 stack_size;
> >  =09__aligned_u64 tls;
> > +=09__aligned_u64 set_tid;
> > +=09__aligned_u64 set_tid_size;
>=20
> Oh, one thing that is missing is the addition of
>=20
> +#define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
>=20
> in sched.h. Please add that, when you resend.

Even if it is unused?

=09=09Adrian

