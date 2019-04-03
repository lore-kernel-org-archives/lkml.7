Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8759DC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5644420882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Nwz9MxVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfDCDd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:33:28 -0400
Received: from ozlabs.org ([203.11.71.1]:38623 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfDCDd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:33:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Ys9b6TVHz9sNy;
        Wed,  3 Apr 2019 14:33:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554262404;
        bh=+/8lmXRpSo6uj6ay2fjaSnbCUIFjfYJHvenvLkb8u4A=;
        h=Date:From:To:Cc:Subject:From;
        b=Nwz9MxVzY9f8pETJe3ESaYyn99OWfUuz45V5cBgt9MQkUQ6WPIxHdmB+aqiOSvsMc
         Op2VCAddpFkR3CT1eV3musTBbp0OvIu5r2NxuWajck70Ph10EVwT9y+aEZlvna7kao
         xiJpZ15lbWS5HwH1le2cVdc4opISsD3WaUZ8g87Jf9Vg4Fy6xBKKpuIqkZmzzwj5vb
         IfovXaMoafGbjU57cWA8HomyvvZrBwrtKoDexWuJ+Z0VKQyydY2zsgTdHkaWkmQqiS
         8bDtAhpQQhDBsVbw2heHNlRU1iKlrzhCU3vyeSmoqBwRz2pzQObM0TXXn7OyrAAKrv
         3RVoghpEoCysg==
Date:   Wed, 3 Apr 2019 14:33:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Corey Minyard <cminyard@mvista.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: linux-next: build failure after merge of the ipmi tree
Message-ID: <20190403143323.156ac503@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/BnlIDobU0SIz0QG2QJvEgqf"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BnlIDobU0SIz0QG2QJvEgqf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Corey,

After merging the ipmi tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/char/ipmi/ipmi_msghandler.c: In function 'free_user':
drivers/char/ipmi/ipmi_msghandler.c:1268:2: error: implicit declaration of =
function 'cleanup_srcu_struct_quiesced'; did you mean 'cleanup_srcu_struct'=
? [-Werror=3Dimplicit-function-declaration]
  cleanup_srcu_struct_quiesced(&user->release_barrier);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cleanup_srcu_struct

Caused by commit

  487ecb21fa66 ("ipmi: fix sleep-in-atomic in free_user at cleanup SRCU use=
r->release_barrier")

interacting with commit

  f5ad3991493c ("srcu: Remove cleanup_srcu_struct_quiesced()")

from the rcu tree.

Based on the comments in the rcu tree commit, I have reverted the impi
tree commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/BnlIDobU0SIz0QG2QJvEgqf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlykKYMACgkQAVBC80lX
0GytbAgAisVFy0Bi0kM7OKJyg+fnkwkMvQbe5+NUPeDrbznizmOQPrv4u0iqieHa
Zmdt0jireZLstdD/th9E6Ln3kQLQqeR8VgO1x21/3CBTvFYr4JW5BhzhQsiFfhPu
c76Bt20P9dkqIdc+XEjbviTcCGumiB0aoLl8nBM9KjohrqGBu98DKIqfui0ZmqfL
QK9RHlFKnaC6KuAnpyM+cuU4lZdGDyKJ3V0PkWec0hHkfB51zLlMxnk1EZNTGFAV
6bWE/pH9lzmLPBPm5VE4YqwaQZrt7+CCeeFHDmeMCjARdVUnNnZ4TrsBnVt6sEQH
YaLa/3d3IwIIXeSH7Zv9Ac7dzfGdUg==
=vMn7
-----END PGP SIGNATURE-----

--Sig_/BnlIDobU0SIz0QG2QJvEgqf--
