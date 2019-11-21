Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC17C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550912063A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9KoJ27q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKUQAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:00:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23167 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726293AbfKUQAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574352016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FaPLEQrdTtUL2Ob9GHzV8gvblPJ9sIr1fQNhRCiAn7Q=;
        b=D9KoJ27q006SC4FbEu8QR32tmOHP8QnIeGBv4ykdDZ3yF9cSpeY3TtV3GdbumOfOwnpR3N
        /JWuTU2oO8wFCZ/PWqhAVBOoB+Cs1v19E2MQ56Q/jc20AtgDj1kKUEq/Se9rh2QWnczLWH
        /1myAwhsVYct5MVrVPsuPd1BoXa4rWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-Jp2VdSAyNJmSVgtfRmHTdw-1; Thu, 21 Nov 2019 11:00:12 -0500
X-MC-Unique: Jp2VdSAyNJmSVgtfRmHTdw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29DA49B3A8;
        Thu, 21 Nov 2019 16:00:11 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B833E1081303;
        Thu, 21 Nov 2019 16:00:03 +0000 (UTC)
Date:   Thu, 21 Nov 2019 16:00:01 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dgilbert@redhat.com,
        miklos@szeredi.hu
Subject: Re: [PATCH 2/4] virtiofs: Add an index to keep track of first
 request queue
Message-ID: <20191121160001.GC445244@stefanha-x1.localdomain>
References: <20191115205705.2046-1-vgoyal@redhat.com>
 <20191115205705.2046-3-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191115205705.2046-3-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 03:57:03PM -0500, Vivek Goyal wrote:
> @@ -1004,6 +1008,7 @@ __releases(fiq->lock)
>  =09spin_unlock(&fiq->lock);
> =20
>  =09fs =3D fiq->priv;
> +=09queue_id =3D fs->first_reqq_idx;

The TODO should be moved here.

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WtIEACgkQnKSrs4Gr
c8gp1wf9FsjNknItwwiYqgaMkCFsD/lJY+7ZWvz25GCPp4aHChGQMvg/GBxEXbUs
d2n5sxD4UcV/wmUt3amPMondoXmfLu//QOg0X5+ftyWLbVK7Tq0rO+hPkysOeP+6
2svIACl5UtYuzU3SxRS5nY3CGZ3/HxLKgJyLVhorSNXacI6ijRHZLnLDEqXU/90o
GCVuxTJfvf8UMQ42KSjwmCM+hyWb9HlNj/NoSZ63K8Zq6Y41N45bx+36k9J8LIlQ
UaFITc5HT6wWTHN0tVJxRQVsV5ZEBx1lauzDLxKCsD47+AJOMDhX/5mbVkndJZS/
xuPiSOtg8Is+zto/rTm+wN9K4/gEAw==
=Cosk
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--

