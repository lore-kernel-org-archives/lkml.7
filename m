Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46837C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FB82067D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="vcP+nFEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfDZNEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:04:36 -0400
Received: from mail-eopbgr70041.outbound.protection.outlook.com ([40.107.7.41]:1293
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbfDZNEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRPm+J7OAdP36EYB0DOvQHbmS8PQtLPYT6JhEObCvwU=;
 b=vcP+nFEj07rMFcacz5XGwSrLGftaktCiAQi1iETnajN9rFeCV+qD6yQ+8Fz0lvfFxQ8rlN5ByAqF+rInDNSEMNLFhm4oX9htFdUDFOdpLlYqUMNMD2l/m4kXhXQTPaMMuhta5VBXTrTaBZ3mUY7MdEFYY/BJ/rgvgaEhi86vo1c=
Received: from AM5PR0501MB2546.eurprd05.prod.outlook.com (10.169.150.142) by
 AM5PR0501MB2435.eurprd05.prod.outlook.com (10.169.149.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Fri, 26 Apr 2019 13:04:29 +0000
Received: from AM5PR0501MB2546.eurprd05.prod.outlook.com
 ([fe80::7492:a69b:3c2:8d2a]) by AM5PR0501MB2546.eurprd05.prod.outlook.com
 ([fe80::7492:a69b:3c2:8d2a%2]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 13:04:29 +0000
From:   Moshe Shemesh <moshe@mellanox.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Saeed Mahameed <saeedm@mellanox.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] devlink: Execute devlink health recover as a
 work
Thread-Topic: [PATCH net-next] devlink: Execute devlink health recover as a
 work
Thread-Index: AQHU+1XYqC6+wlZl5E+t2wQM3bIiOqZNZ9uAgABEHACAAA9igIAAryCA
Date:   Fri, 26 Apr 2019 13:04:29 +0000
Message-ID: <8bb8a789-c189-df07-5d90-fd8f2fa172ca@mellanox.com>
References: <1556189823-5368-1-git-send-email-moshe@mellanox.com>
 <20190425143847.417033ab@cakuba.netronome.com>
 <e540b1c192632dfcf4c0367be133c9ca51f33b43.camel@mellanox.com>
 <20190425193737.131be39f@cakuba.netronome.com>
In-Reply-To: <20190425193737.131be39f@cakuba.netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [84.109.177.105]
x-clientproxiedby: AM0PR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:e6::15) To AM5PR0501MB2546.eurprd05.prod.outlook.com
 (2603:10a6:203:c::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=moshe@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aee9be9b-3484-4ff2-a967-08d6ca47b776
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM5PR0501MB2435;
x-ms-traffictypediagnostic: AM5PR0501MB2435:
x-microsoft-antispam-prvs: <AM5PR0501MB2435F35B669272450A632E0FD93E0@AM5PR0501MB2435.eurprd05.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(31686004)(110136005)(65806001)(6436002)(53936002)(68736007)(478600001)(93886005)(26005)(52116002)(54906003)(65956001)(7736002)(99286004)(31696002)(64126003)(6486002)(305945005)(86362001)(66066001)(8676002)(81166006)(229853002)(81156014)(186003)(6246003)(11346002)(58126008)(6512007)(66476007)(66946007)(64756008)(446003)(476003)(66556008)(66446008)(8936002)(2616005)(73956011)(486006)(36756003)(97736004)(5660300002)(53546011)(316002)(6636002)(14454004)(2906002)(102836004)(76176011)(3846002)(6506007)(386003)(6116002)(65826007)(256004)(14444005)(25786009)(4326008)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0501MB2435;H:AM5PR0501MB2546.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cxzoqWCY+mpRB8SP+5XtyBvHQa49MTHJw7ZlZqppG6hV10Vg9clLK3/UdK7zjHFGZPTgKbdFfxyUEaNiQSkH1NKsFz+57H5TXQc/1mZ7y1uJkg4BKp0dBcf2dgt5NDkLEpZU0jRdI45vsrqrzQWfdQVgYT0THC3qMIKASDiMIIMTRwVhQDHxch5aAPX2pMQdQjuR5Sv7qVQNTu8bEJLvaSgyGyzb1DUEniSke6FmSuKQEb+zNrGUxgS+LD/xsJUkmqxxprwDj8eDLciadgppbFftLHeh3uhXkwwtY1oqvK5B4so1B8jG2QrTDC0D+8aZY59tbvW8NdvkIQK1G9YTbdHbTh0DCzGY2O8rhZmGqethzzvHNN14NRB/DAHFGIHi+Xip7IvRoeiMN7ZR/YkJvPclSCkQiacpY07iULP48vU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94373AECB956DE48B7C32904DE40A772@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee9be9b-3484-4ff2-a967-08d6ca47b776
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 13:04:29.2592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0501MB2435
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMjYvMjAxOSA1OjM3IEFNLCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4gT24gRnJp
LCAyNiBBcHIgMjAxOSAwMTo0MjozNCArMDAwMCwgU2FlZWQgTWFoYW1lZWQgd3JvdGU6DQo+Pj4+
IEBAIC00ODEzLDcgKzQ4MzEsMTEgQEAgc3RhdGljIGludA0KPj4+PiBkZXZsaW5rX25sX2NtZF9o
ZWFsdGhfcmVwb3J0ZXJfcmVjb3Zlcl9kb2l0KHN0cnVjdCBza19idWZmICpza2IsDQo+Pj4+ICAg
CWlmICghcmVwb3J0ZXIpDQo+Pj4+ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4+Pj4gICANCj4+Pj4g
LQlyZXR1cm4gZGV2bGlua19oZWFsdGhfcmVwb3J0ZXJfcmVjb3ZlcihyZXBvcnRlciwgTlVMTCk7
DQo+Pj4+ICsJaWYgKCFyZXBvcnRlci0+b3BzLT5yZWNvdmVyKQ0KPj4+PiArCQlyZXR1cm4gLUVP
UE5PVFNVUFA7DQo+Pj4+ICsNCj4+Pj4gKwlxdWV1ZV93b3JrKGRldmxpbmstPnJlcG9ydGVyc193
cSwgJnJlcG9ydGVyLT5yZWNvdmVyX3dvcmspOw0KPj4+PiArCXJldHVybiAwOw0KPj4+PiAgIH0N
Cj4+Pg0KPj4+IFNvIHRoZSByZWNvdmVyIHVzZXIgc3BhY2UgcmVxdWVzdCB3aWxsIG5vIGxvbmdl
ciByZXR1cm4gdGhlIHN0YXR1cywNCj4+PiBhbmQNCj4+PiBpdCB3aWxsIG5vdCBhY3R1YWxseSB3
YWl0IGZvciB0aGUgcmVjb3ZlciB0byBoYXBwZW4uICBMZWF2aW5nIHVzZXINCj4+PiBwb25kZXJp
bmcgLSBkaWQgdGhlIHJlY292ZXIgcnVuIGFuZCBmYWlsLCBvciBkaWQgaXQgbm9yIGdldCBydW4N
Cj4+PiB5ZXQuLi4NCj4+PiAgICANCj4+DQo+PiB3YWl0X2Zvcl9jb21wbGV0aW9uX2ludGVycnVw
dGlibGVfdGltZW91dCBpcyBtaXNzaW5nIGZyb20gdGhlIGRlc2lnbiA/DQo+IA0KPiBQZXJoYXBz
LCBidXQgSSB0aGluayBpdHMgYmV0dGVyIHRvIGF2b2lkIHRoZSBhc3luYyBleGVjdXRpb24gb2YN
Cj4gdGhlIHJlY292ZXIgYWxsIHRvZ2V0aGVyLiAgUGVyaGFwcyBpdHMgYmV0dGVyIHRvIHJlZmNv
dW50IHRoZQ0KPiByZXBvcnRlcnMgb24gdGhlIGNhbGwgdG8gcmVjb3Zlcl9kb2l0PyAgT3Igc29t
ZSBzdWNoLi4gOikNCj4gDQoNCkkgdHJpZWQgdXNpbmcgcmVmY291bnQgaW5zdGVhZCBvZiBkZXZs
aW5rIGxvY2sgaGVyZS4gQnV0IG9uY2UgSSBnZXQgdG8gDQpyZXBvcnRlciBkZXN0cm95IEkgd2Fp
dCBmb3IgdGhlIHJlZmNvdW50IGFuZCBub3Qgc3VyZSBpZiBJIHNob3VsZCANCnJlbGVhc2UgdGhl
IHJlcG9ydGVyIGFmdGVyIHNvbWUgdGltZW91dCBvciBoYXZlIGVuZGxlc3Mgd2FpdCBmb3IgDQpy
ZWZjb3VudC4gQm90aCBvcHRpb25zIHNlZW0gbm90IGdvb2QuDQo=
