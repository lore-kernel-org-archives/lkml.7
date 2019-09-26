Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361DFC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D94217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cKAIyi+8";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cKAIyi+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfIZKAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:00:47 -0400
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:50277
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725802AbfIZKAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdPfW4ff3Zj81yfxpy6w5d0ccMOB7k5ZxPUx2U4Agf0=;
 b=cKAIyi+8LzloB9Oq6KLIp5jz12CE9m4R59BlTzncClSA5oeDfICB+/iqd2gyA/+kvQMcz7c2LfZ/b2yLytVv5V6X4nW69JMq5B92sapU5UXklhvasg9jo/2n1ECDX+yjJNZqbFmCw1AGctvOc0WchvL/TzxE2QtryFQDTAgYtMM=
Received: from DB6PR0802CA0038.eurprd08.prod.outlook.com (2603:10a6:4:a3::24)
 by DB6PR0802MB2358.eurprd08.prod.outlook.com (2603:10a6:4:89::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.25; Thu, 26 Sep
 2019 10:00:37 +0000
Received: from VE1EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by DB6PR0802CA0038.outlook.office365.com
 (2603:10a6:4:a3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.15 via Frontend
 Transport; Thu, 26 Sep 2019 10:00:36 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT017.mail.protection.outlook.com (10.152.18.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15 via Frontend Transport; Thu, 26 Sep 2019 10:00:35 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Thu, 26 Sep 2019 10:00:30 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bfc151954f27d0d9
X-CR-MTA-TID: 64aa7808
Received: from 939709478a78.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.6.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D48DFA55-5B13-41A6-98FC-E5C9308F5672.1;
        Thu, 26 Sep 2019 10:00:24 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2054.outbound.protection.outlook.com [104.47.6.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 939709478a78.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Thu, 26 Sep 2019 10:00:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjVSwEV5YAwPg7n3TKb+jz0zk2XlkijEgBYhW2lBOmbNxfwtS88gMEMepy32logPZhAtnm0k1yJ/8s0/H3Lva4ZvTq/Aw1+ye/UI1QzyAEcZRyaCGfCWZzXlZc2DWLmHJNSrNNDKbE4Ge1FyII7Kcd/HjQL/omEbVSl8J7GleAudO3UvDkaQVKi6dD8AbMwuWm0ObnIpndJBy7I7igmn+BJMg3DAjY4klhci9mk4jJ1iqGHhhKjRZ+NSflT3qbHwUGeVllWqaTWEWG9+FQNAq3c7rCgIv91fH+8pKeUrEywPXF3nzkIMh7sM2GyKpnicOJ40sciNloJ6meSm1XZHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdPfW4ff3Zj81yfxpy6w5d0ccMOB7k5ZxPUx2U4Agf0=;
 b=CuR8s9tu/09LRIf7Q8LMn+VrGlmqRviWl3SMNXl7ZSCyKwYC4qY2kvO2IuqqVsfBbs0P2rD5u5lJARqEXAPaqmvNOXMRaSYXbc2ITDXj/eU0C+v846Q4skBM5GX7VY5DYSFpaNGFJytDao+aU5lY/v+UlQeb8K08Ap1Z6a7Wzaq5+Om1OWlO9Y5k7JAoJlugMR4AUGO89efbBBl2Y+zHkukk2P2iT9RBO+7WGyozIUURWSIUppx2EwU0qVsk33ZvhJzjhmHdxBFuxbL6bf5lj1k61vdOhk77/F4utlC16fUcvswlIOQBg5sQCa/g0engtA7Y/gRwjo7UB26AGl90Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdPfW4ff3Zj81yfxpy6w5d0ccMOB7k5ZxPUx2U4Agf0=;
 b=cKAIyi+8LzloB9Oq6KLIp5jz12CE9m4R59BlTzncClSA5oeDfICB+/iqd2gyA/+kvQMcz7c2LfZ/b2yLytVv5V6X4nW69JMq5B92sapU5UXklhvasg9jo/2n1ECDX+yjJNZqbFmCw1AGctvOc0WchvL/TzxE2QtryFQDTAgYtMM=
Received: from AM7PR08MB5477.eurprd08.prod.outlook.com (10.141.174.204) by
 AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.21; Thu, 26 Sep 2019 10:00:22 +0000
Received: from AM7PR08MB5477.eurprd08.prod.outlook.com
 ([fe80::30f7:f7:791c:fa30]) by AM7PR08MB5477.eurprd08.prod.outlook.com
 ([fe80::30f7:f7:791c:fa30%3]) with mapi id 15.20.2284.028; Thu, 26 Sep 2019
 10:00:22 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v2 1/2] drm/komeda: Add line size support
Thread-Topic: [PATCH v2 1/2] drm/komeda: Add line size support
Thread-Index: AQHVcq4qSU8pTvlChUyRI22n1SYZCKc8MZkAgAGLbgA=
Date:   Thu, 26 Sep 2019 10:00:22 +0000
Message-ID: <20190926100016.GA32449@lowli01-ThinkStation-P300>
References: <20190924080022.19250-1-lowry.li@arm.com>
 <20190924080022.19250-2-lowry.li@arm.com>
 <20190925102456.njecolasjwsfrvel@e110455-lin.cambridge.arm.com>
In-Reply-To: <20190925102456.njecolasjwsfrvel@e110455-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::20) To AM7PR08MB5477.eurprd08.prod.outlook.com
 (2603:10a6:20b:10f::12)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 3d5cc815-8931-42df-06c6-08d742686030
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM7PR08MB5494;
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:|AM7PR08MB5494:|DB6PR0802MB2358:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2358C5A82BC2257B898932CB9F860@DB6PR0802MB2358.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 0172F0EF77
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(51914003)(33656002)(478600001)(26005)(66556008)(6246003)(66946007)(256004)(58126008)(52116002)(2906002)(25786009)(6862004)(486006)(6486002)(81156014)(81166006)(9686003)(6512007)(14454004)(229853002)(76176011)(99286004)(5660300002)(66476007)(8676002)(446003)(6436002)(476003)(11346002)(8936002)(305945005)(6116002)(1076003)(3846002)(55236004)(316002)(64756008)(186003)(102836004)(33716001)(7736002)(4326008)(86362001)(71200400001)(6506007)(386003)(66066001)(6636002)(71190400001)(54906003)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5494;H:AM7PR08MB5477.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: ijZ6SLxgJx25Y2ZIrHGrwbWtDrFOv+BG8/YdVivBWSN+ZbfJcV2phnGTyzv8C2ClcSyp3Pm7xXsrlnuHLCjEyTeTprpAIzl18qjPPcI07slszcRpqWUggkjEI2piar3qYndJH1XAK5wOPziO6duc1xEvW+kd+ukKp1UeakwSSdmeham+EeRQogRwCslcldCi71f9MwDRQpXaE3yqi9SmGB3AaplJemzCavEU2vl4BuggrqRx6LRf1lH/+1UgHc55CGilAcXEO0YvvKSK93LE3sI+rQO7eOWJouRyTBXvDGPxcJ9D27brUPOKz411SSWG8y9jxF8x+ohO9te7y46Hq+/czK11+Y/KJ26OKnsW7Wk27Vht+YquIM5OF8QsiKv+IidJWPXrQB585HkFgfRl8JXfnjsoy2jCmWCmXoVm4TA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A607E0B608ABC44A79B56DAD4019A5B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(39860400002)(396003)(376002)(136003)(51914003)(189003)(199004)(25786009)(47776003)(6506007)(386003)(66066001)(99286004)(33716001)(6862004)(102836004)(6116002)(476003)(3846002)(76176011)(305945005)(26005)(50466002)(7736002)(58126008)(316002)(36906005)(356004)(23676004)(2906002)(4326008)(2486003)(54906003)(22756006)(478600001)(33656002)(86362001)(436003)(14454004)(76130400001)(70206006)(446003)(1076003)(63350400001)(8936002)(11346002)(486006)(186003)(70586007)(6486002)(6246003)(229853002)(5660300002)(336012)(6636002)(26826003)(126002)(8676002)(6512007)(9686003)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2358;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 74d95d0d-51a0-4841-e9a0-08d742685884
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB6PR0802MB2358;
NoDisclaimer: True
X-Forefront-PRVS: 0172F0EF77
X-Microsoft-Antispam-Message-Info: Kz7wHGOPyBVx5z9uP4xoYo9JhB2QNdmKpKsytG6FdzQovgb7CgMHGQU/oa/Q3PiXdz4+cxdLtZVaER4qetUAgrXoNtGo6RfkDP2pocinD9RKazW25rvU8za+FPa9Ww8vxRUEw2v8txl53sAGk00DYskocgE1pFuENsaYOoO0uvUSDD30AuwKakOtaNjuiEBJmajpTPtveaAzBQ0691+Th+uanT9jXJQThXTr+6jUqOX0VGd8k22ermsTRAAJY3+qozPSgwU5dJmb0A98Nk6OSoZjtmBtwnpSyItGtizgfQwaFu/YJs6YWpWKqpMhRB/WFCpwCyseLvh7yhIsFS+hkukkM/XzC7oHNJSDUk4Ma2gUtIfsCuvEr8Xl/+yaHtpaeRlfh1a/OV9s9B22ztF1N1/cGKsK9gbnOwI4FWMMR9o=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:00:35.2615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5cc815-8931-42df-06c6-08d742686030
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2358
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTG93cnksDQpPbiBXZWQsIFNlcCAyNSwgMjAxOSBhdCAxMDoyNDo1OEFNICswMDAwLCBMaXZp
dSBEdWRhdSB3cm90ZToNCj4gSGkgTG93cnksDQo+IA0KPiBPbiBUdWUsIFNlcCAyNCwgMjAxOSBh
dCAwODowMDo0NEFNICswMDAwLCBMb3dyeSBMaSAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpIHdyb3Rl
Og0KPiA+IEZyb206ICJMb3dyeSBMaSAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpIiA8TG93cnkuTGlA
YXJtLmNvbT4NCj4gPiANCj4gPiBPbiBENzEsIHdlIGFyZSB1c2luZyB0aGUgZ2xvYmFsIGxpbmUg
c2l6ZS4gRnJvbSBEMzIsIGV2ZXJ5DQo+ID4gY29tcG9uZW50IGhhdmUgYSBsaW5lIHNpemUgcmVn
aXN0ZXIgdG8gaW5kaWNhdGUgdGhlIGZpZm8gc2l6ZS4NCj4gPiANCj4gPiBTbyB0aGlzIHBhdGNo
IGlzIHRvIHNldCBsaW5lIHNpemUgc3VwcG9ydCBhbmQgZG8gdGhlIGxpbmUgc2l6ZQ0KPiA+IGNo
ZWNrLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IExvd3J5IExpIChBcm0gVGVjaG5vbG9neSBD
aGluYSkgPGxvd3J5LmxpQGFybS5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9hcm0vZGlzcGxheS9r
b21lZGEvZDcxL2Q3MV9jb21wb25lbnQuYyAgICB8IDU3ICsrKysrKysrKysrKysrKystLS0NCj4g
PiAgLi4uL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2Q3MS9kNzFfcmVncy5oIHwgIDkgKy0t
DQo+ID4gIC4uLi9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9waXBlbGluZS5oICB8ICAy
ICsNCj4gPiAgLi4uL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9waXBlbGluZV9zdGF0ZS5jICAgIHwg
MTcgKysrKysrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgNzAgaW5zZXJ0aW9ucygrKSwgMTUgZGVs
ZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlz
cGxheS9rb21lZGEvZDcxL2Q3MV9jb21wb25lbnQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlz
cGxheS9rb21lZGEvZDcxL2Q3MV9jb21wb25lbnQuYw0KPiA+IGluZGV4IDdiMzc0YTNiOTExZS4u
MzU3ODM3YjlkNmVkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxh
eS9rb21lZGEvZDcxL2Q3MV9jb21wb25lbnQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
cm0vZGlzcGxheS9rb21lZGEvZDcxL2Q3MV9jb21wb25lbnQuYw0KPiA+IEBAIC0xMDYsNiArMTA2
LDIzIEBAIHN0YXRpYyB2b2lkIGR1bXBfYmxvY2tfaGVhZGVyKHN0cnVjdCBzZXFfZmlsZSAqc2Ys
IHZvaWQgX19pb21lbSAqcmVnKQ0KPiA+ICAJCQkgICBpLCBoZHIub3V0cHV0X2lkc1tpXSk7DQo+
ID4gIH0NCj4gPiAgDQo+ID4gKy8qIE9uIEQ3MSwgd2UgYXJlIHVzaW5nIHRoZSBnbG9iYWwgbGlu
ZSBzaXplLiBGcm9tIEQzMiwgZXZlcnkgY29tcG9uZW50IGhhdmUNCj4gPiArICogYSBsaW5lIHNp
emUgcmVnaXN0ZXIgdG8gaW5kaWNhdGUgdGhlIGZpZm8gc2l6ZS4NCj4gPiArICovDQo+ID4gK3N0
YXRpYyB1MzIgX19nZXRfYmxrX2xpbmVfc2l6ZShzdHJ1Y3QgZDcxX2RldiAqZDcxLCB1MzIgX19p
b21lbSAqcmVnLA0KPiA+ICsJCQkgICAgICAgdTMyIG1heF9kZWZhdWx0KQ0KPiA+ICt7DQo+ID4g
KwlpZiAoIWQ3MS0+cGVyaXBoX2FkZHIpDQo+ID4gKwkJbWF4X2RlZmF1bHQgPSBtYWxpZHBfcmVh
ZDMyKHJlZywgQkxLX01BWF9MSU5FX1NJWkUpOw0KPiA+ICsNCj4gPiArCXJldHVybiBtYXhfZGVm
YXVsdDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHUzMiBnZXRfYmxrX2xpbmVfc2l6ZShz
dHJ1Y3QgZDcxX2RldiAqZDcxLCB1MzIgX19pb21lbSAqcmVnKQ0KPiA+ICt7DQo+ID4gKwlyZXR1
cm4gX19nZXRfYmxrX2xpbmVfc2l6ZShkNzEsIHJlZywgZDcxLT5tYXhfbGluZV9zaXplKTsNCj4g
PiArfQ0KPiANCj4gSSBrbm93IHlvdSdyZSB0cnlpbmcgdG8gc2F2ZSB0eXBpbmcgdGhlIGV4dHJh
IHBhcmFtZXRlciwgYnV0IGxvb2tpbmcgYXQgdGhlIHJlc3Qgb2YNCj4gdGhlIGRpZmYgSSB0aGlu
ayBpdCB3b3VsZCBsb29rIGJldHRlciBpZiB5b3UgZ2V0IHJpZCBvZiBnZXRfYmxrX2xpbmVfc2l6
ZSgpIGZ1bmN0aW9uDQo+IGFuZCB1c2UgdGhlIG5hbWUgZm9yIHRoZSBmdW5jdGlvbiB3aXRoIDMg
cGFyYW1ldGVycy4NCj4gDQo+IE90aGVyd2lzZSwgcGF0Y2ggbG9va3MgZ29vZCB0byBtZS4NCj4g
DQo+IFJldmlld2VkLWJ5OiBMaXZpdSBEdWRhdSA8bGl2aXUuZHVkYXVAYXJtLmNvbT4NCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gTGl2aXUNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLg0KQnV0IGNv
bnNpZGVyaW5nIGZyb20gRDMyIGV2ZXJ5IGNvbXBvbmVudCBoYXZlIGEgbGluZSBzaXplIHJlZ2lz
dGVyDQphbmQgbm8gbmVlZCBkZWZhdWx0IHZhbHVlLCBzbyB3ZSBoYXZlIGdldF9ibGtfbGluZV9z
aXplKCkgd2l0aG91dA0KZGVmYXVsdCBhcmd1bWVudCBhbmQgYWxzbyBjYW4gc2F2ZSBzb21lIHR5
cGluZyBhbmQgbGluZXMuIFRoYXQncw0Kd2h5IHdlIHdhbnQgdG8ga2VlcCBfX2dldF9ibGtfbGlu
ZV9zaXplKCkuDQoNCj4gPiArDQo+ID4gIHN0YXRpYyB1MzIgdG9fcm90X2N0cmwodTMyIHJvdCkN
Cj4gPiAgew0KPiA+ICAJdTMyIGxyX2N0cmwgPSAwOw0KPiA+IEBAIC0zNjUsNyArMzgyLDI4IEBA
IHN0YXRpYyBpbnQgZDcxX2xheWVyX2luaXQoc3RydWN0IGQ3MV9kZXYgKmQ3MSwNCj4gPiAgCWVs
c2UNCj4gPiAgCQlsYXllci0+bGF5ZXJfdHlwZSA9IEtPTUVEQV9GTVRfU0lNUExFX0xBWUVSOw0K
PiA+ICANCj4gPiAtCXNldF9yYW5nZSgmbGF5ZXItPmhzaXplX2luLCA0LCBkNzEtPm1heF9saW5l
X3NpemUpOw0KPiA+ICsJaWYgKCFkNzEtPnBlcmlwaF9hZGRyKSB7DQo+ID4gKwkJLyogRDMyIG9y
IG5ld2VyIHByb2R1Y3QgKi8NCj4gPiArCQlsYXllci0+bGluZV9zeiA9IG1hbGlkcF9yZWFkMzIo
cmVnLCBCTEtfTUFYX0xJTkVfU0laRSk7DQo+ID4gKwkJbGF5ZXItPnl1dl9saW5lX3N6ID0gTF9J
TkZPX1lVVl9NQVhfTElORVNaKGxheWVyX2luZm8pOw0KPiA+ICsJfSBlbHNlIGlmIChkNzEtPm1h
eF9saW5lX3NpemUgPiAyMDQ4KSB7DQo+ID4gKwkJLyogRDcxIDRLICovDQo+ID4gKwkJbGF5ZXIt
PmxpbmVfc3ogPSBkNzEtPm1heF9saW5lX3NpemU7DQo+ID4gKwkJbGF5ZXItPnl1dl9saW5lX3N6
ID0gbGF5ZXItPmxpbmVfc3ogLyAyOw0KPiA+ICsJfSBlbHNlCXsNCj4gPiArCQkvKiBENzEgMksg
Ki8NCj4gPiArCQlpZiAobGF5ZXItPmxheWVyX3R5cGUgPT0gS09NRURBX0ZNVF9SSUNIX0xBWUVS
KSB7DQo+ID4gKwkJCS8qIHJpY2ggbGF5ZXIgaXMgNEsgY29uZmlndXJhdGlvbiAqLw0KPiA+ICsJ
CQlsYXllci0+bGluZV9zeiA9IGQ3MS0+bWF4X2xpbmVfc2l6ZSAqIDI7DQo+ID4gKwkJCWxheWVy
LT55dXZfbGluZV9zeiA9IGxheWVyLT5saW5lX3N6IC8gMjsNCj4gPiArCQl9IGVsc2Ugew0KPiA+
ICsJCQlsYXllci0+bGluZV9zeiA9IGQ3MS0+bWF4X2xpbmVfc2l6ZTsNCj4gPiArCQkJbGF5ZXIt
Pnl1dl9saW5lX3N6ID0gMDsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJc2V0X3Jh
bmdlKCZsYXllci0+aHNpemVfaW4sIDQsIGxheWVyLT5saW5lX3N6KTsNCj4gPiArDQo+ID4gIAlz
ZXRfcmFuZ2UoJmxheWVyLT52c2l6ZV9pbiwgNCwgZDcxLT5tYXhfdnNpemUpOw0KPiA+ICANCj4g
PiAgCW1hbGlkcF93cml0ZTMyKHJlZywgTEFZRVJfUEFMUEhBLCBENzFfUEFMUEhBX0RFRl9NQVAp
Ow0KPiA+IEBAIC00NTYsOSArNDk0LDExIEBAIHN0YXRpYyBpbnQgZDcxX3diX2xheWVyX2luaXQo
c3RydWN0IGQ3MV9kZXYgKmQ3MSwNCj4gPiAgDQo+ID4gIAl3Yl9sYXllciA9IHRvX2xheWVyKGMp
Ow0KPiA+ICAJd2JfbGF5ZXItPmxheWVyX3R5cGUgPSBLT01FREFfRk1UX1dCX0xBWUVSOw0KPiA+
ICsJd2JfbGF5ZXItPmxpbmVfc3ogPSBnZXRfYmxrX2xpbmVfc2l6ZShkNzEsIHJlZyk7DQo+ID4g
Kwl3Yl9sYXllci0+eXV2X2xpbmVfc3ogPSB3Yl9sYXllci0+bGluZV9zejsNCj4gPiAgDQo+ID4g
LQlzZXRfcmFuZ2UoJndiX2xheWVyLT5oc2l6ZV9pbiwgRDcxX01JTl9MSU5FX1NJWkUsIGQ3MS0+
bWF4X2xpbmVfc2l6ZSk7DQo+ID4gLQlzZXRfcmFuZ2UoJndiX2xheWVyLT52c2l6ZV9pbiwgRDcx
X01JTl9WRVJUSUNBTF9TSVpFLCBkNzEtPm1heF92c2l6ZSk7DQo+ID4gKwlzZXRfcmFuZ2UoJndi
X2xheWVyLT5oc2l6ZV9pbiwgNjQsIHdiX2xheWVyLT5saW5lX3N6KTsNCj4gPiArCXNldF9yYW5n
ZSgmd2JfbGF5ZXItPnZzaXplX2luLCA2NCwgZDcxLT5tYXhfdnNpemUpOw0KPiA+ICANCj4gPiAg
CXJldHVybiAwOw0KPiA+ICB9DQo+ID4gQEAgLTU5NSw4ICs2MzUsOCBAQCBzdGF0aWMgaW50IGQ3
MV9jb21waXpfaW5pdChzdHJ1Y3QgZDcxX2RldiAqZDcxLA0KPiA+ICANCj4gPiAgCWNvbXBpeiA9
IHRvX2NvbXBpeihjKTsNCj4gPiAgDQo+ID4gLQlzZXRfcmFuZ2UoJmNvbXBpei0+aHNpemUsIEQ3
MV9NSU5fTElORV9TSVpFLCBkNzEtPm1heF9saW5lX3NpemUpOw0KPiA+IC0Jc2V0X3JhbmdlKCZj
b21waXotPnZzaXplLCBENzFfTUlOX1ZFUlRJQ0FMX1NJWkUsIGQ3MS0+bWF4X3ZzaXplKTsNCj4g
PiArCXNldF9yYW5nZSgmY29tcGl6LT5oc2l6ZSwgNjQsIGdldF9ibGtfbGluZV9zaXplKGQ3MSwg
cmVnKSk7DQo+ID4gKwlzZXRfcmFuZ2UoJmNvbXBpei0+dnNpemUsIDY0LCBkNzEtPm1heF92c2l6
ZSk7DQo+ID4gIA0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiBAQCAtNzUzLDcgKzc5Myw3
IEBAIHN0YXRpYyBpbnQgZDcxX3NjYWxlcl9pbml0KHN0cnVjdCBkNzFfZGV2ICpkNzEsDQo+ID4g
IAl9DQo+ID4gIA0KPiA+ICAJc2NhbGVyID0gdG9fc2NhbGVyKGMpOw0KPiA+IC0Jc2V0X3Jhbmdl
KCZzY2FsZXItPmhzaXplLCA0LCAyMDQ4KTsNCj4gPiArCXNldF9yYW5nZSgmc2NhbGVyLT5oc2l6
ZSwgNCwgX19nZXRfYmxrX2xpbmVfc2l6ZShkNzEsIHJlZywgMjA0OCkpOw0KPiA+ICAJc2V0X3Jh
bmdlKCZzY2FsZXItPnZzaXplLCA0LCA0MDk2KTsNCj4gPiAgCXNjYWxlci0+bWF4X2Rvd25zY2Fs
aW5nID0gNjsNCj4gPiAgCXNjYWxlci0+bWF4X3Vwc2NhbGluZyA9IDY0Ow0KPiA+IEBAIC04NjIs
NyArOTAyLDcgQEAgc3RhdGljIGludCBkNzFfc3BsaXR0ZXJfaW5pdChzdHJ1Y3QgZDcxX2RldiAq
ZDcxLA0KPiA+ICANCj4gPiAgCXNwbGl0dGVyID0gdG9fc3BsaXR0ZXIoYyk7DQo+ID4gIA0KPiA+
IC0Jc2V0X3JhbmdlKCZzcGxpdHRlci0+aHNpemUsIDQsIGQ3MS0+bWF4X2xpbmVfc2l6ZSk7DQo+
ID4gKwlzZXRfcmFuZ2UoJnNwbGl0dGVyLT5oc2l6ZSwgNCwgZ2V0X2Jsa19saW5lX3NpemUoZDcx
LCByZWcpKTsNCj4gPiAgCXNldF9yYW5nZSgmc3BsaXR0ZXItPnZzaXplLCA0LCBkNzEtPm1heF92
c2l6ZSk7DQo+ID4gIA0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gQEAgLTkzMyw3ICs5NzMsOCBAQCBz
dGF0aWMgaW50IGQ3MV9tZXJnZXJfaW5pdChzdHJ1Y3QgZDcxX2RldiAqZDcxLA0KPiA+ICANCj4g
PiAgCW1lcmdlciA9IHRvX21lcmdlcihjKTsNCj4gPiAgDQo+ID4gLQlzZXRfcmFuZ2UoJm1lcmdl
ci0+aHNpemVfbWVyZ2VkLCA0LCA0MDMyKTsNCj4gPiArCXNldF9yYW5nZSgmbWVyZ2VyLT5oc2l6
ZV9tZXJnZWQsIDQsDQo+ID4gKwkJICBfX2dldF9ibGtfbGluZV9zaXplKGQ3MSwgcmVnLCA0MDMy
KSk7DQo+ID4gIAlzZXRfcmFuZ2UoJm1lcmdlci0+dnNpemVfbWVyZ2VkLCA0LCA0MDk2KTsNCj4g
PiAgDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Fy
bS9kaXNwbGF5L2tvbWVkYS9kNzEvZDcxX3JlZ3MuaCBiL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlz
cGxheS9rb21lZGEvZDcxL2Q3MV9yZWdzLmgNCj4gPiBpbmRleCAyZDVlNmQwMGI0MmMuLjE3Mjdk
Yzk5MzkwOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29t
ZWRhL2Q3MS9kNzFfcmVncy5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5
L2tvbWVkYS9kNzEvZDcxX3JlZ3MuaA0KPiA+IEBAIC0xMCw2ICsxMCw3IEBADQo+ID4gIC8qIENv
bW1vbiBibG9jayByZWdpc3RlcnMgb2Zmc2V0ICovDQo+ID4gICNkZWZpbmUgQkxLX0JMT0NLX0lO
Rk8JCTB4MDAwDQo+ID4gICNkZWZpbmUgQkxLX1BJUEVMSU5FX0lORk8JMHgwMDQNCj4gPiArI2Rl
ZmluZSBCTEtfTUFYX0xJTkVfU0laRQkweDAwOA0KPiA+ICAjZGVmaW5lIEJMS19WQUxJRF9JTlBV
VF9JRDAJMHgwMjANCj4gPiAgI2RlZmluZSBCTEtfT1VUUFVUX0lEMAkJMHgwNjANCj4gPiAgI2Rl
ZmluZSBCTEtfSU5QVVRfSUQwCQkweDA4MA0KPiA+IEBAIC0zMjEsNiArMzIyLDcgQEANCj4gPiAg
I2RlZmluZSBMX0lORk9fUkYJCUJJVCgwKQ0KPiA+ICAjZGVmaW5lIExfSU5GT19DTQkJQklUKDEp
DQo+ID4gICNkZWZpbmUgTF9JTkZPX0FCVUZfU0laRSh4KQkoKCh4KSA+PiA0KSAmIDB4NykNCj4g
PiArI2RlZmluZSBMX0lORk9fWVVWX01BWF9MSU5FU1ooeCkJKCgoeCkgPj4gMTYpICYgMHhGRkZG
KQ0KPiA+ICANCj4gPiAgLyogU2NhbGVyIHJlZ2lzdGVycyAqLw0KPiA+ICAjZGVmaW5lIFNDX0NP
RUZGVEFCCQkweDBEQw0KPiA+IEBAIC00OTQsMTMgKzQ5Niw2IEBAIGVudW0gZDcxX2Jsa190eXBl
IHsNCj4gPiAgI2RlZmluZSBENzFfREVGQVVMVF9QUkVQUkVUQ0hfTElORQk1DQo+ID4gICNkZWZp
bmUgRDcxX0JVU19XSURUSF8xNl9CWVRFUwkJMTYNCj4gPiAgDQo+ID4gLSNkZWZpbmUgRDcxX01J
Tl9MSU5FX1NJWkUJCTY0DQo+ID4gLSNkZWZpbmUgRDcxX01JTl9WRVJUSUNBTF9TSVpFCQk2NA0K
PiA+IC0jZGVmaW5lIEQ3MV9TQ19NSU5fTElOX1NJWkUJCTQNCj4gPiAtI2RlZmluZSBENzFfU0Nf
TUlOX1ZFUlRJQ0FMX1NJWkUJNA0KPiA+IC0jZGVmaW5lIEQ3MV9TQ19NQVhfTElOX1NJWkUJCTIw
NDgNCj4gPiAtI2RlZmluZSBENzFfU0NfTUFYX1ZFUlRJQ0FMX1NJWkUJNDA5Ng0KPiA+IC0NCj4g
PiAgI2RlZmluZSBENzFfU0NfTUFYX1VQU0NBTElORwkJNjQNCj4gPiAgI2RlZmluZSBENzFfU0Nf
TUFYX0RPV05TQ0FMSU5HCQk2DQo+ID4gICNkZWZpbmUgRDcxX1NDX1NQTElUX09WRVJMQVAJCTgN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21l
ZGFfcGlwZWxpbmUuaCBiL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRh
X3BpcGVsaW5lLmgNCj4gPiBpbmRleCA5MTBkMjc5YWU0OGQuLjkyYWJhNThjZTJhNSAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9waXBl
bGluZS5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21l
ZGFfcGlwZWxpbmUuaA0KPiA+IEBAIC0yMjcsNiArMjI3LDggQEAgc3RydWN0IGtvbWVkYV9sYXll
ciB7DQo+ID4gIAkvKiBhY2NlcHRlZCBoL3YgaW5wdXQgcmFuZ2UgYmVmb3JlIHJvdGF0aW9uICov
DQo+ID4gIAlzdHJ1Y3QgbWFsaWRwX3JhbmdlIGhzaXplX2luLCB2c2l6ZV9pbjsNCj4gPiAgCXUz
MiBsYXllcl90eXBlOyAvKiBSSUNILCBTSU1QTEUgb3IgV0IgKi8NCj4gPiArCXUzMiBsaW5lX3N6
Ow0KPiA+ICsJdTMyIHl1dl9saW5lX3N6OyAvKiBtYXhpbXVtIGxpbmUgc2l6ZSBmb3IgWVVWNDIy
IGFuZCBZVVY0MjAgKi8NCj4gPiAgCXUzMiBzdXBwb3J0ZWRfcm90czsNCj4gPiAgCS8qIGtvbWVk
YSBzdXBwb3J0cyBsYXllciBzcGxpdCB3aGljaCBzcGxpdHMgYSB3aG9sZSBpbWFnZSB0byB0d28g
cGFydHMNCj4gPiAgCSAqIGxlZnQgYW5kIHJpZ2h0IGFuZCBoYW5kbGUgdGhlbSBieSB0d28gaW5k
aXZpZHVhbCBsYXllciBwcm9jZXNzb3JzDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX3BpcGVsaW5lX3N0YXRlLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9waXBlbGluZV9zdGF0ZS5jDQo+ID4gaW5k
ZXggNTUyNjczMWY1YTMzLi42ZGY0NDI2NjZjZmUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfcGlwZWxpbmVfc3RhdGUuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX3BpcGVsaW5lX3N0
YXRlLmMNCj4gPiBAQCAtMjg1LDYgKzI4NSw3IEBAIGtvbWVkYV9sYXllcl9jaGVja19jZmcoc3Ry
dWN0IGtvbWVkYV9sYXllciAqbGF5ZXIsDQo+ID4gIAkJICAgICAgIHN0cnVjdCBrb21lZGFfZGF0
YV9mbG93X2NmZyAqZGZsb3cpDQo+ID4gIHsNCj4gPiAgCXUzMiBzcmNfeCwgc3JjX3ksIHNyY193
LCBzcmNfaDsNCj4gPiArCXUzMiBsaW5lX3N6LCBtYXhfbGluZV9zejsNCj4gPiAgDQo+ID4gIAlp
ZiAoIWtvbWVkYV9mYl9pc19sYXllcl9zdXBwb3J0ZWQoa2ZiLCBsYXllci0+bGF5ZXJfdHlwZSwg
ZGZsb3ctPnJvdCkpDQo+ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gQEAgLTMxNCw2ICszMTUs
MjIgQEAga29tZWRhX2xheWVyX2NoZWNrX2NmZyhzdHJ1Y3Qga29tZWRhX2xheWVyICpsYXllciwN
Cj4gPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiAgCX0NCj4gPiAgDQo+ID4gKwlpZiAoZHJtX3Jv
dGF0aW9uXzkwX29yXzI3MChkZmxvdy0+cm90KSkNCj4gPiArCQlsaW5lX3N6ID0gZGZsb3ctPmlu
X2g7DQo+ID4gKwllbHNlDQo+ID4gKwkJbGluZV9zeiA9IGRmbG93LT5pbl93Ow0KPiA+ICsNCj4g
PiArCWlmIChrZmItPmJhc2UuZm9ybWF0LT5oc3ViID4gMSkNCj4gPiArCQltYXhfbGluZV9zeiA9
IGxheWVyLT55dXZfbGluZV9zejsNCj4gPiArCWVsc2UNCj4gPiArCQltYXhfbGluZV9zeiA9IGxh
eWVyLT5saW5lX3N6Ow0KPiA+ICsNCj4gPiArCWlmIChsaW5lX3N6ID4gbWF4X2xpbmVfc3opIHsN
Cj4gPiArCQlEUk1fREVCVUdfQVRPTUlDKCJSZXF1aXJlZCBsaW5lX3N6OiAlZCBleGNlZWRzIHRo
ZSBtYXggc2l6ZSAlZFxuIiwNCj4gPiArCQkJCSBsaW5lX3N6LCBtYXhfbGluZV9zeik7DQo+ID4g
KwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJcmV0dXJuIDA7DQo+ID4g
IH0NCj4gPiAgDQo+ID4gLS0gDQo+ID4gMi4xNy4xDQo+ID4gDQo+IA0KPiAtLSANCj4gPT09PT09
PT09PT09PT09PT09PT0NCj4gfCBJIHdvdWxkIGxpa2UgdG8gfA0KPiB8IGZpeCB0aGUgd29ybGQs
ICB8DQo+IHwgYnV0IHRoZXkncmUgbm90IHwNCj4gfCBnaXZpbmcgbWUgdGhlICAgfA0KPiAgXCBz
b3VyY2UgY29kZSEgIC8NCj4gICAtLS0tLS0tLS0tLS0tLS0NCj4gICAgIMKvXF8o44OEKV8vwq8N
Cg==
