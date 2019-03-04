Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CB0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DE620842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C/u7Idqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfCDCuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 21:50:44 -0500
Received: from ozlabs.org ([203.11.71.1]:54295 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfCDCun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 21:50:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44CPf84stlz9s5R;
        Mon,  4 Mar 2019 13:50:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551667840;
        bh=TpxcEjZ/AxJbKIh+awY0CcyMYfwnlX+6RNsg2j2FH+Q=;
        h=Date:From:To:Cc:Subject:From;
        b=C/u7IdqiBKB9IhV+Gp+8XGNBiu7jr12bHMVFGU8BtTPuW+OmNhtoqD5N5pHcIKn3W
         tpzBCp95JjxbNH6AZ/KqBRN+TVWDoJVlsfUhA/ket1MsqhCXbMvmH/DMP+PcHrjzPf
         GWlR/o87AaOv+Bi8EwKbvqc+RAdP1ic6DMAZmq2IWcxwadj6JKojh7s4ep2W5YgZCg
         C9E0i9+VvxG79k0cmU4Ru+LOBVvtpRpFNLvanIkflEVf5gpz6MVo2QZblArouaVw7u
         fqkeDCygZz9oVZIy1akkZ0aAM68iZchcJaa2GG//RKBA+ktvxrsigehO8WuLonOpzO
         gmr7yMCkDzXUA==
Date:   Mon, 4 Mar 2019 13:50:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Gardon <bgardon@google.com>
Subject: linux-next: manual merge of the kvm tree with Linus' tree
Message-ID: <20190304135034.79b90d37@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WfOBf/gbWqGR=ZAJW2p.JX9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WfOBf/gbWqGR=ZAJW2p.JX9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  virt/kvm/kvm_main.c

between commit:

  8ed0579c12b2 ("kvm: properly check debugfs dentry before using it")

from Linus' tree and commit:

  b12ce36a43f2 ("kvm: Add memcg accounting to KVM allocations")

from the kvm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc virt/kvm/kvm_main.c
index d237d3350a99,0fb0e9aa0935..000000000000
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@@ -4044,8 -4049,8 +4049,8 @@@ static void kvm_uevent_notify_change(un
  	}
  	add_uevent_var(env, "PID=3D%d", kvm->userspace_pid);
 =20
 -	if (kvm->debugfs_dentry) {
 +	if (!IS_ERR_OR_NULL(kvm->debugfs_dentry)) {
- 		char *tmp, *p =3D kmalloc(PATH_MAX, GFP_KERNEL);
+ 		char *tmp, *p =3D kmalloc(PATH_MAX, GFP_KERNEL_ACCOUNT);
 =20
  		if (p) {
  			tmp =3D dentry_path_raw(kvm->debugfs_dentry, p, PATH_MAX);

--Sig_/WfOBf/gbWqGR=ZAJW2p.JX9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx8knoACgkQAVBC80lX
0Gy0ZggAmznncpwSwuDUKj1gBbbtRklv1vzWT1RBYegD3e98gZEqjgFVHqHDGrCp
ZmLUanMdKEmtBChJ7c0nWnTwKZgmmZ9Bo9q1PLda9F7b6uomqydckx5eoFB0FrPI
fVMe/3ozdbbyQHasbP5xLKJlRQ3DaZX+HW6SWQ34iPX2L9YpJJ3BCBUIDP8alMAK
1s9esQDG8k7Fi0xjec+W7JXR2b4HlY3O2RxFnQmy/ybNLKiwOI9KOg+Hu7eyNkd7
aMOVxVfW247/ABL8Pj1JRM7Z9ms+iVD4iM72EQaMYVbKmCGBDVHfNMkeWBpvivrX
VwUYI5xwbGt9SQlQkZzdihBwkGEGQg==
=k5ru
-----END PGP SIGNATURE-----

--Sig_/WfOBf/gbWqGR=ZAJW2p.JX9--
