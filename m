Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22019C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D902321850
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plantronics.onmicrosoft.com header.i=@plantronics.onmicrosoft.com header.b="BJ4Yrv9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfC2AsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:48:07 -0400
Received: from mail-eopbgr780124.outbound.protection.outlook.com ([40.107.78.124]:6221
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727654AbfC2AsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=plantronics.onmicrosoft.com; s=selector1-plantronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnZUdk1gr141ePtc6ZGVvPotFBKd52xZJ8U7wWAc2/M=;
 b=BJ4Yrv9Txhm2YwbgY6DehakPKAZYatnRclB2Bi0PMXIx4pAIAXxwNdcpaVAjpS5QXEIgDdV7q0CVdhTQmTopc6Ej+TNBIUU/BPRhzNqu962I8rROzH4jlLwp2lJPF8kLWtNKknm4//b9+LXvRUsrQos7hLhRfb/uvqjui6QxpjM=
Received: from BYAPR02MB5607.namprd02.prod.outlook.com (20.177.230.93) by
 BYAPR02MB4294.namprd02.prod.outlook.com (52.135.237.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 29 Mar 2019 00:48:02 +0000
Received: from BYAPR02MB5607.namprd02.prod.outlook.com
 ([fe80::25a1:583a:a978:21fd]) by BYAPR02MB5607.namprd02.prod.outlook.com
 ([fe80::25a1:583a:a978:21fd%4]) with mapi id 15.20.1750.014; Fri, 29 Mar 2019
 00:48:02 +0000
From:   "Junge, Terry" <terry.junge@poly.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jiri Kosina <jikos@kernel.org>,
        "oneukum@suse.de" <oneukum@suse.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] HID: core: move Usage Page concatenation to Main item
Thread-Topic: [PATCH v4] HID: core: move Usage Page concatenation to Main item
Thread-Index: AQHU5IZ+r6lyKkwtx02WiLHUpmG6x6YgME3ggADgigCAALUhcA==
Date:   Fri, 29 Mar 2019 00:48:02 +0000
Message-ID: <BYAPR02MB560797BC61D1AE47761139B48A5A0@BYAPR02MB5607.namprd02.prod.outlook.com>
References: <20190327101848.25477-1-nsaenzjulienne@suse.de>
 <BYAPR02MB5607E9396127F67A9A2BEC948A590@BYAPR02MB5607.namprd02.prod.outlook.com>
 <CAO-hwJLatVKwgevfdFk1Lqqpg3H7Oc28_VEkiyxPXne3fhSrqw@mail.gmail.com>
In-Reply-To: <CAO-hwJLatVKwgevfdFk1Lqqpg3H7Oc28_VEkiyxPXne3fhSrqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=terry.junge@poly.com; 
x-originating-ip: [198.231.9.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acdd7205-2e37-452f-a297-08d6b3e032dd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB4294;
x-ms-traffictypediagnostic: BYAPR02MB4294:
x-microsoft-antispam-prvs: <BYAPR02MB4294CA7644DAB1DBD20C70658A5A0@BYAPR02MB4294.namprd02.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(396003)(39860400002)(376002)(13464003)(189003)(199004)(74316002)(7736002)(305945005)(6436002)(6246003)(476003)(102836004)(478600001)(33656002)(81166006)(229853002)(9686003)(81156014)(86362001)(486006)(106356001)(68736007)(25786009)(55016002)(66066001)(53546011)(186003)(4326008)(53936002)(8676002)(4744005)(11346002)(6116002)(8936002)(76176011)(5660300002)(52536014)(446003)(26005)(14454004)(316002)(2906002)(54906003)(6916009)(71200400001)(6506007)(71190400001)(97736004)(99286004)(7696005)(105586002)(3846002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR02MB4294;H:BYAPR02MB5607.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: poly.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gK+j5xCQiIWQPCEthEccHKVCm+9XaXG9XKc7fI0ar0jQBa/HwwFbjyWihzJnI5ZkVC0iIiul3fmHdJryXzyChZu8l8AKg84nSYvMsNGB3cppzlStfReOwI6/I/ruez2HeujGQz/44uv+PWJYVizAixNb/zx/CnbZWKMr7IQEHaCLZlYiQPoLdMUdV6fgk5n3hN3JJYpV72GGuk+AK+gq+LymQo35/D+jM/HFc4XwNtT4XFmoks3NL9e5VTcV/5buHlEvLtavbvuVviW3rOMkIea7MiL0QfSuQKq8NZW8WxC2xOWhtO++koveXcAV9OXm2UQ+4w/TWVkjQhTVtmD6mLYagpUW7+v0J00DleMpvxwN1NRrhDuHpVcYwpFhMjWHAtsdTL3PZxC2kRQ4JLhw1H1PXq9w1kbKkIRXEsGAE9A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: poly.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdd7205-2e37-452f-a297-08d6b3e032dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 00:48:02.5364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc7c5f16-c55e-417d-aac0-ff6bbfc27f76
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1cnNkYXksIE1hcmNoIDI4LCAyMDE5IDY6NDkgQU0gQmVuamFtaW4gVGlzc29pcmVzIDxi
ZW5qYW1pbi50aXNzb2lyZXNAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pg0KPj4gSGkgTmljb2xhcywN
Cj4+DQo+PiBWNCBsb29rcyBnb29kIHRvIG1lLg0KPg0KPkxvb2tzIGdvb2QgdG8gbWUgdG9vLg0K
Pg0KPlRlcnJ5LCBjYW4gSSBjb25zaWRlciB0aGlzIGFzIGEgZm9ybWFsIFJldi1ieSB5b3U/DQoN
CkJlbmphbWluLA0KDQpZZXMsIHRoYW5rIHlvdS4gV2hhdCBpcyB0aGUgbm9ybWFsIHdheSBvZiBm
b3JtYWxseSBpbmRpY2F0aW5nIFJldi1ieT8NCg0KUmVnYXJkcywNClRlcnJ5DQoNCj4NCj5DaGVl
cnMsDQo+QmVuamFtaW4NCj4NCj4+DQo+PiBUaGFua3MsDQo+PiBUZXJyeQ0KPj4NCj4+ID4tLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gPlN1YmplY3Q6IFtQQVRDSCB2NF0gSElEOiBjb3Jl
OiBtb3ZlIFVzYWdlIFBhZ2UgY29uY2F0ZW5hdGlvbiB0byBNYWluDQo+aXRlbQ0KPj4gPg0K
