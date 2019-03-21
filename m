Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E05C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A235218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeYilcsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfCUQN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:13:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50514 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCUQN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:13:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so3435439wmi.0;
        Thu, 21 Mar 2019 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jZ1hS5vK36AuUEQhYTZQUtCbAR5g+kx6r1fzc9KwmP0=;
        b=jeYilcsczvY4bl4e88AMAQLzuFXPbsATlcwNFPfUrKoDNyRjk2jMVmcgNbZ1i07Qyl
         a3cdtVcxBBtV2cAC2G6BXE87DR86nj4fvU5YTYl7Wr0hlLZiqfUYemJUptyrd/bRUbqM
         pNg0ooVMZStASbnw0FVnXpWl06R345pReUPLAbEPgk4/LYaSYGnPZI9vQrFEYu40kIEN
         Urs5/zowBJBqP5JGhGI1B2O7PgTIJaWFo9xPpUPQbt0dDZru8NcBox6DFPa6ave+N46y
         4lvQklCt/WmxSBQYJACZ/O8zFleQ9AC6ii0WZQsXRlEh69QT6mM/G/06d1Su4AcpFZj0
         vbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jZ1hS5vK36AuUEQhYTZQUtCbAR5g+kx6r1fzc9KwmP0=;
        b=UeWm53AeqI8aWSoKS9jTJ18YGH02ES3COy9Eyxirc/LQfnx74nL1HksJNkfGNdugai
         8v/LPjO3pZ2s4ynn+uyIIhqDmlFuFqILk2GOqJcaQi8LB+Y9G327Woo/NQh2I1IIySQm
         OVV/muYOtmuHN7iDrrUUm0L7KmlLpXjx9z/ghE3xMBT3VGgv6q3Fh4LsdJoYY4oKQjig
         deUTDRaMsuSuFPJ8M+0vtHYW8700fKTUYF5xQkDALpUPVyuE9xGj/fCiKJVaRnjWVEPi
         +sIrdzuHDcjv5xczbgEuujKWCKyAZf2eJkEBtUXKToFdfhXdhg341S6CTPYzhyXnm5cz
         vcLg==
X-Gm-Message-State: APjAAAXGsNjgJi/SRbqwyibAetUHXwDYJqcMcrE8UR6I5NzdLVSoVfHz
        zffektc600T2LJNPxXDjQ4E=
X-Google-Smtp-Source: APXvYqyPWnkg62/1+54VPMTdWsd/WKMc/eHYG3BFeZBkt+Gqv/Sf/gXJRAzIt/HkbNf2r5NiISvxUQ==
X-Received: by 2002:a05:600c:cd:: with SMTP id u13mr23433wmm.49.1553184834121;
        Thu, 21 Mar 2019 09:13:54 -0700 (PDT)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id q2sm9739804wrd.46.2019.03.21.09.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 09:13:53 -0700 (PDT)
Date:   Thu, 21 Mar 2019 16:13:52 +0000
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E . McKenney " <paulmck@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liang Cunming <cunming.liang@intel.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        Fam Zheng <fam@euphon.net>, Amnon Ilan <ailan@redhat.com>,
        John Ferlan <jferlan@redhat.com>
Subject: Re: your mail
Message-ID: <20190321161352.GA21682@stefanha-x1.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20190319144116.400-1-mlevitsk@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2019 at 04:41:07PM +0200, Maxim Levitsky wrote:
> Date: Tue, 19 Mar 2019 14:45:45 +0200
> Subject: [PATCH 0/9] RFC: NVME VFIO mediated device
>=20
> Hi everyone!
>=20
> In this patch series, I would like to introduce my take on the problem of=
 doing=20
> as fast as possible virtualization of storage with emphasis on low latenc=
y.
>=20
> In this patch series I implemented a kernel vfio based, mediated device t=
hat=20
> allows the user to pass through a partition and/or whole namespace to a g=
uest.
>=20
> The idea behind this driver is based on paper you can find at
> https://www.usenix.org/conference/atc18/presentation/peng,
>=20
> Although note that I stared the development prior to reading this paper,=
=20
> independently.
>=20
> In addition to that implementation is not based on code used in the paper=
 as=20
> I wasn't being able at that time to make the source available to me.
>=20
> ***Key points about the implementation:***
>=20
> * Polling kernel thread is used. The polling is stopped after a=20
> predefined timeout (1/2 sec by default).
> Support for all interrupt driven mode is planned, and it shows promising =
results.
>=20
> * Guest sees a standard NVME device - this allows to run guest with=20
> unmodified drivers, for example windows guests.
>=20
> * The NVMe device is shared between host and guest.
> That means that even a single namespace can be split between host=20
> and guest based on different partitions.
>=20
> * Simple configuration
>=20
> *** Performance ***
>=20
> Performance was tested on Intel DC P3700, With Xeon E5-2620 v2=20
> and both latency and throughput is very similar to SPDK.
>=20
> Soon I will test this on a better server and nvme device and provide
> more formal performance numbers.
>=20
> Latency numbers:
> ~80ms - spdk with fio plugin on the host.
> ~84ms - nvme driver on the host
> ~87ms - mdev-nvme + nvme driver in the guest

You mentioned the spdk numbers are with vhost-user-nvme.  Have you
measured SPDK's vhost-user-blk?

Stefan

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJck7hAAAoJEJykq7OBq3PInk8IAIyLq251vi4RSs3LznDr+zKm
vvruxYj2YImYO3vJoFuposfBU6M0D14WhyZQl7HiJNP4nLPsgS1pgqHfmu0w0U/W
vyAay5ug64+5irJFKm+Uj0FbPUoyD/h4mV3qn4wvy6LVpQbHrPEOdiGnE+lBpwF1
whPXlnAAfhrJFTbrvUcK1ricmlmAqRRKxZjiH9N2bSFEfv4pVEkK0Yym7lH/S33e
pqc02PlCB2s5fsOmbQEqg7q5qwNkzyWcGi1JsnbLOBrtRP+87nb5dM3zwIJ/JQne
cgo+YPSOKShndq3BvayQfEs+QefQJlG2KV2x6BT061aPRp982CbGhymktWXoZ68=
=8gYn
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
