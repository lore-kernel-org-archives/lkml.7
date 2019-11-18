Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F349DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C307320857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emNWkQJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKRPpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 10:45:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33857 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727450AbfKRPpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 10:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574091944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQqXtzuR5gTdo1f2yUDL09SryFyi+NfHrzjVbuoXnyc=;
        b=emNWkQJINdk83N0FDDDgSJ2YpIc0QUahtGzmbTUDUE35hy04hW8Fmu43Epj7ty6UbCe4EK
        7SwevyZ13PCPt3m6etR7UCxe8oIMwD7Krood+CwF79ii6sWbUyiTIRD2j0ni8AwHwiHFqo
        wCGb4Nq0hnjcQ9lGoGHx9dR6mrgvQ8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-CUpLGAmmNbCKwd_ow3c15Q-1; Mon, 18 Nov 2019 10:45:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F31A8FBB57;
        Mon, 18 Nov 2019 15:45:34 +0000 (UTC)
Received: from gondolin (ovpn-117-194.ams2.redhat.com [10.36.117.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87D6B1CD;
        Mon, 18 Nov 2019 15:45:13 +0000 (UTC)
Date:   Mon, 18 Nov 2019 16:45:10 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com,
        alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com,
        gregkh@linuxfoundation.org, jgg@mellanox.com,
        netdev@vger.kernel.org, maxime.coquelin@redhat.com,
        cunming.liang@intel.com, zhihong.wang@intel.com,
        rob.miller@broadcom.com, xiao.w.wang@intel.com,
        haotian.wang@sifive.com, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com,
        pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, akrowiak@linux.ibm.com,
        freude@linux.ibm.com, lingshan.zhu@intel.com, eperezma@redhat.com,
        lulu@redhat.com, parav@mellanox.com,
        christophe.de.dinechin@gmail.com, kevin.tian@intel.com,
        stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org,
        aadam@redhat.com, jakub.kicinski@netronome.com, jiri@mellanox.com,
        jeffrey.t.kirsher@intel.com
Subject: Re: [PATCH V13 6/6] docs: sample driver to demonstrate how to
 implement virtio-mdev framework
Message-ID: <20191118164510.549c097b.cohuck@redhat.com>
In-Reply-To: <20191118105923.7991-7-jasowang@redhat.com>
References: <20191118105923.7991-1-jasowang@redhat.com>
        <20191118105923.7991-7-jasowang@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: CUpLGAmmNbCKwd_ow3c15Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 18:59:23 +0800
Jason Wang <jasowang@redhat.com> wrote:

[Note: I have not looked into the reworked architecture of this *at all*
so far; just something that I noted...]

> This sample driver creates mdev device that simulate virtio net device
> over virtio mdev transport. The device is implemented through vringh
> and workqueue. A device specific dma ops is to make sure HVA is used
> directly as the IOVA. This should be sufficient for kernel virtio
> driver to work.
>=20
> Only 'virtio' type is supported right now. I plan to add 'vhost' type
> on top which requires some virtual IOMMU implemented in this sample
> driver.
>=20
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  MAINTAINERS                        |   1 +
>  samples/Kconfig                    |  10 +
>  samples/vfio-mdev/Makefile         |   1 +
>  samples/vfio-mdev/mvnet_loopback.c | 690 +++++++++++++++++++++++++++++
>  4 files changed, 702 insertions(+)
>  create mode 100644 samples/vfio-mdev/mvnet_loopback.c
>=20

> +static struct mvnet_dev {
> +=09struct class=09*vd_class;
> +=09struct idr=09vd_idr;
> +=09struct device=09dev;
> +} mvnet_dev;

This structure embeds a struct device (a reference-counted structure),
yet it is a static variable. This is giving a bad example to potential
implementers; just allocate it dynamically.

> +static void mvnet_device_release(struct device *dev)
> +{
> +=09dev_dbg(dev, "mvnet: released\n");

And that also means you need a proper release function here, of
course.

> +}

