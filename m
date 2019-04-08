Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0E6C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF7121874
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LuhhzYys";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="TNkcEIWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfDHPsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:48:21 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:58738 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725983AbfDHPsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:48:20 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x38Fk7FK025392;
        Mon, 8 Apr 2019 08:48:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=GX7tJgCM+bnHQJJmfOUjTkyz1zbCfSip5e29F2OFvdg=;
 b=LuhhzYys2g8TE3wCfjOuyggHPVrdLGwI3MxAdov2Wf2OtD+8/HkKBD+1hGYWKCVHWE9G
 e/VeeihmbGPT3O101QzyM5fhwpH/xsZW/6KD2v+FzAwQ+4dQBUQEHTkMFZ9yPQ63L6Ar
 48Iz2G4TmZ7NZT/J03qmymS+ccozbSfs9h6p2UVnTB8G1HHywK1CAEJ9L8lAL1sDIQZS
 0ZNvkHfCOQ9AFGbjAUtu8wky4xI0mybquK8l8loFzaeaJsb8Z9qZw/SETZmFX8dG/Cjz
 7aP3ZJUf5bt7E/sO3o6+NFuK/Kpyu4gc5BAUDEybQNrBJOE9s24u9LkzEVubZgVaG4kz tw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2rqdy0mp8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 08 Apr 2019 08:48:14 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 8 Apr
 2019 08:48:11 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.57) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 8 Apr 2019 08:48:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GX7tJgCM+bnHQJJmfOUjTkyz1zbCfSip5e29F2OFvdg=;
 b=TNkcEIWUbgE4r6gFd1vVplrDB0WNI/yFIZhi2kwK4YZcgCOrKyfWBZADa5htXn6M6Ebe3TQ8b9g78fA+jbaeQ1edN7L/G+PwzcdDA614mBzZcVpdLuqcPYCEwPFXaCiJu+BzhWNI3UY3PUd68FA/yUmsXfj6cj0CQjhPMTMUZSk=
Received: from MN2PR18MB2719.namprd18.prod.outlook.com (20.178.255.156) by
 MN2PR18MB2782.namprd18.prod.outlook.com (20.179.21.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 15:48:07 +0000
Received: from MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::fcf8:e2cb:431f:2608]) by MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::fcf8:e2cb:431f:2608%5]) with mapi id 15.20.1771.021; Mon, 8 Apr 2019
 15:48:07 +0000
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     Colin King <colin.king@canonical.com>,
        "qla2xxx-upstream@qlogic.com" <qla2xxx-upstream@qlogic.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] scsi: qla2xxx: fix spelling mistake "alredy" ->
 "already"
Thread-Topic: [PATCH][next] scsi: qla2xxx: fix spelling mistake "alredy" ->
 "already"
Thread-Index: AQHU7ePry6/Bs8mA3kepiOtTRvbxK6Yx88kA
Date:   Mon, 8 Apr 2019 15:48:07 +0000
Message-ID: <C4F6CCA0-D11F-4436-85F6-F1538682B28A@marvell.com>
References: <20190408082014.1354-1-colin.king@canonical.com>
In-Reply-To: <20190408082014.1354-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe76374d-06ee-4989-b6f5-08d6bc39983c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR18MB2782;
x-ms-traffictypediagnostic: MN2PR18MB2782:
x-microsoft-antispam-prvs: <MN2PR18MB27822FABC3A7670226AF9A9BD62C0@MN2PR18MB2782.namprd18.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39850400004)(136003)(396003)(376002)(51914003)(199004)(189003)(26005)(486006)(446003)(6512007)(478600001)(11346002)(256004)(186003)(14444005)(25786009)(99286004)(4326008)(76176011)(2616005)(82746002)(102836004)(6246003)(6506007)(476003)(5660300002)(2501003)(3846002)(53936002)(229853002)(36756003)(54906003)(6486002)(110136005)(105586002)(6436002)(97736004)(86362001)(33656002)(316002)(106356001)(81156014)(81166006)(68736007)(71200400001)(71190400001)(14454004)(8936002)(7736002)(305945005)(83716004)(4744005)(8676002)(6116002)(66066001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2782;H:MN2PR18MB2719.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mRSUh3PVLPuFwIu4uVN12ybwXHYpQijNAVG4Fxo4IBXtX0YzxFSblR0KqfHzz2pZsUWQuCJseNQbVfpaK3drChsyW1NzQozHQ98RMsGUYMGPc9nMfOvFc8C8TR44JJTT7hfj6lN5Q76cl56qQU0G4clNFimraIAw9qaQO2dJArmgrR9T9yGuMZkyU/kE5m//V/GyI/4AtXJMZDaY2szkYvu70O/XpBi3CUhWXgHv9sjN2q4ELY6PJXVK0AhTj3kfOozVzgKLxwx51hnHDNH3DmK6vtMwai1nKBdHEjk1owSN8ZSWvusTv29V0saGrP334zR+6o5dJSEpX5UOTRqIfXNiVapDY8gM5a6mh9Xk9HVFs3lAZ3FyHstHZbbi34kTHDkh6j5zHOzMDeiIZZ7oqct9b/tTXMy+I6AKhuNeiRI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF8C31E1E4B39D4EAF46EFA07955C2B7@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fe76374d-06ee-4989-b6f5-08d6bc39983c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 15:48:07.1756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2782
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29saW4sDQoNCu+7v09uIDQvOC8xOSwgMToyMCBBTSwgImxpbnV4LXNjc2ktb3duZXJAdmdl
ci5rZXJuZWwub3JnIG9uIGJlaGFsZiBvZiBDb2xpbiBLaW5nIiA8bGludXgtc2NzaS1vd25lckB2
Z2VyLmtlcm5lbC5vcmcgb24gYmVoYWxmIG9mIGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4gd3Jv
dGU6DQoNCiAgICBGcm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29t
Pg0KICAgIA0KICAgIFRoZXJlIGlzIGEgc3BlbGxpbmcgbWlzdGFrZSBpbiBhIHFsX2xvZyBtZXNz
YWdlLiBGaXggaXQuDQogICAgDQogICAgU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNv
bGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCiAgICAtLS0NCiAgICAgZHJpdmVycy9zY3NpL3FsYTJ4
eHgvcWxhX252bWUuYyB8IDIgKy0NCiAgICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQogICAgDQogICAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9xbGEy
eHh4L3FsYV9udm1lLmMgYi9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfbnZtZS5jDQogICAgaW5k
ZXggMWNhNjNlODBhN2ZlLi4zYTYxNjBjYTliNGEgMTAwNjQ0DQogICAgLS0tIGEvZHJpdmVycy9z
Y3NpL3FsYTJ4eHgvcWxhX252bWUuYw0KICAgICsrKyBiL2RyaXZlcnMvc2NzaS9xbGEyeHh4L3Fs
YV9udm1lLmMNCiAgICBAQCAtMjA1LDcgKzIwNSw3IEBAIHN0YXRpYyB2b2lkIHFsYV9udm1lX2Fi
b3J0X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KICAgICAJaWYgKGF0b21pY19yZWFk
KCZzcC0+cmVmX2NvdW50KSA9PSAwKSB7DQogICAgIAkJV0FSTl9PTigxKTsNCiAgICAgCQlxbF9s
b2cocWxfbG9nX2luZm8sIGZjcG9ydC0+dmhhLCAweGZmZmYsDQogICAgLQkJCSIlczogY29tbWFu
ZCBhbHJlZHkgYWJvcnRlZCBvbiBzcDogJXBcbiIsDQogICAgKwkJCSIlczogY29tbWFuZCBhbHJl
YWR5IGFib3J0ZWQgb24gc3A6ICVwXG4iLA0KICAgICAJCQlfX2Z1bmNfXywgc3ApOw0KICAgICAJ
CXJldHVybjsNCiAgICAgCX0NCiAgICAtLSANCiAgICAyLjIwLjENCiAgICANCiBUaGFua3MgZm9y
IHRoZSBwYXRjaC4NCg0KQWNrZWQtYnk6IEhpbWFuc2h1IE1hZGhhbmkgPGhtYWRoYW5pQG1hcnZl
bGwuY29tPg0KDQo=
