Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55765C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E1120693
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btDg1fDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfDWN0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:26:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40842 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:26:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so20201364wre.7;
        Tue, 23 Apr 2019 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t55UaS6rBsn5sbPESWXHBguQkipvC+R5S8CcCgaOjCo=;
        b=btDg1fDvgKkMWBKgKuGFctqqiOV7pGBJz8YdRCinLDMxyg+iJEiY/vopFSPGvA/8hY
         gjMSDy7Y3oY8+Z14kotAiZT7X1xzOdgBo6eBCU6A7JpOlQOd0ZMdLFuP286aWwChjA9A
         dvNmZ40ed6Emw7eBKLbL0l+aUi1EeMxDjzuYjMF/4e9OQj0rIK4vo2WeNUBynqmoPBTy
         iWt3TKK6lkS4/fMHQdjjzq56T3gAAvq/1nH6A57YiQBzD/YxkA9utrYx8RYw8SWdoWo1
         /Jht9wN7oqI64PqPCeWz5+g8K7ftBUO/e90LZnr/3xgc/rUCdpaxZsK0SIoEYVnaRoLh
         +pWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t55UaS6rBsn5sbPESWXHBguQkipvC+R5S8CcCgaOjCo=;
        b=FbgrhS6Guew43KLhhjSJt9VEsvwA7HXfgBvLNTnGqzkFAxwIYKu0Tp7o1DBYTfY7kW
         kY5aEqDe6Yze6+sTVnMxjZVWWquOfiY5vZ8BR56funZmgqIML9LocRH04w05dwrPwtj3
         NhWb0ygce+kFDTkSQnGwsNN2UYV07gt/ezRSiYSjEYWy2W4BCPY+1fK3u7s1bZzuQAnx
         AJCaGUsdrT/4aTslP7mrYNzemaDXv3nBYzIdQ69gZYjmUO/jBcSDtRI8tOWiHN093Kkz
         +8dDrtLGhzlqQ4dMgGXWkQu/KaGI1bcluLe8HyKa5l4RxG474UVsFxcYW7rlUgAOSWdb
         ESug==
X-Gm-Message-State: APjAAAUVv9vCtwddR+WK2OZJws5WAbBoKMjqiNOt9o/4Oj0/FRW49rHB
        WyMWnuj/jJdpMkphm6CbI3Q4bwpmw2E=
X-Google-Smtp-Source: APXvYqyKzucly6AoottuXKIRLaNgcCw/xKyGvBFTT1L0zpoCb/ZCD50ZlX2/+VSmEnMeOAHP/JfGkA==
X-Received: by 2002:adf:ed82:: with SMTP id c2mr16425134wro.176.1556025988984;
        Tue, 23 Apr 2019 06:26:28 -0700 (PDT)
Received: from localhost ([51.15.41.238])
        by smtp.gmail.com with ESMTPSA id z20sm13478823wmf.34.2019.04.23.06.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 06:26:27 -0700 (PDT)
Date:   Tue, 23 Apr 2019 14:26:26 +0100
From:   Stefan Hajnoczi <stefanha@gmail.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: remove unneeded linux/miscdevice.h include
Message-ID: <20190423132626.GJ32465@stefanha-x1.localdomain>
References: <20170918165854.23408-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5me2qT3T17SWzdxI"
Content-Disposition: inline
In-Reply-To: <20170918165854.23408-1-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5me2qT3T17SWzdxI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2017 at 06:58:54PM +0200, Corentin Labbe wrote:
> drivers/vhost/vhost.c does not use any miscdevice, so this patch
> remove this unnecessary inclusion.
>=20
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  drivers/vhost/vhost.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--5me2qT3T17SWzdxI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcvxKCAAoJEJykq7OBq3PIxakIAKxmFI7MYIQXPO2NrlHONe5T
IoEK92iePJj7qb0xCK7O2yLLhnvzTgWJxpHCENRsAEFqY1ZGEbR+vnlkbKa+0ZCY
zcZdH6Ndl2KPut8yfQqhY/LGXFCDNT2ZZY851nWoPUpJ6e95LhcO4Grk5VKUS1Cc
v85zFOHJcWpHrmOVVg5DeYLZokXDGLYLHrR34kr3GwRM279muvjQovl67N73gO+P
sGtS88e4g5ax7W3WrFo4vqd4Jam284pYqH/gGm1SWiMIdQNmp40tZF9HLYfG5pnc
s4Rxf02nFEcsoC+F1FrPTHPYxtGoh61TzyCkYOk884j4E0q+Txrs8VpuOfwljkU=
=nDd1
-----END PGP SIGNATURE-----

--5me2qT3T17SWzdxI--
