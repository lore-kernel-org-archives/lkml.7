Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13BCC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B180521835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mfWWrmgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfJIJgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:36:47 -0400
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:53760
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfJIJgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:36:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA4xlQP0xTGQ6PCoi4r1X58yQCPAWE7FGZi1riDuPAI6F+SsRhk0av3Xuv7aaEbKBGCs3AJlRstX4PKV5aqLX6r/DTt/XQVf8FHvjz/frwdAVEOrpJPNb0IjSRYfQphp6PzZA0qimzszk4+6LHoMctld0z9g5Aj4qfeeZ8s4qEfZCM43/UZqCcMPIVEeqOgze1OQtPAAwLT4GpZo64yZjALJ9iwWdAhxzdcKkJ/GTAciTR9RjXK5csXw6cjVDTzT2CqgXsclPbE9zLZb+w89ic7Ts5dt70VlmEEmox96CaEpmY4S5MbOtkiHAVUTSXUSlBTghceIXGGJ+eFC4ZrAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCW4u4cTVQufD2z2wU75Ak0Niq8DgcQPprcAbmmCVTk=;
 b=mo8vIld0ZvgaTeOKeK6MUzsJ++LZkULi6dh1HZlImiim7/OoxUG4jIVa29Nbo6QLMfrIBZhE/wBlkg1s0awJXJrCcLs4Em33Z6djHYuOjgfED5QquChlgR35BqtgJaQoiflENh1xpUvGT9IYsH/U9RSUTCodr/wkvqVs4wpnwZI7FGTISsNHkGdkpv/zZ7ERFHpKSw+lylUAPdozpVxkZWW+fJITsEFDXp2ihTOFFTUqB0jYXmn+7YcoEo4douLzX+5QQbYQeEgeNvQW27SLXwfs5XOQblB1v2Un1bGsM7aKJFo6mqqAmEvYo2cGmr91czYo1o2Y5g1hit7CVDTVgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCW4u4cTVQufD2z2wU75Ak0Niq8DgcQPprcAbmmCVTk=;
 b=mfWWrmgqfQMA87UWm1U/M+/y4CKFtpVM46BooQc5kifMDNvG+Zi/MP62LNTvTVxBK24xE3z+hf+/kqUxQEkJYOdAJnyPwwY6L3mHIrEG18t5BmpehIlsDLnjt4RUciAZDfeO2s2ppFx9ZSRs3x8z+Nrv5GYBgTvL3F5Yx8gG3WU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3819.eurprd04.prod.outlook.com (52.134.71.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 9 Oct 2019 09:36:37 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d469:ad51:2bec:19f0%6]) with mapi id 15.20.2347.016; Wed, 9 Oct 2019
 09:36:36 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH] tty: serial: imx: Only get second/third IRQ when there is
 more than one IRQ
Thread-Topic: [PATCH] tty: serial: imx: Only get second/third IRQ when there
 is more than one IRQ
Thread-Index: AQHVfmm1cibywjMA5UifVvn4HL9DWadR35+AgAAWGACAABWsAIAAAYTg
Date:   Wed, 9 Oct 2019 09:36:36 +0000
Message-ID: <DB3PR0402MB3916361F60FA8ACBB434E7ADF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1570601911-9162-1-git-send-email-Anson.Huang@nxp.com>
 <20191009065315.wgdvmkv6skteyul4@pengutronix.de>
 <CAHp75VcWXT+j5cfVzxPL+3YdgR+3uhFSb0qEDRr4YL+WenVKUQ@mail.gmail.com>
 <20191009092954.srlx5wjaqueps7nz@pengutronix.de>
In-Reply-To: <20191009092954.srlx5wjaqueps7nz@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53d2e6b9-8a1f-4a32-7715-08d74c9c2e33
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DB3PR0402MB3819:|DB3PR0402MB3819:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38196D4B4619CEC2F89CBD45F5950@DB3PR0402MB3819.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(199004)(189003)(76176011)(6506007)(186003)(316002)(102836004)(66574012)(9686003)(55016002)(5660300002)(86362001)(71200400001)(110136005)(7416002)(6436002)(7736002)(14454004)(256004)(53546011)(54906003)(8936002)(14444005)(305945005)(26005)(71190400001)(44832011)(81166006)(478600001)(81156014)(74316002)(486006)(33656002)(4744005)(7696005)(8676002)(66946007)(25786009)(99286004)(476003)(64756008)(2906002)(52536014)(4326008)(66446008)(76116006)(229853002)(6246003)(66066001)(66476007)(11346002)(446003)(3846002)(6116002)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3819;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6a2rFiUszuw8ynZa+e4o8ia2IwLUFW7AOdspivEjB06hMaV/rjZZhSYp2kdNx6gdvDm59cWmyvO87cOp4ZuFWQbu0fWTwk6IQqYTjzMk36FH1DYXWr1G944oG/HEKUiaVkOR/761IXU8To3oiHtFDmGjdt+sGDlQiG6s2QEDG2La7p/gP0FNcdjvdr/fH62D+BPQY2R8NfhSWkZr5ehpF8SrtPF10NQZMRMtc9NomhIVD6AGiS86EYXv6DQsxVYeXTf21ChbzkIvuifcgXGWnouxLkZ+5XIEQD1ymLhmqapMTECSbwn3UrtLK/q3DHbXUGfPSK1BlAe2py7YYvThKJ/ToMe8qQqA3SGu4G57Ar0Fj6sEbq1vwZ70EMmoNLjSFXLr9xSTcYJXa4E5HCiZovxU83PXa+BLEWrtqaw6r/s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d2e6b9-8a1f-4a32-7715-08d74c9c2e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 09:36:36.9458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rnmy4NrVGDGpidqGaueJ/izqGoOppwQoxJSJA5zuhavb19CTFljIEZNCmL4W7ogxftzZ7Etqb9fiVTYJlYF0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3819
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gV2VkLCBPY3QgMDksIDIwMTkgYXQgMTE6MTI6MjBBTSArMDMwMCwgQW5keSBTaGV2
Y2hlbmtvIHdyb3RlOg0KPiA+IE9uIFdlZCwgT2N0IDksIDIwMTkgYXQgOTo1MyBBTSBVd2UgS2xl
aW5lLUvDtm5pZw0KPiA+IDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOg0K
PiA+DQo+ID4gPiBUaGUgcGF0Y2ggaXMgZmluZSBnaXZlbiB0aGUgY2hhbmdlZCBiZWhhdmlvdXIg
b2YgcGxhdGZvcm1fZ2V0X2lycS4gSQ0KPiA+ID4gd29uZGVyIGlmIGl0IGlzIHNlbnNpYmxlIHRv
IGludHJvZHVjZSBhIHZhcmlhbnQgb2YgcGxhdGZvcm1fZ2V0X2lycQ0KPiA+ID4gKHNheQ0KPiA+
ID4gcGxhdGZvcm1fZ2V0X2lycV9ub3dhcm4pIHRoYXQgYmVoYXZlcyBsaWtlIF9fcGxhdGZvcm1f
Z2V0X2lycSBkb2VzDQo+ID4gPiB0b2RheS4gVGhlbiB0aGUgaW14IGRyaXZlciB3b3VsZCBqdXN0
IGNhbGwgcGxhdGZvcm1fZ2V0X2lycV9ub3dhcm4NCj4gPiA+IHdpdGhvdXQgaGF2aW5nIHRvIGNo
ZWNrIHRoZSBudW1iZXIgb2YgYXZhaWxhYmxlIGlycXMgZmlyc3QuDQo+ID4NCj4gPiBJdCdzIGJl
aW5nIGRpc2N1c3NlZCBpbiBwYXJhbGxlbCB0aHJlYWQgYWJvdXQNCj4gPiBwbGF0Zm9ybV9nZXRf
aXJxX29wdGlvbmFsKCkgd2hpY2ggd29uJ3QgaXNzdWUgYSB3YXJuaW5nLg0KPiANCj4gVGhpcyBp
cyBldmVuIGFscmVhZHkgaW4gNS40LXJjMSBhcw0KPiA4OTczZWE0NzkwMWM4MWExOTEyYmQwNWYx
NTc3YmVkOWI1YjUyNTA2Lg0KDQpHcmVhdCwgSSB3aWxsIHNlbmQgb3V0IGEgVjIgdXNpbmcgcGxh
dGZvcm1fZ2V0X2lycV9vcHRpb25hbCgpIGZvciBzZWNvbmQvdGhpcmQgSVJRLg0KDQpUaGFua3Ms
DQpBbnNvbg0K
