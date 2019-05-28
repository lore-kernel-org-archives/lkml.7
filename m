Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3062DC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0025E208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 07:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="mT9JjZ5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfE1Hv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 03:51:28 -0400
Received: from mail-eopbgr710084.outbound.protection.outlook.com ([40.107.71.84]:2923
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727803AbfE1Hv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 03:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+ZGXyNlu+DEZIzl3oJPMCulW9rKxU8isikVn4/nLUY=;
 b=mT9JjZ5/wtUuLc2UJDX/US5d/5bTWeE1opnYpSfNLWz9kqUOyF/HjVRqrCEda+PG70hSqiOYnl+fsJyUZzEkUyCpIK8Rbn2T8iT8dyOR9o0r/tE2QNZqmp1QPN7BwWP/923ybSrf45XvCiYTmrJeuVMzCVBl+LAJbPO/GMhjNrw=
Received: from BN7PR08MB5684.namprd08.prod.outlook.com (20.176.31.141) by
 BN7PR08MB5522.namprd08.prod.outlook.com (20.176.29.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.22; Tue, 28 May 2019 07:51:22 +0000
Received: from BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::8d6c:f350:4859:e532]) by BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::8d6c:f350:4859:e532%4]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 07:51:22 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
CC:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>
Subject: RE: [EXT] [PATCH] scsi: ufs: Check that space was properly alloced in
 copy_query_response
Thread-Topic: [EXT] [PATCH] scsi: ufs: Check that space was properly alloced
 in copy_query_response
Thread-Index: AQHVD669lSVnBatUYkear3B63M9d+aZ+2CBA
Date:   Tue, 28 May 2019 07:51:22 +0000
Message-ID: <BN7PR08MB5684B0A4DB8BC0A00D9D6877DB1E0@BN7PR08MB5684.namprd08.prod.outlook.com>
References: <1558427062-5084-1-git-send-email-avri.altman@wdc.com>
In-Reply-To: <1558427062-5084-1-git-send-email-avri.altman@wdc.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [195.89.176.137]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 660ec111-b5d8-4f2f-f582-08d6e3414736
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN7PR08MB5522;
x-ms-traffictypediagnostic: BN7PR08MB5522:|BN7PR08MB5522:
x-microsoft-antispam-prvs: <BN7PR08MB5522E98CDE2793EB9850D4FDDB1E0@BN7PR08MB5522.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(396003)(136003)(376002)(199004)(189003)(2501003)(110136005)(54906003)(2201001)(86362001)(68736007)(4326008)(316002)(6116002)(3846002)(25786009)(6246003)(2906002)(66446008)(186003)(26005)(558084003)(14454004)(478600001)(476003)(64756008)(446003)(11346002)(486006)(66946007)(76116006)(73956011)(66476007)(66556008)(7696005)(8936002)(8676002)(229853002)(6436002)(81156014)(81166006)(52536014)(5660300002)(7736002)(305945005)(66066001)(99286004)(7416002)(33656002)(71190400001)(71200400001)(53936002)(102836004)(6506007)(76176011)(74316002)(256004)(55016002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR08MB5522;H:BN7PR08MB5684.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oibEA+6PsQrHBjpIaJ6Q/YuPbF9u1Ku8U+IaDE4qaSJ4JgnkFhcaYLu2NGaL+7/qyPYW3g1ldkBY8ULI5nN4rUQzHg8+a3sJlEknXzeFKs0mQWPyKRyfJfMKgjKnN14dtT1v7vIqIg495S1sLH97Lyh4W9TIyowNrxEqiu+6eyR8jbHyKSha3uY+h10XvvEv8It5ahdSHnoB3QeF+3MJRpZPb29a8F01JUMCc30XE256mUPpnoHH6SqUUqd++9eErvlxC922v9qqWjCEx8rqPXknva08PR28wuH4cYpJKw5GzjkeOhpK6AonUpixWS7vnXkBanq0Kg33bBgY1zK4klDJ9l1zUSE0h1XAHmib/i8SQ8qHxI3D8Z9sHIuYGqsUtuDfbmz3PSEF5zUGwSMaSKwgyBuGcoAFLqzIjUDOAVo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660ec111-b5d8-4f2f-f582-08d6e3414736
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 07:51:22.5907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: beanhuo@micron.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB5522
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Avri
>
>Signed-off-by: Avri Altman <avri.altman@wdc.com>
Acked-by: Bean Huo <beanhuo@micron.com>

Thanks,
//Bean
