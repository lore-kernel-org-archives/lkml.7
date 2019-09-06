Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4366C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00BE214DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="FpggqRae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392702AbfIFMmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:42:23 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:53882 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392678AbfIFMmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:42:23 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x86CdekG006664;
        Fri, 6 Sep 2019 05:42:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=xzdn5PowwuIfOiQSv7HY+mfsvdd9sRq9l5Ub8EY57tk=;
 b=FpggqRaeDYnylFPosGRydQH9PcF2CEjBPL0zKrmTkxwgKzsPnD5bzrp9ie8ooWAEgPHI
 /L+n+MOW3FK7kXeWugGd9lOKDlKsTpOn/GtPTOjGIMJFoBAOrKauHVqWfhatMn/yc7EG
 Az89HSZhnCJ+C/Gjq7AhjvAB3MGgwPY6su8ItthV9rAZFOAHlOsXGJUfl89DanA5tI/e
 ouX+5rkqcfY3K4Gy3+5PVJ688sKpLAjxPY2tnab71TFqi+RO8igYmVLMLHJagE4v6DRq
 R2LzsTdfy71BfEPRmtVVbqTKfG0IBozeSjAsw57zfB/OpWY3DkvoCDSmAhpa7Y073x8B 9w== 
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2053.outbound.protection.outlook.com [104.47.48.53])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2uqrdyv70c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Sep 2019 05:42:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZFUCOeQ+kiZAFzjH3cUq5kTWkPoNFLGZF0GSuqekfDimWmd6bQ9mlUba3ZskHRrWiRzhFouL0m+PXo0plKyBk7Yp7+dVckfUiqgSn6jocvtG5jAkSHU28nX9Txslz8ABeeNkRgnWUyAMrj3DDnwHFBI/O3J/dUD1QKRaJqbzAzTy1LcA0WSK9Bke82mMBzurxf9SqYQMPOGFqnhXPxYvVTa8wIQ5mBrUpVwSklhBp5e5mIXfBnz0U0mxD7lYjIECxbMlesYpU0Cx47t71Ywl3EaUKb31LZ+VHbXepLRMReFwWCHqyq83HX0B6uTl7CE72dINj6ZPxU1NRLLCkY6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzdn5PowwuIfOiQSv7HY+mfsvdd9sRq9l5Ub8EY57tk=;
 b=BcdRPQG4P2rnzAy2U3dFU5/9wbz0j/1kAmf/2lJLQTrLHzFRr0MT1Cv9frPNPVC+twwvDk5JbQgTL4RWRNMF3vTb7pJHXpJex27BbRmWAjIpIBriuoKPXnbu+DjJB86Dml3LfhRpDA+vxRyKq2NVhJWmVS/5venIlg2KmjlgFRLtR0dkXs65NL4X0SaSXbfHmM1HpjI/IFXJPYN62mk/UdsO/z/GT9vqaNNT8DMVGwmGFfF6+pDNr9MQHkDziM95cKz47LxQYFwhmhaUHZtLFvQ1m3D+WwZsJwjfYXZc3DmJz16YKYGILil4+bTHPtnW/409WHhKOz35WuqjuI0UQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB3634.namprd02.prod.outlook.com (52.132.27.154) by
 BL0PR02MB3794.namprd02.prod.outlook.com (52.132.10.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Fri, 6 Sep 2019 12:42:15 +0000
Received: from BL0PR02MB3634.namprd02.prod.outlook.com
 ([fe80::fd1a:595d:b861:1f55]) by BL0PR02MB3634.namprd02.prod.outlook.com
 ([fe80::fd1a:595d:b861:1f55%7]) with mapi id 15.20.2220.021; Fri, 6 Sep 2019
 12:42:14 +0000
From:   Matej Genci <matej.genci@nutanix.com>
To:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matej Genci <matej.genci@nutanix.com>
Subject: [PATCH] virtio: add VIRTIO_RING_NO_LEGACY
Thread-Topic: [PATCH] virtio: add VIRTIO_RING_NO_LEGACY
Thread-Index: AQHVZLCCqOLYoC0fKkmB5tdY1UqETA==
Date:   Fri, 6 Sep 2019 12:42:14 +0000
Message-ID: <20190906124130.129870-1-matej.genci@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::39) To BL0PR02MB3634.namprd02.prod.outlook.com
 (2603:10b6:207:3e::26)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [192.146.154.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dee8d3c9-d8e7-41e0-03f6-08d732c7a50a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BL0PR02MB3794;
x-ms-traffictypediagnostic: BL0PR02MB3794:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR02MB3794895A266C4C9A74B2037EFBBA0@BL0PR02MB3794.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(136003)(366004)(396003)(189003)(199004)(110136005)(316002)(2501003)(86362001)(66066001)(2201001)(26005)(7736002)(305945005)(256004)(186003)(478600001)(4326008)(25786009)(14454004)(8936002)(8676002)(81156014)(81166006)(6506007)(386003)(50226002)(102836004)(71190400001)(71200400001)(66946007)(66556008)(66446008)(64756008)(5660300002)(44832011)(486006)(476003)(2616005)(1076003)(6116002)(3846002)(99286004)(52116002)(6486002)(6436002)(53936002)(107886003)(6512007)(2906002)(36756003)(66476007)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR02MB3794;H:BL0PR02MB3634.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ttn8OF1xB+fccwE3IovRwFmO/AknyxTPtiLZOgtjXCEg/FDXOOFUfs7YaL1ZvA63NyzkZBuHm5yDvXEJnx165ngubwprIRXJwQhtd/ytzcyMdF/Zxl9eXe/GekDVgppeflQWRpI1QoUAirN+lUeGqJ0lKJNrS+cDi8+V9QZT30EDUriVrgn1lBQevQq+TJxPr/ReDNIjVfLXaH5V2zNafO9in/g84MXScF7O6E3XYNnL97mU1hJ8ZTtH2t0vVxZpGBoS2AxbwFf+hfg8z2VYDM44a3cWCfFNvK9hXovWjQakHE6scbE3Hg+CpVLd8lRr+MR5Dm15fy7KVUToSs+gmOSv+uETF70gOBweC+sPSNYDIpIZ2UyN70sjaWnW5hY9YbrXhEvlN0+mecetji1UEMrIiP+5/jyvw8je5+I47MU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee8d3c9-d8e7-41e0-03f6-08d732c7a50a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 12:42:14.7281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kD4TQVHtZi3FhT8jSji0zjkyPS1jbUEB+CHkqevO7ufzrJMRNqP16nes0o7Zac97UegSm1vktpvNKKEX0HruXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3794
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-06_06:2019-09-04,2019-09-06 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG1hY3JvIHRvIGRpc2FibGUgbGVnYWN5IGZ1bmN0aW9ucyB2cmluZ19pbml0IGFuZCB2cmlu
Z19zaXplLg0KDQpTaWduZWQtb2ZmLWJ5OiBNYXRlaiBHZW5jaSA8bWF0ZWouZ2VuY2lAbnV0YW5p
eC5jb20+DQotLS0NCiBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3JpbmcuaCB8IDQgKysrKw0K
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUv
dWFwaS9saW51eC92aXJ0aW9fcmluZy5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19yaW5n
LmgNCmluZGV4IDRjNGUyNGMyOTFhNS4uNDk2ZGIyZjMzODMwIDEwMDY0NA0KLS0tIGEvaW5jbHVk
ZS91YXBpL2xpbnV4L3ZpcnRpb19yaW5nLmgNCisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0
aW9fcmluZy5oDQpAQCAtMTY0LDYgKzE2NCw4IEBAIHN0cnVjdCB2cmluZyB7DQogI2RlZmluZSB2
cmluZ191c2VkX2V2ZW50KHZyKSAoKHZyKS0+YXZhaWwtPnJpbmdbKHZyKS0+bnVtXSkNCiAjZGVm
aW5lIHZyaW5nX2F2YWlsX2V2ZW50KHZyKSAoKihfX3ZpcnRpbzE2ICopJih2ciktPnVzZWQtPnJp
bmdbKHZyKS0+bnVtXSkNCiANCisjaWZuZGVmIFZJUlRJT19SSU5HX05PX0xFR0FDWQ0KKw0KIHN0
YXRpYyBpbmxpbmUgdm9pZCB2cmluZ19pbml0KHN0cnVjdCB2cmluZyAqdnIsIHVuc2lnbmVkIGlu
dCBudW0sIHZvaWQgKnAsDQogCQkJICAgICAgdW5zaWduZWQgbG9uZyBhbGlnbikNCiB7DQpAQCAt
MTgxLDYgKzE4Myw4IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgdnJpbmdfc2l6ZSh1bnNpZ25l
ZCBpbnQgbnVtLCB1bnNpZ25lZCBsb25nIGFsaWduKQ0KIAkJKyBzaXplb2YoX192aXJ0aW8xNikg
KiAzICsgc2l6ZW9mKHN0cnVjdCB2cmluZ191c2VkX2VsZW0pICogbnVtOw0KIH0NCiANCisjZW5k
aWYNCisNCiAvKiBUaGUgZm9sbG93aW5nIGlzIHVzZWQgd2l0aCBVU0VEX0VWRU5UX0lEWCBhbmQg
QVZBSUxfRVZFTlRfSURYICovDQogLyogQXNzdW1pbmcgYSBnaXZlbiBldmVudF9pZHggdmFsdWUg
ZnJvbSB0aGUgb3RoZXIgc2lkZSwgaWYNCiAgKiB3ZSBoYXZlIGp1c3QgaW5jcmVtZW50ZWQgaW5k
ZXggZnJvbSBvbGQgdG8gbmV3X2lkeCwNCi0tIA0KMi4yMi4wDQoNCg==
