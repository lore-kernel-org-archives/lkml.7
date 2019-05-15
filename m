Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B583BC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837A0206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="TQyMq4EV";
	dkim=pass (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="r7vy1Nrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfEOUwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:52:36 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:13892 "EHLO
        rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfEOUwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:52:36 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 May 2019 16:52:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=830; q=dns/txt; s=iport;
  t=1557953555; x=1559163155;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=1EW9TDbzRse7TuuGkbStZdCP/HtthI7NcbjgmX//ktw=;
  b=TQyMq4EVleS+nUmu94foB+/u0+mXVxX8REBkb0u4HRAubFRAt5iZ7L1S
   12md6mTNEYYG0DX6+Am9yrBaWcjh+GV1qBPS5VgktHYGq8BP7cNOniQ26
   yDXiQa/PrMne8ycNMBYOv97l1+lkqG+P6MTBlv9YOSu+rTUyeZ3VydeXh
   g=;
IronPort-PHdr: =?us-ascii?q?9a23=3AEtOF/hDQqbSWv3TG3Z/+UyQJPHJ1sqjoPgMT9p?=
 =?us-ascii?q?ssgq5PdaLm5Zn5IUjD/qs03kTRU9Dd7PRJw6rNvqbsVHZIwK7JsWtKMfkuHw?=
 =?us-ascii?q?QAld1QmgUhBMCfDkiuN/7lZio1FcJqX15+9Hb9Ok9QS47z?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AVDwC1edxc/4sNJK1kHQIfBQeBTQK?=
 =?us-ascii?q?BKBRQA4E+IAQLKIQRg0cDjnKCMpdKglIDVAkBAQEMAQEtAgEBhEAZghQjNwY?=
 =?us-ascii?q?OAQMBAQQBAQIBBG0cAQuFTRYREQwBATcBEQEiAiYCBDAVEgQOJ4MAgWsDHQE?=
 =?us-ascii?q?CoRoCgTWIX3GBL4J5AQEFgkeCOhiCDwmBCyYCAQEBAYtLF4FAP4E4DBOCTIg?=
 =?us-ascii?q?MMoImixuCRYZokxUJAoIJApJcFAeCBJNqLYwHlQoCBAIEBQIOAQEFgWUiKYE?=
 =?us-ascii?q?ucBVlAYJBghgag0yKU3KBKY9GAQE?=
X-IronPort-AV: E=Sophos;i="5.60,474,1549929600"; 
   d="scan'208";a="558122177"
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 15 May 2019 20:45:30 +0000
Received: from XCH-RCD-016.cisco.com (xch-rcd-016.cisco.com [173.37.102.26])
        by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id x4FKjU44019581
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 15 May 2019 20:45:30 GMT
Received: from xhs-aln-002.cisco.com (173.37.135.119) by XCH-RCD-016.cisco.com
 (173.37.102.26) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 May
 2019 15:45:30 -0500
Received: from xhs-rtp-001.cisco.com (64.101.210.228) by xhs-aln-002.cisco.com
 (173.37.135.119) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 May
 2019 15:45:29 -0500
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (64.101.32.56) by
 xhs-rtp-001.cisco.com (64.101.210.228) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 15 May 2019 16:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EW9TDbzRse7TuuGkbStZdCP/HtthI7NcbjgmX//ktw=;
 b=r7vy1Nrs1R3m/ImOZpXhhJZ7NeUeqxuVUnFNBbWDasHlHs7CL5yFrdp8aclRmpDT/38A4efNcgEqYNwnY4bkUp0VlEh/HYu1OSAimQXiClcuzXDnb9ERfh4f75e8qAc2MR6Y5ekXpCurEjO25gcG4xunxilf0F28LqfjWE5sAdk=
Received: from BYAPR11MB3461.namprd11.prod.outlook.com (20.177.187.14) by
 BYAPR11MB3752.namprd11.prod.outlook.com (20.178.238.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 20:45:27 +0000
Received: from BYAPR11MB3461.namprd11.prod.outlook.com
 ([fe80::494e:92a0:85c6:a3dd]) by BYAPR11MB3461.namprd11.prod.outlook.com
 ([fe80::494e:92a0:85c6:a3dd%7]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 20:45:27 +0000
From:   "Shreya Gangan (shgangan)" <shgangan@cisco.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Removal of dump_stack()s from  /fs/ubifs/io.c
Thread-Topic: Removal of dump_stack()s from  /fs/ubifs/io.c
Thread-Index: AQHVC18gL8Dvs2CcT0+L+hHPz5/XQA==
Date:   Wed, 15 May 2019 20:45:27 +0000
Message-ID: <E44E4181-1CFB-493C-8023-147472049D19@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shgangan@cisco.com; 
x-originating-ip: [2001:420:30d:1254:f50a:d60e:60dd:2496]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7ce545e-ebef-448c-ca29-08d6d9764344
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR11MB3752;
x-ms-traffictypediagnostic: BYAPR11MB3752:
x-microsoft-antispam-prvs: <BYAPR11MB3752F0BD46529599D446FA6BDB090@BYAPR11MB3752.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(136003)(346002)(199004)(189003)(6436002)(73956011)(66946007)(4744005)(5640700003)(66556008)(64756008)(66476007)(66446008)(102836004)(186003)(478600001)(53936002)(6486002)(33656002)(2906002)(4326008)(76116006)(8676002)(81166006)(81156014)(316002)(2351001)(8936002)(82746002)(86362001)(71190400001)(46003)(305945005)(14454004)(5660300002)(83716004)(71200400001)(6512007)(6916009)(99286004)(36756003)(6506007)(6116002)(25786009)(2616005)(476003)(14444005)(68736007)(256004)(7736002)(2501003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3752;H:BYAPR11MB3461.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XC1KO1Izp0yu1EXerufzRIZfTaL/MifG1FG8EOeEU6DEBDIZHbl5/BF4UaluqE5aMAISVDnTPhH/cELGHfMbsQSbPpMcQ/O8txlTsmVMScoLEcwYhgXo3Fzx9o2QZ91+aF8XDXCqj8DY/a7wfbNHaMKes+5rxDs/ZTtvjbsRzgmHrukplVDxlP0TdD1Pn/HWEdIHXrS/x9fr44cp0E2kepHscrynmt4qkIQKWBmv5u/7oco9s7de6Cb63o9c7Q5HcFf6aKiGIfEWdm+mUr2Q0hlSly7KLTTMceGW6/X7TxGUp8QFkay03ZUV9Rj+B76tz+Hj/nuZPgGOfZ+rluDImhbWQHDddTmAX7SM1fVMkeSSm1Lg711rGjvFA6ci6vbWrKW2qV90oHLNOUIafvnpo12vZ+IE+iXuG1Seh87iTWE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B57E62027753246B31A0AEF8BAB1A0A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ce545e-ebef-448c-ca29-08d6d9764344
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 20:45:27.5355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3752
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.26, xch-rcd-016.cisco.com
X-Outbound-Node: alln-core-6.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQogICAgDQogL2ZzL3ViaWZzL2lvLmMgaGFzIGR1bXBfc3RhY2soKSBpbiBtdWx0aXBsZSBm
dW5jdGlvbnMgdXBvbiBlcnJvcnMgYW5kIHNvbWV0aW1lcyB3YXJuaW5ncy4gDQpTaW5jZSB0aGUg
ZXJyb3IgYW5kIHdhcm5pbmcgbWVzc2FnZXMgc2VlbSB0byBiZSB1bmlxdWUsIHRoZSBmdW5jdGlv
bmFsIHZhbHVlIG9mIHRoZXNlIGR1bXBfc3RhY2tzIGlzIG5vdCBhcHBhcmVudC4NCldoeSBhcmUg
dGhlc2UgZHVtcF9zdGFja3MgcmVxdWlyZWQgYW5kIHdoYXQgaXNzdWVzIG1pZ2h0IG9jY3VyIHVw
b24gdGhlIHJlbW92YWwgb2YgdGhlc2U/DQoNCkV4YW1wbGU6IA0KV2hhdCBpcyB0aGUgdXNlY2Fz
ZSBvZiB0aGUgZHVtcF9zdGFjayBpbiB0aGUgZm9sbG93aW5nIGNvZGUgc25pcHBldCBpbiBmaWxl
IC9mcy91Ymlmcy9pby5jPw0KICAgIGlmIChlcnIpIHsNCiAgICAJCXViaWZzX2VycihjLCAiY2hh
bmdpbmcgJWQgYnl0ZXMgaW4gTEVCICVkIGZhaWxlZCwgZXJyb3IgJWQiLA0KICAgIAkJCSAgbGVu
LCBsbnVtLCBlcnIpOw0KICAgIAkJdWJpZnNfcm9fbW9kZShjLCBlcnIpOw0KICAgIAkJZHVtcF9z
dGFjaygpOw0KICAgIAl9DQogICAgDQpSZWdhcmRzLA0KDQo=
