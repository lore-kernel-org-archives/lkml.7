Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A7EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEDC206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfC1Qgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:36:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfC1Qgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:36:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF7D3315878B;
        Thu, 28 Mar 2019 16:36:48 +0000 (UTC)
Received: from localhost (ovpn-116-113.ams2.redhat.com [10.36.116.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F14718346;
        Thu, 28 Mar 2019 16:36:48 +0000 (UTC)
Date:   Thu, 28 Mar 2019 16:36:47 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vitaly Mayatskih <v.mayatskih@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: zero vhost_vsock memory on allocation
Message-ID: <20190328163647.GE18536@stefanha-x1.localdomain>
References: <1553648174-24913-1-git-send-email-v.mayatskih@gmail.com>
 <20190327164914.GE27283@stefanha-x1.localdomain>
 <CAGF4SLiKv06rzuGprfpWg-EOi8y+DW+cTybCkoT_9OoE+y8tcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Content-Disposition: inline
In-Reply-To: <CAGF4SLiKv06rzuGprfpWg-EOi8y+DW+cTybCkoT_9OoE+y8tcQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 28 Mar 2019 16:36:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2019 at 01:08:53PM -0400, Vitaly Mayatskih wrote:
> On Wed, Mar 27, 2019 at 12:49 PM Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
>=20
> > Which field was accessed before initialization?
> >
> > I ask because the situation is now unclear since code remains that
> > assumes vsock is *not* zero-initialized:
> >
> >   vsock->guest_cid =3D 0; /* no CID assigned yet */
> >
> >   atomic_set(&vsock->queued_replies, 0);
>=20
> It was hash.

vsock->hash is only read if vsock->guest_cid has already been set and
hence vsock->hash has been initialized too.  I don't see where the
problem is.

Was your tree missing commit a72b69dc083a931422cc8a5e33841aff7d5312f2
("vhost/vsock: fix uninitialized vhost_vsock->guest_cid")?

Are you sure the crash can be reproduced on linux.git/master?

Sorry for insisting on so much information but I want to make I fully
understand the issue you encountered.

> > If we're going to zalloc, let's get rid of explicit zero
> > initializations.  Or let's use kvmalloc() and fix the uninitialized
> > access.  Mixing both is confusing.
>=20
> I would go with zalloc, since it's easier to read and it prevents
> further situations like this.
> A zalloc was there originally (not in fallback though).

Sounds good.  Please send a v2 that also removes the explicit zero
initialization since it's no longer needed with zalloc.

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcnPgfAAoJEJykq7OBq3PIRigH/2H5ORZfaJGEE4aM0ajr10TI
6j7s0yIXb/ChPliLQYAEItPZZP1kqUA0nUbFkX+RzbWlivYfUvDmHIeEZPANOpBA
7Ezmlgt5XQhwU0tgdCGL6MJQxyTb2ZE9KvfE1+LJYZnAlB7ZcYDnBTB/2tZew8lN
HOxAxkSAZ3HWeGyPxxXvq3pufK0OZ7BAxP9c+Io5XbqmMMHJz8cmM5ilhqREWYNX
9CsqhAhifw7lo9TwewBDiNH1NcM93nEKviGiXlCYmbKviztovxbzpafl0qu8jC3b
fo5DtppjmJrxLZ+g5guyz3ROSrH+EX2+j8pQhYEWrKfHmocmxqZBzGlFoA3LWD0=
=FVwU
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--
