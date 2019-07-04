Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D0FC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002C2218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OL1OYGMI";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="WX+XOIAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfGDQbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:31:55 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:61778 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbfGDQbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:31:55 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x64GTrqE023703;
        Thu, 4 Jul 2019 09:31:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=0K7zhy1hDxTeusOs2cxysOrqSKi6DuMYXg0c8E42mqQ=;
 b=OL1OYGMIQ33UROVcwQPzd/8wuyOzO47K6qV0Eae7NyTUzeGfcMJtk778HF3MaIUCgis/
 +OAj1jHk9eIm2W6qUl08mH9l/49DpzQWu5o5PssFnstY6yizwWWJzvtvoJ1DDYDjgNkC
 gRTgfFqHDqAEVONdcJAFbwHBKosgbwLZu5sdHCIGrw5jIcSuXYed7m3QnsunW6d7+kRY
 evmbODs+7vzHylYqO93JfaDykcZ0E5hbaDSnh4rp8/RTiUIddXUoA9vhh1NKW0hxtMpT
 JB3xkZ0eKIq5LsVf6LMn8BO6EcatAXHWi6OYn8G2aG0xaXYYRX6c1k+nq8kZq6/8AS62 Kw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2thjyr8dy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Jul 2019 09:31:41 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 4 Jul
 2019 09:31:40 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.55) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 4 Jul 2019 09:31:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K7zhy1hDxTeusOs2cxysOrqSKi6DuMYXg0c8E42mqQ=;
 b=WX+XOIAIqsfgP8Ifo2jsK1cOK4gA/TRt84xxoInNPYCFBVGQbhmN7ImxqIXPLe3/JI+4d3Z6b+ZA17WF7lnsjKom5iDAI3ZLRBmKzwBI2TOacIG+wS1McgJ0MVV6T+aSZfpOwtRcZ8KXKnWCXS0zR4DLVL3yKI0Aiv2YC6O9C+I=
Received: from DM6PR18MB3051.namprd18.prod.outlook.com (20.179.48.144) by
 DM6PR18MB2521.namprd18.prod.outlook.com (20.179.105.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 4 Jul 2019 16:31:35 +0000
Received: from DM6PR18MB3051.namprd18.prod.outlook.com
 ([fe80::9ce3:7d0a:4f56:fdcc]) by DM6PR18MB3051.namprd18.prod.outlook.com
 ([fe80::9ce3:7d0a:4f56:fdcc%7]) with mapi id 15.20.2052.010; Thu, 4 Jul 2019
 16:31:34 +0000
From:   Shijith Thotton <sthotton@marvell.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Julien Thierry <julien.thierry@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Jayachandran Chandrasekharan Nair" <jnair@marvell.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Jan Glauber <jglauber@marvell.com>,
        Robert Richter <rrichter@marvell.com>
Subject: Re: [PATCH] genirq: update irq stats from NMI handlers
Thread-Topic: [PATCH] genirq: update irq stats from NMI handlers
Thread-Index: AQHVMiAiVz/XkkYfRk2+vKGjBsT7x6a6C8+AgAA4f4CAAF/nAIAAA1oA
Date:   Thu, 4 Jul 2019 16:31:34 +0000
Message-ID: <47489142-b040-ec54-a1ac-46f0a8799ed9@marvell.com>
References: <1562214115-14022-1-git-send-email-sthotton@marvell.com>
 <6adfb296-50f1-9efb-0840-cc8732b8ebf9@arm.com>
 <a4ce3800-22f4-72dc-6ff8-75dfed1c377b@marvell.com>
 <alpine.DEB.2.21.1907041818360.1802@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907041818360.1802@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::20) To DM6PR18MB3051.namprd18.prod.outlook.com
 (2603:10b6:5:162::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0932164-297c-426b-2b16-08d7009d1418
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR18MB2521;
x-ms-traffictypediagnostic: DM6PR18MB2521:
x-microsoft-antispam-prvs: <DM6PR18MB252125BCE7C38C9FCEA6B0FFD9FA0@DM6PR18MB2521.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(189003)(199004)(6512007)(6116002)(3846002)(54906003)(76176011)(478600001)(52116002)(5660300002)(107886003)(31696002)(316002)(71190400001)(71200400001)(66066001)(68736007)(256004)(86362001)(6916009)(6506007)(186003)(53546011)(66556008)(6486002)(8936002)(14454004)(31686004)(102836004)(26005)(25786009)(2616005)(476003)(11346002)(6436002)(386003)(4326008)(486006)(2906002)(53936002)(81156014)(81166006)(66946007)(73956011)(99286004)(229853002)(66446008)(305945005)(7736002)(8676002)(64756008)(66476007)(36756003)(446003)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR18MB2521;H:DM6PR18MB3051.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yXo/dwHyipo9yJUn5lD7eZqP5+Dk7a/E5Ti4rxDw81lLejNjDgohXcZhcDkh6df6rRvQztAWBTqso3/AGvQZ5PFWDneC9GTYq78qTQ2WmBYe4HASQmOuXEkt9yY7dK3TZ+OhK506s+brVZnWPtFxHIWGgvzpAZjWo154xsa+KtWi+OJWGPONShxLZszRq9OjxFOoyTcVdoLxdf6Cfndv3JYZ0/gI4kp1h1YYoUruJixQvDwEy4EvlBtRBW+XroJ4C1IOU7KUdIlfGNVqb2iyP0v5UBCTxawHwN+IY2f8suV6hJrhuQDu/QC7O4fm4hOYAQz99d4DF5MiZ5Vm1gLE1agqyoEarn/DeO60MqAulp1OZ1ZL0z36ukDBw1uWBYFc0PEgMq/ZC3RtllLGnrQR/rJrMnxAtwXUrsVUvXgq62A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA60FF3073271D4E8421B16481D26CB5@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e0932164-297c-426b-2b16-08d7009d1418
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 16:31:34.7185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sthotton@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2521
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDcvNC8xOSA5OjE5IEFNLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+IE9uIFRodSwg
NCBKdWwgMjAxOSwgU2hpaml0aCBUaG90dG9uIHdyb3RlOg0KPj4gT24gNy80LzE5IDEyOjEzIEFN
LCBKdWxpZW4gVGhpZXJyeSB3cm90ZToNCj4+PiBMb29raW5nIGF0IGhhbmRsZV9wZXJjcHVfaXJx
KCksIEkgdGhpbmsgdGhpcyBtaWdodCBiZSBhY2NlcHRhYmxlLiBCdXQNCj4+PiBkb2VzIGl0IG1h
a2Ugc2Vuc2UgdG8gb25seSBoYXZlIGtzdGF0cyBmb3IgcGVyY3B1IE5NSXM/DQo+Pj4NCj4+DQo+
PiBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8gaGF2ZSBzdGF0cyBmb3IgYm90aC4NCj4+DQo+PiBoYW5k
bGVfZmFzdGVvaV9ubWkoKSBjYW4gdXNlIF9fa3N0YXRfaW5jcl9pcnFzX3RoaXNfY3B1KCkgaWYg
YmVsb3cNCj4+IGNoYW5nZSBjYW4gYmUgYWRkZWQgdG8ga3N0YXRfaXJxc19jcHUoKS4NCj4+DQo+
PiBkaWZmIC0tZ2l0IGEva2VybmVsL2lycS9pcnFkZXNjLmMgYi9rZXJuZWwvaXJxL2lycWRlc2Mu
Yw0KPj4gaW5kZXggYTkyYjMzNTkzYjhkLi45NDg0ZTg4ZGFiYzIgMTAwNjQ0DQo+PiAtLS0gYS9r
ZXJuZWwvaXJxL2lycWRlc2MuYw0KPj4gKysrIGIva2VybmVsL2lycS9pcnFkZXNjLmMNCj4+IEBA
IC05NTAsNiArOTUwLDExIEBAIHVuc2lnbmVkIGludCBrc3RhdF9pcnFzX2NwdSh1bnNpZ25lZCBp
bnQgaXJxLCBpbnQgY3B1KQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAqcGVyX2NwdV9w
dHIoZGVzYy0+a3N0YXRfaXJxcywgY3B1KSA6IDA7DQo+PiAgICB9DQo+Pg0KPj4gK3N0YXRpYyBi
b29sIGlycV9pc19ubWkoc3RydWN0IGlycV9kZXNjICpkZXNjKQ0KPj4gK3sNCj4+ICsgICAgICAg
cmV0dXJuIGRlc2MtPmlzdGF0ZSAmIElSUVNfTk1JOw0KPj4gK30NCj4+ICsNCj4+ICAgIC8qKg0K
Pj4gICAgICoga3N0YXRfaXJxcyAtIEdldCB0aGUgc3RhdGlzdGljcyBmb3IgYW4gaW50ZXJydXB0
DQo+PiAgICAgKiBAaXJxOiAgICAgICBUaGUgaW50ZXJydXB0IG51bWJlcg0KPj4gQEAgLTk2Nyw3
ICs5NzIsOCBAQCB1bnNpZ25lZCBpbnQga3N0YXRfaXJxcyh1bnNpZ25lZCBpbnQgaXJxKQ0KPj4g
ICAgICAgICAgIGlmICghZGVzYyB8fCAhZGVzYy0+a3N0YXRfaXJxcykNCj4+ICAgICAgICAgICAg
ICAgICAgIHJldHVybiAwOw0KPj4gICAgICAgICAgIGlmICghaXJxX3NldHRpbmdzX2lzX3Blcl9j
cHVfZGV2aWQoZGVzYykgJiYNCj4+IC0gICAgICAgICAgICFpcnFfc2V0dGluZ3NfaXNfcGVyX2Nw
dShkZXNjKSkNCj4+ICsgICAgICAgICAgICFpcnFfc2V0dGluZ3NfaXNfcGVyX2NwdShkZXNjKSAm
Jg0KPj4gKyAgICAgICAgICAgIWlycV9pc19ubWkoZGVzYykpDQo+PiAgICAgICAgICAgICAgIHJl
dHVybiBkZXNjLT50b3RfY291bnQ7DQo+Pg0KPj4gICAgICAgICAgIGZvcl9lYWNoX3Bvc3NpYmxl
X2NwdShjcHUpDQo+Pg0KPj4NCj4+IFRob21hcywNCj4+IFBsZWFzZSBzdWdnZXN0IGEgYmV0dGVy
IHdheSBpZiBhbnkuDQo+IA0KPiBMb29rcyBnb29kLg0KPiANCg0KVGhhbmtzIFRob21hcy4gV2ls
bCBzaGFyZSB2MiB3aXRoIHRoZSBjaGFuZ2VzLg0KDQpUaGFua3MsDQpTaGlqaXRoDQo=
