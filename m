Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DEEC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8776320870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s+Yc/gzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbfIEFzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 01:55:33 -0400
Received: from mail-eopbgr680085.outbound.protection.outlook.com ([40.107.68.85]:50375
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbfIEFzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 01:55:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVSqd9rlCBX3dOQ0pL1lEDdwrfLhkCFBDOkZp6Qw7sf/jOnJS+ujtkeGcLDn86I4qnBH58vIg/bxRDDN9KoSr9hUFMUwUeoztZEzdIhjp/6aoyePFYIIKJDYbBcFRbRXQzY3sWvtagEnfCh7GkaMJb3y/xC3dr8QXaClIodELrvPCElAXYSnYRPJ9cLvpKLbk564nwl7PoCWFRfjnfC9tLn4OYKyezGOtiqUfeCqLvk+AtYRTOd++crASgNX5k/ajPrh3YCkpbOFDhFpBMQ/a9PTOQVKIP3uvEKv6DJn4qGm+/tLYJ+U9DVXxc0QzgCNZU5UUU6lDxa990yKfDuBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjDj7eR+o1o/0275Yt+ta1qwWWBxYg60QPpyTSr8hP8=;
 b=QFhyErqu9aQDWVRhUyPbxwbmz8WUF+CMA2JIx1Ri3tYyZCXBG6jJOoeaM7gX61R+zOLFiYfdbqNMXRrduKw6+1cwlV5tarqSylqeiIiGpfLNHLFyv3js1XN0ivCxVF1gCIN/WJT7sC+0w7EUoldcqd3U5QMp+V4y+gJ/H5piUzH7vuUu1lhOE/RYYy908YYIcaN+Loi9kaL8Q0AXn9HQS8O/qj7zxa7C7dfcellkEjkpKxZP10IXGYUIx8dX9JRmvqdiGtpMWn8I4LeLO1RGN7SuSgmbCEywZySdoFG4vGFEOKy47W/yl5bRlku2wi4PihhQZp8jHZv1MWdr0EWx8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjDj7eR+o1o/0275Yt+ta1qwWWBxYg60QPpyTSr8hP8=;
 b=s+Yc/gzrspT+07FKDuHaVC+3T4P2CAMtcUBfMnCf0qP92EUkmObSOdj42l3U2iaAJLjh3nrTmFyR8S/GzyUhQqNlyK7AjAs9JTB3Z4B1+tlDXhOfV++gUIGp3S5YO/itnT/G/jX3fW75n83dGMBsIWMHFbSCGzeQuNcy6QRDfJY=
Received: from DM6PR12MB2908.namprd12.prod.outlook.com (20.179.71.214) by
 DM6PR12MB3658.namprd12.prod.outlook.com (10.255.76.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Thu, 5 Sep 2019 05:55:28 +0000
Received: from DM6PR12MB2908.namprd12.prod.outlook.com
 ([fe80::f47d:6368:ae50:3fbb]) by DM6PR12MB2908.namprd12.prod.outlook.com
 ([fe80::f47d:6368:ae50:3fbb%4]) with mapi id 15.20.2241.014; Thu, 5 Sep 2019
 05:55:28 +0000
From:   "Zhou, David(ChunMing)" <David1.Zhou@amd.com>
To:     zhong jiang <zhongjiang@huawei.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
CC:     "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/amdgpu: Remove two redundant null pointer checks
Thread-Topic: [PATCH v2] drm/amdgpu: Remove two redundant null pointer checks
Thread-Index: AQHVY64seNhdzuLt5ECII87pYAedc6cclaMA
Date:   Thu, 5 Sep 2019 05:55:28 +0000
Message-ID: <bd65192e-baca-19d7-47ec-dd5d0523ad30@amd.com>
References: <1567662552-3583-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1567662552-3583-1-git-send-email-zhongjiang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0213.apcprd02.prod.outlook.com
 (2603:1096:201:20::25) To DM6PR12MB2908.namprd12.prod.outlook.com
 (2603:10b6:5:15f::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David1.Zhou@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df41889e-8915-458e-e1b6-08d731c5a73e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3658;
x-ms-traffictypediagnostic: DM6PR12MB3658:|DM6PR12MB3658:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB36587016B134938AA71FB658B4BB0@DM6PR12MB3658.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(199004)(189003)(2616005)(31686004)(229853002)(476003)(81156014)(11346002)(81166006)(66066001)(36756003)(6486002)(102836004)(316002)(6506007)(386003)(25786009)(14454004)(5660300002)(486006)(26005)(66446008)(446003)(76176011)(66946007)(66556008)(64756008)(66476007)(478600001)(4326008)(3846002)(8936002)(31696002)(7736002)(2906002)(86362001)(6116002)(53936002)(6512007)(305945005)(256004)(186003)(6246003)(6436002)(99286004)(8676002)(2201001)(52116002)(110136005)(71200400001)(2501003)(71190400001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3658;H:DM6PR12MB2908.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1IKCjqT2+dZSKMzIKuL8Sp4qSMSEFK7rYX/tlgZeC4Z5MDUE0+bb7Z8jwO3ARpfBA+0SfnYRwHJgJ9buSSaClYYivALfs5w6C3EtaXzn6spbdWHNnFycuZJNDzuviNdUDNRtxG74ONaFKYQ0P0t5ASnOBf+5ZOAi1Fy8N3yxR/eJiAyNTRBsoXg2T/i5SSCyqEjhq4CiYP6xPA3/lkgWQxsrNmyh5a8z7k/Oy+dH0bI9IwHzoC/37k08LJlJVC5/1jcqMcc6hC8BDYshGi+SPWbR0o8O8E+jI0bvXSKNxrsS+FMNWsaeIAkgA0Mx2DZ3J46lX8NYpscgpPckTCOInZoonzLoSbby+t+xg8FsoUD52oM6x11VA17DcczA/pQHljBR4zqV/Kf/apEuCvrfPLuN5Tr2c31gfh4o7JBZxSU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14DD2F0BBA21A746AB6C2C53181AF2E7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df41889e-8915-458e-e1b6-08d731c5a73e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 05:55:28.1818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHE+r/ZOOzmO4kOj++/7ssTHDJLrPU2eMkLCotL8BBtjsjUydWH/7orRlspz0Dy6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3658
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyMDE5LzkvNSDkuIvljYgxOjQ5LCB6aG9uZyBqaWFuZyB3cm90ZToNCj4gVGhlIGZ1bmN0
aW9ucyAiZGVidWdmc19yZW1vdmUiIGFuZCAia2ZyZWUiIHRvbGVyYXRlIHRoZSBwYXNzaW5nDQo+
IG9mIG51bGwgcG9pbnRlcnMuIEhlbmNlIGl0IGlzIHVubmVjZXNzYXJ5IHRvIGNoZWNrIHN1Y2gg
YXJndW1lbnRzDQo+IGFyb3VuZCB0aGUgY2FsbHMuIFRodXMgcmVtb3ZlIHRoZSBleHRyYSBjb25k
aXRpb24gY2hlY2sgYXQgdHdvIHBsYWNlcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogemhvbmcgamlh
bmcgPHpob25namlhbmdAaHVhd2VpLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENodW5taW5nIFpob3Ug
PGRhdmlkMS56aG91QGFtZC5jb20+DQoNCg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGVidWdmcy5jIHwgNiArKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMNCj4gaW5kZXggNTY1MmNjNy4uY2I5NDYyNyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+IEBA
IC0xMDc3LDggKzEwNzcsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kZWJ1Z2ZzX2liX3ByZWVtcHQo
dm9pZCAqZGF0YSwgdTY0IHZhbCkNCj4gICANCj4gICAJdHRtX2JvX3VubG9ja19kZWxheWVkX3dv
cmtxdWV1ZSgmYWRldi0+bW1hbi5iZGV2LCByZXNjaGVkKTsNCj4gICANCj4gLQlpZiAoZmVuY2Vz
KQ0KPiAtCQlrZnJlZShmZW5jZXMpOw0KPiArCWtmcmVlKGZlbmNlcyk7DQo+ICAgDQo+ICAgCXJl
dHVybiAwOw0KPiAgIH0NCj4gQEAgLTExMDMsOCArMTEwMiw3IEBAIGludCBhbWRncHVfZGVidWdm
c19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIA0KPiAgIHZvaWQgYW1kZ3B1
X2RlYnVnZnNfcHJlZW1wdF9jbGVhbnVwKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAg
IHsNCj4gLQlpZiAoYWRldi0+ZGVidWdmc19wcmVlbXB0KQ0KPiAtCQlkZWJ1Z2ZzX3JlbW92ZShh
ZGV2LT5kZWJ1Z2ZzX3ByZWVtcHQpOw0KPiArCWRlYnVnZnNfcmVtb3ZlKGFkZXYtPmRlYnVnZnNf
cHJlZW1wdCk7DQo+ICAgfQ0KPiAgIA0KPiAgICNlbHNlDQo=
