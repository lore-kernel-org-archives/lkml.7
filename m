Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F01C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF9E2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AILgxV9K";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UCD/kRLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfDXBAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:00:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51158 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726844AbfDXBAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:00:25 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3O0wkUF000566;
        Tue, 23 Apr 2019 17:59:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=dX8U2iZGvTQbQNS3Nk0vetiNbQ8DOkB8Mc95vHOeMu4=;
 b=AILgxV9KO5PUD2KgdXPoxnKNQiTCNW6giB3PSrR3awJhA0y80PgrVuYBf5If63vOmO89
 vH5MMpbFfOmPS6p+imDR2f/kXCN/yk2vfoEtldqDIrW6Sz8lB9bar7JjWmqUs66tXHic
 tlUlDXcsevp7ePCWpTAliFtQNSDEssK9CsI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s24kejgbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 23 Apr 2019 17:59:55 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 23 Apr 2019 17:59:54 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 23 Apr 2019 17:59:53 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 23 Apr 2019 17:59:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dX8U2iZGvTQbQNS3Nk0vetiNbQ8DOkB8Mc95vHOeMu4=;
 b=UCD/kRLOIxWN5802SmuxNKnJYFkUSu8lluzqFT1DtfP7vsIuKgP8lB+RNn2zWhmPngrz+RZi1P2eGWh2+b2uvK/n8bOCNZY3bMBgQ1Ix2AG7v3aw+V/KU700K/s139HOh0ZFwCd/UwQXAcwWGZqbycFzmIgelZZ1RsmK3DyXaRQ=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1213.namprd15.prod.outlook.com (10.175.2.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Wed, 24 Apr 2019 00:59:52 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::9ccc:f6fa:40e2:f1cd]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::9ccc:f6fa:40e2:f1cd%10]) with mapi id 15.20.1813.017; Wed, 24 Apr
 2019 00:59:52 +0000
From:   Tao Ren <taoren@fb.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     "David S . Miller" <davem@davemloft.net>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Samuel Mendoza-Jonas" <sam@mendozajonas.com>,
        Joel Stanley <joel@jms.id.au>,
        "Andrew Jeffery" <andrew@aj.id.au>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH net 1/2] net: add eth_addr_inc in etherdevice.h
Thread-Topic: [PATCH net 1/2] net: add eth_addr_inc in etherdevice.h
Thread-Index: AQHU+iXBL3XM+2QubECFPb9Ujl9LnqZKYHYAgAAdRQA=
Date:   Wed, 24 Apr 2019 00:59:52 +0000
Message-ID: <2b3935f9-fbf9-6baa-570c-dcd6382518c4@fb.com>
References: <20190423224138.1295-1-taoren@fb.com>
 <20190423161502.5d3e9c36@cakuba.netronome.com>
In-Reply-To: <20190423161502.5d3e9c36@cakuba.netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0060.namprd14.prod.outlook.com
 (2603:10b6:300:81::22) To MWHPR15MB1216.namprd15.prod.outlook.com
 (2603:10b6:320:23::18)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 411ba574-617c-43c0-79fb-08d6c8502830
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1213;
x-ms-traffictypediagnostic: MWHPR15MB1213:
x-microsoft-antispam-prvs: <MWHPR15MB121334524AE2A2A462BA0B84B23C0@MWHPR15MB1213.namprd15.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(39860400002)(376002)(199004)(189003)(46003)(81156014)(64126003)(8676002)(6916009)(5660300002)(31686004)(81166006)(65826007)(102836004)(6512007)(6116002)(6506007)(186003)(6436002)(53546011)(386003)(8936002)(58126008)(53936002)(476003)(305945005)(486006)(86362001)(68736007)(6486002)(36756003)(25786009)(76176011)(7736002)(52116002)(14454004)(6246003)(446003)(4326008)(2616005)(99286004)(316002)(11346002)(7416002)(97736004)(71190400001)(256004)(478600001)(65956001)(73956011)(65806001)(229853002)(66556008)(64756008)(66476007)(66946007)(54906003)(66446008)(31696002)(71200400001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1213;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iJAN046ftr92Ob3TEixJT+/Aw5NEI2+OejOif3unKqd4HREzylOEIXcZ8Ekg3WaoDPt2alp0wnzQnwjZmVbXw3KdQe6PXf2aqPooVAZ3Sv4NPqz93BA2by5UvdiCU9AFIRQaEuzeS7vMCy6vIn7b3GWAhWy4RWix3LRX7ZIyV/i4G8FCqziO27YiZF7bZKy0bgq7dAeH+/6EXaqMpPcpRRpWF5jAQ4TBaw6A6Krj0lYCAGVaXNXDCRAXsTEvsVHSORS9wl4QZd83ft+rKWywTWLiHN5TTjMqgVA8bnuItCuSupQhyywMJWw/bj80Y448NIvj+kK41Sm7IoXDPO6vI30BagDS2yWIfVHi9yAUzPoxG9htJhwqhzeQNyT8yxl3z60bBAFUswC2cW5zgeO9aR2HmuQhI+gX+2Eb56AGAL8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F12C2F2446EC054B9738BBB1AC363A9D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 411ba574-617c-43c0-79fb-08d6c8502830
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 00:59:52.0711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1213
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yMy8xOSA0OjE1IFBNLCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4gT24gVHVlLCAyMyBB
cHIgMjAxOSAyMjo0MTo1NiArMDAwMCwgVGFvIFJlbiB3cm90ZToNCj4+IEFkZCBldGhfYWRkcl9p
bmMgZnVuY3Rpb24gaW4gZXRoZXJkZXZpY2UuaCB0byBpbmNyZW1lbnQgTUFDIGFkZHJlc3MuIE9u
ZQ0KPj4gb2YgdGhlIHVzZSBjYXNlcyBpcyBpbiBuY3NpIHN0YWNrLCB3aGVyZSB0aGUgaG9zdCdz
IE1BQyBhZGRyZXNzIG5lZWRzIHRvDQo+PiBiZSBpbmNyZW1lbnRlZCB0byBnZXQgQk1DJ3MgTUFD
IGFkZHJlc3MuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVGFvIFJlbiA8dGFvcmVuQGZiLmNvbT4N
Cj4gDQo+IFBsZWFzZSBzcXVhc2ggdGhpcyBwYXRjaCB3aXRoIHRoZSBuZXh0IG9uZSwgSU1ITyB0
aGV5IGZvcm0gYSBzaW5nbGUNCj4gbG9naWNhbCBjaGFuZ2UgdG9nZXRoZXIuDQoNClN1cmUuIFdp
bGwgc2VuZCBvdXQgdXBkYXRlZCBwYXRjaCBzb29uLg0KDQo+PiAgaW5jbHVkZS9saW51eC9ldGhl
cmRldmljZS5oIHwgMTMgKysrKysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNl
cnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZXRoZXJkZXZpY2Uu
aCBiL2luY2x1ZGUvbGludXgvZXRoZXJkZXZpY2UuaA0KPj4gaW5kZXggZTJmM2IyMWNkNzJhLi5k
NDhlM2E3MjRjNTQgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2V0aGVyZGV2aWNlLmgN
Cj4+ICsrKyBiL2luY2x1ZGUvbGludXgvZXRoZXJkZXZpY2UuaA0KPj4gQEAgLTQ0OCw2ICs0NDgs
MTkgQEAgc3RhdGljIGlubGluZSB2b2lkIGV0aF9hZGRyX2RlYyh1OCAqYWRkcikNCj4+ICAJdTY0
X3RvX2V0aGVyX2FkZHIodSwgYWRkcik7DQo+PiAgfQ0KPj4gIA0KPj4gKy8qKg0KPj4gKyAqIGV0
aF9hZGRyX2luYyAtIEluY3JlbWVudCB0aGUgZ2l2ZW4gTUFDIGFkZHJlc3MNCj4+ICsgKg0KPj4g
KyAqIEBhZGRyOiBQb2ludGVyIHRvIGEgc2l4LWJ5dGUgYXJyYXkgY29udGFpbmluZyBFdGhlcm5l
dCBhZGRyZXNzIHRvIGluY3JlbWVudA0KPiANCj4gUGxlYXNlIHNlZTogIERvY3VtZW50YXRpb24v
ZG9jLWd1aWRlL2tlcm5lbC1kb2MucnN0DQo+IA0KPiBIZXJlIHdlIG5lZWQ6DQo+ICAtICIoKSIg
YWZ0ZXIgZnVuY3Rpb24gbmFtZTsNCj4gIC0gbm8gZXh0cmEgbGluZSBiZXR3ZWVuIGZ1bmN0aW9u
IG5hbWUgYW5kIGFyZ3VtZW50IGRlc2NyaXB0aW9uLg0KDQpUaGFuayB5b3UgZm9yIHBvaW50aW5n
IGl0IG91dCAoSSBkaWRuJ3Qga25vdyB0aGUgZG9jLWd1aWRlKS4gR2l2ZW4gSSBjb3BpZWQgdGhl
IGZ1bmN0aW9uIGNvbW1lbnQgZnJvbSBldGhfYWRkcl9kZWMoKSwgSSB3aWxsIGFsc28gZml4IHRo
ZSBmb3JtYXQgZm9yIGV0aF9hZGRyX2V0aCgpIHRoZW4uDQoNCkJUVywgIigpIiBpcyBtaXNzaW5n
IGZyb20gYWxsIHRoZSBvdGhlciBmdW5jdGlvbnMnIGNvbW1lbnQgaW4gZXRoZXJkZXZpY2UuaCwg
c28gbWF5YmUgd2Ugc2hvdWxkIGZpeCB0aGF0IGluIGEgc2VwYXJhdGUgcGF0Y2g/DQoNCg0KVGhh
bmtzLA0KDQotIFRhbw0K
