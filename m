Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8835EC31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 19:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6693A20862
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 19:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfFPT5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 15:57:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54884 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfFPT5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 15:57:35 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3CAAB8022F; Sun, 16 Jun 2019 21:57:22 +0200 (CEST)
Date:   Sun, 16 Jun 2019 21:57:32 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, Yufen Yu <yuyufen@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 060/118] nvme-pci: shutdown on timeout during
 deletion
Message-ID: <20190616195732.GD6676@amd>
References: <20190613075643.642092651@linuxfoundation.org>
 <20190613075647.341186537@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline
In-Reply-To: <20190613075647.341186537@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Thu 2019-06-13 10:33:18, Greg Kroah-Hartman wrote:
> [ Upstream commit 9dc1a38ef1925d23c2933c5867df816386d92ff8 ]
>=20
> We do not restart a controller in a deleting state for timeout errors.
> When in this state, unblock potential request dispatchers with failed
> completions by shutting down the controller on timeout detection.
>=20
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 377f6fff420d..c8eeecc58115 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1132,6 +1132,7 @@ static enum blk_eh_timer_return nvme_timeout(struct=
 request *req, bool reserved)
>  	struct nvme_dev *dev =3D nvmeq->dev;
>  	struct request *abort_req;
>  	struct nvme_command cmd;
> +	bool shutdown =3D false;
>  	u32 csts =3D readl(dev->bar + NVME_REG_CSTS);
> =20
>  	/* If PCI error recovery process is happening, we cannot reset or
> @@ -1168,12 +1169,14 @@ static enum blk_eh_timer_return nvme_timeout(stru=
ct request *req, bool reserved)
>  	 * shutdown, so we return BLK_EH_DONE.
>  	 */
>  	switch (dev->ctrl.state) {
> +	case NVME_CTRL_DELETING:
> +		shutdown =3D true;
>  	case NVME_CTRL_CONNECTING:
>  	case NVME_CTRL_RESETTING:

Would it make sense to add /* fallthrough */ comment to indicate it is
intentional?

Best regards,
										Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0GnywACgkQMOfwapXb+vK1mQCfbVYDZKpouHCB+901/6OHWNJE
nqIAn3Oo6G9Sw63OByOjeyBmr75nU6y5
=2f5Q
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
