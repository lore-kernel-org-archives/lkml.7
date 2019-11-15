Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E386EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B5E20732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLZtKCqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfKOWwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:52:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22314 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726969AbfKOWwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573858340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XxLRwCNIqyo3k0JMi1Xi1l9F+MTU6v0lA44sbxrMUCs=;
        b=aLZtKCqDOAvBdnAL2NFO1lXwmKa/eZLzFwp3EgUm1OERi1RT9C84EiZsrjz0OyJvTQ8nQ7
        ljI6YR400XMjVWea9Uf4/aGUuorCjyta0ULkDzgD/pWd0mPOqExeTDDPtGMxPlS/TqXCT5
        RVtGz1/AnVA4elm4ekAzf2g9vcVu3qk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-HJK_wxZNOSqc8u6YXdGSGQ-1; Fri, 15 Nov 2019 17:52:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 211F3DBE5;
        Fri, 15 Nov 2019 22:52:17 +0000 (UTC)
Received: from x1.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD06F6012E;
        Fri, 15 Nov 2019 22:52:16 +0000 (UTC)
Date:   Fri, 15 Nov 2019 15:52:14 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v1 5/5] vfio/pci: Drop duplicate check for size
 parameter of memremap()
Message-ID: <20191115155214.55e949cc@x1.home>
In-Reply-To: <20191115180044.83659-5-andriy.shevchenko@linux.intel.com>
References: <20191115180044.83659-1-andriy.shevchenko@linux.intel.com>
        <20191115180044.83659-5-andriy.shevchenko@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: HJK_wxZNOSqc8u6YXdGSGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 20:00:44 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since memremap() returns NULL pointer for size =3D 0, there is no need
> to duplicate this check in the callers.
>=20
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/vfio/pci/vfio_pci_igd.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/drivers/vfio/pci/vfio_pci_igd.c b/drivers/vfio/pci/vfio_pci_=
igd.c
> index 53d97f459252..3088a33af271 100644
> --- a/drivers/vfio/pci/vfio_pci_igd.c
> +++ b/drivers/vfio/pci/vfio_pci_igd.c
> @@ -75,13 +75,7 @@ static int vfio_pci_igd_opregion_init(struct vfio_pci_=
device *vdev)
>  =09=09return -EINVAL;
>  =09}
> =20
> -=09size =3D le32_to_cpu(*(__le32 *)(base + 16));
> -=09if (!size) {
> -=09=09memunmap(base);
> -=09=09return -EINVAL;
> -=09}
> -
> -=09size *=3D 1024; /* In KB */
> +=09size =3D le32_to_cpu(*(__le32 *)(base + 16)) * 1024; /* In KB */
> =20
>  =09if (size !=3D OPREGION_SIZE) {
>  =09=09memunmap(base);

This seems convoluted, patch 1/5 states "[t]here is no use of memremap()
to be called with size =3D 0", which we weren't doing thanks to the check
removed above.  So now we are potentially calling it with zero,
apparently only to take advantage of this new behavior, and we lose the
error granularity that previously such a condition failed with an
-EINVAL and now we fail with an -ENONMEM and cannot distinguish whether
the OpRegion table size was empty or we just weren't able to memremap()
it.  I don't see how this is an improvement.  Thanks,

Alex

