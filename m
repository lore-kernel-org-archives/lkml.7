Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F34ACA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A6A20659
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a955DpO1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="l4rQHm5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391676AbfJWUcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 16:32:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:28112 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388677AbfJWUcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571862721; x=1603398721;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=KLgLUlVsnnPLZeUMYrdO/imm8HBbdPPvzdRbOkiJnjQ=;
  b=a955DpO1jJ1ejGtphFMXonKSNWo88hm/VfWeR3g1QEzjQxBc4XDesqMX
   Q57zlwd3Xvt1F5zQSE48fpgqjDZRPb/b7XAhjiGXKYsTZe/W5J1Us4z9B
   1gWO+XzbC84JZH7t9Mkwjk6VjRXguqpPy82ji9m5a5V6L1gpUP6GK5WkD
   fkNqL2ysq/015BFqLLCfMb6Jo4K9OFcvLVDxKUvz9fc1e5jVvhWqP/LI+
   y4/lDsbBJCEHRccunF4dkMbnZC6WJzVeroIX4oLMyCXB/7gE7TBAz6sqW
   BQTsM/znLxzWKb3PJ7yIO6Dy4PNAPCh8HK4aGDTaBE9UL7L4Aiihmfts8
   A==;
IronPort-SDR: 5umrMZGbR1676MZWVWSSs9yqqeNsYyeNAIN/7LlGfxNnfoVrnWUPYiRnAlX2bF/ccJ4J2vseGv
 lTKaHxKDKRzW28SO3IjzmVNWRvBkBR8f3HFc4UQJJPDJNQFmSHJAvpNauF7z22m0zIO9nV9OS2
 gHqB18eOAiGl/X957x4GNckzxLC3ITCgiyJ6Kp8xBJ/cKnad7G/YAnIaaviNLMYlnSYr1XRoAU
 nJTihLn0mVX1kxUv65pSoQTAppbiowKwqpQMz8PHt/hykIWa4ESQvAXBfsoK+meQlivOAGmG/o
 bcg=
X-IronPort-AV: E=Sophos;i="5.68,222,1569254400"; 
   d="scan'208";a="125613127"
Received: from mail-bl2nam02lp2052.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.52])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2019 04:32:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQeVkgmibBk9AMtc9SGCH7nM/sSJHWecQfuoP5IUK49zkmEAWZ3CgMhUG5mNa2QWq8aM9YR/1jiTBOFwMiWlyDb2yoxWPoNH/sby4BRSjOge+6Yi3V1nFIIarAQmSCbew3oV+KoN/tUQlKjhpxl4nbYKrfmqxEDvfH/0oKn+lt/zakwcZHvlX3ZZRsH8z7FVp14n0U5S097ypyN1duw/MdoxH61T5nCMS+21FN3ss/mdWfW1jsVj/aM742kE5SaJZnJk7z76bc0WD9cwarW7ztrUrhSMSJJYWMVW8fy1j1iecQ/NezU49VH8VETDpIQtJ+DOCqWkjTytGaYgesLDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5fcLxJ1B9t31WnbPJ+ZXZilHMPckk1o/Y8b4BuuDGw=;
 b=fMwQMEm00jIvtN3jzXYQsN5KQPdF9Sk1tdwQ7aPu+44KpZfiPAHaqxxqenRlhCDuBs5TWqDmX4yaO8xvhuGBWj76/fn/eVzyNRhu0ZJmB5SuZnKYnTgcjyfVsTufBMl4GyfBMd3dWGf4mvewo9lhhU8/WXsVsPDGxrKhgHmiH8qt8QnwX8xpUIgam7wHYegS/BiHATSx9GLP6mfrNbfvB6g+gIAy9p3YZjvohIV53aMKemgNXstMsrTeri0NSn1HSMZOr65ACKZA8aNwVYC4qfSvMmBtN19ZqP/hSGLqkgmlDS2/xGcA8sfSZB00gzNXEUt8ZNQUz8eBgJDDNQdYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5fcLxJ1B9t31WnbPJ+ZXZilHMPckk1o/Y8b4BuuDGw=;
 b=l4rQHm5AbUDlx5muRdQ6C29r0AxBqm0Dwe8mKVpdYw4P9GFKs6pYfnoUjFtDeEtFFVXg4m2xj/uvwi95scU/fmqysPQiPHS+UvbWNN7CuErH0HGRMRE+ApRFXBs3bVHeIngqnxungFD9HXUPJnvl5dyZHz+uYKBUCHyt0TPWMpw=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4742.namprd04.prod.outlook.com (52.135.239.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 23 Oct 2019 20:31:58 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7%6]) with mapi id 15.20.2387.021; Wed, 23 Oct 2019
 20:31:58 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH 5/7] nvmet: Introduce nvmet_dsm_len() helper
Thread-Topic: [PATCH 5/7] nvmet: Introduce nvmet_dsm_len() helper
Thread-Index: AQHVib/6vP1Zu73G8kKgTvQAkF+kfw==
Date:   Wed, 23 Oct 2019 20:31:58 +0000
Message-ID: <BYAPR04MB574984DB7059767E40564B4C866B0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191023163545.4193-1-logang@deltatee.com>
 <20191023163545.4193-6-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b7288b3-be2c-4f2b-e51d-08d757f80d84
x-ms-traffictypediagnostic: BYAPR04MB4742:
x-microsoft-antispam-prvs: <BYAPR04MB4742B21D42D20B42E20DD1B8866B0@BYAPR04MB4742.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(76116006)(64756008)(66946007)(66556008)(66446008)(6506007)(66476007)(7696005)(8936002)(26005)(53546011)(66066001)(76176011)(102836004)(55016002)(99286004)(256004)(229853002)(186003)(478600001)(14454004)(2201001)(86362001)(6246003)(110136005)(6436002)(81166006)(81156014)(52536014)(9686003)(305945005)(2906002)(2501003)(4326008)(5660300002)(3846002)(6116002)(8676002)(486006)(71200400001)(71190400001)(54906003)(74316002)(446003)(33656002)(25786009)(7736002)(316002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4742;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: knHcFNFdz8e8iilLjtzqjucvuEF9qennVdjpB2/VQIWxUbN6Npf4wbKokBMi5XalDZvSEa0fELhcgG7r+u/DAbu/LqPxwBe3wcfXHsQdg6tJhVqwVjsLR1QX58gbB+Yc1wUdAUIjwB2oOJ/GKPx/8m9ifaBUD3CwuQBcuxq1AqAZ/dGGIfGoi4lCrZ4YGfj6cNhEqLMTXTqDqUz2Gn1gwIjl3BYf9ScRcjlVyS0Bg9j6HD4kZEdXRIOQ75ve1XC3ey2varbThi2OJcsSskNwhJ7Run4SYY+LpKcDaPp/rAwbBf/x+C1RkLLe6KXH3oT8Tq4reJa8bXpy8CafMZijPDSxgjleT9foNIFXqi6QfMOKCIQydxjv0IypTCP8WOJQdKKCRBaVoUxPiFW1UN/dlMvMGmt9IXPYYRstcCs0naE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7288b3-be2c-4f2b-e51d-08d757f80d84
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 20:31:58.4964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWE5wsouLi3es1nV3ScPObZGj7YWfDuUgOsmIR5IUuOBc1GayhBt/6dORrzJhZf9ILZFeD+VAmpReRZSErqch8RAXLtHJ7y+96Ia4Zhoz4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4742
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 10/23/2019 09:36 AM, Logan Gunthorpe wrote:=0A=
> Similar to the nvmet_rw_len helper.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> [logang@deltatee.com: separated out of a larger draft patch from hch]=0A=
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>=0A=
> ---=0A=
>   drivers/nvme/target/io-cmd-file.c | 3 +--=0A=
>   drivers/nvme/target/nvmet.h       | 6 ++++++=0A=
>   2 files changed, 7 insertions(+), 2 deletions(-)=0A=
>=0A=
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-c=
md-file.c=0A=
> index 05453f5d1448..7481556da6e6 100644=0A=
> --- a/drivers/nvme/target/io-cmd-file.c=0A=
> +++ b/drivers/nvme/target/io-cmd-file.c=0A=
> @@ -379,8 +379,7 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)=0A=
>   		return 0;=0A=
>   	case nvme_cmd_dsm:=0A=
>   		req->execute =3D nvmet_file_execute_dsm;=0A=
> -		req->data_len =3D (le32_to_cpu(cmd->dsm.nr) + 1) *=0A=
> -			sizeof(struct nvme_dsm_range);=0A=
> +		req->data_len =3D nvmet_dsm_len(req);=0A=
>   		return 0;=0A=
>   	case nvme_cmd_write_zeroes:=0A=
>   		req->execute =3D nvmet_file_execute_write_zeroes;=0A=
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h=0A=
> index c51f8dd01dc4..6ccf2d098d9f 100644=0A=
> --- a/drivers/nvme/target/nvmet.h=0A=
> +++ b/drivers/nvme/target/nvmet.h=0A=
> @@ -495,6 +495,12 @@ static inline u32 nvmet_rw_len(struct nvmet_req *req=
)=0A=
>   			req->ns->blksize_shift;=0A=
>   }=0A=
>=0A=
> +static inline u32 nvmet_dsm_len(struct nvmet_req *req)=0A=
> +{=0A=
> +	return (le32_to_cpu(req->cmd->dsm.nr) + 1) *=0A=
> +		sizeof(struct nvme_dsm_range);=0A=
> +}=0A=
> +=0A=
>   u16 errno_to_nvme_status(struct nvmet_req *req, int errno);=0A=
>=0A=
>   /* Convert a 32-bit number to a 16-bit 0's based number */=0A=
>=0A=
=0A=
