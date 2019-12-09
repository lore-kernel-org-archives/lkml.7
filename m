Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF9DC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83877207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKwW1swh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLIPYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:24:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39845 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726197AbfLIPYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575905092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nB6ZHawHDOXURarJ90WDoWMg8/PhBTAdpkSRqi1R6OI=;
        b=BKwW1swhZhP1B2lhYP7uHtpPySOg6DeaIifyQgwnDsZqJ5GbVYaIywlxYJY6KuZlFfhboj
        4c5RN/GE9YHhyYCzUfO1gdKYY4OBP/ZKw6cN5l9ujhmrjA25Gtc9PIFqZPQE1+LK1tOQY0
        83yx9TRGNL51DvKoscOVG3Z9ioGv2Q8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-1v8MeZ7nMZSlxfk-7GnxQA-1; Mon, 09 Dec 2019 10:24:49 -0500
Received: by mail-qt1-f197.google.com with SMTP id b24so6873293qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 07:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=23mTn2Hsu8HBM40Dn4qvKK+XQePiYEyO60VZuaQCZLw=;
        b=F+lGZYtYg3OTSBCEYzfWvKGuZemCso3k3HNFLGGO96Jm4NCnJfe0vlJCHLqrSwPPaO
         d73qXmaFpWSjYZeszJy0AqVvWaBLvLGj2x2UYuYSOeqafNResyo/leXpzhL4gTv7h2a/
         9PYte9n77xSmoVHxvRmfwObTo7cvFB49Ysq/oJ1fqnqvTrEmTqUm01szdQAzqS77+B60
         7re6XGEfs8aoyp0pDAfdk00Gtu3UYkxclvFi05Ui1s+eBrZzpCVtKN9n5jPiWTsH9Dow
         dysezuhJEd+ceNe0sjC+/oWNkSH7sdAWfz1c4tIIjMiJRD9P9K7sOPLf8HE+L5zo0p7e
         Rj0Q==
X-Gm-Message-State: APjAAAVJ8I78yvLLwm0/smV5Guf4L/3CeThn2e5sV9ljxBVmS7aigZrR
        HA3/3SHIbtl3rsNPE1y1rk4EOL2kWwXRHdhH6wlDMplHCnddzpBDSs0xpu6owRksy9rnxU19Aj1
        JcfE7w6ECdystbjW/8iHuaBvq
X-Received: by 2002:a05:620a:1307:: with SMTP id o7mr4424856qkj.312.1575905087936;
        Mon, 09 Dec 2019 07:24:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZHxF+oTtQnreR9C126/PGX/qNFYXwsWmTdGq2+iQI5uui3YJebhgNx7HlagBKLnY7YJzz+Q==
X-Received: by 2002:a05:620a:1307:: with SMTP id o7mr4424792qkj.312.1575905087254;
        Mon, 09 Dec 2019 07:24:47 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id p126sm8967524qke.108.2019.12.09.07.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 07:24:46 -0800 (PST)
Date:   Mon, 9 Dec 2019 10:24:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vhost tree
Message-ID: <20191209102431-mutt-send-email-mst@kernel.org>
References: <20191204142404.56631d84@canb.auug.org.au>
MIME-Version: 1.0
In-Reply-To: <20191204142404.56631d84@canb.auug.org.au>
X-MC-Unique: 1v8MeZ7nMZSlxfk-7GnxQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 02:24:04PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the vhost tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/net/ethernet/atheros/atlx/atl1.c:2889:21: error: initialization o=
f 'void (*)(struct net_device *, unsigned int)' from incompatible pointer t=
ype 'void (*)(struct net_device *)' [-Werror=3Dincompatible-pointer-types]
>  2889 |  .ndo_tx_timeout  =3D atlx_tx_timeout,
>       |                     ^~~~~~~~~~~~~~~
> drivers/net/ethernet/atheros/atlx/atl1.c:2889:21: note: (near initializat=
ion for 'atl1_netdev_ops.ndo_tx_timeout')
>=20
> Caused by commit
>=20
>   29fd1db09264 ("netdev: pass the stuck queue to the timeout handler")
>=20
> I applied the following patch:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 4 Dec 2019 14:13:18 +1100
> Subject: [PATCH] netdev: another fix for "netdev: pass the stuck queue to=
 the
>  timeout handler"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/net/ethernet/atheros/atlx/atlx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/atheros/atlx/atlx.c b/drivers/net/ether=
net/atheros/atlx/atlx.c
> index 505a22c703f7..0941d07d0833 100644
> --- a/drivers/net/ethernet/atheros/atlx/atlx.c
> +++ b/drivers/net/ethernet/atheros/atlx/atlx.c
> @@ -183,7 +183,7 @@ static void atlx_clear_phy_int(struct atlx_adapter *a=
dapter)
>   * atlx_tx_timeout - Respond to a Tx Hang
>   * @netdev: network interface device structure
>   */
> -static void atlx_tx_timeout(struct net_device *netdev)
> +static void atlx_tx_timeout(struct net_device *netdev, unsigned int txqu=
eue)
>  {
>  =09struct atlx_adapter *adapter =3D netdev_priv(netdev);
>  =09/* Do the reset outside of interrupt context */
> --=20
> 2.24.0
>=20
> Then I got another build failure:
>=20
> drivers/net/ethernet/natsemi/ns83820.c: In function 'ns83820_tx_watch':
> drivers/net/ethernet/natsemi/ns83820.c:1606:3: error: too few arguments t=
o function 'ns83820_tx_timeout'
>  1606 |   ns83820_tx_timeout(ndev);
>       |   ^~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/natsemi/ns83820.c:1552:13: note: declared here
>  1552 | static void ns83820_tx_timeout(struct net_device *ndev, unsigned =
int txqueue)
>       |             ^~~~~~~~~~~~~~~~~~
>=20
> At this point, I just used the vhost tree from next-20191203 ...
> --=20
> Cheers,
> Stephen Rothwell


fixed up now, thanks!

--=20
MST

