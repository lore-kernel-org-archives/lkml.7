Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897F6C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481F72253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QS2II95r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfLMJ2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:28:23 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:26728 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfLMJ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:28:22 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: MbQyB8jav0meLzsQ6VkAU3yr410RWy9q0RB36G6Qx/iL6NNae+J5TAPrEkXHl7dnjvs5aSgayJ
 gllH4aqbfmhPTQ0GpxXaG4qoL7+UyZKkgniXVr55mDri6gIoVryUcdyVW08IG7X4RBQ5KXIybh
 mtumwp1C8YZeM8aNrv6RGyZzt1yxjHLcvhG2rclPRjXn716WkWG7aiBC0qLd2AjdDDXAqoSdrF
 /Qb9l+DFQ2kqofSXa+kCfmfW1gDXVClzNJXg1A7cTf5MRJJX4P/tSRP9G5vMgoE7G1Cmud3rzC
 cu4=
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="59698589"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2019 02:28:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Dec 2019 02:28:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 13 Dec 2019 02:28:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzLJcbb9g4WQ+anKlzQRjj2R8iV75iMHOKdz8X60ndY2WX4zLrCjjr4KNQxpYkCLUSJMe7Uqtm2tT6qkrTB6tYgiRbGGK7Bc78bm2WWnI4kgWbWshLWteQh4qoozb0uGnQ7ROKMAxLBkd0bJ6qjyLEk+PZRaE1XF3fvtrMFFZbzjbEqjJ8Y8DmNoaxX+HjIXaanRdyuROrrWawovBXFxppLmnByl2zP+gQtH5nMluKGUI++Ki9t7dy9zk9RdPXBpNyU134rXMVZUJ9JeGGbKPMHQQLJNwsoMUU67gH+d5SDUGTFkBXB8XtbejI3ZR/OBZx34Bg6ZFreXE1RbTYqDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u105ZdStS5kNW3FojgtQ13IYA/cM80YfeMAeth5VQwo=;
 b=ie8S2oFXj1YLQPsXtgSt82BXONjKZF5MYdvGA2OVXTqGFaLudT2iyJC6uyusqRLMSGXHDamnTPHjuTqXC04ZOX8TKpggzTv+d4r+Q7nnYFNeXMZWZ8WBqmkgkdn7LWwgSqsHRO6am0B9S5j6Me7KtTfT75KyfO45stFKTtY+iSbAV+z2SdjN4srd8Q1WIx3aF5E5vn2c6KltCigWb4VJimj6aYBDqAAifh+I6YEBEEUNfbFGWOmrNaz1A0/PR6A0DgcVhb3vvGW/YdCXzZ3Vq/HMM1RXdpnFpiurjTrFtVQ7Civ1nOVHALppfPX4mCcdrJwyGNB3pzHPnkq2bKnB2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u105ZdStS5kNW3FojgtQ13IYA/cM80YfeMAeth5VQwo=;
 b=QS2II95rN+O/MMw8I7pALHTncOL7UEBLh6WknuKj2zBe5RMoUfaFqwBWbEikeCCbLMa/+fctxH/9ISmvVAaVTQjYtAc51v7oGiQh4KTyAuzAZC5EXoLJNEIwU80g+P/Dl0q51EOl2gxbSHslAPRtrf8ZCGoBkOmRg07v2p/kdPU=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB3547.namprd11.prod.outlook.com (20.178.229.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Fri, 13 Dec 2019 09:28:17 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::ed7d:d06f:7d55:cbe2]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::ed7d:d06f:7d55:cbe2%6]) with mapi id 15.20.2538.012; Fri, 13 Dec 2019
 09:28:17 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <peda@axentia.se>, <sam@ravnborg.org>, <bbrezillon@kernel.org>,
        <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <lee.jones@linaro.org>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] Revert "drm/atmel-hlcdc: allow selecting a higher
 pixel-clock than requested"
Thread-Topic: [PATCH 4/5] Revert "drm/atmel-hlcdc: allow selecting a higher
 pixel-clock than requested"
Thread-Index: AQHVr11ICLJHO/IKjE+yoyNQ0RZUOA==
Date:   Fri, 13 Dec 2019 09:28:17 +0000
Message-ID: <be6a9bce-7d14-563b-1ee5-a968e2e3a6c8@microchip.com>
References: <1575984287-26787-1-git-send-email-claudiu.beznea@microchip.com>
 <1575984287-26787-5-git-send-email-claudiu.beznea@microchip.com>
 <4c3ffc48-7aa5-1e48-b0e9-a50c4eea7c38@axentia.se>
 <5fbad2cd-0dbe-0be5-833a-f7a612d48012@microchip.com>
 <2272669c-38ee-1928-9563-46755574897c@axentia.se>
 <167cb87e-b189-71fd-0a79-adf89336d1f3@microchip.com>
 <b5ea01da-5345-05cf-9f89-b7123dbbb893@axentia.se>
In-Reply-To: <b5ea01da-5345-05cf-9f89-b7123dbbb893@axentia.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0178.eurprd07.prod.outlook.com
 (2603:10a6:802:3e::26) To DM6PR11MB3225.namprd11.prod.outlook.com
 (2603:10b6:5:5b::32)
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191213112808831
x-originating-ip: [86.120.233.88]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6823cf79-73f4-4af2-2cd9-08d77faec901
x-ms-traffictypediagnostic: DM6PR11MB3547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB354700FC55C3D7AED14F206E87540@DM6PR11MB3547.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(478600001)(66556008)(66446008)(64756008)(186003)(5660300002)(71200400001)(66476007)(7416002)(26005)(6486002)(66946007)(316002)(6506007)(53546011)(110136005)(36756003)(54906003)(6512007)(31696002)(2616005)(86362001)(4001150100001)(52116002)(8936002)(31686004)(2906002)(4326008)(81156014)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3547;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jnf+EgXK+QXE0putF9EAqk9tztfkNXkGAXTQUa65mangGkIX4WhAVoaQ0J52855XCtANVP9Pme4f2bCwCGhliMMWzTD74UueidUwwV7fmuITugP3E/wy4RitjNRHSG2qE3HHJFlextZsDB1tbMRgOutf9k5CRmHjrnOotFAx4WukxeoVL+iUnFvQ0BOc2nUr1AIY6b8v8U7SE8ILnZBjo2sm9jRm/kDVRFMlpAeMvS/3KRw26Ohp/uPjTfNV3Cnec6+tnhKxML+ykO6kA0JFwY6NmPLbVML6yuVMjsAmnbJe0q+swKcgfyLM7aGpk8K+pShvhA+OlMKARmDuzC5c7xIhOqvV5v37jevNv7jfwL8OwlsSUwt55ZS4+nuW8Z8amyDtf24S5w7yMQ323hcC8UOaPlzES7H5gNmKcSj+SJVSg9/SMdSnKql2ubslq9gr
Content-Type: text/plain; charset="utf-8"
Content-ID: <86B38DDC3095E349B80FB36F9A3D0A26@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6823cf79-73f4-4af2-2cd9-08d77faec901
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 09:28:17.3616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0bPibBkMDEvFO2u3OhyWoMAqjJWaGjH95/P4E1I9PUw/lLqVCpoVcPhZZwjohzpqMRJpF3mWEhhwWpq8+jsSZz1UYJpkUFSrQAhuGEbpmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLjEyLjIwMTkgMTU6MjgsIFBldGVyIFJvc2luIHdyb3RlOg0KPiBFWFRFUk5BTCBF
TUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDIwMTktMTItMTEgMTI6NDUsIENsYXVk
aXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDEwLjEyLjIwMTkg
MTk6MjIsIFBldGVyIFJvc2luIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZQ0KPj4+DQo+Pj4gT24gMjAxOS0xMi0xMCAxNTo1OSwgQ2xhdWRpdS5CZXpuZWFAbWlj
cm9jaGlwLmNvbSB3cm90ZToNCj4+Pj4NCj4+Pj4NCj4+Pj4gT24gMTAuMTIuMjAxOSAxNjoxMSwg
UGV0ZXIgUm9zaW4gd3JvdGU6DQo+Pj4+PiBPbiAyMDE5LTEyLTEwIDE0OjI0LCBDbGF1ZGl1IEJl
em5lYSB3cm90ZToNCj4+Pj4+PiBUaGlzIHJldmVydHMgY29tbWl0IGY2ZjdhZDMyMzQ2MTNmNmY3
ZjI3YzI1MDM2YWFmMDc4ZGUwN2U5YjAuDQo+Pj4+Pj4gKCJkcm0vYXRtZWwtaGxjZGM6IGFsbG93
IHNlbGVjdGluZyBhIGhpZ2hlciBwaXhlbC1jbG9jayB0aGFuIHJlcXVlc3RlZCIpDQo+Pj4+Pj4g
YmVjYXVzZSBhbGxvd2luZyBzZWxlY3RpbmcgYSBoaWdoZXIgcGl4ZWwgY2xvY2sgbWF5IG92ZXJj
bG9jaw0KPj4+Pj4+IExDRCBkZXZpY2VzLCBub3QgYWxsIG9mIHRoZW0gYmVpbmcgY2FwYWJsZSBv
ZiB0aGlzLg0KPj4+Pj4NCj4+Pj4+IFdpdGhvdXQgdGhpcyBwYXRjaCwgdGhlcmUgYXJlIHBhbmVs
cyB0aGF0IGFyZSAqc2V2ZXJseSogdW5kZXJjbG9ja2VkIChvbiB0aGUNCj4+Pj4+IG1hZ25pdHVk
ZSBvZiA0ME1IeiBpbnN0ZWFkIG9mIDY1TUh6IG9yIHNvbWV0aGluZyBsaWtlIHRoYXQsIEkgZG9u
J3QgcmVtZW1iZXINCj4+Pj4+IHRoZSBleGFjdCBmaWd1cmVzKS4NCj4+Pj4NCj4+Pj4gV2l0aCBw
YXRjaCB0aGF0IHN3aXRjaGVzIGJ5IGRlZmF1bHQgdG8gMnhzeXN0ZW0gY2xvY2sgZm9yIHBpeGVs
IGNsb2NrLCBpZg0KPj4+PiB1c2luZyAxMzNNSHogc3lzdGVtIGNsb2NrIChhcyB5b3Ugc3BlY2lm
aWVkIGluIHRoZSBwYXRjaCBJIHByb3Bvc2VkIGZvcg0KPj4+PiByZXZlcnQgaGVyZSkgdGhhdCB3
b3VsZCBnbywgd2l0aG91dCB0aGlzIHBhdGNoIGF0IDUzTUh6IGlmIDY1TUh6IGlzDQo+Pj4+IHJl
cXVlc3RlZC4gQ29ycmVjdCBtZSBpZiBJJ20gd3JvbmcuDQo+Pj4NCj4+PiBJdCBtaWdodCBoYXZl
IGJlZW4gNTNNSHosIHdoYXRldmVyIGl0IHdhcyBpdCB3YXMgdG9vIGxvdyBmb3IgdGhpbmdzIHRv
IHdvcmsuDQo+Pj4NCj4+Pj4+IEFuZCB0aGV5IGFyZSBvZiBjb3Vyc2Ugbm90IGNhcGFibGUgb2Yg
dGhhdC4gQWxsIHBhbmVscw0KPj4+Pj4gaGF2ZSAqc29tZSogc2xhY2sgYXMgdG8gd2hhdCBmcmVx
dWVuY2llcyBhcmUgc3VwcG9ydGVkLCBhbmQgdGhlIHBhdGNoIHdhcw0KPj4+Pj4gd3JpdHRlbiB1
bmRlciB0aGUgYXNzdW1wdGlvbiB0aGF0IHRoZSBwcmVmZXJyZWQgZnJlcXVlbmN5IG9mIHRoZSBw
YW5lbCB3YXMNCj4+Pj4+IHJlcXVlc3RlZCwgd2hpY2ggc2hvdWxkIGxlYXZlIGF0IGxlYXN0IGEg
KmxpdHRsZSogaGVhZHJvb20uDQo+Pj4+DQo+Pj4+IEkgc2VlLCBidXQgZnJvbSBteSBwb2ludCBv
ZiB2aWV3LCB0aGUgdXBwZXIgbGF5ZXJzIHNob3VsZCBkZWNpZGUgd2hhdA0KPj4+PiBmcmVxdWVu
Y3kgc2V0dGluZ3Mgc2hvdWxkIGJlIGRvbmUgb24gdGhlIExDRCBjb250cm9sbGVyIGFuZCBub3Qg
bGV0IHRoaXMgYXQNCj4+Pj4gIHRoZSBkcml2ZXIncyBsYXRpdHVkZS4NCj4+Pg0KPj4+IFJpZ2h0
LCBidXQgdGhlIHVwcGVyIGxheWVycyBkbyBub3Qgc3VwcG9ydCBuZWdvdGlhdGluZyBhIGZyZXF1
ZW5jeSBmcm9tDQo+Pj4gcmFuZ2VzLiBBdCBsZWFzdCB0aGUgZGlkbid0IHdoZW4gdGhlIHBhdGNo
IHdhcyB3cml0dGVuLCBhbmQgaW1wbGVtZW50aW5nDQo+Pj4gKnRoYXQqIHNlZW1lZCBsaWtlIGEg
aHVnZSB1bmRlcnRha2luZy4NCj4+Pg0KPj4+Pj4NCj4+Pj4+IFNvLCBJJ20gY3VyaW91cyBhcyB0
byB3aGF0IHBhbmVsIHJlZ3Jlc3NlZC4gT3IgcmF0aGVyLCB3aGF0IHBpeGVsLWNsb2NrIGl0IG5l
ZWRzDQo+Pj4+PiBhbmQgd2hhdCBpdCBnZXRzIHdpdGgvd2l0aG91dCB0aGUgcGF0Y2g/DQo+Pj4+
DQo+Pj4+IEkgaGF2ZSAyIHVzZSBjYXNlczoNCj4+Pj4gMS8gc3lzdGVtIGNsb2NrID0gMjAwTUh6
IGFuZCByZXF1ZXN0ZWQgcGl4ZWwgY2xvY2sgKG1vZGVfcmF0ZSkgfjcxTUh6LiBXaXRoDQo+Pj4+
IHRoZSByZXZlcnRlZCBwYXRjaCB0aGUgcmVzdWx0ZWQgY29tcHV0ZWQgcGl4ZWwgY2xvY2sgd291
bGQgYmUgODBNSHouDQo+Pj4+IFByZXZpb3VzbHkgaXQgd2FzIGF0IDY2TUh6DQo+Pj4NCj4+PiBJ
IGRvbid0IHNlZSBob3cgdGhhdCdzIHBvc3NpYmxlLg0KPj4+DQo+Pj4gW2RvaW5nIHNvbWUgY2Fs
Y3VsYXRpb24gYnkgaGFuZF0NCj4+Pg0KPj4+IEFycmdoLiAqYmx1c2gqDQo+Pj4NCj4+PiBUaGUg
Y29kZSBkb2VzIG5vdCBkbyB3aGF0IEkgaW50ZW5kZWQgZm9yIGl0IHRvIGRvLg0KPj4+IENhbiB5
b3UgcGxlYXNlIHRyeSB0aGlzIGluc3RlYWQgb2YgcmV2ZXJ0aW5nPw0KPj4+DQo+Pj4gQ2hlZXJz
LA0KPj4+IFBldGVyDQo+Pj4NCj4+PiBGcm9tIGIzZTg2ZDU1YjhkMTA3YTVjMDdlOThmODc5YzY3
ZjY3MTIwYzg3YTYgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQo+Pj4gRnJvbTogUGV0ZXIgUm9z
aW4gPHBlZGFAYXhlbnRpYS5zZT4NCj4+PiBEYXRlOiBUdWUsIDEwIERlYyAyMDE5IDE4OjExOjI4
ICswMTAwDQo+Pj4gU3ViamVjdDogW1BBVENIXSBkcm0vYXRtZWwtaGxjZGM6IHByZWZlciBhIGxv
d2VyIHBpeGVsLWNsb2NrIHRoYW4gcmVxdWVzdGVkDQo+Pj4NCj4+PiBUaGUgaW50ZW50aW9uIHdh
cyB0byBvbmx5IHNlbGVjdCBhIGhpZ2hlciBwaXhlbC1jbG9jayByYXRlIHRoYW4gdGhlDQo+Pj4g
cmVxdWVzdGVkLCBpZiBhIHNsaWdodCBvdmVyY2xvY2tpbmcgd291bGQgcmVzdWx0IGluIGEgcmF0
ZSBzaWduaWZpY2FudGx5DQo+Pj4gY2xvc2VyIHRvIHRoZSByZXF1ZXN0ZWQgcmF0ZSB0aGFuIGlm
IHRoZSBjb25zZXJ2YXRpdmUgbG93ZXIgcGl4ZWwtY2xvY2sNCj4+PiByYXRlIGlzIHNlbGVjdGVk
LiBUaGUgZml4ZWQgcGF0Y2ggaGFzIHRoZSBsb2dpYyB0aGUgb3RoZXIgd2F5IGFyb3VuZCBhbmQN
Cj4+PiBhY3R1YWxseSBwcmVmZXJzIHRoZSBoaWdoZXIgZnJlcXVlbmN5LiBGaXggdGhhdC4NCj4+
Pg0KPj4+IEZpeGVzOiBmNmY3YWQzMjM0NjEgKCJkcm0vYXRtZWwtaGxjZGM6IGFsbG93IHNlbGVj
dGluZyBhIGhpZ2hlciBwaXhlbC1jbG9jayB0aGFuIHJlcXVlc3RlZCIpDQo+Pj4gUmVwb3J0ZWQt
Ynk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4+IFNp
Z25lZC1vZmYtYnk6IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+DQo+Pj4gLS0tDQo+Pj4g
IGRyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19jcnRjLmMgfCA0ICsrLS0N
Cj4+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+
Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxj
ZGNfY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL2F0bWVsLWhsY2RjL2F0bWVsX2hsY2RjX2NydGMu
Yw0KPj4+IGluZGV4IDllMzRiY2UwODlkMC4uMDM2OTE4NDVkMzdhIDEwMDY0NA0KPj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hdG1lbC1obGNkYy9hdG1lbF9obGNkY19jcnRjLmMNCj4+PiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxjZGMvYXRtZWxfaGxjZGNfY3J0Yy5jDQo+Pj4gQEAg
LTEyMCw4ICsxMjAsOCBAQCBzdGF0aWMgdm9pZCBhdG1lbF9obGNkY19jcnRjX21vZGVfc2V0X25v
ZmIoc3RydWN0IGRybV9jcnRjICpjKQ0KPj4+ICAgICAgICAgICAgICAgICBpbnQgZGl2X2xvdyA9
IHByYXRlIC8gbW9kZV9yYXRlOw0KPj4+DQo+Pj4gICAgICAgICAgICAgICAgIGlmIChkaXZfbG93
ID49IDIgJiYNCj4+PiAtICAgICAgICAgICAgICAgICAgICgocHJhdGUgLyBkaXZfbG93IC0gbW9k
ZV9yYXRlKSA8DQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgMTAgKiAobW9kZV9yYXRlIC0gcHJh
dGUgLyBkaXYpKSkNCj4+PiArICAgICAgICAgICAgICAgICAgICgxMCAqIChwcmF0ZSAvIGRpdl9s
b3cgLSBtb2RlX3JhdGUpIDwNCj4+PiArICAgICAgICAgICAgICAgICAgICAobW9kZV9yYXRlIC0g
cHJhdGUgLyBkaXYpKSkNCj4+DQo+PiBJIHRlc3RlZCBpdCBvbiBteSBzZXR1cCAoSSBoYXZlIG9u
bHkgb25lIG9mIHRob3NlIHNwZWNpZmllZCBhYm92ZSkgYW5kIGl0DQo+PiBpcyBPSy4gRG9pbmcg
c29tZSBtYXRoIGZvciB0aGUgb3RoZXIgc2V0dXAgaXQgc2hvdWxkIGFsc28gYmUgT0suDQo+IA0K
PiBHbGFkIHRvIGhlYXIgaXQsIGFuZCB0aGFua3MgZm9yIHRlc3RpbmcvdmVyaWZ5aW5nIQ0KPiAN
Cj4+IEFzIGEgd2hvbGUsIEknbSBPSyB3aXRoIHRoaXMgYXQgdGhlIG1vbWVudCAobGV0J3MgaG9w
ZSBpdCB3aWxsIHdvcmsgZm9yIGFsbA0KPj4gdXNlLWNhc2VzKSBidXQgc3RpbGwgSSBhbSBub3Qg
T0sgd2l0aCBzZWxlY3RpbmcgaGVyZSwgaW4gdGhlIGRyaXZlciwNCj4+IHNvbWV0aGluZyB0aGF0
IG1pZ2h0IHdvcmsuDQo+IA0KPiBUaGUgZHJpdmVyIGhhcyB0byBzZWxlY3QgKnNvbWV0aGluZyou
IElmIGl0IGNhbiBkZWxpdmVyIHRoZSBleGFjdCByZXF1ZXN0ZWQNCj4gZnJlcXVlbmN5LCBmaW5l
LiBPdGhlcndpc2U/IFdoYXQgc2hvdWxkIGl0IGRvPyBCYWlsIG91dD8gV2h5IGlzIDUzTUh6IGJl
dHRlcg0KPiBhbmQgbW9yZSBsaWtlbHkgdG8gcHJvZHVjZSBhIHBpY3R1cmUgdGhhbiA2Nk1Ieiwg
d2hlbiA2NU1IeiBpcyByZXF1ZXN0ZWQ/DQo+IFRoYXQncyBvZiBjb3Vyc2UgYW4gaW1wb3NzaWJs
ZSBxdWVzdGlvbiBmb3IgdGhlIGRyaXZlciB0byBhbnN3ZXIuDQo+IA0KPiBTbywgaWYgeW91IGFy
ZSBub3Qgb2sgd2l0aCB0aGF0LCB5b3UgbmVlZCB0byBpbXBsZW1lbnQgc29tZXRoaW5nIHRoYXQg
dXNlcw0KPiB0aGUgbWluL21heCBmaWVsZHMgZnJvbSB0aGUgdmFyaW91cyBmaWVsZHMgaW5zaWRl
IHN0cnVjdCBkaXNwbGF5X3RpbWluZw0KPiBpbnN0ZWFkIG9mIG9ubHkgbG9va2luZyBhdCB0aGUg
dHlwIGZpZWxkLiBFLmcuIHRoZSBwYW5lbF9sdmRzIGRyaXZlciBjYWxscw0KPiB2aWRlb21vZGVf
ZnJvbV90aW1pbmdzKCkgYW5kIHRoZSByZXN1bHQgaXMgYSBzaW5nbGUgcG9zc2libGUgbW9kZSB3
aXRoIG9ubHkNCj4gdGhlIHR5cGljYWwgdGltaW5ncywgd2l0aCBubyBuZWdvdGlhdGlvbiBvZiB0
aGUgYmVzdCBvcHRpb24gd2l0aGluIHRoZQ0KPiBnaXZlbiByYW5nZXMgd2l0aCB0aGUgb3RoZXIg
ZHJpdmVycyBpbnZvbHZlZCB3aXRoIHRoZSBwaXBlLiBJIHRoaW5rIHRoZQ0KPiBwYW5lbC1zaW1w
bGUgZHJpdmVyIGFsc28gbWFrZXMgdGhpcyBvbmUtc2lkZWQgZGVjaXNpb24gb2Ygb25seSBtYWtp
bmcgdXNlDQo+IG9mIHRoZSB0eXAgZmllbGQgZm9yIGVhY2ggZ2l2ZW4gdGltaW5nIHJhbmdlLiBI
YXZpbmcgZGFiYmxlZCBhIGJpdCBpbiB3aGF0DQo+IHRoZSBzb3VuZCBzdGFjayBkb2VzIHRvIG5l
Z290aWF0ZSB0aGUgc2FtcGxlIHJhdGUsIHNhbXBsZSBmb3JtYXQgYW5kDQo+IGNoYW5uZWwgY291
bnQgZXRjLCBJIGNhbiBvbmx5IHByZWRpY3QgdGhhdCByZXRyb2ZpdHRpbmcgc29tZXRoaW5nIGxp
a2UgdGhhdA0KPiBmb3IgdmlkZW8gbW9kZXMgd2lsbCBiZSAuLi4gaW50ZXJlc3RpbmcuIFdoaWNo
IGlzIHByb2JhYmx5IHdoeSBpdCdzIG5vdA0KPiBkb25lIGF0IGFsbCwgYXQgbGVhc3Qgbm90IGlu
IHRoZSBnZW5lcmFsIGNhc2UuDQo+IA0KPiBBbmQgeWVzLCBJIGFncmVlLCB0aGUgY3VycmVudCBt
ZWNoYW5pY3MgYXJlIGxlc3MgdGhhbiBpZGVhbC4gQnV0IEkgaGF2ZSBubw0KPiB0aW1lIHRvIGRv
IGFueXRoaW5nIGFib3V0IGl0Lg0KPiANCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFs
dGhvdWdoIEkgYW0gbm90IGZhbWlsaWFyIHdpdGggaG93IG90aGVyIERSTQ0KPj4gZHJpdmVycyBh
cmUgaGFuZGxpbmcgdGhpcyBraW5kIG9mIHNjZW5hcmlvcy4gTWF5YmUgeW91IGFuZC9vciBvdGhl
ciBEUk0NCj4+IGd1eXMga25vd3MgbW9yZSBhYm91dCBpdC4NCj4gDQo+IEkgZG9uJ3Qga25vdyAo
YW5kIEkgbWVhbiBpdCBsaXRlcmFsbHkpLCBidXQgbWF5YmUgdGhlc2UgY2hpcHMgYXJlIHNwZWNp
YWwNCj4gYXMgdGhleSB0eXBpY2FsbHkgZW5kIHVwIHdpdGggdmVyeSBzbWFsbCBkaXZpZGVycyBh
bmQgdGh1cyBsYXJnZSBmcmVxdWVuY3kNCj4gc3RlcHM/IEJUVywgSSBkbyBub3QgY29uc2lkZXIg
bXlzZWxmIGEgRFJNIGd1eSwgSSBoYXZlIG9ubHkgdHJpZWQgdG8NCj4gZml4IHRoYXQgd2hpY2gg
ZGlkIG5vdCB3b3JrIG91dCBmb3Igb3VyIG5lZWRzLi4uDQo+IA0KPj4gSnVzdCBhcyBhIG5vdGlj
ZSwgaXQgbWF5IHdvcnRoIGFkZGluZyBhIHByaW50IG1lc3NhZ2Ugc2F5aW5nIHdoYXQgd2FzDQo+
PiBmcmVxdWVuY3kgd2FzIHJlcXVlc3RlZCBhbmQgd2hhdCBmcmVxdWVuY3kgaGFzIGJlZW4gc2V0
dXAgYnkgZHJpdmVyLg0KPiANCj4gSSBoYXZlIG5vIHByb2JsZW0gd2l0aCB0aGF0Lg0KDQpIaSBQ
ZXRlciwNCg0KSSBpbnRlbmQgdG8gcHJlcGFyZSBteSB2MiBvZiB0aGlzIHNlcmllcy4gSG93IHdv
dWxkIHlvdSBsaWtlIHRvIHByb2NlZWQNCndpdGggdGhlIHBhdGNoIHlvdSBwcm92aWRlZD8gQXJl
IHlvdSBPSyBpZiBJIGFkZCBpdCB0byBteSB2MiBvZiB0aGlzIHNlcmllcw0Kb3Igd291bGQgeW91
IHByZWZlciB0byBzZW5kIGl0IG9uIHlvdXIgb3duPw0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJl
em5lYQ0KDQo+IA0KPiBDaGVlcnMsDQo+IFBldGVyDQo+IA0KPj4NCj4+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAvKg0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAqIEF0IGxlYXN0IDEw
IHRpbWVzIGJldHRlciB3aGVuIHVzaW5nIGEgaGlnaGVyDQo+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICogZnJlcXVlbmN5IHRoYW4gcmVxdWVzdGVkLCBpbnN0ZWFkIG9mIGEgbG93ZXIuDQo+
Pj4gLS0NCj4+PiAyLjIwLjENCj4+Pg0KPiANCg==
