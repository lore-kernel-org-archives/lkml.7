Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA31C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAEE20663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UNJNGd1q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PuqZY328"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfFXFu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 01:50:57 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:31158 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFXFu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561355456; x=1592891456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ae3YgcVwCDrnTxYqAN6YBVv3IyIZuFFaOBX4kDD5Xr0=;
  b=UNJNGd1q2at29fwUmX9sxspVP2VVM4H6dXR9CQjPqsdGky1tjOxsMSOR
   2+7yb+OERphM1ysMjGsiNruIoLWEgSMjOMIUOVN2HZ1KE/7YE2zV9H/AT
   6AEcDhFKBxaYfcNusxAS0lB2/XV7O2c0xyj8X6cwU+lKvrhQqOsAchm5b
   rJNbUjFjWFSZI9BtgJ0NnJPSHAGAh8x9AuvD4JsG3NO6NHahZig2DJh+e
   9LKgq3a5+Rs+b8HYUDGeamq2TL+7x/x7mhPDE+azA25eKVt5LSSJuC5F9
   ANVLwuZIkLT0k8SHK5Kbn7z95iUJ/V6x+1wsJ+2Yq3X5Ql2tfjnJiW1Vv
   w==;
X-IronPort-AV: E=Sophos;i="5.63,411,1557158400"; 
   d="scan'208";a="217722677"
Received: from mail-by2nam01lp2054.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.54])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2019 13:50:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtI+8h6xfOReEQr+7bNpmyjv0rvw6KWJYQlb579mKIU=;
 b=PuqZY3281AfhXwqeLOATP0g7VHjlrCy0P8FuhfNeIN6gq9lCpIL8Vkk4ou451rSh3I03xo1KdSv8+g7UxgQGAffsSASR4L80K1NTOUsqWj+pv1lLqjLNga83OBb2Ope7m3hCrvN/e6NsmnfgA3ZRoc0VUuxfbAf6TGLoTPCHhd8=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4864.namprd04.prod.outlook.com (52.135.114.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 05:50:54 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c5b2:c213:37f6:819a]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c5b2:c213:37f6:819a%7]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 05:50:54 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Evan Green <evgreen@chromium.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] scsi: ufs: typo fixes and improvement
Thread-Topic: [PATCH v2 0/3] scsi: ufs: typo fixes and improvement
Thread-Index: AdUp6BAI7ZILf7ZTT5ms/BIKCU7S/AAaJsqw
Date:   Mon, 24 Jun 2019 05:50:54 +0000
Message-ID: <SN6PR04MB4925C03088D2D715A9ADAB84FCE00@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <BN7PR08MB5684A44F56972BCE0972B28EDBE10@BN7PR08MB5684.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB5684A44F56972BCE0972B28EDBE10@BN7PR08MB5684.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c7802dd-921f-437f-8ef1-08d6f867ec35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4864;
x-ms-traffictypediagnostic: SN6PR04MB4864:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB48644E291C207970EF600AB1FCE00@SN6PR04MB4864.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(346002)(39860400002)(366004)(199004)(189003)(102836004)(229853002)(6116002)(256004)(14444005)(446003)(11346002)(305945005)(74316002)(476003)(9686003)(81166006)(68736007)(81156014)(486006)(6506007)(54906003)(66066001)(55016002)(76176011)(7696005)(7736002)(3846002)(6436002)(53936002)(110136005)(316002)(8936002)(2906002)(99286004)(6246003)(4326008)(26005)(186003)(33656002)(8676002)(72206003)(73956011)(66556008)(66446008)(52536014)(76116006)(66946007)(66476007)(64756008)(14454004)(86362001)(5660300002)(25786009)(4744005)(71190400001)(71200400001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4864;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oqafVsPJxw2fxKZ4L7HnPNVOlCN1uP0UfEei76wZNIMCbYkABGwkC3WgOs/KM+Ld8KFX+o0Qcm1Wo41lU0uGAP+35pKXtMDZNHyRBL4n9BOqREwClJNRe7tAk8lO9HttA5Zv0/kCixv8t37LkvGdnv+FqwwL5CdnNfHS8fO/BGVQicNXsvIXEx5gXXpXY6UgRpl452wElAYAZLRJzzodYcQ4VVMVfTMspR8Agb1dwDaKLFxjtNrRCmgp1t2E89pRJr2ETskEnn7hAy3sPE6vzbBFmqG/HK7f4r08vnG8peTfbuihdWBfC4ujiqgwn+X2cZhF2GyPIgv/8CsJ3hh2ylX8liBFf51nLXuDghImXHAZ1XxIJVRL6Q9ezl/TzviCb+wWU6fgKFjifFHp+d+z07A446IVQoEM6Jg8S6dt6ZI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7802dd-921f-437f-8ef1-08d6f867ec35
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 05:50:54.5927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Avri.Altman@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4864
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>=20
>=20
> From: Bean Huo <beanhuo@micron.com>
>=20
> This series patch is to fix several typos and fix one issue of twice
> completing ufs-bsg job in case of UPIU/DME command failed.
>=20
> Changed since v1:
>     - split v1 patch
>     - add fixes tag
>     - delete needless blank line
>=20
> Bean Huo (3):
>   scsi: ufs: fix typos in comment of ufshcd_uic_change_pwr_mode
>   scsi: ufs-bsg: fix typo in ufs_bsg_request
>   scsi: ufs-bsg: complete ufs-bsg job only if no error

This series looks good to me.
Thanks,
Avri
