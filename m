Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89177C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6A12230C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtKnvXNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKSJhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:37:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34893 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbfKSJhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574156269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fRXQm6AwweBAKs+ZK0WV5Q/2PFP544W5D+sMQayTAv8=;
        b=gtKnvXNORKJO2eFZ7YrbYnzt42OB4h0T6HfTkd8OHfrNbnaXsNSzb6qm2nxUBj94lALBKy
        wdEEXIoC2LvLg1gK/1ODIeIllS3iV4NgalOw0BWOmwYE4IOCjlUbExFBeCsSnveDNU8wtt
        aA5CYG2Jm3LjO9IxJFEBC2d1VdHZqu8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-bmRiM5suOUmRBO08iONfnw-1; Tue, 19 Nov 2019 04:37:46 -0500
Received: by mail-qt1-f200.google.com with SMTP id s8so14240517qtq.17
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 01:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i0dzxXcu3kZcEkcFFAvs/xGVYiism8Ya+pMy/yRvdtE=;
        b=YCoOO7u/6HRiSedThFdauTLSTLvKHcJ0OlxCvfFB3/qnXRprf4mMZSjbmwSy59vMT1
         42zSkq8dd8vwqgOvNas99PAHTru5aM49EB7f16WyZhptFZ+XW8a78FJ/yA+sNs95Kj06
         pWr7Tsm4p4POpFDt5BHI4Js7DhSO3l/hjLopzUAbaiSb4w/dmnrCxqDYD7v6KJq9YFGU
         OxzCIYjkMeTZw7PMnDaCKRImX7kGDx4WYvFJPheGTNDjuyn2E+UfHkfxYDBDtBtMNbU+
         nTOBqwADE4STuhqhN2JJGY1zbzsHmQqjbuK0Ti39YC2mg+8wiORyGTqgvesqAc3iR+nI
         9pyw==
X-Gm-Message-State: APjAAAVbUaEN9jn0z5rPk3b7QKYCnWG+rKOM4tGZ5zzZXimQFVzABRO2
        1u1gwu5zGLTrTcjzsBq00yTn5V6ZF9y7G/mNKQzs8joY9GdE/+Mr+ZtRUJthJn/cSnIsaB7tDEt
        NxV0UNUWseAvdxWr6u2CB3lo8
X-Received: by 2002:a05:6214:170c:: with SMTP id db12mr30011414qvb.202.1574156266084;
        Tue, 19 Nov 2019 01:37:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqwK7mvg1/UTFi/ReQv/8Rt9plSBa25dcfN4y7V2hWjRkBh3WMhOIhzLmTGyXjsBRGWkz36XMQ==
X-Received: by 2002:a05:6214:170c:: with SMTP id db12mr30011390qvb.202.1574156265771;
        Tue, 19 Nov 2019 01:37:45 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id h37sm12422937qth.78.2019.11.19.01.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 01:37:44 -0800 (PST)
Date:   Tue, 19 Nov 2019 04:37:39 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     Khazhismel Kumykov <khazhy@google.com>, jasowang@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] virtio_balloon: fix pages_to_free calculation
Message-ID: <20191119043648-mutt-send-email-mst@kernel.org>
References: <CACGdZYJoHSN3vkj_QBz6Txmec9mJMmkH66j2XtqzpUWpfpw4Tg@mail.gmail.com>
 <20191118213811.22017-1-khazhy@google.com>
 <20191118175648-mutt-send-email-mst@kernel.org>
 <5DD37FE4.4000407@intel.com>
MIME-Version: 1.0
In-Reply-To: <5DD37FE4.4000407@intel.com>
X-MC-Unique: bmRiM5suOUmRBO08iONfnw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 01:38:44PM +0800, Wei Wang wrote:
> On 11/19/2019 07:08 AM, Michael S. Tsirkin wrote:
> > So I really think we should do something like the below instead.
> > Limit playing with balloon pages so we can gradually limit it to legacy=
.
> > Testing, review would be appreciated.
> >=20
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >=20
> >=20
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
> > index 226fbb995fb0..7cee05cdf3fb 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -772,6 +772,13 @@ static unsigned long shrink_free_pages(struct virt=
io_balloon *vb,
> >   =09return blocks_freed << VIRTIO_BALLOON_FREE_PAGE_ORDER;
> >   }
> > +static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
> > +                                          unsigned long pages_to_free)
> > +{
> > +=09return leak_balloon(vb, pages_to_free * VIRTIO_BALLOON_PAGES_PER_PA=
GE) /
> > +=09=09VIRTIO_BALLOON_PAGES_PER_PAGE;
> > +}
> > +
>=20
> Looks good to me, too. (just a reminder that the returning type of
> leak_balloon is "unsigned int",

Yea that use of 32 bit integers is another problem with the existing interf=
aces.

> we may want them to be consistent).
>=20
> Reviewed-by: Wei Wang <wei.w.wang@intel.com>
>=20
> Best,
> Wei

