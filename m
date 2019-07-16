Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6828BC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 06:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AFD2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 06:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fvXgqrS6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="E1iJ/GCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfGPGyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 02:54:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:45611 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfGPGyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 02:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563260188; x=1594796188;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rRzCzyAdwIVEYaPofBz/AKCwP5dKJ4/z4zeuDl6Ssig=;
  b=fvXgqrS6GNMqBPh7l1cf8/iD+h6h5c2bUbrvdf0XB7BdRtUa0T4B7ji4
   GK1lps4t1ul3J4/IGtrFCH/1t+8FNUK9rIq/oYusBhOinWsJpd7T5ZQuf
   NenvF58Ax3EM2hVoQM2fVV+DsL6y1OxG1wCRnRPl/BueL9GpHUzwGsGhW
   PqK8bWFLyrhlEF83Yhx8Ix5tPKIyUp/W9qrs0NY1rfkdHy2U+aLtaQ5Rv
   fdCe+iXqg0vwe04OvdP0wPP7sP9E7S5mNYiFK+1VA5fm9K+Clu2+hYzWu
   zFqtT/uuVpTDRDQGVpk0165+IP9IH2wcJfCk2NcWN9gDEX2qB6W5TAVkX
   g==;
IronPort-SDR: gANFz2MgvQQsZbT9zGy6SJN4vrZLUfkXdO1JJobpj2eD8aKu/c0F6EJffXyTdYrwNdgkklmgG1
 rghk5Rswq0Lp/n58CDhNzM/wLsg0QR6/QRX5sAeKc0+iR2nYkfWJqgVbYfAmXsAQIlDRvr8l7S
 5844G6ikL09HyHmtSS65neXjrOLzqdcaLM+4kl1tDw/J6RBm6kkfPT7Z0Uyag7FcCorNpgr2f2
 kEGRL0fNgZRzPH2FyiSHaWDaZe7sjDguLF8u+3GAH20iB82KtdSHyuuWb4oxXZ9SuDoXdPCW8z
 Et4=
X-IronPort-AV: E=Sophos;i="5.63,496,1557158400"; 
   d="scan'208";a="213125947"
Received: from mail-sn1nam02lp2050.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.50])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2019 14:56:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f92c4zncoRTlnZVplbrjfKtGPw/+sVld/y8c+o4XQNFqcHojb3jD/OQK4B16oHKXy0kDoibU7CYkQdXZi0qYPTkseAWErT6fuY/HljFGCYItZAzVtAw6BS0sA4gDKqq/NuFSpIGBxLQ31Ah0uNsWRuc7n6Dkc8kMxkWCwM4g3ztZ8zK5mJfQqJotYaEnCfSt3rmLqCUcg8bFSPsdJteKV7udJPwCGkVfCywS5ijG4lHCS5O1undcVvJl/VZiDq6+iPsFmcTQkLEiNG7fmqnmXaGNMvP5v4cdHoS+a47wChraWMIkr5oFtNRrBGRgAT/WNVV4c+yOf6eU5SJ+5oCVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRzCzyAdwIVEYaPofBz/AKCwP5dKJ4/z4zeuDl6Ssig=;
 b=V1ZZOjMnuqH0s19TBAUkoAqL08tqfozfIPIH5NEs9uKCCOJUthNRKHRGZX757F5Amn0kyAg7FY8gbM+3OZPLG65SAexHwYxbFl7QF2m8PkjH+u/y18Nblb1HYux06tSw5L9QRJDDWOTJM+7oCIFCoswlyPxmeGevXwETtLHX+FSr9+S2jqi5CVl7cTEceHrNC1iNRTwWRPJbyVLpqk4BujaaVU6Boq3WLU1/wq1nzb0eX9pJegqLgbAEfOeoCN0R8E8HgtCFtHHZMDsrvxjsio6I2kJVOlacMIAse/+OTg71u+Kk1csb2vpWlLdnJUYtM+V71fm7ywT2Zzsh76SlkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRzCzyAdwIVEYaPofBz/AKCwP5dKJ4/z4zeuDl6Ssig=;
 b=E1iJ/GCcS2I/wJrtaQX1ndBzOCHEoRhlZe7lefeHe/PrgnoxKjsTIpt1RGv9nJ+Z5+Kz5lQLkz8LTa2XRbesv/d2yB7X5c4c9BQOBfi5KH6eSwrCJRR6cd9epb8wEFh3nwlXiibYS44iPkihF2wueNV3bYrBWJa7LqeuVBslxzs=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4112.namprd04.prod.outlook.com (52.135.82.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.13; Tue, 16 Jul 2019 06:54:50 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::541e:d74b:98bf:c319]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::541e:d74b:98bf:c319%5]) with mapi id 15.20.2073.008; Tue, 16 Jul 2019
 06:54:50 +0000
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
Subject: RE: [PATCH v1] scsi: ufs: change msleep to usleep_range
Thread-Topic: [PATCH v1] scsi: ufs: change msleep to usleep_range
Thread-Index: AdU6/zmiJJopDFlPQEeuzjc9BNSdLAApAIHw
Date:   Tue, 16 Jul 2019 06:54:50 +0000
Message-ID: <SN6PR04MB492511AE7841BD4C84205218FCCE0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <BN7PR08MB5684BBB44FD0E43501558A20DBCF0@BN7PR08MB5684.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB5684BBB44FD0E43501558A20DBCF0@BN7PR08MB5684.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d76c0bdd-44c6-48eb-71c6-08d709ba7f8e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4112;
x-ms-traffictypediagnostic: SN6PR04MB4112:
x-microsoft-antispam-prvs: <SN6PR04MB4112E51AAD7C324A7E7BF750FCCE0@SN6PR04MB4112.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(199004)(189003)(6116002)(86362001)(25786009)(478600001)(3846002)(446003)(68736007)(6436002)(8936002)(102836004)(6506007)(186003)(74316002)(26005)(33656002)(8676002)(76176011)(14454004)(229853002)(476003)(110136005)(71200400001)(11346002)(305945005)(54906003)(2906002)(71190400001)(81166006)(9686003)(52536014)(66446008)(66556008)(4326008)(53936002)(256004)(4744005)(7736002)(6246003)(81156014)(64756008)(7696005)(486006)(76116006)(55016002)(99286004)(66946007)(66476007)(66066001)(5660300002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4112;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sHaEGOuDHhogjSLr1qTFA+S9rFQM0xALbsFneNIy018ppmuJTRfQQIcj9XpHhhTOk2Bt5gNoYxDG3nB9FivrrQh9XNIXqndNFqOwWrQegpFV/Xu/MAWVVO3hKJRqYrTUkTrmliVpkfqMXm6AY1CtJPvQqYyt6ZiP1baWsinv5RJyZJKvwRSs+wbANEB7PbmkvwwMijrLDGig0tzninmteeMFc9vZS01lk/Yw9xM8WvyDykkg3LYAGpBYfoE1kQ2VI6xZNvOE2sKnMJEVfDyYLLb59o54/5U8OtsW/Eb+IPw8fgcryPWYCh11Cz1hFX4guN3m8aZ8faCfjjmByc4ruhZPM5rc/sc8uesNO1XQm+bxdKWQjtAVgLKbMD7jN4Q2oUDRe8UYyqJXGyaeiJQHAYD7yu3uoziYBM3BvFvy5S4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76c0bdd-44c6-48eb-71c6-08d709ba7f8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 06:54:50.3174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Avri.Altman@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> From: Bean Huo <beanhuo@micron.com>
>=20
> This patch is to change msleep() to usleep_range() based on
> Documentation/timers/timers-howto.txt. It suggests using
> usleep_range() for small msec(1ms - 20ms) since msleep()
> will often sleep longer than desired value.
>=20
> After changing, booting time will be 5ms-10ms faster than before.
> I tested this change on two different platforms, one has 5ms faster,
> another one is about 10ms. I think this is different on different
> platform.
>=20
> Actually, from UFS host side, 1ms-5ms delay is already sufficient for
> its initialization of the local UIC layer.
>=20
> Fixes: 7a3e97b0dc4b ([SCSI] ufshcd: UFS Host controller driver)
> Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
