Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F6BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A541121922
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="qGI2CLx4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="X/vwgmye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfHGLRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:17:51 -0400
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:28487
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726873AbfHGLRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2akGUlw3MHuPSW3jwQyRM5Tf8uPLSE9lYdcwSDrqmh0=;
 b=qGI2CLx4nHB5unmWhDr3RP0g0UO+eDeETZuLJMNsZ7b0l+JOL2B4UsyHLO49i2Y+X/CtZY5541duvUUoY+Htc2KDQMF0Osu7Lwi9NRkLpginSA9wLzhiujJKO2B0EZbLRYEbJq/PdzhTLxsmgD7vKaHPSoE95EIjxSM8Rxj4PxI=
Received: from DB7PR08CA0018.eurprd08.prod.outlook.com (2603:10a6:5:16::31) by
 DB6PR0802MB2597.eurprd08.prod.outlook.com (2603:10a6:4:99::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Wed, 7 Aug 2019 11:17:39 +0000
Received: from AM5EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by DB7PR08CA0018.outlook.office365.com
 (2603:10a6:5:16::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.16 via Frontend
 Transport; Wed, 7 Aug 2019 11:17:38 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT040.mail.protection.outlook.com (10.152.17.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Wed, 7 Aug 2019 11:17:37 +0000
Received: ("Tessian outbound cc8a947d4660:v26"); Wed, 07 Aug 2019 11:17:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: af215e18233e7293
X-CR-MTA-TID: 64aa7808
Received: from b6871704ccdf.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EDA68FC2-2034-4AE4-B9A1-41C7E22E245C.1;
        Wed, 07 Aug 2019 11:17:29 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2056.outbound.protection.outlook.com [104.47.8.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b6871704ccdf.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 07 Aug 2019 11:17:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDdI1XcSzZi8XifVhCwd9yPxxSQwv2A9FnksQqOmkFLFuVWHyYLJmm17T+FdEFjxP2E0aOpvtogkzk48tH0C4JhX3JTxhNEiWNgwCivrrucd2npTUOPabCgUBJWd4X+Y3cK/9ZiR6jFaFS7opqPz0EfqX4f4tIh/rjoHoZuBufNq7x7EUyZO9fB4wNdi7xA/15EMacQXe+WPhPMpRVWa3k4LFRaOGPr73tbXYP49lzgkcxUPZOCsMttyWAZqtqOmpTylSGVPNLovLLQPvEQ6qnVJSOfoTe3pquXX8M4aDDQT0/OlyqRa2QwImUoK59kTN3FFvdmorpk0d+eDSdYU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6t8VmygeFRzfcYbjPIKIEh0eXDkxjh8IkBsDNsx6Bw=;
 b=HAIyPp2adC7RiKT6RdhxcObSGR9WzEzuAAQU00WI/LQNye/rkYaMltECbVlbdfuKFlXmLwMR1mSAdQScQew/7+O9iznpTlVuIK38aEWkT+grh/ayPHt9HdmQQpUOi0vGX77ccBxzIHY6tX/6TDH/fInAwlfCxaBFh17/VryBqRyEWBmMHkDqOUEXZZlMylvJ0qKcc970ULhjcs2u2GWELhW/yc/+wk1uL/OTIpN4/DIK9WXg8BiK+GwPpWBw6xNTLx+2K3yFjwS8vrjYKTrfxh3Ctq2gQT3v32TX+LPmv0NNbT0SMO9gblDwi4qyvf4lZBZOy82WVzTskPXASwnJKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6t8VmygeFRzfcYbjPIKIEh0eXDkxjh8IkBsDNsx6Bw=;
 b=X/vwgmyeqbixXXTHAHp8cMC22ucrjw7GGJQ7C+NOJp0W2O6KQw3cA1H/+eN1zSC2khxuZmhZcELUTUzBOWAkPR6oKPrTdBS6UHIV1fAe2ZoQG64uOnQ/hGQRcggwICshOPEPhw34bZSuV8ZPs691La3mmLd6V6081B5C/iELLwU=
Received: from DB6PR08MB2647.eurprd08.prod.outlook.com (10.175.233.142) by
 DB6PR08MB2821.eurprd08.prod.outlook.com (10.170.220.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.20; Wed, 7 Aug 2019 11:17:27 +0000
Received: from DB6PR08MB2647.eurprd08.prod.outlook.com
 ([fe80::5804:a8fc:c70e:cb4c]) by DB6PR08MB2647.eurprd08.prod.outlook.com
 ([fe80::5804:a8fc:c70e:cb4c%7]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 11:17:27 +0000
From:   Tushar Khandelwal <Tushar.Khandelwal@arm.com>
To:     Sudeep Holla <Sudeep.Holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tushar.2nov@gmail.com" <tushar.2nov@gmail.com>,
        "morten_bp@live.dk" <morten_bp@live.dk>, nd <nd@arm.com>,
        Morten Petersen <Morten.Petersen@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/4] mailbox: arm_mhuv2: add device tree binding
 documentation
Thread-Topic: [PATCH 1/4] mailbox: arm_mhuv2: add device tree binding
 documentation
Thread-Index: AQHVPNWWqZ5nqYwTRESTK6j2lnJD4KbVpRIAgBIkAwCAB/FmgA==
Date:   Wed, 7 Aug 2019 11:17:27 +0000
Message-ID: <998A97B0-D9D3-4F01-B5D4-56F875D38FC8@arm.com>
References: <20190717192616.1731-1-tushar.khandelwal@arm.com>
 <20190717192616.1731-2-tushar.khandelwal@arm.com>
 <CABb+yY04vW-i35N6P57KSKgmMAYkrA2CDyUvA-bLCZMxiZaocw@mail.gmail.com>
 <20190802105938.GG23424@e107155-lin>
In-Reply-To: <20190802105938.GG23424@e107155-lin>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1b.0.190715
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Tushar.Khandelwal@arm.com; 
x-originating-ip: [217.140.106.49]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 8a49a006-bddf-401d-551c-08d71b28da8d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB6PR08MB2821;
X-MS-TrafficTypeDiagnostic: DB6PR08MB2821:|DB6PR0802MB2597:
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2597BE6E170273AE9CF8F162F7D40@DB6PR0802MB2597.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 01221E3973
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(229853002)(76176011)(305945005)(7736002)(8676002)(6512007)(33656002)(256004)(2906002)(81166006)(71190400001)(71200400001)(81156014)(8936002)(53936002)(6246003)(54906003)(316002)(3846002)(186003)(11346002)(446003)(68736007)(476003)(102836004)(110136005)(58126008)(99286004)(26005)(53546011)(15650500001)(6116002)(36756003)(6506007)(2616005)(486006)(6436002)(5660300002)(478600001)(66556008)(66946007)(64756008)(66476007)(66446008)(25786009)(4326008)(76116006)(66066001)(86362001)(14454004)(6486002)(91956017);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR08MB2821;H:DB6PR08MB2647.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: zo9yVLj1/ALyRkZ+s7Ru4s0Otj9nyruOynMPZXww03K9Xisi6A2YS/4ktAw7ZkW0sBcqvlbFkakKHd0RYwzgXANA3MCXttcpwkYsf1tt5rLPGwPAsAYjHqgkU6qgzaYE2NjM6RTLwi3M2RcpkYZf7N3IVGZ7T0sLok2UzLOgdEAYds0Ae9oX5ApdKTMDY0OzJArdmnkUFNqBVDPWhoNYmOQOhXDihKocsZuKTyPBiVedFmGgYBNN63RBrMCb9bcBmwU7mG6QckYpd30YsJ/qPcxwJRofVNqQw1G5tAUaJDXGXmcLzmwsX9CR+fxlUnz3BNmvKuOEG/XJy435K4Zbt5wk6fmtQ4q76sZrzh8qEnZDtDo3f7xRMasox1Dxlk6dhu8Rkg67mtGmRmOpcW3+4M07lql6C0OoJx6Xk3s5jVs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A255E356161BDE4ABF590540DBE20E36@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2821
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tushar.Khandelwal@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(2980300002)(40434004)(189003)(199004)(102836004)(3846002)(6116002)(356004)(53546011)(86362001)(99286004)(6506007)(58126008)(54906003)(110136005)(229853002)(25786009)(5660300002)(486006)(76176011)(2486003)(22756006)(436003)(4326008)(26005)(2906002)(446003)(2616005)(63350400001)(186003)(6246003)(36906005)(11346002)(23676004)(63370400001)(50466002)(33656002)(5024004)(6512007)(8936002)(305945005)(126002)(15650500001)(14444005)(476003)(478600001)(26826003)(8676002)(336012)(6486002)(316002)(7736002)(450100002)(70586007)(81166006)(14454004)(36756003)(76130400001)(66066001)(70206006)(81156014)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2597;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: fa07ff41-8cd0-4a32-ed5c-08d71b28d4d2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB6PR0802MB2597;
X-Forefront-PRVS: 01221E3973
X-Microsoft-Antispam-Message-Info: aRuiWKveP4o1xuRe15hfjTpZhHy6+BRYotmkjck0GiQduWYhTTueE4zuk9EL1KVmDtEHYhVZBz3568UYREopt2TMCyhAQm+bI8WiKlDrh1XTMsryG9GLUk8hJ6D62tc6tBkCoOY6CoQI+XPsBoQ7xrAMwDn46o6SVENAtauzbjHWpFObV4/UvwDPIV2cPC32g3XmkWhULbNXmz8D63EW3lCy4WkdQ3sjaUaiWIFO+oIIwo5vZwxM/gUAJOyvLBjlXWG0TYu64B6LEmzTBV882qeehz7eqyaTAV4M6ep0nYw1SYZs8SqLx+NqNIPlzuFVdIInNlFRWdlJuoiPkEASiREHsnw7ZdeEVu9BjCYG5f+JjPks8rQKY6JC0SKog6IX39t1VM13vhtw+PwZNg2BpKwY+fLclyBUO2sWEWseArs=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2019 11:17:37.4230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a49a006-bddf-401d-551c-08d71b28da8d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2597
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDAyLzA4LzIwMTksIDExOjU5LCAiU3VkZWVwIEhvbGxhIiA8c3VkZWVwLmhvbGxh
QGFybS5jb20+IHdyb3RlOg0KDQogICAgT24gU3VuLCBKdWwgMjEsIDIwMTkgYXQgMDQ6NTg6MDRQ
TSAtMDUwMCwgSmFzc2kgQnJhciB3cm90ZToNCiAgICA+IE9uIFdlZCwgSnVsIDE3LCAyMDE5IGF0
IDI6MjYgUE0gVHVzaGFyIEtoYW5kZWx3YWwNCiAgICA+IDx0dXNoYXIua2hhbmRlbHdhbEBhcm0u
Y29tPiB3cm90ZToNCiAgICA+DQogICAgPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9hcm0sbWh1djIudHh0IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvYXJtLG1odXYyLnR4dA0KICAgID4gPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KICAgID4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjNhMDU1OTM0MTRiYw0K
ICAgID4gPiAtLS0gL2Rldi9udWxsDQogICAgPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tYWlsYm94L2FybSxtaHV2Mi50eHQNCiAgICA+ID4gQEAgLTAsMCArMSwx
MDggQEANCiAgICA+ID4gK0FybSBNSFV2MiBNYWlsYm94IERyaXZlcg0KICAgID4gPiArPT09PT09
PT09PT09PT09PT09PT09PT09DQogICAgPiA+ICsNCiAgICA+ID4gK1RoZSBBcm0gTWVzc2FnZS1I
YW5kbGluZy1Vbml0IChNSFUpIFZlcnNpb24gMiBpcyBhIG1haWxib3ggY29udHJvbGxlciB0aGF0
IGhhcw0KICAgID4gPiArYmV0d2VlbiAxIGFuZCAxMjQgY2hhbm5lbCB3aW5kb3dzIHRvIHByb3Zp
ZGUgdW5pZGlyZWN0aW9uYWwgY29tbXVuaWNhdGlvbiB3aXRoDQogICAgPiA+ICtyZW1vdGUgcHJv
Y2Vzc29yKHMpLg0KICAgID4gPiArDQogICAgPiA+ICtHaXZlbiB0aGUgdW5pZGlyZWN0aW9uYWwg
bmF0dXJlIG9mIHRoZSBkZXZpY2UsIGFuIE1IVXYyIG1haWxib3ggbWF5IG9ubHkgYmUNCiAgICA+
ID4gK3dyaXR0ZW4gdG8gb3IgcmVhZCBmcm9tLiBJZiBhIHBhaXIgb2YgTUhVIGRldmljZXMgaXMg
aW1wbGVtZW50ZWQgYmV0d2VlbiB0d28NCiAgICA+ID4gK3Byb2Nlc3NpbmcgZWxlbWVudHMgdG8g
cHJvdmlkZSBiaWRpcmVjdGlvbmFsIGNvbW11bmljYXRpb24sIHRoZXNlIG11c3QgYmUNCiAgICA+
ID4gK3NwZWNpZmllZCBhcyB0d28gc2VwYXJhdGUgbWFpbGJveGVzLg0KICAgID4gPiArDQogICAg
PiA+ICtBIGRldmljZSB0cmVlIG5vZGUgZm9yIGFuIEFybSBNSFV2MiBkZXZpY2UgbXVzdCBzcGVj
aWZ5IGVpdGhlciBhIHJlY2VpdmVyIGZyYW1lDQogICAgPiA+ICtvciBhIHNlbmRlciBmcmFtZSwg
aW5kaWNhdGluZyB3aGljaCBlbmQgb2YgdGhlIHVuaWRpcmVjdGlvbmFsIE1IVSBkZXZpY2Ugd2hp
Y2gNCiAgICA+ID4gK3RoZSBkZXZpY2Ugbm9kZSBlbnRyeSBkZXNjcmliZXMuDQogICAgPiA+ICsN
CiAgICA+ID4gK0FuIE1IVSBkZXZpY2UgbXVzdCBiZSBzcGVjaWZpZWQgd2l0aCBhIHRyYW5zcG9y
dCBwcm90b2NvbC4gVGhlIHRyYW5zcG9ydA0KICAgID4gPiArcHJvdG9jb2wgb2YgYW4gTUhVIGRl
dmljZSBkZXRlcm1pbmVzIHRoZSBtZXRob2Qgb2YgZGF0YSB0cmFuc21pc3Npb24gYXMgd2VsbCBh
cw0KICAgID4gPiArdGhlIG51bWJlciBvZiBwcm92aWRlZCBtYWlsYm94ZXMuDQogICAgPiA+ICtG
b2xsb3dpbmcgYXJlIHRoZSBwb3NzaWJsZSB0cmFuc3BvcnQgcHJvdG9jb2wgdHlwZXM6DQogICAg
PiA+ICstIFNpbmdsZS13b3JkOiBBbiBNSFUgZGV2aWNlIGltcGxlbWVudHMgYXMgbWFueSBtYWls
Ym94ZXMgYXMgaXQNCiAgICA+ID4gKyAgICAgICAgICAgICAgIHByb3ZpZGVzIGNoYW5uZWwgd2lu
ZG93cy4gRGF0YSBpcyB0cmFuc21pdHRlZCB0aHJvdWdoDQogICAgPiA+ICsgICAgICAgICAgICAg
ICB0aGUgTUhVIHJlZ2lzdGVycy4NCiAgICA+ID4gKy0gTXVsdGktd29yZDogIEFuIE1IVSBkZXZp
Y2UgaW1wbGVtZW50cyBhIHNpbmdsZSBtYWlsYm94LiBBbGwgY2hhbm5lbCB3aW5kb3dzDQogICAg
PiA+ICsgICAgICAgICAgICAgICB3aWxsIGJlIHVzZWQgZHVyaW5nIHRyYW5zbWlzc2lvbi4gRGF0
YSBpcyB0cmFuc21pdHRlZCB0aHJvdWdoDQogICAgPiA+ICsgICAgICAgICAgICAgICB0aGUgTUhV
IHJlZ2lzdGVycy4NCiAgICA+ID4gKy0gRG9vcmJlbGw6ICAgIEFuIE1IVSBkZXZpY2UgaW1wbGVt
ZW50cyBhcyBtYW55IG1haWxib3hlcyBhcyB0aGVyZSBhcmUgZmxhZw0KICAgID4gPiArICAgICAg
ICAgICAgICAgYml0cyBhdmFpbGFibGUgaW4gaXRzIGNoYW5uZWwgd2luZG93cy4gT3B0aW9uYWxs
eSwgZGF0YSBtYXkNCiAgICA+ID4gKyAgICAgICAgICAgICAgIGJlIHRyYW5zbWl0dGVkIHRocm91
Z2ggYSBzaGFyZWQgbWVtb3J5IHJlZ2lvbiwgd2hlcmVpbiB0aGUgTUhVDQogICAgPiA+ICsgICAg
ICAgICAgICAgICBpcyB1c2VkIHN0cmljdGx5IGFzIGFuIGludGVycnVwdCBnZW5lcmF0aW9uIG1l
Y2hhbmlzbS4NCiAgICA+ID4gKw0KICAgID4gPiArTWFpbGJveCBEZXZpY2UgTm9kZToNCiAgICA+
ID4gKz09PT09PT09PT09PT09PT09PT09DQogICAgPiA+ICsNCiAgICA+ID4gK1JlcXVpcmVkIHBy
b3BlcnRpZXM6DQogICAgPiA+ICstLS0tLS0tLS0tLS0tLS0tLS0tLQ0KICAgID4gPiArLSBjb21w
YXRpYmxlOiAgU2hhbGwgYmUgImFybSxtaHV2MiIgJiAiYXJtLHByaW1lY2VsbCINCiAgICA+ID4g
Ky0gcmVnOiAgICAgICAgIENvbnRhaW5zIHRoZSBtYWlsYm94IHJlZ2lzdGVyIGFkZHJlc3MgcmFu
Z2UgKGJhc2UNCiAgICA+ID4gKyAgICAgICAgICAgICAgIGFkZHJlc3MgYW5kIGxlbmd0aCkNCiAg
ICA+ID4gKy0gI21ib3gtY2VsbHMgIFNoYWxsIGJlIDEgLSB0aGUgaW5kZXggb2YgdGhlIGNoYW5u
ZWwgbmVlZGVkLg0KICAgID4gPiArLSBtaHUtZnJhbWUgICAgRnJhbWUgdHlwZSBvZiB0aGUgZGV2
aWNlLg0KICAgID4gPiArICAgICAgICAgICAgICAgU2hhbGwgYmUgZWl0aGVyICJzZW5kZXIiIG9y
ICJyZWNlaXZlciINCiAgICA+ID4gKy0gbWh1LXByb3RvY29sIFRyYW5zcG9ydCBwcm90b2NvbCBv
ZiB0aGUgZGV2aWNlLiBTaGFsbCBiZSBvbmUgb2YgdGhlDQogICAgPiA+ICsgICAgICAgICAgICAg
ICBmb2xsb3dpbmc6ICJzaW5nbGUtd29yZCIsICJtdWx0aS13b3JkIiwgImRvb3JiZWxsIg0KICAg
ID4gPiArDQogICAgPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzIChyZWNlaXZlciBmcmFtZSk6DQog
ICAgPiA+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogICAgPiA+ICst
IGludGVycnVwdHM6ICBDb250YWlucyB0aGUgaW50ZXJydXB0IGluZm9ybWF0aW9uIGNvcnJlc3Bv
bmRpbmcgdG8gdGhlDQogICAgPiA+ICsgICAgICAgICAgICAgICBjb21iaW5lZCBpbnRlcnJ1cHQg
b2YgdGhlIHJlY2VpdmVyIGZyYW1lDQogICAgPiA+ICsNCiAgICA+ID4gK0V4YW1wbGU6DQogICAg
PiA+ICstLS0tLS0tLQ0KICAgID4gPiArDQogICAgPiA+ICsgICAgICAgbWJveF9td190eDogbWh1
QDEwMDAwMDAwIHsNCiAgICA+ID4gKyAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLG1o
dXYyIiwiYXJtLHByaW1lY2VsbCI7DQogICAgPiA+ICsgICAgICAgICAgICAgICByZWcgPSA8MHgx
MDAwMDAwMCAweDEwMDA+Ow0KICAgID4gPiArICAgICAgICAgICAgICAgY2xvY2tzID0gPCZyZWZj
bGsxMDBtaHo+Ow0KICAgID4gPiArICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAiYXBiX3Bj
bGsiOw0KICAgID4gPiArICAgICAgICAgICAgICAgI21ib3gtY2VsbHMgPSA8MT47DQogICAgPiA+
ICsgICAgICAgICAgICAgICBtaHUtcHJvdG9jb2wgPSAibXVsdGktd29yZCI7DQogICAgPiA+ICsg
ICAgICAgICAgICAgICBtaHUtZnJhbWUgPSAic2VuZGVyIjsNCiAgICA+ID4gKyAgICAgICB9Ow0K
ICAgID4gPiArDQogICAgPiA+ICsgICAgICAgbWJveF9zd190eDogbWh1QDEwMDAwMDAwIHsNCiAg
ICA+ID4gKyAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLG1odXYyIiwiYXJtLHByaW1l
Y2VsbCI7DQogICAgPiA+ICsgICAgICAgICAgICAgICByZWcgPSA8MHgxMTAwMDAwMCAweDEwMDA+
Ow0KICAgID4gPiArICAgICAgICAgICAgICAgY2xvY2tzID0gPCZyZWZjbGsxMDBtaHo+Ow0KICAg
ID4gPiArICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAiYXBiX3BjbGsiOw0KICAgID4gPiAr
ICAgICAgICAgICAgICAgI21ib3gtY2VsbHMgPSA8MT47DQogICAgPiA+ICsgICAgICAgICAgICAg
ICBtaHUtcHJvdG9jb2wgPSAic2luZ2xlLXdvcmQiOw0KICAgID4gPiArICAgICAgICAgICAgICAg
bWh1LWZyYW1lID0gInNlbmRlciI7DQogICAgPiA+ICsgICAgICAgfTsNCiAgICA+ID4gKw0KICAg
ID4gPiArICAgICAgIG1ib3hfZGJfcng6IG1odUAxMDAwMDAwMCB7DQogICAgPiA+ICsgICAgICAg
ICAgICAgICBjb21wYXRpYmxlID0gImFybSxtaHV2MiIsImFybSxwcmltZWNlbGwiOw0KICAgID4g
PiArICAgICAgICAgICAgICAgcmVnID0gPDB4MTIwMDAwMDAgMHgxMDAwPjsNCiAgICA+ID4gKyAg
ICAgICAgICAgICAgIGNsb2NrcyA9IDwmcmVmY2xrMTAwbWh6PjsNCiAgICA+ID4gKyAgICAgICAg
ICAgICAgIGNsb2NrLW5hbWVzID0gImFwYl9wY2xrIjsNCiAgICA+ID4gKyAgICAgICAgICAgICAg
ICNtYm94LWNlbGxzID0gPDE+Ow0KICAgID4gPiArICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9
IDwwIDQ1IDQ+Ow0KICAgID4gPiArICAgICAgICAgICAgICAgaW50ZXJydXB0LW5hbWVzID0gIm1o
dV9yeCI7DQogICAgPiA+ICsgICAgICAgICAgICAgICBtaHUtcHJvdG9jb2wgPSAiZG9vcmJlbGwi
Ow0KICAgID4gPiArICAgICAgICAgICAgICAgbWh1LWZyYW1lID0gInJlY2VpdmVyIjsNCiAgICA+
ID4gKyAgICAgICB9Ow0KICAgID4gPiArDQogICAgPiA+ICsgICAgICAgbWh1X2NsaWVudDogc2Ni
QDJlMDAwMDAwIHsNCiAgICA+ID4gKyAgICAgICBjb21wYXRpYmxlID0gImZ1aml0c3UsbWI4NnM3
MC1zY2ItMS4wIjsNCiAgICA+ID4gKyAgICAgICByZWcgPSA8MCAweDJlMDAwMDAwIDB4NDAwMD47
DQogICAgPiA+ICsgICAgICAgbWJveGVzID0NCiAgICA+ID4gKyAgICAgICAgICAgICAgIC8vIEZv
ciBtdWx0aS13b3JkIGZyYW1lcywgY2xpZW50IG1heSBvbmx5IGluc3RhbnRpYXRlIGEgc2luZ2xl
DQogICAgPiA+ICsgICAgICAgICAgICAgICAvLyBtYWlsYm94IGZvciBhIG1haWxib3ggY29udHJv
bGxlcg0KICAgID4gPiArICAgICAgICAgICAgICAgPCZtYm94X213X3R4IDA+LA0KICAgID4gPiAr
DQogICAgPiA+ICsgICAgICAgICAgICAgICAvLyBGb3Igc2luZ2xlLXdvcmQgZnJhbWVzLCBjbGll
bnQgbWF5IGluc3RhbnRpYXRlIGFzIG1hbnkNCiAgICA+ID4gKyAgICAgICAgICAgICAgIC8vIG1h
aWxib3hlcyBhcyB0aGVyZSBhcmUgY2hhbm5lbCB3aW5kb3dzIGluIHRoZSBNSFUNCiAgICA+ID4g
KyAgICAgICAgICAgICAgICA8Jm1ib3hfc3dfdHggMD4sDQogICAgPiA+ICsgICAgICAgICAgICAg
ICAgPCZtYm94X3N3X3R4IDE+LA0KICAgID4gPiArICAgICAgICAgICAgICAgIDwmbWJveF9zd190
eCAyPiwNCiAgICA+ID4gKyAgICAgICAgICAgICAgICA8Jm1ib3hfc3dfdHggMz4sDQogICAgPiA+
ICsNCiAgICA+ID4gKyAgICAgICAgICAgICAgIC8vIEZvciBkb29yYmVsbCBmcmFtZXMsIGNsaWVu
dCBtYXkgaW5zdGFudGlhdGUgYXMgbWFueSBtYWlsYm94ZXMNCiAgICA+ID4gKyAgICAgICAgICAg
ICAgIC8vIGFzIHRoZXJlIGFyZSBiaXRzIGF2YWlsYWJsZSBpbiB0aGUgY29tYmluZWQgbnVtYmVy
IG9mIGNoYW5uZWwNCiAgICA+ID4gKyAgICAgICAgICAgICAgIC8vIHdpbmRvd3MgKChjaGFubmVs
IHdpbmRvd3MgKiAzMikgbWFpbGJveGVzKQ0KICAgID4gPiArICAgICAgICAgICAgICAgIDxtYm94
X2RiX3J4IDA+LA0KICAgID4gPiArICAgICAgICAgICAgICAgIDxtYm94X2RiX3J4IDE+LA0KICAg
ID4gPiArICAgICAgICAgICAgICAgIC4uLg0KICAgID4gPiArICAgICAgICAgICAgICAgIDxtYm94
X2RiX3J4IDE3PjsNCiAgICA+ID4gKyAgICAgICB9Ow0KICAgID4NCiAgICA+IElmIHRoZSBtaHV2
MiBpbnN0YW5jZSBpbXBsZW1lbnRzLCBzYXksIDMgY2hhbm5lbCB3aW5kb3dzIGJldHdlZW4NCiAg
ICA+IHNlbmRlciAobGludXgpIGFuZCByZWNlaXZlciAoZmlybXdhcmUpLCBhbmQgTGludXggcnVu
cyB0d28gcHJvdG9jb2xzDQogICAgPiBlYWNoIHJlcXVpcmluZyAxIGFuZCAyLXdvcmQgc2l6ZWQg
bWVzc2FnZXMgcmVzcGVjdGl2ZWx5LiBUaGUgaGFyZHdhcmUNCiAgICA+IHN1cHBvcnRzIHRoYXQg
YnkgYXNzaWduaW5nIHdpbmRvd3MgWzBdIGFuZCBbMSwyXSB0byBlYWNoIHByb3RvY29sLg0KICAg
ID4gSG93ZXZlciwgSSBkb24ndCB0aGluayB0aGUgZHJpdmVyIGNhbiBzdXBwb3J0IHRoYXQuIE9y
IGRvZXMgaXQ/DQogICAgPg0KDQogICAgRldJVywgdGhlIElQIGlzIGRlc2lnbmVkIHRvIGNvdmVy
IHdpZGUgcmFuZ2Ugb2YgdXNlY2FzZSBmcm9tIElvVCB0byBzZXJ2ZXJzDQogICAgd2l0aCB2YXJp
YWJsZSB3aW5kb3cgbGVuZ3RoLiBJIGRvbid0IHNlZSB0aGUgbmVlZCB0byBjb21wbGljYXRlIHRo
ZSBkcml2ZXINCiAgICBzdXBwb3J0aW5nIG1peC1uLW1hdGNoIGF0IHRoZSBjb3N0IG9mIGxhdGVu
Y3kuIEVhY2ggcGxhdGZvcm0gY2hvb3NlIG9uZQ0KICAgIHRyYW5zcG9ydCBwcm90b2NvbCBmb3Ig
YWxsIGl0J3MgdXNlLg0KDQpUaGUgZHJpdmVyIGRlc2lnbiBpcyB0byBhZGRyZXNzIHRoZSBtb3N0
IHByb2JhYmxlIHNjZW5hcmlvcyBhbmQgbm90IGFsbC4NClNpbmdsZS13b3JkIDogQ2xpZW50IGdl
dHMgb25lIDMyLWJpdCB3aW5kb3cNCkRvb3JiZWxsIDogQ2xpZW50IGdldHMgMzIgZGF0YSBwb2lu
dGVycyAoYXJtX21lc3NhZ2UpDQpNdWx0aS13b3JkOiBDbGllbnQgZ2V0cyBhbGwgY2hhbm5lbHMg
YXZhaWxhYmxlIGluIHRoZSBwbGF0Zm9ybS4NCg0KLS1UdXNoYXINCiAgICAtLQ0KICAgIFJlZ2Fy
ZHMsDQogICAgU3VkZWVwDQoNCg0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRo
aXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxz
byBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBw
bGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0
aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwg
b3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91
Lg0K
