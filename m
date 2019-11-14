Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700FFC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247CB206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dPGeqloE";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dPGeqloE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfKNI7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:59:09 -0500
Received: from mail-eopbgr130049.outbound.protection.outlook.com ([40.107.13.49]:21311
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfKNI7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilpTs/v/bDlDFg5GYFokNi4kEq5tIzs0CqhkB5zqvbQ=;
 b=dPGeqloEibqKOmLbD44DiCJLHDa/87hB5JnxKvhMDqjvFx9rM0htpnrW7if421Zjta1gKpIKp6K+CntfqCbueJCsUmDIA8karNUmf7WROVCyWX1UApfRDforOujYyx+BFx8fuObm8TP6m1d3Zk46WGVmdd1A8pTPc5sJDZ3Ph/A=
Received: from HE1PR08CA0071.eurprd08.prod.outlook.com (2603:10a6:7:2a::42) by
 AM7PR08MB5333.eurprd08.prod.outlook.com (2603:10a6:20b:104::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Thu, 14 Nov
 2019 08:58:21 +0000
Received: from DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by HE1PR08CA0071.outlook.office365.com
 (2603:10a6:7:2a::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22 via Frontend
 Transport; Thu, 14 Nov 2019 08:58:21 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT025.mail.protection.outlook.com (10.152.20.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Thu, 14 Nov 2019 08:58:21 +0000
Received: ("Tessian outbound 0cf06bf5c60e:v33"); Thu, 14 Nov 2019 08:58:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 767106356f5cf578
X-CR-MTA-TID: 64aa7808
Received: from 93115d107804.3 (cr-mta-lb-1.cr-mta-net [104.47.14.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BE670E7C-6995-48A2-ACC9-3B4BFED7AEF2.1;
        Thu, 14 Nov 2019 08:58:15 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 93115d107804.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 14 Nov 2019 08:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4TTIrwQknLBfA//lzoCstcXqyO2BQH2Dnjrr/illn67s834m+ovUetqEv3JfotFmHQrhw6TGsH97OvMHrHorEP8CT9cIQGlUBBuFwL6lSpgGC1DmhthhePyknxc5Q9YsOhUsjHNssbDNDDgcBGmUnPfGSfWO4yxqU5Nz2RkGad5oUMd85blNSFCQeuT6c5GTJuPk3GsyHRfK1GElC1ve2t40vQoDRmUkEVr4YpEtClWSEiGk1tb4dprdRVPhab34PamUY92RWG3W+KwBMztgfR/ucBAp0+Y/cHKGuA7w6FVgcKhfKBDn6XQLgMp9I/v4AFfydS3CFB7EXyYwcGdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilpTs/v/bDlDFg5GYFokNi4kEq5tIzs0CqhkB5zqvbQ=;
 b=hrXzDueC0qfHNtPsB9pSDLvuMxdgTwaCIbJjbzVbZQCvkUW5j5b6D9dp7mWJdAg2R1m4CW5uKedxuoNSJ838tZnvcaiTRpmMZAEqpZLaBE7xrdFfsZoHI94zVULitn2No6uavccgWJN5lEEkj7JTxf3l1UfVq6793cPMDXJRA7+1KY2tqvcPSbM6pFRRDzGiUFL2FFIFNUFLWkP7XpARg+047amdg2n9bD6BVmsHfr9g9EyZsxUo+W5O2UuFfgLAxTAtaAw14Z9dDmYwUWFeSQ3L3Y4vnFxt/oAevGeKLQNg48r+W4+QuK6afqV/LYmgqIvezq94YBJZ04qfHUkDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilpTs/v/bDlDFg5GYFokNi4kEq5tIzs0CqhkB5zqvbQ=;
 b=dPGeqloEibqKOmLbD44DiCJLHDa/87hB5JnxKvhMDqjvFx9rM0htpnrW7if421Zjta1gKpIKp6K+CntfqCbueJCsUmDIA8karNUmf7WROVCyWX1UApfRDforOujYyx+BFx8fuObm8TP6m1d3Zk46WGVmdd1A8pTPc5sJDZ3Ph/A=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4718.eurprd08.prod.outlook.com (10.255.113.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Thu, 14 Nov 2019 08:58:14 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::a809:417a:faf3:61a7%6]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 08:58:14 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "lowryli@arm.com" <lowryli@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: =?utf-8?B?UmU6IFtQQVRDSF0gZHJtL2tvbWVkYTogQ2xlYW4gd2FybmluZ3M6IGNhbmRp?=
 =?utf-8?B?ZGF0ZSBmb3IgJ2dudV9wcmludGbigJkgZm9ybWF0IGF0dHJpYnV0ZQ==?=
Thread-Topic: =?utf-8?B?W1BBVENIXSBkcm0va29tZWRhOiBDbGVhbiB3YXJuaW5nczogY2FuZGlkYXRl?=
 =?utf-8?B?IGZvciAnZ251X3ByaW50ZuKAmSBmb3JtYXQgYXR0cmlidXRl?=
Thread-Index: AQHVmrvHSAACMS3tME+zvG9PBSu3eaeKWvSAgAAC1YA=
Date:   Thu, 14 Nov 2019 08:58:13 +0000
Message-ID: <20191114085805.GA29015@jamwan02-TSP300>
References: <20191114071839.29120-1-james.qian.wang@arm.com>
 <2335872.DMSfzqFJN1@e123338-lin>
In-Reply-To: <2335872.DMSfzqFJN1@e123338-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::18) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d551f15e-edf9-4065-55b8-08d768e0cce8
X-MS-TrafficTypeDiagnostic: VE1PR08MB4718:|VE1PR08MB4718:|AM7PR08MB5333:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53331E0B9487736731AA84C2B3710@AM7PR08MB5333.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4941;OLM:4941;
x-forefront-prvs: 02213C82F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(39860400002)(376002)(346002)(396003)(366004)(136003)(199004)(189003)(386003)(6506007)(33656002)(55236004)(99286004)(478600001)(26005)(66066001)(25786009)(102836004)(14454004)(256004)(186003)(14444005)(6116002)(3846002)(33716001)(81166006)(5660300002)(486006)(81156014)(8936002)(71200400001)(71190400001)(9686003)(1076003)(2906002)(11346002)(476003)(446003)(66476007)(66556008)(64756008)(66446008)(86362001)(66946007)(6636002)(6436002)(76176011)(316002)(54906003)(58126008)(6486002)(6246003)(6862004)(7736002)(305945005)(6512007)(229853002)(4326008)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4718;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 6OPmHTfpQxU8PMlUQbpw6/D+r2o2Ynrnmz5XCa0ZmnAKluPnoId3Y/hnFAvnEQrMG0VC7r75HtmbOvbPpoWBFzGtBTr04J+fFgj4wSrJMFwJWgCbj3/MjiMgVFOJgvMppOoml2ZFjjwx1l2iqr6DlLINloPfw6KrJ2iG9swM8RbJxbMG8isECFRhJOl62YYOQ6wm4dMYlnoEPrPeNy/HX5vpd9M4cQ6hJtIAv+bHE/4KfPJGDsoDTfl8FkbusrJib70scMHDyGjPhmY8Jd9Y9ZgqfIN7yWg9m6WlPYU4g0bwBxgaWEHdV303vkr0Jc99C5OrvdFvAL/I06EwDgf+WxtQ602bO/zGQX/LTqsjU/EDwYeMqgSQulHApG+7DRMtwfJbsCfbvmQ9byfCkcitpaMX2taRcC0OYVx7TbNswdbVg3ZZVStvTZB1N9s/OHW2
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCACC3CCFE213540A1154517BFF511C5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4718
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(39860400002)(376002)(136003)(346002)(1110001)(339900001)(189003)(199004)(446003)(11346002)(9686003)(6636002)(86362001)(33716001)(7736002)(6512007)(356004)(23676004)(2486003)(6486002)(76176011)(229853002)(305945005)(336012)(436003)(6246003)(14444005)(47776003)(478600001)(107886003)(25786009)(476003)(126002)(486006)(26826003)(66066001)(33656002)(4326008)(6862004)(2906002)(6116002)(3846002)(58126008)(70206006)(76130400001)(70586007)(5660300002)(1076003)(186003)(14454004)(386003)(6506007)(26005)(99286004)(105606002)(8936002)(54906003)(81166006)(316002)(81156014)(22756006)(102836004)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5333;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8b880900-704b-443c-62f7-08d768e0c823
NoDisclaimer: True
X-Forefront-PRVS: 02213C82F8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /84IA4iLkG/WCexS6pPAN5RMWj28OLK8twtOyt0xYfGZAspk9qeJlVXeCkAK2C2uhGgwejrFQYyTc3DfGFEVKOuJlHyixT+lNctEy0ZpiS9D9pd9f7BLlw1pS/OP0Cc1nzU63+Y+74INzz0bZLMyboeg/CpC7slyzaiRIGM3dUoFDEklRWcbAT04RHDJkxIChot2lehVL5zkx7/l0vJdoG1Piye5DSTebi99QzGDBF48MaUyOlNBR1ZjwJJ9qRoM0FrRQNOuuZSLgTnmeljCYhaaAfMCervbdRM9E7DGkxVYuGjwiKGdEE0USpZ/CyI/+XQkkoPU4hITq3cPQbMCHdidxH2d2oHhFkktLnpEDff0M54rTQsOGmKYnx+puFny2xw3vzEntNzNCXbLe6b3GlBTNIqReeOKnpqE1a9RToQGexXf/vNJLn8/vBzluC63
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 08:58:21.5375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d551f15e-edf9-4065-55b8-08d768e0cce8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5333
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBOb3YgMTQsIDIwMTkgYXQgMDg6NDc6NThBTSArMDAwMCwgTWloYWlsIEF0YW5hc3Nv
diB3cm90ZToNCj4gSGkgSmFtZXMsDQo+IA0KPiBPbiBUaHVyc2RheSwgMTQgTm92ZW1iZXIgMjAx
OSAwNzoxODo1NiBHTVQgamFtZXMgcWlhbiB3YW5nIChBcm0gVGVjaG5vbG9neSBDaGluYSkgd3Jv
dGU6DQo+ID4ga29tZWRhL2tvbWVkYV9waXBlbGluZS5jOiBJbiBmdW5jdGlvbiDigJhrb21lZGFf
Y29tcG9uZW50X2FkZOKAmToNCj4gPiBrb21lZGEva29tZWRhX3BpcGVsaW5lLmM6MjEzOjM6IHdh
cm5pbmc6IGZ1bmN0aW9uIOKAmGtvbWVkYV9jb21wb25lbnRfYWRk4oCZIG1pZ2h0IGJlIGEgY2Fu
ZGlkYXRlIGZvciDigJhnbnVfcHJpbnRm4oCZIGZvcm1hdCBhdHRyaWJ1dGUgWy1Xc3VnZ2VzdC1h
dHRyaWJ1dGU9Zm9ybWF0XQ0KPiA+ICAgIHZzbnByaW50ZihjLT5uYW1lLCBzaXplb2YoYy0+bmFt
ZSksIG5hbWVfZm10LCBhcmdzKTsNCj4gPiAgICBefn5+fn5+fn4NCj4gDQo+IFRoZSBmaXggZm9y
IHRoaXMgb25lIGlzbid0IGluIHRoZSBwYXRjaCBiZWxvdy4NCg0KQmVjYXVzZSB0aGUgdXBzdHJl
YW0gY29kZSBhbHJlYWR5IGhhdmUgaXQsIEJ1dCBJIGZvcmdvdCB0byB1cGRhdGUgdGhlDQpjb21t
ZW50IG1zZywgd2lsbCBzZW5kIHYyIHRvIGZpeCBpdC4NCg0KVGhhbmtzDQpKYW1lcw0KDQo+ID4g
DQo+ID4ga29tZWRhL2tvbWVkYV9ldmVudC5jOiBJbiBmdW5jdGlvbiDigJhrb21lZGFfc3ByaW50
ZuKAmToNCj4gPiBrb21lZGEva29tZWRhX2V2ZW50LmM6MzE6Mjogd2FybmluZzogZnVuY3Rpb24g
4oCYa29tZWRhX3NwcmludGbigJkgbWlnaHQgYmUgYSBjYW5kaWRhdGUgZm9yIOKAmGdudV9wcmlu
dGbigJkgZm9ybWF0IGF0dHJpYnV0ZSBbLVdzdWdnZXN0LWF0dHJpYnV0ZT1mb3JtYXRdDQo+ID4g
ICBudW0gPSB2c25wcmludGYoc3RyLT5zdHIgKyBzdHItPmxlbiwgZnJlZV9zeiwgZm10LCBhcmdz
KTsNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBqYW1lcyBxaWFuIHdhbmcgKEFybSBUZWNobm9s
b2d5IENoaW5hKSA8amFtZXMucWlhbi53YW5nQGFybS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2V2ZW50LmMgfCAxICsNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2V2ZW50LmMgYi9kcml2ZXJz
L2dwdS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9ldmVudC5jDQo+ID4gaW5kZXggYmYy
Njk2ODNmODExLi45NzdjMzhkNTE2ZGEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfZXZlbnQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2V2ZW50LmMNCj4gPiBAQCAtMTcsNiArMTcs
NyBAQCBzdHJ1Y3Qga29tZWRhX3N0ciB7DQo+ID4gIA0KPiA+ICAvKiByZXR1cm4gMCBvbiBzdWNj
ZXNzLCAgPCAwIG9uIG5vIHNwYWNlLg0KPiA+ICAgKi8NCj4gPiArX19wcmludGYoMiwgMykNCj4g
PiAgc3RhdGljIGludCBrb21lZGFfc3ByaW50ZihzdHJ1Y3Qga29tZWRhX3N0ciAqc3RyLCBjb25z
dCBjaGFyICpmbXQsIC4uLikNCj4gPiAgew0KPiA+ICAJdmFfbGlzdCBhcmdzOw0KPiA+IC0tIA0K
PiA+IDIuMjAuMQ0KPiA+IA0KPiA+IA0KPiANCj4gDQo+IC0tIA0KPiBNaWhhaWwNCj4gDQo+IA0K
PiANCg==
