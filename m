Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CB3C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F8922310
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EF0IIECD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKRW4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:56:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26318 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726705AbfKRW4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574117789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SIFN0DSE2a6uRlEGbcGYw3B4WnteeMfXDq8qzdRcgWA=;
        b=EF0IIECDy40qgcVkE1CDldjz/WAY0YJECsn5fRj+wEbmPFmoOSem8IlYKQuq6B9/dxbSyT
        dRqQ2uUKLgRuNTsIbT4DdXU6Yg1uBeep/T5rGx3LoaTmNZo0DjFj8BpNl6dPtwDEaiu7bw
        6igmzGDpAa2nEF+xK9MEYrhexk2WTE0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-rVd5YYcON2aYErV2zGQKZQ-1; Mon, 18 Nov 2019 17:56:28 -0500
Received: by mail-wr1-f72.google.com with SMTP id w4so17002938wro.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 14:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HioSahbeNRN41x4RVyYU/tP+TcFzJdT9IZVxNGFaNo8=;
        b=rU0+XHMADQMffeQsh1vqXAySYw9m5NaOAjaGAl86av1SYlZVcrNRapG4/WB3LlMjVe
         NlzLlldVMn+WCTyjLkbfvTU4m57ijnlfVEk0q3b88X6nqMTrUlmYy2sGnMVlcJPK/RaN
         mplD/WOqKCXX5/2DaKNaPN4OMI9hif4oclQ1j9tB1RyhLhJT07iSEsie689r+q1tjWcZ
         ggrNhK6vOPAPvwNVFZw1nL9LZUnIBxFZoTKdFTuhxoQ8aFwpeEjhqb3MTvXbgVyt+kDS
         UfWxHVjfaDImPk8CiYyVIQHzCsldjKeXCXrMLJvXP+XahS3Gk3HOwCCW8CQ4OkqTjCXP
         5ZPw==
X-Gm-Message-State: APjAAAWnMEVTDF3M1WwYP/esfubdgw/iQmxVAhFRuCPn+lbAKAplIX4u
        /7Vv9Bzbu7J9Q5H7rIO9Fsr50kbrVL1TFsT/9lj6UpDkOx4EDZ6HaP7W0PhgeSgExI740rRnbk7
        WSn9xit6hb102USWZUtRc82eH
X-Received: by 2002:a1c:6a09:: with SMTP id f9mr1971321wmc.15.1574117787432;
        Mon, 18 Nov 2019 14:56:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyhDG4FHIYHOZCl0OnG5fQ8dXkyj3RaiFcZW6cetFvUY5JdHU33H0ovNtwxOvLRLUbPHoNbxQ==
X-Received: by 2002:a1c:6a09:: with SMTP id f9mr1971306wmc.15.1574117787217;
        Mon, 18 Nov 2019 14:56:27 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id 13sm953862wmk.1.2019.11.18.14.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 14:56:26 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:56:24 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     jasowang@redhat.com, wei.w.wang@intel.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 2/2] virtio_balloon: fix shrinker_scan return units
Message-ID: <20191118175339-mutt-send-email-mst@kernel.org>
References: <CACGdZYJoHSN3vkj_QBz6Txmec9mJMmkH66j2XtqzpUWpfpw4Tg@mail.gmail.com>
 <20191118213811.22017-1-khazhy@google.com>
 <20191118213811.22017-2-khazhy@google.com>
MIME-Version: 1.0
In-Reply-To: <20191118213811.22017-2-khazhy@google.com>
X-MC-Unique: rVd5YYcON2aYErV2zGQKZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 01:38:11PM -0800, Khazhismel Kumykov wrote:
> We were returning number of virtio balloon pages, which may not be the
> same as number of system pages
>=20
> Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> Cc: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> ---
>  drivers/virtio/virtio_balloon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index 7cf9540a40b8..7951ece3fe24 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -802,11 +802,11 @@ static unsigned long virtio_balloon_shrinker_scan(s=
truct shrinker *shrinker,
>  =09=09pages_freed =3D shrink_free_pages(vb, pages_to_free);
> =20
>  =09if (pages_freed >=3D pages_to_free)
> -=09=09return pages_freed;
> +=09=09return pages_freed / VIRTIO_BALLOON_PAGES_PER_PAGE;
>

I'm no seeing why is this one right. shrink_free_pages gives result
in PAGE_SIZE units, right?
 =20
>  =09pages_freed +=3D shrink_balloon_pages(vb, pages_to_free - pages_freed=
);
> =20
> -=09return pages_freed;
> +=09return pages_freed / VIRTIO_BALLOON_PAGES_PER_PAGE;


My head hurts. Isn't this what patch 1 tweaked?



>  }
> =20
>  static unsigned long virtio_balloon_shrinker_count(struct shrinker *shri=
nker,
> --=20
> 2.24.0.432.g9d3f5f5b63-goog

