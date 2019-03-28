Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0C3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658752075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cqOU7Y3O";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="IMM+PHUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfC1Fxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 01:53:32 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:39708 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbfC1Fxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 01:53:31 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2S5nnf4014546;
        Wed, 27 Mar 2019 22:53:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=fvSa0BqjY6V2PBnPW0sW8ETSPHbDNf+5u4BwfLNcf+E=;
 b=cqOU7Y3OEu8HWh8CLK4HfNigykFz4ZwZdwdtaPiAbbHBk1PapfiYC4Sn/LPD6M3IFLsJ
 o5WbwmJrZ/On0MBg+r28fWQkIljY59wcxiMxo8ikSMjeTJ1yIYKPnrgfl7CGQV7/8IJS
 ji9ehPQA7NTQT5kMxS5OtQKIXZ57fnR0/bVPuHBVWYrhUPW3W3xiKfavSKDibl7rdUL6
 SkGlm6zZtloW7vOQdpn9AwCJdIc6uUTMLGf9e2s09FS1KzDPphu7fIprBOBlf4zblQHV
 vIgKuvaMWU7XyzkaD3xlSzSbY0Xueyo0/yG0pYGLDN4yukJIqdhhOgSntnVJmMsZLGKR YA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2rgr9fr0uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Mar 2019 22:53:28 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 27 Mar
 2019 22:53:21 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.59) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 27 Mar 2019 22:53:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvSa0BqjY6V2PBnPW0sW8ETSPHbDNf+5u4BwfLNcf+E=;
 b=IMM+PHUDzqdGLO7SI8c9y99aW2fs2wlun5BZVvLDQaoMI+yKAba2CCBg0HP45Bh2vwDJdVjNgp+ZUDgGjCQoa05mWAVLk1yecd4LmLarjPyfyM7u9ajPyBmpGG3zaeoMFtXntf8okh591HqxNntctxnxBVr0HV614idla1FSJZ4=
Received: from BYAPR18MB2485.namprd18.prod.outlook.com (20.179.92.143) by
 BYAPR18MB2902.namprd18.prod.outlook.com (20.179.58.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Thu, 28 Mar 2019 05:53:15 +0000
Received: from BYAPR18MB2485.namprd18.prod.outlook.com
 ([fe80::2d57:671d:82c7:14e0]) by BYAPR18MB2485.namprd18.prod.outlook.com
 ([fe80::2d57:671d:82c7:14e0%4]) with mapi id 15.20.1730.019; Thu, 28 Mar 2019
 05:53:15 +0000
From:   Manish Rangankar <mrangankar@marvell.com>
To:     Colin King <colin.king@canonical.com>,
        "QLogic-Storage-Upstream@cavium.com" 
        <QLogic-Storage-Upstream@cavium.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: qedi: remove declaration of nvm_image from stack
Thread-Topic: [PATCH] scsi: qedi: remove declaration of nvm_image from stack
Thread-Index: AQHU5MiGMiYnk6lOEkq9sKMvSMXYq6Ygizxg
Date:   Thu, 28 Mar 2019 05:53:15 +0000
Message-ID: <BYAPR18MB2485E6EE1193DE82178C05A3D8590@BYAPR18MB2485.namprd18.prod.outlook.com>
References: <20190327181103.15677-1-colin.king@canonical.com>
In-Reply-To: <20190327181103.15677-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d9c5e1f-ffde-48e7-a5fd-08d6b341abe3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR18MB2902;
x-ms-traffictypediagnostic: BYAPR18MB2902:
x-microsoft-antispam-prvs: <BYAPR18MB290264FAC0C21A36C804E7F2D8590@BYAPR18MB2902.namprd18.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(39850400004)(396003)(376002)(189003)(13464003)(199004)(71190400001)(486006)(14444005)(8936002)(99286004)(316002)(14454004)(6116002)(54906003)(110136005)(33656002)(66066001)(71200400001)(68736007)(2501003)(256004)(81156014)(3846002)(478600001)(9686003)(8676002)(229853002)(81166006)(97736004)(6436002)(7696005)(4326008)(6506007)(76176011)(2906002)(53546011)(74316002)(26005)(5660300002)(25786009)(305945005)(106356001)(53936002)(476003)(105586002)(52536014)(86362001)(11346002)(446003)(186003)(55016002)(7736002)(6246003)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR18MB2902;H:BYAPR18MB2485.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oV7wSMxFd6mxIa+hL1xugTq2QYrVLWdUv3tu7//kHc/KQ2kR+9fdq4eh2OFJopqPKPwtiN+81pZgbbJ55XVgDx9eB8XACMFj24XtdG0c7FOwm4WumKDdiHoN6cQ/r1QiGWLH4F2k+bZnOeTKsmG5/l6ZQZLgATnWFi8yT2Ir3nBUQwGrSMJbMavy0CLFU9++6zg1J6MRDD4K284iPc9cFmUXFizPYhdcj8hts4QqBkW4tbD3NJgss979DucQAKJTcV4H7VetQeZrrPQpfgM6rjrSUzsm/ngMfIgcqAROcVDGeDmrYuGH7z6EJMGpT+jB9KjgfOYYryiFH8vcsrH3wKMwwJsdIEpo7ZV+RB0Tv+defqFiCzOsYMSpHZvESZz6jPNCXzOL+SQYm1kVRr6NZkzP6tye4D6WQao1RxiNspY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9c5e1f-ffde-48e7-a5fd-08d6b341abe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 05:53:15.5641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2902
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENvbGluIEtpbmcgPGNvbGlu
LmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAyNywgMjAxOSAx
MTo0MSBQTQ0KPiBUbzogUUxvZ2ljLVN0b3JhZ2UtVXBzdHJlYW1AY2F2aXVtLmNvbTsgSmFtZXMg
RSAuIEogLiBCb3R0b21sZXkNCj4gPGplamJAbGludXguaWJtLmNvbT47IE1hcnRpbiBLIC4gUGV0
ZXJzZW4gPG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tPjsNCj4gbGludXgtc2NzaUB2Z2VyLmtl
cm5lbC5vcmcNCj4gQ2M6IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBzY3NpOiBxZWRpOiByZW1v
dmUgZGVjbGFyYXRpb24gb2YgbnZtX2ltYWdlIGZyb20gc3RhY2sNCj4gDQo+IEZyb206IENvbGlu
IElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IA0KPiBUaGUgbnZtX2ltYWdl
IGlzIGEgbGFyZ2Ugc3RydWN0IHFlZGlfbnZtX2lzY3NpX2ltYWdlIG9iamVjdCBvZiBvdmVyIDI0
Sw0KPiBzbyBkb24ndCBkZWNsYXJlIGl0IG9uIHRoZSBzdGFjayBqdXN0IGZvciBhIHNpemVvZiBy
ZXF1aXJlbWVudDsgdXNlIHNpemVvZiBvbg0KPiBzdHJ1Y3QgcWVkaV9udm1faXNjc2lfaW1hZ2Ug
aW5zdGVhZC4NCj4gDQo+IEZpeGVzOiBjNzdhMmZhM2ZmOGYgKCJzY3NpOiBxZWRpOiBBZGQgdGhl
IENSQyBzaXplIHdpdGhpbiBpU0NTSSBOVk0gaW1hZ2UiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xp
biBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
c2NzaS9xZWRpL3FlZGlfbWFpbi5jIHwgNyArKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
c2NzaS9xZWRpL3FlZGlfbWFpbi5jIGIvZHJpdmVycy9zY3NpL3FlZGkvcWVkaV9tYWluLmMNCj4g
aW5kZXggZTc0YTYyNDQ4YmE0Li5lNWRiOWE5OTU0ZGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
c2NzaS9xZWRpL3FlZGlfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvc2NzaS9xZWRpL3FlZGlfbWFp
bi5jDQo+IEBAIC0xMzkyLDEwICsxMzkyLDggQEAgc3RhdGljIHZvaWQgcWVkaV9mcmVlX252bV9p
c2NzaV9jZmcoc3RydWN0DQo+IHFlZGlfY3R4ICpxZWRpKQ0KPiANCj4gIHN0YXRpYyBpbnQgcWVk
aV9hbGxvY19udm1faXNjc2lfY2ZnKHN0cnVjdCBxZWRpX2N0eCAqcWVkaSkgIHsNCj4gLQlzdHJ1
Y3QgcWVkaV9udm1faXNjc2lfaW1hZ2UgbnZtX2ltYWdlOw0KPiAtDQo+ICAJcWVkaS0+aXNjc2lf
aW1hZ2UgPSBkbWFfYWxsb2NfY29oZXJlbnQoJnFlZGktPnBkZXYtPmRldiwNCj4gLQkJCQkJICAg
ICAgIHNpemVvZihudm1faW1hZ2UpLA0KPiArCQkJCQkgICAgICAgc2l6ZW9mKHN0cnVjdA0KPiBx
ZWRpX252bV9pc2NzaV9pbWFnZSksDQo+ICAJCQkJCSAgICAgICAmcWVkaS0+bnZtX2J1Zl9kbWEs
DQo+IEdGUF9LRVJORUwpOw0KPiAgCWlmICghcWVkaS0+aXNjc2lfaW1hZ2UpIHsNCj4gIAkJUUVE
SV9FUlIoJnFlZGktPmRiZ19jdHgsICJDb3VsZCBub3QgYWxsb2NhdGUgTlZNDQo+IEJVRi5cbiIp
OyBAQCAtMjIzNiwxNCArMjIzNCwxMyBAQCBzdGF0aWMgdm9pZCBxZWRpX2Jvb3RfcmVsZWFzZSh2
b2lkDQo+ICpkYXRhKSAgc3RhdGljIGludCBxZWRpX2dldF9ib290X2luZm8oc3RydWN0IHFlZGlf
Y3R4ICpxZWRpKSAgew0KPiAgCWludCByZXQgPSAxOw0KPiAtCXN0cnVjdCBxZWRpX252bV9pc2Nz
aV9pbWFnZSBudm1faW1hZ2U7DQo+IA0KPiAgCVFFRElfSU5GTygmcWVkaS0+ZGJnX2N0eCwgUUVE
SV9MT0dfSU5GTywNCj4gIAkJICAiR2V0IE5WTSBpU0NTSSBDRkcgaW1hZ2VcbiIpOw0KPiAgCXJl
dCA9IHFlZGlfb3BzLT5jb21tb24tPm52bV9nZXRfaW1hZ2UocWVkaS0+Y2RldiwNCj4gIAkJCQkJ
ICAgICAgUUVEX05WTV9JTUFHRV9JU0NTSV9DRkcsDQo+ICAJCQkJCSAgICAgIChjaGFyICopcWVk
aS0+aXNjc2lfaW1hZ2UsDQo+IC0JCQkJCSAgICAgIHNpemVvZihudm1faW1hZ2UpKTsNCj4gKwkJ
CQkJICAgICAgc2l6ZW9mKHN0cnVjdA0KPiBxZWRpX252bV9pc2NzaV9pbWFnZSkpOw0KPiAgCWlm
IChyZXQpDQo+ICAJCVFFRElfRVJSKCZxZWRpLT5kYmdfY3R4LA0KPiAgCQkJICJDb3VsZCBub3Qg
Z2V0IE5WTSBpbWFnZS4gcmV0ID0gJWRcbiIsIHJldCk7DQo+IC0tDQo+IDIuMjAuMQ0KDQpUaGFu
a3MsDQpBY2tlZC1ieTogTWFuaXNoIFJhbmdhbmthciA8bXJhbmdhbmthckBtYXJ2ZWxsLmNvbT4N
Cg==
