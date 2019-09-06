Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B829FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B99D2082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404265AbfIFMFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:05:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389271AbfIFMFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:05:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A3A53090FDB;
        Fri,  6 Sep 2019 12:05:36 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FF8E19C70;
        Fri,  6 Sep 2019 12:05:35 +0000 (UTC)
Date:   Fri, 6 Sep 2019 13:05:34 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 16/18] virtiofs: Use virtio_fs_mutex for races w.r.t
 ->remove and mount path
Message-ID: <20190906120534.GX5900@stefanha-x1.localdomain>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <20190905194859.16219-17-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZcaUvQ23gCOmDTXi"
Content-Disposition: inline
In-Reply-To: <20190905194859.16219-17-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 06 Sep 2019 12:05:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZcaUvQ23gCOmDTXi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 03:48:57PM -0400, Vivek Goyal wrote:
> It is possible that a mount is in progress and device is being removed at
> the same time. Use virtio_fs_mutex to avoid races.
>=20
> This also takes care of bunch of races and removes some TODO items.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)

Let's move to a per-device mutex in the future.  That way a single
device that fails to drain/complete requests will not hang all other
virtio-fs instances.  This is fine for now.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZcaUvQ23gCOmDTXi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yS44ACgkQnKSrs4Gr
c8gUCQf+Lirs+hHg5s88TZfhFQDIDlsjp7llI3ghi4VGGjOuWrHpg5U7YPVCoG+A
+0eiFCQiNg4fqbw/TLcaT8YknKoReHjLZb8waWsV+NWa4EVPLLcQHM4NPVMQpHXg
/CNlyVrgI608sj4hndY5xrbKsnmJdSUBedMLU7nNpnl2dId2yIHYMzHrwsce+Fth
a0bRjYBP1KZqXLaiTi+D7ytBAdRcIyacS+pJ8eeOOk+wOgWaoeQx8oZUfy6/IXyq
hZ+zZpC6c7xcxaNJqgvs+eBG3oQBFJHWCqRtFJad+TSEPgSNOiRU/fcVTAR1Anmj
czpMpNPM8lGfcpjr4tW456SPBRyiVw==
=nWjp
-----END PGP SIGNATURE-----

--ZcaUvQ23gCOmDTXi--
