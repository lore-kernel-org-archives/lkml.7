Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638FDC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 20:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E63D2080C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 20:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfFPU4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 16:56:38 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:41106 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbfFPU4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 16:56:38 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5GKtZFx023249;
        Sun, 16 Jun 2019 20:56:23 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 2t5vcwr5ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jun 2019 20:56:23 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id A91D083;
        Sun, 16 Jun 2019 20:56:21 +0000 (UTC)
Received: from G4W9331.americas.hpqcorp.net (16.208.32.117) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 16 Jun 2019 20:56:21 +0000
Received: from G4W10204.americas.hpqcorp.net (2002:10cf:5210::10cf:5210) by
 G4W9331.americas.hpqcorp.net (2002:10d0:2075::10d0:2075) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Sun, 16 Jun 2019 20:56:20 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G4W10204.americas.hpqcorp.net (16.207.82.16) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Sun, 16 Jun 2019 20:56:20 +0000
Received: from CS1PR8401MB0727.NAMPRD84.PROD.OUTLOOK.COM (10.169.15.135) by
 CS1PR8401MB0807.NAMPRD84.PROD.OUTLOOK.COM (10.169.14.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Sun, 16 Jun 2019 20:56:19 +0000
Received: from CS1PR8401MB0727.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e1ad:64bb:f91:be1]) by CS1PR8401MB0727.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e1ad:64bb:f91:be1%5]) with mapi id 15.20.1987.014; Sun, 16 Jun 2019
 20:56:19 +0000
From:   "Vaden, Tom (HPE Server OS Architecture)" <tom.vaden@hpe.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf/x86/intel: Disable check_msr for real hw
Thread-Topic: [PATCH] perf/x86/intel: Disable check_msr for real hw
Thread-Index: AQHVJE2uIweGrZOGEUGcjZAqGgW0xaaewzIA
Date:   Sun, 16 Jun 2019 20:56:19 +0000
Message-ID: <b084a989-a39c-0da4-6b68-9e3094b2344e@hpe.com>
References: <20190614112853.GC4325@krava>
 <aafc5b7c-220e-dfab-c49d-d9e75a4efa87@linux.intel.com>
 <20190616141313.GD2500@krava>
In-Reply-To: <20190616141313.GD2500@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:208:2d::14) To CS1PR8401MB0727.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750d::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:85:c100:2d8d:dbb0:2ed9:59d1:461]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b80c33d2-c11a-47fa-5a60-08d6f29d14b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CS1PR8401MB0807;
x-ms-traffictypediagnostic: CS1PR8401MB0807:
x-microsoft-antispam-prvs: <CS1PR8401MB080729E5CA2DD06CDFF2FE04E8E80@CS1PR8401MB0807.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0070A8666B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(366004)(376002)(39860400002)(189003)(199004)(305945005)(54906003)(110136005)(14444005)(5024004)(8936002)(46003)(256004)(6116002)(99286004)(25786009)(186003)(102836004)(71190400001)(71200400001)(52116002)(478600001)(6506007)(66556008)(64756008)(66446008)(7416002)(6246003)(66476007)(73956011)(81166006)(66946007)(386003)(476003)(5660300002)(53546011)(2616005)(486006)(8676002)(53936002)(81156014)(316002)(76176011)(6512007)(2906002)(31696002)(7736002)(36756003)(4326008)(6436002)(86362001)(68736007)(14454004)(6486002)(11346002)(229853002)(446003)(31686004);DIR:OUT;SFP:1102;SCL:1;SRVR:CS1PR8401MB0807;H:CS1PR8401MB0727.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MNjF69RGVANLym9iF0UpIuW5x5c/WcWwX8NQTiWi1jN1vHLO1pt860WaU8lj3sIoNZAcz6pDWT0od6kCsAWIL9VBcy4lBmkKQlisIp3QUkJvNZWryghT5Xes0Zb6id+aQ8s4DTcbflB1AmSHVMoYBCfNj8J2rXYJejpPQ4CRo8CM/OqfsyZCFP43d90wemWgChUrhmD+EVX4npDMbYN/2qxgDEqZJG+tHebrnARP3nGYZZbqUS6ZylFKfjkUC26ZFaIUw66dlfibQGMyvOZABlYj0NjGEi/BPdaWqy8/4/eEkFu9d5EG7hplP3TVRwqPPLAmGrgsFZC9vbSqI3WhTZIeAKHEtHpb1dHIYcwu0x0v008CKQ8s1m0U72P+bzg34skPeRy9cisZY+PofdizLE6zv/zMNNcCbfWi4G3I960=
Content-Type: text/plain; charset="utf-8"
Content-ID: <738E7E232033084E8769669A029E8ED4@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b80c33d2-c11a-47fa-5a60-08d6f29d14b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2019 20:56:19.3414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tom.vaden@hpe.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0807
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-16_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=877 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906160201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDYvMTYvMTkgMTA6MTMgQU0sIEppcmkgT2xzYSB3cm90ZToNCj4gT24gRnJpLCBKdW4g
MTQsIDIwMTkgYXQgMDk6NDU6MjFBTSAtMDQwMCwgTGlhbmcsIEthbiB3cm90ZToNCj4+DQo+Pg0K
Pj4gT24gNi8xNC8yMDE5IDc6MjggQU0sIEppcmkgT2xzYSB3cm90ZToNCj4+PiBoaSwNCj4+PiB0
aGUgSFBFIHNlcnZlciBjYW4gZG8gUE9TVCB0cmFjaW5nIGFuZCBoYXZlIGVuYWJsZWQgTEJSDQo+
Pj4gdHJhY2luZyBkdXJpbmcgdGhlIGJvb3QsIHdoaWNoIG1ha2VzIGNoZWNrX21zciBmYWlsIGZh
bHNseS4NCj4+Pg0KPj4+IEl0IGxvb2tzIGxpa2UgY2hlY2tfbXNyIGNvZGUgd2FzIGFkZGVkIG9u
bHkgdG8gY2hlY2sgb24gZ3Vlc3RzDQo+Pj4gTVNSIGFjY2Vzcywgd291bGQgaXQgYmUgdGhlbiBv
ayB0byBkaXNhYmxlIGNoZWNrX21zciBmb3IgcmVhbA0KPj4+IGhhcmR3YXJlPyAoYXMgaW4gcGF0
Y2ggYmVsb3cpDQo+Pg0KPj4gWWVzLCB0aGUgY2hlY2tfbXNyIHBhdGNoIHdhcyB0byBmaXggYSBi
dWcgcmVwb3J0IGluIGd1ZXN0Lg0KPj4gSSBkaWRuJ3QgZ2V0IHNpbWlsYXIgYnVnIHJlcG9ydCBm
b3IgcmVhbCBoYXJkd2FyZS4NCj4+IEkgdGhpbmsgaXQgc2hvdWxkIGJlIE9LIHRvIGRpc2FibGUg
aXQgZm9yIHJlYWwgaGFyZHdhcmUuDQo+Pg0KPiANCj4gdGhhbmtzIGZvciBjb25maXJtYXRpb24s
IGF0dGFjaGluZyB0aGUgZnVsbCBwYXRjaA0KPiANCj4gdGhhbmtzLA0KPiBqaXJrYQ0KPiANCj4g
DQo+IC0tLQ0KPiBUb20gVmFkZW4gcmVwb3J0ZWQgZmFsc2UgZmFpbHVyZSBvZiBjaGVja19tc3Ig
ZnVuY3Rpb24sIGJlY2F1c2UNCj4gc29tZSBzZXJ2ZXJzIGNhbiBkbyBQT1NUIHRyYWNpbmcgYW5k
IGVuYWJsZSBMQlIgdHJhY2luZyBkdXJpbmcNCj4gdGhlIGJvb3QuDQo+IA0KPiBLYW4gY29uZmly
bWVkIHRoYXQgY2hlY2tfbXNyIHBhdGNoIHdhcyB0byBmaXggYSBidWcgcmVwb3J0IGluDQo+IGd1
ZXN0LCBzbyBpdCdzIG9rIHRvIGRpc2FibGUgaXQgZm9yIHJlYWwgSFcuDQo+IA0KPiBDYzogS2Fu
IExpYW5nIDxrYW4ubGlhbmdAaW50ZWwuY29tPg0KPiBSZXBvcnRlZC1ieTogVG9tIFZhZGVuIDx0
b20udmFkZW5AaHBlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmlyaSBPbHNhIDxqb2xzYUBrZXJu
ZWwub3JnPg0KDQpUaGFua3MgZm9yIGhhbmRsaW5nIHRoZSBwYXRjaC4NCg0KQWNrZWQtYnk6IFRv
bSBWYWRlbiA8dG9tLnZhZGVuQGhwZS5jb20+DQoNCj4gLS0tDQo+ICAgYXJjaC94ODYvZXZlbnRz
L2ludGVsL2NvcmUuYyB8IDggKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZXZlbnRzL2ludGVsL2NvcmUuYyBi
L2FyY2gveDg2L2V2ZW50cy9pbnRlbC9jb3JlLmMNCj4gaW5kZXggNzEwMDFmMDA1YmZlLi4xMTk0
YWU3ZTE5OTIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2V2ZW50cy9pbnRlbC9jb3JlLmMNCj4g
KysrIGIvYXJjaC94ODYvZXZlbnRzL2ludGVsL2NvcmUuYw0KPiBAQCAtMjAsNiArMjAsNyBAQA0K
PiAgICNpbmNsdWRlIDxhc20vaW50ZWwtZmFtaWx5Lmg+DQo+ICAgI2luY2x1ZGUgPGFzbS9hcGlj
Lmg+DQo+ICAgI2luY2x1ZGUgPGFzbS9jcHVfZGV2aWNlX2lkLmg+DQo+ICsjaW5jbHVkZSA8YXNt
L2h5cGVydmlzb3IuaD4NCj4gICANCj4gICAjaW5jbHVkZSAiLi4vcGVyZl9ldmVudC5oIg0KPiAg
IA0KPiBAQCAtNDA1MCw2ICs0MDUxLDEzIEBAIHN0YXRpYyBib29sIGNoZWNrX21zcih1bnNpZ25l
ZCBsb25nIG1zciwgdTY0IG1hc2spDQo+ICAgew0KPiAgIAl1NjQgdmFsX29sZCwgdmFsX25ldywg
dmFsX3RtcDsNCj4gICANCj4gKwkvKg0KPiArCSAqIERpc2FibGUgdGhlIGNoZWNrIGZvciByZWFs
IEhXLCBzbyB3ZSBkb24ndA0KPiArCSAqIG1lc3MgdXAgd2l0aCBwb3RlbnRpb25hbHkgZW5hYmxl
ZCByZWdzLg0KPiArCSAqLw0KPiArCWlmIChoeXBlcnZpc29yX2lzX3R5cGUoWDg2X0hZUEVSX05B
VElWRSkpDQo+ICsJCXJldHVybiB0cnVlOw0KPiArDQo+ICAgCS8qDQo+ICAgCSAqIFJlYWQgdGhl
IGN1cnJlbnQgdmFsdWUsIGNoYW5nZSBpdCBhbmQgcmVhZCBpdCBiYWNrIHRvIHNlZSBpZiBpdA0K
PiAgIAkgKiBtYXRjaGVzLCB0aGlzIGlzIG5lZWRlZCB0byBkZXRlY3QgY2VydGFpbiBoYXJkd2Fy
ZSBlbXVsYXRvcnMNCj4gDQo=
