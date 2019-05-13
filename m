Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5DBC46460
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D6B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gKTX5gGF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KIoFd1IC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbfEMP2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:28:31 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:55669 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731308AbfEMP2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557761326; x=1589297326;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vm2BEm43NTq1zUs2nMsTmXHPzSoBXsj2c6hgdn5g5iE=;
  b=gKTX5gGFalGxC6vIMpy85tA6EdrKjku7YcdczPX4KOEiJOYI8xEcl59z
   QhaQTplGeoYILGsXUui/yhLwV/Fl9/t1ba74VUCg2bCfunSWrdIBbDYD2
   isPrIJ4bX0m+85E/7kcjHgSfmFJ9z4THvKhToOHew0ZgKs0LdzCe63DBB
   COZVNF92NYxYe2EmVAaDyeaWKO/4KUozhKx41i+Z2Ui6JiFUbFNEqACTh
   rs1Xhj8Z/vDh2F2gZRRjLuond1/0sJNOcB5CgMPvA/Z0obCH7h+hUxusb
   Huy6QKzzrEzd4C/WZ2Z0QknB+24xn+2bqAh6T6HeCNSZhSptGVlsE2BAP
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,465,1549900800"; 
   d="scan'208";a="207527805"
Received: from mail-sn1nam02lp2051.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.51])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2019 23:28:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJVz5uxb67CyVBfZ0vI47cxV7MIhoO1c6syZIISYhmk=;
 b=KIoFd1ICz3mCRhZmOeDvqnnUT+rfuBpmdAtBMdmqfob3fP4he6meZzkvHL2QX6U6vPPhbAIua9SBNbPFMZMKjz9Mj0qnKf9+fpkDmKCp27y/eCx0M8mfOqxsOsGVFFlm4Q5sdj59YlL+amXnTMAAs/P3r9krxh5HD8LYvQScrRI=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4944.namprd04.prod.outlook.com (52.135.114.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 15:28:28 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 15:28:28 +0000
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
Subject: Re: [PATCH v3 1/7] devcoredump: use memory_read_from_buffer
Thread-Topic: [PATCH v3 1/7] devcoredump: use memory_read_from_buffer
Thread-Index: AQHVCNsOeO2apvtWyEKVBVay0Hpz5w==
Date:   Mon, 13 May 2019 15:28:28 +0000
Message-ID: <SN6PR04MB452758CB8027D6069A748E63860F0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-2-git-send-email-akinobu.mita@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7732161-b6b6-4ce9-6ba4-08d6d7b7a5f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4944;
x-ms-traffictypediagnostic: SN6PR04MB4944:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB494489EC67A9C91FDA851E07860F0@SN6PR04MB4944.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:192;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(486006)(186003)(54906003)(110136005)(66066001)(476003)(446003)(6436002)(26005)(305945005)(7736002)(33656002)(9686003)(99286004)(55016002)(2906002)(316002)(68736007)(7416002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(53936002)(91956017)(76116006)(2501003)(229853002)(71200400001)(6246003)(81156014)(14454004)(5660300002)(72206003)(71190400001)(52536014)(81166006)(8676002)(76176011)(86362001)(4326008)(8936002)(25786009)(74316002)(7696005)(3846002)(6116002)(6506007)(256004)(53546011)(478600001)(102836004)(2201001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4944;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4Ow/rc6kWSR5gvYbwD2b1jCbDppe0d7UbjSeX05F2Gj7a5hSTgSoQoq1NwO13EHVvm7hWgGZQm8SscvGHkFb9A7zVkLO20v/svltDIAHzLskJO7medonTYRVoLVK6JebQhNyV1XJQTPgiPSjcSq5C/VnWjJUAEWzCj4O0G/MsYrrmZjQ1PCgY7yIjlTii/VTkWr6p/uXgm3kXeL5vt9y31XvfCVDLBVuhC3Emi0wYgalyjIi8g6a0qrXKsBMkjYBLFf15+nJAwsOx4kEWRK6U+HS6YiAmf4ywZhh+OQrZo7gwuQ03JU7WNDzbiFK+dWjN2rG47JYlxlcISoCP65eprWA1TBd+CT2CYR41OEZCPUytiPdz0lpn1Q08PEdyjsReQYNZXresPWccJ5oUuHvimGv1y2KAh0NBr4yzQhZSAA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7732161-b6b6-4ce9-6ba4-08d6d7b7a5f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 15:28:28.1166
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
On 05/12/2019 08:55 AM, Akinobu Mita wrote:=0A=
> Use memory_read_from_buffer() to simplify devcd_readv().=0A=
>=0A=
> Cc: Johannes Berg <johannes@sipsolutions.net>=0A=
> Cc: Keith Busch <keith.busch@intel.com>=0A=
> Cc: Jens Axboe <axboe@fb.com>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Sagi Grimberg <sagi@grimberg.me>=0A=
> Cc: Minwoo Im <minwoo.im.dev@gmail.com>=0A=
> Cc: Kenneth Heitke <kenneth.heitke@intel.com>=0A=
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>=0A=
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>=0A=
> ---=0A=
> * v3=0A=
> - No change since v2=0A=
>=0A=
>   drivers/base/devcoredump.c | 11 +----------=0A=
>   1 file changed, 1 insertion(+), 10 deletions(-)=0A=
>=0A=
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c=0A=
> index f1a3353..3c960a6 100644=0A=
> --- a/drivers/base/devcoredump.c=0A=
> +++ b/drivers/base/devcoredump.c=0A=
> @@ -164,16 +164,7 @@ static struct class devcd_class =3D {=0A=
>   static ssize_t devcd_readv(char *buffer, loff_t offset, size_t count,=
=0A=
>   			   void *data, size_t datalen)=0A=
>   {=0A=
> -	if (offset > datalen)=0A=
> -		return -EINVAL;=0A=
> -=0A=
> -	if (offset + count > datalen)=0A=
> -		count =3D datalen - offset;=0A=
> -=0A=
> -	if (count)=0A=
> -		memcpy(buffer, ((u8 *)data) + offset, count);=0A=
> -=0A=
> -	return count;=0A=
> +	return memory_read_from_buffer(buffer, count, &offset, data, datalen);=
=0A=
>   }=0A=
>=0A=
>   static void devcd_freev(void *data)=0A=
>=0A=
=0A=
