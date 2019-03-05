Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B22C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD68208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551804339;
	bh=G2mnA6MtdEgoJaaEDw5X3sG6WrPVPZUPF7LejKLxKSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vGbmJhpMWzNURXZBKbOEES9sF0SOBRKSaaa/LxsrT1wjKt1lK7+c47Ks094mGc4ep
	 k3h/bHnh656Ij9IH2tTxhXf6+sFsd9ssvJLtcTo3pBw3nhe/o5IYZdtoK5GQhYNM/9
	 MddQ+0m/aF19eOWLtdw9SNcVYwq+LYThMzdtSJIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfCEQph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:45:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfCEQph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:45:37 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E984220661;
        Tue,  5 Mar 2019 16:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551804336;
        bh=G2mnA6MtdEgoJaaEDw5X3sG6WrPVPZUPF7LejKLxKSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1qTO0K1iMlnmWuM9Zp8xmUDg8XvzvsCD5xK/oFqPeKqcFoD+QPFU8nyIXWCJNo2Fp
         XvM5kWcK4CNBa77A/7sfftOhjyZSVif3+VQUPmBOeV3xKdwz2FxHweUusfxhb7wAWn
         a4ZICKZWqPJMcKyaT+UwjaLFqc88qM9YmlyNBkE4=
Date:   Tue, 5 Mar 2019 18:45:30 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, john.hubbard@gmail.com,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3] RDMA/umem: minor bug fix in error handling path
Message-ID: <20190305164530.GO15253@mtr-leonro.mtl.com>
References: <20190304194645.10422-1-jhubbard@nvidia.com>
 <20190304194645.10422-2-jhubbard@nvidia.com>
 <20190304115814.GE30058@iweiny-DESK2.sc.intel.com>
 <20190305150406.GA12098@lap1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="o5hfEDzsoqw8wJwC"
Content-Disposition: inline
In-Reply-To: <20190305150406.GA12098@lap1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o5hfEDzsoqw8wJwC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2019 at 05:04:06PM +0200, Yuval Shaia wrote:
> On Mon, Mar 04, 2019 at 03:58:15AM -0800, Ira Weiny wrote:
> > On Mon, Mar 04, 2019 at 11:46:45AM -0800, john.hubbard@gmail.com wrote:
> > > From: John Hubbard <jhubbard@nvidia.com>
> > >
> > > 1. Bug fix: fix an off by one error in the code that
> > > cleans up if it fails to dma-map a page, after having
> > > done a get_user_pages_remote() on a range of pages.
> > >
> > > 2. Refinement: for that same cleanup code, release_pages()
> > > is better than put_page() in a loop.
> > >
> > > Cc: Leon Romanovsky <leon@kernel.org>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Doug Ledford <dledford@redhat.com>
> > > Cc: linux-rdma@vger.kernel.org
> > > Cc: linux-mm@kvack.org
> > > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> >
> > I meant...
> >
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> >
> > <sigh>  just a bit too quick on the keyboard before lunch...  ;-)
> >
> > Ira
>
> I have this mapping in vimrc so i just have to do shift+!
>
> map ! o=0DReviewed-by: Yuval Shaia <yuval.shaia@oracle.com>=0D=1B

I have something similar, but limited to responses through mail client only
and mapped to "rt" key combination.

in my .vimrc:

augroup filetypedetect
	" Mail
	autocmd BufRead,BufNewFile *mutt-* setfiletype mail
	 " Add Reviewed-by tag and delete rest of the email
	function! RBtag()
		r~/.vim/mutt/rb-tag.txt
	endfunction
	nmap rt :call RBtag()<CR>2j<CR>dG<CR>
augroup END

Thanks

--o5hfEDzsoqw8wJwC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcfqeqAAoJEORje4g2clinMKQP/1gRoq+qz5xGqSzz+mJjU+4C
PJBCXt4vZF7+Gu/HfveIlS7wAB0jNAAd71Sg7rrO8U2iCBAzBopL98o2UK45vBvX
d5FNoMi1WpbiiY3of2d2NbnWu+IhgjUNrixW257UjjBBCllXaxnnpgTsXtBspnFP
wztRSNdIIksIlJBZJEBI/PqvbIs81vdGyQrN3Iiz64uRRinb6GAx75Rspk5M/YFq
WDLMv1+ImDeG2GHOaaQHPK0n5Uaf6gU65vLOqGZp5haZK3lrG1RtcFIFhplqGNUh
xRy+Q5Alsy9RO1E4gfg43bQs8yFgESuhYUHeQwUgENIMLYMwel5sMca6DQEbq1qo
yupHSId4i4oLjujXjJoAsYJilxsjrMxTSAgc44EVhFzf5gYOYgVAccjBj6m7IZMQ
i0E6KROm+XxOPXWXYYXGzO1r9h6RFDA70dH06xCl3011WnC28T4QoMeFRPiRdIX+
sdQtVUEo1HG+x9hF3pmjj2eDCYQNh7olKJC+kIxA9bn9Luo8/Ipoxrohjuvhpmie
52Ekt8ks6TteBjM9E0+msNLpYLL0nF45nvKpUxGW2q6tXTgLnf4epuDGbxTNmZmo
ktbselHH74/nux7OYVG3pUd8w+4guXzmLky1w5aNfnbLsPNSv0shvQ1eJregy2JU
bMNmng/g87i+g5NnWge+
=lxM4
-----END PGP SIGNATURE-----

--o5hfEDzsoqw8wJwC--
