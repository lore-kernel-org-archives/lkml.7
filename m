Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571CCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225C82147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfCKVuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:50:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:52470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727500AbfCKVuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:50:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E958B0F2;
        Mon, 11 Mar 2019 21:50:16 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     paulmck@linux.ibm.com
Date:   Tue, 12 Mar 2019 08:50:05 +1100
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        neeraju@codeaurora.org
Subject: Re: [PATCH 2/5] rhashtable: don't hold lock on first table throughout insertion.
In-Reply-To: <20190311152752.GA10700@linux.ibm.com>
References: <20180724225825.GE12945@linux.vnet.ibm.com> <87in53oqzz.fsf@notabene.neil.brown.name> <20180725152250.GN12945@linux.vnet.ibm.com> <87r2jpmqu2.fsf@notabene.neil.brown.name> <20180727031815.GW24813@linux.vnet.ibm.com> <20180727145731.GA2780@linux.vnet.ibm.com> <87zhy8s05i.fsf@notabene.neil.brown.name> <20180731041425.GI24813@linux.vnet.ibm.com> <87lg9sro5r.fsf@notabene.neil.brown.name> <20180731144429.GM24813@linux.vnet.ibm.com> <20190311152752.GA10700@linux.ibm.com>
Message-ID: <874l89qdwy.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11 2019, Paul E. McKenney wrote:

> On Tue, Jul 31, 2018 at 07:44:29AM -0700, Paul E. McKenney wrote:
>> On Tue, Jul 31, 2018 at 03:04:48PM +1000, NeilBrown wrote:
>> > On Mon, Jul 30 2018, Paul E. McKenney wrote:
>> >=20
>> > > On Tue, Jul 31, 2018 at 10:45:45AM +1000, NeilBrown wrote:
>> > >> On Fri, Jul 27 2018, Paul E. McKenney wrote:
>> > >>=20
>> > >> > On Thu, Jul 26, 2018 at 08:18:15PM -0700, Paul E. McKenney wrote:
>> > >> >> On Fri, Jul 27, 2018 at 11:04:37AM +1000, NeilBrown wrote:
>> > >> >> > On Wed, Jul 25 2018, Paul E. McKenney wrote:
>> > >> >> > >>=20
>> > >> >> > >> Looks good ... except ... naming is hard.
>> > >> >> > >>=20
>> > >> >> > >>  is_after_call_rcu_init()  asserts where in the lifecycle w=
e are,
>> > >> >> > >>  is_after_call_rcu() tests where in the lifecycle we are.
>> > >> >> > >>=20
>> > >> >> > >>  The names are similar but the purpose is quite different.
>> > >> >> > >>  Maybe s/is_after_call_rcu_init/call_rcu_init/ ??
>> > >> >> > >
>> > >> >> > > How about rcu_head_init() and rcu_head_after_call_rcu()?
>> > >> >>=20
>> > >> >> Very well, I will pull this change in on my next rebase.
>> > >> >
>> > >> > Like this?
>> > >>=20
>> > >> Hard to say - unwinding white-space damage in my head is too challe=
nging
>> > >> when newlines have been deleted :-(
>> > >
>> > > What???  Don't you like block-structured code?
>> > >
>> > > All kidding aside, how about the following more conventionally forma=
tted
>> > > version?
>> >=20
>> > Wow - it's like I just got new glasses!
>> > Yes - nice an clear and now flaws to be found.  Thanks a lot.
>>=20
>> Now that flaws are to be found, please feel free to report them.  ;-)
>
> Hello, Neil,
>
> Any plans to use these functions?  There are still no upstream uses.
> On the other hand, if they proved unuseful, I will remove them.  If I
> don't hear otherwise from you, I will pull them in v5.2.

Hi Paul,
 yes, I do still have plans for them.  I've got quite a few things I
 want to add to rhashtables including this, but got stalled late last
 year and I haven't managed to get back to it.
 Thanks for your prompting - I'll make an effort to post some patches
 soon, particularly the one that makes use of this new functionality.

Thanks,
NeilBrown


>
> 							Thanx, Paul
>
>> > NeilBrown
>> >=20
>> > >
>> > > 							Thanx, Paul
>> > >
>> > > --------------------------------------------------------------------=
----
>> > >
>> > > commit e3408141ed7d702995b2fdc94703af88aadd226b
>> > > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> > > Date:   Tue Jul 24 15:28:09 2018 -0700
>> > >
>> > >     rcu: Provide functions for determining if call_rcu() has been in=
voked
>> > >=20=20=20=20=20
>> > >     This commit adds rcu_head_init() and rcu_head_after_call_rcu() f=
unctions
>> > >     to help RCU users detect when another CPU has passed the specifi=
ed
>> > >     rcu_head structure and function to call_rcu().  The rcu_head_ini=
t()
>> > >     should be invoked before making the structure visible to RCU rea=
ders,
>> > >     and then the rcu_head_after_call_rcu() may be invoked from within
>> > >     an RCU read-side critical section on an rcu_head structure that
>> > >     was obtained during a traversal of the data structure in questio=
n.
>> > >     The rcu_head_after_call_rcu() function will return true if the r=
cu_head
>> > >     structure has already been passed (with the specified function) =
to
>> > >     call_rcu(), otherwise it will return false.
>> > >=20=20=20=20=20
>> > >     If rcu_head_init() has not been invoked on the rcu_head structure
>> > >     or if the rcu_head (AKA callback) has already been invoked, then
>> > >     rcu_head_after_call_rcu() will do WARN_ON_ONCE().
>> > >=20=20=20=20=20
>> > >     Reported-by: NeilBrown <neilb@suse.com>
>> > >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> > >     [ paulmck: Apply neilb naming feedback. ]
>> > >
>> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>> > > index e4f821165d0b..4db8bcacc51a 100644
>> > > --- a/include/linux/rcupdate.h
>> > > +++ b/include/linux/rcupdate.h
>> > > @@ -857,6 +857,46 @@ static inline notrace void rcu_read_unlock_sche=
d_notrace(void)
>> > >  #endif /* #else #ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE */
>> > >=20=20
>> > >=20=20
>> > > +/* Has the specified rcu_head structure been handed to call_rcu()? =
*/
>> > > +
>> > > +/*
>> > > + * rcu_head_init - Initialize rcu_head for rcu_head_after_call_rcu()
>> > > + * @rhp: The rcu_head structure to initialize.
>> > > + *
>> > > + * If you intend to invoke rcu_head_after_call_rcu() to test whethe=
r a
>> > > + * given rcu_head structure has already been passed to call_rcu(), =
then
>> > > + * you must also invoke this rcu_head_init() function on it just af=
ter
>> > > + * allocating that structure.  Calls to this function must not race=
 with
>> > > + * calls to call_rcu(), rcu_head_after_call_rcu(), or callback invo=
cation.
>> > > + */
>> > > +static inline void rcu_head_init(struct rcu_head *rhp)
>> > > +{
>> > > +	rhp->func =3D (rcu_callback_t)~0L;
>> > > +}
>> > > +
>> > > +/*
>> > > + * rcu_head_after_call_rcu - Has this rcu_head been passed to call_=
rcu()?
>> > > + * @rhp: The rcu_head structure to test.
>> > > + * @func: The function passed to call_rcu() along with @rhp.
>> > > + *
>> > > + * Returns @true if the @rhp has been passed to call_rcu() with @fu=
nc,
>> > > + * and @false otherwise.  Emits a warning in any other case, includ=
ing
>> > > + * the case where @rhp has already been invoked after a grace perio=
d.
>> > > + * Calls to this function must not race with callback invocation.  =
One way
>> > > + * to avoid such races is to enclose the call to rcu_head_after_cal=
l_rcu()
>> > > + * in an RCU read-side critical section that includes a read-side f=
etch
>> > > + * of the pointer to the structure containing @rhp.
>> > > + */
>> > > +static inline bool
>> > > +rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
>> > > +{
>> > > +	if (READ_ONCE(rhp->func) =3D=3D f)
>> > > +		return true;
>> > > +	WARN_ON_ONCE(READ_ONCE(rhp->func) !=3D (rcu_callback_t)~0L);
>> > > +	return false;
>> > > +}
>> > > +
>> > > +
>> > >  /* Transitional pre-consolidation compatibility definitions. */
>> > >=20=20
>> > >  static inline void synchronize_rcu_bh(void)
>> > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
>> > > index 5dec94509a7e..4c56c1d98fb3 100644
>> > > --- a/kernel/rcu/rcu.h
>> > > +++ b/kernel/rcu/rcu.h
>> > > @@ -224,6 +224,7 @@ void kfree(const void *);
>> > >   */
>> > >  static inline bool __rcu_reclaim(const char *rn, struct rcu_head *h=
ead)
>> > >  {
>> > > +	rcu_callback_t f;
>> > >  	unsigned long offset =3D (unsigned long)head->func;
>> > >=20=20
>> > >  	rcu_lock_acquire(&rcu_callback_map);
>> > > @@ -234,7 +235,9 @@ static inline bool __rcu_reclaim(const char *rn,=
 struct rcu_head *head)
>> > >  		return true;
>> > >  	} else {
>> > >  		RCU_TRACE(trace_rcu_invoke_callback(rn, head);)
>> > > -		head->func(head);
>> > > +		f =3D head->func;
>> > > +		WRITE_ONCE(head->func, (rcu_callback_t)0L);
>> > > +		f(head);
>> > >  		rcu_lock_release(&rcu_callback_map);
>> > >  		return false;
>> > >  	}
>>=20
>>=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyG2A0ACgkQOeye3VZi
gbmQhg/9G8CjVJNnvsmrt6UIntBjlPZxZeno0sVyVVWlZ8+daxawKIfWmp8811zG
H3oVZ1NHQCzlmY1iVvZODW+cfKrrRiFdU30VBLvWUsZVmBhPhqTvoEPWJa0+RB1Q
5j3WRYMr/CLuGOzmTEjpY/FrRvKr4WRi2HZ3RqxKR9STIKdS1qtSvB1c85ho60ie
fBOdQwNuucYwygmV4YcWJqqwAn4qSQ47ZRGXHJBn2mT0me4IpI+fOI3iYnRqiXzy
anD6RabMhThkYHwAUuV+IMqydmJMvLRGOYiJ1vPbU9b84E6Vcp1AbTFPGwWg+wcA
CxKAA1p9VGtHy4aZzW42bEEtGZP/sumkaWb5UhLQ82WoHKZuyn5vAnzEqeygx+YS
M4E+Mk9olaZctvTSGvUOr4y4B7is1qNGZwN5rjmIP9Wf8qaMNrPlc6lEdH4pS6uW
AhfwlHrGRgxyavDaHChaNbIrAOVPVpVx9Yo33gLWqWz6wc0UuIncTGyLPJA9Q08h
+NQEdIisVkavm9eUGGFm303QaxNHckGOGvcPQNbAQ9jG6Y8pd4Zk6P6cCCDGxVcr
Mb/DY+JisFRi6H56WyqRIWsalQAQDQc8RqN/m7yEx3KdrlacJPT8D5PVMEXRMSIQ
6ZIYTg8+L0hDV1FCLUrD0w0kWuPv2fWzYU1MhCe1zm9LK8HFYfw=
=i37E
-----END PGP SIGNATURE-----
--=-=-=--
