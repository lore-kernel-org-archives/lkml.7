Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37491C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E431321783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="meEqKqf2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DDN9dDHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfGRGqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 02:46:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8678 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfGRGqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563432398; x=1594968398;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XH/xLghjclFjmGZULGzE+zOCNkzC+Rge0wBhhcqlxiE=;
  b=meEqKqf2eqtBgEAp1IgiVnfgmVdUilGUFqM9KNQkOOefKUlJ26O47tSK
   6JfmoEIIG7taj/vzPy0WQNsHiG94snHrBXyQXjJ1wq9HvXtmHsirV0+Rn
   CNVgets2AHkbKeQ+EgH2MjwnyJMbq7vtTR7T6vrBVfBiPKxesdKcjXzrp
   cB3gsA7EpHM/F6QvaEpiNpdQJW01sKGq7aLGWSHlzdzCsHZi2qvhvkOyu
   UhJY+8K6PLV99RyvCV9Rs8FXq33uTsa+yS3TxFTnC0KyekMHht5pbA5by
   kOUOXJ0onFI3nHqfCNtURvfqBYDNlB8sxE3WYcCW1BJHHbQXz0X3B+B8y
   Q==;
IronPort-SDR: aoBWnHPR9VfOyTT8RnEBZQE3NlpI73ulsX/urxkqtEzJGrhpQ4ij+tNRm0VLn1pt9NszZ2J3IS
 SLHiyKUTqvJnRPPwZd8lvnHlD9zwqyfpWI4Ys2iAm+Bc/JZBIPNN6IV/fLEpThbSc7yZtC+U+k
 Vr0X0m7jBHWcYgJ2SbvZuGGy2Efs6alh2VXJ28EBKSA34j/sKu7sNfD1S1pOXo8BScpj1zsfL/
 EbJMnt6a0WtWHw6eBRcr9rIy//FR9tVNTKukmqK/eMD6DUTvZ+tHCuTHe42rw/tbHAXH5gjDnb
 cMI=
X-IronPort-AV: E=Sophos;i="5.64,276,1559491200"; 
   d="scan'208";a="114473251"
Received: from mail-dm3nam05lp2054.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.54])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2019 14:46:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoTyQLIk4SNIkhVG/rpcf6uwS+o7+0FEv2HY+mAOR/ftJwZuMBfbmQIekktoVGYfA94R65ae8s261pigDMsfG9AlpOgu1qGTXd/JmD9Q4CCEBY+bhnJVBimxBw80Sk8agaO7icJK4GjTjtdeYZ/6ZU6zaNzlybLmwi1nw8/TsIZdinLaaFuf4Lm49JAbpAcEui8fyKArZlqB3mMI2frY3CfXukhVjRsVSXYZNUL3xwWPvaDzmNHzZkBeywKoC2Pf+yqR043D8zIl4m0KpfikSHofovL8VgNH+a89obr1pxFrKLFmSY/7BR8/Mw1p1n38aWhx9xZD+Oc6mvRIQH14sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPavYDlqZoyuLGMPRPBJmOZY1rgRVxy2gymti2/a+/I=;
 b=CX4yBy9hG/xTdd+0Zh3e/99d4MbNF7StNHAJQjUQZyGqfOwxE4bGOabBj2ZTbT+qf1iM9GV7W8cKfFGrO3Lo+Aw3NWL1OU8l7iSfWgTeg6szL6TL6hSYV0in1bQY72TMsDe8oh8rmDHWBg8tyLU6DcQxkb1qtKIOU2Oj6yrm3Xvadu7NyJwg542Dgt0DA++piTbwmTTiR6yvH5OR/ub646Y/mxG8iW4WLXhpzmgG1Y/tkZRsNwFvdSguZ0sbaTn+hNFCex/MPDEJR0Ti4ruU0GgL3y0v1cuOb9PjvvhivW/r8RQAB72tpdPwToxJy1UOqXwRxQcf9v/L6rXoPqOg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPavYDlqZoyuLGMPRPBJmOZY1rgRVxy2gymti2/a+/I=;
 b=DDN9dDHMuHXLtdjwR/mz7BgXN/0OV5gYIfvYBxueFj+RXAkPXukY7cpbsUG+gntNIiI5Qdv4JeyH95ZHE88y9LMJ1BXKkG5tebbyDM+UTnJZCVB64UP6STrMQ81yAeLNKkKsZBiHRwqWbJhJEoWLXIuanYeaHm0HxPbbIbYn+Po=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4334.namprd04.prod.outlook.com (52.135.72.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.11; Thu, 18 Jul 2019 06:46:35 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::a102:1701:9c05:96b3]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::a102:1701:9c05:96b3%5]) with mapi id 15.20.2094.011; Thu, 18 Jul 2019
 06:46:35 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>
Subject: RE: [PATCH] scsi: uapi: ufs: Fix SPDX license identifier
Thread-Topic: [PATCH] scsi: uapi: ufs: Fix SPDX license identifier
Thread-Index: AQHVISOkIGq/TXYo40K7pkiAfhMabKbGS2d+gAABeYCAABGCt4AJx32A
Date:   Thu, 18 Jul 2019 06:46:35 +0000
Message-ID: <SN6PR04MB4925B7FC2F71730A5932F7EFFCC80@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1560346477-13944-1-git-send-email-avri.altman@wdc.com>
        <yq1ef2w9kig.fsf@oracle.com>    <1562890815.2915.13.camel@linux.vnet.ibm.com>
 <yq1d0ig6o8b.fsf@oracle.com>
In-Reply-To: <yq1d0ig6o8b.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: edafb04c-3e81-4ca8-0bcd-08d70b4bad9d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4334;
x-ms-traffictypediagnostic: SN6PR04MB4334:
x-microsoft-antispam-prvs: <SN6PR04MB433408EFC0A34708321D097DFCC80@SN6PR04MB4334.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(199004)(189003)(76116006)(66446008)(66946007)(64756008)(4744005)(186003)(66476007)(476003)(86362001)(446003)(11346002)(66556008)(66066001)(26005)(71190400001)(5660300002)(71200400001)(74316002)(6246003)(6436002)(52536014)(9686003)(305945005)(478600001)(55016002)(7736002)(53936002)(2906002)(81156014)(99286004)(81166006)(8936002)(3846002)(256004)(6116002)(76176011)(54906003)(486006)(229853002)(4326008)(7696005)(110136005)(6506007)(102836004)(68736007)(33656002)(8676002)(14454004)(25786009)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4334;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zaw46+F1GqIrCIo2AtuQrrfmO1Y3V0M9bRjNR3VMcyKePtHEUZGRCv4/bVSYVq+AoYSRbEvNLAHgep+Qdl/hnJYp0FKuTdlOSwECHgidZqtbW0/HAt5A7aBwCYwCQ/HRApJTWVBuEAOSi1aEuU254jJnw9wsAlg2MuUjfE43R1TlPZ72KkP+e/YqND8o3FyQValuFvdYdVg4yTZUjktWFGbWaVYUhB9K5iTeA4WF6HAtvBdSuW5stgBR7rEckbrPAtgnAIMQKzU22uJNt6rUhXM0TC+/TvGdlLx71iTABCicJxHkYh0npS12FBIf8P4khjiZjB3xSlyL53k16XmltqymhU3yFEVgp+RrisJaaYZEE31y1dG27Olnuj3AHU0Zj4Am4Lj0Uv6CW6o3H799zcubtInAQL4ZwDbPe6a2vYU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edafb04c-3e81-4ca8-0bcd-08d70b4bad9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 06:46:35.8258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Avri.Altman@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

Are there any further clarifications required?
Thanks,
Avri

>=20
>=20
> James,
>=20
> > Just to note: this isn't technically a licence change at all.  The
> > entire kernel is covered by the system call exception and this file is
> > thus also covered.  It's really a simple tag change to allow tools
> > which parse uapi header files to recognise from the SPDX tags that this
> > is a kernel header to which the Linux-syscall-note applies.
>=20
> OK.
>=20
> --
> Martin K. Petersen	Oracle Linux Engineering
