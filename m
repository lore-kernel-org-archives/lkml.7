Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E48AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EF02075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfC0BFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:05:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731579AbfC0BFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:05:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A1FA3ABA1;
        Wed, 27 Mar 2019 01:05:17 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Date:   Wed, 27 Mar 2019 09:35:18 +1100
Cc:     Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash bucket.
In-Reply-To: <20190326050320.gwk3tgtqwl5csivt@gondor.apana.org.au>
References: <155349021177.1111.15681654355431465791.stgit@noble.brown> <155349033961.1111.18247269615646768227.stgit@noble.brown> <20190326050320.gwk3tgtqwl5csivt@gondor.apana.org.au>
Message-ID: <874l7p463d.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Tue, Mar 26 2019, Herbert Xu wrote:

> On Mon, Mar 25, 2019 at 04:05:39PM +1100, NeilBrown wrote:
>>
>> + * Sometimes we unlock a bucket by writing a new pointer there.  In that
>> + * case we don't need to unlock, but we do need to reset state such as
>> + * local_bh. For that we have rht_unlocked().  This doesn't include
>> + * the memory barrier that bit_spin_unlock() provides, but rcu_assign_pointer()
>> + * will have provided that.
>
> Hmm, are you sure that's enough? IIRC rcu_assign_pointer only
> provides a write barrier compared to the more complete (but one-way)
> barrier that a spin-lock provides.
>

The bit_spin_unlock(), which I am avoiding as unnecessary, would have
provided release semantics.
i.e. any write by this CPU that happened before the releasing write
will be visible to other CPUs before (or when) they see the result of
the releasing write.
This is (as I understand it) exactly that rcu_assign_pointer() promises
- even before acquire semantics were added as Paul just reported.

So yes, I am sure (surer now that I've walked through it carefully).

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyaqSYACgkQOeye3VZi
gblG1BAAugBQSAHkt7j0YxxaNGdLzZFDd1c7CFpL3USh8KEqNJlSZidq0g+746mk
YlEW67d9PUu0ey4A1dalzjD3vD/ti4MCy1GqWS5LF+JV1GoYOpFesq6aHi28yBsf
JeFHBBk8EBiKZ3LspXL9sjd/KodwbujTEtQKw0Ax1FJWizCMiF8g80G+Ly3RjUn3
8QF3WHCgdjNfPcHXmMkLnRVXEnKRUSgutvPTj9rPSdhUme3ZLcQFee3ff+HbKD9r
BSun9EA8nEW+9wfFscXu+F0we5l+cmATr8sK9y4OEyiu+HCdj3JgG3lOiAaDeW3+
ZOuoX8C3AUsDpBMQB3Xx0nppDnl7cI3WW7JmLnIAAIyk8fKrJBYaXNQX0xlxGipu
c2HDn738xwBMGd1ECfQECXDEANUjGdmSXR/sZISx3rPjIgyyYRllgvV3LvcdhZk4
f9cB8LEkmW3Vo1+M4J1CT8Iwb6LFVJrqxbc8HlzIEyBMUEqIJiKwR+plTUeeXPUd
NfF83LluCow4a12uFWyn86jqydlxeHKe1qqPFPZGexHDWvnHJNsmGxGWU75I0Knq
w6xikBUm9tcQauQVRXmF85Fv6AnbLapyAiYSEuG+oKvr5xvwd+1/hQaGRcZ5Oj1k
j3FgQ+tECDpaMcFh6FAHO1XLq4TD3EbOmX1eT201gIJdjzeQeS4=
=u/o4
-----END PGP SIGNATURE-----
--=-=-=--
