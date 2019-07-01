Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3074EC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AB421479
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rhw/1vx1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GRa+inB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfGAVP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:15:58 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:38370 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfGAVP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562015755; x=1593551755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IbtMsfLcN3s/J+PHWScrjDaYBa9bajLydbe7d3ZJnMc=;
  b=rhw/1vx1KXgqK/pYLyHp243I3rJYRlbdtIf1GsKdUiyaVBjdOS9aAoZE
   0GxwV5OEiJGjKeURUjCQwDC+430T+WBFMREQyB4kcC3awYyXGPpf2ekf/
   M1M66VByLswa1UbgKgAGOnch8DIN2Qtbyf7pfjAfH+zYQn79a3jT3ePdd
   Uihe2QLbh3S9gHx/qHyVN34DZeFp1M7ntqe7tDuk/UJkSpv3tx7gLi4g4
   QDeUBtG9EMq3seyptzVNla2+JPWtBihzQ2MheTfRtsBdIevcYHPIom6rI
   brJE8751iTekpG5nzYKpsW8irHyhDttIhlejo1xncyspwAnd+vQV65o7I
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,440,1557158400"; 
   d="scan'208";a="218375144"
Received: from mail-dm3nam03lp2053.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.53])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 05:15:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbtMsfLcN3s/J+PHWScrjDaYBa9bajLydbe7d3ZJnMc=;
 b=GRa+inB9CWIMUybDRtCV4CCPvkLNV/t/5J4WcyNj6FqP7ItxA8sv7sDSJfbqcvlVCLTPD+XPaqiK3R8BwU9Bc3R+4ZVEm6TMT9Ji/bhRvtMy6THZSzj57BquC7gM98LIDr1JnUzLMyBirX4GQwPagvsXVF1vZqiW+NhTVU2sfx8=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB5511.namprd04.prod.outlook.com (20.178.232.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Mon, 1 Jul 2019 21:15:51 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2%5]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 21:15:51 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@lst.de" <hch@lst.de>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/17] riscv: read the hart ID from mhartid on boot
Thread-Topic: [PATCH 10/17] riscv: read the hart ID from mhartid on boot
Thread-Index: AQHVKk/cfMyx94L+NUaLXWJqaXxhu6a2T7EA
Date:   Mon, 1 Jul 2019 21:15:51 +0000
Message-ID: <ee7f3fb820b8efa8812670964fe86add9c5838be.camel@wdc.com>
References: <20190624054311.30256-1-hch@lst.de>
         <20190624054311.30256-11-hch@lst.de>
In-Reply-To: <20190624054311.30256-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.45.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a0ec5ee-65cb-4fb2-961f-08d6fe694bd5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5511;
x-ms-traffictypediagnostic: BYAPR04MB5511:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB55110765B38400C1D97E76E5FAF90@BYAPR04MB5511.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(199004)(189003)(446003)(2616005)(14454004)(476003)(305945005)(2906002)(486006)(118296001)(66476007)(66556008)(64756008)(66446008)(11346002)(186003)(2201001)(66946007)(86362001)(72206003)(76176011)(73956011)(102836004)(6116002)(3846002)(25786009)(2501003)(5660300002)(26005)(6506007)(316002)(76116006)(966005)(478600001)(256004)(71200400001)(229853002)(8676002)(6486002)(99286004)(66066001)(6436002)(53936002)(81166006)(81156014)(8936002)(36756003)(6512007)(7736002)(54906003)(110136005)(6306002)(4326008)(6246003)(71190400001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5511;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zw7T8D2zqu1R5UTq7jcRxYfVWeR28N+2hACs9Fl87LTzWkocnLO+n4+0vmDQPZzHs0EfjsgN/UJzSeoitkVEOxBh8fSBfIEBq1dPNg8kIIDl+PlXphRz9YiOqI0ZUIRbWlJMpfha/lwRMoGymRoq8IyElEpvYWWXBgkrvszFwUOUfN0aIZPaMXmajFkg6qGZncFYYkWFfv9z9LxonxSoWIHdPDS+AwTk/3VlDTXPaQEAfg6oCaCE0ANeW8T//GuRbWL5T0tJvaENqRlxaQf/2h3wX5Nr9DVTLWMdZhJ00iWKR+bYjMlErDsjPAa3Xh5Ao8FmuiHckrfEFGHS7FzNB3oCK7xW0BI/cnIZIsJofvWyb3vGN/1nMkL3ljVQZEK4ldcy2jrn7/+8P1PWvRQm/shha4WTVUcMcNjAGRWAm+s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF3F2D41B9906D4CBC43A3BD256FF72F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0ec5ee-65cb-4fb2-961f-08d6fe694bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 21:15:51.5804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA2LTI0IGF0IDA3OjQzICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gRnJvbTogRGFtaWVuIExlIE1vYWwgPERhbWllbi5MZU1vYWxAd2RjLmNvbT4NCj4gDQo+
IFdoZW4gaW4gTS1Nb2RlLCB3ZSBjYW4gdXNlIHRoZSBtaGFydGlkIENTUiB0byBnZXQgdGhlIElE
IG9mIHRoZQ0KPiBydW5uaW5nDQo+IEhBUlQuIERvaW5nIHNvLCBkaXJlY3QgTS1Nb2RlIGJvb3Qg
d2l0aG91dCBmaXJtd2FyZSBpcyBwb3NzaWJsZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhbWll
biBMZSBNb2FsIDxkYW1pZW4ubGVtb2FsQHdkYy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlz
dG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0NCj4gIGFyY2gvcmlzY3Yva2VybmVsL2hl
YWQuUyB8IDggKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2tlcm5lbC9oZWFkLlMgYi9hcmNoL3Jpc2N2L2tl
cm5lbC9oZWFkLlMNCj4gaW5kZXggZTVmYTU0ODFhYTk5Li5hNGMxNzBlNDFhMzQgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL2hlYWQuUw0KPiArKysgYi9hcmNoL3Jpc2N2L2tlcm5l
bC9oZWFkLlMNCj4gQEAgLTE4LDYgKzE4LDE0IEBAIEVOVFJZKF9zdGFydCkNCj4gIAljc3J3IENT
Ul9YSUUsIHplcm8NCj4gIAljc3J3IENTUl9YSVAsIHplcm8NCj4gIA0KPiArI2lmZGVmIENPTkZJ
R19NX01PREUNCj4gKwkvKg0KPiArCSAqIFRoZSBoYXJ0aWQgaW4gYTAgaXMgZXhwZWN0ZWQgbGF0
ZXIgb24sIGFuZCB3ZSBoYXZlIG5vDQo+IGZpcm13YXJlDQo+ICsJICogdG8gaGFuZCBpdCB0byB1
cy4NCj4gKwkgKi8NCj4gKwljc3JyIGEwLCBtaGFydGlkDQoNCkkgdGhpbmsgeW91IHNob3VsZCBh
ZGQgU1JfTUhBUlRJRCBhbmQgdXNlIHRoYXQgaW5zdGVhZCBvZiBkaXJlY3QgY3NyDQpuYW1lLg0K
VGhlIGZvbGxvd2luZyBwYXRjaCByZXBsYWNlZCBhbGwgb2NjdXJyZW5jZSBvZiBjc3IgbmFtZSB1
c2FnZSBmcm9tDQprZXJuZWwgd2l0aCBDU1IgbnVtYmVycy4NCg0KaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wYXRjaC8xMDkxNjI5My8NCg0KV2l0aCB0aGF0IGNoYW5nZSwgDQoNClJldmll
d2VkLWJ5OiBBdGlzaCBQYXRyYSA8YXRpc2gucGF0cmFAd2RjLmNvbT4NCg0KPiArI2VuZGlmDQo+
ICsNCj4gIAkvKiBMb2FkIHRoZSBnbG9iYWwgcG9pbnRlciAqLw0KPiAgLm9wdGlvbiBwdXNoDQo+
ICAub3B0aW9uIG5vcmVsYXgNCg0KLS0gDQpSZWdhcmRzLA0KQXRpc2gNCg==
