Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F5CC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 04:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9D422CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 04:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VIYL1qYD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="y5PaxG6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfHVEB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 00:01:29 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:44749 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfHVEB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 00:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566446488; x=1597982488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BUilaCWlb9HbDt0OcS+IhyTuYoposAVKNiiyeL6RP/M=;
  b=VIYL1qYDehzd8T2Wcf1sI25fa1EN8asV7POhGtVmhRsqei2+mjiLcHkL
   CUbyv61vNpYKTRB99WDMsopn1nQU4OCr1IxbhnjZ8oerQZ/kQlIdVWjQQ
   4OERp1Z+yZJK0lwHva/vdYgZauQXR6/K6Nn/OqWpDqaU/yVU4vVH2xztJ
   1y2YYsCgSBRpONFp4EIV5jumiS9J259YDGHpDbMZzDEYuD1rfGBg0pQaw
   RLKhyteYkAH4iR+7JyioOqyDAftb7nawtQOEI+qw1DDBRSIHQD00GBRYA
   Fi3nTT3gY7p0jtawqo/FO1WsE3EbvAmHuHqdrh3CgFD2Ceuc9q0CBTSLT
   w==;
IronPort-SDR: jKCwGXvRStuix7PsiDZcmyhJQrKwRa5CPuR01RQt+tXmCf6XnwlmZJqxj1EBcrAeZmJDQ9GggN
 f+j/w3PHOBjfbyPWClbVmNFTefNZVQlPaPMJMYNPplOK6y3XblqQ4JqM9YYoBcVN+bXf7il1na
 fOc4ExWX87xWlf+Crd0VarMnOprviPC/rDQrj75VZUC5K5vjlUwzIoennQTmpDa4hsNfi69gGV
 7z0E9ZSLA6HYPq8js181J3udcvNwivWcngZLrrvi3LwnXZZ+a53MzNT3DbSdhb5Zwz7VtNoADv
 STM=
X-IronPort-AV: E=Sophos;i="5.64,415,1559491200"; 
   d="scan'208";a="117317468"
Received: from mail-bn3nam04lp2059.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.59])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2019 12:01:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VL0zie42cuwKi3nx9Ynn+DSQQeULYpmomNbNvxUUu+aBNx5vlCrPPf6e6uVbD3w9ZLi5ZDUK4WM7yAjdi5WT7AOyGEp2tOI0CAJ10WK/nwijhjkBIKj0npextpj4p+7hL0OUe16mHQTOUBliBd9l4+eVo5GhWBiGo61GXIhQhOymLisfava3vctaB40gpebZlclMEzkQjUcBOS221d3LI/76i/KPXJMVJPU6nkjAKUzt9gZt1NjeUehZin1KPPue/ztK7eJTxS/2VJ4ghVo0FgZ/DPmMIQ1a/i02ltkGbFFTFCV1bfjOZXHVZZnLzk3i6Eq0zgMKemYcfJ0R6WxSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUilaCWlb9HbDt0OcS+IhyTuYoposAVKNiiyeL6RP/M=;
 b=oE41s4EyKxx7eJcsc42C+QDO24Vy9Io+QX0R1LQ+cB9+a3q1bSO0VonSoCnmv5F+e3zavNaxEvbcxEp6Ptw3oAosVFfIQz9k9lp6afEIQ6Zs8EOFMP87md1SqcvvckHNCY/Jzd0/XQ1UNRV5aF8V0h54VckIOOhYCrGbzcmRJtZFTerrGoNMWQZP3bMb/SmX3Odso6InDzXgln2Tfce5mPGncQ0+o0brbMUMJJMQ2pwgbtQDHe2rKA0LpFSUSTzA5YH3PcZZZpo8plyABujYiCSY2q+jUD3ozs8fyw0FFY+xsWZDbtww1lZVZyvxN5nDlQij5rCAe10qtQLuBNzDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUilaCWlb9HbDt0OcS+IhyTuYoposAVKNiiyeL6RP/M=;
 b=y5PaxG6WLYrwf7YHefyRW+LoWLTRw1GfkoB6FKJ/2pGDDCOT02F5LvOq4Z4wLKEsvmEFo1ABnSOpas9r9kU9eOLX3pvkSOmDIk+ruKiZzceuI29XvL/Y5U0nH0DfNpNdmqBPuhw00EslVTwuiq+UqPMpHjiDwFMW3LMeWtCTWPM=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4327.namprd04.prod.outlook.com (20.176.251.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 04:01:25 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e%4]) with mapi id 15.20.2178.018; Thu, 22 Aug 2019
 04:01:25 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v3 1/3] RISC-V: Issue a local tlbflush if possible.
Thread-Topic: [PATCH v3 1/3] RISC-V: Issue a local tlbflush if possible.
Thread-Index: AQHVWIMVUivLbwS0nk+EJJcu32ceGqcGZd4AgAAlowA=
Date:   Thu, 22 Aug 2019 04:01:24 +0000
Message-ID: <0f66583404f89ab2bd6c264ba653364ab8a3160e.camel@wdc.com>
References: <20190822004644.25829-1-atish.patra@wdc.com>
         <20190822004644.25829-2-atish.patra@wdc.com>
         <20190822014642.GA11922@lst.de>
In-Reply-To: <20190822014642.GA11922@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [2601:646:8280:fdf0:69be:1cca:a557:65ea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5810d355-84e0-49c7-4dc0-08d726b566b7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4327;
x-ms-traffictypediagnostic: BYAPR04MB4327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4327B45CF49AE4729145E79DFAA50@BYAPR04MB4327.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(6916009)(6486002)(46003)(2616005)(66556008)(305945005)(7736002)(66946007)(6512007)(6506007)(5660300002)(66446008)(64756008)(476003)(6436002)(5640700003)(446003)(11346002)(76116006)(486006)(36756003)(66476007)(102836004)(118296001)(316002)(186003)(53936002)(229853002)(8936002)(76176011)(86362001)(2351001)(6246003)(4326008)(1730700003)(81166006)(81156014)(25786009)(99286004)(8676002)(478600001)(256004)(71200400001)(54906003)(2906002)(14454004)(71190400001)(6116002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4327;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YVVYCWGnpcxMiNuW5wFMP/g15Mchc1Q5QCobZ9WF6c5F/Ehh/qwAhlJBxg4K/bdO8cNfn2fYzQ/4951ARWMd/jWBlxcSWIe/nDj5gitzZFCAVcvTza8/KorEbINchMt8K99sIFKSYf9Z5h2hFxioJJw8sdxHweUX96AOXMx6/TeNgFVeXQqoCC+1CVslbGgh12bWcZUSn4XfmhGMyY8bOPrdl3RfPrj2SCkyC0wJJkh0JW5C8Zdv2BB4z0gexEPXkggl1zmiDwXAMjjGFaLfG6Eh4ldoMdsqv6SQyqvjE4svS0TKUUMCYc0e51dNLIAPrp9H1O6nZEmiV9BMbcVRXLZnukD9C207hIrLbCLDrWfArx8L5GFW9mHsGQrpSZVjdG4eSbFK6QLQCKg+dAnExyZEEbUiF9cXHmvgCcsTfSY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C1DC9928CA4DE43AAB106B1CF77F24E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5810d355-84e0-49c7-4dc0-08d726b566b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 04:01:24.8130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CpbLBHO0BKZQ9/yl+JUy0DfVQnVfXbOkUMChXp94ki1BGbNUn2KXypoTrDIrYXmDtF9EYMBcXjKRHf+7vUQkAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4327
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTIyIGF0IDAzOjQ2ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMjEsIDIwMTkgYXQgMDU6NDY6NDJQTSAtMDcwMCwgQXRpc2ggUGF0
cmEgd3JvdGU6DQo+ID4gSW4gUklTQy1WLCB0bGIgZmx1c2ggaGFwcGVucyB2aWEgU0JJIHdoaWNo
IGlzIGV4cGVuc2l2ZS4gSWYgdGhlDQo+ID4gbG9jYWwNCj4gPiBjcHUgaXMgdGhlIG9ubHkgY3B1
IGluIGNwdW1hc2ssIHRoZXJlIGlzIG5vIG5lZWQgdG8gaW52b2tlIGEgU0JJDQo+ID4gY2FsbC4N
Cj4gPiANCj4gPiBKdXN0IGRvIGEgbG9jYWwgZmx1c2ggYW5kIHJldHVybi4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBBdGlzaCBQYXRyYSA8YXRpc2gucGF0cmFAd2RjLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgYXJjaC9yaXNjdi9tbS90bGJmbHVzaC5jIHwgMTUgKysrKysrKysrKysrKysrDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L2FyY2gvcmlzY3YvbW0vdGxiZmx1c2guYyBiL2FyY2gvcmlzY3YvbW0vdGxiZmx1c2guYw0KPiA+
IGluZGV4IGRmOTNiMjZmMWI5ZC4uMzY0MzBlZTNiZWQ5IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gv
cmlzY3YvbW0vdGxiZmx1c2guYw0KPiA+ICsrKyBiL2FyY2gvcmlzY3YvbW0vdGxiZmx1c2guYw0K
PiA+IEBAIC0yLDYgKzIsNyBAQA0KPiA+ICANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L21tLmg+DQo+
ID4gICNpbmNsdWRlIDxsaW51eC9zbXAuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+
DQo+ID4gICNpbmNsdWRlIDxhc20vc2JpLmg+DQo+ID4gIA0KPiA+ICB2b2lkIGZsdXNoX3RsYl9h
bGwodm9pZCkNCj4gPiBAQCAtMTMsOSArMTQsMjMgQEAgc3RhdGljIHZvaWQgX19zYmlfdGxiX2Zs
dXNoX3JhbmdlKHN0cnVjdCBjcHVtYXNrDQo+ID4gKmNtYXNrLCB1bnNpZ25lZCBsb25nIHN0YXJ0
LA0KPiA+ICAJCXVuc2lnbmVkIGxvbmcgc2l6ZSkNCj4gPiAgew0KPiA+ICAJc3RydWN0IGNwdW1h
c2sgaG1hc2s7DQo+ID4gKwl1bnNpZ25lZCBpbnQgY3B1aWQgPSBnZXRfY3B1KCk7DQo+ID4gIA0K
PiA+ICsJaWYgKCFjbWFzaykgew0KPiA+ICsJCXJpc2N2X2NwdWlkX3RvX2hhcnRpZF9tYXNrKGNw
dV9vbmxpbmVfbWFzaywgJmhtYXNrKTsNCj4gPiArCQlnb3RvIGlzc3VlX3NmZW5jZTsNCj4gPiAr
CX0NCj4gPiArDQo+ID4gKwlpZiAoY3B1bWFza190ZXN0X2NwdShjcHVpZCwgY21hc2spICYmIGNw
dW1hc2tfd2VpZ2h0KGNtYXNrKSA9PQ0KPiA+IDEpIHsNCj4gPiArCQlsb2NhbF9mbHVzaF90bGJf
YWxsKCk7DQo+ID4gKwkJZ290byBkb25lOw0KPiA+ICsJfQ0KPiANCj4gSSB0aGluayBhIHNpbmds
ZSBjb3JlIG9uIGEgU01QIGtlcm5lbCBpcyBhIHZhbGlkIGVub3VnaCB1c2UgY2FzZQ0KPiBnaXZl
bg0KPiBob3cgbGl0dGUgZGlzdHJvcyBzdGlsbCBoYXZlIFVQIGtlcm5lbHMuICBTbyBNYXliZSB0
aGlzIHNoaXVsZCByYXRoZXINCj4gYmU6DQo+IA0KPiAJaWYgKCFjbWFzaykNCj4gCQljbWFzayA9
IGNwdV9vbmxpbmVfbWFzazsNCj4gDQo+IAlpZiAoY3B1bWFza190ZXN0X2NwdShjcHVpZCwgY21h
c2spICYmIGNwdW1hc2tfd2VpZ2h0KGNtYXNrKSA9PQ0KPiAxKSB7DQo+IAkJbG9jYWxfZmx1c2hf
dGxiX2FsbCgpOw0KPiAJfSBlbHNlIHsNCj4gCSAJcmlzY3ZfY3B1aWRfdG9faGFydGlkX21hc2so
Y21hc2ssICZobWFzayk7DQo+IAkgIAlzYmlfcmVtb3RlX3NmZW5jZV92bWEoaG1hc2suYml0cywg
c3RhcnQsIHNpemUpOw0KPiAJfQ0KDQpUaGUgZG93bnNpZGUgb2YgdGhpcyBpcyB0aGF0IGZvciBl
dmVyeSAhY21hc2sgY2FzZSBpbiB0cnVlIFNNUCAobW9yZQ0KY29tbW9uIHByb2JhYmx5KSBpdCB3
aWxsIGV4ZWN1dGUgMiBleHRyYSBjcHVtYXNrIGluc3RydWN0aW9ucy4gQXMNCnRsYmZsdXNoIHBh
dGggaXMgaW4gcGVyZm9ybWFuY2UgY3JpdGljYWwgcGF0aCwgSSB0aGluayB3ZSBzaG91bGQgZmF2
b3INCm1vcmUgY29tbW9uIGNhc2UgKFNNUCB3aXRoIG1vcmUgdGhhbiAxIGNvcmUpLg0KDQpUaG91
Z2h0cyA/DQoNCi0tIA0KUmVnYXJkcywNCkF0aXNoDQo=
