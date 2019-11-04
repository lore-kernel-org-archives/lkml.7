Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480D5CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1228920B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WR3jYNL4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ImGjTiN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfKDNh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:37:56 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:41953 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfKDNhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1572874675; x=1604410675;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=seRPaLhDA4dWrjXKUvCCznh27RBvvuw/jblz1N545Ag=;
  b=WR3jYNL4VshpdZ36YLqUmGPQkgfftUS3mxjCkXhKxfqUO0/eX766W8ZY
   QsaphW1J3PGeF6qjgecJ4jBDYsw4ilR724Lj02M/TvbOR28hezIOKdpG5
   SXtHHIWUdzugU8o1GoRLmEhTBcXT/zlwqgJNnYDuykrO6uthOl+GpRqqU
   Mp5F2flTkDWUneTQgZTclhE+YfCsb+MlHYS5bmfmNtrk0mQZrTKWKeK37
   Ox1j2kswtVE1S7FG6dtsjVzmNlXEJP9mxuGgcPP1PjqzG+NSL+4fbM7Pl
   UjvdU6XL3O7gYEM0yict67hxsIFgKZGoRie11iTg6xQgwMXzDD6yJFFbT
   Q==;
IronPort-SDR: Ybj3ETyPJ3hoG10Ll0xKpekm4Ac6HH4JMjCOLjLklOqFy5wDLS5qJoT2jj2jfyyUe6QQdX5iKz
 6lgKQsFjZGE/t0XT4HsCRu5nHOfZ9iWA9PDeeSF2USDSiy3L8xeaRkUVMFrWEbx9KPnO1DstwD
 9UvyGR55Ku/wDsKLzht01/0Qe8I8RWrGNfmzgT68RBJ3mI8tDyeWtn9bkuec8i3kt47hCgRraM
 ZgSBR4mNiwgiTd96eoP++/O1eJY9RWD1ybXgmp7csw1+zEdCoxEYu42SVn+flOk8F0zcz24/WI
 Pvo=
X-IronPort-AV: E=Sophos;i="5.68,267,1569254400"; 
   d="scan'208";a="123652266"
Received: from mail-sn1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.52])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2019 21:37:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxbcoZNY0Nomn1PeJ0KYVkRo9SniEC8bfnD3j7KE4MQzgfBTe2JAi4rcTj76GQoJ2zUt0zQFtz1RBBVbC7QaIJDFcHBCxMGP+Hnf0q1YYnOvE3pc3lcMaWtH/BbxBAfStNwSnmwByHQTBp3MSlpZ9jIjILy+91AvLi+hs6V0tOfv3XXqKe64sztDMeTwem63xHNCPEDmfSjhROZi2yoi7Jkc0KgUtE8wutTI2f8kmRoMA4OOWrrD02S5r1FqxAbvPLs7CvEcxASX3dbogQGk45jZoTebxjsIj+ugyAzQ1fSR3nKr6viEucgBe9B6CW5yDjQBMjwWEgQFzXWUPobYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRbEe5sRhn6IVTGKZ95kv764QD0GluXpc4BXuAN08uE=;
 b=TwioxwuS3aV7ytsLuXB/kDA1Qnp264keGsy/c7HCpZeGs2weWnkvtqh8CQoVZyTMAnWTZ/ZzY8brunVY4FiFVNRujAiE6IV7eanbPVWmgq/0ee36/GwynPFFhLcHpVjz8PvxWu8TdwDdb55Sv0rlWqv6vqWSv1/0ejCwsCcSzIL5oGzimvtrXqC+Tqsim+fKE8ZGvYQr/SS3XIYy3Vn1TCmU1EKnfb8bixGRB0obQPyAeCoCQjMHc46uE50K3pxNaHACtfCI/FW+/LZ4Jm8Mpmjs8r+gMhB3CHziN/bwtQCWbg7u2Hjl0wsDB7oCh7Kdvtoi2Y5F2tYrP3jzZH7MOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRbEe5sRhn6IVTGKZ95kv764QD0GluXpc4BXuAN08uE=;
 b=ImGjTiN4zj9uMxOySCRCj/thwJA4FsuiJMe0DeIu8IhySdODypuIig63i86lCfbdSX8tRPuOAX0rYkNruS6eDvvUEl9shK+KmmdYiFtbAXKrU0FexqoRxpjljdOk+fmhjISxqwmwR9Bh+1QcaHjcDlcz/udfqmfrILIL3lXAEf0=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (10.186.144.209) by
 MN2PR04MB5775.namprd04.prod.outlook.com (20.179.23.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 13:37:52 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::5852:6199:7952:c2ce]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::5852:6199:7952:c2ce%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 13:37:52 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bradley Bolen <bradleybolen@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "info@metux.net" <info@metux.net>,
        "hongjiefang@asrmicro.com" <hongjiefang@asrmicro.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "yinbo.zhu@nxp.com" <yinbo.zhu@nxp.com>
Subject: RE: [PATCH] mmc: core: Fix size overflow for mmc partitions
Thread-Topic: [PATCH] mmc: core: Fix size overflow for mmc partitions
Thread-Index: AQHVj4iHC/4Zqf+xVky+q9mZEDTeuad7Cq3Q
Date:   Mon, 4 Nov 2019 13:37:52 +0000
Message-ID: <MN2PR04MB6991B930872AB555EB56F16CFC7F0@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20191031011132.5947-1-bradleybolen@gmail.com>
In-Reply-To: <20191031011132.5947-1-bradleybolen@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e39053e-3be7-4338-e7fd-08d7612c3108
x-ms-traffictypediagnostic: MN2PR04MB5775:
x-microsoft-antispam-prvs: <MN2PR04MB5775EF8927C14FF2B00C603EFC7F0@MN2PR04MB5775.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(189003)(199004)(8936002)(3846002)(8676002)(486006)(81166006)(316002)(476003)(81156014)(6116002)(66946007)(64756008)(66476007)(66556008)(66446008)(2501003)(52536014)(11346002)(6436002)(76116006)(110136005)(446003)(4326008)(256004)(25786009)(2906002)(54906003)(99286004)(478600001)(66066001)(102836004)(26005)(7696005)(186003)(55016002)(14454004)(6506007)(6246003)(5660300002)(71200400001)(86362001)(71190400001)(229853002)(7736002)(33656002)(76176011)(305945005)(7416002)(74316002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5775;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MYCNtNMt81oklcU1F+f2PEBcg/f+BSLrecUu/pt2J6gNlkskHjrqv9NF/xfSr0LmLw+sY17RUi0CyB6f9wsC3o39BQPlqhh7Iv89iWrAK74lxddWK6rlwS6ATzmpTwPTerCCAKm09RUfpt9hMhZdTWNAbX0ssao2rwOz9MyEAhVjH9fQvlWXufWAjsUWUG+aMFDj3KPZHFzru0G+YT5/jQswnIDt/5upu9y7lmg0eUXPvVkBJ2QB5o5FAXhg7y4hVyqYW2npyVuvLkms79isyKoy44Vt8nQWUxY9FOssbAAxJc3TgwSWabR/OYd5694FONirQpd6aaHAcxjBnqQTowv/8+Aa7/6TiBd1PAUNwHaM56G3SxrYROfLz1xvYIlMoJbqOFHdptuEmadPvGYFYOB8qOZhobMSg1zwDxz9n0V3B7KUrsi+pivbW3qIw7vz
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e39053e-3be7-4338-e7fd-08d7612c3108
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 13:37:52.4455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sSF5oPvLIDre3zzt4tpOQbfi7pIy4Mbhqmmr90GOuV9IGA6hsmy10e96jqZhXVqYqS8jbJhiutXiiR3XV3/YqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5775
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
>=20
> With large eMMC cards, it is possible to create general purpose partition=
s that
> are bigger than 4GB.  The size member of the mmc_part struct is only an
> unsigned int which overflows for gp partitions larger than 4GB.  Change t=
his to a
> u64 to handle the overflow.
>=20
> Signed-off-by: Bradley Bolen <bradleybolen@gmail.com>
> ---
>  drivers/mmc/core/mmc.c   | 4 ++--
>  include/linux/mmc/card.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> c8804895595f..4e89cf6524a1 100644
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
> @@ -345,7 +345,7 @@ static void mmc_manage_gp_partitions(struct
> mmc_card *card, u8 *ext_csd)
>                                 ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3];
>                         part_size *=3D (size_t)(hc_erase_grp_sz *
Need to adjust part_size as well.

Thanks,
Avri
>                                 hc_wp_grp_sz);
> -                       mmc_part_add(card, part_size << 19,
> +                       mmc_part_add(card, (u64)part_size << 19,
>                                 EXT_CSD_PART_CONFIG_ACC_GP0 + idx,
>                                 "gp%d", idx, false,
>                                 MMC_BLK_DATA_AREA_GP); diff --git
> a/include/linux/mmc/card.h b/include/linux/mmc/card.h index
> 9b6336ad3266..b59d35bb50ba 100644
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
> 2.17.1

