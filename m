Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B159C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB8B2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iXb+iS81";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SSRxjVpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbfEMPZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:25:02 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:55435 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfEMPZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557761102; x=1589297102;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=51577D36CSzR1L3PoAPGLYaDDhfcSmG+6z9UQdG84wQ=;
  b=iXb+iS813dSkApAu+hEX7sbo61+dBeYysd2HIdfnky7Xnjjr5prKUHtN
   1y8vWrdL3haEkt0rfXJP+qtCyuUnPaNIpSS3vj7YTsktMeVWgNu8ufhq2
   Rj+3xnpz3N8UCWRzdnoqnobJDDnQLp8ssndzxj2b7CvfBypWMHqipTd0y
   /xfxxHNqXiSu6BqU+QY5NFswZFCxa/iAS5vYB49gBfj812Ho5N+l8lG+k
   cynR6JpsZWLhoKP+9j8LKmk80XA1Jaz7dgJelxh49UKVPXqePjoC88Rnb
   CzqShovCFs6L69ydm50B8VAdBgXDdbjZ/pi/QuTTY3MGD9WZFjaEVCYd9
   A==;
X-IronPort-AV: E=Sophos;i="5.60,465,1549900800"; 
   d="scan'208";a="207527536"
Received: from mail-by2nam03lp2058.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.58])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2019 23:25:01 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imCWbY8H6AEVGd9XM4aC2/P9yOK4hujtOiFMXSuCZAU=;
 b=SSRxjVpwabhdpVBAIkD435D+OksCEyIe6ejwici3RSQ7DwHeB2Om5oPtlofMZQ+mG+tUNu+DeFkXYC16jB4ROyVLA4n0j5i2XLebWJiQclufOhyyIY9ERPzf7NlNK5xuArxIIoLcKHnSo599rEKxe9CvCv/QY28GJHGCRbd1gP8=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4944.namprd04.prod.outlook.com (52.135.114.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 15:24:59 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 15:24:59 +0000
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
Subject: Re: [PATCH v3 2/7] devcoredump: fix typo in comment
Thread-Topic: [PATCH v3 2/7] devcoredump: fix typo in comment
Thread-Index: AQHVCNsROeeWe5OvjkSMfroZKWp4fg==
Date:   Mon, 13 May 2019 15:24:59 +0000
Message-ID: <SN6PR04MB452707FD4C32EE927D80294F860F0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-3-git-send-email-akinobu.mita@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 065ad1f2-6f65-4933-32d8-08d6d7b729af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4944;
x-ms-traffictypediagnostic: SN6PR04MB4944:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB494419653003622B07BCEB63860F0@SN6PR04MB4944.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(486006)(186003)(54906003)(110136005)(66066001)(476003)(446003)(6436002)(26005)(305945005)(7736002)(33656002)(9686003)(99286004)(55016002)(2906002)(316002)(68736007)(7416002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(53936002)(91956017)(76116006)(2501003)(229853002)(71200400001)(6246003)(81156014)(14454004)(5660300002)(72206003)(4744005)(71190400001)(52536014)(81166006)(8676002)(76176011)(86362001)(4326008)(8936002)(25786009)(74316002)(7696005)(14444005)(3846002)(6116002)(6506007)(256004)(53546011)(478600001)(102836004)(2201001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4944;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ujfX9Nunt7hmGPfc51CAAC218Qmk7lKKnMoc+j7e+iWY7lqwc4lHjatUmQBGfvTPSmOVGyBJjoVNEYQuhln+fTf/sIgby0K3Zyx7ZIR7zoorRBxRGv7ItAoBccyFeZ8n704StUlzHYqB5Bvt2vux6G8ZQxbL1KWVf9NVfYE3f+alDUychv7gMduiArTDRUr+rRut/DWsDnFHeiHMW1NjisW4OtRccig377F+tnNPgRbgfslD/8nrM2vT6iYS3MidTLMfow0FPNqQzsXOKl2rGJF3ArYBGnrHxUl/VpOTM0+B39Vohgaakc8akhG1iws194YQJUXeER5sYv0f8MyT+Vihsfo1G9iiXuTk+OZ2J0v5sUUwtFyJMWV/KkmhhH8iiM36xFovuUXQNu966hmQUUY1CqoZomK0KdCWpQu2T+s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 065ad1f2-6f65-4933-32d8-08d6d7b729af
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 15:24:59.6797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4944
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>.=0A=
=0A=
=0A=
On 05/12/2019 08:55 AM, Akinobu Mita wrote:=0A=
> s/dev_coredumpmsg/dev_coredumpsg/=0A=
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
> - No change since v2=0A=
>=0A=
>   drivers/base/devcoredump.c | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c=0A=
> index 3c960a6..e42d0b5 100644=0A=
> --- a/drivers/base/devcoredump.c=0A=
> +++ b/drivers/base/devcoredump.c=0A=
> @@ -314,7 +314,7 @@ void dev_coredumpm(struct device *dev, struct module =
*owner,=0A=
>   EXPORT_SYMBOL_GPL(dev_coredumpm);=0A=
>=0A=
>   /**=0A=
> - * dev_coredumpmsg - create device coredump that uses scatterlist as dat=
a=0A=
> + * dev_coredumpsg - create device coredump that uses scatterlist as data=
=0A=
>    * parameter=0A=
>    * @dev: the struct device for the crashed device=0A=
>    * @table: the dump data=0A=
>=0A=
=0A=
