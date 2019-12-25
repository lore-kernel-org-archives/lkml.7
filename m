Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068CCC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 18:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39F62075E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 18:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuM4SFAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfLYSSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 13:18:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55446 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLYSSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 13:18:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so2972101wmj.5;
        Wed, 25 Dec 2019 10:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rAiDopa0PVL/QOjfMprf+6GTtD9PBgJzDjRRbtYvJag=;
        b=iuM4SFAFvMah8RL6hZAyo9Yy1r9RehM16Jcl0jYuqy7YsZk9ED3rSbXAa3SHvlwFIY
         b44pFf78xW0QgHZGjkc0eejHbGg5sPCacOfd2UbELcwAI4Y+Ptma0YY4Dp4jdgvyZmhs
         cH9cSo2Te5ZTIqiNdZ+VgmlZhcPCRNTufuwkk6mI4YJt+jIYwOFxI8QZwJEegrCjEQTz
         vWJ61SbDipxDP+N8SThGX8I7n1frSqM6H61NhmxmXa0lSUSh5jg0+IRb/BFqDLrvbR+L
         3JsLjFUFFPjw6IX6pt4vUWKGLFVXu5+YebVyEXroMnFa+QDKlI3NYZAMOltMJqLxQ0Zi
         SQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rAiDopa0PVL/QOjfMprf+6GTtD9PBgJzDjRRbtYvJag=;
        b=dibxlN+yhPE4p8rCEbGSjL1YY0dw7udpgMlPWZmoUlmXNdk74DsD43FX0ChGzmWSVe
         AI5ttaywrpeLNSv+RDzyf/osH6shnJpmY1hqi2Lu4n+SvQWYbFET3nHfE4fvw/CsUAm7
         SqHZ+RFfaOEEcuyZXv9O3QtZu6ofNat5A6yVkdXLYYXxfTDqr21+G46poUee8q47n1+9
         YQMVXkPV/ns9cMdnGdSEYiRbgl13Q/hOqCskrdAijPgVKsf1uWHY4tewfuw2UUaBSlmo
         l3ss1XXCJEe5XdwsThnd+ddXAWHz+tHBfD245Sg+SRafH6xhhfdZ9rCKTYAIAi5lSUmo
         Iprg==
X-Gm-Message-State: APjAAAWnhqWlmuREM/MlR9y+2ba+OewqGuMOvlN4KnXhB/yGtlIjzYqj
        elT67M5kJKLkoa+jIMCyZYQ=
X-Google-Smtp-Source: APXvYqxzvA/vnd/9gK2CPJNQnH/8bERogGjDN6eKlGPfpWGy8dDYcCNvC1ySRm+bCI2w6B0c7T3YQw==
X-Received: by 2002:a05:600c:48a:: with SMTP id d10mr10277501wme.87.1577297921560;
        Wed, 25 Dec 2019 10:18:41 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id r5sm27765327wrt.43.2019.12.25.10.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Dec 2019 10:18:40 -0800 (PST)
Date:   Wed, 25 Dec 2019 19:18:40 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, kernel@pengutronix.de
Subject: Re: [PATCH v2] libata: Fix retrieving of active qcs
Message-ID: <20191225181840.ooo6mw5rffghbmu2@pali>
References: <20191213080408.27032-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6tv2c6r4hje2wamn"
Content-Disposition: inline
In-Reply-To: <20191213080408.27032-1-s.hauer@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6tv2c6r4hje2wamn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sascha!

On Friday 13 December 2019 09:04:08 Sascha Hauer wrote:
> ata_qc_complete_multiple() is called with a mask of the still active
> tags.
>=20
> mv_sata doesn't have this information directly and instead calculates
> the still active tags from the started tags (ap->qc_active) and the
> finished tags as (ap->qc_active ^ done_mask)
>=20
> Since 28361c40368 the hw_tag and tag are no longer the same and the
> equation is no longer valid. In ata_exec_internal_sg() ap->qc_active is
> initialized as 1ULL << ATA_TAG_INTERNAL, but in hardware tag 0 is
> started and this will be in done_mask on completion. ap->qc_active ^
> done_mask becomes 0x100000000 ^ 0x1 =3D 0x100000001 and thus tag 0 used as
> the internal tag will never be reported as completed.
>=20
> This is fixed by introducing ata_qc_get_active() which returns the
> active hardware tags and calling it where appropriate.
>=20
> This is tested on mv_sata, but sata_fsl and sata_nv suffer from the same
> problem. There is another case in sata_nv that most likely needs fixing
> as well, but this looks a little different, so I wasn't confident enough
> to change that.

I can confirm that sata_nv.ko does not work in 4.18 (and new) kernel
version correctly. More details are in email:

https://lore.kernel.org/linux-ide/20191225180824.bql2o5whougii4ch@pali/T/

I tried this patch and it fixed above problems with sata_nv.ko. It just
needs small modification (see below).

So you can add my:

Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

And I hope that patch would be backported to 4.18 and 4.19 stable
branches soon as distributions kernels are broken for machines with
these nvidia sata controllers.

Anyway, what is that another case in sata_nv which needs to be fixed
too?

> Fixes: 28361c403683 ("libata: add extra internal command")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>=20
> Changes since v1:
> - Fix wrong function name in include/linux/libata.h
>=20
>  drivers/ata/libata-core.c | 23 +++++++++++++++++++++++
>  drivers/ata/sata_fsl.c    |  2 +-
>  drivers/ata/sata_mv.c     |  2 +-
>  drivers/ata/sata_nv.c     |  2 +-
>  include/linux/libata.h    |  1 +
>  5 files changed, 27 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e9017c570bc5..a330e1f28ff4 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5328,6 +5328,29 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
>  	}
>  }
> =20
> +/**
> + *	ata_qc_get_active - get bitmask of active qcs
> + *	@ap: port in question
> + *
> + *	LOCKING:
> + *	spin_lock_irqsave(host lock)
> + *
> + *	RETURNS:
> + *	Bitmask of active qcs
> + */
> +u64 ata_qc_get_active(struct ata_port *ap)
> +{
> +	u64 qc_active =3D ap->qc_active;
> +
> +	/* ATA_TAG_INTERNAL is sent to hw as tag 0 */
> +	if (qc_active & (1ULL << ATA_TAG_INTERNAL)) {
> +		qc_active |=3D (1 << 0);
> +		qc_active &=3D ~(1ULL << ATA_TAG_INTERNAL);
> +	}
> +
> +	return qc_active;
> +}

Here is missing

  EXPORT_SYMBOL_GPL(ata_qc_get_active);

otherwise sata_nv.ko cannot use this ata_qc_get_active() function and
throw error about undefined symbol when modprobing module.

> +
>  /**
>   *	ata_qc_complete_multiple - Complete multiple qcs successfully
>   *	@ap: port in question
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 9239615d8a04..d55ee244d693 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -1280,7 +1280,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
>  				     i, ioread32(hcr_base + CC),
>  				     ioread32(hcr_base + CA));
>  		}
> -		ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
> +		ata_qc_complete_multiple(ap, ata_qc_get_active(ap) ^ done_mask);
>  		return;
> =20
>  	} else if ((ap->qc_active & (1ULL << ATA_TAG_INTERNAL))) {
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 277f11909fc1..d7228f8e9297 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -2829,7 +2829,7 @@ static void mv_process_crpb_entries(struct ata_port=
 *ap, struct mv_port_priv *pp
>  	}
> =20
>  	if (work_done) {
> -		ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
> +		ata_qc_complete_multiple(ap, ata_qc_get_active(ap) ^ done_mask);
> =20
>  		/* Update the software queue position index in hardware */
>  		writelfl((pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK) |
> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
> index f3e62f5528bd..eb9dc14e5147 100644
> --- a/drivers/ata/sata_nv.c
> +++ b/drivers/ata/sata_nv.c
> @@ -984,7 +984,7 @@ static irqreturn_t nv_adma_interrupt(int irq, void *d=
ev_instance)
>  					check_commands =3D 0;
>  				check_commands &=3D ~(1 << pos);
>  			}
> -			ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
> +			ata_qc_complete_multiple(ap, ata_qc_get_active(ap) ^ done_mask);
>  		}
>  	}
> =20
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index d3bbfddf616a..2dbde119721d 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1175,6 +1175,7 @@ extern unsigned int ata_do_dev_read_id(struct ata_d=
evice *dev,
>  					struct ata_taskfile *tf, u16 *id);
>  extern void ata_qc_complete(struct ata_queued_cmd *qc);
>  extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
> +extern u64 ata_qc_get_active(struct ata_port *ap);
>  extern void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *=
cmd);
>  extern int ata_std_bios_param(struct scsi_device *sdev,
>  			      struct block_device *bdev,

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--6tv2c6r4hje2wamn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXgOn/gAKCRCL8Mk9A+RD
Um5pAJ9L+/vJqmQEXoYqqCoq5zRFkP4rqQCfRNQZzQ+VxZQEXmwVUTYC61sNYsI=
=V5/p
-----END PGP SIGNATURE-----

--6tv2c6r4hje2wamn--
