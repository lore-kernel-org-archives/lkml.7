Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94470C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BA32171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JlDN3o9L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="Ve64x6RR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDLNWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:22:41 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:57790 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfDLNWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:22:40 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 29D5224E2E39;
        Fri, 12 Apr 2019 06:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555075360; bh=xT+mYFQpmlU3goz9KDCtrtTi6mj0HVqhWz/Z1JZEpU8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=JlDN3o9LcRuisfl1t8WBrHWiFsNWxyF6h8yk7Px2kauZ97gVCYlYnJYWiNlDj0L9i
         Aw88aTufELZweuavn6oD5kFLn+Lf9COQ6ZWPrnCXKvjxVMkvEzO8V6jM1attmbDhUb
         H9uxB7n1KX8QyNRdbhq4FScsoSxxDe75TVGQEn+OBEuZ62IQIqtXa9eX7zgYi+/WtV
         JaAs0+C1UfOGEOmxAeAGKNN+yEOOTS+G9tFt8VcLiC4wNUJ/aj/QLoDBjYhDkr5nNP
         kCtT59eHP/Nvtrgv4yNKREDU2d706b51ShK2b3R8e4l5cyn/U1jCF3dzMuwi65H5Eo
         JL2TVQRW9iDtQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 776E4A005A;
        Fri, 12 Apr 2019 13:22:39 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 12 Apr 2019 06:22:39 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 12 Apr 2019 06:22:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT+mYFQpmlU3goz9KDCtrtTi6mj0HVqhWz/Z1JZEpU8=;
 b=Ve64x6RRWzeMZkOkryjPLQ+Tnk5MSK+Q9GnQG/PfOcb/4m+SF0Bv8HnpsMMM9djCztvnFayqaKjr9GSYb7S0t5VXXP7nqk45YDFAnkr07ajY0lrq4nq9acwBsU5Ju1HaDW7BY9mMlloLDxUkbW/2SlA4svZkNuGo+QsMGhHMMRQ=
Received: from CY4PR1201MB2471.namprd12.prod.outlook.com (10.172.116.10) by
 CY4PR1201MB0214.namprd12.prod.outlook.com (10.174.54.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Fri, 12 Apr 2019 13:22:33 +0000
Received: from CY4PR1201MB2471.namprd12.prod.outlook.com
 ([fe80::1466:86ac:f4fd:6767]) by CY4PR1201MB2471.namprd12.prod.outlook.com
 ([fe80::1466:86ac:f4fd:6767%5]) with mapi id 15.20.1792.016; Fri, 12 Apr 2019
 13:22:33 +0000
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     Vitor Soares <vitor.soares@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>
CC:     Joao Pinto <joao.pinto@synopsys.com>,
        "nelson.costa@synopsys.com" <nelson.costa@synopsys.com>,
        Luis de Oliveira <luis.oliveira@synopsys.com>,
        "eugeniy.Paltsev@synopsys.com" <eugeniy.paltsev@synopsys.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "jose.abreu@synopsys.com" <jose.abreu@synopsys.com>,
        "pedrom.sousa@synopsys.com" <pedrom.sousa@synopsys.com>
Subject: Re: [PATCH] reset: axs10x: Implement assert and deassert callbacks
Thread-Topic: [PATCH] reset: axs10x: Implement assert and deassert callbacks
Thread-Index: AQHU7fZSnbQvj+gxfk+DCceWR2xQe6YyI6sAgAAdlQCABkhiAA==
Date:   Fri, 12 Apr 2019 13:22:33 +0000
Message-ID: <1555075350.2668.17.camel@synopsys.com>
References: <33ed7b90da8439aecb3544c3ff7dcfb511e03b8e.1554457026.git.vitor.soares@synopsys.com>
         <1554723600.2797.58.camel@synopsys.com>
         <13D59CF9CEBAF94592A12E8AE55501350A611EA9@DE02WEMBXB.internal.synopsys.com>
In-Reply-To: <13D59CF9CEBAF94592A12E8AE55501350A611EA9@DE02WEMBXB.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [5.18.205.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fbee9bd-dd24-4138-d32b-08d6bf49ec60
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:CY4PR1201MB0214;
x-ms-traffictypediagnostic: CY4PR1201MB0214:
x-microsoft-antispam-prvs: <CY4PR1201MB0214412FAFB10A29BEC681FCDE280@CY4PR1201MB0214.namprd12.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(136003)(396003)(376002)(366004)(199004)(189003)(81166006)(186003)(71200400001)(2501003)(66066001)(54906003)(68736007)(2201001)(110136005)(99286004)(105586002)(107886003)(486006)(6246003)(106356001)(8936002)(446003)(316002)(476003)(6436002)(6486002)(2616005)(36756003)(6636002)(11346002)(71446004)(305945005)(86362001)(229853002)(71190400001)(97736004)(102836004)(103116003)(6512007)(6116002)(6506007)(53936002)(7736002)(26005)(2906002)(81156014)(256004)(8676002)(76176011)(3846002)(4326008)(5660300002)(14454004)(25786009)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1201MB0214;H:CY4PR1201MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wIq9WaglQpIAkYRxdh3LQUSzUaii76llt6H2vCKxDngp0/57WCxA6D3JeuPCmrG7dyN0KDkw5Wg5ux44QjIYLPmKQT0zAYjGSnsQyTvBHnBHD9civjfbvKJVDp5Ulz87KmcrU3DR24YQ94RERQpbWTPT7boeAcKgSyJls2sZTcwPROesS6qkj7uwvHmB+RIjMHHRhje88z1ek1wAgyB1Ul1VUrOjOgGvQCQ5CzGOF2yIBqlgk+LX0G2X+/wQ90GuUnP/DcB3Y2MwxK/9O3UNI2CJq70HTcitFW9NLi/H2isS/O37wmtHGb3Fpc6rtLbAdZw20Z79D+Pp72X8p1kip13t6rz1LaaDdIjSVQfeIe/i1S8yz5vx6tR71C4iIkqGaxOSDZ7KXWMN1W3BZeCsDXEIXbXESzOxbKkWyHkoBcY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86FD9E46544FAF43BF490BD4ED469294@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbee9bd-dd24-4138-d32b-08d6bf49ec60
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 13:22:33.6248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0214
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVml0b3IsDQoNCk9uIE1vbiwgMjAxOS0wNC0wOCBhdCAxMzoyNSArMDAwMCwgVml0b3IgU29h
cmVzIHdyb3RlOg0KPiBIaSBFdWdlbml5LA0KPiANCj4gRnJvbTogRXVnZW5peSBQYWx0c2V2IDxw
YWx0c2V2QHN5bm9wc3lzLmNvbT4NCj4gRGF0ZTogTW9uLCBBcHIgMDgsIDIwMTkgYXQgMTI6NDA6
MDANCj4gDQo+ID4gSGkgVml0b3IsDQo+ID4gDQo+ID4gT24gTW9uLCAyMDE5LTA0LTA4IGF0IDEy
OjMxICswMjAwLCBWaXRvciBTb2FyZXMgd3JvdGU6DQo+ID4gPiBTb21lIGN1c3RvbSBJUC1ibG9j
ayBjb25uZWN0ZWQgdG8gQVJDIEFYUzEweCBib2FyZCBuZWVkIGFzc2VydCBhbmQNCj4gPiA+IGRl
YXNzZXJ0IGZ1bmN0aW9ucyB0byBjb250cm9sIHJlc2V0IHNpZ25hbCBvZiBzZWxlY3RlZCBwZXJp
cGhlcmFscy4NCj4gPiA+IA0KPiA+ID4gVGhpcyBwYXRjaCBpbXByb3ZlIEFYUzEweCByZXNldCBk
cml2ZXIgYnkgYWRkaW5nIGFzc2VydCBhbmQgZGVhc3NlcnQNCj4gPiA+IGNhbGxiYWNrcy4NCj4g
PiANCj4gPiANCj4gPiBJbiB0aGUgQVhTMTB4IHJlc2V0IGRyaXZlciBvbmx5ICdyZXNldCcgY2Fs
bGJhY2sgaXMgaW50ZW50aW9uYWxseSANCj4gPiA+IGltcGxlbWVudGVkLg0KPiA+IA0KPiA+IEFY
UzEweCBpcyBGUEdBIGJhc2VkIGJvYXJkcyBhbmQgd2l0aCBvdXIgZGVmYXVsdCBmaXJtd2FyZSBB
WFMxMHggcmVzZXQgDQo+ID4gPiByZWdpc3RlciBpcyBpbXBsZW1lbnRlZCBhcyBzZWxmLWRlYXNz
ZXJ0ZWQuDQo+IA0KPiBJIGhhdmUgYW5vdGhlciByZXNldCBibG9jayBjb25uZWN0IHRocm91Z2gg
QVhJLg0KPiANCj4gPiBEbyB5b3UgaGF2ZSBzb21laG93IG1vZGlmaWVkIEFYUzEweCBmaXJtd2Fy
ZSB3aGVyZSByZXNldCByZWdpc3RlciBpcyBub3QgDQo+ID4gPiBzZWxmLWRlYXNzZXJ0ZWQ/DQo+
ID4gDQo+ID4gSW4gdGhhdCBjYXNlICJzaW1wbGUtcmVzZXQiIGRyaXZlciB3aWxsIGJlIHN1aXRh
YmxlIGZvciB5b3UsIEkgZ3Vlc3MuDQo+IA0KPiBJIHdpbGwgdHJ5IGl0Lg0KPiANCj4gPiBPdGhl
cndpc2UgdGhpcyBpbXBsZW1lbnRhdGlvbiBpcyBpbmNvcnJlY3QgLSB0aGVyZSBzaG91bGQgYmUg
bm8gJ2Fzc2VydCcgZm9yIA0KPiA+ID4gcmVzZXQgY29udHJvbGxlciB3aXRoIHNlbGYtZGVhc3Nl
cnRlZCBsb2dpYy4NCj4gDQo+IFNvIHRoZSBhc3NlcnQgYW5kIHJlc2V0IGNhbGxiYWNrIGFyZSBt
dXR1YWxseSBleGNsdXNpdmU/DQoNCk5vdCBhY3R1YWxseS4NCg0KQWRkaW5nICdhc3NlcnQnIGNh
bGxiYWNrIGlzIGluY29ycmVjdCBmb3IgZXhjbHVzaXZlIHJlc2V0IGNvbnRyb2xzIGluDQpjYXNl
IG9mIHNlbGYtZGVhc3NlcnRlZCByZXNldCBjb250cm9sbGVyLg0KSXQgd2lsbCBjYXVzZSByZXNl
dF9jb250cm9sX2Fzc2VydCgpIHRvIHJldHVybiBzdWNjZXNzIGZvciBleGNsdXNpdmUNCnJlc2V0
IGNvbnRyb2xzLCBldmVuIHRob3VnaCB0aGUgLmFzc2VydCBvcCBmYWlsZWQgdG8gbGVhdmUgdGhl
IHJlc2V0DQpsaW5lIGFzc2VydGVkIGFmdGVyIHRoZSBmdW5jdGlvbiByZXR1cm5zLg0KDQoNCltz
bmFwXQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBWaXRvciBTb2FyZXMNCj4gDQotLSANCiBFdWdl
bml5IFBhbHRzZXY=
