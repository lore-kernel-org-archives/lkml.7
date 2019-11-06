Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8789C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4752067B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSCa0DCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732420AbfKFSGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:06:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34257 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726616AbfKFSGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 13:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573063608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mc0CfKFNSumdX6DJ613pFznuf2fCrMDQvvSKwwkRmvo=;
        b=JSCa0DCE4upjNYqfZl7x4n/mZqSjDMWXB3L2I2HuvcWv1qr1Y29Y1Xy3JXUJSkBgrOQFJr
        ZvnwtqZN85Q7BrMuUsjh4xFpi3KVtv5BR07oN/OscjgvJHjA8WOZwHQdwfze/eagOwM+bz
        U2iPjMAjr4oZInqR2uJ6A3dawddbuX4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-avMl-cg1M_GWhtFAvoN0FQ-1; Wed, 06 Nov 2019 13:06:46 -0500
Received: by mail-qt1-f198.google.com with SMTP id c32so26985492qtb.14
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 10:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NqfzdUNcXeLkdXp8DQ/xxrnz7TDp3lCj6CeS25u8znQ=;
        b=MOuwPYh03k7Q1qAT8zn69l54IsddbktF1mNGC6GuT5Dr5hbMKkqpjcw6lrp2Jk/md7
         d4HHxyMXV64eNMfz8lejA/KUnoKecLrmjSfSiKo4g+aENdzyr0WSSccGWQlYdq9UUEjf
         TWsR6GetM7kvx4xrcJwqHF9GYTAvI78WzyP0X3qWadnhgJSKUePuPZWOoYG7+l5FSJSG
         U8yBDtrBBjptMkg5AhdnVhX402uJFWr05mPbLmBFZSZIhQ8ndcrs4uH5f78uvMN4Wxst
         2A6JIhe8DiB313XugbOYqHkDmiEgc6eh7qEEj4l2N+WLc50XNYdqI5I7vG1AkcP0Fkfr
         KnwQ==
X-Gm-Message-State: APjAAAVll3ej1tFPDaAmJW2gD/tegJTPO6PSkkWjfhrbdMAlfOyWO4/7
        lZ8NFvbOgQ8ttWRrYQUDKPCDI+hGJkXklFJwoTVHnnXcBYKy14VPPEBe8YAUo/C4YgJgraaTGbF
        p9l5qAWvo5M+YilYmELjQeRCP
X-Received: by 2002:aed:35f4:: with SMTP id d49mr3723079qte.20.1573063606282;
        Wed, 06 Nov 2019 10:06:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqyOhMFoH+z07w8YBa359Wh6c2mb8FRixZPOonwYmlAbW0henI/EGic2ZkzRnEfuMVA+wm2czg==
X-Received: by 2002:aed:35f4:: with SMTP id d49mr3723053qte.20.1573063605969;
        Wed, 06 Nov 2019 10:06:45 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
        by smtp.gmail.com with ESMTPSA id k3sm15336883qtf.68.2019.11.06.10.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 10:06:45 -0800 (PST)
Date:   Wed, 6 Nov 2019 13:06:37 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        benh@kernel.crashing.org, david@gibson.dropbear.id.au,
        mpe@ellerman.id.au, paulus@ozlabs.org, mdroth@linux.vnet.ibm.com,
        hch@lst.de, andmike@us.ibm.com, sukadev@linux.vnet.ibm.com,
        ram.n.pai@gmail.com, cai@lca.pw, tglx@linutronix.de,
        bauerman@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 0/2] Enable IOMMU support for pseries Secure VMs
Message-ID: <20191106130558-mutt-send-email-mst@kernel.org>
References: <1572902923-8096-1-git-send-email-linuxram@us.ibm.com>
 <265679db-9cb3-1660-0cf6-97f740b1b48b@ozlabs.ru>
MIME-Version: 1.0
In-Reply-To: <265679db-9cb3-1660-0cf6-97f740b1b48b@ozlabs.ru>
X-MC-Unique: avMl-cg1M_GWhtFAvoN0FQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 12:59:50PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 05/11/2019 08:28, Ram Pai wrote:
> > This patch series enables IOMMU support for pseries Secure VMs.
> >=20
> >=20
> > Tested using QEMU command line option:
> >=20
> >  "-device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.0,addr=3D0x4,
> >  =09iommu_platform=3Don,disable-modern=3Doff,disable-legacy=3Don"
> >  and=20
> >=20
> >  "-device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,
> >  =09addr=3D0x5,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,
> >  =09iommu_platform=3Don,disable-modern=3Doff,disable-legacy=3Don"
>=20
>=20
> Worth mentioning that SLOF won't boot with such devices as SLOF does not =
know about iommu_platform=3Don.

Shouldn't be hard to support: set up the iommu to allow everything
and ack the feature. Right?

> >=20
> > Ram Pai (2):
> >   powerpc/pseries/iommu: Share the per-cpu TCE page with the hypervisor=
.
> >   powerpc/pseries/iommu: Use dma_iommu_ops for Secure VMs aswell.
> >=20
> >  arch/powerpc/platforms/pseries/iommu.c | 30 ++++++++++++++++++--------=
----
> >  1 file changed, 18 insertions(+), 12 deletions(-)
> >=20
>=20
> --=20
> Alexey

