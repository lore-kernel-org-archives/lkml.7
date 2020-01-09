Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12800C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B846A20721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qigWHL3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgAIFO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 00:14:29 -0500
Received: from mail-db8eur05on2062.outbound.protection.outlook.com ([40.107.20.62]:25833
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbgAIFO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 00:14:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fowr2MQkUXFzEpiVezEDtHhBKaarZCBnl8Lf+74g8iF3npkIMsqyMFqTqqdVSiAFC2Nuf4DZYJRtzDOEQrlhXfHqXFol2l7Axwhi7u+dc1G2Tfx++t2TliTYkIh5zudSfLnsC72U0aWV2YhQhGWWFOn1mQ55yIeuTS7pCXXW3zfhZLJo6JHDWgB2xA6+t0aqrjacm5vkz6hKOO+sTtyzN9GxoaCrV+ubQHh9In5gMNQ03jWr2BCmgJ7VidnV02ihTA8Dcq90S0kz9k1ZFTKv1lHCGXXYMdyJXEuBYQoDJwIcNV25hJIWZ6KhG8XLYS7zMIWTmW+MH+GOrteqLipFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd85rFmelP/o2GcQ5qRkynq+u/o/1LJ6dLEODaLqEjE=;
 b=b8ZMfteBVpcg6EVwbYyqLJRYfuTG71zZV39gJdkcFN1k4pZqUM9VT93yndI6WWn49HpcJUKMyPMu2M1cYNF6NPKSJXhE1W0MXeZtiSdL6MqJyamiG/YMpZf6uRWe03MHwJcZ0uFYJFKo9RC4GT6uG+6NXfzavEA0zNdC6gBEzV7B2coUhvg4fle4s4KBY9wxgQgtR7T456+llnUFXMG1JRwwzhTkuLhMJV5uhbkmFx09EUnREdw1a1U5qvGDIPzdI9IuMM1AbeaiCqj0y3EHLNVlSUivwm5bCL7jWYSFnstO5QQAEbteaNkRmehTTJueu9D63OHSY+mPMhDeJK7qkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd85rFmelP/o2GcQ5qRkynq+u/o/1LJ6dLEODaLqEjE=;
 b=qigWHL3O/R/GllifPFevcF7w+94paSGvSNE/3rZ+Lnz0Uft7LmflaSk1SxgeGRVwVNu7VqmiokpGr6w8S3harrbEAsvWX/CiaL96RxO7rhY0TiZCBCNWY597dxUxYOz8kXgzVdGLtaBWiG3ZnR5mczSLb9wPx1P5u96zZEZ3Muo=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB5305.eurprd04.prod.outlook.com (20.176.236.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Thu, 9 Jan 2020 05:14:24 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::b40b:46af:9458:f2df]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::b40b:46af:9458:f2df%6]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 05:14:24 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V4 1/2] dt-bindings/irq: add binding for NXP INTMUX
 interrupt multiplexer
Thread-Topic: [PATCH V4 1/2] dt-bindings/irq: add binding for NXP INTMUX
 interrupt multiplexer
Thread-Index: AQHVtzJR1bo6WHpuN02oPlbZy7KDtKfgQkIAgAGmXnA=
Date:   Thu, 9 Jan 2020 05:14:24 +0000
Message-ID: <DB7PR04MB4618A1607B4E95689CBEC353E6390@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <1576845281-32675-1-git-send-email-qiangqing.zhang@nxp.com>
 <1576845281-32675-2-git-send-email-qiangqing.zhang@nxp.com>
 <CAL_Jsq+ZJ0asAxaPFgiuHKC2o6UP_5Mht=EascFVpJ6AUoKPvA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+ZJ0asAxaPFgiuHKC2o6UP_5Mht=EascFVpJ6AUoKPvA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6295e126-96b0-4591-1480-08d794c2caee
x-ms-traffictypediagnostic: DB7PR04MB5305:|DB7PR04MB5305:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB53051090D39971DDFE2D347CE6390@DB7PR04MB5305.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(189003)(199004)(13464003)(52536014)(66946007)(54906003)(7416002)(81156014)(4326008)(9686003)(66556008)(81166006)(76116006)(316002)(8676002)(66476007)(66446008)(2906002)(8936002)(186003)(55016002)(64756008)(6506007)(7696005)(26005)(4744005)(478600001)(33656002)(53546011)(5660300002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5305;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: edLI4nd1Q1x/BV5aurDzrel2pXDnAd5Q6h33xx1uTXITqu3qi28rsPrfTIN4KrGgZ6PIgfc2WiZB7uVHRotOTeiJ2py3C4o+Y7yxGMq5eLvs9lrMhOa/UKZsqHd75+tsVHiv94V8THj9LJ6E60QLASDBv2q9QWuI7Lr2OfAdbYNj9NqrC/oIbJ7sCNHRLu5Ec5qlRM5Mq/vyrT/oouCOPAIbdyXfUeOz5zCe48f1GHYcqCw+oeD/jo4thFUfcygJ8SYw4Pvg6hSJh7yQaVdkPTxqVVhaoXW3V0dKf9J5VCNBC+i2yYSxJcepW5Ohkm1tZZ1H5HZ3ZTFQUa87WC2GKv7GODi5C6Flc+TESR6aOBsaNGSdjJSuNkXw/Jc+4Xs4NdkKKNVa8V6k5jAO63fW/sfm1BqPFdj7wLSGrdgm41wguapuF6wVbwUeZmy6H55uU/MTIsMwmyWEKMSAXDU4sMwcF0a8i3aPrPi8hmZ0qttTEOrCScoabPQ1Lks5Y3tv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6295e126-96b0-4591-1480-08d794c2caee
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 05:14:24.4371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lV6r0FlQ1nKmvvsZ8M+LYPNy4Q0Q8Y2BrebxumVqRRlzDjPhukP854ZNKOplusmYMJTGvet8l+UfaRyEcfq7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5305
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2Jo
K2R0QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjDlubQx5pyIOOaXpSAxMjowMg0KPiBUbzogSm9h
a2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gQ2M6IE1hcmMgWnluZ2llciA8
bWF6QGtlcm5lbC5vcmc+OyBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47DQo+
IEphc29uIENvb3BlciA8amFzb25AbGFrZWRhZW1vbi5uZXQ+OyBNYXJrIFJ1dGxhbmQNCj4gPG1h
cmsucnV0bGFuZEBhcm0uY29tPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgU2Fz
Y2hhDQo+IEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgU2FzY2hhIEhhdWVyIDxrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU+Ow0KPiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQW5keSBEdWFuDQo+IDxmdWdhbmcuZHVhbkBu
eHAuY29tPjsgbW9kZXJhdGVkIGxpc3Q6QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMgQVJNDQo+IEFS
Q0hJVEVDVFVSRSA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIFY0IDEvMl0gZHQtYmluZGluZ3MvaXJxOiBhZGQgYmluZGluZyBmb3Ig
TlhQIElOVE1VWA0KPiBpbnRlcnJ1cHQgbXVsdGlwbGV4ZXINCj4gDQo+IE9uIEZyaSwgRGVjIDIw
LCAyMDE5IGF0IDY6MzggQU0gSm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4N
Cj4gd3JvdGU6DQo+ID4NCj4gPiBUaGlzIHBhdGNoIGFkZHMgdGhlIERUIGJpbmRpbmdzIGZvciB0
aGUgTlhQIElOVE1VWCBpbnRlcnJ1cHQNCj4gPiBtdWx0aXBsZXhlciBmb3IgaS5NWDggZmFtaWx5
IFNvQ3MuDQo+IA0KPiA0IHZlcnNpb25zIGluIDIgZGF5cz8gRG9uJ3QgZG8gdGhhdC4gR2l2ZSBy
ZXZpZXdlcnMgc29tZSB0aW1lLg0KPiANCj4gQ29udmVydCB0aGlzIHRvIERUIHNjaGVtYSBwbGVh
c2UuIEFuZCBtYWtlIHN1cmUgdG8gc2VuZCB0byBEVCBsaXN0IGlmIHlvdSB3YW50DQo+IGl0IHJl
dmlld2VkLiBZb3Ugb25seSBzZW50IHYxIHRvIHRoZSBsaXN0Lg0KDQpUaGFua3MgUm9iLiBJIHdp
bGwgY29udmVydCB0aGlzIGludG8gRFQgc2NoZW1hLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0g
WmhhbmcNCj4gUm9iDQo=
