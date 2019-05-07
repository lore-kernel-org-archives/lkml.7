Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09D7C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8633C20989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfEGHjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 03:39:12 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:54574 "EHLO
        9.mo178.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfEGHjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:39:09 -0400
X-Greylist: delayed 1200 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 May 2019 03:39:09 EDT
Received: from player796.ha.ovh.net (unknown [10.108.35.27])
        by mo178.mail-out.ovh.net (Postfix) with ESMTP id 666135E9E0
        for <linux-kernel@vger.kernel.org>; Tue,  7 May 2019 09:01:51 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player796.ha.ovh.net (Postfix) with ESMTPSA id 65F0A561F73C;
        Tue,  7 May 2019 07:01:46 +0000 (UTC)
Date:   Tue, 7 May 2019 09:01:45 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Sam Bobroff <sbobroff@linux.ibm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio-pci/nvlink2: Fix potential VMA leak
Message-ID: <20190507090145.4be12c82@bahia.lan>
In-Reply-To: <20190507014915.GA10274@tungsten.ozlabs.ibm.com>
References: <155568823785.601037.2151744205292679252.stgit@bahia.lan>
        <20190506155845.70f3b01d@x1.home>
        <20190507014915.GA10274@tungsten.ozlabs.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/40jBTFpoOsFSSaNoBPfpNLC"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 3269331857217132982
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrjeelgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/40jBTFpoOsFSSaNoBPfpNLC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 7 May 2019 11:52:44 +1000
Sam Bobroff <sbobroff@linux.ibm.com> wrote:

> On Mon, May 06, 2019 at 03:58:45PM -0600, Alex Williamson wrote:
> > On Fri, 19 Apr 2019 17:37:17 +0200
> > Greg Kurz <groug@kaod.org> wrote:
> >  =20
> > > If vfio_pci_register_dev_region() fails then we should rollback
> > > previous changes, ie. unmap the ATSD registers.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > --- =20
> >=20
> > Applied to vfio next branch for v5.2 with Alexey's R-b.  Thanks!
> >=20
> > Alex =20
>=20
> Should this have a fixes tag? e.g.:
> Fixes: 7f92891778df ("vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subd=
river")
>=20

Oops... you're right.

Alex, can you add the above tag ?

> > >  drivers/vfio/pci/vfio_pci_nvlink2.c |    2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/v=
fio_pci_nvlink2.c
> > > index 32f695ffe128..50fe3c4f7feb 100644
> > > --- a/drivers/vfio/pci/vfio_pci_nvlink2.c
> > > +++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
> > > @@ -472,6 +472,8 @@ int vfio_pci_ibm_npu2_init(struct vfio_pci_device=
 *vdev)
> > >  	return 0;
> > > =20
> > >  free_exit:
> > > +	if (data->base)
> > > +		memunmap(data->base);
> > >  	kfree(data);
> > > =20
> > >  	return ret;
> > >  =20
> >  =20


--Sig_/40jBTFpoOsFSSaNoBPfpNLC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlzRLVkACgkQcdTV5YIv
c9ZGkA/+JZ5PaOPO7i+B9OrZ2lo2PBoFGqJDKD/7eIZh5y6gFUSxEq9SgINn+8gx
MyCzhiLHvVf0BXgkOqEuopploTNUxjQR1bg4JN6RigS1p29g4btDcpkUxcYVIm0E
pHoFxeOFMkTzVuBKY0x4qG0exONoCfWgdZOl1gK8dqudX6h9Emg7fcaJ1O94toOZ
PV2AQ0byBJn5L02oCCdCZOAaRJTKU3LoT0pZlYBtXXFxj/oFewEoGj2bYQBF00fR
NTUMhmU+TDJCIog3hcarH4xI28f42oOmpwWpDLWptPN2Pm0sIUHEkprrag5/jpI+
p9XfxNsCPGK1Y2yDyb38xFAmoDpUkI6P4rKUfgVm2YjzkLFzTSS1pSEE2A4hYDdE
IXTWFwzMz70wJLA4nlLd4vQYdJ03YH8X2vv8B0niH0jtvij3HIJSFYdn9t3T9dMd
3F60y15qKVoM8EYTarlRMDl0nX/5999A/FiWEaj/Kxjh2Fy8U4bdfPAZyvertETL
HIwJbSISfG0Rno53ROXeLR34L1sOkLran70bZYkr+eURURGAEzOaXvfxZcGLa2Km
+e/B9/1ymLIEPLqFURKu7mHqWw8AbUZfgnGdkJUttDRTh+RAbhUEmUT93JtSSl+J
H7s7qa8dFe6Y9v5nc1YglHJpkeSTJs8k8YJlhlvmCNfGPHxpLdE=
=x3tB
-----END PGP SIGNATURE-----

--Sig_/40jBTFpoOsFSSaNoBPfpNLC--
