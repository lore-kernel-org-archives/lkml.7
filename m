Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38796C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29D721874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chelsious.onmicrosoft.com header.i=@chelsious.onmicrosoft.com header.b="O+SMMESK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfH3McR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:32:17 -0400
Received: from mail-eopbgr730100.outbound.protection.outlook.com ([40.107.73.100]:52040
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727417AbfH3McR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:32:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UovHKvwOikLNXT54mU6ISLYolnScqyRmF0NPe9JpkiuNvXqVOrR48lLpZR6limD5fs29pInrj5WEvZ1BvJ+0z1kpUsi1bH+nqvqA97zbwBDEmludlmHSuxiD8wy2X1oYGnDdMZb2qvlt0VVs+jKoSVEhnGwdmMI6FGFimP7eQUCnppcLKzkkim6dJa/HcSBBh+OKVPoy0BNzK0/aaa+Zs6NEAmRU5uA25KDxuUVPfXZs1oDTIQxQQvy7c4N1Qjw6OKpriX7z+cC8Gwj8Q1Ud2+RwLeS+7JdgMFvuLQV8ma3hme2u53vZVwXnq+6YUVPWlOh9q8YkS7mydT93LFI5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ay5OtJsym90TLhUPzG1D09rG3sChVYaO8XyHtM34Nr4=;
 b=dDNwe76fdAL3g0rs0JSkkLUfmNuOIiGAqbVvqARgvn5RLHMktnY5u+UsJSMhXsbgYg9IfbmNaM/W2YgqVFVA8PnDK0IUcppn+hz/spoxPhtom9qLsqCMpiMowyvOjh6cFbd3TSoaRMQaL0S9xiCgcospGz5uq8tqjQNi+lDzhey3xDYYVajbbdICKWyO2jsfecgfX8N92WmSeW5QM8aNf26RyWFxGQbT/2FRLPTbMZDwah7u/2vXemPGm+tAlZd3znDq1NaVVXHH539H3TzYOCcrEYPwcZYk5pjSsf7SGqBRGksF1tPakaYdjV9db64HEaZRohLrUkJq/qkN1xrZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chelsious.onmicrosoft.com; s=selector2-chelsious-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ay5OtJsym90TLhUPzG1D09rG3sChVYaO8XyHtM34Nr4=;
 b=O+SMMESK2Gxcp48BSRCYrcha8Vy5ScGF+DrNM7iBttAfjQYnqYbCzyFhFq4v8IcBml+jLvTiPEpjp64MLUkx34iffTNiC+Tz5q6Ua1j8CEx+3MFxAY7NCzQ/pb4aL2hekahlEQeDiGE10H95I7/xhKsfkV+XI/y1+hHgvEdv3Hw=
Received: from MWHPR12MB1343.namprd12.prod.outlook.com (10.169.200.137) by
 MWHPR12MB1502.namprd12.prod.outlook.com (10.172.56.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.18; Fri, 30 Aug 2019 12:31:35 +0000
Received: from MWHPR12MB1343.namprd12.prod.outlook.com
 ([fe80::a8b6:5544:a6d6:f2ec]) by MWHPR12MB1343.namprd12.prod.outlook.com
 ([fe80::a8b6:5544:a6d6:f2ec%3]) with mapi id 15.20.2178.023; Fri, 30 Aug 2019
 12:31:34 +0000
From:   Vishal Kulkarni <vishal@chelsio.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     Nirranjan Kirubaharan <nirranjan@chelsio.com>, dt <dt@chelsio.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: pull request: Linux-firmware: Add cxgb4 firmware config files
Thread-Topic: pull request: Linux-firmware: Add cxgb4 firmware config files
Thread-Index: AdVfIJkHFpF9QpSLQ+exguGytDD3sg==
Date:   Fri, 30 Aug 2019 12:31:34 +0000
Message-ID: <MWHPR12MB13436D4BF9438757EF28CA0CCBBD0@MWHPR12MB1343.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vishal@chelsio.com; 
x-originating-ip: [111.93.130.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d36b2d31-c1cd-4f16-7d96-08d72d45fef6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR12MB1502;
x-ms-traffictypediagnostic: MWHPR12MB1502:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB15022AB63DBE4C049FE5EC6BCBBD0@MWHPR12MB1502.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(376002)(346002)(136003)(366004)(396003)(199004)(189003)(174864002)(486006)(6436002)(256004)(476003)(71190400001)(26005)(71200400001)(508600001)(14454004)(102836004)(6506007)(6916009)(186003)(6116002)(305945005)(8936002)(7736002)(7696005)(3846002)(2501003)(54906003)(99286004)(316002)(74316002)(81156014)(66476007)(52536014)(86362001)(2351001)(8676002)(66946007)(33656002)(76116006)(81166006)(66556008)(25786009)(53936002)(66446008)(64756008)(5660300002)(9686003)(4326008)(55016002)(2906002)(5640700003)(66066001)(79990200002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR12MB1502;H:MWHPR12MB1343.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: chelsio.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PGTBUf3zOMkU7t2mCx42zCSxB7Oren3Ut1vWkhUUULQUk1kL0MAQ+UGY9Ng+woKMU6eINOiVa7s6tufkz3gcLS2I6Lwfe6JmgLXPaF7f9gl/lwyMyiiqLG3CkaYcOUhkGTk1X9qwD4C24llYHb5A3T8jfA5a91jsWHlZ49UdnXrCbsOtwON0T3F0wJQvRz+tlf1WipCxMfj7PrG9BvdHmMFPPbblG835PKNqWTOyoEriEFem7I+wKmm0TDtjxtHuVOGEkD7GRdY3EP4g7nz1Sd5wLTRdix3kF4fgfk0gkVk+AZ1Ge2CDDJEN6vcqMZQKpIna+554S80YHcXmzCZa5e7QLnTy7GnhzvFt7SgBZXUJeOMfbEYfOvI2fX1PgSy7hA6feXV73vpN2eymr9KvePbRSrKI6jp9zdXtaBBOF/A+kXbxLJuTDEAkoLSgdLS147cnWbj8cJgCCANS59IKxA==
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36b2d31-c1cd-4f16-7d96-08d72d45fef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 12:31:34.7735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VjtdvhWZo+SCNdG1wLoeKHJP+W0p+DhShDtgOMJmjh70QWrwJAKQXNgQCZ9o6hPZrEfKfDWEnlyOcRseIBCe/AUy54J4s5vJ4r6l61nsuoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Chelsio driver loads firmware configuration file to allow
firmware to distribute resources before chip bring up. Chelsio NIC
driver, cxgb4 searches for firmware config file at /lib/firmware/cxgb4/
directory.

Two predefined configuration files are available - default and
hashfilter. Default configuration file equally distributes
resources across all features, such as iSCSI, iWARP, Crypto, etc.
On the other hand, hashfilter configuration file borrows some
resources by disabling the iSCSI, iWARP, Crypto, etc. features,
and redistributes them to increase offloading more number of flows
to hardware via tc-flower.

Please pull the files to /lib/firmware/cxgb4/config directory
and create a t6-config.txt symbolic link in /lib/firmware/cxgb4/ to
/lib/firmware/cxgb4/config/t6-config-default.txt. The same needs
to be done for t5-config-default.txt and t4-config-default.txt.
=20
The directory structure should look like below.
# tree /lib/firmware/cxgb4/
.
=86=80=80 config
=81   =86=80=80 t4-config-default.txt
=81   =86=80=80 t5-config-default.txt
=81   =86=80=80 t5-config-hashfilter.txt
=81   =84=80=80 t6-config-default.txt
=81   =84=80=80 t6-config-hashfilter.txt
=86=80=80 t4-config.txt -> config/t4-config-default.txt
=86=80=80 t5-config.txt -> config/t5-config-default.txt
=86=80=80 t6-config.txt -> config/t6-config-default.txt


The following changes since commit 7307a29961ad2765ebcad162da699d2497c5c3f8=
:

  brcm: Add 43455 based AP6255 NVRAM for the Minix Neo Z83-4 Mini PC (2019-=
08-27 08:04:55 -0400)

are available in the git repository at:

  git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

for you to fetch changes up to 2f885ba53dca06eeaf3d31cfa74fa9d30ab1dcc6:

  Chelsio driver loads firmware configuration file to allow firmware to dis=
tribute resources before chip bring up. Chelsio NIC driver, cxgb4 searches =
for firmware config file at /lib/firmware/cxgb4/ directory. (2019-08-29 05:=
40:00 -0700)

----------------------------------------------------------------
Vishal Kulkarni (1):
      Chelsio driver loads firmware configuration file to allow     firmwar=
e to distribute resources before chip bring up. Chelsio NIC     driver, cxg=
b4 searches for firmware config file at /lib/firmware/cxgb4/     directory.

 WHENCE                                 |   8 +
 cxgb4/configs/t4-config-default.txt    | 562 +++++++++++++++++++++++++++++=
+
 cxgb4/configs/t5-config-default.txt    | 613 +++++++++++++++++++++++++++++=
++++
 cxgb4/configs/t5-config-hashfilter.txt | 467 +++++++++++++++++++++++++
 cxgb4/configs/t6-config-default.txt    | 599 +++++++++++++++++++++++++++++=
+++
 cxgb4/configs/t6-config-hashfilter.txt | 430 +++++++++++++++++++++++
 cxgb4/t4-config.txt                    |   1 +
 cxgb4/t5-config.txt                    |   1 +
 cxgb4/t6-config.txt                    |   1 +
 9 files changed, 2682 insertions(+)
 create mode 100644 cxgb4/configs/t4-config-default.txt
 create mode 100644 cxgb4/configs/t5-config-default.txt
 create mode 100644 cxgb4/configs/t5-config-hashfilter.txt
 create mode 100644 cxgb4/configs/t6-config-default.txt
 create mode 100644 cxgb4/configs/t6-config-hashfilter.txt
 create mode 120000 cxgb4/t4-config.txt
 create mode 120000 cxgb4/t5-config.txt
 create mode 120000 cxgb4/t6-config.txt=
