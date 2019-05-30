Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658A4C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 05:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7332238C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 05:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tS9XjhsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfE3FdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 01:33:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36421 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3FdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 01:33:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Dx7d4v7bz9s00;
        Thu, 30 May 2019 15:33:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559194397;
        bh=mimjJjO6VsPyW9w7prhgMUoBLSc8qMMY4Mw1JmXnMuw=;
        h=Date:From:To:Cc:Subject:From;
        b=tS9XjhsW5QUPZBbZfz+Zulbmb+U2uowHm6XMO/EL61bbz/5/uA65TIXUUYvvo7oeR
         OqKPKz6XG7buid1HFAlMzheBoPj7cL5tdoVO+ysyKL8VWKsEoGrlyvew6ueXgjemi8
         Feb8YA55UxTv8k+uZU7RVMlp4dqo1R0kFz8eXeIqN+Qi1yjcYfheHWp/sGQcRHclrV
         CUzv1w9BVSvCKUQev+eiQc4XIo+q74FrUiFre0VNfRtg+3+OVM/sNWc52xtwIjTSt/
         tJrg1hm5HkPqX+QAev+aLKhJPiUuiiqdA2wNXL0jp9alfyxS1gKxAbaYliUGwVTl2x
         oP7s4fuFsYbfQ==
Date:   Thu, 30 May 2019 15:33:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the userns tree
Message-ID: <20190530153316.60907d8f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5kYuec8EBjVawDMYkqOfsSD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5kYuec8EBjVawDMYkqOfsSD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

After merging the userns tree, today's linux-next build (i386 defconfig)
produced this warning:

arch/x86/mm/fault.c: In function 'do_sigbus':
arch/x86/mm/fault.c:1017:22: warning: unused variable 'tsk' [-Wunused-varia=
ble]
  struct task_struct *tsk =3D current;
                      ^~~

Introduced by commit

  351b6825b3a9 ("signal: Explicitly call force_sig_fault on current")

The remaining used of "tsk" are protected by CONFIG_MEMORY_FAILURE.

--=20
Cheers,
Stephen Rothwell

--Sig_/5kYuec8EBjVawDMYkqOfsSD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzvaxwACgkQAVBC80lX
0Gykxgf8DSGyhXKHKnG8MV3Iv/w2yd0SppFLsSAqvXWZHNtfPi8p/ftjtZ3Zp3Ja
y+o7czQJCz8kULN5kd1SG3caLCRxtF1YqCwYUlWo4z61X1ZSpWosV1Y6Rj5YgJF1
drX1BCu+nH0RX5D0YaKO9Z47fTGbBWregDEiPAaTDjqc5KeTX8YaHPaL8kZCicGz
QQ3h91LWfmumpE1BBJx6AverzIrC6ieKu2zt6VHcXx1wROrnTTpG6xkEbFRLZNUn
fGiCi3XGkYkHz0/wHgT5lFKCBoaVXYVhw6Rj0JNhMcEF1N9WIe9c/BFTKwbYFmgL
poT4KVuWp7I3mJkTydIbhRLMp4jEIw==
=xeiI
-----END PGP SIGNATURE-----

--Sig_/5kYuec8EBjVawDMYkqOfsSD--
