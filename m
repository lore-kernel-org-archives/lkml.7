Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4F6C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7B6207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ni7nbs5M";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ni7nbs5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbfITOYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:24:22 -0400
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:30702
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387845AbfITOYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5ytb+0I/I+il0Yr3WnyX4CihE4CwuhyiaJh0cP4Sns=;
 b=ni7nbs5M01N1w8+hQjF99jdmGwq1AGEtPmzj72XFpbUd3AL6EK4MSesAdFKreob4Lujq75fVRa71tPKWTOPAhiXlyg52XO0fOfQWAuo34Xd/ADWMI6KxiOuoY7hRU0Xa/iQLy0f+xqPWtrcrGx8/K8XexjnUJXR7AbKpfO2C0po=
Received: from VE1PR08CA0002.eurprd08.prod.outlook.com (2603:10a6:803:104::15)
 by HE1PR0802MB2570.eurprd08.prod.outlook.com (2603:10a6:3:df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.17; Fri, 20 Sep
 2019 14:24:14 +0000
Received: from DB5EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by VE1PR08CA0002.outlook.office365.com
 (2603:10a6:803:104::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.18 via Frontend
 Transport; Fri, 20 Sep 2019 14:24:13 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT060.mail.protection.outlook.com (10.152.21.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.20 via Frontend Transport; Fri, 20 Sep 2019 14:24:12 +0000
Received: ("Tessian outbound d5a1f2820a4f:v31"); Fri, 20 Sep 2019 14:24:10 +0000
X-CR-MTA-TID: 64aa7808
Received: from 10583a20677c.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4B71E7A5-D560-4E3A-9037-104A8F31A7E2.1;
        Fri, 20 Sep 2019 14:24:05 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 10583a20677c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 20 Sep 2019 14:24:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtG757f6Bw1s1rOksLO+aAsaldXIGWOjv8qWZziJxBWbVD3rWADYfzg3VuMGMXGHjlubS08Pf4PAbMAax5nWWJHz8cXFeZueBkR9sKTq+DRwERXHtW/d47X/wSMtjFSKWQel3NttP+x962thHg3vQb1Iwya3vU9TogEOAlwPOha2b7Ukt/wNWe+bTsRHUEzFKfiS0CUK/2W2Lbi05xYOpm+uTsgAzcGjpUtc4bHDBUd3QSquddoLYSPEoAaKZPdrkfFXW66hy5YPKT3F3OjT2b15cM6PxldG16A8o9fD34se8qce4MF+5wRsSYqy1fco6dYmUa0x7f16RGRZcBM0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5ytb+0I/I+il0Yr3WnyX4CihE4CwuhyiaJh0cP4Sns=;
 b=GzN/ha5ildakkEIkjPn8QnDAkP9reYcQnN7kvUuQfTVS/jAzq1eeLgfntddaUo/+z8VI6vhfE8PZBs87mCvQneDyWnUYkR0Rdn7JaaN8otqrFTEQ6gN9pui+XoRK+rRqlnfuCNx+m+g3T0bCw81Iwgg/jHKRrOPOe6kIDMH5nc31DaoyVzA/uZ9wLcBaul2xabR9NQrnDOHnWVWYNgst8Ima6npdCloWXcWO+NmE0lnp5DPmREwT2XcNcT2OU4olCl1lxTqkos2waWFfY1X0jWDdcx/aSI0cOev3rInbP2fqwQmMuHc0KTBGk1BtQc1XpPPOkzDEZM3G+51u8drc1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5ytb+0I/I+il0Yr3WnyX4CihE4CwuhyiaJh0cP4Sns=;
 b=ni7nbs5M01N1w8+hQjF99jdmGwq1AGEtPmzj72XFpbUd3AL6EK4MSesAdFKreob4Lujq75fVRa71tPKWTOPAhiXlyg52XO0fOfQWAuo34Xd/ADWMI6KxiOuoY7hRU0Xa/iQLy0f+xqPWtrcrGx8/K8XexjnUJXR7AbKpfO2C0po=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB3324.eurprd08.prod.outlook.com (52.135.128.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Fri, 20 Sep 2019 14:24:04 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::3dcd:d5e4:c17:489d]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::3dcd:d5e4:c17:489d%5]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 14:24:04 +0000
From:   "Justin He (Arm Technology China)" <Justin.He@arm.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, nd <nd@arm.com>,
        "hejianet@gmail.com" <hejianet@gmail.com>
Subject: RE: [PATCH v7 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Thread-Topic: [PATCH v7 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Thread-Index: AQHVb7sLaOwb1dEY50+Jn8LDfSzGEKc0ndmAgAAAN+A=
Date:   Fri, 20 Sep 2019 14:24:04 +0000
Message-ID: <DB7PR08MB3082D3733CBACE61C50AD13EF7880@DB7PR08MB3082.eurprd08.prod.outlook.com>
References: <20190920135437.25622-1-justin.he@arm.com>
 <20190920135437.25622-4-justin.he@arm.com>
 <20190920142113.52mdiflo4yghlsmu@box>
In-Reply-To: <20190920142113.52mdiflo4yghlsmu@box>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 8c3a65df-0bd5-4fde-8b4c-6568642a7620.0
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 8576b1ee-178f-408b-0b35-08d73dd6357b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3324;
X-MS-TrafficTypeDiagnostic: DB7PR08MB3324:|HE1PR0802MB2570:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2570DA9CCC86CF39861C324FF7880@HE1PR0802MB2570.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 0166B75B74
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(189003)(199004)(13464003)(76116006)(66066001)(14444005)(25786009)(6436002)(74316002)(6506007)(6916009)(71200400001)(256004)(305945005)(99286004)(186003)(55236004)(7736002)(102836004)(26005)(6306002)(316002)(71190400001)(53546011)(55016002)(8936002)(6246003)(54906003)(5660300002)(66556008)(66476007)(478600001)(64756008)(229853002)(486006)(7696005)(6116002)(11346002)(966005)(476003)(66574012)(4326008)(86362001)(66946007)(3846002)(52536014)(9686003)(76176011)(14454004)(81166006)(446003)(2906002)(33656002)(66446008)(8676002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3324;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: sfjH1eLdOIr+wxLcjOH7XGebrCnzegD42vg1ikq2fFbz95NxAgK42zsCOKgv3AT4ONicbQkuE4JoTt/SRCtRZVRFjkUNn7CgGURakf5/HwmFHkERdT9KDIB7XbAKEGoQGcNeZ39nw5ylTs+HRvE1pMQC12x0wPCJq1b0fvJvW30eVc8Ov0FLqRcjklpBth2mF4GTGRFlflWIeiUnpM1KrJcGciG/6caZD+F4RiaNy912mIXj08H2ZP9y+rmguemnIkzGWoFJcQkwvdLuq1/e4ssdD6iaC9DanwguaqTqx0CDTQfmd04LBXb+hJ4CIuhM3FgIG4FHVwvTocZ4gZhAl9SCHhM4HsjC644EoWr/gTbl67v58G5Bcxk4dBXsO87AvPkDx/y9r6YLk8CT4Q1RCb/zhZYN6k6q80rdW7LOR4M=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3324
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(13464003)(66066001)(26005)(2906002)(6116002)(3846002)(47776003)(6246003)(14444005)(229853002)(5660300002)(52536014)(486006)(966005)(478600001)(14454004)(6862004)(476003)(86362001)(9686003)(55016002)(126002)(6306002)(107886003)(26826003)(22756006)(54906003)(316002)(4326008)(33656002)(74316002)(76130400001)(7736002)(70586007)(305945005)(70206006)(50466002)(8936002)(11346002)(446003)(336012)(81166006)(8676002)(81156014)(436003)(7696005)(2486003)(23676004)(63350400001)(186003)(356004)(102836004)(53546011)(25786009)(76176011)(99286004)(6506007)(66574012);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2570;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2532dadd-350c-4375-aeea-08d73dd63097
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:HE1PR0802MB2570;
NoDisclaimer: True
X-Forefront-PRVS: 0166B75B74
X-Microsoft-Antispam-Message-Info: dzxaoKZlQouoisdZEsiTnm0Xj14avfmDlgeVQNABXth77cS2hUL/MbpIoKt9MZFXMlTCWzyj4ojHeQW7BZ44OIlhF1itar8VUBm7wFkW1bdYYNJwkqCajU1nTcPWVpVTu2Okx0UcDMKJ4PE5Max8PPnf+TJ3jxhcJgMbyPTMx2cCn9xaf7foRlSvlASCF778PQEauQw+P3vqAA9d1i62na2n5xtynXmzf7Ce9lMoseAmZvS24Gt7sVrBNes/GPGC/hHTjRlHWaJDeGxEeOJaESZxZ+heMsno2HDBO1qAYRtCZHpoStsrkgPUZqzqGYswYdCAuX4cpfUy4d/8awVPEwf6s5VB2GRzzSn6KtKkgYkUP800IJiGbpS63BfKEpJoVYvxhfCf17PhDWKuxKMpGnbAN1vuxv0KEsuqsEAIfXs=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2019 14:24:12.5266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8576b1ee-178f-408b-0b35-08d73dd6357b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2570
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIHBhdGVudCByZXZpZXcg8J+Yig0KDQotLQ0KQ2hlZXJzLA0KSnVzdGlu
IChKaWEgSGUpDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtp
cmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsQHNodXRlbW92Lm5hbWU+DQo+IFNlbnQ6IDIwMTnlubQ5
5pyIMjDml6UgMjI6MjENCj4gVG86IEp1c3RpbiBIZSAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpIDxK
dXN0aW4uSGVAYXJtLmNvbT4NCj4gQ2M6IENhdGFsaW4gTWFyaW5hcyA8Q2F0YWxpbi5NYXJpbmFz
QGFybS5jb20+OyBXaWxsIERlYWNvbg0KPiA8d2lsbEBrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5k
IDxNYXJrLlJ1dGxhbmRAYXJtLmNvbT47IEphbWVzIE1vcnNlDQo+IDxKYW1lcy5Nb3JzZUBhcm0u
Y29tPjsgTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz47IE1hdHRoZXcNCj4gV2lsY294IDx3
aWxseUBpbmZyYWRlYWQub3JnPjsgS2lyaWxsIEEuIFNodXRlbW92DQo+IDxraXJpbGwuc2h1dGVt
b3ZAbGludXguaW50ZWwuY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IFN1
enVraSBQb3Vsb3NlDQo+IDxTdXp1a2kuUG91bG9zZUBhcm0uY29tPjsgUHVuaXQgQWdyYXdhbCA8
cHVuaXRhZ3Jhd2FsQGdtYWlsLmNvbT47DQo+IEFuc2h1bWFuIEtoYW5kdWFsIDxBbnNodW1hbi5L
aGFuZHVhbEBhcm0uY29tPjsgQWxleCBWYW4gQnJ1bnQNCj4gPGF2YW5icnVudEBudmlkaWEuY29t
PjsgUm9iaW4gTXVycGh5IDxSb2Jpbi5NdXJwaHlAYXJtLmNvbT47DQo+IFRob21hcyBHbGVpeG5l
ciA8dGdseEBsaW51dHJvbml4LmRlPjsgQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC0NCj4gZm91
bmRhdGlvbi5vcmc+OyBKw6lyw7RtZSBHbGlzc2UgPGpnbGlzc2VAcmVkaGF0LmNvbT47IFJhbHBo
IENhbXBiZWxsDQo+IDxyY2FtcGJlbGxAbnZpZGlhLmNvbT47IGhlamlhbmV0QGdtYWlsLmNvbTsg
S2FseSBYaW4gKEFybSBUZWNobm9sb2d5DQo+IENoaW5hKSA8S2FseS5YaW5AYXJtLmNvbT47IG5k
IDxuZEBhcm0uY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDMvM10gbW06IGZpeCBkb3Vi
bGUgcGFnZSBmYXVsdCBvbiBhcm02NCBpZiBQVEVfQUYgaXMNCj4gY2xlYXJlZA0KPiANCj4gT24g
RnJpLCBTZXAgMjAsIDIwMTkgYXQgMDk6NTQ6MzdQTSArMDgwMCwgSmlhIEhlIHdyb3RlOg0KPiA+
IFdoZW4gd2UgdGVzdGVkIHBtZGsgdW5pdCB0ZXN0IFsxXSB2bW1hbGxvY19mb3JrIFRFU1QxIGlu
IGFybTY0IGd1ZXN0LA0KPiB0aGVyZQ0KPiA+IHdpbGwgYmUgYSBkb3VibGUgcGFnZSBmYXVsdCBp
biBfX2NvcHlfZnJvbV91c2VyX2luYXRvbWljIG9mDQo+IGNvd191c2VyX3BhZ2UuDQo+ID4NCj4g
PiBCZWxvdyBjYWxsIHRyYWNlIGlzIGZyb20gYXJtNjQgZG9fcGFnZV9mYXVsdCBmb3IgZGVidWdn
aW5nIHB1cnBvc2UNCj4gPiBbICAxMTAuMDE2MTk1XSBDYWxsIHRyYWNlOg0KPiA+IFsgIDExMC4w
MTY4MjZdICBkb19wYWdlX2ZhdWx0KzB4NWE0LzB4NjkwDQo+ID4gWyAgMTEwLjAxNzgxMl0gIGRv
X21lbV9hYm9ydCsweDUwLzB4YjANCj4gPiBbICAxMTAuMDE4NzI2XSAgZWwxX2RhKzB4MjAvMHhj
NA0KPiA+IFsgIDExMC4wMTk0OTJdICBfX2FyY2hfY29weV9mcm9tX3VzZXIrMHgxODAvMHgyODAN
Cj4gPiBbICAxMTAuMDIwNjQ2XSAgZG9fd3BfcGFnZSsweGIwLzB4ODYwDQo+ID4gWyAgMTEwLjAy
MTUxN10gIF9faGFuZGxlX21tX2ZhdWx0KzB4OTk0LzB4MTMzOA0KPiA+IFsgIDExMC4wMjI2MDZd
ICBoYW5kbGVfbW1fZmF1bHQrMHhlOC8weDE4MA0KPiA+IFsgIDExMC4wMjM1ODRdICBkb19wYWdl
X2ZhdWx0KzB4MjQwLzB4NjkwDQo+ID4gWyAgMTEwLjAyNDUzNV0gIGRvX21lbV9hYm9ydCsweDUw
LzB4YjANCj4gPiBbICAxMTAuMDI1NDIzXSAgZWwwX2RhKzB4MjAvMHgyNA0KPiA+DQo+ID4gVGhl
IHB0ZSBpbmZvIGJlZm9yZSBfX2NvcHlfZnJvbV91c2VyX2luYXRvbWljIGlzIChQVEVfQUYgaXMg
Y2xlYXJlZCk6DQo+ID4gW2ZmZmY5YjAwNzAwMF0gcGdkPTAwMDAwMDAyM2Q0ZjgwMDMsIHB1ZD0w
MDAwMDAwMjNkYTliMDAzLA0KPiBwbWQ9MDAwMDAwMDIzZDRiMzAwMywgcHRlPTM2MDAwMDI5ODYw
N2JkMw0KPiA+DQo+ID4gQXMgdG9sZCBieSBDYXRhbGluOiAiT24gYXJtNjQgd2l0aG91dCBoYXJk
d2FyZSBBY2Nlc3MgRmxhZywgY29weWluZyBmcm9tDQo+ID4gdXNlciB3aWxsIGZhaWwgYmVjYXVz
ZSB0aGUgcHRlIGlzIG9sZCBhbmQgY2Fubm90IGJlIG1hcmtlZCB5b3VuZy4gU28gd2UNCj4gPiBh
bHdheXMgZW5kIHVwIHdpdGggemVyb2VkIHBhZ2UgYWZ0ZXIgZm9yaygpICsgQ29XIGZvciBwZm4g
bWFwcGluZ3MuIHdlDQo+ID4gZG9uJ3QgYWx3YXlzIGhhdmUgYSBoYXJkd2FyZS1tYW5hZ2VkIGFj
Y2VzcyBmbGFnIG9uIGFybTY0LiINCj4gPg0KPiA+IFRoaXMgcGF0Y2ggZml4IGl0IGJ5IGNhbGxp
bmcgcHRlX21reW91bmcuIEFsc28sIHRoZSBwYXJhbWV0ZXIgaXMNCj4gPiBjaGFuZ2VkIGJlY2F1
c2Ugdm1mIHNob3VsZCBiZSBwYXNzZWQgdG8gY293X3VzZXJfcGFnZSgpDQo+ID4NCj4gPiBBZGQg
YSBXQVJOX09OX09OQ0Ugd2hlbiBfX2NvcHlfZnJvbV91c2VyX2luYXRvbWljKCkgcmV0dXJucyBl
cnJvcg0KPiA+IGluIGNhc2UgdGhlcmUgY2FuIGJlIHNvbWUgb2JzY3VyZSB1c2UtY2FzZS4oYnkg
S2lyaWxsKQ0KPiA+DQo+ID4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9wbWVtL3BtZGsvdHJlZS9t
YXN0ZXIvc3JjL3Rlc3Qvdm1tYWxsb2NfZm9yaw0KPiA+DQo+ID4gUmVwb3J0ZWQtYnk6IFlpYm8g
Q2FpIDxZaWJvLkNhaUBhcm0uY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYSBIZSA8anVzdGlu
LmhlQGFybS5jb20+DQo+IA0KPiBBY2tlZC1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwu
c2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiANCj4gLS0NCj4gIEtpcmlsbCBBLiBTaHV0ZW1v
dg0K
