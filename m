Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C06C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E982089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Bpybt7to";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="b3hTfkyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfGaKJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:09:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9261 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfGaKJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564567798; x=1596103798;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WAwuweJrEgd2UDtVBxTNqldHlRm6VqKiLQFazhsKvR8=;
  b=Bpybt7toL+v7o58d+YKYr237FuhXjtPzbh4OrgYl1RyELayueu95i+Sy
   zITHkGtkBCFw8/HWg1d3nmG0uV1/heugp1CHTxVS7xfUzShEVvtUmgpCS
   xsoI932LJgFjLjTUEbO9CTrbuuuF/PnrbXTNn3cQNoWEnma5rqfw5XM6Q
   JJmYyL4AQAoUWOQiPj0oooM0537y7Dei3+3lqXkBZV+UKZJr6/51fLvtS
   FV3zjM9LZLa4jkovdnZDBp8dY1Ocj115Z6iRJ4g6U5TYtraTTz92Pmhp4
   NklXHidjafexkDG0uL+GweobxizbMxIOCLoIR2BrxW/VaPfpnJ7sR7pFh
   Q==;
IronPort-SDR: 1JybFdu3HQw8yM+WuDRWqHYOeEKjD1B58hycptIE03A+PKoB0mIjHVe7674NmLVYLOloRy2vNu
 n1BMfIxO5QkXIQgqu2wjA3mB3hfSVj+v3kKi88kJX14EgB0R6wyYshHFr08dh9p78Z4QIccwyJ
 lGjfud7S5HBGtAOuy21zbDK0nSvb4ku2c0fdv9OA4VnPF5B9y7b5ofeYlAg04L+MNc26OEnEFu
 8wN/mhXs18IqcbR2ZyIhBtWszca87iKHoz4YK4jAdGd3hfcM37R6o2qrEnYB7wTxRICXLwGIdX
 wCQ=
X-IronPort-AV: E=Sophos;i="5.64,329,1559491200"; 
   d="scan'208";a="115587183"
Received: from mail-sn1nam02lp2059.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.59])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2019 18:09:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQy3H+17/fj+XZPM+1De9AFwm5mPsK9ru9WJt/ikUy4BdHhvK43KORredUb7zyAGEVR2eyGS5Hi0hePWDzBkQRXOpjLpvfEB0BZEp06zw5O3R+XL4XKvouV58QqcCwJOxj8ZgqcxxOn6v6Dj9MGwo7wRfAwOqexEWBlW8wslNCq7QyyaBxWCiMEQM7WrCymahP7xbPKEIwP9iOzAN/AKsaRd9Ytn48lET+mCScoUn/KaZsaDhbcx9T0A3qhK1M6Goz3QVBTPNGyqH/3IuXcnt4oqbp7xp8pevIDSS1SGBVF4XCqnjYP+ZV+wpWNfc+nAhOAEbIHihvzwumb4fkgLjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAwuweJrEgd2UDtVBxTNqldHlRm6VqKiLQFazhsKvR8=;
 b=n2/i6EbTNCarM+O2SN0w6IUpcgZViUyofRkxB7x/UfD2pl4ki0YonLoLXJ6f9APVHfN7bkvxo18967ogimIzmWMC2qeOXT+otcoLVz8k1wEtVpCBT3HS44xKpFu087HvmyUBxLz+Mq+VrmMFgFP22RTB8+Al+jmbUGWuWAxhpuL5CyFhCKpkCMVI0tN9Bv6W7f43TUMb+razw+3O2ZswTAOEQ6MazdYJdYYKEoRo3JT2Zn62j6MXi80+PlIFraUvFdqAuJh13Gsrs1+vUYZ0qE+6N0amtgrJacM6SGnszun6JQCcCo4+hbG2ML1hbi1nJueCtiRs1ud5Nhtli43fkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAwuweJrEgd2UDtVBxTNqldHlRm6VqKiLQFazhsKvR8=;
 b=b3hTfkyjYJKMeKRiTYso1cX1/Q3QGjHp32x/O29mVTqJ/vtpmHi1FTQ6PU5cZFeglgxgCbOeWsO3AIxIS6AxHOKjXF978+ZwPtP4ATXABSPmcGCJyW3B11PTPgGBWCZS/Eqk2hL8MHgMm25LzHbB+qtobyydQvJpMluRWs6wypg=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (10.186.144.209) by
 MN2PR04MB6445.namprd04.prod.outlook.com (52.132.169.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Wed, 31 Jul 2019 10:09:55 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::5d3b:c35e:a95a:51e2]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::5d3b:c35e:a95a:51e2%3]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 10:09:55 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Anil Varughese <aniljoy@cadence.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "pedrom.sousa@synopsys.com" <pedrom.sousa@synopsys.com>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "hare@suse.de" <hare@suse.de>,
        "rafalc@cadence.com" <rafalc@cadence.com>,
        "mparab@cadence.com" <mparab@cadence.com>,
        "jank@cadence.com" <jank@cadence.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: Additional clock initialization in Cadence UFS
Thread-Topic: [PATCH] scsi: ufs: Additional clock initialization in Cadence
 UFS
Thread-Index: AQHVR3tcf/mCdBEWqU6Uux3DMp7HZKbkgPKQ
Date:   Wed, 31 Jul 2019 10:09:54 +0000
Message-ID: <MN2PR04MB699133D84C627AE30C6A50CDFCDF0@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20190731083614.25926-1-aniljoy@cadence.com>
In-Reply-To: <20190731083614.25926-1-aniljoy@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e71d768c-825e-4757-1fe6-08d7159f3c34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB6445;
x-ms-traffictypediagnostic: MN2PR04MB6445:
x-microsoft-antispam-prvs: <MN2PR04MB6445B8193A6DE8B0A9AE1BD8FCDF0@MN2PR04MB6445.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(189003)(199004)(86362001)(316002)(8676002)(81166006)(8936002)(81156014)(5660300002)(486006)(52536014)(110136005)(54906003)(2501003)(478600001)(6246003)(25786009)(4326008)(9686003)(305945005)(6436002)(229853002)(55016002)(68736007)(7736002)(53936002)(76176011)(2201001)(26005)(102836004)(256004)(74316002)(7696005)(14454004)(7416002)(186003)(6506007)(99286004)(6116002)(64756008)(66556008)(66476007)(3846002)(66446008)(66946007)(11346002)(476003)(446003)(76116006)(71190400001)(71200400001)(66066001)(4744005)(2906002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6445;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: erBPUDobGILlZI0oIToSHV/lBdjP8kGBScoxefuv7QULoGCrfmS3NwfDgF+uL+9bBNk9UNnj7iOPC1W73mRn5ULLoeqVDEuQlnJc+yNcY63VJzzW3PB71bLw91ab+F3fv5YrN4iXNKq+C1XQG6ORn4FI/USe+xmdygJIRVQvH/OoWGtxKxy8Ap1uZlMBKNZSUVo0CHqEovqfuIed16whYne5PyTMsQ9a3aG2cWPtXoqcJ9Sq/Y0i69Yl1dk5ThNqYx1qbCiLvdf/ueMQaqBJRTVKGd0qhpxUo1TUvVNgRYiaKmqR57LsUfhT70GeFVdEw254Yr9KC8ooVo1jIu5RdxymKc0Hj/PiiCBnF2yTruzNaHesv1Myp5hQwEJIeFBYE4c2XFPQxlo0TMWISISp3vxnLk7SBKmxwBWej1zhyU4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71d768c-825e-4757-1fe6-08d7159f3c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 10:09:54.9276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Avri.Altman@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6445
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Configure CDNS_UFS_REG_HCLKDIV in .hce_enable_notify()
> because if UFSHCD resets the controller ip because of
> phy or device related errors then CDNS_UFS_REG_HCLKDIV
> is reset to default value and .setup_clock() is not
> called later in the sequence whereas hce_enable_notify
> will be called everytime controller is reenabled.
>=20
> Signed-off-by: Anil Varughese <aniljoy@cadence.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
