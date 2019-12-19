Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F77C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9A7227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OHVyXXUA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="KiuKtIiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfLSMyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:54:41 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:46928 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbfLSMyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:54:41 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3808A405BC;
        Thu, 19 Dec 2019 12:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1576760080; bh=Q1ER6K86z6A3jHiaM/mR7rc+Ff3LNSGXXroWsWjqt8E=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=OHVyXXUAKtceg5/kVMHspHtuV/jssIvCqWL1u1f90HY8BTDeCsiuPrIchQI7W+1AL
         CbmwMrUamSParJPhvBTWkLGURQ4QoGYZTS/8lP86WO7nkd7GgxGe2/NKrisIKo2QN2
         iOmhYs5RtADeDqiYwmaB1JMKD4tIZcI6ThBQDXJZIekdFpsQlTwu9Tf8QY0pR4zK/I
         vASzLSxCf8XifzRWRq9DyECjHiP51g29+Q4I3dGcILTNIPCSkIpWkATOrK5QMerpwl
         FzBRlVL3TMYlvvw8Af3ZvHasEeejuXUCGR9gBJo2IgzoJ785Fb44chlGjKh0rAvQXl
         QxhII9LUgpfkA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 74863A0079;
        Thu, 19 Dec 2019 12:54:37 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 19 Dec 2019 04:54:28 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 19 Dec 2019 04:54:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iq2k5zDMwH7AzpyzEO86x0TkOO/7F3TaiJkvh8JsFJxu/PCSHVuwwp/4uTF+756N3sPxSxls90VhhaE5ELVwlsms0QT2CM2feq5PR1RWldSdeiQa6zGlVGMZ+VtBEqrNEsW6NswfCPMODMe+rqYb0LhQFmfhvWuxP466vc8zctzfsZ2YY6x5FGWOYUXIYiLtAmUMrcn1e+5xdL/wmOWRGAzU2ivLsBkdSvbk6unaEVFaXzOnb2e0gIeAHSOR9kaa5e64amIEMHT4R+Y6AHmUVZ55dDDSfIqYzO16V/vgkeVNanZcO88E1E69jFGxFfYx5GHjvZtNu/5MJ+1KF3g3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1ER6K86z6A3jHiaM/mR7rc+Ff3LNSGXXroWsWjqt8E=;
 b=H3x5OJpjiCecIMeh1Yf9btDMPshqLfzcDrdNe1C49MyEX7V4WmiGo/iZzBTZiAEWOs0DZkW+NLZQS82fyN5YXqErgoFx5Rgws0awry86Lnk8GM2cX1aVcARqJJZ4xJK/TYYGsqaJ+KBYQRvvHOc10N06A6zjZ3RCGLyTwXtfsb9VtHOYywSMOKcLokAZ2Rq1wzX/niGUGlpHg4MiLKr5upvIPUk8ovbsAdxg9XbozMXkpPrXnEBzjH9p8u2PD98k+Riiu00wF1pLBd/nZcervIkCZYkW9Fj1raoxiwTtFUjsam9Emq5VvjqVAwcUPP/lc+G08WwfloC5JfkHC30uCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1ER6K86z6A3jHiaM/mR7rc+Ff3LNSGXXroWsWjqt8E=;
 b=KiuKtIiXowx2l1rwC6656rnWIFmqnC0dwY7zmjFFpxl7xryOV562JJKCkkaH22wLtNbonmBSdpvkLy0BfJxmVobTbdUKpGUaH8bWT4bPxgrOGPWCmbNcEt2jdXz4ZFXx+mSEkG9ibQbecKAOYWdD0NSXzaS2EAJcYLPUc5sWlok=
Received: from MN2PR12MB4093.namprd12.prod.outlook.com (52.135.51.203) by
 MN2PR12MB3454.namprd12.prod.outlook.com (20.178.242.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 12:54:27 +0000
Received: from MN2PR12MB4093.namprd12.prod.outlook.com
 ([fe80::d0e:7272:4a88:ffeb]) by MN2PR12MB4093.namprd12.prod.outlook.com
 ([fe80::d0e:7272:4a88:ffeb%5]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 12:54:27 +0000
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kgene@kernel.org" <kgene@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "amelie.delaunay@st.com" <amelie.delaunay@st.com>
Subject: Re: [PATCH v2 0/2] Add yaml DWC2 bindings
Thread-Topic: [PATCH v2 0/2] Add yaml DWC2 bindings
Thread-Index: AQHVtlg1SWbTGIsCKUivGYMMUpd+xafBajIA
Date:   Thu, 19 Dec 2019 12:54:27 +0000
Message-ID: <c6101bcb-1491-b9ce-b0f8-e50826202ee3@synopsys.com>
References: <20191219103536.25485-1-benjamin.gaignard@st.com>
In-Reply-To: <20191219103536.25485-1-benjamin.gaignard@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hminas@synopsys.com; 
x-originating-ip: [46.162.196.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e911fc8a-129b-4a9e-73a7-08d7848294ba
x-ms-traffictypediagnostic: MN2PR12MB3454:
x-microsoft-antispam-prvs: <MN2PR12MB3454F73E4F28AE818469A2B4A7520@MN2PR12MB3454.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(136003)(376002)(346002)(366004)(199004)(189003)(31696002)(5660300002)(478600001)(66946007)(81156014)(76116006)(81166006)(6512007)(4326008)(6486002)(110136005)(7416002)(36756003)(186003)(31686004)(86362001)(2906002)(91956017)(71200400001)(8936002)(66476007)(8676002)(316002)(2616005)(53546011)(54906003)(4744005)(6506007)(64756008)(26005)(66446008)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR12MB3454;H:MN2PR12MB4093.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EiM1FTjAdoffOd9KgMPY5SSON6nrGJNf27wXHsGHeW+VDidOcxe58KFkhJFREd7TAq/etHeM1BrXRIAA6vR2cYn2PZzXyRZOZiXt/m9p2RrVBWxnC53IQc92Ive/rWMROEO6IFMiFb2ue+TK4a8uCJ+Xm3R96yiKHeuuxKmqyMRhIjukTjkK9wZFMqK43ZIOpVDdXdLZrPPtBvVfEruMKN1IgIfFP0CIX8HxI4yckbHcoYzvKbbSdOMctBY96iWDnb42VMg0FooNvoOWFrPByDS8l8IvdeWfoSexAu0Y0M2duu/ZiD4/5MNWufa8GPJ9QqpBsXfoooENLLprIeywvRUy+egTkPvM2Q+pkC5ldwhsyndojCMfFEtr2/52GOtYIDtdEtDGZGcBDav4P6oy+B54V4vePSLebra3x4T9mzHpPKnSlLVFFqI9QShFm6Ut
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C22F634CEFEC894B8CE99BABDC974744@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e911fc8a-129b-4a9e-73a7-08d7848294ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 12:54:27.0553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YVGYFkMPBq5/FyCmv5ikFjz/6vhjEUVOr357SesOSHTczKPgRKomNUp0w6keKjZ3+LE4efhNQGXaQjJS75JFPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3454
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmVuamFtaW4sDQoNCk9uIDEyLzE5LzIwMTkgMjozNSBQTSwgQmVuamFtaW4gR2FpZ25hcmQg
d3JvdGU6DQo+IENvbnZlcnQgRFdDMiBiaW5kaW5ncyB0byBqc29uLXNjaGVtYSBhbmQgZml4IGlz
c3VlIGluIGR0c2kgZmlsZS4NCj4gDQo+IEJlbmphbWluIEdhaWduYXJkICgyKToNCj4gICAgZHQt
YmluZGluZ3M6IHVzYjogQ29udmVydCBEV0MyIGJpbmRpbmdzIHRvIGpzb24tc2NoZW1hDQo+ICAg
IEFSTTogZHRzOiBleHlub3M6IFJlbW92ZSB1bm5lZWRlZCAic25wcyxkd2MyIiBmcm9tIGhzb3Rn
IG5vZGUNCj4gDQo+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9kd2My
LnR4dCAgfCAgNjQgLS0tLS0tLS0tLQ0KPiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy91c2IvZHdjMi55YW1sIHwgMTUyICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGFy
Y2gvYXJtL2Jvb3QvZHRzL2V4eW5vczMyNTAuZHRzaSAgICAgICAgICAgICAgIHwgICAyICstDQo+
ICAgMyBmaWxlcyBjaGFuZ2VkLCAxNTMgaW5zZXJ0aW9ucygrKSwgNjUgZGVsZXRpb25zKC0pDQo+
ICAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2IvZHdjMi50eHQNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3VzYi9kd2MyLnlhbWwNCj4gDQoNCkluIE1haW50YWluZXJzIGZpbGUgbWVu
dGlvbmVkIHRoYXQgRUhDSSBhbmQgT0hDSSBkcml2ZXJzIG1haW50YWluZXIgaXMgDQpBbGFuIFN0
ZXJuLCBidXQgaW4gMiBleGlzdGluZyB5YW1sIGZpbGVzIChnZW5lcmljLWVoY2kueWFtbCBhbmQg
DQpnZW5lcmljLW9oY2kueWFtbCkgbWVudGlvbmVkIHRoYXQgbWFpbnRhaW5lciBpcyBHcmVnIEty
b2FoLUhhcnRtYW4uDQpTbywgSSdtIG5vdCBzdXJlIHRoYXQgaW4gZHdjMi55YW1sIGZpbGUgc2hv
dWxkIGJlIHdyaXR0ZW4gbWUuDQpBY3R1YWxseSBJJ20gbm90IGZhbWlsaWFyIHdpdGggZG9jdW1l
bnRhdGlvbi9iaW5kaW5ncy4NCg0KVGhhbmtzLA0KTWluYXMNCg==
