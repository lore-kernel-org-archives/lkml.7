Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85503CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C07F21906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="xRqqz+vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406311AbfJWOCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 10:02:49 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:17998 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbfJWOCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:02:48 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9NDwgkl019478;
        Wed, 23 Oct 2019 10:02:38 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2059.outbound.protection.outlook.com [104.47.44.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vt9t22md6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 10:02:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWEIUMIyQzgwP/1HvdHki53312irh1kSHET9wekBDiiz9oXTynKLPlKBkalnchtLP9aMASsY9eocFTICLmOIaMVGwwQ3pjhjcpva6ukBEnBn1g8taRnYk//hLkNe71KwQYx4Fz37g72C6aAee8rLImb/og4ewrX31jYMBguFhlSRyfHXdvs49yBAYcWZHmWfrWpLfynNSK15bOJCjqDBju0DdrNaPdWmMV8UrKXahx80cuXaKAatE1fz1B6Tdxw4TbOcamqmYyXTG9ANwe8gKKzDbWqOArumfDxsYd/15dxgfGr4tpveAFWBPVB3LPD/QBbsslIaG2YwbMCZ5fLh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzqalHzmrqYpXfFsIZ3suL0aRGtxgzLQqQ06XnGsf3I=;
 b=Du08SSd+/0HStzT8IUgSFeHbiU1htXfI8y9EPz6Mklc05qwmBvXd88ht+XWLBHiPBbxz6Y1gLNehr3ju2XLrMqBHGOnrCWkXhhSTdVHnEFFELGJoBiMkUmNjhbDYabKurMEuxcIgqvpXuW8e9YxcBh1iWgZQO5PXdnYWx4mddgydwMxWOJJgXkaxeHRtL5mRjF4vcSY7k2pn94n9fE2No9jtw2aUz2npxGQsVt8Pp8QlRK/u5cEepvLXdM5HbQVqSMi58lYiARWmt7a2JiY39VijVBKKqJSxtZGOg4uTjDRSqIgb6erR0Ni3zuyPpNzWY4CWDqrGy1a5/EwBnckrrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzqalHzmrqYpXfFsIZ3suL0aRGtxgzLQqQ06XnGsf3I=;
 b=xRqqz+vmDKq3URrtKfTbzQ7sNXxORg+A727z3aCCkr+u2DfjCbrmmQpOvhoTNkKAWQy5DkVxs+8raaOmqtxcmMljYGccKapqUw0VoB7YDrxXuQuwxkLjsoBbTAKyE03Qxs9TulsLPwNJ12JXZPofHh77V1ZxQsR5NERm8QY2+CM=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5254.namprd03.prod.outlook.com (20.180.4.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Wed, 23 Oct 2019 14:02:30 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2367.022; Wed, 23 Oct 2019
 14:02:30 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>
Subject: =?utf-8?B?W2J1ZyByZXBvcnRdIGNvbXBpbGVyIHdhcm5pbmc6ICBmcy9mMmZzL25vZGUu?=
 =?utf-8?B?YzogSW4gZnVuY3Rpb24g4oCYX19zZXRfbmF0X2NhY2hlX2RpcnR54oCZOiA=?=
 =?utf-8?B?4oCYaGVhZOKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVk?=
Thread-Topic: =?utf-8?B?W2J1ZyByZXBvcnRdIGNvbXBpbGVyIHdhcm5pbmc6ICBmcy9mMmZzL25vZGUu?=
 =?utf-8?B?YzogSW4gZnVuY3Rpb24g4oCYX19zZXRfbmF0X2NhY2hlX2RpcnR54oCZOiA=?=
 =?utf-8?B?4oCYaGVhZOKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVk?=
Thread-Index: AQHViaqCPk0KQeLWIEWJ5KCTuOj7kA==
Date:   Wed, 23 Oct 2019 14:02:30 +0000
Message-ID: <fc71f3b73116115f78bcee2753e7bb3d5331731e.camel@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c82bacef-e9d0-4654-7f59-08d757c1a529
x-ms-traffictypediagnostic: CH2PR03MB5254:
x-microsoft-antispam-prvs: <CH2PR03MB5254FDF69B3FDFB2642355E6F96B0@CH2PR03MB5254.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:120;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(136003)(346002)(396003)(199004)(189003)(186003)(256004)(102836004)(81156014)(6506007)(118296001)(86362001)(81166006)(14454004)(316002)(476003)(486006)(14444005)(26005)(71190400001)(71200400001)(8936002)(25786009)(2616005)(110136005)(54906003)(66066001)(6486002)(64756008)(6436002)(305945005)(76116006)(66476007)(66556008)(6512007)(66446008)(2906002)(66946007)(7736002)(4326008)(99286004)(3846002)(6116002)(36756003)(5660300002)(478600001)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5254;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TN2NPYwMEi8JT2n48ir6Bbxpu+hHBYSyYE8iZs7pW3Q4llgecVzZk2uDp0TGNTj9K3R40qjVct3Io4bhSTPBBgjJc9F+lSQt2GKBvJNniqXRrRmnQ6rd3Qrgp5tDhEIVEEpZkTddyCCcIN2kCsYRVLAv3z2smLvkJpWNqJiA0rFUcOEr9MqaoWAUCJndvNYY150aANMGP+JpfbnM6xEna4hi9X+lN+Upc4PYoq8YRQB4iyeMokaf2zHRvw7rZxqZ/v9gnMZn3zFAWclvRgcQYFVE6eRfLXYhyfby7CnxCEINjx2uCiKQ3hWIQiSot6fstUm/M/pI267nUIvF4FnY3DAEOtyPf6m4bPYI/mQA6lI+R6xQnRMWjh+yrSciMhNOXUBwIJsbDJsJDFjqNKbDL74yRlnWfYimgMN0VT1BV7LHqz0136apBnN7udIaVN5k
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2590B0140D4E6E40807DBB307C0047DE@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82bacef-e9d0-4654-7f59-08d757c1a529
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 14:02:30.5129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qYohvCraT2imIXWOGqKneE5sZhHMxpLryNjCNBbjy7vT71/fxLUnC1XlnxrabJrKLjG8lZdUSvlJBIvy4mYaI4cqRDssHjR5794qna8qYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5254
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-23_03:2019-10-23,2019-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=852 phishscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910230141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2VlbXMgdG8gaGF2ZSBiZWVuIGludHJvZHVjZWQgdmlhOg0KDQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCmNvbW1pdCA3
ODBkZTQ3Y2Y2Y2I1ZjUyNGNkOThlYzhmZmJmZmMzZGE1Njk2ZTE3DQpBdXRob3I6IENoYW8gWXUg
PHl1Y2hhbzBAaHVhd2VpLmNvbT4NCkRhdGU6ICAgVHVlIE1hciAyMCAyMzowODozMCAyMDE4ICsw
ODAwDQoNCiAgICBmMmZzOiBkb24ndCB0cmFjayBuZXcgbmF0IGVudHJ5IGluIG5hdCBzZXQNCiAg
ICANCiAgICBOYXQgZW50cnkgc2V0IGlzIHVzZWQgb25seSBpbiBjaGVja3BvaW50KCksIGFuZCBk
dXJpbmcgY2hlY2twb2ludCgpIHdlDQogICAgd29uJ3QgZmx1c2ggbmV3IG5hdCBlbnRyeSB3aXRo
IHVuYWxsb2NhdGVkIGFkZHJlc3MsIHNvIHdlIGRvbid0IG5lZWQgdG8NCiAgICBhZGQgbmV3IG5h
dCBlbnRyeSBpbnRvIG5hdCBzZXQsIHRoZW4gbmF0X2VudHJ5X3NldDo6ZW50cnlfY250IGNhbg0K
ICAgIGluZGljYXRlIGFjdHVhbCBlbnRyeSBjb3VudCB3ZSBuZWVkIHRvIGZsdXNoIGluIGNoZWNr
cG9pbnQoKS4NCiAgICANCiAgICBTaWduZWQtb2ZmLWJ5OiBZdW5sZWkgSGUgPGhleXVubGVpQGh1
YXdlaS5jb20+DQogICAgU2lnbmVkLW9mZi1ieTogQ2hhbyBZdSA8eXVjaGFvMEBodWF3ZWkuY29t
Pg0KICAgIFNpZ25lZC1vZmYtYnk6IEphZWdldWsgS2ltIDxqYWVnZXVrQGtlcm5lbC5vcmc+DQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQoNCkNvbXBpbGVyIHdhcm5pbmcgaXM6DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCiAgQ0MgICAgICBmcy9m
MmZzL25vZGUubw0KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4vaW5jbHVkZS9saW51eC93YWl0Lmg6
NzowLA0KICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC93YWl0X2JpdC5oOjgs
DQogICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L2ZzLmg6NiwNCiAgICAgICAg
ICAgICAgICAgZnJvbSBmcy9mMmZzL25vZGUuYzoxMToNCmZzL2YyZnMvbm9kZS5jOiBJbiBmdW5j
dGlvbiDigJhfX3NldF9uYXRfY2FjaGVfZGlydHnigJk6DQouL2luY2x1ZGUvbGludXgvbGlzdC5o
OjYzOjEzOiBlcnJvcjog4oCYaGVhZOKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluDQp0
aGlzIGZ1bmN0aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdDQogIG5leHQtPnByZXYg
PSBuZXc7DQogICAgICAgICAgICAgXg0KZnMvZjJmcy9ub2RlLmM6MjM4OjI0OiBub3RlOiDigJho
ZWFk4oCZIHdhcyBkZWNsYXJlZCBoZXJlDQogIHN0cnVjdCBuYXRfZW50cnlfc2V0ICpoZWFkOw0K
ICAgICAgICAgICAgICAgICAgICAgICAgXg0KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRl
ZCBhcyBlcnJvcnMNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KVGhhbmtzDQpBbGV4DQo=
