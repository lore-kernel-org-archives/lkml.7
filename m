Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0675C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 23:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C86206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 23:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPqaY0Sz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKRXJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 18:09:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48651 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726787AbfKRXJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 18:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574118546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/mx4+qFXiC/+e+Xdl1zRsPqe4Lse+/H7aINXXZ+4oWE=;
        b=OPqaY0SzvQjTyUSCDf8JAgVRw962FHqtCJtNuoGCd7IekVi981nzDNBz+g5mJm2qJ7PwOj
        hcBkdkzUxwGHWmbMnQCd6rq8WkCViXLw+kxzL+9SOD88qMJEaKzQVEMxr2r5isjCzBSz8p
        HmaikqNRmyX08NNgvaE849dq5EG+AAg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-MLcVy1_GOK2ovlcJs0Rmrw-1; Mon, 18 Nov 2019 18:09:03 -0500
Received: by mail-qt1-f198.google.com with SMTP id u23so13352733qtb.22
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 15:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ASVjtjtrlpOdxJBYrKpoEIu0aAE2iNvxpFL7UFyOhZI=;
        b=kBsdSFGYC5tKyxgGzjYBzY5RNQ0fC1DRj9VdjwMCRJYyUc2AC1FCQ/coNtSqaTHXhu
         ABiamDo0CL4Ktd1Rtzj8DG0opPhZnyiZxk5H7QdxLb2+PWPqFZYT1TdNTjVyji35Wb+5
         vR14fXfHOTrB/WTVG4iNBPhMv7EyGytKD08j3z5BhHQhSvuYeYDYyipP2PmVWOR1O3Ql
         wgwHLeFqBEu938+Zl0soAYhXaZZ029l08+YA2yI7h50EsomRFZw9cFlGj/FmR22cAAEe
         XIFzSpOoOK2/Le7Ll2fEffBexnOPRBDdsj2Oz56Zu/2ar99rXZ+V1cZP/ptysNW0OXlw
         NkAA==
X-Gm-Message-State: APjAAAWnKbYwPbp4XT18yL3yD49qagHtqirOYKhfBUa9hODxsEGIX93O
        VP3uOQDNpegRnB6ILDcl5tjdTLiGLb7lLL3njm9EZHM0lAL4UnSziObzGI+jWEpG8y4ZhMI7vgB
        XakI2BCwG3V+0R4jNag0IxZ94
X-Received: by 2002:ad4:55f0:: with SMTP id bu16mr508576qvb.80.1574118542561;
        Mon, 18 Nov 2019 15:09:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqylfbTgxCWyt2CLVW/JdX9DrSVC+Ljy7mGozqLWbllbTB1zEStw/500ZaQBOmJKizWLC2uycg==
X-Received: by 2002:ad4:55f0:: with SMTP id bu16mr508555qvb.80.1574118542243;
        Mon, 18 Nov 2019 15:09:02 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id y24sm9167647qki.104.2019.11.18.15.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 15:09:01 -0800 (PST)
Date:   Mon, 18 Nov 2019 18:08:56 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     jasowang@redhat.com, wei.w.wang@intel.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] virtio_balloon: fix pages_to_free calculation
Message-ID: <20191118175648-mutt-send-email-mst@kernel.org>
References: <CACGdZYJoHSN3vkj_QBz6Txmec9mJMmkH66j2XtqzpUWpfpw4Tg@mail.gmail.com>
 <20191118213811.22017-1-khazhy@google.com>
MIME-Version: 1.0
In-Reply-To: <20191118213811.22017-1-khazhy@google.com>
X-MC-Unique: MLcVy1_GOK2ovlcJs0Rmrw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


So I really think we should do something like the below instead.
Limit playing with balloon pages so we can gradually limit it to legacy.
Testing, review would be appreciated.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloo=
n.c
index 226fbb995fb0..7cee05cdf3fb 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -772,6 +772,13 @@ static unsigned long shrink_free_pages(struct virtio_b=
alloon *vb,
 =09return blocks_freed << VIRTIO_BALLOON_FREE_PAGE_ORDER;
 }
=20
+static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
+                                          unsigned long pages_to_free)
+{
+=09return leak_balloon(vb, pages_to_free * VIRTIO_BALLOON_PAGES_PER_PAGE) =
/
+=09=09VIRTIO_BALLOON_PAGES_PER_PAGE;
+}
+
 static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,
 =09=09=09=09=09  unsigned long pages_to_free)
 {
@@ -782,11 +789,9 @@ static unsigned long shrink_balloon_pages(struct virti=
o_balloon *vb,
 =09 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
 =09 * multiple times to deflate pages till reaching pages_to_free.
 =09 */
-=09while (vb->num_pages && pages_to_free) {
-=09=09pages_freed +=3D leak_balloon(vb, pages_to_free) /
-=09=09=09=09=09VIRTIO_BALLOON_PAGES_PER_PAGE;
-=09=09pages_to_free -=3D pages_freed;
-=09}
+=09while (vb->num_pages && pages_freed < pages_to_free)
+=09=09pages_freed +=3D leak_balloon_pages(vb, pages_to_free);
+
 =09update_balloon_size(vb);
=20
 =09return pages_freed;
@@ -799,7 +804,7 @@ static unsigned long virtio_balloon_shrinker_scan(struc=
t shrinker *shrinker,
 =09struct virtio_balloon *vb =3D container_of(shrinker,
 =09=09=09=09=09struct virtio_balloon, shrinker);
=20
-=09pages_to_free =3D sc->nr_to_scan * VIRTIO_BALLOON_PAGES_PER_PAGE;
+=09pages_to_free =3D sc->nr_to_scan;
=20
 =09if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 =09=09pages_freed =3D shrink_free_pages(vb, pages_to_free);

