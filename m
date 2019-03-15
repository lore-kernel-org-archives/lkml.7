Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F187C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B81421871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfCOGwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 02:52:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:56306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727905AbfCOGwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 02:52:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0082DACEC;
        Fri, 15 Mar 2019 06:52:01 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri, 15 Mar 2019 17:51:55 +1100
Cc:     Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rhashtable: use cmpxchg() in nested_table_alloc()
In-Reply-To: <20190315051029.waqb3ohztl7w6zep@gondor.apana.org.au>
References: <155253979234.5022.1840929790507376038.stgit@noble.brown> <155253992824.5022.10318044793639169265.stgit@noble.brown> <20190315051029.waqb3ohztl7w6zep@gondor.apana.org.au>
Message-ID: <87lg1gocj8.fsf@notabene.neil.brown.name>
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

On Fri, Mar 15 2019, Herbert Xu wrote:

> Hi Neil:
>
> On Thu, Mar 14, 2019 at 04:05:28PM +1100, NeilBrown wrote:
>> nested_table_alloc() relies on the fact that there is
>> at most one spinlock allocated for every slot in the top
>> level nested table, so it is not possible for two threads
>> to try to allocate the same table at the same time.
>>=20
>> This assumption is a little fragile (it is not explicit) and is
>> unnecessary.  We can instead protect against
>> a race using cmpxchg() - if it the cmp fails, free the table
>> that was just allocated.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>  lib/rhashtable.c |    8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> You probably explained it to me before but it's been long enough
> that I no longer remember why we need this change.  So please
> explain in the commit log why this change is needed.  Because
> on the face of it you are adding locking/sychronisation and not
> taking it away.
>

I hoped the patch could be justified on the basis that the current
behaviour is fragile - the dependency that a single spin lock covers a
while slot (and all children) in the top-level nested table is not at
all obvious.

I do have a stronger reason though - I want the replace the spinlocks
with bit-spin-locks.  With those we will only hold a lock for the
particular chain being worked on.  If you need that extra explanation to
justify the patch, I'll hold it over until the other two patches land
and the rest of the bit-spin-lock series is ready.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyLS4sACgkQOeye3VZi
gblQUQ//RBzixG4gFwOatP9rLrNit/9H4cnPHvtaJOIdW56aCWCUa8L5/BaPOKNP
vbQA/17jXhVYYpLQHtB94j3g+gCZ48uF3heolfwMejbYeheionbwrw+h/zEmS2MF
3zi25k6hzybkO6TEsNotPG0cJ+99wT7AGqlZm+EzHEjKW1K8T7DWbcGaYx/2c7ZY
MpnE46wbDSWBuROuHH3WFUHC23O6TyUcHaRaA3yfHkrVBsLCo1sy+NX7NLBYSERe
EzgmocJ0l4wUBlQeet3tGlShCv2jdPm6cloelE8E8rys4E1h5pH/2m4FtxUgkPmZ
KqnlJog7EnqM2J02OO3M1yY2GjIDlSvQSv4Fx2ig6fPN0Wn8/yXOYy+fzmMR8BOl
gBT//zy+ENSHogo4eJLqV6//3g1OkWk8LYXp6te7z3tCHiXI0XMvNxHuJSgzhkUS
Y7PahZ2ZSRPa28xKiCbkj8LF1+gN6qF+QIT1Ofnzxdpp4AKNuX5PXMXNUIHLdcAh
AAT/hHsqM/T5qt44IGR54EtUq0w6hXymVGuqC4Qj7HsWsw54v1m4Xikwi58NjGSr
ZKeUqahKHZwcI4Sg1s4t/EwSOJzyiK6F76Mbb1PYZzbVGJd2Mrm2QCEJ61wkDEbR
rTBcUyF+P2GZO4HaAi4PzDkHIF7wOmx8rlw41q/BILxslS0P1zg=
=f/1C
-----END PGP SIGNATURE-----
--=-=-=--
