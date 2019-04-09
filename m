Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAE1C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DA720850
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YVBdENyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfDIX3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:29:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:35587 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbfDIX3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 19:29:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44f3QQ4B8Cz9sTb;
        Wed, 10 Apr 2019 09:29:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554852543;
        bh=kBan17G2swnl9tZeAIeixQuwNm9a7169panF1YPaZG0=;
        h=Date:From:To:Cc:Subject:From;
        b=YVBdENyHF8YmCHg75L3VoLPm0kkO17exjsUbMJ7Hmz9gaJfgo8HzANSpoB8THQ/HU
         8u96RecUZ/mLTlU5meuPF8LzF6iierqYSeo/LqcST6P/iv7NzlkiQvwmyFlT1zTTUP
         u2M4z5kybtPDst/gGGL0gADFaXhzL6QchQtkfQjclK8cSyxdfrCp0tMFXqQ6TOhoIo
         p8iRfQJNs1fMkkJQ2a+B4V4y9xtn5Emm+hxoaalB4Tjm+buxhei62u+HKJWqjzWg78
         C7WJf3v4Sh3BbeOHip9bRmyRQTg5rB59CKNw+ZbMdygn+48VnJIemBDm/E3O8wwjvO
         AGbJvCQMD7FMw==
Date:   Wed, 10 Apr 2019 09:29:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: linux-next: manual merge of the printk tree with Linus' tree
Message-ID: <20190410092901.0a17ee79@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JLyIHtWwlpc=v2NS3d+BDIx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JLyIHtWwlpc=v2NS3d+BDIx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the printk tree got a conflict in:

  include/trace/events/sunrpc.h

between commit:

  6f701383368d ("SUNRPC: Display symbolic flag names in RPC trace events")

from Linus' tree and commit:

  d75f773c86a2 ("treewide: Switch printk users from %pf and %pF to %ps and =
%pS, respectively")

from the printk tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/trace/events/sunrpc.h
index 7e899e635d33,7b8b987d332e..000000000000
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@@ -146,10 -102,10 +146,10 @@@ DECLARE_EVENT_CLASS(rpc_task_running
  		__entry->flags =3D task->tk_flags;
  		),
 =20
- 	TP_printk("task:%u@%d flags=3D%s runstate=3D%s status=3D%d action=3D%pf",
 -	TP_printk("task:%u@%d flags=3D%4.4x state=3D%4.4lx status=3D%d action=3D=
%ps",
++	TP_printk("task:%u@%d flags=3D%s runstate=3D%s status=3D%d action=3D%ps",
  		__entry->task_id, __entry->client_id,
 -		__entry->flags,
 -		__entry->runstate,
 +		rpc_show_task_flags(__entry->flags),
 +		rpc_show_runstate(__entry->runstate),
  		__entry->status,
  		__entry->action
  		)

--Sig_/JLyIHtWwlpc=v2NS3d+BDIx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlytKr4ACgkQAVBC80lX
0GxVFgf/SidMM7NNcSNHCA1rIMrV0RjSRiC8V+f1o0oliCRjuzWGFWaNPK7Py1EW
qa3OVIX7tFsp9lpDg4KhsXfgR/+Wr1/j3pejrE7P3B2QKuls1YkvTXj9b57XkJk8
mSeQv2Sy+GiB+Ch3xLvOiYiYjYQ12lLALZG56ZyEzGInW8mIQnTS+mfummVYdm4u
amN3dDAaDbqVOlI4dOV27euRn07Y+/cbDKz7jE3lcrdacPNhInVTOAikjSVDqkW2
SxsnMsF/9j33hYxjQ0VFKCydlnQqCzlLCkVK8bvXajwiIzsVr9H1h28q8yX4PPDL
Z69gWzSf+pPreLt2HX6ukdKmI1oGww==
=uGU0
-----END PGP SIGNATURE-----

--Sig_/JLyIHtWwlpc=v2NS3d+BDIx--
