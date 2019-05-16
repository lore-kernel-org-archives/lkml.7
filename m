Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D570BC04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A837E20873
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mmLRzAlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfEPBrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:47:08 -0400
Received: from ozlabs.org ([203.11.71.1]:42271 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbfEPBAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 21:00:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 454ClS5NQYz9s3q;
        Thu, 16 May 2019 11:00:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557968436;
        bh=cxOVi+EeQ/hvXm3xkhnHns4v0atEvXuiHV+6juBaIQI=;
        h=Date:From:To:Cc:Subject:From;
        b=mmLRzAlwtiNAk7hdbb6+LyWacuuVCAGJX+3t+ueBbPRNVPLx8jQABJGPGDyWrGpxM
         e3GCot6z8q+aGFDt0hwYSOTxMjCPuuv58ikGNhuMXXfC4gsBFwlh87MVE8lZc+YnP6
         XxI1uuUHGo2I41lxtm9hmjbVNtQ9Gdg9txDKfub567RauEF7QHyWB48jNAmZz3LJA/
         hOoiKuUxYY4G40rFC0cA11+iZlZj0I248LadOvykxxIYnFkszBsATNuVSddHPT8FKk
         NhR+KHsMIf03AMvy/lTgtEX2E8N6CojHe6stdDZJYDKTuwLtxbg9L+OlH74ebT8QKk
         PGHbzwu9pF5dA==
Date:   Thu, 16 May 2019 11:00:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: linux-next: manual merge of the ftrace tree with Linus' tree
Message-ID: <20190516110018.4e85254e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7DYV1ZLNDZ1kZ/LMGOb=0jE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7DYV1ZLNDZ1kZ/LMGOb=0jE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ftrace tree got a conflict in:

  arch/x86/entry/entry_64.S

between commits:

  8f34c5b5afce ("x86/exceptions: Make IST index zero based")
  3207426925d2 ("x86/exceptions: Disconnect IST index and stack order")
  2a594d4ccf3f ("x86/exceptions: Split debug IST stack")

from Linus' tree and commit:

  2700fefdb2d9 ("x86_64: Add gap to int3 to allow for call emulation")

from the ftrace tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/entry/entry_64.S
index 20e45d9b4e15,27fcc6fbdd52..000000000000
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@@ -878,7 -879,7 +878,7 @@@ apicinterrupt IRQ_WORK_VECTOR			irq_wor
   * @paranoid =3D=3D 2 is special: the stub will never switch stacks.  Thi=
s is for
   * #DF: if the thread stack is somehow unusable, we'll still get a useful=
 OOPS.
   */
- .macro idtentry sym do_sym has_error_code:req paranoid=3D0 shift_ist=3D-1=
 ist_offset=3D0
 -.macro idtentry sym do_sym has_error_code:req paranoid=3D0 shift_ist=3D-1=
 create_gap=3D0
++.macro idtentry sym do_sym has_error_code:req paranoid=3D0 shift_ist=3D-1=
 ist_offset=3D0 create_gap=3D0
  ENTRY(\sym)
  	UNWIND_HINT_IRET_REGS offset=3D\has_error_code*8
 =20
@@@ -1128,8 -1143,8 +1142,8 @@@ apicinterrupt3 HYPERV_STIMER0_VECTOR=20
  	hv_stimer0_callback_vector hv_stimer0_vector_handler
  #endif /* CONFIG_HYPERV */
 =20
 -idtentry debug			do_debug		has_error_code=3D0	paranoid=3D1 shift_ist=3DDE=
BUG_STACK
 +idtentry debug			do_debug		has_error_code=3D0	paranoid=3D1 shift_ist=3DIS=
T_INDEX_DB ist_offset=3DDB_STACK_OFFSET
- idtentry int3			do_int3			has_error_code=3D0
+ idtentry int3			do_int3			has_error_code=3D0	create_gap=3D1
  idtentry stack_segment		do_stack_segment	has_error_code=3D1
 =20
  #ifdef CONFIG_XEN_PV

--Sig_/7DYV1ZLNDZ1kZ/LMGOb=0jE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzctiIACgkQAVBC80lX
0GwWZggAorC5X+xTH+vP9/QFuHBmrJvruuWSXPm0WKd4nH6x3AlHt+EgtPGqAT52
VR+ASjIv0p6xxCbNOG87cp5Iff3GECPWrkjYsbBVx7EJukiQbpywARr7S46rMbbe
q/wdqaRQOr7IZj8hsyt8LXhaTSaQq+zuCKN17FXyugd8cEu0MQwHl0XL5skZNthB
47S2xpUSOHJJmfFDkRtj9TW4/psHdEuVxE80/4ArU78zw1hNCaMTwtGJdC2gEXSB
WW4Zt/eM/Ro+NVtrdXsj2RUpFfDR7qFGOUDenksTXtgHX77MBZWeDNQmRXGNt1g8
IVJdMzZvlk0L+vMKV57ekIRKe2HQvg==
=40U7
-----END PGP SIGNATURE-----

--Sig_/7DYV1ZLNDZ1kZ/LMGOb=0jE--
