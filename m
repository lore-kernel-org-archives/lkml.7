Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFE7C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480F420409
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dj443aZg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="HgUNayzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKNJtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:49:25 -0500
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:53502 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbfKNJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:49:24 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DE534C0C42;
        Thu, 14 Nov 2019 09:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1573724964; bh=+cG6UGj9AUf64OwwL+j5feOuOcTISc3rAdk+VIUujgg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=dj443aZgSiFsbV5tZBqys12mN7FvuYB9/zY2cBfZ6LM15y/UV34RgdvOPfPfCrUgB
         cjYCXmgle4Irsz3elXaPNrGtFynAJyNn+2VwZzNGfvIe3D9Ipo37AYdzGRsZrkc0Ij
         5nDjpfiKz8coinp+XvfY6uzkXueGZRj6KC3QGYFpRifpFR9Gu88gvPDNyL22NcgsV7
         oaD/WnPfgzG4uohuqDElWzeb/zqGrcNThw/2WMzCux23ffDph0y3LgU2+Td/wwTWlN
         X4KR4R6Alsw8ncjlJ+pSJFtUdosVdei3kII1YDSqH18MW+eLGU2LhAjss7Kk07vUki
         MxnCvXyT2KU6Q==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id BB556A0148;
        Thu, 14 Nov 2019 09:49:23 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 14 Nov 2019 01:49:11 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 14 Nov 2019 01:49:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0lgGhJMkeXXBYIj65YUCFEBzKQBjcnRROGuQkcfvewkNO4brkPLbJXwFZQdomcRm496dNfI16KkEDxa0Sr8muUPML5LTeMxM/AWzu7gLQ0GDd0H4VY2bKK8H+QVc6nY6d0JMNo263b0Yiyv30ibiYx0/R7dYuXmU6F2VhNUyyyrUDD2Jo8WW1x5VxQMic6mfmL+PY0HvDRTKSjcnRwfN7PzBu36K6MsgVzmjYAegEvYfEJUGZmBJFEjGGcjpRXlA9il1t6YFRj9JwjkwL6jiG+Z4zBjNNpW61G9B5Le1B8vPHizdSXU2EEqdJ2m9FouL3vjQwq+9bBXnBDeKToUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cG6UGj9AUf64OwwL+j5feOuOcTISc3rAdk+VIUujgg=;
 b=J5+n70K9Dlzr8m3d6aw9oX+7X462vTsbezowm97tpbBkBqjjzlSJ25jrGrpAB5hSf7D0KezlHcXPKBQyzQhHiT6pq+32Zjwvj0Gq8/6W5esnBplZ6f6NOU9D5z0JOGR4H+Iv0KnWGXVvipQPZTqz2UhD5gXxdVl0tkG+y6kuzkCe/UyO3t0N/WxFkAHx92bNjOKy2ebe6qPzIjX/U+c1a1BCyKM6+jCMBEcsglf1sPdt9vpv5Q5VbgJywigpidevB64t5mcliTD5z+AJH9GhiAP/9tg7uXEoYBnQs+EyEE8EtyAWxovtTrMF8KRkobmjJ9zYpNzuCITlLvmfQArLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cG6UGj9AUf64OwwL+j5feOuOcTISc3rAdk+VIUujgg=;
 b=HgUNayzJPMCa4mmACiISFjyccA5WEBNzrVQo/k349o02oaDnrIcbmZ4e5k2ScYcnluoK+8+RTmsN5Og960icliX9VeUTLTrziy0Nb3dCsMa/kpIReUtj5ajWy6URnr63XuBDRnxaOyob+pwMh85q5U/Whba9Ml3rvclv2Z4CvC0=
Received: from MN2PR12MB4093.namprd12.prod.outlook.com (52.135.51.203) by
 MN2PR12MB3918.namprd12.prod.outlook.com (10.255.236.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 09:49:09 +0000
Received: from MN2PR12MB4093.namprd12.prod.outlook.com
 ([fe80::85e4:7eb9:af8d:8a9]) by MN2PR12MB4093.namprd12.prod.outlook.com
 ([fe80::85e4:7eb9:af8d:8a9%3]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 09:49:09 +0000
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Pan Bian <bianpan2016@163.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] usb: dwc2: fix potential double free
Thread-Topic: [PATCH 1/1] usb: dwc2: fix potential double free
Thread-Index: AQHVlEU5zvY07CTVb0qrP6bsJzHzeaeKePoA
Date:   Thu, 14 Nov 2019 09:49:09 +0000
Message-ID: <5baaa3ab-fe75-4351-5acc-ec7fdffce28b@synopsys.com>
References: <1573005273-35877-1-git-send-email-bianpan2016@163.com>
In-Reply-To: <1573005273-35877-1-git-send-email-bianpan2016@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hminas@synopsys.com; 
x-originating-ip: [195.10.9.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e7cddbf-408c-4068-c76a-08d768e7e56c
x-ms-traffictypediagnostic: MN2PR12MB3918:
x-microsoft-antispam-prvs: <MN2PR12MB391883CBA5737E77FB32CF0FA7710@MN2PR12MB3918.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:183;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(396003)(39850400004)(346002)(189003)(199004)(4326008)(229853002)(102836004)(446003)(110136005)(4744005)(76176011)(54906003)(3846002)(5660300002)(36756003)(316002)(53546011)(6506007)(6116002)(65956001)(65806001)(25786009)(31686004)(6512007)(14454004)(64756008)(66556008)(66476007)(66946007)(476003)(486006)(6436002)(99286004)(2616005)(66066001)(478600001)(58126008)(6486002)(11346002)(305945005)(26005)(7736002)(186003)(86362001)(66446008)(81156014)(256004)(8676002)(8936002)(71190400001)(71200400001)(81166006)(91956017)(76116006)(6246003)(31696002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR12MB3918;H:MN2PR12MB4093.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QtH/WLuntZ+ZDRoxAjJjbODFoTow8ZaHEmbmZ3zF1fJxL+eU7P2kB62CTavuWxjqJwc2StEwoTQ++NpMdgJYhLwz1Zb/lQIDGsEdD30Zem0KI6sOl213vwiv1EE4QvCjBgI3UfIym10LtVR4dbs1uNY9ntisPTAQ7UcHCrOCaUmZWW8KyJfdah4gm30eZQ0KQVulzeUgTUPWO7gavXHvweL5oLvs7mrE2yy+Zmu5jd4L65sCWd5L++qXRvGZW5n2Ac7z18TJ8goaDDavLcAPqzmDCHdAkZh2QBf56eNf6f3D58kjnoxk8dsmXwkkl9bW3u37HsBJSpZoh9U7f4wTr9fPzwCmGUdfHeLU8S4ErRDGHrMRzmWGSFu2ed+K580jHbt0PGx76IZx3cQY49Zdljxj1+PRTEoq9GgOX5rEMUvHLeZKaZmYg+U9Ounb4TfB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F928CD1570E944EB367E1E278E54BE7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7cddbf-408c-4068-c76a-08d768e7e56c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 09:49:09.0855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9CH58c4RStvTcMZaoS3XO5o8NO10FTubA55aziilOwYfQKwe0rVVA6AHZIdEt4nE08dXnrq4QdvNgznL9vm3UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3918
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzYvMjAxOSA1OjU0IEFNLCBQYW4gQmlhbiB3cm90ZToNCj4gVGhlIG1lbWJlciBo
c290Zy0+ZGVzY19nZW5fY2FjaGUgaXMgYXNzaWduZWQgTlVMTCBhZnRlciBpdCBpcyBkZXN0cm95
ZWQNCj4gdG8gYXZvaWQgYmVpbmcgZnJlZWQgdHdpY2Ugd2hlbiB0aGUgY2FsbCB0byB1c2JfYWRk
X2hjZCgpIGZhaWxzLg0KPiANCj4gRml4ZXM6IDNiNWZjYzlhYzJmNCAoInVzYjogZHdjMjogaG9z
dDogdXNlIGttZW0gY2FjaGUgdG8gYWxsb2NhdGUgZGVzY3JpcHRvcnMiKQ0KPiANCj4gU2lnbmVk
LW9mZi1ieTogUGFuIEJpYW4gPGJpYW5wYW4yMDE2QDE2My5jb20+DQoNCkFja2VkLWJ5OiBNaW5h
cyBIYXJ1dHl1bnlhbiA8aG1pbmFzQHN5bm9wc3lzLmNvbT4NCg0KPiAtLS0NCj4gICBkcml2ZXJz
L3VzYi9kd2MyL2hjZC5jIHwgMSArDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9oY2QuYyBiL2RyaXZlcnMvdXNi
L2R3YzIvaGNkLmMNCj4gaW5kZXggODFhZmU1NTNhYTY2Li4zYjk0MzM1MmIyOTYgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvaGNkLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9o
Y2QuYw0KPiBAQCAtNTE4Myw2ICs1MTgzLDcgQEAgaW50IGR3YzJfaGNkX2luaXQoc3RydWN0IGR3
YzJfaHNvdGcgKmhzb3RnKQ0KPiAgIAkJCQkidW5hYmxlIHRvIGNyZWF0ZSBkd2MyIGhzIGlzb2Mg
ZGVzYyBjYWNoZVxuIik7DQo+ICAgDQo+ICAgCQkJa21lbV9jYWNoZV9kZXN0cm95KGhzb3RnLT5k
ZXNjX2dlbl9jYWNoZSk7DQo+ICsJCQloc290Zy0+ZGVzY19nZW5fY2FjaGUgPSBOVUxMOw0KPiAg
IA0KPiAgIAkJCS8qDQo+ICAgCQkJICogRGlzYWJsZSBkZXNjcmlwdG9yIGRtYSBtb2RlIHNpbmNl
IGl0IHdpbGwgbm90IGJlDQo+IA0K
