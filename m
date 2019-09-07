Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC62BC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBE520854
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N3EKR9A7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cTKtuvUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394130AbfIGSmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 14:42:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46505 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfIGSmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 14:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1567881771; x=1599417771;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Ca/3WHO2tArSA0pRrXqVUvm7Wp4fcSJyIr0NAzN8E3Y=;
  b=N3EKR9A740VhzudbGzj7pNLydNBmMsdLGFK3GwVq6Cu/MWvmwtL8Mtsl
   rf9OuymUlu5R2ZyWYNcTqzGWPx3Yefi9yfgq+K5c4z4yth5jeW72pWTVs
   45t2gA0KeSR6CCLDMwPmrDVWiDZX/I3TlCJPoc26ZCWaNzZs/3pDGZIuj
   huPE1huf6Iq9P+0S8I7od2iMQIflS9t2FaruA4uBotUYr6GA0D+c5X3Sa
   +INW+rwyVHDMW3FVRKEChaf3heEkhDi07Y/fdtmbI4B4NfLYVOrE8Yqw+
   sRcDM5TtHisrYmnVJH1w9Ew/1jbpD3wocp+0rssZe456aRw7F5VFqYwy/
   g==;
IronPort-SDR: pS0wKdQTYnjXVSJSz5tRuOZYmLi87KjTpGN2jnf0kh83PkAazfKV8ppha/c7CFDrkK3aWy//eN
 YscEPnxV1j94pkF+ilNwqEKFwi8T+I7n4BJ9PdDkWuvMPWPKgnSVCxG6bfDCJr7krkpP2troCU
 l31BI98oTSHUTILA5YuX4xv8dAMTscYtkLwVw0BZS4/SfgUroZvPlrJGmpsmI79BbF/9u3g2Ic
 KSwLKXbLt1sx2c2NOBYHNxbo1CbVL0VKVx2bWAl8nfar5nQdx7/u/q3Ytef7yTWOCE+pezFPs3
 +o8=
X-IronPort-AV: E=Sophos;i="5.64,478,1559491200"; 
   d="scan'208";a="117739897"
Received: from mail-by2nam01lp2051.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.51])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2019 02:42:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5yuRsIpC5RKuDnHfXUk75n25+W3X3Ra7Csu96L9jgKeHTKaVlEq7+LSyjrM77vqAccE1vCSsul4dONJjuQwC0CkAKYAzExrzGp5oI1QSolVgQCVim1bvzRrGfS1a9+I6fpd5zKA0AnBPI/9nxexGLBsX0MLC/uwQXIXaU3/nrZM8Dd2Fbu6WH8DQCbFH0gRftVh0SsWQJkRhSEltMyLGyOAR7+91+grjbNh+QveTH9YDkBBsdaFFe4tJKrLVblNUIY4UUjndUHVN+p6XURN7vAXjljZO8J4cEoyFIjKr0ig7rSq6QZaEdRvwQPLCznIVu0shFNec5ZLeK1qVnVaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RftVf8WrnRNBQnWCSBJaZP6MC1X0ohQ2OzKPZJ2HZFs=;
 b=hObcFp6n+46rNwXmQkeGeyqglfthATOsInWWMLvtWnxTiV4Fbvs0iRYY9iA2TzZuTGeNGc6ABmEhkq/0LY03YmL3RKoy6O/dE2z/ky2Zfgf4qb5uWmBWfSHT3I1wMygbPQAj9irHsbu8XIs435GJKvh71DNOUcnz9exdbPabieOpZQCYcnbBXffwJUlxVLp9fcq2wYGkefaOXgpjuS7onU37OJEQw5p66BXZXq1zbRYKrNyE1sZLPo/e7Oiyb5eNrS4qyAqdkZ3Nnps/nbltHESQyduyZ97UfkKLdyu958xfb1Bd5ASxcWjImJTUdUvSW3DMknC2EaNELBzfbmv6qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RftVf8WrnRNBQnWCSBJaZP6MC1X0ohQ2OzKPZJ2HZFs=;
 b=cTKtuvUTGZcF1pIiFo6OCXzeC0v0DGw//eUEkzPJjhukbYbnMJo7Aacw9TDyddnBGKJHLlTJq9AEwMjrTtdUKqP+J3tCTwn2FtzGLL0dsBpQXo4cbLNEAovx3q0ddUnXw9cfhWbqtVEo78skWZLeOjwX82gOtM5jBcCVo05Ml4w=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5400.namprd04.prod.outlook.com (20.178.50.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Sat, 7 Sep 2019 18:42:49 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2241.018; Sat, 7 Sep 2019
 18:42:49 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] nvme: Restore device naming sanity
Thread-Topic: [PATCH] nvme: Restore device naming sanity
Thread-Index: AQHVY0b0r2H6Juc7x0CaNQILnZjrrw==
Date:   Sat, 7 Sep 2019 18:42:49 +0000
Message-ID: <BYAPR04MB5749E4FBF82F23C41A494A6286B50@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190904173159.22921-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fe34546-8bb1-4c24-b256-08d733c32eca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5400;
x-ms-traffictypediagnostic: BYAPR04MB5400:
x-microsoft-antispam-prvs: <BYAPR04MB5400E402CEF62A5FB65CEC3686B50@BYAPR04MB5400.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 0153A8321A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(189003)(199004)(305945005)(54906003)(6116002)(3846002)(25786009)(2906002)(71200400001)(71190400001)(446003)(476003)(486006)(33656002)(86362001)(6436002)(2501003)(66066001)(316002)(74316002)(52536014)(229853002)(5660300002)(478600001)(14454004)(14444005)(256004)(9686003)(55016002)(53936002)(76176011)(186003)(64756008)(81156014)(81166006)(66946007)(6506007)(7696005)(8676002)(66476007)(8936002)(26005)(76116006)(53546011)(66556008)(66446008)(4326008)(110136005)(7736002)(102836004)(99286004)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5400;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U4/mZr07d8lHnjn+1LSyyONGYjRx/K7KS3OsW2tOg1yscrGjCasGnlvbVl2odrSaJ7xEil+TVNOc4iCv/oCdhqYH+U0kY4LhkIzpKGV8J1K8jsFzrFLAE/JvkqmSQWRcak7rKKGS/9nv6oqJKykqXLSVN1Dw41Q3ndu7VQyuHK2UHHtLC9hueB/bnJnzJgTF8WeGUiEjLqWmq6Fd0Gmkpxw6S6R+skze42jQWYQnZyBTeCJNHwhUYq6GaD+nAZtGkoTRUymaFgW9t0H1Y7XB34W9PJOTRSrKvdeOSgTMHmICyMTOhdZFuDpko0KbkzYP/hiy6MMySDp5bkZDtojco5DTTT+IYjEPDSlnpQ4x7NRZMaCdtC4XlQhIGKrHKogN6v6O/2s9hAAOhMSq9IERQsofKEi6MKiYnbFhT6m7wKQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe34546-8bb1-4c24-b256-08d733c32eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2019 18:42:49.1750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CBZ9xwPG28MPPkc3EudRG5Jt444ZwPfTYevXGBvKEXGBaRsyG7a22aALKNczLh3ECpeAd87KOACUM/KH67VoGOYVhbD1iVjAMcxLY21Q3G4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5400
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apart from the some nits, this looks okay.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
May be subject line should be 's/nvme/nvme-core/' ?=0A=
=0A=
On 09/04/2019 10:34 AM, Keith Busch wrote:=0A=
> The namespace names must be unique for the lifetime of the subsystem.=0A=
> This was accomplished by using their parent subsystems' instances which=
=0A=
> was independent of the controllers connected to that subsystem.=0A=
>=0A=
> The consequence of that naming scheme meant that name prefixes given to=
=0A=
> namespaces may match a controller from an unrelated subsystem. This has=
=0A=
> understandbly invited confusion when examining device nodes.=0A=
's/understandbly/understandably/'=0A=
>=0A=
> Ensure the namespace's subsystem instance never clashes with a=0A=
> controller instance of another subsystem by transferring the instance=0A=
> ownership to parent subsystem from the first controller discovered in=0A=
> that subsystem.=0A=
>=0A=
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>=0A=
> Signed-off-by: Keith Busch <kbusch@kernel.org>=0A=
> ---=0A=
>   drivers/nvme/host/core.c | 21 ++++++++++-----------=0A=
>   1 file changed, 10 insertions(+), 11 deletions(-)=0A=
>=0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index 14c0bfb55615..8a8279ece5ee 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -81,7 +81,6 @@ EXPORT_SYMBOL_GPL(nvme_reset_wq);=0A=
>   struct workqueue_struct *nvme_delete_wq;=0A=
>   EXPORT_SYMBOL_GPL(nvme_delete_wq);=0A=
>=0A=
> -static DEFINE_IDA(nvme_subsystems_ida);=0A=
>   static LIST_HEAD(nvme_subsystems);=0A=
>   static DEFINE_MUTEX(nvme_subsystems_lock);=0A=
>=0A=
> @@ -2344,7 +2343,8 @@ static void nvme_release_subsystem(struct device *d=
ev)=0A=
>   	struct nvme_subsystem *subsys =3D=0A=
>   		container_of(dev, struct nvme_subsystem, dev);=0A=
>=0A=
> -	ida_simple_remove(&nvme_subsystems_ida, subsys->instance);=0A=
> +	if (subsys->instance >=3D 0)=0A=
> +		ida_simple_remove(&nvme_instance_ida, subsys->instance);=0A=
>   	kfree(subsys);=0A=
>   }=0A=
>=0A=
> @@ -2473,12 +2473,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *c=
trl, struct nvme_id_ctrl *id)=0A=
>   	subsys =3D kzalloc(sizeof(*subsys), GFP_KERNEL);=0A=
>   	if (!subsys)=0A=
>   		return -ENOMEM;=0A=
> -	ret =3D ida_simple_get(&nvme_subsystems_ida, 0, 0, GFP_KERNEL);=0A=
> -	if (ret < 0) {=0A=
> -		kfree(subsys);=0A=
> -		return ret;=0A=
> -	}=0A=
> -	subsys->instance =3D ret;=0A=
> +=0A=
> +	subsys->instance =3D -1;=0A=
>   	mutex_init(&subsys->lock);=0A=
>   	kref_init(&subsys->ref);=0A=
>   	INIT_LIST_HEAD(&subsys->ctrls);=0A=
> @@ -2497,7 +2493,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ct=
rl, struct nvme_id_ctrl *id)=0A=
>   	subsys->dev.class =3D nvme_subsys_class;=0A=
>   	subsys->dev.release =3D nvme_release_subsystem;=0A=
>   	subsys->dev.groups =3D nvme_subsys_attrs_groups;=0A=
> -	dev_set_name(&subsys->dev, "nvme-subsys%d", subsys->instance);=0A=
> +	dev_set_name(&subsys->dev, "nvme-subsys%d", ctrl->instance);=0A=
>   	device_initialize(&subsys->dev);=0A=
>=0A=
>   	mutex_lock(&nvme_subsystems_lock);=0A=
> @@ -2528,6 +2524,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ct=
rl, struct nvme_id_ctrl *id)=0A=
>   		goto out_put_subsystem;=0A=
>   	}=0A=
>=0A=
> +	if (!found)=0A=
> +		subsys->instance =3D ctrl->instance;=0A=
>   	ctrl->subsys =3D subsys;=0A=
>   	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);=0A=
>   	mutex_unlock(&nvme_subsystems_lock);=0A=
> @@ -3803,7 +3801,9 @@ static void nvme_free_ctrl(struct device *dev)=0A=
>   		container_of(dev, struct nvme_ctrl, ctrl_device);=0A=
>   	struct nvme_subsystem *subsys =3D ctrl->subsys;=0A=
>=0A=
> -	ida_simple_remove(&nvme_instance_ida, ctrl->instance);=0A=
> +	if (subsys && ctrl->instance !=3D subsys->instance)=0A=
> +		ida_simple_remove(&nvme_instance_ida, ctrl->instance);=0A=
> +=0A=
>   	kfree(ctrl->effects);=0A=
>   	nvme_mpath_uninit(ctrl);=0A=
>   	__free_page(ctrl->discard_page);=0A=
> @@ -4085,7 +4085,6 @@ static int __init nvme_core_init(void)=0A=
>=0A=
>   static void __exit nvme_core_exit(void)=0A=
>   {=0A=
> -	ida_destroy(&nvme_subsystems_ida);=0A=
>   	class_destroy(nvme_subsys_class);=0A=
>   	class_destroy(nvme_class);=0A=
>   	unregister_chrdev_region(nvme_chr_devt, NVME_MINORS);=0A=
>=0A=
=0A=
