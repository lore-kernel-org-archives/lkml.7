Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C18C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7009D20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551729237;
	bh=giA6uiGuJHeAeWZdu7sapZruLOXqUI5GTktC7GOoboA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d4k+LFLZEEeYzmrqV5g7UuK71CvMqe8slO18fQV0afKMSihEtD0WZHhvi1qOwA59J
	 6kPAKTc7B8AUBhgxMkrJX7xjnYidVkFGu4Sxj+2dPBVRx3h9LUY03ZzPRbN5sMONxI
	 kketURq0zvvRLWhfANMe4GpilnIIXyJ7kkw2wklQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfCDTxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:53:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfCDTxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:53:55 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7FF520657;
        Mon,  4 Mar 2019 19:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551729234;
        bh=giA6uiGuJHeAeWZdu7sapZruLOXqUI5GTktC7GOoboA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikd1IfSntVPb0jCcMvR23FsW66mmRPg+Ya5PloGrKhnh5ubKMv9akgFuOcgUavQ5A
         Gj1XK1+esNYB1ShEAhwM6zDPbgXRkAJ7E30YYkZPtpmh8Cy7xneTjGUuwbKJs0g1w+
         NkIHa2hCd4BOJKrnwF8Xivzt/ziElTavVoXspJxY=
Date:   Mon, 4 Mar 2019 21:53:51 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     john.hubbard@gmail.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3] RDMA/umem: minor bug fix in error handling path
Message-ID: <20190304195351.GK15253@mtr-leonro.mtl.com>
References: <20190304194645.10422-1-jhubbard@nvidia.com>
 <20190304194645.10422-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SzQ167Kp6Zo0TWVn"
Content-Disposition: inline
In-Reply-To: <20190304194645.10422-2-jhubbard@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SzQ167Kp6Zo0TWVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 04, 2019 at 11:46:45AM -0800, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
>
> 1. Bug fix: fix an off by one error in the code that
> cleans up if it fails to dma-map a page, after having
> done a get_user_pages_remote() on a range of pages.
>
> 2. Refinement: for that same cleanup code, release_pages()
> is better than put_page() in a loop.
>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>

--SzQ167Kp6Zo0TWVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcfYJPAAoJEORje4g2clinTO4P/0fRa+62AVNr9diB7JwN2q00
R/xwy4BeamgibjxK4ajFxNiuOe8kWL4M0xidWvIUIjhsljdVwNtyKUfH6SYi3YdM
chSj9iQeluos07CWbM9VPyGGBHZfQ13aTCy9P4tx/3JD+D03lZDBoP3tm93Mms4L
mxQwjxdBnBaquIpD98cIPZm31XXFUcRR/K7kMnPOBcXp+f2yx6DfJprm3tffb2Ke
9NgfVcIV03ZlfeC/NI2bj/MC17PZgZZBK2XqVTi7Wu0iYcy9J8nRlD2kVjNq/0rG
kxPMZ/O2K65gwnNSWtWPxsL074ekD4P5Mcn9D6Qa0MeFGotoGdDrEH9gJ4hmGFxG
1vgWYZRJ26JCoGASInbPKmPQBjC1bfHyUG83E8qfHHyTDzHj8ytcXXFtW2JMCSOi
nbqqX7ww8sXyAbCW2546yxCQ3AIL93g42gkwgGoxtQioovSkQ0eJoYSOT4cDxYEY
nsECMJGMhey3kqDDQGGvzZ31RZ7byaMQY/p6mc5hewRf8HOKHJEslsA1uTh5DkHq
j4duANKV3tZyw3sWQ+bf4s2NE0/EzH4wqIQWN2x7J6u+GDGM+JM9uLalXA+2tN+e
ks9z1cS4AXflaeIpV4q7p/bdqJf3JfrSsNY9WLFiryjF5q9c/4ejwYIRcsN1wq7D
v4WszJR2m5vaYxbOgMxo
=wIFY
-----END PGP SIGNATURE-----

--SzQ167Kp6Zo0TWVn--
