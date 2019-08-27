Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5394AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B7720828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Ps8dWS8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfH0MEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:04:34 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:26132 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfH0MEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:04:33 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: EEAjcotZ4RqizZjCkzllaVGC+XXq/OaFvs3CwOpMOBAacnuCoGQKprCOp+uXDr7uKN31qR//Cv
 YWVBfjaks124z82BHd+9xHWi2cQYbuaZPeuQwoOGhAGZma+OOrcn/2J1o8qbMkMWoCDclJOfYY
 0hkxLAFwFvjLZ4vqeTP21aq/og+XfkI4xcTP+bk9VP6yjP2OiZ1MnD5Z2DMRR3xXDHmztWz073
 u4yXwjTJJI8lBJYM60NJkWNgeSznH9JcBFZBZXQiLfQ9BTxfU+ioZc6N4z9Pwtw1qsIp7fh0jE
 VqY=
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="48123617"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Aug 2019 05:04:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 27 Aug 2019 05:04:30 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 27 Aug 2019 05:04:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjhQUGMGbxtlzf1LETwnuOH9SrA/k92HtXPmXLxqncl+PNQT+8P02LkN6DQRE2GW9EjPJFHf+hX9qM6tQh6BOjqSau2cb/9FIcV2M9h0RUuCAdyUPqWekieLwFgYZgzY0iwgdPN0yPjXJDSu+mzWsDkXaWYyxWgVJYDJubnAWFG0Osls9WzPFfTC0W8gTyfLMwuHWy5LJS7E8sHDLj+tub0ymRMUZoeJfjl0+z/xIKdV7Abdoya8OvT44RMN6xzSG+WHDAwRAqelqdXdxK4aobDan0D/zLLWZfKK6A27Qe4Ia6VR7s6YoNuxoL06KqRQI3weU6d76J0UwgQQi/frGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeQcIuX+KIIlgqDcnD+g7jGEw3FCLGiV0erEJ3pLL5o=;
 b=E0uuvbM76WvTqtNiwIxecE7Vpei9FhKiNq598eT4kNwtekK4SK/M27xr/qmr0dID+TACNh9tVY2paiNWYJq4TdMo7b8xpc7gyptHyKL/yMW+V1dAHY8xbTYAfExK0OWi8XC8XTDx12tLBscnc7yL0l7ATDhfqflbM9VFxvjIrXBqPnv7ZbjpoHpSRKFOKRLUiVfPZk0e5yqXScn4AVcJybbZgkW69ZI7XtFKd33lfGTcri61DqfxrOOR3y9MwoVF/gLZRLScHPlWijQbW8qJPATvY+Ae58VHPBCHuGmQplnq7elVrcaloeXhxzIsfETbIRZVfNqUXNKmeoDwefCsUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeQcIuX+KIIlgqDcnD+g7jGEw3FCLGiV0erEJ3pLL5o=;
 b=Ps8dWS8siBezFy9AObzPe3CfpozRCcmDrA0L/PTbtDsAVBaXn3tc1ObeB+NmVNSrIMXKq+W6ju/p+/Oo9fPHEoQYK38DzkmfPeeZhTUtBcZzXxJLXglBFpvnPwvZuYYJVO3+NG84Gi5cbyrX3bcDO0Dnr/jv387gphRB3EqLCiQ=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3904.namprd11.prod.outlook.com (10.255.180.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 12:04:29 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 12:04:29 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Ashish.Kumar@nxp.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <kuldeep.singh@nxp.com>
Subject: Re: [Patch v3] drivers: mtd: spi-nor: Add flash property for
 mt25qu512a and mt35xu02g
Thread-Topic: [Patch v3] drivers: mtd: spi-nor: Add flash property for
 mt25qu512a and mt35xu02g
Thread-Index: AQHVUcNYVX8MlxJF80625T3aIY1jHqcO+5qA
Date:   Tue, 27 Aug 2019 12:04:29 +0000
Message-ID: <e55cd1f9-7359-5484-d258-1f3ea51584b6@microchip.com>
References: <1565692705-27749-1-git-send-email-Ashish.Kumar@nxp.com>
In-Reply-To: <1565692705-27749-1-git-send-email-Ashish.Kumar@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0165.eurprd07.prod.outlook.com
 (2603:10a6:802:3e::13) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e172b9c6-eea5-4c6a-d85c-08d72ae6b69e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3904;
x-ms-traffictypediagnostic: MN2PR11MB3904:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MN2PR11MB3904ABF3F90BB278A1041EDBF0A00@MN2PR11MB3904.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(366004)(199004)(189003)(53936002)(71190400001)(6506007)(6436002)(66066001)(71200400001)(31686004)(86362001)(81156014)(81166006)(186003)(8676002)(5660300002)(6512007)(66946007)(66556008)(36756003)(6116002)(6486002)(3846002)(66446008)(8936002)(6306002)(64756008)(52116002)(2501003)(31696002)(2906002)(386003)(478600001)(76176011)(66476007)(486006)(6246003)(2201001)(2616005)(26005)(25786009)(476003)(7416002)(110136005)(446003)(966005)(102836004)(14444005)(11346002)(14454004)(4326008)(229853002)(99286004)(305945005)(54906003)(256004)(316002)(53546011)(7736002)(138113003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3904;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MR1+Yl2k6FoXerhZ1wn1HePwFUX3b2NaRWeDikY16g5SPU/VqJvT99c7h7yBsUf/JqL3voj1bzH2NjoNtAMAotJfhNAzuiYGR79l7OKRYy/W0wlTkp2wlPmKvwzGW4rZf9ehOitmTHd5S4FcF+EfPm2FwSCDyOKs8fXyPKweGiwNnPqntZ+Z7asNgqvzUpOjpTDN6Pzcq3KYH34BGWlbbkRzoe2gPfhNRN8H6G6wYAq0SM+47bRm3yvucf5tTqRHPPPnq07FFpaEPedVwl2kskU5BkUeFKNJPKM+RVBN5Loe6MrF3FFAoDOulg7r3o6HUUan9qRxTxJ9UuJiZtU2ZOBPTEgdRQWPqUWdBrkFnyvhCDwWSI+xOi/gfCu20XBlsilxlmJBr9S9h9h4u4YFTKkwMr0dcNymiVAaAUt0fhk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <817519E50A773D418D42B6B710A039A6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e172b9c6-eea5-4c6a-d85c-08d72ae6b69e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 12:04:29.3860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: di0B5en4YzGn/Q+MOFVvMOUjH6nPtCuvmmk9LF2DA8aMv2NEXWgy2y6MWuM9h6pHvx8xAuYiw6AM5EJsrtYCA1CWZ7dNLMDIDj+ePfOiats=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3904
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFzaGlzaCwNCg0KT24gMDgvMTMvMjAxOSAwMTozOCBQTSwgQXNoaXNoIEt1bWFyIHdyb3Rl
Og0KPiBFeHRlcm5hbCBFLU1haWwNCj4gDQo+IA0KPiBtdDI1cXU1MTJhIGlzIHJlYnJhbmRlZCBh
ZnRlciBpdHMgc3Bpbm9mZiBmcm9tIFNUTSwgc28gaXQgaXMNCj4gZGlmZmVyZW50IG9ubHkgaW4g
dGVybSBvZiBvcGVyYXRpbmcgZnJlcXVlbmN5LCBpbml0aWFsIEpFREVDIGlkDQo+IGlzIHNhbWUg
YXMgdGhhdCBvZiBuMjVxNTEyYS4gSW4gb3JkZXIgdG8gYXZvaWQgYW55IGNvbmZ1c3Npb24NCj4g
d2l0aCByZXNwZWN0IHRvIG5hbWUgbmV3IGVudHJ5IGlzIGFkZGVkLg0KPiBUaGlzIGZsYXNoIGlz
IHRlc3RlZCBmb3IgU2luZ2xlIEkvTyBhbmQgUVVBRCBJL08gbW9kZSBvbiBMUzEwNDZGUldZLg0K
PiANCj4gbXQzNXh1MDJnIGlzIE9jdGFsIGZsYXNoIHN1cHBvcnRpbmcgU2luZ2xlIEkvTyBhbmQg
UUNUQUwgSS9PDQo+IGFuZCBpdCBoYXMgYmVlbiB0ZXN0ZWQgb24gTFMxMDI4QVJEQg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogS3VsZGVlcCBTaW5naCA8a3VsZGVlcC5zaW5naEBueHAuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBBc2hpc2ggS3VtYXIgPGFzaGlzaC5rdW1hckBueHAuY29tPg0KPiAtLS0N
Cj4gdjM6DQo+IC1SZXdvcmQgY29tbWl0cyBtc2cNCj4gLXJlYmFzZSB0byB0b3Agb2YgbXRkLWxp
bnV4IHNwaS1ub3IvbmV4dA0KPiB2MjoNCj4gSW5jb3Jwb3JhdGUgcmV2aWV3IGNvbW1lbnRzIGZy
b20gVmlnbmVzaA0KPiANCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIHwgOSArKysr
KysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
c3BpLW5vci5jDQo+IGluZGV4IDAzY2M3ODguLjk3ZDNkZTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3Bp
LW5vci5jDQo+IEBAIC0xOTg4LDYgKzE5ODgsMTIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFz
aF9pbmZvIHNwaV9ub3JfaWRzW10gPSB7DQo+ICAJeyAibjI1cTEyOGExMyIsICBJTkZPKDB4MjBi
YTE4LCAwLCA2NCAqIDEwMjQsICAyNTYsIFNFQ1RfNEsgfCBTUElfTk9SX1FVQURfUkVBRCkgfSwN
Cj4gIAl7ICJuMjVxMjU2YSIsICAgIElORk8oMHgyMGJhMTksIDAsIDY0ICogMTAyNCwgIDUxMiwg
U0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQpIH0sDQo+ICAJ
eyAibjI1cTI1NmF4MSIsICBJTkZPKDB4MjBiYjE5LCAwLCA2NCAqIDEwMjQsICA1MTIsIFNFQ1Rf
NEsgfCBTUElfTk9SX1FVQURfUkVBRCkgfSwNCj4gKw0KPiArCS8qIE1pY3JvbiAqLw0KPiArCXsg
Im10MjVxdTUxMmEiLCBJTkZPNigweDIwYmIyMCwgMHgxMDQ0MDAsIDY0ICogMTAyNCwgMTAyNCwg
U0VDVF80SyB8DQo+ICsJCQkJVVNFX0ZTUiB8IFNQSV9OT1JfRFVBTF9SRUFEIHwNCj4gKwkJCQlT
UElfTk9SX1FVQURfUkVBRCB8IFNQSV9OT1JfNEJfT1BDT0RFUykgfSwNCg0KSSdtIGxvb2tpbmcg
YXQgdGhlIGZvbGxvd2luZyBkYXRhc2hlZXRzOiBtdDI1cXU1MTJhIFsxXSBhbmQgbjI1cTUxMmEg
WzJdLg0KQm90aCBmbGFzaGVzIGhhdmUgdGhlIHNhbWUgRXh0ZW5kZWQgRGV2aWNlIElEIGRhdGEu
IFdoYXQgd2lsbCBoYXBwZW4sIGlzIHRoYXQNCnlvdSdsbCBhbHdheXMgaGl0IHRoZSBmaXJzdCB2
YWxpZCBlbnRyeSwgc28gIm10MjVxdTUxMmEiLCBhbmQgeW91J2xsIGluZGljYXRlIGENCid3cm9u
ZycgZmxhc2ggbmFtZSBmb3IgbjI1cTUxMmEuIElmIHRoZXJlIGlzIG5vdGhpbmcgdGhhdCBkaWZm
ZXJlbnRpYXRlIGJldHdlZW4NCnRoZSB0d28sIG1heWJlIHlvdSBjYW4gYWRkIGEgY29tbWVudCBp
biB0aGUgY29kZSB0aGF0IHNheXMgdGhhdCAibjI1cTUxMmEiIHdhcw0KcmUtYnJhbmRlZCB0byAi
bXQyNXF1NTEyYSIgYWZ0ZXIgdGhlIFNUTSBzcGluLW9mZi4gV2hhdGV2ZXIgc29sdXRpb24gd2ls
bCBiZSwgaXQNCndpbGwgYmUgYmV0dGVyIGlmIHlvdSBkbyBpdCBpbiBhIHNlcGFyYXRlIHBhdGNo
Lg0KDQpbMV0NCmh0dHBzOi8vc3RhdGljNi5hcnJvdy5jb20vYXJvcGRmY29udmVyc2lvbi8xYThi
MDhjYjA4NDI3ODIxZjE2NjEzN2QwNjRjNDgzN2VjYTcwZjE1LzEyNjgyNzk3NzAwNzI4NDgxMjY4
MjY2ODQyOTQ1OTQ2bXQyNXFfcWxrdF91XzUxMl9hYmJfMC5wZGYucGRmDQoNClsyXQ0KaHR0cHM6
Ly93d3cuZ29vZ2xlLmNvbS91cmw/c2E9dCZyY3Q9aiZxPSZlc3JjPXMmc291cmNlPXdlYiZjZD0x
JmNhZD1yamEmdWFjdD04JnZlZD0yYWhVS0V3alpsSl9NX0tMa0FoV0I2NlFLSFY2V0FYNFFGakFB
ZWdRSUFoQUMmdXJsPWh0dHBzJTNBJTJGJTJGd3d3Lm1pY3Jvbi5jb20lMkYtJTJGbWVkaWElMkZk
b2N1bWVudHMlMkZwcm9kdWN0cyUyRmRhdGEtc2hlZXQlMkZub3ItZmxhc2glMkZzZXJpYWwtbm9y
JTJGbjI1cSUyRm4yNXFfNTEybWJfMV84dl82NW5tLnBkZiZ1c2c9QU92VmF3M0JTaVVJZlRnaWtG
WjBGWjdPX0Q2MQ0KDQo+ICsNCj4gIAl7ICJuMjVxNTEyYSIsICAgIElORk8oMHgyMGJiMjAsIDAs
IDY0ICogMTAyNCwgMTAyNCwgU0VDVF80SyB8IFVTRV9GU1IgfCBTUElfTk9SX1FVQURfUkVBRCkg
fSwNCj4gIAl7ICJuMjVxNTEyYXgzIiwgIElORk8oMHgyMGJhMjAsIDAsIDY0ICogMTAyNCwgMTAy
NCwgU0VDVF80SyB8IFVTRV9GU1IgfCBTUElfTk9SX1FVQURfUkVBRCkgfSwNCj4gIAl7ICJuMjVx
MDAiLCAgICAgIElORk8oMHgyMGJhMjEsIDAsIDY0ICogMTAyNCwgMjA0OCwgU0VDVF80SyB8IFVT
RV9GU1IgfCBTUElfTk9SX1FVQURfUkVBRCB8IE5PX0NISVBfRVJBU0UpIH0sDQo+IEBAIC0yMDAz
LDYgKzIwMDksOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8gc3BpX25vcl9pZHNb
XSA9IHsNCj4gIAkJCVNFQ1RfNEsgfCBVU0VfRlNSIHwgU1BJX05PUl9PQ1RBTF9SRUFEIHwNCj4g
IAkJCVNQSV9OT1JfNEJfT1BDT0RFUykNCj4gIAl9LA0KPiArCXsgIm10MzV4dTAyZyIsICBJTkZP
KDB4MmM1YjFjLCAwLCAxMjggKiAxMDI0LCAyMDQ4LA0KPiArCQkJU0VDVF80SyB8IFVTRV9GU1Ig
fCBTUElfTk9SX09DVEFMX1JFQUQgfA0KPiArCQkJU1BJX05PUl80Ql9PUENPREVTKSB9LA0KDQpJ
cyB0aGVyZSBhIHB1YmxpYyBkYXRhc2hlZXQgZm9yIHRoaXMgZmxhc2g/DQoNCkNoZWVycywNCnRh
DQo=
