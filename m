Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00DFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F7A20851
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VA5jDh/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfEVNll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:41:41 -0400
Received: from ozlabs.org ([203.11.71.1]:38785 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbfEVNll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:41:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 458DLn08Dwz9s5c;
        Wed, 22 May 2019 23:41:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558532498;
        bh=Y3vALN2miZYBpiC9DvaVl+ErwzmuEQ+sXIpQQc/f5dQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VA5jDh/ElGxzmJ7SmF2vmHOEa+AWpmzNIv6e5o6Ld+pVn5ECRmHwiOyS3JBpHUTAk
         ggGBdEFbO/8NGAePsUks7C9gnf8LLFs7CExQLYlcRq51QYvA1pZRze10GaHoe1B14z
         Eayz/cTdDFa2SP3f/QOAwnAb19+2R/G0xw0DCFBjeguAg1e8rLOZ6b4gQDO8jGWD86
         //kdfBUSl4fvK8P9tq0AvXdnGJIOh0lZot9s+yhCUL+8dIYuIyNoGOV+bdn1Sk8/oW
         h3SoDn0ZE3bvXP5VfaZmxf89Xp9z8O1PnmKLBlg3SimfOqk2URS/5Wr7KUkzZTjuWz
         UfpQYFko6cn9A==
Date:   Wed, 22 May 2019 23:41:34 +1000
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
Message-ID: <20190522234134.44327256@canb.auug.org.au>
In-Reply-To: <a6b6a5ef-c65c-6999-2bc1-7aaf9dd19fe8@i-love.sakura.ne.jp>
References: <1557745331-10367-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
        <20190515105540.vyzh6n62rqi5imqv@pathway.suse.cz>
        <ee7501c6-d996-1684-1652-f0f838ba69c3@i-love.sakura.ne.jp>
        <20190516115758.6v7oitg3vbkfhh5j@pathway.suse.cz>
        <a3d9de97-46e8-aa43-1743-ebf66b434830@i-love.sakura.ne.jp>
        <a6b6a5ef-c65c-6999-2bc1-7aaf9dd19fe8@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ugZY1zGwonFni/OVGqNsy8G"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ugZY1zGwonFni/OVGqNsy8G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tetsuo,

On Wed, 22 May 2019 21:38:45 +0900 Tetsuo Handa <penguin-kernel@i-love.saku=
ra.ne.jp> wrote:
>
> I want to send debug printk() patches to linux-next.git. Petr Mladek
> is suggesting me to have a git tree for debug printk() patches.
> But it seems that there is "git quiltimport" command, and I prefer
> "subversion + quilt", and I don't have trees for sending "git pull"
> requests. Therefore, just ignoring "git quiltimport" failure is fine.
> What do you think?

Sure, we can try.  I already have one quilt tree (besides Andrew's) in
linux-next, but much prefer a git tree.  If you have to use a quilt
tree, I will import it into a local branch on the base you tell me to
and then fetch it every morning and reimport it if it changes.  I will
then merge it like any other git branch.  Let me know what you can deal
with.
--=20
Cheers,
Stephen Rothwell

--Sig_/ugZY1zGwonFni/OVGqNsy8G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzlUY4ACgkQAVBC80lX
0Gy8ngf/UWv5u8sVXx7DR9gndxiKe8lJBXWNKr1/53EQxt14gu2pgt8hqfFu0m1w
l9JlXIguaXxEdFAeoaso4JwuUV24SquFlTEbvugrXwURjzF9Gp/I8GVQn6cklusM
EPYEmkBIiirsOXDYfLS1yNfWKMhc45O9A854KJVsTcy4fDZTsOiBZC+3Rwx3oV40
r67qdjmIEcIX/MRhVQ8cO5WDgEqQWLPdYLBLsFvJLEzgq8QmdXP9RfkHSgJDk+AD
2v84L0kctCq0vSb/BMb0LxG/sCSaTB8d42JgfOtDl9pphQLf39O63CRq940tgY4a
wgcRDWolfryEJ7yi6ATyBbut63xkFA==
=xm58
-----END PGP SIGNATURE-----

--Sig_/ugZY1zGwonFni/OVGqNsy8G--
