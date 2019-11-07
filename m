Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD6FC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF57F21D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="clNJrFnC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zmZ1v1oA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbfKGIa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:30:26 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:6635 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGIa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573115425; x=1604651425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fdGH/2GLSZnLIFL4YjAO80jIJHXR0Xhp+Bcd55bItCQ=;
  b=clNJrFnCiqZh7hacFmgxBS2q7Wsc/GtRKonbrZjz5LI42Ons9ytrdp95
   ftySxGItQCEfNa7lLfZWd0wlR+zZlAHzl4Aw0TNf5Z/dekzbbi8rV6JrZ
   /6ohWVmuQl8bm61wCshXJPOCmTAE34yW+l94RCpdosxQRtsk9Hsbqj7/K
   PU7vyb/9iTpSsFr5w10NcUtfjnYQ5HKj1D9G3VHs4w8QfOdB+zSRq4oJQ
   7yh8+5pWELcmV8EKDiOlBQY7y5/aF6VdxTG6DzecvX5jpfsUq2Dk0VeY7
   5tFMiT0Z5oIOBedckik7rqlbajaYr+GnYpxMoV12pTN1SbMThthl9v/BW
   g==;
IronPort-SDR: /cpPP5CdBAWMlgP4hU3rCQ58LrOtDF78Hj/zisUzD37sjX/0aSAs7m59kIYCCgzUuDO2N0N9C2
 n9CXKAu40jf7Rzbirjx6JYF8tw1KnVy1HLZPaqV0OaoGy19KQ77QtmaIfRtiqnvxeI6v8eO94x
 ZBYy0gQto1LfCbhafnrNUvIzs9on9EfYu5lVz8aJRQYLeQKmNZpDDIOE7QYCnsDB+OWSvmlgA7
 lTt6pdRztWIlqS2Kj/gXoauVPNZVDVQqFIsKJmTCH20yaJCcr2LJYGdi49GZVfp5QRuiNekX2+
 tLE=
X-IronPort-AV: E=Sophos;i="5.68,277,1569254400"; 
   d="scan'208";a="229600430"
Received: from mail-sn1nam01lp2050.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.50])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2019 16:30:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3+Hnzv1f0jUUBaCAH6I5yOzlnRK8PxfbWL47BV8xu9GB90YN5t77N+nMr626csrtak5QxkPq/qjiR0qeBeQj1HsA4pP4DoHSdMTXEqPsUOoEAWYUT1/LNLGVQF2/epVF8x0jWLpWoC1e/hDmaWikWHFBeS0An58zkZlEidhrCOAcqboKWgzffqVgkTrpCN8lfwjwuHVetIcCFCa8WESDo7xdGFfH/nWRePuT8GR5kOCRk1Gr7Cujo/z0u3vrPY51lJhwJxIZ8ve47SDcONTrq+jHJ/BUa+pes3U2FqPXB1ZNkb5VfvtZ+vUXtO3qis6Hl0QVp6lSTRDOFNqGxl4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cr3Au8g9HzxumIWu+xfuHxGm4dmJcSftCYunowwvemI=;
 b=ZR2yvEmAA5jiB/cG/+AMeED5lq1YBMAroLVSpE5WU28bJfeq2ibQi5WsFodmbWCduslOoeKh8tT6qzL2m1fgZY7jOrCOvoG0AZB+hkwTYbU1ZBrwIhO0DuCkOKTfykeCLNBQFuZ8bnEK33dGzcExkdgHALFwKyAnLv0PVRsjg2knnaE/skkvLWFPTFfe0LT5QMfqyFVTQ2xtYK3L/k7ejyZaH7n3eSVjDX7JI+IqEDNpQVH7tmIlPkhJoQVmh+Hy5MoJyfe8CUhg1bBlJt5sOX29gbQENu+ktzI8E3FF+hh7tNJb6Nohagn7ZhVSZLOb2MMEAFSpl+T+HyaDH5Dwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cr3Au8g9HzxumIWu+xfuHxGm4dmJcSftCYunowwvemI=;
 b=zmZ1v1oARsd1BBTGlQhGQmt0OdtawWvOxDlp7KA8FXzYGdVshKRLtt+68GHOOqYCdsfC90UwMNu0xplXISD3J6BWvqEsv6h5YX0YJd75yZK6oeyqKOh/cAXN4vSKVCGqgXmAsLSU+umfpxKcSJiviYwS6o5f1mwKu9OPuBm9dSc=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (10.186.144.209) by
 MN2PR04MB6942.namprd04.prod.outlook.com (10.186.145.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Thu, 7 Nov 2019 08:30:23 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::5852:6199:7952:c2ce]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::5852:6199:7952:c2ce%7]) with mapi id 15.20.2430.023; Thu, 7 Nov 2019
 08:30:23 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bradley Bolen <bradleybolen@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "yinbo.zhu@nxp.com" <yinbo.zhu@nxp.com>,
        "hongjiefang@asrmicro.com" <hongjiefang@asrmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mmc: core: Fix size overflow for mmc partitions
Thread-Topic: [PATCH v2] mmc: core: Fix size overflow for mmc partitions
Thread-Index: AQHVlRsip+rrxfkAO0KNHDyPQxqMrqd/YMxA
Date:   Thu, 7 Nov 2019 08:30:22 +0000
Message-ID: <MN2PR04MB69915AFED1B6AFD1B30EFBCDFC780@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <1573097159-3914-1-git-send-email-bradleybolen@gmail.com>
In-Reply-To: <1573097159-3914-1-git-send-email-bradleybolen@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 815b8989-178b-44d4-1506-08d7635cbb86
x-ms-traffictypediagnostic: MN2PR04MB6942:
x-microsoft-antispam-prvs: <MN2PR04MB6942A5BE7BC282091AAEA20EFC780@MN2PR04MB6942.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(71200400001)(102836004)(316002)(6116002)(2906002)(33656002)(6436002)(55016002)(229853002)(76116006)(71190400001)(99286004)(8936002)(66946007)(110136005)(54906003)(81156014)(66476007)(66446008)(478600001)(81166006)(64756008)(66556008)(2501003)(9686003)(6246003)(3846002)(4326008)(52536014)(5660300002)(8676002)(256004)(14454004)(25786009)(7696005)(26005)(486006)(186003)(76176011)(6506007)(446003)(11346002)(7736002)(305945005)(66066001)(74316002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6942;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SlIj+3Ct/s71Y6m9USnIVJfYkJWtCeec5ldREPajCiOyGKw4mWE3HOnoVzBJ7kJ8hDpQbU6LsCqXvXugwO71DlaBQeX9lmMyWTgiN/s8bL4+OAg44+1lRpPKQwine2+aYp8PclR4Jmz5g8f+/q9mhdVfAUbB3OnX3WKh0whnFxKb8txuX8yXx678iIKMXLIZferWWsPlkwyVVzJhWb/Jpxzh+ngTwMrI56SHIwHZAohjFMl3EuvjAhY7gqW8mZqeYkaKLsCys7umdpe0ce+/m2V+56AwM4NCs38VfvgnZXG7UwXqVUEyJX+cuhMbwXP5Ajr8vg+asuRyEeN/EKzNGsHgCXjwh4qFCuibCKGS2d35AH/f5RMNXHL7NR7wJY4jcjsmYeur6ge9QtsE9qORyUlbHwnFvzfJFL4+nCtD3zATomreoKEoqQWFYye6w/oY
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815b8989-178b-44d4-1506-08d7635cbb86
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 08:30:22.9436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHkAxlX42H7bwK8KsdT8NXNrH+enuSlLcSfzo7t4M3/j5RLK4zGcwYWnUcCmbKtGtSprVdiQLdsFNC9POuXW0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> With large eMMC cards, it is possible to create general purpose partition=
s that
> are bigger than 4GB.  The size member of the mmc_part struct is only an
> unsigned int which overflows for gp partitions larger than 4GB.  Change t=
his to a
> u64 to handle the overflow.
>=20
> Signed-off-by: Bradley Bolen <bradleybolen@gmail.com>
Looks fine.
Avri

> ---
>  drivers/mmc/core/mmc.c   | 6 +++---
>  include/linux/mmc/card.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> c880489..fc02124 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -297,7 +297,7 @@ static void mmc_manage_enhanced_area(struct
> mmc_card *card, u8 *ext_csd)
>         }
>  }
>=20
> -static void mmc_part_add(struct mmc_card *card, unsigned int size,
> +static void mmc_part_add(struct mmc_card *card, u64 size,
>                          unsigned int part_cfg, char *name, int idx, bool=
 ro,
>                          int area_type)
>  {
> @@ -313,7 +313,7 @@ static void mmc_manage_gp_partitions(struct
> mmc_card *card, u8 *ext_csd)  {
>         int idx;
>         u8 hc_erase_grp_sz, hc_wp_grp_sz;
> -       unsigned int part_size;
> +       u64 part_size;
>=20
>         /*
>          * General purpose partition feature support -- @@ -362,7 +362,7 =
@@
> static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
> static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)  {
>         int err =3D 0, idx;
> -       unsigned int part_size;
> +       u64 part_size;
>         struct device_node *np;
>         bool broken_hpi =3D false;
>=20
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h index
> 9b6336a..b59d35b 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -226,7 +226,7 @@ struct mmc_queue_req;
>   * MMC Physical partitions
>   */
>  struct mmc_part {
> -       unsigned int    size;   /* partition size (in bytes) */
> +       u64             size;   /* partition size (in bytes) */
>         unsigned int    part_cfg;       /* partition type */
>         char    name[MAX_MMC_PART_NAME_LEN];
>         bool    force_ro;       /* to make boot parts RO by default */
> --
> 2.7.4

