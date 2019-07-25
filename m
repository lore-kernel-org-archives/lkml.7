Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351C2C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 04:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC112190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 04:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="K+j5/UFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390219AbfGYErR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 00:47:17 -0400
Received: from ozlabs.org ([203.11.71.1]:47551 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390204AbfGYErR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 00:47:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45vKSf27J0z9sBt;
        Thu, 25 Jul 2019 14:47:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564030034;
        bh=XgNiyUC/8j8tQYX8YJAPfwm9flwHUimtQeGsqjcgCgk=;
        h=Date:From:To:Cc:Subject:From;
        b=K+j5/UFiVp1yASqfFfYtxDs/Io9FD0y/x41FEDqoGc0fAHf5rlVnAQmDp1Djf9m8h
         n55DtPVvc01KxlvO2xp6E2SjGeUZ/7SlntUyZAl/hUqPrr94v7XmAGbdOVm6Tb2xLr
         KMEXt4BdioAo7CjNU7ZSor1NIMzw6YWCGxI7nqQxmxAIkT7VIMNMPJg2/wIqF3c2rc
         QEn4XtWdPQG9BNxOnQV0D4s0oiWVcyA4k478X4bPhvCGfad7fhUYyV4xweAD3TeHWB
         h/cmW+567geuOxcCWRxtPX+//PLKHmk8ZXaQmwiyI9kyn75JFDJNb5kOBEImaw1Tt+
         JRMJ6hJr6qZYA==
Date:   Thu, 25 Jul 2019 14:47:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: linux-next: run time BUG after merge of the vfs-fixes tree?
Message-ID: <20190725144712.39cb1e5b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pEgeTEg2=EXC5OrdPMK6f02";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pEgeTEg2=EXC5OrdPMK6f02
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

During my qemu boot tests (powerpc64 pseries_le_defconfig) today, I got
the following BUG:

# halt
# Stopping network...Saving random seed... [    6.515368] random: dd: unini=
tialized urandom read (512 bytes read)
done.
Stopping logging: OK
[    6.796972] BUG: Unable to handle kernel data access at 0x5deadbeef00001=
22
[    6.797133] Faulting instruction address: 0xc00000000041cba4
[    6.797616] Oops: Kernel access of bad area, sig: 11 [#1]
[    6.797725] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSeries
[    6.797987] Modules linked in:
[    6.798405] CPU: 0 PID: 111 Comm: umount Not tainted 5.3.0-rc1 #2
[    6.798554] NIP:  c00000000041cba4 LR: c00000000041cb90 CTR: 00000000000=
001fc
[    6.798664] REGS: c00000007e1eba70 TRAP: 0380   Not tainted  (5.3.0-rc1)
[    6.798716] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 82242884 =
 XER: 20000000
[    6.798957] CFAR: c00000000041c434 IRQMASK: 0=20
[    6.798957] GPR00: c00000000041cb90 c00000007e1ebd00 c00000000110e100 00=
00000000000001=20
[    6.798957] GPR04: 0000000000000800 0000000000000800 0000000000020000 c0=
0000000113dbf8=20
[    6.798957] GPR08: 0000000000000048 c00000007a2e2100 5deadbeef0000122 c0=
00000079417380=20
[    6.798957] GPR12: 0000000022242884 c0000000012f0000 0000000000000000 00=
00000000000000=20
[    6.798957] GPR16: 0000000000000000 0000000000000000 0000000000000000 00=
00000000000000=20
[    6.798957] GPR20: 0000000000000000 0000000000000000 0000000000000000 00=
000000100bce20=20
[    6.798957] GPR24: 0000000000000000 c00000007a2e2100 0000000000000000 c0=
0000007a2e2188=20
[    6.798957] GPR28: 0000000000000000 5deadbeef0000100 5deadbeef0000122 5d=
eadbeef0000100=20
[    6.800143] NIP [c00000000041cba4] namespace_unlock+0x194/0x240
[    6.800208] LR [c00000000041cb90] namespace_unlock+0x180/0x240
[    6.800366] Call Trace:
[    6.800456] [c00000007e1ebd00] [c00000000041cb90] namespace_unlock+0x180=
/0x240 (unreliable)
[    6.800603] [c00000007e1ebd60] [c00000000041e634] ksys_umount+0x324/0x6f0
[    6.800760] [c00000007e1ebe00] [c00000000041ea24] sys_umount+0x24/0x40
[    6.800824] [c00000007e1ebe20] [c00000000000ba64] system_call+0x5c/0x70
[    6.800940] Instruction dump:
[    6.801234] 81490124 fba900f0 fbc900f8 2f8a0000 409e00b0 7d234b78 4bfff8=
0d 353fff10=20
[    6.801374] 4182007c ebe900f0 e94900f8 2fbf0000 <fbea0000> 409effc8 3ce0=
5dea 60e7dbee=20
[    6.801992] ---[ end trace 34315779952607e2 ]---
[    6.905920]=20
The system is going down NOW!

5deadbeef is the ppc64 ILLEGAL_POINTER_VALUE.  I am guessing that the
problem may have been introduced by commit

  2085eeffbc6d ("fix the struct mount leak in umount_tree()")

in the vfs-fixes tree today.

And actually reverting that commit makes the BUG go away.

After doing the revert (and also before today), I get the following log
messages instead of the BUG trace:

umount: devtmpfs busy - remounted read-only
umount: can't unmount /: Invalid argument

So, I have left that commit reverted for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/pEgeTEg2=EXC5OrdPMK6f02
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl05NFAACgkQAVBC80lX
0GzMCgf/Z43iUTipx8OAm5+vbL33R6EKfD0dTufyKZFYSro17WVkUYcE27nQmYbj
PII9tbx+S1uDvwMMX/0RumvK3aM2ygkf93RcVobI0D8+X95TCQe3Sx6IgsW2Uk8E
lX7f3Nfzpcm29EdQJZ52c6x2wALnCmvQubFPi5E0q9azIrD/5Ih49pLrL3O2moiB
z+7pCABIEr9eu5nEAFDDrOdyWgrwslY+ogZdmQo7KSqXYuX5yHqk/wWE6VVGAtCR
bAEVczy8LFUONlQfIGmbULLZ+CFQ8djj7Izdf3aktfWUMHiD6iJLi9JsXOdg7aB/
c4KSHUCk9Jn5CFkjN2IPikJ6JJCS5w==
=9j6j
-----END PGP SIGNATURE-----

--Sig_/pEgeTEg2=EXC5OrdPMK6f02--
