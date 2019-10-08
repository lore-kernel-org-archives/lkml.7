Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F73ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5122070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXH+3AnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfJHNAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:00:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57847 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730827AbfJHNAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570539632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=25SGDAhtAVwMxgYBLJztMuhf8UXGP63ScuWL8gNPwyY=;
        b=NXH+3AnYZT7WFKonCnSWyW49FxiXJiOQyESdgQsGbf/V8l3axMMCjyOTtwkEENWB0uu0cV
        rQ77DNkg1mbfonOooYoBvSZfB90Naz8nymUkj94a2Usaiy0tVSGMSZprctG9m1ffJ4qm/b
        8XA02TSq+b4TVPAZOl3O9oeQ7NROcZU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-zxEmyGyKOFql6fstFQ0Uxg-1; Tue, 08 Oct 2019 09:00:28 -0400
Received: by mail-wm1-f72.google.com with SMTP id g67so954139wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 06:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lgFAVfH4gHJ873MMlUdQpwbkdKDcdf8fglwECqOAC/A=;
        b=qE0CbzE87H+kqLRXg8Sp9T3jZWqbUNqZixr1fsL9KLFuR+BrDdUlKmzcFgJVDjmSNG
         fAtdBSGXHxQCZVioOUUPTIeoe08fFq2f0sYXatAMvYl7+NT9viT2PiCHHO8eKC7ye6w4
         fAmXpl+51qZ78sZV8ueq6DsoxUfLVLSrq0TzmVBdC0+ds9oofhJiI5Ox/sTgTxqdsaQF
         6RhqBhatIr6F0ev/GgoKQvC142l2SdSfk7mdzAOs2uKO1ZgN1JH7iAacPec3zY5QEC/N
         GpUT751V0Fv3TQyo93MZZGFsVayobCHOZuYBfB8GzAYTvSD/AlVSOQTU3gRtvmY1X0n3
         f4ew==
X-Gm-Message-State: APjAAAWcMVRr5b8MLuMl5jWLmmWGPjX7ajfPrlafVQvmlaHW4NafhOr2
        qwkJOnHuKIsaED0GfC5QsJZZdlwKA9DyJ+ZjytPVIyAhL+ImlM04WlzbdWYuit09CU9XV+WpOqG
        wE9K9rs41Y8L0c+CEAXt21Qa1
X-Received: by 2002:a5d:620e:: with SMTP id y14mr2743096wru.337.1570539627458;
        Tue, 08 Oct 2019 06:00:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwKyQmxQY7wc1q8P+7MLUsSSqE5z4zZJqx7BcDykmc3jhMv5OuucnZNr4xwuT8fxXLxhUSlDg==
X-Received: by 2002:a5d:620e:: with SMTP id y14mr2743081wru.337.1570539627206;
        Tue, 08 Oct 2019 06:00:27 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x5sm32090752wrg.69.2019.10.08.06.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 06:00:26 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 1/2] Drivers: hv: vmbus: Introduce table of VMBus protocol versions
In-Reply-To: <20191008124052.GA11245@andrea.guest.corp.microsoft.com>
References: <20191007163115.26197-1-parri.andrea@gmail.com> <20191007163115.26197-2-parri.andrea@gmail.com> <87eezo1nrr.fsf@vitty.brq.redhat.com> <20191008124052.GA11245@andrea.guest.corp.microsoft.com>
Date:   Tue, 08 Oct 2019 15:00:25 +0200
Message-ID: <87zhibz91y.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: zxEmyGyKOFql6fstFQ0Uxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Parri <parri.andrea@gmail.com> writes:

>> > @@ -244,21 +234,18 @@ int vmbus_connect(void)
>> >  =09 * version.
>> >  =09 */
>> > =20
>> > -=09version =3D VERSION_CURRENT;
>> > +=09for (i =3D 0; ; i++) {
>> > +=09=09version =3D vmbus_versions[i];
>> > +=09=09if (version =3D=3D VERSION_INVAL)
>> > +=09=09=09goto cleanup;
>>=20
>> If you use e.g. ARRAY_SIZE() you can get rid of VERSION_INVAL - and make
>> this code look more natural.
>
> Thank you for pointing this out, Vitaly.
>
> IIUC, you're suggesting that I do:
>
> =09for (i =3D 0; i < ARRAY_SIZE(vmbus_versions); i++) {
> =09=09version =3D vmbus_versions[i];
>
> =09=09ret =3D vmbus_negotiate_version(msginfo, version);
> =09=09if (ret =3D=3D -ETIMEDOUT)
> =09=09=09goto cleanup;
>
> =09=09if (vmbus_connection.conn_state =3D=3D CONNECTED)
> =09=09=09break;
> =09}
>
> =09if (vmbus_connection.conn_state !=3D CONNECTED)
> =09=09break;
>
> and that I remove VERSION_INVAL from vmbus_versions, yes?
>

Yes, something like that.

> Looking at the uses of VERSION_INVAL, I find one remaining occurrence
> of this macro in vmbus_bus_resume(), which does:
>
> =09if (vmbus_proto_version =3D=3D VERSION_INVAL ||
> =09    vmbus_proto_version =3D=3D 0) {
> =09=09...
> =09}
>
> TBH I'm looking at vmbus_bus_resume() and vmbus_bus_suspend() for the
> first time and I'm not sure about how to change such check yet... any
> suggestions?

Hm, I don't think vmbus_proto_version can ever become =3D=3D VERSION_INVAL
if we rewrite the code the way you suggest, right? So you'll reduce this
to 'if (!vmbus_proto_version)' meaning we haven't negotiated any version
(yet).

>
> Mmh, I see that vmbus_bus_resume() and vmbus_bus_suspend() can access
> vmbus_connection.conn_state: can such accesses race with a concurrent
> vmbus_connect()?

Let's summon Dexuan who's the author! :-)=20

>
> Thanks,
>   Andrea
>
>
>> > =20
>> > -=09do {
>> >  =09=09ret =3D vmbus_negotiate_version(msginfo, version);
>> >  =09=09if (ret =3D=3D -ETIMEDOUT)
>> >  =09=09=09goto cleanup;
>> > =20
>> >  =09=09if (vmbus_connection.conn_state =3D=3D CONNECTED)
>> >  =09=09=09break;
>> > -
>> > -=09=09version =3D vmbus_get_next_version(version);
>> > -=09} while (version !=3D VERSION_INVAL);
>> > -
>> > -=09if (version =3D=3D VERSION_INVAL)
>> > -=09=09goto cleanup;
>> > +=09}
>> > =20
>> >  =09vmbus_proto_version =3D version;
>> >  =09pr_info("Vmbus version:%d.%d\n",

--=20
Vitaly

