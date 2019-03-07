Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83E5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B754E20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551978079;
	bh=Vxsye+JkmXQfcvarfpWknV0wQ+S0huawQuXfDeFp87s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=taAYBvrNMzvGQZRHZYLUikss3lnpdaXDnE5WxW2tE4H9Q8OOwzbVT14GJ24xijSGc
	 DUuz61H6NF/k/EsbWsyOOsRM23TwpawKm5Jd62ZeRVOPIlWK6HiosVVw6F/yJv36ID
	 wOALVqPnaciyRLNdlCGNQrdjzdh7DMKdUZCblDfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfCGRBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:01:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfCGRBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:01:17 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 395DC20851;
        Thu,  7 Mar 2019 17:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551978076;
        bh=Vxsye+JkmXQfcvarfpWknV0wQ+S0huawQuXfDeFp87s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jcyvsi6/LFcVLoCqQTHJLNuHe8zb8B6CvwSp8/YD0OoA/3oEE/u/7n/Zlt4IalCKb
         4uXGCGkXNokpy4xZoK9cwxuh2TI+9GgS8rrmpqd4JwEPQQ20tPyAfjqLtWNhN/ha6d
         vVfl6DoyG1j55J3YQwTbiMgqn4mpouO9dQYusRJs=
Date:   Thu, 7 Mar 2019 19:01:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/nes: remove redundant check on udata
Message-ID: <20190307170108.GQ1789@mtr-leonro.mtl.com>
References: <20190302230637.8624-1-colin.king@canonical.com>
 <20190304063623.GA15253@mtr-leonro.mtl.com>
 <815dea03-ef9a-39c0-3ec5-cdd58a545911@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Ah40dssYA/cDqAW1"
Content-Disposition: inline
In-Reply-To: <815dea03-ef9a-39c0-3ec5-cdd58a545911@canonical.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ah40dssYA/cDqAW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 07, 2019 at 10:23:28AM +0000, Colin Ian King wrote:
> On 04/03/2019 06:36, Leon Romanovsky wrote:
> > On Sat, Mar 02, 2019 at 11:06:36PM +0000, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> The non-null check on udata is redundant as this check was performed
> >> just a few statements earlier and the check is always true as udata
> >> must be non-null at this point. Remove redundant the check on udata
> >> and the redundant else part that can never be executed.
> >>
> >> Detected by CoverityScan, CID#1477317 ("Logically dead code")
> >>
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >> ---
> >>  drivers/infiniband/hw/nes/nes_verbs.c | 73 +++++++++++++--------------
> >>  1 file changed, 34 insertions(+), 39 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniband/hw/nes/nes_verbs.c
> >> index 828e4af3f951..526092d435df 100644
> >> --- a/drivers/infiniband/hw/nes/nes_verbs.c
> >> +++ b/drivers/infiniband/hw/nes/nes_verbs.c
> >> @@ -1039,53 +1039,48 @@ static struct ib_qp *nes_create_qp(struct ib_pd *ibpd,
> >>  				}
> >>  				if (req.user_qp_buffer)
> >>  					nesqp->nesuqp_addr = req.user_qp_buffer;
> >> -				if (udata) {
> >> -					nesqp->user_mode = 1;
> >
> > It was single place where user_mode was set, you should continue and
> > remove all code which depends on "if (nesqp->user_mode)".
>
> This is not the only place where user_mode is being set; we currently have:

ok, It doesn't matter, I'll clean it later with my memory allocation
conversion patches.

Thanks

--Ah40dssYA/cDqAW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcgU5UAAoJEORje4g2clinhMYQAMVjNOhrTtcq5zyPak5Slih1
fO1U0u7DXwIR4nyPd1Dim4+6/DsgX3Tzx7H7sjB+7kmBjQU/F0gppDuYvhH/+GA7
zgcLhkHT9G52/fvH2CZPZNb2c9y1S3CweV2e4s4wr0bHSEjJ9UnfEdJQ6jRRS4/V
gJlNWGM5Mv3f2GFmjpPeGGdmW7Z870y8aKS3TTTKt+YzcO7ArdJMfYS8LPSY2pds
tbJdFnrrG4YE7wlpmfCkyOThaulnT12eKjR/Bmwrwv5vWPl+DrCrn0mZ/ZgGDIyV
q/bNm5eRfIAt38pOFnC5vyAge8Pr3s05SW+rhqKGtVl4m0mbGumOEAKs5FZfT0iG
ULAjcHyiZfb6aQrg5B9Mv5eWOok2q4OGzlG0R4QWrP8dnj4I6Gl1ZFwaL8T6qL+8
ACfmtqZdR2PpHMf8YL7e/oNCRzGpZj9+w71r+cuBj6P44+PZbuDJ/PQ4mIoMUOII
sIWMocbFOb6wPT+Hx5qFhrZncJpYlKYWTm5gy7zd9Mv4u3V8PYJjlzzXwSJSjupL
XDdnwnBhpi7c2/28FrW6afd6qh+J2rYdQ2kP0DUL1Vvo6Ylxis3qy+Ce1CNLiQxN
eS+F7d8MJHeQr+eU5nta3XAVHLLKWQy5VuIXCw36iuvBzXC/xCJIS/d7QUkNRX6c
QMXOKHG/EXsJHpAn9S0m
=aqqe
-----END PGP SIGNATURE-----

--Ah40dssYA/cDqAW1--
