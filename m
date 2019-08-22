Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028CDC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 04:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBD021848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 04:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DYlmA9jE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jc49Lt3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfHVEXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 00:23:35 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:41804 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfHVEXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 00:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566447815; x=1597983815;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KsQBdsZVdZkqGn3Niq6LghQRRG4VS8zu6DJf7i2nbEs=;
  b=DYlmA9jE52XsuqW9pEoCOS9T/Fwl7Kbw4Z/P7QTIOgH7I7dcwSN4czkv
   IjksHpLNrOp+EL0CY+GwwTGXzgR8zQbgL3fIL1/aD287QicN8QCKt5Ha4
   bM1zOyVeCwFlocV0xICBl1hqGKRjfQixZnSxx2XeJZvNMV0n1RHx4Emak
   AsjA0zDc0vOYoNJRcmKyKjgs0BM8vh0sTuXn/Lnn/InFCX9CspqGTdH7K
   ax0k0yg52gcC30K4IHXkAGpr1CTf63HRP+dEuX+Ns94U04UED1TlX+yoy
   LFmvIpXIevQ29HoLtN30vPxfjZGep9TXBSpSyEc8xPt+NuNMtDL/9A87H
   g==;
IronPort-SDR: h4cNZEzE3B2sdCqJOTFAA1C9dHPt5UgKZyRNxtsHjanlHLitQ7HMYOLXAuoVHRTxDZAAD2v3ef
 xzdUX4RJB2rwLGBC2vJRvZ/9JkHZTzFZ+FH3OW8hsYc2K/uYUA9vxFKArZhG93gq64++AbIcYF
 HuSlpj2ynzhW2vO6OsciMZvjLEXhmauVboeK9rM8KWxcQlwlWDTooZps/n24gre9IjXGHccMdH
 OegGdZAqGPf2r3yCJQuOLw7BLIAvgV0e9TCDdd2vCYr0xhfCrs2uxsqK3ni2Jo6HP/srWEnwvF
 zB4=
X-IronPort-AV: E=Sophos;i="5.64,415,1559491200"; 
   d="scan'208";a="116385153"
Received: from mail-sn1nam01lp2057.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.57])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2019 12:23:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKaJ7kSjlrhKKGOs8jUqtA4/pBwIavw/0cthYAxxkhQ2+wow6+WH6nsYum+DaFfJdbOOAJrtiBJo5s03IlQXAJIOyWDprArUCU5/KJVZMIL2pURO2PwjWdceAfF6C4nQE3KlKS/LnOFqvOuPJvWmW/VuGuIKSgjWuEqaDZ3UWr+ClGTtuX6N7D5WBbQJakcF32yG/XrO3YHt5MEUg7UwWfAovooIV0EBsUTokJyJWqjkNarBjbK1vNCmK2Rh6WDr+MjgW+FTo2km4+p4OOmWLCWZ/+3VksQUiRpjoWAWlo6I3yZFuss3lKhX2KrOgSOUiQweN7OP4sEuqAilcxE+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsQBdsZVdZkqGn3Niq6LghQRRG4VS8zu6DJf7i2nbEs=;
 b=iE3r2b1I9VvQWo16C14YkPTzfUp7K6rnutGm8Y6tNN2U5XZiaN99iBoHbUS9ssxISri8h8WbPe/6o6TTkwGwpo9/egshKPxkvpyw+lx2f8uf+OT2419DaxePyQkBGDAVzQrSpgDlinQ34cK6dmTlYdeETs/pAupq9uWM6EHFrKZ6JDsB2VLnzGrsatzW0BDpnXpBT/+1kJ/y5R70+2hXnSPDJSa3S5gTYsRkUuZdQBaU5fRb5gsFEHFIybbMZ6Pz2NgfLzJuWk8tI4kfdAiFLLML96/C6THGH+m9zDpFC4JeTl9RxA9VTGnWQSn4jHHWX7CTCos9lCmGnSG+gIpCcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsQBdsZVdZkqGn3Niq6LghQRRG4VS8zu6DJf7i2nbEs=;
 b=jc49Lt3oj3Mr+QQ4jyd5RMtHCht/cDNhfwRKmnMU0vMMnJH71G6LrIn5dv/GwH8IOyzlCukF6y4IP2l3sUMrEyvfjXtlnpzPfe7o7fZg/JHolEENX4GszjMCoN/CkzhtGVWgr7md9eZFWJgZX1DQu0GU0Jg5tWRxQVGOxI7Sp3g=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5589.namprd04.prod.outlook.com (20.178.207.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 04:23:23 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e%4]) with mapi id 15.20.2178.018; Thu, 22 Aug 2019
 04:23:23 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v3 3/3] RISC-V: Do not invoke SBI call if cpumask is empty
Thread-Topic: [PATCH v3 3/3] RISC-V: Do not invoke SBI call if cpumask is
 empty
Thread-Index: AQHVWIMXlvjJf/OWIEKZ9ZEntF6ZhqcGZyGAgAAqgwA=
Date:   Thu, 22 Aug 2019 04:23:23 +0000
Message-ID: <bfec8818b825fd791f7e170ba913860971c18067.camel@wdc.com>
References: <20190822004644.25829-1-atish.patra@wdc.com>
         <20190822004644.25829-4-atish.patra@wdc.com>
         <20190822015113.GC11922@lst.de>
In-Reply-To: <20190822015113.GC11922@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [2601:646:8280:fdf0:69be:1cca:a557:65ea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8317b479-de61-4755-1ee5-08d726b87883
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5589;
x-ms-traffictypediagnostic: BYAPR04MB5589:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB55892468BF04A55CF8C93A27FAA50@BYAPR04MB5589.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(189003)(199004)(51914003)(4326008)(6436002)(229853002)(36756003)(14454004)(256004)(4744005)(8936002)(7736002)(118296001)(86362001)(305945005)(81156014)(5660300002)(478600001)(81166006)(8676002)(1730700003)(5640700003)(6486002)(25786009)(6512007)(6246003)(2351001)(76116006)(53936002)(2616005)(71200400001)(446003)(71190400001)(46003)(11346002)(186003)(6506007)(66556008)(102836004)(476003)(66476007)(66946007)(6916009)(64756008)(66446008)(54906003)(2906002)(76176011)(486006)(316002)(99286004)(6116002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5589;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0aD5a+VHA9tGNWBY+92B6o0rI++hTwN1A8WfbHowhDcZmNulB8pRQQH8C1xHdMrOz5jptmhx1pPN47b3nEq266lGXyrDl8ErbmcSM9RMAkdVjKEg4/NBvDMzpy9+aoh97eCWdNuSKZtfK8CSIqPZqdWEN7Ck26+f/qt+jqIb1JxlxcjUrdtPehWS1c5ZxK7Sey53tS+npOarlEYP/fT7pZffclllmqo4dQuxjoxZrfnUnwtFxRqvlzA4tMMmf31CLeNnF1M85qd4mLR3TcwujNCObIH1iWj0pXcEUdBo1wQfE3IDh9QG29cosem2xYaGVBzO6NqQMOXD6+PD7mDSDIgrze40bLUErqJ7n5lMUQCBuQhwGbWt0XVXus2AuJcvYQQiO8ShLeUI4T54C59pjIt3iQ+veDF0P4ot89j3DOQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BC2817F55A796469B7FE9926ABAC989@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8317b479-de61-4755-1ee5-08d726b87883
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 04:23:23.2072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wfou3K4ci+2+RQ/G5pwR7WF5YtbhHJeCWsZycBmxr61aAzUFTEZxf71TMJHKDJsdIiKJGklBOk0oink/TOJK9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5589
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTIyIGF0IDAzOjUxICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMjEsIDIwMTkgYXQgMDU6NDY6NDRQTSAtMDcwMCwgQXRpc2ggUGF0
cmEgd3JvdGU6DQo+ID4gU0JJIGNhbGxzIGFyZSBleHBlbnNpdmUuIElmIGNwdW1hc2sgaXMgZW1w
dHksIHRoZXJlIGlzIG5vIG5lZWQgdG8NCj4gPiB0cmFwIHZpYSBTQkkgYXMgbm8gcmVtb3RlIHRs
YiBmbHVzaGluZyBpcyByZXF1aXJlZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBdGlzaCBQ
YXRyYSA8YXRpc2gucGF0cmFAd2RjLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9yaXNjdi9tbS90
bGJmbHVzaC5jIHwgMyArKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L21tL3RsYmZsdXNoLmMgYi9hcmNoL3Jp
c2N2L21tL3RsYmZsdXNoLmMNCj4gPiBpbmRleCA5ZjU4YjM3OTBiYWEuLjJiZDNjNDE4ZDc2OSAx
MDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Jpc2N2L21tL3RsYmZsdXNoLmMNCj4gPiArKysgYi9hcmNo
L3Jpc2N2L21tL3RsYmZsdXNoLmMNCj4gPiBAQCAtMjEsNiArMjEsOSBAQCBzdGF0aWMgdm9pZCBf
X3NiaV90bGJfZmx1c2hfcmFuZ2Uoc3RydWN0IGNwdW1hc2sNCj4gPiAqY21hc2ssIHVuc2lnbmVk
IGxvbmcgc3RhcnQsDQo+ID4gIAkJZ290byBpc3N1ZV9zZmVuY2U7DQo+ID4gIAl9DQo+ID4gIA0K
PiA+ICsJaWYgKGNwdW1hc2tfZW1wdHkoY21hc2spKQ0KPiA+ICsJCWdvdG8gZG9uZTsNCj4gDQo+
IEkgdGhpbmsgdGhpcyBjYW4gZXZlbiBiZSBkb25lIGJlZm9yZSB0aGUgZ2V0X2NwdSB0byBvcHRp
bWl6ZSBpdCBhDQo+IGxpdHRsZQ0KPiBmdXJ0aGVyLg0KDQpZZWFoLiBJIGNhbiBqdXN0IHJldHVy
biBkaXJlY3RseSBpbiB0aGlzIGNhc2UgYW5kIGNhbGwgZ2V0X2NwdSBhZnRlcg0KdGhpcy4gVGhh
bmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4NCg0KDQotLSANClJlZ2FyZHMsDQpBdGlzaA0K
