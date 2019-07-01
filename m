Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3380CC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16088206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfGATcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:32:50 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45972 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfGATct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 15:32:49 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hi22h-00006O-IZ; Mon, 01 Jul 2019 15:32:47 -0400
Message-ID: <4bf9c6e1eeec9b52aa9c10b9149384cb99399b04.camel@surriel.com>
Subject: Re: [PATCH 03/10] sched,fair: redefine runnable_load_avg as the sum
 of task_h_load
From:   Rik van Riel <riel@surriel.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Date:   Mon, 01 Jul 2019 15:32:47 -0400
In-Reply-To: <20190701192234.5oxkuysimi437utz@macbook-pro-91.dhcp.thefacebook.com>
References: <20190628204913.10287-1-riel@surriel.com>
         <20190628204913.10287-4-riel@surriel.com>
         <20190701162949.vhxjndychoamhkbq@MacBook-Pro-91.local.dhcp.thefacebook.com>
         <757e0af14b714b596417b31c45098fc314ed7c8a.camel@surriel.com>
         <20190701192234.5oxkuysimi437utz@macbook-pro-91.dhcp.thefacebook.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-G0E3IlZFVcKl+naxuyrr"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-G0E3IlZFVcKl+naxuyrr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-07-01 at 15:22 -0400, Josef Bacik wrote:
> On Mon, Jul 01, 2019 at 12:47:35PM -0400, Rik van Riel wrote:
> > On Mon, 2019-07-01 at 12:29 -0400, Josef Bacik wrote:
> > >=20
> > > My memory on this stuff is very hazy, but IIRC we had the
> > > runnable_sum and the
> > > runnable_avg separated out because you could have the avg lag
> > > behind
> > > the sum.
> > > So like you enqueue a bunch of new entities who's avg may have
> > > decayed a bunch
> > > and so their overall load is not felt on the CPU until they start
> > > running, and
> > > now you've overloaded that CPU.  The sum was there to make sure
> > > new
> > > things
> > > coming onto the CPU added actual load to the queue instead of
> > > looking
> > > like there
> > > was no load.
> > >=20
> > > Is this going to be a problem now with this new code?
> >=20
> > That is a good question!
> >=20
> > On the one hand, you may well be right.
> >=20
> > On the other hand, while I see the old code calculating
> > runnable_sum, I don't really see it _using_ it to drive
> > scheduling decisions.
> >=20
> > It would be easy to define the CPU cfs_rq->runnable_load_sum
> > as being the sum of task_se_h_weight() of each runnable task
> > on the CPU (for example), but what would we use it for?
> >=20
> > What am I missing?
>=20
> It's suuuuuper sublte, but you're right in that we don't really need
> the
> runnable_avg per-se, but what you do is you kill calc_group_runnable,
> which used
> to do this
>=20
> load_avg =3D max(cfs_rq->avg.load_avg,
>                scale_load_down(cfs_rq->load.weight));
>=20
> runnable =3D max(cfs_rq->avg.runnable_load_avg,
>                scale_load_down(cfs_rq->runnable_weight));
>=20
> so we'd account for this weirdness of adding a previously idle
> process to a new
> CPU and overloading the CPU because we'd add a bunch of these 0
> weight looking
> tasks that suddenly all wake up and are on the same CPU.  So we used
> the
> runnable_weight to account for what was actually happening, and the
> max of
> load_avg and the weight to figure out what the potential load would
> be.
>=20
> What you've done here is change the weighting stuff to be completely
> based on
> load avg, which is problematic for the reasons above.  Did you fix
> this later on
> in your patches?  If so then just tell me to keep reading and I'll do
> that ;).

No, I have not fixed that later in the code.

I am not entirely sure how I could do that, without
reintroducing walking the hierarchy at task enqueue
and dequeue, but maybe you have some idea...

--=20
All Rights Reversed.

--=-G0E3IlZFVcKl+naxuyrr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0aX98ACgkQznnekoTE
3oOQLwf/V7laRZB80HojKDUBvWPexAXiERPG6bdrZTlssrh8dnwDYtmnSHAibtqd
UzoMDXpZRe455omNpUB4F7tyBlrds3jbDJmaoOaVDJnPQTaJRVBGddfIn7QRYdkF
MGuQqodBHwjwiKX4m2Lh0gJE/msyNd3tbDYH58yRf4m/N6Sty2dOCBwuP5QGbB3v
iCsTMs3LJOQifwIVZlyNEMvHwlGJBHXrB2Uuv0Ya5e9SQHTooqTAj9ZjpQgQ4nQj
AImBeflH3cD17Msk6JuCRTMaFiuhsUOMUHGiHFB+VSQnAPZ83Y3e1jLgr3ekLw2n
gwSIHBh+vb5zsRsmkCeSIISwupydLg==
=7Xe7
-----END PGP SIGNATURE-----

--=-G0E3IlZFVcKl+naxuyrr--

