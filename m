Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293A0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29C42087E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="0V5IOIYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfICLp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:45:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:59338 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbfICLpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:45:25 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x83B9s0W015813;
        Tue, 3 Sep 2019 04:14:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=TZ8nGziQlW+a5wDYdKs45iTjnMlJb/mQyXTuDUvImg8=;
 b=0V5IOIYuyRJp7r8Bc4Yh5keRynJVjGf5YFLHbh9t6amiwNJ+eap6/sKzZOUpz5mPPdvU
 nlLxN4Wbm/n6/2ydwUFlkNHyRLIGEn/9j+CrGVRKDugJvKgvrFWgWy6KsG6GqIPlTM80
 H8h4zimw5qRSa5oUqOpc8s+GN9/ff2KO8qqUVTyvBzdDFEZu70XMdFTOC6lhJxVbDw1r
 CFeSXbhrhqgieKEIgMuePML2NtfJ50xwcMsRU1GNGKGlJruLj+6XyfF10xicLugjUMX1
 aMqc98hg3l1l9nLh6BZs7tCrT3sH8W4wVF2GRPUzevaMcO4CpXVXKnqLlUoLrJAyPQXB SA== 
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2052.outbound.protection.outlook.com [104.47.34.52])
        by mx0a-002c1b01.pphosted.com with ESMTP id 2uqqyg4r6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 04:14:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZyzB3zzN1gHl00s0NV/Ds0r4o3Y9wUR3Nsu6E/Oeknpt/CoEhYtIyFOzBB07O0q8S56/fsBl6FSLIpsH+fggfd8gPYOnvcHgPUG8IEkGAvXW1cD4aeO4ksvVRdgWTWygOL586CNzRVEIGDx055H8rHTN0DJE1BdQ/oOlpfBhurhiGRDWtG7g358ns4uGtZUbnSSGxA0lNcIvP1HOG+NJy5J8H9qrKkTov1m5aw8eSijYIIp507neKbQijib0bPL9vC7UDqDKxOnD6BeXfbX62q04mAmWmOAKT1mwTHS2PyEGPFbG8+58CrZ7A8dLtj9N5f03xpyb4FcYsfL0WuINQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ8nGziQlW+a5wDYdKs45iTjnMlJb/mQyXTuDUvImg8=;
 b=FPDgTbi8/V27eCyFzeJ1ll7xYcpX01ds/tnrEkvlr9eKNW8hY96NM25mE68kIqWY8+vjMbiIJm9ju4xX7IL7xN2uUE6Ch4qvdHscrMQBjYcKqV7dBilCXF47SsGnRappgsyLY+xXhNaHiBUTIgmtSNfHitf9LuVEIV82jG6frR/oDrbSJ8g9m0s9uxTM448EPJhygniwqwvKI6DBsJ5xjizG1F5frRaPv1Ev/BPOWnFNAPgClkUGF94TF3oQSXbDQSjtyUvNnCb4HdJ5ifCFWtLN/ZONHw7Qzg2AdxIgFJXXkRekadM/khdbcZ2L+ZNsuSf3o23D9PLZBeGjOPRwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CY4PR0201MB3588.namprd02.prod.outlook.com (52.132.98.38) by
 CY4PR0201MB3409.namprd02.prod.outlook.com (52.132.98.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 3 Sep 2019 11:14:08 +0000
Received: from CY4PR0201MB3588.namprd02.prod.outlook.com
 ([fe80::5598:9f2e:9d39:c737]) by CY4PR0201MB3588.namprd02.prod.outlook.com
 ([fe80::5598:9f2e:9d39:c737%6]) with mapi id 15.20.2199.021; Tue, 3 Sep 2019
 11:14:08 +0000
From:   Florian Schmidt <florian.schmidt@nutanix.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Schmidt <florian.schmidt@nutanix.com>
Subject: [PATCH 0/2] trace-vmscan-postprocess: fix parsing and output
Thread-Topic: [PATCH 0/2] trace-vmscan-postprocess: fix parsing and output
Thread-Index: AQHVYki0ihj6YyCnoUGe1njuFVT2kQ==
Date:   Tue, 3 Sep 2019 11:14:07 +0000
Message-ID: <20190903111342.17731-1-florian.schmidt@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR07CA0033.eurprd07.prod.outlook.com
 (2603:10a6:205:1::46) To CY4PR0201MB3588.namprd02.prod.outlook.com
 (2603:10b6:910:8b::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00582005-d723-4f62-d0ee-08d7305fd69e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR0201MB3409;
x-ms-traffictypediagnostic: CY4PR0201MB3409:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0201MB3409A2BE1C27790905BB8BFCF7B90@CY4PR0201MB3409.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(366004)(376002)(396003)(189003)(199004)(54094003)(1076003)(36756003)(305945005)(476003)(6512007)(186003)(71190400001)(71200400001)(50226002)(107886003)(81166006)(66066001)(14454004)(52116002)(81156014)(8676002)(86362001)(7736002)(6486002)(54906003)(5660300002)(102836004)(66946007)(3846002)(6116002)(4326008)(66476007)(66556008)(316002)(8936002)(478600001)(6916009)(26005)(2906002)(486006)(53936002)(44832011)(25786009)(6506007)(386003)(64756008)(99286004)(2616005)(256004)(6436002)(66446008)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0201MB3409;H:CY4PR0201MB3588.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2VsrbN0hehSzFlFRIZS14Gg+AXYi1bZtm7nzouL/f0VrJIvjN86KEhhG5Vl1ycgmE0Ic5gu/AoxItOc32QfMnTr6uT7HF9k7yc4+R3bH7tjrOzrJ3JmB5FyyunFCQS18mKqCkmMmVVTgE+2hKshXexAKecQkz59/FncUvBPMU4Wh2O0ZCpEXXYYb8PYt8T9ZatDudF+igHWSKcezCLK9ipvV/sei5o3Kyuel5Dcf2D4pOWmAt3KDZwbCri0ZEr5lzVvA09ujM7zyHC8NtKr+8EBIDJeG2zpvWHixCKWlL7EibNa64rkhzF8yhKZHmi5wHtUYWJy3CrmddQRjLNV0jpxCFOLxQ+tOtuMl9XDx/wQyLqGuSdrvFM1HfyH5dIPL4K6xDDxXkkK5kj2sbUmWSHxsN4O1b6EXpgnPLC8KIGU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00582005-d723-4f62-d0ee-08d7305fd69e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 11:14:08.0271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DfUGPwZ4U5oZ4FKS9mg9+jOB7psJMIsOnJyZv9ZvV1C04E6+/re/qyCZWWh5xQyS++eT3fFHtNQ2ZBsCUwf+xVJjf1V6/jUnIsKGnx8pHtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3409
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-03_01:2019-09-03,2019-09-03 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgdXBkYXRlcyB0cmFjZS12bXNjYW4tcG9zdHByb2Nlc3MucGwgdG8g
d29yayB3aXRob3V0DQp0aHJvd2luZyB3YXJuaW5ncyBhbmQgZXJyb3JzIHdoaWNoIHN0ZW0gZnJv
bSB1cGRhdGVzIHRvIHNldmVyYWwgdHJhY2UNCnBvaW50cy4NCg0KMzQ4MWMzN2ZmYTFkICgibW0v
dm1zY2FuOiBkcm9wIG1heV93cml0ZXBhZ2UgYW5kIGNsYXNzem9uZV9pZHggZnJvbQ0KZGlyZWN0
IHJlY2xhaW0gYmVnaW4gdGVtcGxhdGUiKSByZW1vdmVkICJtYXlfd3JpdGVwYWdlIiBmcm9tDQpt
bV92bXNjYW5fZGlyZWN0X3JlY2xhaW1fYmVnaW4sIGFuZCAzYjc3NTk5OGVjYTcNCigiaW5jbHVk
ZS90cmFjZS9ldmVudHMvdm1zY2FuLmg6IGRyb3Agem9uZSBpZCBmcm9tIGtzd2FwZCB0cmFjZXBv
aW50cyIpDQpyZW1vdmVkICJ6aWQiIGZyb20gbW1fdm1zY2FuX3dha2V1cF9rc3dhcGQuIFRoZSBv
dXRwdXQgb2YNCm1tX3Ztc2Nhbl9scnVfaXNvbGF0ZSBhbmQgbW1fdm1zY2FuX2xydV9zaHJpbmtf
YWN0aXZlIHNlZW1zIHRvIG5ldmVyDQpoYXZlIG1hdGNoZWQgdGhlIGZvcm1hdCBvZiB0aGUgdHJh
Y2UgcG9pbnQgb3V0cHV0IHNpbmNlIHRoZXkgd2VyZQ0KY3JlYXRlZCwgb3IgYXQgbGVhc3QgZm9y
IGFzIGxvbmcgYXMgSSBjYW4gdGVsbC4gUGF0Y2ggMSBhbGlnbnMgdGhlDQpmb3JtYXQgcGFyc2lu
ZyBvZiB0aGUgcGVybCBzY3JpcHQgd2l0aCB0aGUgY3VycmVudCBvdXRwdXQgb2YgdGhlIHRyYWNl
DQpwb2ludHMuDQoNCkluIGFkZGl0aW9uLCB0aGUgdGFibGVzIHRoYXQgYXJlIHByaW50ZWQgYnkg
dGhlIHNjcmlwdCB3ZXJlIG5vdCBwcm9wZXJseQ0KYWxpZ25lZCBhbnkgbW9yZSwgc28gcGF0Y2gg
MiBmaXhlcyB0aGUgc3BhY2luZy4NCg0KQSBzaWRlIHJlbWFyazogcGFyc2luZyB0aGUgdHJhY2Ug
b3V0cHV0IGZvciBtbV92bXNjYW5fbHJ1X3Nocmlua19hY3RpdmUNCmhhcyBiZWVuIGluIHRoZSBz
Y3JpcHQgZXZlciBzaW5jZSBpdCB3YXMgY3JlYXRlZCBpbiAyMDEwLCBidXQgYXQgbm8NCnBvaW50
IHRoZSBwYXJzZWQgb3V0cHV0IHdhcyBldmVyIHVzZWQgZm9yIGFueXRoaW5nLiBJIHVwZGF0ZWQg
dGhlDQpwYXJzaW5nIGNvZGUgbm93LCBidXQgSSB3b25kZXIgaWYgd2UgY291bGQganVzdCBnZXQg
cmlkIG9mIHRoYXQgcGFydC4uLg0KDQpGbG9yaWFuIFNjaG1pZHQgKDIpOg0KICB0cmFjZS12bXNj
YW4tcG9zdHByb2Nlc3M6IHN5bmMgd2l0aCB0cmFjZXBvaW50cyB1cGRhdGVzDQogIHRyYWNlLXZt
c2Nhbi1wb3N0cHJvY2VzczogZml4IG91dHB1dCB0YWJsZSBzcGFjaW5nDQoNCiAuLi4vcG9zdHBy
b2Nlc3MvdHJhY2Utdm1zY2FuLXBvc3Rwcm9jZXNzLnBsICAgfCAyOSArKysrKysrKystLS0tLS0t
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0K
DQotLSANCjIuMjMuMC5yYzENCg0K
