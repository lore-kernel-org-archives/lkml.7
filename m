Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CD4C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC2624999
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfEaI7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 04:59:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50388 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfEaI7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:59:08 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B8D5F802CE; Fri, 31 May 2019 10:58:56 +0200 (CEST)
Date:   Fri, 31 May 2019 10:59:06 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 075/276] scsi: qla2xxx: Fix a qla24xx_enable_msix()
 error path
Message-ID: <20190531085905.GB19447@amd>
References: <20190530030523.133519668@linuxfoundation.org>
 <20190530030531.119463640@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <20190530030531.119463640@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Wed 2019-05-29 20:03:53, Greg Kroah-Hartman wrote:
> [ Upstream commit 24afabdbd0b3553963a2bbf465895492b14d1107 ]
>=20
> Make sure that the allocated interrupts are freed if allocating memory for
> the msix_entries array fails.
>=20
> Cc: Himanshu Madhani <hmadhani@marvell.com>
> Cc: Giridhar Malavali <gmalavali@marvell.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Acked-by: Himanshu Madhani <hmadhani@marvell.com>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

> --- a/drivers/scsi/qla2xxx/qla_isr.c
> +++ b/drivers/scsi/qla2xxx/qla_isr.c
> @@ -3449,7 +3449,7 @@ qla24xx_enable_msix(struct qla_hw_data *ha, struct =
rsp_que *rsp)
>  		ql_log(ql_log_fatal, vha, 0x00c8,
>  		    "Failed to allocate memory for ha->msix_entries.\n");
>  		ret =3D -ENOMEM;
> -		goto msix_out;
> +		goto free_irqs;

Could we just do > +     pci_free_irq_vectors(ha->pdev); return
-ENOMEM; here? Going through two gotos just does not feel right.

And yes, I'd replace msix_out with direct returns, too. gotos have
value when there's cleanup to be done, but we are not doing any here.

Thanks,
								Pavel

>  	}
>  	ha->flags.msix_enabled =3D 1;
> =20
> @@ -3532,6 +3532,10 @@ qla24xx_enable_msix(struct qla_hw_data *ha, struct=
 rsp_que *rsp)
> =20
>  msix_out:
>  	return ret;
> +
> +free_irqs:
> +	pci_free_irq_vectors(ha->pdev);
> +	goto msix_out;
>  }
> =20

Come on, that is nasty.=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzw7NkACgkQMOfwapXb+vI/GACgqIzAthEf6Dm5q/Fh/RYPwRU2
ERkAoJeD7mh2WCy8aMSwO5QXuXj+upaf
=dTH+
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
