Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01E9C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3D521019
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 06:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QADk/K2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfEFG6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 02:58:53 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38727 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfEFG6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 02:58:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44yD9N5scDz9s55;
        Mon,  6 May 2019 16:58:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557125929;
        bh=j29dG6zflvKP4umLOj0CWscPCKi+jUJ+Qg2+axZ911I=;
        h=Date:From:To:Cc:Subject:From;
        b=QADk/K2S/b+Vr7iqAl63eZoN46dF1wZ6SHItqqEfAf6+CGNRnRmDN4lmRL8SVyhOP
         p3TIMwQ/ICRxfWe+kYxXrtmHOQ47pM9PDIhYpyC3tt0x5NPVmpVSLUjBUmHx0luE7M
         ilKfCIz4tJVQs/c8uDrOAwYyTTYNCHorNqLXPz7W2rpaNtcvLijYvpRj86d6nS3VJ4
         xJxhWrCmYR+sl+ND3pmJA182dNn4XyBADSy9oWvGtEyM/Dd7vrsQKQbKE1yh7vFCQM
         0EtZ1lcHWtSXzLAHLgQX15AvsUMs0XS2tLCXcXdPc7XSe7Ge1SronkbputoAcuOk1U
         IM/+PtQyqRXwg==
Date:   Mon, 6 May 2019 16:58:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with the s390 tree
Message-ID: <20190506165847.0e648a4c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ux0dL4xhqMQOJKdIaeT1DsM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ux0dL4xhqMQOJKdIaeT1DsM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/s390/kernel/stacktrace.c

between commit:

  78c98f907413 ("s390/unwind: introduce stack unwind API")

from the s390 tree and commit:

  6a28b4c2d93b ("s390/stacktrace: Remove the pointless ULONG_MAX marker")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/s390/kernel/stacktrace.c
index 89f9f63dca18,cc9ed9787068..000000000000
--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@@ -16,53 -41,29 +16,47 @@@
 =20
  void save_stack_trace(struct stack_trace *trace)
  {
 -	unsigned long sp;
 -
 -	sp =3D current_stack_pointer();
 -	dump_trace(save_address, trace, NULL, sp);
 +	struct unwind_state state;
 +
 +	unwind_for_each_frame(&state, current, NULL, 0) {
 +		if (trace->nr_entries >=3D trace->max_entries)
 +			break;
 +		if (trace->skip > 0)
 +			trace->skip--;
 +		else
 +			trace->entries[trace->nr_entries++] =3D state.ip;
 +	}
- 	if (trace->nr_entries < trace->max_entries)
- 		trace->entries[trace->nr_entries++] =3D ULONG_MAX;
  }
  EXPORT_SYMBOL_GPL(save_stack_trace);
 =20
  void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *tr=
ace)
  {
 -	unsigned long sp;
 -
 -	sp =3D tsk->thread.ksp;
 -	if (tsk =3D=3D current)
 -		sp =3D current_stack_pointer();
 -	dump_trace(save_address_nosched, trace, tsk, sp);
 +	struct unwind_state state;
 +
 +	unwind_for_each_frame(&state, tsk, NULL, 0) {
 +		if (trace->nr_entries >=3D trace->max_entries)
 +			break;
 +		if (in_sched_functions(state.ip))
 +			continue;
 +		if (trace->skip > 0)
 +			trace->skip--;
 +		else
 +			trace->entries[trace->nr_entries++] =3D state.ip;
 +	}
- 	if (trace->nr_entries < trace->max_entries)
- 		trace->entries[trace->nr_entries++] =3D ULONG_MAX;
  }
  EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 =20
  void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trac=
e)
  {
 -	unsigned long sp;
 -
 -	sp =3D kernel_stack_pointer(regs);
 -	dump_trace(save_address, trace, NULL, sp);
 +	struct unwind_state state;
 +
 +	unwind_for_each_frame(&state, current, regs, 0) {
 +		if (trace->nr_entries >=3D trace->max_entries)
 +			break;
 +		if (trace->skip > 0)
 +			trace->skip--;
 +		else
 +			trace->entries[trace->nr_entries++] =3D state.ip;
 +	}
- 	if (trace->nr_entries < trace->max_entries)
- 		trace->entries[trace->nr_entries++] =3D ULONG_MAX;
  }
  EXPORT_SYMBOL_GPL(save_stack_trace_regs);

--Sig_/Ux0dL4xhqMQOJKdIaeT1DsM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzP2ycACgkQAVBC80lX
0GzcJgf/WSfAWYc7/nI/cWjpTwQVB5BBHTIukEA2dT5QtCAe7NzwY4jleBobufJF
ehkeLLp3OXbXt29l2Jfv4lP6h4gTPFJF5aW7allb93Ifg+54eHlQ783QbJGgUuGB
TGjX1pjsOnBE2sn/t+XLfrkE7rdUwj1IVMSvA01u/2hpfDeKgVaqvOtsdH7JM+8Y
HcQLfodCtzzjgmCm9AtcTaeNszkAxfaXh0ZcZOxv0uEI22L4/9U2B8JdHkFteo4L
bGIxR/CcaCtn2/T3P3KFHF/geUOjJcf5a8b4x6bbynlhROicC4wTf70N7R3dmjqU
ZGcX/lnz8igGM/m3feT7YR9a44Hy2w==
=SgIA
-----END PGP SIGNATURE-----

--Sig_/Ux0dL4xhqMQOJKdIaeT1DsM--
