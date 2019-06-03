Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01BEC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BCE27BEE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="usyZjCBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfFCGWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:22:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37489 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfFCGWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:22:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45HQ2K2h3wz9s4Y;
        Mon,  3 Jun 2019 16:22:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559542937;
        bh=qtRLL5MmwkVppNQC2HhXBoAeLnIwZD4NL/50uFan5SU=;
        h=Date:From:To:Cc:Subject:From;
        b=usyZjCBMTorPhShHFMWkb8U6KufF4zisxKgg93tf98GQElT38ZO/mkJRMLJU0AkAO
         fvcAnveLGmuIMGSOUt6n8BnmXd4ECIgT3Ii4aJRxXZ4eY8qQ/Ptn81dvmoy4bSvXkP
         C3PhkBtT34d4GO6x/7U6m0uMAsJS1L3pZ/ofuJj1HhkWFGGmrFJLXRTKDDehOdbQUA
         KG19z8vZqiuNH209Lkre3yx1bJLqJrgYHPeAY6FqHVfdgtk247eyIzbQg/fW7Rp53C
         Zt91O6knQIRCZt+n3Yc4nKexRUunh0xFq6/TDlsUSvnkblHekOSv27W2DYKM3rmsvg
         jnrzghbrpL1xg==
Date:   Mon, 3 Jun 2019 16:22:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: runtime failure of next-20190603
Message-ID: <20190603162215.6390707f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+TiVC.xekiq4xkQ7ICT.F+4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+TiVC.xekiq4xkQ7ICT.F+4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

My qemu powerpc_pseries_le_defconfig boots failed today with the following
output at shutdown time:

# halt
# Stopping network...[   32.109495] watchdog: BUG: soft lockup - CPU#0 stuc=
k for 22s! [ifdown:97]
[   32.109794] Modules linked in:
[   32.110367] CPU: 0 PID: 97 Comm: ifdown Not tainted 5.2.0-rc3 #2
[   32.110577] NIP:  c000000000bbeb38 LR: c000000000bbf0a0 CTR: 00000000000=
00000
[   32.110732] REGS: c00000007c50f4d0 TRAP: 0901   Not tainted  (5.2.0-rc3)
[   32.110813] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24422422 =
 XER: 20000000
[   32.111162] CFAR: c000000000bbf09c IRQMASK: 0=20
[   32.111162] GPR00: c0000000002fa540 c00000007c50f760 c00000000119c100 c0=
0000007c50f7b8=20
[   32.111162] GPR04: ffffffffffffffff 000000000000000f c00000007c50f8f0 00=
00000000000003=20
[   32.111162] GPR08: c00000007d468450 0000000000000003 c00c000000006834 c0=
0000007ffe7000=20
[   32.111162] GPR12: c000000001268a90 c000000001380000=20
[   32.112430] NIP [c000000000bbeb38] xas_load+0x8/0xd0
[   32.112506] LR [c000000000bbf0a0] xas_find+0x1b0/0x260
[   32.112737] Call Trace:
[   32.112859] [c00000007c50f760] [c000000000bbf0a0] xas_find+0x1b0/0x260 (=
unreliable)
[   32.113082] [c00000007c50f790] [c0000000002fa540] find_get_entries+0x2e0=
/0x350
[   32.113204] [c00000007c50f840] [c00000000031fe08] shmem_undo_range+0x2d8=
/0xa90
[   32.113292] [c00000007c50f9f0] [c0000000003205ec] shmem_truncate_range+0=
x2c/0x60
[   32.113381] [c00000007c50fa20] [c000000000320ca4] shmem_setattr+0x3a4/0x=
3e0
[   32.113467] [c00000007c50fa80] [c00000000040e600] notify_change+0x2d0/0x=
5c0
[   32.113596] [c00000007c50fae0] [c0000000003d8f7c] do_truncate+0x9c/0x140
[   32.113672] [c00000007c50fb70] [c0000000003f66d8] path_openat+0x848/0x16=
60
[   32.113747] [c00000007c50fc70] [c0000000003f900c] do_filp_open+0x8c/0x120
[   32.113816] [c00000007c50fda0] [c0000000003da9e8] do_sys_open+0x248/0x350
[   32.113956] [c00000007c50fe20] [c00000000000bce4] system_call+0x5c/0x70
[   32.114123] Instruction dump:
[   32.114508] 4e800020 60000000 3900c005 7fa94040 409dff60 7d291674 2f8900=
00 419eff54=20
[   32.114651] 38600000 4e800020 3c4c005e 3842d5d0 <7c0802a6> fbe1fff8 7c7f=
1b78 f8010010=20

Reverting commit

  fa858b6eec3f ("XArray: Add xas_replace")

made the failure go away.

--=20
Cheers,
Stephen Rothwell

--Sig_/+TiVC.xekiq4xkQ7ICT.F+4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz0vJcACgkQAVBC80lX
0Gxj8gf/VjZVL3NuxGCcA/fQWIZi2QUrNTpQVsVn7/XpqL5ylaAoRCVtsqKvtJ2i
opCS8iyYyun/S8HOqxe6Su0LCBoeb3gXXo6Vj79hdWkjK5AN49NGpQoZWLd+O7Dw
Jx4yjHOb9RrLOBHpZFoeJqsjaneRqk3XLgT40TcCgmNF+O9Kr51nPFrbodPan3hY
R/OzBGrascS0yaK6JQbiIL+iII55G7UgSbtups3u84kOxCJ2ysDpRjNAgsNQAMDl
TfJ0mIkDMaUnMo6niRoOn1n1ikgWQ2gRA7aUFcjVpAjrLYkRh6ME69WFtGuUrrOY
TwlcOgW3dwUv3gi6nz+Bgpw9ZIY9aQ==
=3mjZ
-----END PGP SIGNATURE-----

--Sig_/+TiVC.xekiq4xkQ7ICT.F+4--
