Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5EFC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC04E21882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bAACg1Rs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfGCQwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:52:43 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:6925 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCQwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:52:43 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Codrin.Ciubotariu@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="Codrin.Ciubotariu@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Codrin.Ciubotariu@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: k8uY/EBvQ8z1vx5Z6gXqTlpbmIe1V0qcWs26i8cA1ZxDpLfV7NvzJf/n6/OeV3ID4aj5pbQsEo
 tCGlehiV9yWv0sxARyDUHTd0tGdBynbssEGIGhnzxmvnXRNAbw9SdaV9CW1VPwOIQbjWqewKht
 QEXQyMtbTZ1bn0ymYw0yu1qkA4tvsKbeSaVstRljtNcPoyaU8h7h91F+p7zRHBoDi1vK8ZWVmr
 pYeXNGvVIeOwL35HeT3C9pEDCWd7w88ghGyBLD3Gb8IRfvswbijCVnX9ZMvuDtMHEJCtjx68TW
 1gE=
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="39922410"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2019 09:52:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 3 Jul 2019 09:52:37 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 3 Jul 2019 09:52:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thCssWWz2Xp4kyD0XDsMGnPUcTjwjL9mYhBxR7akPEQ=;
 b=bAACg1RsD4FNDOUeRwQtVE/WR8aP5BA1z1DPIBAnhYj3ID/SasnJROI0ya07f30oH4IlOE97av5DMnMhpMY+MZU2rHMjPgO6qWmdTOEL79IeCumIeo4FaoXqZvrmMo/W943/EL6WhA+Wc0onTnsLX7eEtKgKoXGjgmg/hDjdEdo=
Received: from BN6PR11MB0051.namprd11.prod.outlook.com (10.161.153.153) by
 BN6PR11MB0019.namprd11.prod.outlook.com (10.161.155.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 16:52:35 +0000
Received: from BN6PR11MB0051.namprd11.prod.outlook.com
 ([fe80::7972:d14b:4c60:adb2]) by BN6PR11MB0051.namprd11.prod.outlook.com
 ([fe80::7972:d14b:4c60:adb2%3]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 16:52:35 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <tzungbi@google.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <tiwai@suse.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: codecs: ad193x: Group register
 initialization at probe
Thread-Topic: [alsa-devel] [PATCH 1/2] ASoC: codecs: ad193x: Group register
 initialization at probe
Thread-Index: AQHVLOBuNYbcxW+S6E2Xr3qUkzcNHqa4ixeAgACah4A=
Date:   Wed, 3 Jul 2019 16:52:35 +0000
Message-ID: <e9e653d1-6360-ffaf-6b47-eb33c0d867df@microchip.com>
References: <20190627120208.4661-1-codrin.ciubotariu@microchip.com>
 <CA+Px+wXBBgeWbjZ5uQmwJgn+d=ZE-N0aehitog7==ak3GDxMsQ@mail.gmail.com>
In-Reply-To: <CA+Px+wXBBgeWbjZ5uQmwJgn+d=ZE-N0aehitog7==ak3GDxMsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0207.eurprd08.prod.outlook.com
 (2603:10a6:802:15::16) To BN6PR11MB0051.namprd11.prod.outlook.com
 (2603:10b6:405:65::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24dff10b-620f-4c6c-406d-08d6ffd6d8d0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB0019;
x-ms-traffictypediagnostic: BN6PR11MB0019:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR11MB001987718B73258F179F1055E7FB0@BN6PR11MB0019.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(366004)(199004)(189003)(6116002)(6486002)(3846002)(14454004)(8676002)(66066001)(99286004)(966005)(81156014)(81166006)(52116002)(5660300002)(31686004)(54906003)(316002)(25786009)(229853002)(36756003)(68736007)(256004)(6916009)(6306002)(64756008)(66446008)(8936002)(86362001)(6246003)(71190400001)(71200400001)(31696002)(72206003)(305945005)(446003)(26005)(4326008)(66556008)(2616005)(11346002)(66476007)(2906002)(53936002)(7736002)(186003)(476003)(73956011)(486006)(66946007)(6506007)(76176011)(102836004)(6512007)(478600001)(6436002)(53546011)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB0019;H:BN6PR11MB0051.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: te0oQsh9Nupa+8SUs2DphLkyh24M2cAwIRDTkdQE7m5ixW6GuoLK2HGR4pFr2vXNpOnY+gEW2stxDy2wc3oUd2t7JhsdxlKdpAWM7cSUt62kISFHe/Mz2iBxaxB9zk6XnafqfgTcOgN4DY0ZK5N1T6TELJva3Gj6nlP3C5CagJCn7utVUUtH2KoGE6kvLdnMdv7Er5m7ZbgOJ4wNaCy+ZG8TEBz/IRe92ZudFP/unC/pmG4DplXuOu2AEr4yuq60qSiuymX2YrRy2tQ+j06ITu7c4lmCfM/y5HV9yl9Cu2/fIAW+hnB+rm8cwVRMrt6/wpsJ98ocWBirKNyBY5yk0FG46Khp0SjyDDsx20CcyeAcH9yZOZWA4q5nhqtSBeaiLK8Vy62Dk7WH/itIV3QWb9MFb65P0hvMAGZNgDCJsCM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <106EAF0CF0E83B4CACE6BBC13ECDE279@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 24dff10b-620f-4c6c-406d-08d6ffd6d8d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 16:52:35.1690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Codrin.Ciubotariu@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDcuMjAxOSAxMDozOSwgVHp1bmctQmkgU2hpaCB3cm90ZToNCj4gT24gVGh1LCBKdW4g
MjcsIDIwMTkgYXQgODowNSBQTSBDb2RyaW4gQ2l1Ym90YXJpdQ0KPiA8Y29kcmluLmNpdWJvdGFy
aXVAbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+PiArc3RydWN0IGFkMTkzeF9yZWdfZGVmYXVsdCB7
DQo+PiArICAgICAgIHVuc2lnbmVkIGludCByZWc7DQo+PiArICAgICAgIHVuc2lnbmVkIGludCB2
YWw7DQo+PiArfTsNCj4gWW91IHByb2JhYmx5IGRvbid0IG5lZWQgdG8gZGVmaW5lIHRoaXMuICBU
aGVyZSBpcyBhIHN0cnVjdA0KPiByZWdfc2VxdWVuY2UgaW4gcmVnbWFwLmguDQo+IA0KPj4gKw0K
Pj4gKy8qIGNvZGVjIHJlZ2lzdGVyIHZhbHVlcyB0byBzZXQgYWZ0ZXIgcmVzZXQgKi8NCj4+ICtz
dGF0aWMgdm9pZCBhZDE5M3hfcmVnX2RlZmF1bHRfaW5pdChzdHJ1Y3QgYWQxOTN4X3ByaXYgKmFk
MTkzeCkNCj4+ICt7DQo+PiArICAgICAgIGNvbnN0IHN0cnVjdCBhZDE5M3hfcmVnX2RlZmF1bHQg
cmVnX2luaXRbXSA9IHsNCj4+ICsgICAgICAgICAgICAgICB7ICAwLCAweDk5IH0sICAgLyogUExM
X0NMS19DVFJMMDogcGxsIGlucHV0OiBtY2xraS94aSAxMi4yODhNaHogKi8NCj4+ICsgICAgICAg
ICAgICAgICB7ICAxLCAweDA0IH0sICAgLyogUExMX0NMS19DVFJMMTogbm8gb24tY2hpcCBWcmVm
ICovDQo+PiArICAgICAgICAgICAgICAgeyAgMiwgMHg0MCB9LCAgIC8qIERBQ19DVFJMMDogVERN
IG1vZGUgKi8NCj4+ICsgICAgICAgICAgICAgICB7ICA0LCAweDFBIH0sICAgLyogREFDX0NUUkwy
OiA0OGtIeiBkZS1lbXBoYXNpcywgdW5tdXRlIGRhYyAqLw0KPj4gKyAgICAgICAgICAgICAgIHsg
IDUsIDB4MDAgfSwgICAvKiBEQUNfQ0hOTF9NVVRFOiB1bm11dGUgREFDIGNoYW5uZWxzICovDQo+
PiArICAgICAgIH07DQo+PiArICAgICAgIGNvbnN0IHN0cnVjdCBhZDE5M3hfcmVnX2RlZmF1bHQg
cmVnX2FkY19pbml0W10gPSB7DQo+PiArICAgICAgICAgICAgICAgeyAxNCwgMHgwMyB9LCAgIC8q
IEFEQ19DVFJMMDogaGlnaC1wYXNzIGZpbHRlciBlbmFibGUgKi8NCj4+ICsgICAgICAgICAgICAg
ICB7IDE1LCAweDQzIH0sICAgLyogQURDX0NUUkwxOiBzYXRhIGRlbGF5PTEsIGFkYyBhdXggbW9k
ZSAqLw0KPj4gKyAgICAgICB9Ow0KPj4gKyAgICAgICBpbnQgaTsNCj4+ICsNCj4+ICsgICAgICAg
Zm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUocmVnX2luaXQpOyBpKyspDQo+PiArICAgICAgICAg
ICAgICAgcmVnbWFwX3dyaXRlKGFkMTkzeC0+cmVnbWFwLCByZWdfaW5pdFtpXS5yZWcsIHJlZ19p
bml0W2ldLnZhbCk7DQo+PiArDQo+PiArICAgICAgIGlmIChhZDE5M3hfaGFzX2FkYyhhZDE5M3gp
KSB7DQo+PiArICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUocmVnX2Fk
Y19pbml0KTsgaSsrKSB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICByZWdtYXBfd3JpdGUo
YWQxOTN4LT5yZWdtYXAsIHJlZ19hZGNfaW5pdFtpXS5yZWcsDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmVnX2FkY19pbml0W2ldLnZhbCk7DQo+PiArICAgICAgICAg
ICAgICAgfQ0KPj4gKyAgICAgICB9DQo+IEFuZCB5b3UgY291bGQgdXNlIHJlZ21hcF9tdWx0aV9y
ZWdfd3JpdGUoICkgdG8gc3Vic3RpdHV0ZSB0aGUgdHdvIGZvci1sb29wcy4NCj4gDQo+IFNlZSBo
dHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9waXBlcm1haWwvYWxzYS1kZXZlbC8yMDE5
LUp1bmUvMTUxMDkwLmh0bWwNCj4gYXMgYW4gZXhhbXBsZS4gIEl0IGFsc28gaGFzIHNvbWUgcmVn
IGluaXRpYWxpemF0aW9ucyBpbiBjb21wb25lbnQNCj4gcHJvYmUoICkuDQo+IA0KDQpZb3VyIHNv
bHV0aW9uIGlzIGNlcnRhaW5seSBtb3JlIGVsZWdhbnQuIEkgd2lsbCBtYWtlIGEgcGF0Y2ggYW5k
IHN3aXRjaCANCnRvIHJlZ21hcF9tdWx0aV9yZWdfd3JpdGUoKS4NCg0KVGhhbmsgeW91IGZvciB5
b3VyIHJldmlldy4NCg0KQmVzdCByZWdhcmRzLA0KQ29kcmluDQo=
