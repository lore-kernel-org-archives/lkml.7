Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFA1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8F52184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gUpLKq65";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="amsJndYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfCNJPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:15:12 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:10660 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfCNJPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1552554912; x=1584090912;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hMe8FKVPjVi0fBfAiHF940hFJcMPNsl2HAI6hOaoVt8=;
  b=gUpLKq651SwZTEjlJD3xwEyq1noAERuDqFWR+EC3KFN5Rfonw4Ty/Saw
   ckebozNDcpnzyUqkZhEKZHAVO1v8lzf3lbNeJjFJU1J+n1PZSXnjzPlXy
   k/GWkn5pdKeLufOUxFNz47zx43+tvOlvMGdW98j1P6Sa9cqCbzW2FM6XD
   LVjsdc+RsU2WVaA/0O1x0KimA519EnEhnsk2GPsWXzfZSI6BxDzCK6GuE
   QImAWFnLAZVdI19p30jNE7qX4lUal2FuNvuQv4bmgz3vzCcmCx76zvksj
   g++hXBts0ujj9ddHh8cTUbW4kUf4W1z4GgYgCHwvIsd3RHjE6V3AGLFDY
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,477,1544457600"; 
   d="scan'208";a="105143333"
Received: from mail-sn1nam02lp2051.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.51])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2019 17:15:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQsq+gsMDnlWFDT6BagtHvmNeN/25Yyu5Ax1zFYiMkY=;
 b=amsJndYhlKcNASOfb6ke1vqqHmy98R+h8CPe7Cfljdyp+burY4tgDk/KWxCo2D5X+MPNdb0kxV09jCNngVaYt9bK9F6c0PdlnZfTzm8KkdVh1DaVcpUOLUGglUCv6kwxzo9UMjgbQJeIbgkGOJE6Ju9h8WbRHIv4Xqoyh9GGop4=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4719.namprd04.prod.outlook.com (52.135.122.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 14 Mar 2019 09:15:10 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::f4d4:a300:2010:195a]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::f4d4:a300:2010:195a%3]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 09:15:10 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Kangjie Lu <kjlu@umn.edu>
CC:     "pakki001@umn.edu" <pakki001@umn.edu>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: fix a missing check of devm_reset_control_get
Thread-Topic: [PATCH] scsi: ufs: fix a missing check of devm_reset_control_get
Thread-Index: AQHU2jE5oITZH0L/+0mOkIU9/P2A26YK2DXQ
Date:   Thu, 14 Mar 2019 09:15:10 +0000
Message-ID: <SN6PR04MB4925DB2652FAED5F3AED27CCFC4B0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <20190314063749.13907-1-kjlu@umn.edu>
In-Reply-To: <20190314063749.13907-1-kjlu@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4994bfa5-fac6-46a1-f47e-08d6a85d8eee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4719;
x-ms-traffictypediagnostic: SN6PR04MB4719:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB47190752D253C3BAEEE5E00AFC4B0@SN6PR04MB4719.namprd04.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(366004)(376002)(189003)(199004)(2171002)(86362001)(6436002)(229853002)(2906002)(52536014)(6246003)(72206003)(76176011)(186003)(4326008)(478600001)(6506007)(102836004)(26005)(81156014)(9686003)(71200400001)(74316002)(81166006)(4744005)(71190400001)(14454004)(55016002)(99286004)(7736002)(305945005)(8676002)(7696005)(53936002)(6916009)(25786009)(8936002)(97736004)(33656002)(68736007)(105586002)(106356001)(6116002)(3846002)(11346002)(476003)(54906003)(66066001)(446003)(5660300002)(256004)(316002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4719;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E51RDOQQSnzKVjssq0o0D29IfH+O9b8mEBJvp5y6/VSU4s9GIX/wGZbLGivnDhcFk62qUPuQgF/LD3ctKSGDdmUx9CaM7fnk49w7wqiuMMwmmW/JwMYXWPEz2rL6atdh59iKeyVK48VcYVqmQyMgmSz9NQKvv5T0s4mRJKMtjJjwuxFMuyBbTquql0p/TXmkR87FyYMatfWmYpyZ1349ng5VJRktdAQL0d4VwshW/45BZ715ID2Nby2Wl9c+d1aYwJmk77tepMQ7b9qyJnoPThtwqwLnK4tbI8baFCfScqNKq/HQ1Pf1W3nK1XB/R50RO666Te705TIGm8gM/8djvY8gqQFnDpq9PmuqyRRElUdyxRYihNqoS1dpN0xfw6wAAyjv8Nr4O4shXCoPDxE+fGYMQdA7KgCJnujqjcThAjM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4994bfa5-fac6-46a1-f47e-08d6a85d8eee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 09:15:10.2143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4719
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
>=20
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Acked-by: Avri Altman <avri.altman@wdc.com>

> ---
>  drivers/scsi/ufs/ufs-hisi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
> index 452e19f8fb47..ce9d7c40909f 100644
> --- a/drivers/scsi/ufs/ufs-hisi.c
> +++ b/drivers/scsi/ufs/ufs-hisi.c
> @@ -544,6 +544,11 @@ static int ufs_hisi_init_common(struct ufs_hba *hba)
>  	ufshcd_set_variant(hba, host);
>=20
>  	host->rst  =3D devm_reset_control_get(dev, "rst");
> +	if (IS_ERR(host->rst)) {
> +		dev_err(dev, "%s: failed to get reset control\n",
> +			__func__);
Use full line please

> +		return PTR_ERR(host->rst);
> +	}
>=20
>  	ufs_hisi_set_pm_lvl(hba);
>=20
> --
> 2.17.1

