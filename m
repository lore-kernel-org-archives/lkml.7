Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE37EC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA4421479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="n53KoT2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437240AbfIJRxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:53:50 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:63144 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729580AbfIJRxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:53:50 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8AHgRFc019527;
        Tue, 10 Sep 2019 10:53:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=yxpt4wSksH5olSs3rpHiE/nhuJHRgHL5NBo/TkrT4UA=;
 b=n53KoT2LjM8a6wlFnHt1coscpvQnCBONWEXCiMtpQNsC9LUA2hZ2zMXEPOHL/gj8lrPl
 o+7dSM9+l/Bne8bG1STL2Y8idt9ENHvpMHnGZ6PyfE+7CcVi6x8rx3WbQ0uF6VLXhAF3
 0V9TRN9BSNQACAC/X1OhdIrVtCa5d5huFyGylDphRFrK0fQo/WKc9pv1O5JtEQSUNLCd
 yPX0Y1SPxVJ0+mVXNROqQ0meowEhyRudLooMeQnV6tJr+4h/xOIcLgud3AZfoSgoRFYo
 4wfRl6JpJtMzp3/Ot1tb66u1thyScuSvH5vFINafFLU6a1yPj/6Ksz9MV1x0RqLvDcnm lw== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2056.outbound.protection.outlook.com [104.47.46.56])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2uva386ena-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 10:53:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlSUPlYve3D1QYxPIntpNmT+/qPmNXs0FTVJoRtGJzAZQ0j94KL0aY2Tg6MDjOdClEia51eVDKW86+8o6qGcNNa55g1yZWoaKOyWGBYY2EJ8youWNVYNruXs6ZdrJfvK1dUA2Kxu7WVxx5GZNIqd2HcjicdplWpUnClhE5uKHLHvjfq9+i0pdthJvexSZB5R6cJ219VAvLs5gJAMzBrzHtNuBLqeBfWlYIJSL9QnF9/cX5F7MB1JWqp5HfsCkOQSp0/YUoY34ffEO0YP65cHNvntf/4PwhG4opBrXlTjJ8VASLJi1r2ce8s6IP7WHKse9qNr4fMBKSmg3SnpwbHMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxpt4wSksH5olSs3rpHiE/nhuJHRgHL5NBo/TkrT4UA=;
 b=KNoAhxj99BWfgtF0HbTQygXEj/UgGPEoBVA9tonEPqnHksCrGIP0MFYzkMhyS29CPThI2ZKCygQMxNb4qFoZl80yaYtSPHvZnmI22Y0r+G7vNlH/7HSdpejPPnVcOk9JihwNxCTMxdTJmHji9zugZEpupgIJp9EdfyT32ViLB9QqvJEshE9hth5WacUlnwdRaqzuiGBfDkhr5e1qyDzmk1Gl3/krmoV+YOqGo2JYPjvkVNdz7E4LihhWZFS8O+ucD1s/xV2aaWArJ+s7LNyysBjnfZKAGv8LnJpM5tb6MHEFlC9ahUx3B5A8y0icTlfm+I7VHbDgh5aLX9851eeZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB3634.namprd02.prod.outlook.com (52.132.27.154) by
 BL0PR02MB4675.namprd02.prod.outlook.com (20.177.144.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Tue, 10 Sep 2019 17:53:44 +0000
Received: from BL0PR02MB3634.namprd02.prod.outlook.com
 ([fe80::fd1a:595d:b861:1f55]) by BL0PR02MB3634.namprd02.prod.outlook.com
 ([fe80::fd1a:595d:b861:1f55%7]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 17:53:44 +0000
From:   Matej Genci <matej.genci@nutanix.com>
To:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matej Genci <matej.genci@nutanix.com>
Subject: [PATCH v2] virtio: add VIRTIO_RING_NO_LEGACY
Thread-Topic: [PATCH v2] virtio: add VIRTIO_RING_NO_LEGACY
Thread-Index: AQHVaACwxB3GFSwoAkODWIsoL6vcSw==
Date:   Tue, 10 Sep 2019 17:53:44 +0000
Message-ID: <20190910175335.231660-1-matej.genci@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::17) To BL0PR02MB3634.namprd02.prod.outlook.com
 (2603:10b6:207:3e::26)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [192.146.154.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7ec82eb-e0b0-475c-9411-08d73617d2c4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR02MB4675;
x-ms-traffictypediagnostic: BL0PR02MB4675:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR02MB467534BD65CDEE9239B3BB6AFBB60@BL0PR02MB4675.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(136003)(376002)(39860400002)(189003)(199004)(66446008)(14454004)(2201001)(66556008)(52116002)(386003)(256004)(6506007)(8676002)(44832011)(486006)(2501003)(50226002)(8936002)(53936002)(66946007)(107886003)(2616005)(476003)(6512007)(3846002)(6116002)(66476007)(71190400001)(71200400001)(4326008)(316002)(36756003)(478600001)(102836004)(5660300002)(86362001)(81166006)(81156014)(186003)(305945005)(64756008)(26005)(25786009)(2906002)(66066001)(99286004)(1076003)(6436002)(110136005)(7736002)(6486002)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR02MB4675;H:BL0PR02MB3634.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hPCV1ZHGrqEOystCOorL+++6SNqGZfs+9Nn2lVgCG6BEU0cADzz6HELtutbFOBpHqRx7vJXrmVpehBrWxt6apT2U7UtSDCLr23rusmGfvGY3Nr4TAbTuY0FbdWH4D8fCzckq58UIZGSyDnesIZQiava6UoDggB1k5HXBBH+58TQX4JMhmob+ev0ISY+rFpCSFDMK96ea/JxqWeX3wFh+aCAdY+gQycaSrx0BrZ/dww3GGcybN61U7FvfxsejCD1JPa9FU3NI3vJd6/vG/j8y0IJor2zap2GA8YXEqMKkRJ0CwknRa2mC8e7vvl5qNM54fCLWhpVEjb1kijlu1fs9JSu346IIdwMbkA/e55PvPm4DFKcsCzcnupLktFzYafQfPCwY8XdWlvkdE3X9hxDbQIKledL+zQOfgrsT8RVjHJQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ec82eb-e0b0-475c-9411-08d73617d2c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 17:53:44.6479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSy/fqH0iiG3mduYP4TdeGP53l/wtPgrcX03bt2MrNdTBBuBjrzZEKZVft4OWrsbFReLT5B7XqyzEJtOie4ViA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4675
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_11:2019-09-10,2019-09-10 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG1hY3JvIHRvIGRpc2FibGUgbGVnYWN5IGZ1bmN0aW9ucyB2cmluZ19pbml0IGFuZCB2cmlu
Z19zaXplLg0KDQpTaWduZWQtb2ZmLWJ5OiBNYXRlaiBHZW5jaSA8bWF0ZWouZ2VuY2lAbnV0YW5p
eC5jb20+DQotLS0NCg0KVjI6IFB1dCBhbGwgbGVnYWN5IEFQSXMgaW5zaWRlIGd1YXJkcy4NCg0K
LS0tDQogaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19yaW5nLmggfCA4ICsrKysrKysrDQogMSBm
aWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBp
L2xpbnV4L3ZpcnRpb19yaW5nLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3JpbmcuaA0K
aW5kZXggNGM0ZTI0YzI5MWE1Li5lZmU1YTQyMWI0ZWEgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL3Vh
cGkvbGludXgvdmlydGlvX3JpbmcuaA0KKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19y
aW5nLmgNCkBAIC0xMTgsNiArMTE4LDggQEAgc3RydWN0IHZyaW5nX3VzZWQgew0KIAlzdHJ1Y3Qg
dnJpbmdfdXNlZF9lbGVtIHJpbmdbXTsNCiB9Ow0KIA0KKyNpZm5kZWYgVklSVElPX1JJTkdfTk9f
TEVHQUNZDQorDQogc3RydWN0IHZyaW5nIHsNCiAJdW5zaWduZWQgaW50IG51bTsNCiANCkBAIC0x
MjgsNiArMTMwLDggQEAgc3RydWN0IHZyaW5nIHsNCiAJc3RydWN0IHZyaW5nX3VzZWQgKnVzZWQ7
DQogfTsNCiANCisjZW5kaWYgLyogVklSVElPX1JJTkdfTk9fTEVHQUNZICovDQorDQogLyogQWxp
Z25tZW50IHJlcXVpcmVtZW50cyBmb3IgdnJpbmcgZWxlbWVudHMuDQogICogV2hlbiB1c2luZyBw
cmUtdmlydGlvIDEuMCBsYXlvdXQsIHRoZXNlIGZhbGwgb3V0IG5hdHVyYWxseS4NCiAgKi8NCkBA
IC0xMzUsNiArMTM5LDggQEAgc3RydWN0IHZyaW5nIHsNCiAjZGVmaW5lIFZSSU5HX1VTRURfQUxJ
R05fU0laRSA0DQogI2RlZmluZSBWUklOR19ERVNDX0FMSUdOX1NJWkUgMTYNCiANCisjaWZuZGVm
IFZJUlRJT19SSU5HX05PX0xFR0FDWQ0KKw0KIC8qIFRoZSBzdGFuZGFyZCBsYXlvdXQgZm9yIHRo
ZSByaW5nIGlzIGEgY29udGludW91cyBjaHVuayBvZiBtZW1vcnkgd2hpY2ggbG9va3MNCiAgKiBs
aWtlIHRoaXMuICBXZSBhc3N1bWUgbnVtIGlzIGEgcG93ZXIgb2YgMi4NCiAgKg0KQEAgLTE5NSw2
ICsyMDEsOCBAQCBzdGF0aWMgaW5saW5lIGludCB2cmluZ19uZWVkX2V2ZW50KF9fdTE2IGV2ZW50
X2lkeCwgX191MTYgbmV3X2lkeCwgX191MTYgb2xkKQ0KIAlyZXR1cm4gKF9fdTE2KShuZXdfaWR4
IC0gZXZlbnRfaWR4IC0gMSkgPCAoX191MTYpKG5ld19pZHggLSBvbGQpOw0KIH0NCiANCisjZW5k
aWYgLyogVklSVElPX1JJTkdfTk9fTEVHQUNZICovDQorDQogc3RydWN0IHZyaW5nX3BhY2tlZF9k
ZXNjX2V2ZW50IHsNCiAJLyogRGVzY3JpcHRvciBSaW5nIENoYW5nZSBFdmVudCBPZmZzZXQvV3Jh
cCBDb3VudGVyLiAqLw0KIAlfX2xlMTYgb2ZmX3dyYXA7DQotLSANCjIuMjIuMA0KDQo=
