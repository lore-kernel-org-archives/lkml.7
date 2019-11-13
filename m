Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80160C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D52222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bP02yBDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfKMNvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:51:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20459 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726957AbfKMNvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573653075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I49FNaB31Xym/1989jEGjQsxSSpOY1GJbdRrHOQtTFg=;
        b=bP02yBDH14GS59BXMp8LtszkANtMw6qTuB6j1+QRifAgRCA2vdSvTRjU6P3HOrfGiUHrU0
        +Q4SzZ0/wPH6OmpM4oRergH1tNvBf4b8fWaiaZgtM11R76AngizLjNslTYr1RcgeI/Fnyu
        /BOGQgXvBbAjodb2hnF6rwYHEaWriE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-jlrzj_9NMJ-s1OhMBC6-uw-1; Wed, 13 Nov 2019 08:51:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DC91B4144;
        Wed, 13 Nov 2019 13:51:10 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91ED84D9E1;
        Wed, 13 Nov 2019 13:51:09 +0000 (UTC)
Subject: Re: [PATCH 1/1] kernel/module.c: wakeup processes in module_wq on
 module unload
To:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jessica Yu <jeyu@kernel.org>, Barret Rhoden <brho@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-kernel@vger.kernel.org, David Arcari <darcari@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
References: <20191113092950.15556-1-khorenko@virtuozzo.com>
 <20191113092950.15556-2-khorenko@virtuozzo.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <1b047b83-e6cd-9c56-9c55-a2ef6a3e16f5@redhat.com>
Date:   Wed, 13 Nov 2019 08:51:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191113092950.15556-2-khorenko@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: jlrzj_9NMJ-s1OhMBC6-uw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/19 4:29 AM, Konstantin Khorenko wrote:
> Fix the race between load and unload a kernel module.
>=20
> sys_delete_module()
>  try_stop_module()
>   mod->state =3D _GOING
> =09=09=09=09=09add_unformed_module()
> =09=09=09=09=09 old =3D find_module_all()
> =09=09=09=09=09 (old->state =3D=3D _GOING =3D>
> =09=09=09=09=09  wait_event_interruptible())
>=20
> =09=09=09=09=09 During pre-condition
> =09=09=09=09=09 finished_loading() rets 0
> =09=09=09=09=09 schedule()
> =09=09=09=09=09 (never gets waken up later)
>  free_module()
>   mod->state =3D _UNFORMED
>    list_del_rcu(&mod->list)
>    (dels mod from "modules" list)
>=20
> return
>=20
> The race above leads to modprobe hanging forever on loading
> a module.
>=20
> Error paths on loading module call wake_up_all(&module_wq) after
> freeing module, so let's do the same on straight module unload.
>=20
> Fixes: 6e6de3dee51a ("kernel/module.c: Only return -EEXIST
> for modules that have finished loading")
>=20
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  kernel/module.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/kernel/module.c b/kernel/module.c
> index ff2d7359a418..cb09a5f37a5f 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -1033,6 +1033,8 @@ SYSCALL_DEFINE2(delete_module, const char __user *,=
 name_user,
>  =09strlcpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module)=
);
> =20
>  =09free_module(mod);
> +=09/* someone could wait for the module in add_unformed_module() */
> +=09wake_up_all(&module_wq);

free_module() acts on that *this* module so it makes sense to include the
wake_up_all(&module_wq) call in delete_module.  IIRC I did try a module loa=
d &
unload stress test but it looks like my testing wasn't hard enough :(

In any case,

Reviewed-by: Prarit Bhargava <prarit@redhat.com>

P.

>  =09return 0;
>  out:
>  =09mutex_unlock(&module_mutex);
>=20

