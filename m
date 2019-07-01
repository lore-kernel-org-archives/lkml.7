Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E16EC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 03:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DCF20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 03:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gJ5IUVQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfGADhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 23:37:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50795 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfGADhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 23:37:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45cY302F34z9s3Z;
        Mon,  1 Jul 2019 13:37:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561952236;
        bh=ryYrZ8daQ3imDGjLIA1MGy3CqYI88ot5Nnx16IqqlfQ=;
        h=Date:From:To:Cc:Subject:From;
        b=gJ5IUVQXRBN4st/prb2KocgbDnym84jRfBsbV50+9diWei6RX2YcURkJekO5tMfec
         PMLAqD8vtsPqvx4V2PdKQS+GG6LnhISVoNEIOY1P+xhjH7nPwzSTBS8i1H17dg5n49
         VDlB04llkxpvYVmdh11PqoWCbxEo4LFDTStQbpcGUiFsMRJddpRS0Ee30CoGcCfV2O
         i18rCXhEqqPtD8/5ekSKyjkl4p62rz4gEgiJ5B350ESmDqCeXqFwNNkTkOqbLuDhnP
         wsibWROzjdgvftx9YMBk0IZjt1suYMkTI+sPrvDgd8jfbWNBtohgYk5y8pgV4PQJWh
         XonBD9Aveeb+w==
Date:   Mon, 1 Jul 2019 13:37:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20190701133715.702d4b57@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/s1qXaYoyzgP+.ueeYt=QfH0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s1qXaYoyzgP+.ueeYt=QfH0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

In file included from drivers/cpufreq/intel_pstate.c:11:
drivers/cpufreq/intel_pstate.c: In function 'intel_pstate_update_max_freq':
drivers/cpufreq/intel_pstate.c:912:31: error: 'struct cpufreq_policy' has n=
o member named 'user_policy'; did you mean 'last_policy'?
  new_policy.max =3D min(policy->user_policy.max, policy->cpuinfo.max_freq);
                               ^~~~~~~~~~~
include/linux/kernel.h:819:22: note: in definition of macro '__typecheck'
   (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
                      ^
include/linux/kernel.h:843:24: note: in expansion of macro '__safe_cmp'
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
include/linux/kernel.h:852:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/cpufreq/intel_pstate.c:912:19: note: in expansion of macro 'min'
  new_policy.max =3D min(policy->user_policy.max, policy->cpuinfo.max_freq);
                   ^~~
drivers/cpufreq/intel_pstate.c:912:31: error: 'struct cpufreq_policy' has n=
o member named 'user_policy'; did you mean 'last_policy'?
  new_policy.max =3D min(policy->user_policy.max, policy->cpuinfo.max_freq);
                               ^~~~~~~~~~~
include/linux/kernel.h:827:48: note: in definition of macro '__is_constexpr'
  (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
                                                ^
include/linux/kernel.h:833:25: note: in expansion of macro '__no_side_effec=
ts'
   (__typecheck(x, y) && __no_side_effects(x, y))
                         ^~~~~~~~~~~~~~~~~
include/linux/kernel.h:843:24: note: in expansion of macro '__safe_cmp'
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
include/linux/kernel.h:852:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/cpufreq/intel_pstate.c:912:19: note: in expansion of macro 'min'
  new_policy.max =3D min(policy->user_policy.max, policy->cpuinfo.max_freq);
                   ^~~
drivers/cpufreq/intel_pstate.c:912:31: error: 'struct cpufreq_policy' has n=
o member named 'user_policy'; did you mean 'last_policy'?
  new_policy.max =3D min(policy->user_policy.max, policy->cpuinfo.max_freq);
                               ^~~~~~~~~~~
include/linux/kernel.h:835:27: note: in definition of macro '__cmp'
 #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
                           ^
include/linux/kernel.h:852:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/cpufreq/intel_pstate.c:912:19: note: in expansion of macro 'min'
  new_policy.max =3D min(policy->user_policy.max, policy->cpuinfo.max_freq);
                   ^~~
drivers/cpufreq/intel_pstate.c:912:31: error: 'struct cpufreq_policy' has n=
o member named 'user_policy'; did you mean 'last_policy'?
  new_policy.max =3D min(policy->user_policy.max, policy->cpuinfo.max_freq);
                               ^~~~~~~~~~~
include/linux/kernel.h:835:40: note: in definition of macro '__cmp'
 #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
                                        ^
include/linux/kernel.h:852:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/cpufreq/intel_pstate.c:912:19: note: in expansion of macro 'min'
  new_policy.max =3D min(policy->user_policy.max, policy->cpuinfo.max_freq);
                   ^~~
drivers/cpufreq/intel_pstate.c:912:31: error: 'struct cpufreq_policy' has n=
o member named 'user_policy'; did you mean 'last_policy'?
  new_policy.max =3D min(policy->user_policy.max, policy->cpuinfo.max_freq);
                               ^~~~~~~~~~~
include/linux/kernel.h:838:10: note: in definition of macro '__cmp_once'
   typeof(x) unique_x =3D (x);  \
          ^
include/linux/kernel.h:852:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/cpufreq/intel_pstate.c:912:19: note: in expansion of macro 'min'
  new_policy.max =3D min(policy->user_policy.max, policy->cpuinfo.max_freq);
                   ^~~
drivers/cpufreq/intel_pstate.c:912:31: error: 'struct cpufreq_policy' has n=
o member named 'user_policy'; did you mean 'last_policy'?
  new_policy.max =3D min(policy->user_policy.max, policy->cpuinfo.max_freq);
                               ^~~~~~~~~~~
include/linux/kernel.h:838:25: note: in definition of macro '__cmp_once'
   typeof(x) unique_x =3D (x);  \
                         ^
include/linux/kernel.h:852:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/cpufreq/intel_pstate.c:912:19: note: in expansion of macro 'min'
  new_policy.max =3D min(policy->user_policy.max, policy->cpuinfo.max_freq);
                   ^~~
include/linux/kernel.h:843:2: error: first argument to '__builtin_choose_ex=
pr' not a constant
  __builtin_choose_expr(__safe_cmp(x, y), \
  ^~~~~~~~~~~~~~~~~~~~~
include/linux/kernel.h:852:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/cpufreq/intel_pstate.c:912:19: note: in expansion of macro 'min'
  new_policy.max =3D min(policy->user_policy.max, policy->cpuinfo.max_freq);
                   ^~~
drivers/cpufreq/intel_pstate.c:913:31: error: 'struct cpufreq_policy' has n=
o member named 'user_policy'; did you mean 'last_policy'?
  new_policy.min =3D min(policy->user_policy.min, new_policy.max);
                               ^~~~~~~~~~~
include/linux/kernel.h:819:22: note: in definition of macro '__typecheck'
   (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
                      ^
include/linux/kernel.h:843:24: note: in expansion of macro '__safe_cmp'
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
include/linux/kernel.h:852:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/cpufreq/intel_pstate.c:913:19: note: in expansion of macro 'min'
  new_policy.min =3D min(policy->user_policy.min, new_policy.max);
                   ^~~
drivers/cpufreq/intel_pstate.c:913:31: error: 'struct cpufreq_policy' has n=
o member named 'user_policy'; did you mean 'last_policy'?
  new_policy.min =3D min(policy->user_policy.min, new_policy.max);
                               ^~~~~~~~~~~
include/linux/kernel.h:827:48: note: in definition of macro '__is_constexpr'
  (sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
                                                ^
include/linux/kernel.h:833:25: note: in expansion of macro '__no_side_effec=
ts'
   (__typecheck(x, y) && __no_side_effects(x, y))
                         ^~~~~~~~~~~~~~~~~
include/linux/kernel.h:843:24: note: in expansion of macro '__safe_cmp'
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^~~~~~~~~~
include/linux/kernel.h:852:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/cpufreq/intel_pstate.c:913:19: note: in expansion of macro 'min'
  new_policy.min =3D min(policy->user_policy.min, new_policy.max);
                   ^~~
drivers/cpufreq/intel_pstate.c:913:31: error: 'struct cpufreq_policy' has n=
o member named 'user_policy'; did you mean 'last_policy'?
  new_policy.min =3D min(policy->user_policy.min, new_policy.max);
                               ^~~~~~~~~~~
include/linux/kernel.h:835:27: note: in definition of macro '__cmp'
 #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
                           ^
include/linux/kernel.h:852:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/cpufreq/intel_pstate.c:913:19: note: in expansion of macro 'min'
  new_policy.min =3D min(policy->user_policy.min, new_policy.max);
                   ^~~
drivers/cpufreq/intel_pstate.c:913:31: error: 'struct cpufreq_policy' has n=
o member named 'user_policy'; did you mean 'last_policy'?
  new_policy.min =3D min(policy->user_policy.min, new_policy.max);
                               ^~~~~~~~~~~
include/linux/kernel.h:835:40: note: in definition of macro '__cmp'
 #define __cmp(x, y, op) ((x) op (y) ? (x) : (y))
                                        ^
include/linux/kernel.h:852:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/cpufreq/intel_pstate.c:913:19: note: in expansion of macro 'min'
  new_policy.min =3D min(policy->user_policy.min, new_policy.max);
                   ^~~
drivers/cpufreq/intel_pstate.c:913:31: error: 'struct cpufreq_policy' has n=
o member named 'user_policy'; did you mean 'last_policy'?
  new_policy.min =3D min(policy->user_policy.min, new_policy.max);
                               ^~~~~~~~~~~
include/linux/kernel.h:838:10: note: in definition of macro '__cmp_once'
   typeof(x) unique_x =3D (x);  \
          ^
include/linux/kernel.h:852:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/cpufreq/intel_pstate.c:913:19: note: in expansion of macro 'min'
  new_policy.min =3D min(policy->user_policy.min, new_policy.max);
                   ^~~
drivers/cpufreq/intel_pstate.c:913:31: error: 'struct cpufreq_policy' has n=
o member named 'user_policy'; did you mean 'last_policy'?
  new_policy.min =3D min(policy->user_policy.min, new_policy.max);
                               ^~~~~~~~~~~
include/linux/kernel.h:838:25: note: in definition of macro '__cmp_once'
   typeof(x) unique_x =3D (x);  \
                         ^
include/linux/kernel.h:852:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/cpufreq/intel_pstate.c:913:19: note: in expansion of macro 'min'
  new_policy.min =3D min(policy->user_policy.min, new_policy.max);
                   ^~~
include/linux/kernel.h:843:2: error: first argument to '__builtin_choose_ex=
pr' not a constant
  __builtin_choose_expr(__safe_cmp(x, y), \
  ^~~~~~~~~~~~~~~~~~~~~
include/linux/kernel.h:852:19: note: in expansion of macro '__careful_cmp'
 #define min(x, y) __careful_cmp(x, y, <)
                   ^~~~~~~~~~~~~
drivers/cpufreq/intel_pstate.c:913:19: note: in expansion of macro 'min'
  new_policy.min =3D min(policy->user_policy.min, new_policy.max);
                   ^~~

Caused by commit

  218208538ffe ("cpufreq: Add QoS requests for userspace constraints")

from the pm tree interacting with commit

  9083e4986124 ("cpufreq: intel_pstate: Update max frequency on global turb=
o changes")

from Linus' tree.

I have used the pm tree from next-20190628 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/s1qXaYoyzgP+.ueeYt=QfH0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0Zf+sACgkQAVBC80lX
0GzwQgf/b26tD0r2/9TwwIjT0Ed+NEUScayE1gsviO4z/7P1xWn+7o2lFt1TUDx6
njvyrp6MW7e5SJISFpgi91Eg9TEp1mebsEl7mChrTNYEMOE3lRoHHqep7s+aHtak
c/Jp3iR3idh1DpzTVcr6o8TXaxrzIiU+0gLHHAvgpGWMTmTOE+zGal1tXG+ayQOT
NE+S2+pQ+CELU/lAnFXjRCEjDgMAGYXjmvU09SiaOwL6Ifj1nuGGKcgOA0r1A30O
cGXQmg/Ecraxs5o8Pl8uUYWgP4tsfXSrtlFpAQYieytElhvg5RYE7RbH4STcrXul
9hSkveVSuJHJ8ksowf5FuHyN3bRpBA==
=HOv/
-----END PGP SIGNATURE-----

--Sig_/s1qXaYoyzgP+.ueeYt=QfH0--
