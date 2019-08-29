Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70BDC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72852077B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfH2SG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:06:26 -0400
Received: from shelob.surriel.com ([96.67.55.147]:47764 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfH2SG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:06:26 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i3OoI-0007h4-Ne; Thu, 29 Aug 2019 14:06:14 -0400
Message-ID: <ecfd9e0ff6e0697f18f9b9d2f6df9462e602aa0b.camel@surriel.com>
Subject: Re: [PATCH 13/15] sched,fair: propagate sum_exec_runtime up the
 hierarchy
From:   Rik van Riel <riel@surriel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, peterz@infradead.org,
        mingo@redhat.com, morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Date:   Thu, 29 Aug 2019 14:06:14 -0400
In-Reply-To: <1d631d5e-e606-4915-440f-fb00daa41fa5@arm.com>
References: <20190822021740.15554-1-riel@surriel.com>
         <20190822021740.15554-14-riel@surriel.com>
         <f940abf6-3020-014c-74d7-d9be334e201c@arm.com>
         <a35dd83b9ecadf4e136b588d7696a23e36ff2e9a.camel@surriel.com>
         <1d631d5e-e606-4915-440f-fb00daa41fa5@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Y8gRDCgIYuhlhpKtgQ3u"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Y8gRDCgIYuhlhpKtgQ3u
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-29 at 19:20 +0200, Dietmar Eggemann wrote:
> On 28/08/2019 15:14, Rik van Riel wrote:
> > On Wed, 2019-08-28 at 09:51 +0200, Dietmar Eggemann wrote:
> > > On 22/08/2019 04:17, Rik van Riel wrote:
> > > > Now that enqueue_task_fair and dequeue_task_fair no longer
> > > > iterate
> > > > up
> > > > the hierarchy all the time, a method to lazily propagate
> > > > sum_exec_runtime
> > > > up the hierarchy is necessary.
> > > >=20
> > > > Once a tick, propagate the newly accumulated exec_runtime up
> > > > the
> > > > hierarchy,
> > > > and feed it into CFS bandwidth control.
> > > >=20
> > > > Remove the pointless call to account_cfs_rq_runtime from
> > > > update_curr,
> > > > which is always called with a root cfs_rq.
> > >=20
> > > But what about the call to account_cfs_rq_runtime() in
> > > set_curr_task_fair()? Here you always call it with the root
> > > cfs_rq.
> > > Shouldn't this be called also in a loop over all se's until !se-
> > > > parent
> > > (like in propagate_exec_runtime() further below).
> >=20
> > I believe that call should be only on the cgroup
> > cfs_rq, with account_cfs_rq_runtime figuring out
> > whether more runtime needs to be obtained from
> > further up in the hierarchy.
>=20
> So like this?
>=20
> @@ -10248,7 +10248,8 @@ static void set_curr_task_fair(struct rq *rq)
>=20
>         set_next_entity(cfs_rq, se);
>         /* ensure bandwidth has been allocated on our new cfs_rq */
> -       account_cfs_rq_runtime(cfs_rq, 0);
> +       if (task_se_in_cgroup(se))
> +               account_cfs_rq_runtime(group_cfs_rq_of_parent(se),
> 0);
>  }
>=20
> I fail to understand the second part of your sentence, and
> how is this related to the code in propagate_exec_runtime():
>=20
> for_each_sched_entity(se) {
>=20
>     propagate_exec_runtime() {
>=20
>         if (parent)
>             account_cfs_rq_runtime(cfs_rq, diff);
>     }
> }

I am not sure how that would work for distributing
runtime, since runtime would have to be distributed
downwards and on demand, no?

That seems like a very different code path than
"upwards, and periodically".

Then again, I have not worked out all the details
of reimplementing CFS bandwidth yet...

> > By default we should probably work under the assumption
> > that account_cfs_rq_runtime() will succeed at the current
> > level, and no gymnastics are required to obtain CPU time.
>=20
> Maybe this all will become clearer when the reworked CFS Bandwidth
> support is ready ;-) I see this patch as the first part of it.

That is one of the reasons I have not been "fixing"
CFS bandwidth related code in the current patch series.

Having all of those changes in one location seems like
it would be best.

--=20
All Rights Reversed.

--=-Y8gRDCgIYuhlhpKtgQ3u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1oFBYACgkQznnekoTE
3oN3Bwf9FQ2idXqyCOfvpwuDjCR1BA6kw1IG8VP/vWWhZQA1GGlgd+epCkPR53vT
uz5nHvQPVbreT7ilvywvAJNRV6Ht9AS5cPRFzqs6+mM81E2JCMMWl/EEiCQuVoMp
TXjKFLIVu3S2sdLlbQIVhKw9CueobEJ6UckVnQNmTjKznvb9TFXBI5i4iISzAjyE
SRyr1A3QKcUbueQgEt50hD938aM57ZmB111czBVZux9fTbMVlOJuDJ1EhwNasnNp
MazD58+8v3+Bcx6EQHfXsdOLMiepvQTxAosov7pKi/RcallBeUFoHSVY6IFsm5hf
DKBe95u5RbwRAlyM4vzQ0mvf6vHdqA==
=3gog
-----END PGP SIGNATURE-----

--=-Y8gRDCgIYuhlhpKtgQ3u--

