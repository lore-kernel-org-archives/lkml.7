Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED23EC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA573206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEVz2VlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfJGROZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:14:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20598 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728028AbfJGROZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570468464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9PAQ2tFm+AtM3TzgFRHpTr4JMn+XXrxy7maVApAdIJM=;
        b=bEVz2VlLXhQanzhmne7q9S7FYgUur5yIENig584GRFXcpGZ7BrkVdF6y7yawOfaTS21e0P
        TYbULmobyPGIb1rVXDZgcTPElKCX4yqhzPgpPf0eJVm9GNl2c2sVAPdgFNeiYMrzKAjOBc
        Yv03dEPzvZRdLboLt1imDO+YB3/FuW0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-icFCO8TRMxS5yLVX6R40jQ-1; Mon, 07 Oct 2019 13:14:20 -0400
Received: by mail-wm1-f70.google.com with SMTP id n3so109529wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 10:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VGV18VA+AE3LfmjZMCSFNrwz/PRTgDak/4MGgvP+8ac=;
        b=RUDHd+PRoDbkAgXR8yZ9UIw9GuVsmmM9RY79g16GljzbZVvisPMwDPEpeiYv6T8UH+
         18Rd7UFsjXjm6Q/RSKXZ0Ce/0l3GdT3qvI+FZRjkfjgAxnSGrP5MvjdTSEikbZ6hc3Yv
         V+bsc4thhRTSPJhsi8PoIYdsGxiyIyM4/numimR8N8p74fdn4SnYyJUnY5r5EoA4u2jy
         0/cDj2ofqM3PRDT08mYLmWWTlXFJZAqLsksFh+2EnjF1VvbPi7PZwUWFyG3MP+8frDos
         ZYh7nbghtaD3rhTJEMahUPx8u2fA9z14OGVF92uMOMJmf/hPc9VJoNOwP0pnntZWkyPe
         Im9g==
X-Gm-Message-State: APjAAAUyl38zOOgnh0mPOixdrkZtki+h/5JI0aTmRT8SsdtD1/CgGFMq
        E0lnhWqnVz1x4rtRiQt9jkxVsfz8wiByZLDiOA0SUf72hsT7+WsMRyOzqWFKj1MX0OTJlxeUGRq
        8YLKVdyf2q7LSMMRMaPIZdk61
X-Received: by 2002:adf:8163:: with SMTP id 90mr19785219wrm.129.1570468458709;
        Mon, 07 Oct 2019 10:14:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyTsAKryRHUYEwNfXDnDTXesB2iGCqDbuGhIV1Lf/H5FCI4hmBIRgnrP9hPRrF/bojTQJsKHQ==
X-Received: by 2002:adf:8163:: with SMTP id 90mr19785200wrm.129.1570468458441;
        Mon, 07 Oct 2019 10:14:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y18sm40294127wro.36.2019.10.07.10.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 10:14:17 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andrea Parri <parri.andrea@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH 1/2] Drivers: hv: vmbus: Introduce table of VMBus protocol versions
In-Reply-To: <20191007163115.26197-2-parri.andrea@gmail.com>
References: <20191007163115.26197-1-parri.andrea@gmail.com> <20191007163115.26197-2-parri.andrea@gmail.com>
Date:   Mon, 07 Oct 2019 19:14:16 +0200
Message-ID: <87eezo1nrr.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: icFCO8TRMxS5yLVX6R40jQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Parri <parri.andrea@gmail.com> writes:

> The technique used to get the next VMBus version seems increasisly
> clumsy as the number of VMBus versions increases.  Performance is
> not a concern since this is only done once during system boot; it's
> just that we'll end up with more lines of code than is really needed.
>
> As an alternative, introduce a table with the version numbers listed
> in order (from the most recent to the oldest).  vmbus_connect() loops
> through the versions listed in the table until it gets an accepted
> connection or gets to the end of the table (invalid version).
>
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  drivers/hv/connection.c | 51 +++++++++++++++--------------------------
>  include/linux/hyperv.h  |  2 --
>  2 files changed, 19 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 6e4c015783ffc..90a32c9d79403 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -40,29 +40,19 @@ EXPORT_SYMBOL_GPL(vmbus_connection);
>  __u32 vmbus_proto_version;
>  EXPORT_SYMBOL_GPL(vmbus_proto_version);
> =20
> -static __u32 vmbus_get_next_version(__u32 current_version)
> -{
> -=09switch (current_version) {
> -=09case (VERSION_WIN7):
> -=09=09return VERSION_WS2008;
> -
> -=09case (VERSION_WIN8):
> -=09=09return VERSION_WIN7;
> -
> -=09case (VERSION_WIN8_1):
> -=09=09return VERSION_WIN8;
> -
> -=09case (VERSION_WIN10):
> -=09=09return VERSION_WIN8_1;
> -
> -=09case (VERSION_WIN10_V5):
> -=09=09return VERSION_WIN10;
> -
> -=09case (VERSION_WS2008):
> -=09default:
> -=09=09return VERSION_INVAL;
> -=09}
> -}
> +/*
> + * Table of VMBus versions listed from newest to oldest; the table
> + * must terminate with VERSION_INVAL.
> + */
> +__u32 vmbus_versions[] =3D {
> +=09VERSION_WIN10_V5,
> +=09VERSION_WIN10,
> +=09VERSION_WIN8_1,
> +=09VERSION_WIN8,
> +=09VERSION_WIN7,
> +=09VERSION_WS2008,
> +=09VERSION_INVAL
> +};
> =20
>  int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 v=
ersion)
>  {
> @@ -169,8 +159,8 @@ int vmbus_negotiate_version(struct vmbus_channel_msgi=
nfo *msginfo, u32 version)
>   */
>  int vmbus_connect(void)
>  {
> -=09int ret =3D 0;
>  =09struct vmbus_channel_msginfo *msginfo =3D NULL;
> +=09int i, ret =3D 0;
>  =09__u32 version;
> =20
>  =09/* Initialize the vmbus connection */
> @@ -244,21 +234,18 @@ int vmbus_connect(void)
>  =09 * version.
>  =09 */
> =20
> -=09version =3D VERSION_CURRENT;
> +=09for (i =3D 0; ; i++) {
> +=09=09version =3D vmbus_versions[i];
> +=09=09if (version =3D=3D VERSION_INVAL)
> +=09=09=09goto cleanup;

If you use e.g. ARRAY_SIZE() you can get rid of VERSION_INVAL - and make
this code look more natural.
> =20
> -=09do {
>  =09=09ret =3D vmbus_negotiate_version(msginfo, version);
>  =09=09if (ret =3D=3D -ETIMEDOUT)
>  =09=09=09goto cleanup;
> =20
>  =09=09if (vmbus_connection.conn_state =3D=3D CONNECTED)
>  =09=09=09break;
> -
> -=09=09version =3D vmbus_get_next_version(version);
> -=09} while (version !=3D VERSION_INVAL);
> -
> -=09if (version =3D=3D VERSION_INVAL)
> -=09=09goto cleanup;
> +=09}
> =20
>  =09vmbus_proto_version =3D version;
>  =09pr_info("Vmbus version:%d.%d\n",
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index b4a017093b697..7073f1eb3618c 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -194,8 +194,6 @@ static inline u32 hv_get_avail_to_write_percent(
> =20
>  #define VERSION_INVAL -1
> =20
> -#define VERSION_CURRENT VERSION_WIN10_V5
> -
>  /* Make maximum size of pipe payload of 16K */
>  #define MAX_PIPE_DATA_PAYLOAD=09=09(sizeof(u8) * 16384)

--=20
Vitaly

