Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FE1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01DC2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553006116;
	bh=gjLJEnVok6+5lve3Vyn0DxS5+/afQzt+dHD2aoNJn7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k+7YQj5XawD1gfIhpukswjmRcHEvqVhjHGgFmNWjCPE28QZW4NFP6NlnGODNwberE
	 Qbf0259KGWovlCAzUXawg7UIsO4fFBiLGe7PYBtaN20DkpriaMHx2wIQ015fa6R9eH
	 wzZ1oZ7HMO8QHkIBmCuGSG+CdDS4GP1BO7AFqcmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfCSOfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbfCSOfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:35:13 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4221D2133D;
        Tue, 19 Mar 2019 14:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553006112;
        bh=gjLJEnVok6+5lve3Vyn0DxS5+/afQzt+dHD2aoNJn7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z68FNAdHd5jFaI6eRPCY4fwlkpXk8FpbWEhujPplNXeczZ9siDtSpcsPIuw0KvJLc
         kO2ikSPD8SCueOUC752rZIuyrekRnVpOWVpvpPo4VBHPztjm9/C5jXglff7et+37zw
         GJvH92q2oBjkxioy8+F+qTdsv+XG75SxcyQt1hU8=
Date:   Tue, 19 Mar 2019 16:35:07 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Boris Pismenny <borisp@mellanox.com>
Cc:     Aditya Pakki <pakki001@umn.edu>, "kjlu@umn.edu" <kjlu@umn.edu>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: mlx5: Add a missing check on idr_find
Message-ID: <20190319143507.GO4823@mtr-leonro.mtl.com>
References: <20190318221924.7034-1-pakki001@umn.edu>
 <e48d6cc9-9bb2-47fc-ec04-eceecbe6d91e@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Rmm1Stw9KgbdL9/H"
Content-Disposition: inline
In-Reply-To: <e48d6cc9-9bb2-47fc-ec04-eceecbe6d91e@mellanox.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Rmm1Stw9KgbdL9/H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 19, 2019 at 01:41:49PM +0000, Boris Pismenny wrote:
>
>
> On 3/19/2019 12:18 AM, Aditya Pakki wrote:
> > idr_find() can return a NULL value to 'flow' which is used without a check.
> > The patch adds a check to avoid potential NULL pointer dereference.
>
> Did you encounter this in practice?
> This flow you are suggesting shouldn't be possible, because the handle
> is always there until the socket is destroyed in sk_destruct.
>
> But, I wouldn't mind some defensive coding here.
> Maybe also a WARN_ONCE :)
>
> Could you also release buf in case of an error returned from
> mlx5_fpga_sbu_conn_sendmsg below?
> Otherwise, I could submit a patch for this.

Boris,

Can you please invest ten seconds to read previous emails prior to answering?
https://lkml.org/lkml/2019/3/19/36

Thanks

--Rmm1Stw9KgbdL9/H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJckP4bAAoJEORje4g2clin8lIP/367xE+vAKvgzuFbzOAJYH25
I2VHgXebnt9n6dJ3VzJAmQSPTj0YlMKw7SGofXPfTybNv9G55bo1H8DsyBvpsyf3
xBRy3G55CA+na1Qwc8CUtX3VPmNnn+Wn8330UOjv6uuRm0qF0DaxwmXqoCwR43DN
+2JXg9Vi8wqfUbu++WD8xSpVYnzgmAlS8R1UbQNIuy4FZWGRKWOOhh4PKwkmw8NQ
69BCU6xjLROz5KcPLo14oH3a/M5l7WiwYBIcl42a7jguOnc5AlVAZ9wekm7yLymP
Vcg2UyF4STMnCkBVGi7J1wwculitBGo/d4LLQScmGDFA0JBh4SVvQb7SIMJMe9W/
bY18njmMtSmEYRmqRZYykkUGCGmoSY8hfpHT9STm3e0vVCsGjyBX4O7B61sg4lgo
Y+niypJRR9jSolYDmlBxVqvV0J2DcuX4Pn8qorg4Q/3ftiDGSzzAoNsc1icU6YSA
twd4FhT1jnS3L9r2bE0UJhxFCnkqxYjAfZa3DH6s57F7J7Zp4DVAvLhoSvAVeoFe
ft8kkUDwXWKJCjVT4jng82KlgX4tpehA/ucwCEeo+1vo1cVCTQ4yEXhSxATIIgZ1
nuhWVbk8w8gxD6aHckYBlXsgMkq8VlCKVSeHqgFGrZIKOADpLFFR6S3FsPv3J0c3
gQ7ghJR9KJP5brC+Of6P
=EJK0
-----END PGP SIGNATURE-----

--Rmm1Stw9KgbdL9/H--
