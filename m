Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC2CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9258D2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bzKfJbDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfEVVjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:39:51 -0400
Received: from ozlabs.org ([203.11.71.1]:59501 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729857AbfEVVju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:39:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 458QyN6RQyz9s6w;
        Thu, 23 May 2019 07:39:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558561187;
        bh=wRKrhXUTkO76zZP8yvjvak+7H46xVyw1PuWBiwkqSpM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bzKfJbDS5X7VE7JUEe/IJvAiOzTtv/s5JAgaziL6JxyX4Glv7VzA0ioT9MbKTefgy
         m6yoW8vRgSBt0ISzYudyvvkdO4r6ad3SQsrEBEFZjMFF+oGiazxImzqORC/5mbMxUs
         bHGrQICqYSOvz/4+KsAB3KYJ7kBle3KcDltbv2lBWp6a9uR4/jNUoFi3wkbqYgGtrX
         UOaGc9sF8et0tth04D2v06xJ1aWXDe155137YwW2mRtze7GN8TCVmYXTUm5zkPaPYy
         VLHC9spUOZr5MtS4JYXJPfQ0qJtydtnMMlqpMP1neg7vPAa/p7lNk/aYrtwuokgY0D
         5ZUd5R2KWmfBQ==
Date:   Thu, 23 May 2019 07:39:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Liu Chuansheng <chuansheng.liu@intel.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] kernel/hung_task.c: Monitor killed tasks.
Message-ID: <20190523073925.169563ed@canb.auug.org.au>
In-Reply-To: <abbfb5df-40da-63c8-0333-805083397533@i-love.sakura.ne.jp>
References: <1557745331-10367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
        <20190515105540.vyzh6n62rqi5imqv@pathway.suse.cz>
        <ee7501c6-d996-1684-1652-f0f838ba69c3@i-love.sakura.ne.jp>
        <20190516115758.6v7oitg3vbkfhh5j@pathway.suse.cz>
        <a3d9de97-46e8-aa43-1743-ebf66b434830@i-love.sakura.ne.jp>
        <a6b6a5ef-c65c-6999-2bc1-7aaf9dd19fe8@i-love.sakura.ne.jp>
        <20190522234134.44327256@canb.auug.org.au>
        <03b5834d-5f8f-9c7e-20df-cfdf5395d245@i-love.sakura.ne.jp>
        <abbfb5df-40da-63c8-0333-805083397533@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/N.../tmEjaT./BOsoQmrWom"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N.../tmEjaT./BOsoQmrWom
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tetsuo,

On Thu, 23 May 2019 06:09:07 +0900 Tetsuo Handa <penguin-kernel@i-love.saku=
ra.ne.jp> wrote:
>
> > What I do for making patches is:
> >=20
> >   git fetch --tags
> >   git reset --hard next-$date
> >   edit files
> >   git commit -a -s
> >   git format-patch -1
> >   git send-email --to=3D$recipient 0001-*.patch
> >=20
> > I'm sure I will confuse git history/repository everyday if
> > I try to send changes using git. For my skill level, managing
> > 0001-*.patch in a subversion repository is the simplest and safest.
> >  =20
>=20
> I put an example patch into my subversion repository:
>=20
>   svn checkout https://svn.osdn.net/svnroot/tomoyo/branches/syzbot-patche=
s/
>=20
> To fetch up-to-date debug printk() patches:
>=20
>   cd syzbot-patches
>   svn update
>=20
> Does this work for you?

Neither will fit into my normal workflow.

So, tell me, what are you trying to do?  What does you work depend on?
Just Linus' tree, or something already in linux-next?  Why would you
want to keep moving your patch(es) on top of linux-next?

--=20
Cheers,
Stephen Rothwell

--Sig_/N.../tmEjaT./BOsoQmrWom
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzlwY0ACgkQAVBC80lX
0GyJmggAolSyWYOkdjcXs5HtLn172YJJqPmawn81i51UmCz/OGcKgSQL13M84AR1
6bLXIO/EJ+puXtghzhwwd1ujwsvSsrrZS4sI83HdWkr0anJkbN/byCpY49XpRvSL
IY1D8FdnJqk2XxZqEF1fvTNwYtn8x4jbYzAz8bwVRTH7CbjVnBZlM53UPeXNCY6G
g6hQHQq6ebc/Rm4+b8dZG7GPcCWdgBVgsXtJqw9dLc7J+5BXncZFwyJaEZ5YDsuC
I6DQy7eT6K4ra0PpY99J8SvXOAqSox0hnXgMKtqsodbeNF0Nu4qWgmef5jifoUIo
ioiASEPk+8auSU6IPryhuUZDGbKX4Q==
=8eNo
-----END PGP SIGNATURE-----

--Sig_/N.../tmEjaT./BOsoQmrWom--
