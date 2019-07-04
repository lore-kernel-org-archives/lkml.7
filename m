Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C52CC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4E62133F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nCN7FX9Y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NUZhtBm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfGDHrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:47:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24916 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGDHrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562226459; x=1593762459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GHJ0KDUKPpKmudHJ1R6fXfGfOnD9MDCx3n80VozxZkc=;
  b=nCN7FX9Y30DCTA7lcG2zcCUf2baTQKGZlqG0W2VP4jsDGS0JQRTA2yCb
   OMSK0TgJOW9gzNddafyJv4zbhcOnWM8z386YX1Fm3YI9mlF38XRps6dnu
   nI2ac/oaGMXYHT3gyyjP7QZnt0j/P2xJpjPfifSs99xn52yBn4M6AiNQG
   cjyE8irBAfQqBEfAyxzkCB3ygFNAk+2g3uwkSwDL2Ff1Ubc7rtMz3Y6Ok
   JXIPCRAOSQtr5SGjfqpEF/R1qCcl28W8v7hiwEcK572ElJoSw4UuPFV+Z
   4ReGYXNNp+QKznV/Ur9j8sTaHnQ2OR5pZZmrs/FboJuLlgdXokB3r/ikw
   w==;
IronPort-SDR: PILL87nLDIqKdsCBX3eoxwoLK+WGqVAgL1NxyMT0GpQi2M6iUS6PmFksZzJbDJqzrLji0J/cfU
 pZf71bs+ypstSzqYSk+vk1/OLQ3PlRmcaQSgSXAGOatj3VlnozBHOryaFBh2uR9waWi5OrjgFG
 Q+A1vOyAKF99JxPr7QRcDY+dYm3K7Zh/hy7Dl7L8795xh40ESSY9KdJXaE7sQInRNyX+t005ss
 hMIg7szG+n5yFymdZme+OIscQhkbzjmEobACdjwkPVyzFLfYMXWZdou4tLH2/MtHdwf+hl+hBv
 JCA=
X-IronPort-AV: E=Sophos;i="5.63,449,1557158400"; 
   d="scan'208";a="113406057"
Received: from mail-bl2nam02lp2058.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.58])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2019 15:47:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJU4zL1vwbjl6BVjVf23ywhF12yR0dYXibUkejsCdDo=;
 b=NUZhtBm+3xpVnZ2Ap5Zfg4fU2QORe64o3f5Dmi4O3UvZjGD8edftop27C98ZIcmmIl079Ie2tFE7bzq+n2rNL99WFwZ4EVy9MS101nU2JH4BRvAMeDU2/yF+hEu1ZUxhs9PAKeLSClXJEjMtE1rXGjSFYuetm4hb08z+n/bJH2M=
Received: from DM6PR04MB4923.namprd04.prod.outlook.com (20.176.109.84) by
 DM6PR04MB6009.namprd04.prod.outlook.com (20.178.225.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 4 Jul 2019 07:47:37 +0000
Received: from DM6PR04MB4923.namprd04.prod.outlook.com
 ([fe80::4443:24aa:16cb:ec73]) by DM6PR04MB4923.namprd04.prod.outlook.com
 ([fe80::4443:24aa:16cb:ec73%7]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 07:47:36 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Pedro Sousa <PedroM.Sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>
CC:     Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>
Subject: RE: [PATCH] scsi: uapi: ufs: Fix SPDX license identifier
Thread-Topic: [PATCH] scsi: uapi: ufs: Fix SPDX license identifier
Thread-Index: AQHVISOkIGq/TXYo40K7pkiAfhMabKaxBgUAgAkw5cA=
Date:   Thu, 4 Jul 2019 07:47:36 +0000
Message-ID: <DM6PR04MB49232962D82A0A4F5424014FFCFA0@DM6PR04MB4923.namprd04.prod.outlook.com>
References: <1560346477-13944-1-git-send-email-avri.altman@wdc.com>
 <MN2PR12MB3167D6E742D06055FDCFB17ACCFC0@MN2PR12MB3167.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3167D6E742D06055FDCFB17ACCFC0@MN2PR12MB3167.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1b1164f-7e54-49c2-6c17-08d70053e1f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR04MB6009;
x-ms-traffictypediagnostic: DM6PR04MB6009:
x-microsoft-antispam-prvs: <DM6PR04MB6009671C77D2AF4B695406C5FCFA0@DM6PR04MB6009.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(66066001)(6436002)(55016002)(4744005)(6246003)(5660300002)(52536014)(25786009)(86362001)(229853002)(54906003)(68736007)(76116006)(110136005)(2201001)(9686003)(66946007)(73956011)(64756008)(66476007)(66556008)(66446008)(2501003)(316002)(7696005)(14444005)(478600001)(305945005)(33656002)(53936002)(14454004)(71190400001)(6506007)(102836004)(71200400001)(486006)(76176011)(4326008)(256004)(72206003)(99286004)(2906002)(26005)(476003)(74316002)(8936002)(446003)(8676002)(81156014)(81166006)(11346002)(186003)(7736002)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB6009;H:DM6PR04MB4923.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: znESxxZaZVYaa9Vp6qy8i1sIQHQT7EOcyp7i1HNIMcYI/lwRQKEGK0FlUgGEeDLvyzOfEgHa8XDhXhMqqxd5wnMETYZxnKX3zjim2n6COOAUtPE0/dxdCrS/k4W9KRLAwUZ4LakqYitp5stZUjI1QK0lxGRBljiBcYAlEWfgn4tckST0WCOan8/b7BocgCt6DJp53tWqd2uwLM+ejwxhOIqLlrqG0MzRNIX8JOZPVvXIAlvoaY0SbDgLW+pWk7XLgdvv5Yli2NjQ9x+CevGjwAd3UbWeS1koqJ/5hkxaNNoY4Ru5WSsjryecISaW+WV5RGRag8UwSSBd4eDDb2oxfu+YZw3f8v8F4h9bG+xxhDy11iODdBYBNVNwE8QxmrqFU0bQbzZ2v1CcStwqY5zy41kETLOYnKG4snlr1CalbB0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b1164f-7e54-49c2-6c17-08d70053e1f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 07:47:36.8058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Avri.Altman@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin - a kind reminder.

Thanks,
Avri

> Subject: RE: [PATCH] scsi: uapi: ufs: Fix SPDX license identifier
>=20
> From: Avri Altman <avri.altman@wdc.com>
> Date: Wed, Jun 12, 2019 at 14:34:37
>=20
> > added 'WITH Linux-syscall-note' exception, which is the officially
> > assigned exception identifier for the kernel syscall exception.
> > This exception makes it possible to include GPL headers into non GPL
> > code, without confusing license compliance tools.
> >
> > fixes: a851b2bd3632 (scsi: uapi: ufs: Make utp_upiu_req visible to user
> > 		     space)
> >
> > Signed-off-by: Avri Altman <avri.altman@wdc.com>
> Reviewed-by: Pedro Sousa <pedrom.sousa@synopsys.com>

