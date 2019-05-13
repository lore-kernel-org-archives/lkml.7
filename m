Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF54CC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E3121473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YD2J3JX6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eUb37EO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbfEMPeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:34:20 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33549 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbfEMPeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557761659; x=1589297659;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=flGhTy3TR+0mqV5XhaZmrjl1ZW+5B/gzMUXNDgdGT2k=;
  b=YD2J3JX6qi6ZqgNvqawH+7A2bj0HoUEZFKEjMKZTACQ+h2Yc75Ruj7Gv
   Loyi2VNDplrw6i2jTNJVc7PbEkk0dON0joKOVISISX0W3PlkjSk1aFkeo
   8RxzNUzjBw6yIakK1NiAPkH532r0y5SSxPaQtw1OBVvb7fTk2Dyt7M+Kj
   pMdw1Zfy7dTyOFS1j9DqildmlefVEVxyqN8xhI6g/amNxPV/Qa9MeoiKA
   z42IGc3o+3s3SXux/4HFXuMqaOwrj6fz5W+OUGltnauexw81MpdYO0Wb6
   ZK0XoG+Xzncnye42cXCet0jOrbLgpQ0V7ERPsA8kYYaw/Lu4CLP9//xqd
   A==;
X-IronPort-AV: E=Sophos;i="5.60,465,1549900800"; 
   d="scan'208";a="113093643"
Received: from mail-co1nam05lp2058.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.58])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2019 23:34:18 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=patcxQKA/m5B015jcVT8PhapMHr65hzcFhJpilxr6N0=;
 b=eUb37EO1nHTMGYlxVA0xdb+Hy98MTrGzMmv6Jgskog4ohoyKrBhBn90rx+G+7Wpn/QrUf6zsO7a37/C8WOupvfQ7Hi9KdLm+C2jJ13W11S+tz12jvBCe8xKLBs8OtZKtKihom3iY5z1ztgoWJW8SCKprtocN3ZsGeGxyfqQyBmM=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4829.namprd04.prod.outlook.com (52.135.122.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 15:34:15 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 15:34:15 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 4/7] nvme: add basic facility to get telemetry log page
Thread-Topic: [PATCH v3 4/7] nvme: add basic facility to get telemetry log
 page
Thread-Index: AQHVCNsftCzLP1UjZkWS9UhDPRIwqQ==
Date:   Mon, 13 May 2019 15:34:15 +0000
Message-ID: <SN6PR04MB4527A2B52661330D519FD618860F0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-5-git-send-email-akinobu.mita@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c687f9b-f3dd-4b9f-f67d-08d6d7b87534
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4829;
x-ms-traffictypediagnostic: SN6PR04MB4829:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB48293740EE8782E24CA16A8F860F0@SN6PR04MB4829.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(136003)(396003)(199004)(189003)(66066001)(68736007)(25786009)(14454004)(52536014)(5660300002)(33656002)(4326008)(229853002)(8936002)(478600001)(72206003)(8676002)(81156014)(81166006)(2501003)(14444005)(256004)(3846002)(316002)(6436002)(446003)(7736002)(486006)(6116002)(7696005)(476003)(71190400001)(6246003)(74316002)(76176011)(9686003)(305945005)(55016002)(71200400001)(102836004)(86362001)(91956017)(110136005)(2906002)(186003)(54906003)(2201001)(99286004)(66476007)(73956011)(66556008)(53936002)(66946007)(53546011)(64756008)(76116006)(66446008)(6506007)(7416002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4829;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m6hXV95rFelgkDHFTzgohbwuVF6Qlg92NqUDRw1HDzUzCpwYC/hFD0UQ36NqP90E0b0+xirdMr5FNomrJhRHx+mNP4O/XGpg2vLwZjsL55catKhFMSv44tSYznBWFr8eH3d8rQ8ePnYkUmR8JRh2BVVP4saqM7Yr1v3pdemnwJ3KKlj6+8eXihj18P6ZMeoTAmZmuJbS0W9RkCl7ulva2pqQ3ekmYWtBkl4wCxNZnXCDrN7kRUYFutQjGxKC7smWPG64Xo4DklTL+gMhfkx9/nLH/v/kMqgnIofyDdrQi3pjE0LhQ9UTDwru4zH49uGKkjdf4mzW3piRcp7pS541bObYR1ejGV8JqzQ+l1ajcoC7lZexI0uEeznihMXZm2hGoc/aRsQrb3vrcTK6tJU0ANQoVXf1BnlKPtN7wKa8qfI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c687f9b-f3dd-4b9f-f67d-08d6d7b87534
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 15:34:15.8762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4829
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2019 08:55 AM, Akinobu Mita wrote:=0A=
> This adds the required definisions to get telemetry log page.=0A=
s/definisions/definitions/=0A=
> The telemetry log page structure and identifier are copied from nvme-cli.=
=0A=
>=0A=
> We also need a facility to check log page attributes in order to know=0A=
> the controller supports the telemetry log pages and log page offset field=
=0A=
> for the Get Log Page command.  The telemetry data area could be larger=0A=
> than maximum data transfer size, so we may need to split into multiple=0A=
> transfers with incremental page offset.=0A=
>=0A=
> Cc: Johannes Berg <johannes@sipsolutions.net>=0A=
> Cc: Keith Busch <keith.busch@intel.com>=0A=
> Cc: Jens Axboe <axboe@fb.com>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Sagi Grimberg <sagi@grimberg.me>=0A=
> Cc: Minwoo Im <minwoo.im.dev@gmail.com>=0A=
> Cc: Kenneth Heitke <kenneth.heitke@intel.com>=0A=
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>=0A=
> ---=0A=
> * v3=0A=
> - Merge 'add telemetry log page definisions' patch and 'add facility to=
=0A=
>    check log page attributes' patch=0A=
> - Copy struct nvme_telemetry_log_page_hdr from the latest nvme-cli=0A=
> - Add BUILD_BUG_ON for the size of struct nvme_telemetry_log_page_hdr=0A=
>=0A=
>   drivers/nvme/host/core.c |  2 ++=0A=
>   drivers/nvme/host/nvme.h |  1 +=0A=
>   include/linux/nvme.h     | 17 +++++++++++++++++=0A=
>   3 files changed, 20 insertions(+)=0A=
>=0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index a6644a2..0cea2a8 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -2585,6 +2585,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)=0A=
>   	} else=0A=
>   		ctrl->shutdown_timeout =3D shutdown_timeout;=0A=
>=0A=
> +	ctrl->lpa =3D id->lpa;=0A=
>   	ctrl->npss =3D id->npss;=0A=
>   	ctrl->apsta =3D id->apsta;=0A=
>   	prev_apst_enabled =3D ctrl->apst_enabled;=0A=
> @@ -3898,6 +3899,7 @@ static inline void _nvme_check_size(void)=0A=
>   	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) !=3D NVME_IDENTIFY_DATA_SIZE)=
;=0A=
>   	BUILD_BUG_ON(sizeof(struct nvme_id_ns) !=3D NVME_IDENTIFY_DATA_SIZE);=
=0A=
>   	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) !=3D 64);=0A=
> +	BUILD_BUG_ON(sizeof(struct nvme_telemetry_log_page_hdr) !=3D 512);=0A=
>   	BUILD_BUG_ON(sizeof(struct nvme_smart_log) !=3D 512);=0A=
>   	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) !=3D 64);=0A=
>   	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) !=3D 64);=0A=
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h=0A=
> index 5ee75b5..7f6f1fc 100644=0A=
> --- a/drivers/nvme/host/nvme.h=0A=
> +++ b/drivers/nvme/host/nvme.h=0A=
> @@ -195,6 +195,7 @@ struct nvme_ctrl {=0A=
>   	u32 vs;=0A=
>   	u32 sgls;=0A=
>   	u16 kas;=0A=
> +	u8 lpa;=0A=
>   	u8 npss;=0A=
>   	u8 apsta;=0A=
>   	u32 oaes;=0A=
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h=0A=
> index c40720c..8c0b29d 100644=0A=
> --- a/include/linux/nvme.h=0A=
> +++ b/include/linux/nvme.h=0A=
> @@ -294,6 +294,8 @@ enum {=0A=
>   	NVME_CTRL_OACS_DIRECTIVES		=3D 1 << 5,=0A=
>   	NVME_CTRL_OACS_DBBUF_SUPP		=3D 1 << 8,=0A=
>   	NVME_CTRL_LPA_CMD_EFFECTS_LOG		=3D 1 << 1,=0A=
> +	NVME_CTRL_LPA_EXTENDED_DATA		=3D 1 << 2,=0A=
> +	NVME_CTRL_LPA_TELEMETRY_LOG		=3D 1 << 3,=0A=
>   };=0A=
>=0A=
>   struct nvme_lbaf {=0A=
> @@ -396,6 +398,20 @@ enum {=0A=
>   	NVME_NIDT_UUID		=3D 0x03,=0A=
>   };=0A=
>=0A=
> +struct nvme_telemetry_log_page_hdr {=0A=
> +	__u8    lpi; /* Log page identifier */=0A=
> +	__u8    rsvd[4];=0A=
> +	__u8    iee_oui[3];=0A=
> +	__le16  dalb1; /* Data area 1 last block */=0A=
> +	__le16  dalb2; /* Data area 2 last block */=0A=
> +	__le16  dalb3; /* Data area 3 last block */=0A=
> +	__u8    rsvd1[368];=0A=
> +	__u8    ctrlavail; /* Controller initiated data avail?*/=0A=
> +	__u8    ctrldgn; /* Controller initiated telemetry Data Gen # */=0A=
> +	__u8    rsnident[128];=0A=
> +	__u8    telemetry_dataarea[0];=0A=
> +};=0A=
> +=0A=
=0A=
nit:- Thanks for adding the comments, can you please align all the above =
=0A=
comments like :-=0A=
=0A=
+struct nvme_telemetry_log_page_hdr {=0A=
+       __u8    lpi;            /* Log page identifier */=0A=
+       __u8    rsvd[4];=0A=
+       __u8    iee_oui[3];=0A=
+       __le16  dalb1;          /* Data area 1 last block */=0A=
+       __le16  dalb2;          /* Data area 2 last block */=0A=
+       __le16  dalb3;          /* Data area 3 last block */=0A=
+       __u8    rsvd1[368];=0A=
+       __u8    ctrlavail;      /* Controller initiated data avail?*/=0A=
+       __u8    ctrldgn;        /* Controller initiated telemetry Data =0A=
Gen # */=0A=
+       __u8    rsnident[128];=0A=
+       __u8    telemetry_dataarea[0];=0A=
+};=0A=
+=0A=
=0A=
=0A=
>   struct nvme_smart_log {=0A=
>   	__u8			critical_warning;=0A=
>   	__u8			temperature[2];=0A=
> @@ -832,6 +848,7 @@ enum {=0A=
>   	NVME_LOG_FW_SLOT	=3D 0x03,=0A=
>   	NVME_LOG_CHANGED_NS	=3D 0x04,=0A=
>   	NVME_LOG_CMD_EFFECTS	=3D 0x05,=0A=
> +	NVME_LOG_TELEMETRY_CTRL	=3D 0x08,=0A=
>   	NVME_LOG_ANA		=3D 0x0c,=0A=
>   	NVME_LOG_DISC		=3D 0x70,=0A=
>   	NVME_LOG_RESERVATION	=3D 0x80,=0A=
>=0A=
=0A=
