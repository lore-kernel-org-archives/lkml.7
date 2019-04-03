Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C25C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B8B2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDCAzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 20:55:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:44438 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726089AbfDCAzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 20:55:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2E8EACC1;
        Wed,  3 Apr 2019 00:55:11 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>
Date:   Wed, 03 Apr 2019 11:55:01 +1100
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/24] Convert vfs.txt to vfs.rst
In-Reply-To: <5c5e02f8b8add4aa2fc24ba2a0880652529588af.camel@themaw.net>
References: <20190327051717.23225-1-tobin@kernel.org> <20190402094934.5b242dc0@lwn.net> <20190402164824.GK2217@ZenIV.linux.org.uk> <20190402175401.GL2217@ZenIV.linux.org.uk> <20190402190811.GM2217@ZenIV.linux.org.uk> <5c5e02f8b8add4aa2fc24ba2a0880652529588af.camel@themaw.net>
Message-ID: <87ftqz29i2.fsf@notabene.neil.brown.name>
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

On Wed, Apr 03 2019, Ian Kent wrote:

> On Tue, 2019-04-02 at 20:08 +0100, Al Viro wrote:
>> On Tue, Apr 02, 2019 at 06:54:01PM +0100, Al Viro wrote:
>> > static void autofs_dentry_release(struct dentry *de)
>> > {
>> >         struct autofs_info *ino =3D autofs_dentry_ino(de);
>> >         struct autofs_sb_info *sbi =3D autofs_sbi(de->d_sb);
>> >=20
>> >         pr_debug("releasing %p\n", de);
>> >=20
>> >         if (!ino)
>> >                 return;
>> > ...
>> >         autofs_free_ino(ino);
>> > }
>> > with autofs_free_ino() being straight kfree().  Which means
>> > that the lockless case of autofs_d_manage() can run into
>> > autofs_dentry_ino(dentry) getting freed right under it.
>> >=20
>> > And there we do have this reachable:
>> > int autofs_expire_wait(const struct path *path, int rcu_walk)
>> > {
>> >         struct dentry *dentry =3D path->dentry;
>> >         struct autofs_sb_info *sbi =3D autofs_sbi(dentry->d_sb);
>> >         struct autofs_info *ino =3D autofs_dentry_ino(dentry);
>> >         int status;
>> >         int state;
>> >=20
>> >         /* Block on any pending expire */
>> >         if (!(ino->flags & AUTOFS_INF_WANT_EXPIRE))
>
> Oh yes, this is saying the dentry hasn't been selected
> for expire on the first pass, there's a second pass at
> expire selection so there's a delay there and both flags
> (this one and the expiring flag) are kept throughout the
> expire operation if dentry is selected.
>
> That might be partly why an oops has never been seen but
> path walks can occur at any time so it's a bit puzzling.
>
> LOL, and Neil probably can't remember the deeper detail
> on what he did there now either.

It seems very likely that this was just a subtlety that I missed.
I doesn't help that "ino" isn't actually and inode and isn't freed like
an inode, but that is no excuse.

When we add the rcu_head linkage to 'struct autofs_info', we might as
well remove the 'struct inode' from there - it doesn't seem to have been
used for years.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlykBGUACgkQOeye3VZi
gbnd2Q//Q4rAbmynw2Vea6ZsNkYJl8xmUtC8mF44+qGvLBuqQ3RbBgLoz2fhqN7Y
dAyfAo/OYRjQwrHRc2Udb4mmDGL48ckGWaunAueEcMBpnh34S8/vTWY2WKq1b5Vs
40ypXGmmH9Bgj3LRb7D7hFxBVM73M75J3T4AwlH3FTLcrOLLGtlMsKdxC1JWO49Z
mzzKm2EoaR5YTMUJsmfU91wvr+qGJanDQMMRSiuB6BwdxsbywwZ7bk5hVF/Gm6Od
hUajm/STGohToEWUVL6ZsqjouadIVmxy1xaq0uDh/GSMKwh0ugT/OYnMzQcWE3sg
4V2sfX/WW4qHl8ugoMEjNut4y28SGKxky5C7yNCbqE/Qj85nv10toSqJIjI/VV4O
WSzv1vvQasZxyDmh6fcpF6JCI8TefRmzA0pf8SsH0QTqmZUfIib+W3RdZ72JbwX7
x6dtNH3B7l/PDovOEJX4lmW7Jz5JMjin99ZN6oew5Y8ap35vi+zbJqP87QwAbP2W
Fy6BGMRmjka/7NS3QgDdoZubANZRuZI0q7TByMzxP2n8END2vTFsDTTg3NVyA/XF
zNYwlSlBwoWhATFjrGwib1bs0WCuEyT0+M0Rb+CXQ0kfpl3De/6ZkryfDRzaQygo
K/34vVhWC2Rg5/yJgMjCXTr0FL+KvM9XGPt9Bn9Noi6jY5GL680=
=SSWA
-----END PGP SIGNATURE-----
--=-=-=--
