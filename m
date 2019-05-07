Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E463C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0470B205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557246295;
	bh=32zdtmSFU7gmpB48Jswp0pwOKODwXBGNxj9zkXofPE0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=cZxNBgrmenrNRrudTqX7PfdUH3+NGKkrkWdIvLKXe03FPFg/z21dEekKK9CaQaux5
	 wnlomOJu4BJEtQqnM5xf8eAUYHPNnpwGL7h8ggJHt47pU16FEa8AYQNS1LX7huw7+p
	 9gn01389LstotcjxJNqSmgPp/yu+6RdWocGNvjlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfEGQYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:24:54 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:38842 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEGQYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:24:53 -0400
Received: by mail-qk1-f180.google.com with SMTP id a64so4666200qkg.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iSNw5fu9lUP2MWiBpedtYkAamwdAf22AYRSw8dqpkoc=;
        b=NjJFTWJEcuSDKym1wWes+8rSRjiyMTVCtxK8R5Yo70hBVhhVNbjv0BlB3Rut6LW1uu
         Q6yRVr5VRdkCzqk9GmwvDlCWz5aJ4Qefh/x4MN0IhPA4HlPJDu7aCPwMPt7kRHa1nkr+
         uVVXIlPD+/RdEOCt7liyHhfpFF8bktBid26Vu3cKq7M8HjlR1krFErkcBKRob/VY5W17
         dIUbAmHNyl7FuWZBqRN/Oo/6jphVJhjtEtk55S1/LJaQ4Mw2Fn75llrBnlElMA+lYZqt
         DgPJwxsJ+sbTlgzZdbEcGkB3Gd2r+Ij6CJO3Uyp5gQ6JKFuXZ1vg2tTapGlgPaLfrQev
         0wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=iSNw5fu9lUP2MWiBpedtYkAamwdAf22AYRSw8dqpkoc=;
        b=roxC48rsR2M+Ls1g+5qvQiyYD29Imz42bf4DcUoSMbi5ak4OSY/1/9JH1VuS2pZHmk
         FrNtbtxikJVdlrkM6EHt6DXcEhFgeoizwAGtrTriSURx5JcZyoctDgewsTRjXarE4Rhl
         9AClijQbb3bKsuBsHiJHcQJARnWbNieB+pjB6W48eOq9tRjGyXzVYPg2737r/RAE7XzI
         4pyVkymtIOm/xbUA7WmapgOVLBcKI4eZItMvHniS0aYAnucWLmVfaHfPKpm6DzhtN+vs
         ARkySd1YGkY3onJlaH0+E3tSnkfjg3ODCiy8IC+cSajg8H7nkL8HYHbdK96eRNwx3ptE
         40QA==
X-Gm-Message-State: APjAAAX6y5R6cUsuGMoQ7sVClFLoJ7n8BDLadYumsj1GosUw4kSX9TB/
        GwPtT4hNnR/Q0UHImo6UKoE=
X-Google-Smtp-Source: APXvYqwhHr/1zzAbdilCsxzM93SPTG+zJd5uRO7jrTzHIUam6NUjs6kXmHnuXACDHAkgvN83jxUx5A==
X-Received: by 2002:a37:a394:: with SMTP id m142mr15434807qke.180.1557246292745;
        Tue, 07 May 2019 09:24:52 -0700 (PDT)
Received: from localhost.localdomain (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id 7sm8892335qtx.20.2019.05.07.09.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 09:24:51 -0700 (PDT)
Date:   Tue, 7 May 2019 12:24:47 -0400
From:   Konrad Rzeszutek Wilk <konrad@kernel.org>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     konrad.wilk@oracle.com
Subject: [GIT PULL] (swiotlb) stable/for-linus-5.2
Message-ID: <20190507162434.GA27798@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please git pull the following branch:


git pull git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.2

which has cleanups in the swiotlb code and extra debugfs knobs to help with the field
diagnostics.

Thank you!

Christoph Hellwig (4):
      swiotlb-xen: make instances match their method names
      swiotlb-xen: use ->map_page to implement ->map_sg
      swiotlb-xen: simplify the DMA sync method implementations
      swiotlb-xen: ensure we have a single callsite for xen_dma_map_page

Dongli Zhang (2):
      swiotlb: dump used and total slots when swiotlb buffer is full
      swiotlb: save io_tlb_used to local variable before leaving critical section


 drivers/xen/swiotlb-xen.c | 196 ++++++++++++++--------------------------------
 kernel/dma/swiotlb.c      |   6 +-
 2 files changed, 64 insertions(+), 138 deletions(-)

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJc0bFJAAoJEFKlDoTx2wm/rjkQAIA42+eXI4nVD/i+qetJbNxF
XmUUNt+WjKuUTvlllQGfiqN5Za9+Qc5vQAPOxXsi6UYxsYkuJEiOMsOpGsMjF3rd
v7/i5SuDOdhLnVyoQZZOoIQ2sKmYmNXFVr0eT9Va/jVnphC+06EGdgQd+KTLYVTv
KZUpIvgXLo4zZGqTuYKtBE6CmT1DKfZlYd5wCz7Z410FLvbKItv/R5Jh00dzlEVy
YaukyLLJ9tKVqIvKDVbhj1l5rbh+BFuYTHriIl8/KVvPE6Z+Ku0Cz7chKAhB8RRS
BoQfRtqK02kEEryPK9yNAdpUhSWb6v6yw8kXdabs+Bz1OTE7XrmFdk0aVVcWmoPz
Dv4lHrO0Lp6OriOkJY2IlTGaiBGQo3Qq1/31gDkazMoBBBHcUidTOy8AO3tr3QuE
uljmtKCzDSd61rhUFKnGzkZNaQ2QnMUjUZylUFq6CbIwaoRagUPJBUpqeKz1emJy
SY+38LNdtaTwPc5FVirtoz0sa2eG56L+wX8XGR5ATvqIk+ACR3/VANMW6kLR2DG5
Lj3fiUzOl8X5fksC6SaAu3/NCWw/HsSzh1i7qVxiXKgZHHY+Z9NqAOWQAqFXx4ob
RxAUVe2jxnDzErRpO5+52a8B+px5b1ijInXBaK9uAH/s3RywU9xT/LK9lFvtxBl1
e7TDyyIMZyXvhmBhnv2O
=wKk8
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
