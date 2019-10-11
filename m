Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B0BC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C2921920
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7QIUuyjs";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="7QIUuyjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfJKBRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 21:17:04 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:18574
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727518AbfJKBRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 21:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGj2HS8mrLbW5trr1i++mH/TbBuewd/EaqI06wBs7wQ=;
 b=7QIUuyjsDmxOd3inBkR7uFunyKQrStVV1Sb7ODxJkRM0A9PXYamlqmVg/zl5h+1nVLKq9S5A4myUeP+7wroVZYUZzM21y4ojzPJ+b7t0Dqeg91Wdm6DraI5pgv50van7OQ0CykBXYBc6V0uRpqKISjmQtHjm+SEMBOqAILm4bX8=
Received: from AM6PR08CA0010.eurprd08.prod.outlook.com (2603:10a6:20b:b2::22)
 by VI1PR0802MB2447.eurprd08.prod.outlook.com (2603:10a6:800:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 11 Oct
 2019 01:16:53 +0000
Received: from DB5EUR03FT029.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::201) by AM6PR08CA0010.outlook.office365.com
 (2603:10a6:20b:b2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 11 Oct 2019 01:16:53 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT029.mail.protection.outlook.com (10.152.20.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 11 Oct 2019 01:16:51 +0000
Received: ("Tessian outbound e4042aced47b:v33"); Fri, 11 Oct 2019 01:16:45 +0000
X-CR-MTA-TID: 64aa7808
Received: from 5907c512596c.3 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.53])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 31010DF8-6BE6-4F02-89F1-EC088F28A22B.1;
        Fri, 11 Oct 2019 01:16:40 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2053.outbound.protection.outlook.com [104.47.5.53])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5907c512596c.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 11 Oct 2019 01:16:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPK7mu8nHve4zFXtn31+5CHBhBzWyQdvZYhljzZfczmYtWw8sTagfb0VGmXs9yrN5plwjDbQjSCKAaJZRd4UEcljFWJwY0rY3aHXGqaAZvRAetzG/iB6ywx4p16cZY5CKxsSV/Do1uRKgh4hi+bCURMQJbjfl/79wcsFUSIoBuHumL/mw8ohtvEDrvAfQccKDUcErt00Shwt7Uc028hTZvvNWVVyRF2TVl6BfoW8ZwBahIPqHvPYTBY1wHheVfPJtXPXk7jCpuO1azEoBSoEDi/CxriLSgU53JZQLmQoLtYsgp77HSF1uMclRaQRvDgYlRe67dFoQp+lXweC089vyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGj2HS8mrLbW5trr1i++mH/TbBuewd/EaqI06wBs7wQ=;
 b=hXy6/4ZpanRvMNNfgpdrxLQW3yPqLN904FmieVqfh5dXcYvFe0rH/Nt3eEN/RRVX9HdzWfjzTJVBDR+LkMVXMVkjidCEvxCq4oldIwWGhaDtbjegtRTxp36Esj8xM+kg0wL81R15w7bnl9lUvEMcxyyEdmugSrM1PbN7CaNogo/o/JyRDTxXuJEmtoMOBwmVqPEfERz4H97DOOdqcf0enZIsV7/i/rVZ15NtQcV+S4nmn4gp6tklkx2Z2saqoyYyFpaGJhEOnl+mfQInj/5p2Fyn6PSNIMaYrCIc4X2FIxZvFUmpTMjotnvlstwpOoBP03TjK9bd91oFx3aG1yJHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGj2HS8mrLbW5trr1i++mH/TbBuewd/EaqI06wBs7wQ=;
 b=7QIUuyjsDmxOd3inBkR7uFunyKQrStVV1Sb7ODxJkRM0A9PXYamlqmVg/zl5h+1nVLKq9S5A4myUeP+7wroVZYUZzM21y4ojzPJ+b7t0Dqeg91Wdm6DraI5pgv50van7OQ0CykBXYBc6V0uRpqKISjmQtHjm+SEMBOqAILm4bX8=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB3483.eurprd08.prod.outlook.com (20.177.120.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Fri, 11 Oct 2019 01:16:37 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::f9f9:ad51:6636:42f0]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::f9f9:ad51:6636:42f0%6]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 01:16:36 +0000
From:   "Justin He (Arm Technology China)" <Justin.He@arm.com>
To:     Catalin Marinas <Catalin.Marinas@arm.com>
CC:     Will Deacon <will@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>,
        James Morse <James.Morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "hejianet@gmail.com" <hejianet@gmail.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        nd <nd@arm.com>
Subject: RE: [PATCH v11 1/4] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Thread-Topic: [PATCH v11 1/4] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Thread-Index: AQHVfn2fVz/WJ52EYEizqdXPogUta6dUFqAAgACNw7A=
Date:   Fri, 11 Oct 2019 01:16:36 +0000
Message-ID: <DB7PR08MB3082E71F1FF5FE8462F88B8BF7970@DB7PR08MB3082.eurprd08.prod.outlook.com>
References: <20191009084246.123354-1-justin.he@arm.com>
 <20191009084246.123354-2-justin.he@arm.com>
 <20191010164312.GB40923@arrakis.emea.arm.com>
In-Reply-To: <20191010164312.GB40923@arrakis.emea.arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: d7bb498f-8d05-424c-b473-90d1d87356a9.0
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 16f885d0-6134-499e-3269-08d74de8b216
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: DB7PR08MB3483:|DB7PR08MB3483:|VI1PR0802MB2447:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2447D48A42B68BC7DE7846EBF7970@VI1PR0802MB2447.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 0187F3EA14
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(189003)(199004)(52314003)(13464003)(9686003)(6306002)(86362001)(186003)(33656002)(6116002)(14444005)(6636002)(256004)(6246003)(11346002)(3846002)(8936002)(66066001)(316002)(6506007)(446003)(6436002)(55236004)(476003)(54906003)(6862004)(53546011)(4326008)(26005)(102836004)(55016002)(486006)(7696005)(76176011)(64756008)(66556008)(76116006)(2906002)(229853002)(7416002)(74316002)(71200400001)(478600001)(66446008)(66476007)(66946007)(71190400001)(305945005)(81156014)(52536014)(8676002)(25786009)(81166006)(99286004)(7736002)(966005)(14454004)(5660300002)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3483;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: xV74x7btxdj0NPHje7ZSMIftpX3PU0iuErUnUIY67rJ2Bcg6mAXaVD36jn/V41T+gG3ShMrcl8dQnA3k2SKIUgVpvj8iCO3r1f/R4UDLBjXCLprSWUfdtJEBV7gC9jNsAhaFD9LekZcJF0E35+Mnf0lgCrdiADf1Bjr+hABY3dJwQRsiEJk/FTC5gsQ2cbmcaK1uXn3/ontbIT5hBEkPB0jMapRs6j/xuXX3CYr8n8HsObXdnkEumQIeoL5Z8VIAUmeRz5+tSZH2MMFpz1xNO7jcA8B5mKw6AbgdjLbUKnPywGF/SuEkQy1IQcphpXoAuLfF6pc1B9tEBmmhpykObhmOFIBkvpQNc8NBCjeTraw7t5oddNXMjIcrzyEUCvcO3OoGo470NnkiPp78yclBa0TPNBrZ2z5tF9lfR0u7Hn9jtviQI7wEaRIKuthbL12DjKzZ4O3DiTaYJnKKO1neCg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3483
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT029.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(136003)(39860400002)(52314003)(189003)(199004)(13464003)(53546011)(23676004)(7696005)(14444005)(14454004)(305945005)(6862004)(25786009)(74316002)(76176011)(52536014)(2486003)(6116002)(8676002)(8936002)(4326008)(478600001)(81156014)(66066001)(81166006)(26826003)(6506007)(3846002)(966005)(70206006)(7736002)(33656002)(229853002)(2906002)(22756006)(70586007)(102836004)(63350400001)(446003)(316002)(6636002)(436003)(47776003)(99286004)(11346002)(6306002)(336012)(9686003)(476003)(55016002)(54906003)(76130400001)(50466002)(356004)(6246003)(186003)(126002)(26005)(86362001)(486006)(5660300002)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2447;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e22d04bd-ec4d-44d1-bd4b-08d74de8a99a
NoDisclaimer: True
X-Forefront-PRVS: 0187F3EA14
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eIWGQuFuc6ZIij9SFP6M5Wk1Lk/0BZT+ho5paWPS9JVq8F+mZssdKDplALKtybw7fXGRxmjw+uAdGc91BCawRTnzwUBfGgyU3z/SI1s+mNX1Lkggq1L6OZ+HrLTTIAr2QEjAQPE/tsApN/GDH+JzIxr0kbOXiu5eLpx+Eq+AvBf12iX0TY1+G3x2DqBBM2x5h/KwRTN+lAesCIyoaoWIK9o+peqUSsLN0vkFiRGnjCHAjA4MSHR7xIn1gm5ah0sYyOA/Zu7T1xflDIeUocckQgRnhq/kaa+dk+BzUjqXOfYFyAo2LpBdsjgFjavYLmVm+fSe4X7f7EoMcuydhl53OARqHEa1/XpkVzvo+wC/RB6/b29SRIl2Xm5cje/GJ8VYpTus7eW5Y8kDOFkmamCrANINxIUauZEidoSzS4g3f3qViQappI5vxDD9/BHhT11M02a5EQejuWk1cI0C1MQw8A==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2019 01:16:51.1274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f885d0-6134-499e-3269-08d74de8b216
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2447
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2F0YWxpbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENhdGFs
aW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgT2N0
b2JlciAxMSwgMjAxOSAxMjo0MyBBTQ0KPiBUbzogSnVzdGluIEhlIChBcm0gVGVjaG5vbG9neSBD
aGluYSkgPEp1c3Rpbi5IZUBhcm0uY29tPg0KPiBDYzogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVs
Lm9yZz47IE1hcmsgUnV0bGFuZA0KPiA8TWFyay5SdXRsYW5kQGFybS5jb20+OyBKYW1lcyBNb3Jz
ZSA8SmFtZXMuTW9yc2VAYXJtLmNvbT47IE1hcmMNCj4gWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+
OyBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz47IEtpcmlsbCBBLg0KPiBTaHV0
ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT47IGxpbnV4LWFybS0NCj4ga2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LQ0KPiBtbUBrdmFjay5vcmc7IFN1enVraSBQb3Vsb3NlIDxTdXp1a2kuUG91bG9zZUBhcm0u
Y29tPjsgQm9yaXNsYXYNCj4gUGV0a292IDxicEBhbGllbjguZGU+OyBILiBQZXRlciBBbnZpbiA8
aHBhQHp5dG9yLmNvbT47IHg4NkBrZXJuZWwub3JnOw0KPiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhA
bGludXRyb25peC5kZT47IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtDQo+IGZvdW5kYXRpb24u
b3JnPjsgaGVqaWFuZXRAZ21haWwuY29tOyBLYWx5IFhpbiAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEp
DQo+IDxLYWx5LlhpbkBhcm0uY29tPjsgbmQgPG5kQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjExIDEvNF0gYXJtNjQ6IGNwdWZlYXR1cmU6IGludHJvZHVjZSBoZWxwZXINCj4gY3B1
X2hhc19od19hZigpDQo+IA0KPiBPbiBXZWQsIE9jdCAwOSwgMjAxOSBhdCAwNDo0Mjo0M1BNICsw
ODAwLCBKaWEgSGUgd3JvdGU6DQo+ID4gV2UgdW5jb25kaXRpb25hbGx5IHNldCB0aGUgSFdfQUZE
Qk0gY2FwYWJpbGl0eSBhbmQgb25seSBlbmFibGUgaXQgb24NCj4gPiBDUFVzIHdoaWNoIHJlYWxs
eSBoYXZlIHRoZSBmZWF0dXJlLiBCdXQgc29tZXRpbWVzIHdlIG5lZWQgdG8ga25vdw0KPiA+IHdo
ZXRoZXIgdGhpcyBjcHUgaGFzIHRoZSBjYXBhYmlsaXR5IG9mIEhXIEFGLiBTbyBkZWNvdXBsZSBB
RiBmcm9tDQo+ID4gREJNIGJ5IGEgbmV3IGhlbHBlciBjcHVfaGFzX2h3X2FmKCkuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBKaWEgSGUgPGp1c3Rpbi5oZUBhcm0uY29tPg0KPiA+IFN1Z2dlc3Rl
ZC1ieTogU3V6dWtpIFBvdWxvc2UgPFN1enVraS5Qb3Vsb3NlQGFybS5jb20+DQo+ID4gUmV2aWV3
ZWQtYnk6IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQo+IA0KPiBJ
IGRvbid0IHRoaW5rIEkgcmV2aWV3ZWQgdGhpcyB2ZXJzaW9uIG9mIHRoZSBwYXRjaC4NCg0KU29y
cnkgYWJvdXQgdGhhdC4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9h
c20vY3B1ZmVhdHVyZS5oDQo+IGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9jcHVmZWF0dXJlLmgN
Cj4gPiBpbmRleCA5Y2RlNWQyZTc2OGYuLjFhOTUzOTZlYTVjOCAxMDA2NDQNCj4gPiAtLS0gYS9h
cmNoL2FybTY0L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmUuaA0KPiA+ICsrKyBiL2FyY2gvYXJtNjQv
aW5jbHVkZS9hc20vY3B1ZmVhdHVyZS5oDQo+ID4gQEAgLTY1OSw2ICs2NTksMjAgQEAgc3RhdGlj
IGlubGluZSB1MzINCj4gaWRfYWE2NG1tZnIwX3BhcmFuZ2VfdG9fcGh5c19zaGlmdChpbnQgcGFy
YW5nZSkNCj4gPiAgCWRlZmF1bHQ6IHJldHVybiBDT05GSUdfQVJNNjRfUEFfQklUUzsNCj4gPiAg
CX0NCj4gPiAgfQ0KPiA+ICsNCj4gPiArLyogQ2hlY2sgd2hldGhlciBoYXJkd2FyZSB1cGRhdGUg
b2YgdGhlIEFjY2VzcyBmbGFnIGlzIHN1cHBvcnRlZCAqLw0KPiA+ICtzdGF0aWMgaW5saW5lIGJv
b2wgY3B1X2hhc19od19hZih2b2lkKQ0KPiA+ICt7DQo+ID4gKwlpZiAoSVNfRU5BQkxFRChDT05G
SUdfQVJNNjRfSFdfQUZEQk0pKSB7DQo+IA0KPiBQbGVhc2UganVzdCByZXR1cm4gZWFybHkgaGVy
ZSB0byBhdm9pZCB1bm5lY2Vzc2FyeSBpbmRlbnRhdGlvbjoNCg0KT2theQ0KPiANCj4gCWlmICgh
SVNfRU5BQkxFRChDT05GSUdfQVJNNjRfSFdfQUZEQk0pKQ0KPiAJCXJldHVybiBmYWxzZTsNCj4g
DQo+ID4gKwkJdTY0IG1tZnIxID0gcmVhZF9jcHVpZChJRF9BQTY0TU1GUjFfRUwxKTsNCj4gPiAr
DQo+ID4gKwkJcmV0dXJuICEhY3B1aWRfZmVhdHVyZV9leHRyYWN0X3Vuc2lnbmVkX2ZpZWxkKG1t
ZnIxLA0KPiA+ICsNCj4gCUlEX0FBNjRNTUZSMV9IQURCU19TSElGVCk7DQo+IA0KPiBObyBuZWVk
IGZvciAhISwgdGhlIHJldHVybiB0eXBlIGlzIGEgYm9vbCBhbHJlYWR5Lg0KDQpCdXQgY3B1aWRf
ZmVhdHVyZV9leHRyYWN0X3Vuc2lnbmVkX2ZpZWxkIGhhcyB0aGUgcmV0dXJuIHR5cGUgInVuc2ln
bmVkIGludCIgWzFdDQoNClsxXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9hcmNoL2FybTY0L2luY2x1ZGUvYXNt
L2NwdWZlYXR1cmUuaCNuNDQ0DQoNCj4gDQo+IEFueXdheSwgYXBhcnQgZnJvbSB0aGVzZSBuaXRw
aWNrcywgdGhlIHBhdGNoIGlzIGZpbmUgeW91IGNhbiBrZWVwIG15DQo+IHJldmlld2VkLWJ5Lg0K
DQpUaGFua3Mg8J+YiQ0KPiANCj4gSWYgbGF0ZXIgd2Ugbm90aWNlZCBhIHBvdGVudGlhbCBwZXJm
b3JtYW5jZSBpc3N1ZSBvbiB0aGlzIHBhdGgsIHdlIGNhbg0KPiB0dXJuIGl0IGludG8gYSBzdGF0
aWMgbGFiZWwgYXMgd2l0aCBvdGhlciBDUFUgZmVhdHVyZXMuDQoNCk9rYXkNCg0KLS0NCkNoZWVy
cywNCkp1c3RpbiAoSmlhIEhlKQ0KDQo=
