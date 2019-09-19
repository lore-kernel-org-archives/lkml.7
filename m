Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4EDC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 23:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83269214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 23:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WCOOI3mF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405463AbfISXW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 19:22:27 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:2283 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392378AbfISXW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 19:22:27 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d840dae0000>; Fri, 20 Sep 2019 07:22:22 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 19 Sep 2019 16:22:22 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 19 Sep 2019 16:22:22 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Sep
 2019 23:22:21 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.56) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 19 Sep 2019 23:22:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMv/+DT4HphYHrhsZ+dwEau742a9+KRpTXhusCxOUX/TbQy+0X5TCcJhqTS+cWg+lcCKNaHZDDeMVIXOJ0jKwNrAtvVxo+InB+aaJdCbnKyvDEbuUcYxCkYLsClCF34F5OC2HmE46pZTNj9+6NYge7TLiIqIry7ESkAfKr8hA+DAiqP6D/v9WL8u4CGHcmjA862C/89zumQEeztpydDu0NCFMhhmLdydB25WoGpWPu67Gv9qVyk/4LLhAfXmiAQse8ecXpC46BFCwq5/K4Tag8mbjhNxHm0BZZfBzXFE2iVz+d53UcALbyGq0DJ0S85ZHQM4NV2MrRZ1zxpE42Xqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uP1KFcEGT02KR9tJFDEn5OVoubPZcdnXTLEpyri7KLo=;
 b=la8Yll6BAr+C4nzVriYs4iqAuyilkI+JQ+KvGqQ1RefK/LNlUV0NO21+A1RJpn3iglwdc4/r7AW9jSlLK+QLiCL/zIPs9pARNgFOAk6NhJLI1o3HcKmTZySofBcxmJ3Pwet0QuFMYxo8w4y/sv5mcMvRZUT5V8XmHpvOQLOqn6h11+OZ7ge/BxEE3aElgqVB9gDD66FR4RG3yfk6K1e6hauFMfEQfL5Pve5RkGT6mj9z6+YfW61qP5sdTUrKn5JUURH6LC5VdIg0at6RNPl4on2+x+xaD3hZpemiMNfV2OxwnGSfnzUfDDZUv9TsNsdhpI+kRn2CRy0z8jOOjvv5Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3015.namprd12.prod.outlook.com (20.178.55.78) by
 BYAPR12MB3032.namprd12.prod.outlook.com (20.178.53.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 23:22:19 +0000
Received: from BYAPR12MB3015.namprd12.prod.outlook.com
 ([fe80::2da1:b02f:cd54:eae9]) by BYAPR12MB3015.namprd12.prod.outlook.com
 ([fe80::2da1:b02f:cd54:eae9%3]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 23:22:19 +0000
From:   Nitin Gupta <nigupta@nvidia.com>
To:     "mgorman@techsingularity.net" <mgorman@techsingularity.net>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cai@lca.pw" <cai@lca.pw>,
        "arunks@codeaurora.org" <arunks@codeaurora.org>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "janne.huttunen@nokia.com" <janne.huttunen@nokia.com>,
        "jannh@google.com" <jannh@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>, "guro@fb.com" <guro@fb.com>,
        "khlebnikov@yandex-team.ru" <khlebnikov@yandex-team.ru>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [RFC] mm: Proactive compaction
Thread-Topic: [RFC] mm: Proactive compaction
Thread-Index: AQHVVHvSPOoT6GjwikqO8JNrunJOkacG5KOAgCz0jQA=
Date:   Thu, 19 Sep 2019 23:22:19 +0000
Message-ID: <9e24d3fa3098fc338bf396ffdf82555cc033ae48.camel@nvidia.com>
References: <20190816214413.15006-1-nigupta@nvidia.com>
         <20190822085135.GS2739@techsingularity.net>
In-Reply-To: <20190822085135.GS2739@techsingularity.net>
Reply-To: Nitin Gupta <nigupta@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nigupta@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d33beec-6e65-4dc9-f5d2-08d73d583794
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB3032;
x-ms-traffictypediagnostic: BYAPR12MB3032:
x-microsoft-antispam-prvs: <BYAPR12MB303288B272482DDF48406D32D8890@BYAPR12MB3032.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(39860400002)(346002)(199004)(189003)(486006)(186003)(6512007)(6916009)(2906002)(1730700003)(66066001)(66946007)(81156014)(43066004)(446003)(476003)(2616005)(64756008)(76116006)(11346002)(66476007)(2501003)(66556008)(8936002)(8676002)(66446008)(91956017)(86362001)(5660300002)(81166006)(4744005)(3846002)(54906003)(3450700001)(99286004)(76176011)(6116002)(102836004)(6506007)(7736002)(25786009)(14454004)(316002)(478600001)(5640700003)(26005)(118296001)(256004)(6486002)(2351001)(229853002)(4326008)(71200400001)(71190400001)(6246003)(36756003)(7416002)(305945005)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3032;H:BYAPR12MB3015.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LP/jRvEvA/z2in1fTq03xOnIC4nif8w4jdWzieZl9HRbe0Xjeb6ECiWONxf5+keqV/WzVoHB+2O9OVqJ6Aa4BfQV8M5XT35OpMkP4JsB7t+zq1xdrRtGc8+nL2HkBEtmSjV8cUDXlsKnFgEwXg9TclEFjDJ8SjiiGVlCaDIhU7lqzz/0NthQTGnFh/M4DYAIWAUm1u9Tqu6LVkiobiz+GxGO8zUMFOGGEoSKOrAJU+I40cxFpyF7fRVrMUxF78qBxJpL4SMSW/V1G69SI+HxTdarw+vva1Hcax4ClEA2y9EeB9d1/EBJ11Hc7OogIAlnTsDRlifkuubJwPAUG3eolIZWXoWygLm4ljI0Yq/ngnfCJdYaMuNv4/2YPU4TXLN8Xq9m/L0HVD/b5FmKqiUQ36uXm79+AJNZz9kAn0h6TkI=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d33beec-6e65-4dc9-f5d2-08d73d583794
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 23:22:19.1901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bf0xS1Es06EHqc272Bo+gRuH8ozgWSUBNYvH2qEg53C1UWJj6JxRJEfaUARuWoCQZ+L0X6NbKlBR2B6FPp5jmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3032
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F20A421D4F3A6479DECE755F56E94A9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1568935342; bh=uP1KFcEGT02KR9tJFDEn5OVoubPZcdnXTLEpyri7KLo=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
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
        b=WCOOI3mF6npddacyq3PPUWH3iy2urUe2sCJEHpinOieU8ghHbJGHY/GcYEvRyplcB
         ACYVjI7FtElh15kriwSbcnS1f15xngRxtfjT73im7jAyR+gEcVos0kCNi7u1ZiRfB9
         MCLlEdhep10soa7b7ILkCNmLEOyuzWoEfbAaRkB/2Ns/Ht7c+W29EHRKvsMZpU9Z4g
         PskwsMf94Jdt4TLf15Wu6CJTCEuOu6DIm1Xdv4awjYTeGbbopgrt+1RFXYnPNBBtMY
         xGkRcWw1C5/gXIt/RN/JdDfKOoH9uJ5jJbmW1xMYxFplc+NlIIQIMwQxsR6LIrcARO
         g8VD/RoT1qDhQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTIyIGF0IDA5OjUxICswMTAwLCBNZWwgR29ybWFuIHdyb3RlOg0KPiBB
cyB1bmFwcGVhbGluZyBhcyBpdCBzb3VuZHMsIEkgdGhpbmsgaXQgaXMgYmV0dGVyIHRvIHRyeSBp
bXByb3ZlIHRoZQ0KPiBhbGxvY2F0aW9uIGxhdGVuY3kgaXRzZWxmIGluc3RlYWQgb2YgdHJ5aW5n
IHRvIGhpZGUgdGhlIGNvc3QgaW4gYSBrZXJuZWwNCj4gdGhyZWFkLiBJdCdzIGZhciBoYXJkZXIg
dG8gaW1wbGVtZW50IGFzIGNvbXBhY3Rpb24gaXMgbm90IGVhc3kgYnV0IGl0DQo+IHdvdWxkIGJl
IG1vcmUgb2J2aW91cyB3aGF0IHRoZSBzYXZpbmdzIGFyZSBieSBsb29raW5nIGF0IGEgaGlzdG9n
cmFtIG9mDQo+IGFsbG9jYXRpb24gbGF0ZW5jaWVzIC0tIHRoZXJlIGFyZSBvdGhlciBtZXRyaWNz
IHRoYXQgY291bGQgYmUgY29uc2lkZXJlZA0KPiBidXQgdGhhdCdzIHRoZSBvYnZpb3VzIG9uZS4N
Cj4gDQoNCkRvIHlvdSBtZWFuIHJlZHVjaW5nIGFsbG9jYXRpb24gbGF0ZW5jeSBlc3BlY2lhbGx5
IHdoZW4gaXQgaGl0cyBkaXJlY3QNCmNvbXBhY3Rpb24gcGF0aD8gRG8geW91IGhhdmUgYW55IGlk
ZWFzIGluIG1pbmQgZm9yIHRoaXM/IEknbSBvcGVuIHRvDQp3b3JraW5nIG9uIHRoZW0gYW5kIHJl
cG9ydCBiYWNrIGxhdGVuY3kgbnVtbWJlcnMsIHdoaWxlIEkgdGhpbmsgbW9yZSBvbiBsZXNzDQp0
dW5hYmxlLWhlYXZ5IGJhY2tncm91bmQgKHByby1hY3RpdmUpIGNvbXBhY3Rpb24gYXBwcm9hY2hl
cy4NCg0KLU5pdGluDQoNCg==
