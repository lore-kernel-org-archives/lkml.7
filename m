Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDCBC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 23:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19460218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 23:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="L40I76ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbfISXhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 19:37:41 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18238 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731387AbfISXhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 19:37:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d8411460000>; Thu, 19 Sep 2019 16:37:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 19 Sep 2019 16:37:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 19 Sep 2019 16:37:37 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Sep
 2019 23:37:36 +0000
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.58) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 19 Sep 2019 23:37:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e27vt4TXpq0lqFrVOBZsyPYtKDwyGQISGwF7SEHHaoNiwl8jfo63x/63M0SdreXOwp3/euK7QktSMbEB/NzgpHyTQyDyFVFEnfls/mEPqXONhYx8u8wj/O2PKTH+RvyNzoT87hQ8goHbdnLgFn3Qw2GJBQCB3pee65nBSthl+r1pn267hbuckqPEaEbMCGN8tfsg7lMkGqVs7kgc71IZ89rfoseRBjzKN+5j+vj57CMTQtmTKqgPOgTYCodExZ7Vavr+EIfFRopfVpyW+Z4x5QHzLjj1vq1aiOSOXeaSFCJJf32CsyNkVrqlNoqZkQO+ItTEQwXG5TUkLUYIUJZ91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpwB9JytXsYQ5wuSovW2N+cdPjLA9ZF5iqwlpJui4D0=;
 b=TJjc34+Qje8z/ZubmqG8Z8CagBFiAzrvQwL1tbEsdmGL+X4fVrRQsaHpFhvNtw77TyTHggADqAIDGq8i8XaW4OLChrOh4hYyNYoisnOB+2dzTtFjtYNgZVZbiVJv95b630z4+5Q4mW7WXv1zFhFvCmWoihKirbUtikUooylK61+xDfbVm4p9+skaZ8mOHu7BPXfAIfYqrvxcZp46EWTeBNlzc6dAkt/K8KexGXezrOln/s6FrfpbV11sLCcfDmBR3VZDzCynoKUuAgXiLV3kbeBNeVdemFuLtjVH4tnC8csIfxJs5n5p93BYRi2TMl+61z45s2iRogBGXhgeG+UuKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3015.namprd12.prod.outlook.com (20.178.55.78) by
 BYAPR12MB3304.namprd12.prod.outlook.com (20.179.93.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.23; Thu, 19 Sep 2019 23:37:34 +0000
Received: from BYAPR12MB3015.namprd12.prod.outlook.com
 ([fe80::2da1:b02f:cd54:eae9]) by BYAPR12MB3015.namprd12.prod.outlook.com
 ([fe80::2da1:b02f:cd54:eae9%3]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 23:37:34 +0000
From:   Nitin Gupta <nigupta@nvidia.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "cai@lca.pw" <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "jannh@google.com" <jannh@google.com>, "guro@fb.com" <guro@fb.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "arunks@codeaurora.org" <arunks@codeaurora.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>,
        "janne.huttunen@nokia.com" <janne.huttunen@nokia.com>,
        "khlebnikov@yandex-team.ru" <khlebnikov@yandex-team.ru>
Subject: Re: [RFC] mm: Proactive compaction
Thread-Topic: [RFC] mm: Proactive compaction
Thread-Index: AQHVVHvSPOoT6GjwikqO8JNrunJOkacDvn6AgDAe9YA=
Date:   Thu, 19 Sep 2019 23:37:34 +0000
Message-ID: <7bbd5322ed7a7fcb349c83952f8fc17448cd07d8.camel@nvidia.com>
References: <20190816214413.15006-1-nigupta@nvidia.com>
         <87634ddc-8bfd-8311-46c4-35f7dc32d42f@suse.cz>
In-Reply-To: <87634ddc-8bfd-8311-46c4-35f7dc32d42f@suse.cz>
Reply-To: Nitin Gupta <nigupta@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nigupta@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1a3a28e-c07a-42ad-e937-08d73d5a58c6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB3304;
x-ms-traffictypediagnostic: BYAPR12MB3304:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR12MB33048A81B18CDD26FA5A908DD8890@BYAPR12MB3304.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(66556008)(64756008)(66946007)(66476007)(26005)(76116006)(186003)(6246003)(91956017)(3846002)(316002)(6116002)(66446008)(229853002)(43066004)(5660300002)(7416002)(99286004)(6486002)(71200400001)(6436002)(71190400001)(6512007)(6306002)(102836004)(8936002)(6506007)(76176011)(478600001)(81166006)(86362001)(8676002)(2201001)(305945005)(54906003)(7736002)(2501003)(81156014)(4326008)(2906002)(118296001)(25786009)(256004)(36756003)(66066001)(446003)(2616005)(966005)(3450700001)(476003)(14454004)(14444005)(486006)(11346002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3304;H:BYAPR12MB3015.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: umud9Pwq2WwUKuVsDN02ZWnvdsd919jWjqm8nbUsmCD7tiiiU8O1L1BU//gy6TAcOZNZyd47KoddPWq7ohKJf2ebPKbZe6KzRFrp1IZSV4oiGn/UQI9O5H0pbuRUeS1rZeA/DZcLasvTwDAHJWijeyEAhWpash5NWXyh3gXQfMO3NOUwuhTBNMzHHn8V+rW10XShX5ZBoqsCkWelhwH/cBHgguH/QEZSG69bEoSmA27Imnq4qmomwQ3M+jbzd0AhFqtxABhL1/Yzlp/bmYoMgtTxP3g3oMQNnZ92AzXluh0ReJlCNi0eobKR5l9RgkCH7VYgR3hYL+QqQYM7lse+QjrR5MWLupZLI/N0hBewD3S9Gf7zAJbb5QsYQ3yFHzlECLa4EyqzdvKsJFHBFc6NvSRsgUud/D+q3KtN+qKqiAs=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a3a28e-c07a-42ad-e937-08d73d5a58c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 23:37:34.0817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yb7dJm7PQ294UnqAoBwqjfaQyXn9OPeT9sxrAEQ0JsfYXLdqBJBw9HZ8iWvAeAjsPjRQOguHRCFC0lLX3wLi7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3304
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <60A320A2F7AB8D48B17F534862742B6D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1568936262; bh=IpwB9JytXsYQ5wuSovW2N+cdPjLA9ZF5iqwlpJui4D0=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-ms-exchange-purlcount:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         x-ms-exchange-transport-forked:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-ID:
         Content-Transfer-Encoding;
        b=L40I76mlZ05lBeDIcjMYLBwWesMLhh+oG/xus/0mwQYMoi/U9OlemwnlfPDO9f1po
         Sjj+JgKcymQ25VS0bB/ByuQIuKbOBQcLll8hNpH9/QBTzDw7wJbjivRrBlgE1WvVxj
         mzc+KsXvWwtNvF6XibMEtvgKy5Xlqe2Im7ErmkxcJ6VRDVM5IsZSe4zKIRmuLWmYTF
         1q79l4ANYJQU/LDuoSfS+CnCEnH1tmWpGybf1QKgodsAHEW28pFwGVz3P+FjEKuJNm
         hrM/DcUqLiOl5mhuqpq+nJ4C+oIiNab9AM7zR7TtG2NI9IKrSFi5BnxiaFAkN3m6pT
         xTNDPknldG2lg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTIwIGF0IDEwOjQ2ICswMjAwLCBWbGFzdGltaWwgQmFia2Egd3JvdGU6
DQo+ID4gVGhpcyBwYXRjaCBpcyBsYXJnZWx5IGJhc2VkIG9uIGlkZWFzIGZyb20gTWljaGFsIEhv
Y2tvIHBvc3RlZCBoZXJlOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1tLzIw
MTYxMjMwMTMxNDEyLkdJMTMzMDFAZGhjcDIyLnN1c2UuY3ovDQo+ID4gDQo+ID4gVGVzdGluZyBk
b25lIChvbiB4ODYpOg0KPiA+ICAgLSBTZXQgL3N5cy9rZXJuZWwvbW0vY29tcGFjdGlvbi9vcmRl
ci05L2V4dGZyYWdfe2xvdyxoaWdofSA9IHsyNSwgMzB9DQo+ID4gICByZXNwZWN0aXZlbHkuDQo+
ID4gICAtIFVzZSBhIHRlc3QgcHJvZ3JhbSB0byBmcmFnbWVudCBtZW1vcnk6IHRoZSBwcm9ncmFt
IGFsbG9jYXRlcyBhbGwNCj4gPiBtZW1vcnkNCj4gPiAgIGFuZCB0aGVuIGZvciBlYWNoIDJNIGFs
aWduZWQgc2VjdGlvbiwgZnJlZXMgMy80IG9mIGJhc2UgcGFnZXMgdXNpbmcNCj4gPiAgIG11bm1h
cC4NCj4gPiAgIC0ga2NvbXBhY3RkMCBkZXRlY3RzIGZyYWdtZW50YXRpb24gZm9yIG9yZGVyLTkg
PiBleHRmcmFnX2hpZ2ggYW5kIHN0YXJ0cw0KPiA+ICAgY29tcGFjdGlvbiB0aWxsIGV4dGZyYWcg
PCBleHRmcmFnX2xvdyBmb3Igb3JkZXItOS4NCj4gPiANCj4gPiBUaGUgcGF0Y2ggaGFzIHBsZW50
eSBvZiByb3VnaCBlZGdlcyBidXQgcG9zdGluZyBpdCBlYXJseSB0byBzZWUgaWYgSSdtDQo+ID4g
Z29pbmcgaW4gdGhlIHJpZ2h0IGRpcmVjdGlvbiBhbmQgdG8gZ2V0IHNvbWUgZWFybHkgZmVlZGJh
Y2suDQo+IA0KPiBUaGF0J3MgYSBsb3Qgb2YgY29udHJvbCBrbm9icyAtIGhvdyBpcyBhbiBhZG1p
biBzdXBwb3NlZCB0byB0dW5lIHRoZW0gdG8NCj4gdGhlaXINCj4gbmVlZHM/DQoNCg0KWWVzLCBp
dCdzIGRpZmZpY3VsdCBmb3IgYW4gYWRtaW4gdG8gZ2V0IHNvIG1hbnkgdHVuYWJsZSByaWdodCB1
bmxlc3MNCnRhcmdldGluZyBhIHZlcnkgc3BlY2lmaWMgd29ya2xvYWQuDQoNCkhvdyBhYm91dCBh
IHNpbXBsZXIgc29sdXRpb24gd2hlcmUgd2UgZXhwb3NlZCBqdXN0IG9uZSB0dW5hYmxlIHBlci1u
b2RlOg0KICAgL3N5cy8uLi4vbm9kZS14L2NvbXBhY3Rpb25fZWZmb3J0DQp3aGljaCBhY2NlcHRz
IFswLCAxMDBdDQoNClRoaXMgcGFyYWxsZWxzIC9wcm9jL3N5cy92bS9zd2FwcGluZXNzIGJ1dCBm
b3IgY29tcGFjdGlvbi4gV2l0aCB0aGlzDQpzaW5nbGUgbnVtYmVyLCB3ZSBjYW4gZXN0aW1hdGUg
cGVyLW9yZGVyIFtsb3csIGhpZ2hdIHdhdGVybWFya3MgZm9yIGV4dGVybmFsDQpmcmFnbWVudGF0
aW9uIGxpa2UgdGhpczoNCiAtIEZvciBub3csIG1hcCB0aGlzIHJhbmdlIHRvIFtsb3csIG1lZGl1
bSwgaGlnaF0gd2hpY2ggY29ycmVwb25kcyB0byBzcGVjaWZpYw0KbG93LCBoaWdoIHRocmVzaG9s
ZHMgZm9yIGV4dGZyYWcuDQogLSBBcHBseSBtb3JlIHJlbGF4ZWQgdGhyZXNob2xkcyBmb3IgaGln
aGVyLW9yZGVyIHRoYW4gZm9yIGxvd2VyIG9yZGVycy4NCg0KV2l0aCB0aGlzIHNpbmdsZSB0dW5h
YmxlIHdlIHJlbW92ZSB0aGUgYnVyZGVuIG9mIHNldHRpbmcgcGVyLW9yZGVyIGV4cGxpY2l0DQpb
bG93LCBoaWdoXSB0aHJlc2hvbGRzIGFuZCBpdCBzaG91bGQgYmUgZWFzaWVyIHRvIGV4cGVyaW1l
bnQgd2l0aC4NCg0KLU5pdGluDQoNCg0KDQo=
