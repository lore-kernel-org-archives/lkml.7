Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3985EC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 02:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017082465E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 02:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=transsionglobal.onmicrosoft.com header.i=@transsionglobal.onmicrosoft.com header.b="YLET4M2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLPCCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 21:02:52 -0500
Received: from mail-eopbgr1300041.outbound.protection.outlook.com ([40.107.130.41]:52954
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726373AbfLPCCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 21:02:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFP+xAJWsGi76OCd5g2AMrceN+eX1SvxXbrRXqw97J4HPq/8TnxsiAj0J4OxqkqnEKI1sljU94+BR/WQzuIJZtb8gSPkan4pMvGqmriZuXZamXeWI7hKc4QzOQPKIxpawg2QtOMsIWUSFHNH1CH3ESBEc/k8tA1nN2AjDwjK9RH9zuyv8NONfD+I5nCCseLId0IlfF6eYjmj5osgNuz/yM9WAanDQe1r8B+EhAeggN+4zIrbuvd6cYSmOO2454aAfPiUdiLwRmoFXVmfO4oLtoOGzkUoiJtpAJOwQPeFQcpsR1fE3QAdb4oCprb1IP3BcSeA6dSFTZVChsPw0mCKqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI7R/msScpHcQSvVK0AzEGWohNhrRlL29G3FfIyTa0U=;
 b=HPMLFYYUvSNLaucRTpbVeZDd71L0WkI6KoRa1FVo/G/sx56x0nl4IAox6+5Kr9FvIjZVVhlJrhDvAAG8ScZiXl9cpRPtxb9kjfGZQMylhe/Fna/sYt4qnsxe4DF9kHDZuOLcvJmeZAb28fITyZN6wzMAjfqO5OqVd6MJnUtAA979RIBkoMkVnb2BGCV+UEmcZEgc3dbHfwspVuRw7vHT5r5n1jnFXnlMeKFWEHJTufhradltZaUTN5qEAtUnjegvfVKdD2vL9+t3f9rQw5NFbjfqQpal9VNnc1G1umKz+az71FL1RV2n10fjgINr+DkbvF7JnDR4JtRG9uPg/HDV0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 27.115.63.14) smtp.rcpttodomain=kernel.org smtp.mailfrom=transsion.com;
 dmarc=none action=none header.from=transsion.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=transsionglobal.onmicrosoft.com;
 s=selector2-transsionglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI7R/msScpHcQSvVK0AzEGWohNhrRlL29G3FfIyTa0U=;
 b=YLET4M2AedTmVmygucHMxEWvRpmuuxRQwBL1D+tTDYUbybOXEnqlAHjORkSwVLBE6mt91UIrrlh+jIddyOBVXaof31TkoazVWXn6S1O8/Kw+bQiQNbEeAqVIanHHyXcRjHqygMVWkyiamig6rVgBoIAhdfBxdTod/pVYmiRN1tE=
Received: from SG2PR0401CA0001.apcprd04.prod.outlook.com (2603:1096:3:1::11)
 by HK0PR04MB2564.apcprd04.prod.outlook.com (2603:1096:203:67::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Mon, 16 Dec
 2019 02:02:45 +0000
Received: from PU1APC01FT049.eop-APC01.prod.protection.outlook.com
 (2a01:111:f400:7ebd::208) by SG2PR0401CA0001.outlook.office365.com
 (2603:1096:3:1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Mon, 16 Dec 2019 02:02:44 +0000
Authentication-Results: spf=fail (sender IP is 27.115.63.14)
 smtp.mailfrom=transsion.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=transsion.com;
Received-SPF: Fail (protection.outlook.com: domain of transsion.com does not
 designate 27.115.63.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=27.115.63.14; helo=mail.transsion.com;
Received: from mail.transsion.com (27.115.63.14) by
 PU1APC01FT049.mail.protection.outlook.com (10.152.253.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2538.15 via Frontend Transport; Mon, 16 Dec 2019 02:02:43 +0000
Received: from SH-EXC-MX01.transsion.com (10.150.2.41) by
 SH-EXC-MX01.transsion.com (10.150.2.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 16 Dec 2019 10:02:33 +0800
Received: from SH-EXC-MX01.transsion.com ([fe80::a9c9:4b06:6245:846c]) by
 SH-EXC-MX01.transsion.com ([fe80::a9c9:4b06:6245:846c%13]) with mapi id
 15.01.1591.008; Mon, 16 Dec 2019 10:02:33 +0800
From:   =?gb2312?B?eGlhbnJvbmcuemhvdSjW3M/IyNkp?= 
        <xianrong.zhou@transsion.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        =?gb2312?B?d2VpbWluLm1hbyjDq87Aw/Ep?= <weimin.mao@transsion.com>,
        =?gb2312?B?aGFpemhvdS5zb25nKMvOuqPW2yk=?= 
        <haizhou.song@transsion.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        =?gb2312?B?d2FuYmluLndhbmcozfTN8rHzKQ==?= 
        <wanbin.wang@transsion.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?gb2312?B?eXVhbmppb25nLmdhbyi439Sovrwp?= 
        <yuanjiong.gao@transsion.com>,
        =?gb2312?B?cnV4aWFuLmZlbmcot+vI5ea1KQ==?= 
        <ruxian.feng@transsion.com>, "agk@redhat.com" <agk@redhat.com>
Subject: Reply [PATCH] dm-verity: unnecessary data blocks that need not read
 hash blocks
Thread-Topic: Reply [PATCH] dm-verity: unnecessary data blocks that need not
 read hash blocks
Thread-Index: AdWztMxRz9kVwcU5TJCkJS5tt5ezYg==
Date:   Mon, 16 Dec 2019 02:02:33 +0000
Message-ID: <727b9e9279a546beb2ae63a18eae6ab0@transsion.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.150.151.93]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:27.115.63.14;IPV:;CTRY:CN;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39850400004)(136003)(396003)(1110001)(339900001)(199004)(189003)(316002)(2906002)(5660300002)(8676002)(4326008)(8936002)(81166006)(6916009)(336012)(478600001)(186003)(26005)(426003)(81156014)(70206006)(54906003)(108616005)(85182001)(356004)(36756003)(86362001)(2616005)(70586007)(7696005)(24736004);DIR:OUT;SFP:1101;SCL:1;SRVR:HK0PR04MB2564;H:mail.transsion.com;FPR:;SPF:Fail;LANG:en;PTR:mail.reallytek.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c813980-4f7a-48c6-4836-08d781cc09ee
X-MS-TrafficTypeDiagnostic: HK0PR04MB2564:
X-Microsoft-Antispam-PRVS: <HK0PR04MB256419E689FBE9AA81B992D1F8510@HK0PR04MB2564.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 02530BD3AA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZBBX22bDThTCzV21FdYsZx4HhRYRbBijLxObb6JM2/Ht1JU7YtMyMXV4bKb7z64wHGxaxVtJhyuf/lhRWNkJxbHgamIyI5iFGVjkCNLi6MmDIbU0zoJ3DEtNgobOi/Kr7ikvgtqi1epsX2Yi4bFopHdLlmr6l3fA04n7sOMJllqqdiDCG7nSSni/5ZS/LfWxjIQs9AzDRlQ73KGGrbR3a/oP9zj/MHlW5KrvzJ2Fjqq5GoFbGcLwY4ycFdhdYS2chz4TUEYcc9EOGtR4CdaqCpvzhYb+kGnSxV1SlE7vTtOQkG+O7+UUA4swUPLq3zxVc1awAvOLR3CG9lbUvDg+oUbaimAtWdIfPHv1sSb1tnhW22llt0hDt4maPybvsJHlef8weg4awbuf26FwuQqRJuVmOC1RkB71TwhZlnM0w7zfYUYwA67Izcz8D7jY0Ln
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2019 02:02:43.4375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c813980-4f7a-48c6-4836-08d781cc09ee
X-MS-Exchange-CrossTenant-Id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2;Ip=[27.115.63.14];Helo=[mail.transsion.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aGV5IEVyaWM6DQoNCk9uIFdlZCwgRGVjIDExLCAyMDE5IGF0IDExOjMyOjQwQU0gKzA4MDAsIHpo
b3UgeGlhbnJvbmcgd3JvdGU6DQo+IEZyb206ICJ4aWFucm9uZy56aG91IiA8eGlhbnJvbmcuemhv
dUB0cmFuc3Npb24uY29tPg0KPiANCj4gSWYgY2hlY2tfYXRfbW9zdF9vbmNlIGVuYWJsZWQsIGp1
c3QgbGlrZSB2ZXJpdHkgd29yayB0aGUgcHJlZmV0Y2hpbmcgDQo+IHdvcmsgc2hvdWxkIGNoZWNr
IGZvciBkYXRhIGJsb2NrIGJpdG1hcCBmaXJzdGx5IGJlZm9yZSByZWFkaW5nIGhhc2ggDQo+IGJs
b2NrIGFzIHdlbGwuIFNraXAgYml0LXNldCBkYXRhIGJsb2NrcyBmcm9tIGJvdGggZW5kcyBvZiBk
YXRhIGJsb2NrIA0KPiByYW5nZSBieSB0ZXN0aW5nIHRoZSB2YWxpZGF0ZWQgYml0bWFwLiBUaGlz
IGNhbiByZWR1Y2UgdGhlIGFtb3VudHMgb2YgDQo+IGRhdGEgYmxvY2tzIHdoaWNoIG5lZWQgdG8g
cmVhZCBoYXNoIGJsb2Nrcy4NCj4gDQo+IExhdW5jaGluZyA5MSBhcHBzIGV2ZXJ5IDE1cyBhbmQg
cmVwZWF0IDIxIHJvdW5kcyBvbiBBbmRyb2lkIFEuDQo+IEluIHByZWZldGNoaW5nIHdvcmsgd2Ug
Y2FuIGxldCBvbmx5IDI2MDIvMzYwMzEyID0gMC43MiUgZGF0YSBibG9ja3MgDQo+IHJlYWxseSBu
ZWVkIHRvIHJlYWQgaGFzaCBibG9ja3MuDQo+IA0KPiBCdXQgdGhlIHJlZHVjZWQgZGF0YSBibG9j
a3MgcmFuZ2Ugd291bGQgYmUgZW5sYXJnZWQgYWdhaW4gYnkgDQo+IGRtX3Zlcml0eV9wcmVmZXRj
aF9jbHVzdGVyIGxhdGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogeGlhbnJvbmcuemhvdSA8eGlh
bnJvbmcuemhvdUB0cmFuc3Npb24uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiB5dWFuamlvbmcuZ2Fv
IDx5dWFuamlvbmcuZ2FvQHRyYW5zc2lvbi5jb20+DQo+IFRlc3RlZC1ieTogcnV4aWFuLmZlbmcg
PHJ1eGlhbi5mZW5nQHRyYW5zc2lvbi5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tZC9kbS12ZXJp
dHktdGFyZ2V0LmMgfCAxNiArKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTYg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWQvZG0tdmVyaXR5LXRh
cmdldC5jIA0KPiBiL2RyaXZlcnMvbWQvZG0tdmVyaXR5LXRhcmdldC5jIGluZGV4IDRmYjMzZTc1
NjJjNS4uN2I4ZWI3NTRjMGI2IA0KPiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZC9kbS12ZXJp
dHktdGFyZ2V0LmMNCj4gKysrIGIvZHJpdmVycy9tZC9kbS12ZXJpdHktdGFyZ2V0LmMNCj4gQEAg
LTU4MSw2ICs1ODEsMjIgQEAgc3RhdGljIHZvaWQgdmVyaXR5X3ByZWZldGNoX2lvKHN0cnVjdCB3
b3JrX3N0cnVjdCAqd29yaykNCj4gIAlzdHJ1Y3QgZG1fdmVyaXR5ICp2ID0gcHctPnY7DQo+ICAJ
aW50IGk7DQo+ICANCj4gKwlpZiAodi0+dmFsaWRhdGVkX2Jsb2Nrcykgew0KPiArCQl3aGlsZSAo
cHctPm5fYmxvY2tzKSB7DQo+ICsJCQlpZiAodW5saWtlbHkoIXRlc3RfYml0KHB3LT5ibG9jaywg
di0+dmFsaWRhdGVkX2Jsb2NrcykpKQ0KPiArCQkJCWJyZWFrOw0KPiArCQkJcHctPmJsb2NrKys7
DQo+ICsJCQlwdy0+bl9ibG9ja3MtLTsNCj4gKwkJfQ0KPiArCQl3aGlsZSAocHctPm5fYmxvY2tz
KSB7DQo+ICsJCQlpZiAodW5saWtlbHkoIXRlc3RfYml0KHB3LT5ibG9jayArIHB3LT5uX2Jsb2Nr
cyAtIDEsDQo+ICsJCQkJdi0+dmFsaWRhdGVkX2Jsb2NrcykpKQ0KPiArCQkJCWJyZWFrOw0KPiAr
CQkJcHctPm5fYmxvY2tzLS07DQo+ICsJCX0NCj4gKwkJaWYgKCFwdy0+bl9ibG9ja3MpDQo+ICsJ
CQlyZXR1cm47DQo+ICsJfQ0KDQpUaGlzIGlzIGEgZ29vZCBpZGVhLCBidXQgc2hvdWxkbid0IHRo
aXMgbG9naWMgZ28gaW4gdmVyaXR5X3N1Ym1pdF9wcmVmZXRjaCgpIHByaW9yIHRvIHRoZSBzdHJ1
Y3QgZG1fdmVyaXR5X3ByZWZldGNoX3dvcmsgYmVpbmcgYWxsb2NhdGVkPyAgVGhlbiBpZiBubyBw
cmVmZWNoaW5nIGlzIG5lZWRlZCwgYWxsb2NhdGluZyBhbmQgc2NoZWR1bGluZyB0aGUgd29yayBv
YmplY3QgY2FuIGJlIHNraXBwZWQuDQoNCkVyaWMsIERvIHlvdSBtZWFuIGl0IGlzIG1vcmUgc3Vp
dGFibGUgaW4gZG1fYnVmaW9fcHJlZmV0Y2ggd2hpY2ggaXMgY2FsbGVkIG9uIGRpZmZlcmVudCBw
YXRocyBldmVuIHRob3VnaCBwcmVmZWNoaW5nIGlzIGRpc2FibGVkID8NCg0KQWxzbyBub3RlIHRo
YXQgeW91J3JlIGN1cnJlbnRseSBsZWFraW5nIHRoZSB3b3JrIG9iamVjdCB3aXRoIHRoZSBlYXJs
eSByZXR1cm4uCQ0KDQpSaWdodCEgSSBsZWFrZWQgdGhpcy4gYWx3YXlzIHNvLiBUaGFua3MhISEN
Cg0KLSBFcmljDQo=
