Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324D1C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4BD2245C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfLEW3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 17:29:31 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:46240 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfLEW3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 17:29:30 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9E6411C246E; Thu,  5 Dec 2019 23:29:28 +0100 (CET)
Date:   Thu, 5 Dec 2019 23:29:28 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+7857962b4d45e602b8ad@syzkaller.appspotmail.com
Subject: Re: [PATCH 4.19 242/321] kvm: properly check debugfs dentry before
 using it
Message-ID: <20191205222928.GD25107@duo.ucw.cz>
References: <20191203223427.103571230@linuxfoundation.org>
 <20191203223439.731003476@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
In-Reply-To: <20191203223439.731003476@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> [ Upstream commit 8ed0579c12b2fe56a1fac2f712f58fc26c1dc49b ]
>=20
> debugfs can now report an error code if something went wrong instead of
> just NULL.  So if the return value is to be used as a "real" dentry, it
> needs to be checked if it is an error before dereferencing it.
>=20
> This is now happening because of ff9fb72bc077 ("debugfs: return error
> values, not NULL").  syzbot has found a way to trigger multiple debugfs
> files attempting to be created, which fails, and then the error code
> gets passed to dentry_path_raw() which obviously does not like it.

4.19-stable does not contain patch ff9fb72bc077, so is this still good
idea? It should not break anything, as it still uses IS_ERR_OR_NULL,
but...

Best regards,
								Pavel

> +++ b/virt/kvm/kvm_main.c
> @@ -3990,7 +3990,7 @@ static void kvm_uevent_notify_change(unsigned int t=
ype, struct kvm *kvm)
>  	}
>  	add_uevent_var(env, "PID=3D%d", kvm->userspace_pid);
> =20
> -	if (kvm->debugfs_dentry) {
> +	if (!IS_ERR_OR_NULL(kvm->debugfs_dentry)) {
>  		char *tmp, *p =3D kmalloc(PATH_MAX, GFP_KERNEL);
> =20
>  		if (p) {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXemEyAAKCRAw5/Bqldv6
8hpwAJ4/IJBfKLwlc7sby84fNdUBc4AuQACdElBFVsiybM2y5xi7K2HaXdDVd5c=
=TXZS
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
