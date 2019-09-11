Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998BCC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D4B20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="WtWdD80/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfIKLMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 07:12:12 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:35738 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726696AbfIKLML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 07:12:11 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8BBA1OH004862;
        Wed, 11 Sep 2019 04:12:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=5T2nCFusGa8Bi4L4AHPAz4kfbJNC036CLLTb/oTJlak=;
 b=WtWdD80/KDWYoLjWWYovAZe6T4I2LjHivn5EON32NikmEIOVJ7cEWD8v/bXMgs/dqauN
 z+QUXgBW1IKDS4RhFZvv6wduKyeIu/7RiVyVB+O9bjOXqvhFD9lQ3mxNOsuXWDGnMZ0E
 bGvZbiNw5ZPjjATrudlF3+gpNeT+3MXL/Qvl1EgeEkbBl4lFvHfvCBFSifEA+fZjnDNh
 fWbQNgAMUAi6lXgZL3sgxjR7hXpoNXWxgR3NWU4QcpInuNOl7slrqs4Yd6wkbb6cLMxA
 PVGvKf/RKEo20f1WDZf7UVyZAygXiN9LQJ7sxo2L96dVNFsVxxX6FleuDj7CizrhjsrA uA== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2056.outbound.protection.outlook.com [104.47.33.56])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2uvc2yyxvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 04:12:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnvIxBzOkxq3JT0qsS5BfR1iUuu5GtSTRYkFlxiHmWDW3iKKzREgf/O8eJWDczLgiZN16zNKElfXhegchNbpKl42splvHl42F9eXtSW2Nt2g0+j8nSWnS0lXvEiI9xYgh5mZjTkfsF19x2YuXqBasOeQwojhxAgYIllt4LhfXWdqqcodxTzXWNN77R8/ETjRy/Mkyfgpeouip6/fBb/YS+wPuno1zAaj6/HnfVcxr6a/D0EPEyOXQaxdNM8gF48PidTvOe6nA1z/rkRCERbkmvsDXhqbSfmteJmPMju7lafa8gIrd08uol7oajOg9YB/28WCfHXczOiqsH63DNrvig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5T2nCFusGa8Bi4L4AHPAz4kfbJNC036CLLTb/oTJlak=;
 b=TS3iXRFhWN+8Bv9t19MXgMmNWt3FvydUr1Kx3Vk6nml2yRdztp9P49JW7fTp8iCshBOMid2sRteQvo2xh35oAOfjJVK3IPzbKdh/44IRV92Sf2MCUZOJfZoFf9OI9I5V3fGEdu6z2By3AOGSBxmpA6I0SW5WYkuJmVW3bcjY8ClJZN6Mj4YkAeeXAPyvSX8WTzjh3BM10+uGNmwRLonsxiiC7mz8CrzOSLReqfZ4Ck4kgFE5BSy+at9xxrLHvQ4n7VKwRIoPo9Gzu2fDLfouiNF/WPOOjfr4nq/uXOkEH2u1Hw1bRHyVPe0qT3kkfBzkfqP1vADbYqemWWn6ZZxkNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CY4PR0201MB3588.namprd02.prod.outlook.com (52.132.98.38) by
 CY4PR0201MB3475.namprd02.prod.outlook.com (52.132.99.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.13; Wed, 11 Sep 2019 11:12:05 +0000
Received: from CY4PR0201MB3588.namprd02.prod.outlook.com
 ([fe80::5598:9f2e:9d39:c737]) by CY4PR0201MB3588.namprd02.prod.outlook.com
 ([fe80::5598:9f2e:9d39:c737%6]) with mapi id 15.20.2199.027; Wed, 11 Sep 2019
 11:12:05 +0000
From:   Florian Schmidt <florian.schmidt@nutanix.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Schmidt <florian.schmidt@nutanix.com>
Subject: [PATCH v2 0/2] trace-vmscan-postprocess: fix parsing and output
Thread-Topic: [PATCH v2 0/2] trace-vmscan-postprocess: fix parsing and output
Thread-Index: AQHVaJG+W/ZepYHKIEGKJ+a3WisJoA==
Date:   Wed, 11 Sep 2019 11:12:05 +0000
Message-ID: <20190911111146.14799-1-florian.schmidt@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR05CA0093.eurprd05.prod.outlook.com
 (2603:10a6:207:1::19) To CY4PR0201MB3588.namprd02.prod.outlook.com
 (2603:10b6:910:8b::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 005d16b8-901c-48da-8028-08d736a8e0d8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR0201MB3475;
x-ms-traffictypediagnostic: CY4PR0201MB3475:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0201MB34750237F2237B9EE5DED75FF7B10@CY4PR0201MB3475.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(376002)(39860400002)(396003)(189003)(199004)(6512007)(6506007)(386003)(256004)(44832011)(2616005)(66476007)(81156014)(81166006)(66946007)(64756008)(66446008)(66556008)(66066001)(476003)(8936002)(50226002)(102836004)(486006)(8676002)(186003)(71200400001)(54906003)(26005)(4326008)(71190400001)(478600001)(107886003)(6436002)(1076003)(316002)(52116002)(36756003)(6486002)(99286004)(5660300002)(305945005)(2906002)(14454004)(53936002)(6916009)(25786009)(7736002)(3846002)(6116002)(86362001)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0201MB3475;H:CY4PR0201MB3588.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PlfhKnwzGUY2VTwiyQGc8TM5xAN3RxpPDDPxuPqT/LYHMSO6GtOilyGN+hCYUnPLgiL0gXTr7r1pH27EKE3gb7lIuR5X7BuE1JuCH9HjGe2nDB2kR3rlvHgGbHJY5cgiFieW2aUhRSNnurWGvfWZrau+6BqJi862A8Ufh6m287s6JNyCBEfuXEKV28spYgII1HWyGK1QQEz+dyseHhcjsNodIUSVFTws/Zw3gGoLCTIOvJFwh2oZy/J8T6IbvbBm+z1khHLS6LUrrIA8dpd/mLAqUOy+hwdUsMyrUzt7ZU0EVx81A/1etDkadNzLDlrjYhmh+5LfRJqe75jTQOp8yslghuAZvoKgRRAaKfAXmCK5xmn98yiIDteoniexhKhZSJwxCbe1YDg+FlHp6AldIgiRNtTHNWyHWnzbXFKV3kw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005d16b8-901c-48da-8028-08d736a8e0d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 11:12:05.3333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xq77gf7YTUGZuRMeBmGg26lQvM0dnznh7Tk84L3L+HCH7EyxI+LUMCHZhAhgYKVaMRFICkwSvZj+E6wvTlozANNijJBqRfy6pTPb8+2giNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3475
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-11_07:2019-09-11,2019-09-11 signatures=0
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
MiBmaXhlcyB0aGUgc3BhY2luZy4NCg0KQ2hhbmdlcyBzaW5jZSB2MToNCiogQWRkZWQgIkZpeGVz
OiIgbGluZXMgdG8gY29tbWl0IG1lZXNzYWdlIGluIHBhdGNoIDENCiogRml4ZWQgYSBzcGFjaW5n
IGlzc3VlIGluIHBhdGNoIDINCg0KDQpGbG9yaWFuIFNjaG1pZHQgKDIpOg0KICB0cmFjZS12bXNj
YW4tcG9zdHByb2Nlc3M6IHN5bmMgd2l0aCB0cmFjZXBvaW50cyB1cGRhdGVzDQogIHRyYWNlLXZt
c2Nhbi1wb3N0cHJvY2VzczogZml4IG91dHB1dCB0YWJsZSBzcGFjaW5nDQoNCiAuLi4vcG9zdHBy
b2Nlc3MvdHJhY2Utdm1zY2FuLXBvc3Rwcm9jZXNzLnBsICAgfCAyOSArKysrKysrKystLS0tLS0t
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0K
DQotLSANCjIuMjMuMA0KDQo=
