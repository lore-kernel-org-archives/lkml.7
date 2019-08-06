Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C3AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7BC20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chelsious.onmicrosoft.com header.i=@chelsious.onmicrosoft.com header.b="HsTTaHRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732586AbfHFKij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:38:39 -0400
Received: from mail-eopbgr810100.outbound.protection.outlook.com ([40.107.81.100]:1632
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730068AbfHFKii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:38:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqSqJEGN+XGmHXXF/UfGM7RC7FA3Kmg/glfYk76bmnq6dyZnBsepoevfoqgUIsxVlgOiaQ4oqcXwnTu/LT2MLhA4M0utZxw1vGukS38wVjEHtsondGE6yzsxPdelYshUIulHltg1Uipj6QZIXuP4n+A5TQzVtJt4yXn8+yGPJk3d3k8j6EuIDtJsIbryUHXw6x/5wbvFQ6sfRH2OZkffGnk3+kZ8eWm29/iT8rJx1Dxunu3K8/WDUj5WFn6fC1cFf8oTZtj/++r4p0YB/lP1c9zkOrlVW663/NpaZRzCl9jLDFZba+yltYxNPMFapxHTc5PwZiCHam1FgrrqEwWITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwwvEmzPUqmEF65wZA2Dj3ylHjdsn+HIO+6dmXpwHRI=;
 b=m8iLFek+cpQDBfsrNMIVf4Kx3c80JiEJT1tJH+5jUjEy7NhQCjmFX2bhhGv60PFxP9yvPTTUhQ2QY1adXXwxzZWliFXwt1mQeTpa7BVDkD9+pQe0QgV1UkkXlu6cfQx+qNJA3nt6xkBEAoX12FZ8a3HJZhAXa6d6P1P9i29HRa06tVZWrmoVp1r0DxxsY+wDXZFpRZlU0Kb76I1N0EHMiRr3s9CaBhyVthWe1/LbKB3Huhr5eLUt9EEAd0xiwrn/7JTWHp2uTN/LMzZPXvv7HOjWTIo6ajrULmYV1vIBeQ0lfqHqZaZslLFeWLPceVs+Zl2R199qy8TmV3fyADs8Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=chelsio.com;dmarc=pass action=none
 header.from=chelsio.com;dkim=pass header.d=chelsio.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chelsious.onmicrosoft.com; s=selector2-chelsious-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwwvEmzPUqmEF65wZA2Dj3ylHjdsn+HIO+6dmXpwHRI=;
 b=HsTTaHRbHIWhius/NKf8/uA7pU8QChHajaX/5IWXqQbQcgbS2DX6Q8GPOo2aKVUGWX5CKsq7MwvisVLz6yCbrKHXSrBhWIb5r8rX1TqwyYwwmgkEzefG/ljWQrQDvHEqsW1l4XZEvUtOd009ovC97dV/YNveBPtMoRJ6aZu6kwk=
Received: from MWHPR12MB1343.namprd12.prod.outlook.com (10.169.200.137) by
 MWHPR12MB1886.namprd12.prod.outlook.com (10.175.53.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Tue, 6 Aug 2019 10:38:35 +0000
Received: from MWHPR12MB1343.namprd12.prod.outlook.com
 ([fe80::a8b6:5544:a6d6:f2ec]) by MWHPR12MB1343.namprd12.prod.outlook.com
 ([fe80::a8b6:5544:a6d6:f2ec%3]) with mapi id 15.20.2157.011; Tue, 6 Aug 2019
 10:38:35 +0000
From:   Vishal Kulkarni <vishal@chelsio.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     Nirranjan Kirubaharan <nirranjan@chelsio.com>, dt <dt@chelsio.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: pull request: Linux-firmware: Update cxgb4 firmware to 1.24.3.0
Thread-Topic: pull request: Linux-firmware: Update cxgb4 firmware to 1.24.3.0
Thread-Index: AdVMQrCavNmr4ct9SzGhc1kdBf5rVA==
Date:   Tue, 6 Aug 2019 10:38:35 +0000
Message-ID: <MWHPR12MB134396EEFEFF70FE0387BA75CBD50@MWHPR12MB1343.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vishal@chelsio.com; 
x-originating-ip: [111.93.130.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91e0c834-43ee-4901-5e25-08d71a5a3c65
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR12MB1886;
x-ms-traffictypediagnostic: MWHPR12MB1886:
x-microsoft-antispam-prvs: <MWHPR12MB18863DA3B2496D12430DC250CBD50@MWHPR12MB1886.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(346002)(39850400004)(136003)(189003)(199004)(66066001)(476003)(78486014)(486006)(55016002)(74316002)(2351001)(5660300002)(64756008)(316002)(52536014)(66476007)(66556008)(66946007)(186003)(9686003)(53936002)(5640700003)(6436002)(33656002)(26005)(66446008)(81156014)(8936002)(6506007)(102836004)(508600001)(86362001)(54906003)(305945005)(25786009)(7696005)(6916009)(7736002)(4326008)(76116006)(2501003)(256004)(15650500001)(8676002)(2906002)(71190400001)(68736007)(14444005)(71200400001)(6116002)(14454004)(99286004)(81166006)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR12MB1886;H:MWHPR12MB1343.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: chelsio.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PAIi9o3QSXhVnjjVd586/WC4ao4ueHBXKW5z+y7EnYyBHY3C887qN8u9pbi2jkWXnnr6/qVmGX58kDyRzjZdOXVXvsW1V1UKHEkKn9KvmowNhBIfBszwZHa8BpD9DNCmCex4r87GJ87Pe+nOZ6nB3LVD4mi/1DC0GQKwdw09TuPkDjpwVOA04dFyVnb5YHIs0SMjIwJraj5KKBTIDb96xwda+pWXKdnzClEl6eDucnrKsM5uplimxrcxL4HH0zwVwAKlHmpEPNnIc7onHVESzCkFFP/XbNSOedMS0TFgE7q0MVJj0yRFYvsXLxx1GrKl4vYoW3e8lM1qyUpiPC4hVMV+WLiRxJ+l+qclsziyMyIT65Rn37oSACimXkzSRx0XX6dxsnEpW4ZUv/j+k6PMCBGxRnO09zxjhG8WUMu0y0E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e0c834-43ee-4901-5e25-08d71a5a3c65
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 10:38:35.5970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JMFZUwj0CV7c5ZfTqRaNigXLcLZONa7xhb2W+Jvo6FZtXE1LPpiTNLNWfmgL+Mi0rH5MS7+nR5PauvnMmaK6iz18JY7vqG/URVhNQxB6Kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1886
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kindly pull the new firmware from the following URL:
git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

Thanks,
Vishal


The following changes since commit dff98c6c57383fe343407bcb7b6e775e0b87274f=
:

  Merge branch 'master' of git://github.com/skeggsb/linux-firmware (2019-07=
-26 07:32:37 -0400)

are available in the git repository at:


  git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

for you to fetch changes up to b1e26aaebfdc34827c23a96ef3948298137f72e9:

  cxgb4: update firmware to revision 1.24.3.0 (2019-08-06 00:33:02 -0700)

----------------------------------------------------------------
Vishal Kulkarni (1):
      cxgb4: update firmware to revision 1.24.3.0

 WHENCE                  |  12 ++++++------
 cxgb4/t4fw-1.23.4.0.bin | Bin 570880 -> 0 bytes
 cxgb4/t4fw-1.24.3.0.bin | Bin 0 -> 571904 bytes
 cxgb4/t4fw.bin          |   2 +-
 cxgb4/t5fw-1.23.4.0.bin | Bin 659456 -> 0 bytes
 cxgb4/t5fw-1.24.3.0.bin | Bin 0 -> 662016 bytes
 cxgb4/t5fw.bin          |   2 +-
 cxgb4/t6fw-1.23.4.0.bin | Bin 708608 -> 0 bytes
 cxgb4/t6fw-1.24.3.0.bin | Bin 0 -> 714240 bytes
 cxgb4/t6fw.bin          |   2 +-
 10 files changed, 9 insertions(+), 9 deletions(-)
 delete mode 100644 cxgb4/t4fw-1.23.4.0.bin
 create mode 100644 cxgb4/t4fw-1.24.3.0.bin
 delete mode 100644 cxgb4/t5fw-1.23.4.0.bin
 create mode 100644 cxgb4/t5fw-1.24.3.0.bin
 delete mode 100644 cxgb4/t6fw-1.23.4.0.bin
 create mode 100644 cxgb4/t6fw-1.24.3.0.bin=
