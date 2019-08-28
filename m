Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B48C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386D02070B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfH1NPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:15:08 -0400
Received: from shelob.surriel.com ([96.67.55.147]:60812 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfH1NPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:15:07 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i2xmp-0008Gg-ES; Wed, 28 Aug 2019 09:14:55 -0400
Message-ID: <a35dd83b9ecadf4e136b588d7696a23e36ff2e9a.camel@surriel.com>
Subject: Re: [PATCH 13/15] sched,fair: propagate sum_exec_runtime up the
 hierarchy
From:   Rik van Riel <riel@surriel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, peterz@infradead.org,
        mingo@redhat.com, morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Date:   Wed, 28 Aug 2019 09:14:54 -0400
In-Reply-To: <f940abf6-3020-014c-74d7-d9be334e201c@arm.com>
References: <20190822021740.15554-1-riel@surriel.com>
         <20190822021740.15554-14-riel@surriel.com>
         <f940abf6-3020-014c-74d7-d9be334e201c@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-YVLA9/K5jNpds7mVVwG8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YVLA9/K5jNpds7mVVwG8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-28 at 09:51 +0200, Dietmar Eggemann wrote:
> On 22/08/2019 04:17, Rik van Riel wrote:
> > Now that enqueue_task_fair and dequeue_task_fair no longer iterate
> > up
> > the hierarchy all the time, a method to lazily propagate
> > sum_exec_runtime
> > up the hierarchy is necessary.
> >=20
> > Once a tick, propagate the newly accumulated exec_runtime up the
> > hierarchy,
> > and feed it into CFS bandwidth control.
> >=20
> > Remove the pointless call to account_cfs_rq_runtime from
> > update_curr,
> > which is always called with a root cfs_rq.
>=20
> But what about the call to account_cfs_rq_runtime() in
> set_curr_task_fair()? Here you always call it with the root cfs_rq.
> Shouldn't this be called also in a loop over all se's until !se-
> >parent
> (like in propagate_exec_runtime() further below).

I believe that call should be only on the cgroup
cfs_rq, with account_cfs_rq_runtime figuring out
whether more runtime needs to be obtained from
further up in the hierarchy.

By default we should probably work under the assumption
that account_cfs_rq_runtime() will succeed at the current
level, and no gymnastics are required to obtain CPU time.

--=20
All Rights Reversed.

--=-YVLA9/K5jNpds7mVVwG8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1mfk8ACgkQznnekoTE
3oMqrQf6A9CIcHBD91ysYlu6dqDA472OlW0Ml7c5n9B2nC6WM/+J7740PEMEZ2xv
qnISoltSnfLcveWrykUn7UBsn4QZX+sCLDA4TSK/gkOsmhdyEvW7cleM4muKE5Ff
t+6zoTRTs2KoLPtoMUi3q4Ew0I2521pwZ0HfUoFDEm5b1fE/LHil7oiOZGv5UVV+
37b+SPUs4kZ1lbm9p28LQDd56Dck/TgFo3OlZA5O4IWP32U1MMl+qMls3YQSNbKk
n1jgT7F8ftWjyEZhU4dH919suovk7qWUXB15Jdg/wFR/gUG+jbXqwmluIpF+/Zzq
Wwtr2rWLnZHnbMQJVZIA/+9zq5g8Bg==
=yfel
-----END PGP SIGNATURE-----

--=-YVLA9/K5jNpds7mVVwG8--

