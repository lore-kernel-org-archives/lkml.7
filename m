Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A76C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821732147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Q504NqZ+";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Gf0jJu2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfCLTiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:38:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58064 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726685AbfCLTiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 15:38:09 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2CJZROp017996;
        Tue, 12 Mar 2019 12:38:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=XoZ2pGrth398PWBphXT5JDu9O53Gf9+HALHB0mb+sPc=;
 b=Q504NqZ+1PIjnRS0ydqoT9u93njA6vVUuw8TOHhctk5Q3lFH/hAmpYEcJ2ziRbPy7Gfn
 60Fipz5gShbJJqIakAbsCHkG4cq4193ro3+a8o5DgBUCbsCVG59buVpXS6M2rDJ52FX9
 H/bqYsTXoJMj9m5YCRjNhbhrm2oP5osYofY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r6g380swq-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Mar 2019 12:37:59 -0700
Received: from frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 12 Mar 2019 12:37:32 -0700
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 12 Mar 2019 12:37:32 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Mar 2019 12:37:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoZ2pGrth398PWBphXT5JDu9O53Gf9+HALHB0mb+sPc=;
 b=Gf0jJu2CYGIXdkNzlf3U4iDjU00vhsrntUJZW9nv3nI0DocSlH/Mz0dlBTCvXiq825NVXnRIGh18FhywzdLv/ZQGzPXcouYjvgImTH2Ckp1bPRyOmr5pc+sd9S4Jh32X5vu1aX3BdHP0g5ipxQ7wl7lrtK4IzCrCeUxZPbpH7Mk=
Received: from MWHPR15MB1264.namprd15.prod.outlook.com (10.175.3.14) by
 MWHPR15MB1903.namprd15.prod.outlook.com (10.174.100.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.20; Tue, 12 Mar 2019 19:37:30 +0000
Received: from MWHPR15MB1264.namprd15.prod.outlook.com
 ([fe80::cc6:7ec2:94ef:f8cb]) by MWHPR15MB1264.namprd15.prod.outlook.com
 ([fe80::cc6:7ec2:94ef:f8cb%9]) with mapi id 15.20.1709.011; Tue, 12 Mar 2019
 19:37:30 +0000
From:   Calvin Owens <calvinowens@fb.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
CC:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Calvin Owens <calvinowens@fb.com>
Subject: Re: [PATCH] tpm: Make timeout logic simpler and more robust
Thread-Topic: [PATCH] tpm: Make timeout logic simpler and more robust
Thread-Index: AQHU2GXGLeYW3Qpbpky5KjnMPwFs0aYHJAWAgAFBNwA=
Date:   Tue, 12 Mar 2019 19:37:30 +0000
Message-ID: <20190312193702.GA4148@Haydn>
References: <358e89ed2b766d51b5f57abf31ab7a925ac63379.1552348123.git.calvinowens@fb.com>
 <1552350463.23859.8.camel@HansenPartnership.com>
In-Reply-To: <1552350463.23859.8.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1301CA0018.namprd13.prod.outlook.com
 (2603:10b6:301:29::31) To MWHPR15MB1264.namprd15.prod.outlook.com
 (2603:10b6:320:24::14)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::ce7e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7aff22f-d815-4c78-a438-08d6a7222a28
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1903;
x-ms-traffictypediagnostic: MWHPR15MB1903:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1903;20:AP+sJ3ZLeMq9ZDKADtVaoKt6NSzUiTOFcs0J3Nt0XsXlRFjwoog1W2YdoPDyWkAQlWwEp8HGq3rTOLAhROXO3vws744/WcYh1Lng726MZXIH75HUbRCuAfHWhP6PcDbpEoDBxaj9c5Lo6Dhtcq8+Xg9EULR6U6Umshs3j8616Vs=
x-microsoft-antispam-prvs: <MWHPR15MB1903C0D35E022628B169CFEDCE490@MWHPR15MB1903.namprd15.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(376002)(39860400002)(366004)(396003)(346002)(199004)(189003)(86362001)(99286004)(256004)(14444005)(386003)(6506007)(81156014)(106356001)(4326008)(105586002)(6116002)(25786009)(53546011)(33656002)(33716001)(316002)(478600001)(8676002)(81166006)(6436002)(8936002)(2906002)(5660300002)(6246003)(102836004)(14454004)(9686003)(97736004)(305945005)(53936002)(186003)(6486002)(71200400001)(476003)(6916009)(446003)(54906003)(46003)(486006)(76176011)(6512007)(7736002)(1076003)(71190400001)(68736007)(52116002)(229853002)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1903;H:MWHPR15MB1264.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wjq8BaytfUPBxgxvxUkhX4B3JVoB9kUHk80dbJ2ofCpucucIsxNypqVDbrv6Vduusu9P85oAW/W/aP0+SBvp7v0PKJIpWmGpm47JPAMmaVIUQrUTZegAQpwd+bf8UrR91p87MEBQwMCFqVYvnoggVSwuPLzd9QyjP75iGtHLNlQJMr779KW9qWLQjT+xfYL+OAnDJjeG2U5ZyXG1Sqxd6JaJvT3iL+jh7kBhjVTlFwMvzDE9qf0NnrrPpkehvDFmA8tkHJdPKMS0cutMKHzSadX/7sWRYoM2a1IYrRxTCM7YL20xg7Fn5im7DOfgUHpaFezH2uAprqVbqTzYm2CLPPS1uDUxsisMFpjEVdOlxvOdtvW3Rpsu2GsAucP+RmbDVOtYahg7mT/61iw1pqG51ozAHHfWZ4MXYVxA1+rNKKI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84E781199727C04A833500AE6EF2FFCD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c7aff22f-d815-4c78-a438-08d6a7222a28
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 19:37:30.1570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1903
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uZGF5IDAzLzExIGF0IDE3OjI3IC0wNzAwLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6DQo+
IE9uIE1vbiwgMjAxOS0wMy0xMSBhdCAxNjo1NCAtMDcwMCwgQ2FsdmluIE93ZW5zIHdyb3RlOg0K
PiA+IGUncmUgaGF2aW5nIGxvdHMgb2YgcHJvYmxlbXMgd2l0aCBUUE0gY29tbWFuZHMgdGltaW5n
IG91dCwgYW5kIHdlJ3JlDQo+ID4gc2VlaW5nIHRoZXNlIHByb2JsZW1zIGFjcm9zcyBsb3RzIG9m
IGRpZmZlcmVudCBoYXJkd2FyZSAoYm90aCB2MS92MikuDQo+ID4gDQo+ID4gSSBpbnN0cnVtZW50
ZWQgdGhlIGRyaXZlciB0byBjb2xsZWN0IGxhdGVuY3kgZGF0YSwgYnV0IEkgd2Fzbid0IGFibGUN
Cj4gPiB0byBmaW5kIGFueSBzcGVjaWZpYyB0aW1lb3V0IHRvIGZpeDogaXQgc2VlbXMgbGlrZSBt
YW55IG9mIHRoZW0gYXJlDQo+ID4gdG9vIGFnZ3Jlc3NpdmUuIFNvIEkgdHJpZWQgcmVwbGFjaW5n
IGFsbCB0aGUgdGltZW91dCBsb2dpYyB3aXRoIGENCj4gPiBzaW5nbGUgdW5pdmVyc2FsIGxvbmcg
dGltZW91dCwgYW5kIGZvdW5kIHRoYXQgbWFrZXMgb3VyIFRQTXMgMTAwJQ0KPiA+IHJlbGlhYmxl
Lg0KPiA+IA0KPiA+IEdpdmVuIHRoYXQgdGhpcyB0aW1lb3V0IGxvZ2ljIGlzIHZlcnkgY29tcGxl
eCwgcHJvYmxlbWF0aWMsIGFuZA0KPiA+IGFwcGVhcnMgdG8gc2VydmUgbm8gcmVhbCBwdXJwb3Nl
LCBJIHByb3Bvc2Ugc2ltcGx5IGRlbGV0aW5nIGFsbCBvZg0KPiA+IGl0Lg0KPiANCj4gIm5vIHJl
YWwgcHVycG9zZSIgaXMgYSBiaXQgc3Ryb25nIGdpdmVuIHRoYXQgYWxsIHRoZXNlIHRpbWVvdXRz
IGFyZQ0KPiBzdGFuZGFyZHMgbWFuZGF0ZWQuICANCg0KU3VyZSwgaW4gZmFpcm5lc3MgSSBzYWlk
ICJhcHBlYXJzIHRvIiA7KQ0KDQpXZSB0ZXN0ZWQgdGhpcyBvbiByb3VnaGx5IGEgaHVuZHJlZCBt
YWNoaW5lcyB3aXRoIGEgdmFyaWV0eSBvZiBoYXJkd2FyZSwNCnRoZXkgd2VyZSBmbGFreSBiZWZv
cmUgYW5kIGVzc2VudGlhbGx5IHBlcmZlY3RseSByZWxpYWJsZSBhZnRlciB0aGlzDQpwYXRjaC4g
U28gdGhhdCdzIHdoZXJlIEknbSBjb21pbmcgZnJvbSBoZXJlLg0KDQo+IFRoZSBwdXJwb3NlIHN0
YXRlZCBieSB0aGUgc3RhbmRhcmRzIGlzIHRoYXQgdGhlcmUgbmVlZHMgdG8gYmUgYSB3YXkgb2YN
Cj4gZGlmZmVyZW50aWF0aW5nIHRoZSBUUE0gY3Jhc2hlZCBmcm9tIHRoZSBUUE0gaXMgdGFraW5n
IGEgdmVyeSBsb25nDQo+IHRpbWUgdG8gcmVzcG9uZC4gIEZvciBhIG5vcm1hbGx5IGZ1bmN0aW9u
aW5nIFRQTSBpdCBsb29rcyBjb21wbGV4IGFuZA0KPiB1bm5lY2Vzc2FyeSwgYnV0IGZvciBhIG1h
bGZ1bmN0aW9uaW5nIG9uZSBpdCdzIGEgbGlmZXNhdmVyLg0KDQpEb2VzIGdldHRpbmcgLUVXSEFU
RVZFUiBzb21lIDItMyBzZWNvbmRzIG1vcmUgcXVpY2tseSByZWFsbHkgbWFrZSBtdWNoDQpvZiBh
IGRpZmZlcmVuY2U/IFRoYXQncyBhbGwgd2UncmUgdGFsa2luZyBhYm91dCBjaGFuZ2luZyBoZXJl
LCByaWdodD8NCg0KPiBDb3VsZCB5b3UgZmlyc3QgY2hlY2sgaXQncyBub3QgYSBwcm9ibGVtIHdl
IGludHJvZHVjZWQgd2l0aCBvdXIgcG9sbGluZw0KPiBjaGFuZ2VzPyAgTXkgbnV2b3RvbiBzdGls
bCBkb2Vzbid0IHdvcmsgcHJvcGVybHkgd2l0aCB0aGUgZGVmYXVsdCBwb2xsDQo+IHRpbWluZ3Mg
YnV0IGl0IHdvcmtzIGZsYXdsZXNzbHkgaWYgSSB1c2UgdGhlIHBhdGNoIGJlbG93LiAgSSB0aGlu
ayBteQ0KPiBudXZvdG9uIGlzIGEgYml0IG91dCBvZiBzcGVjIChpdCdzIGEgdmVyeSBlYXJseSBt
b2RlbCB0aGF0IHdhcyBzb2Z0d2FyZQ0KPiB1cGdyYWRlZCBmcm9tIDEuMiB0byAyLjApIGJlY2F1
c2Ugbm8tb25lIGVsc2Ugb24gdGhlIGxpc3Qgc2VlbXMgdG8gc2VlDQo+IHRoZSBwcm9ibGVtcyBJ
IHNlZSwgYnV0IHBlcmhhcHMgeW91IGFyZS4NCg0KSSBkaWQgY29uc2lkZXIgdGhlIHBvbGxpbmcg
Y2hhbmdlcy4gTXkgdGhpbmtpbmcgd2FzIHRoYXQsIHNpbmNlIHRoZSBwb2xsDQpsb29wcyBJIHdh
cyBzZWVpbmcgdGltZSBvdXQgYXJlIGFsbCBnYXRlZCBvbiB0aW1lX2JlZm9yZSgpLCBpdCB3b3Vs
ZA0Kb25seSBwb3RlbnRpYWxseSBjaGFuZ2UgaG93IG11Y2ggdGhlIGZpbmFsIHBvbGwgb3ZlcnJ1
bnMgdGhlIHRhcmdldA0KamlmZmllcywgYW5kIHdhc24ndCBhcyBsaWtlbHkgdG8gaGVscCBhcyBj
aGFuZ2luZyB0aGUgdGltZW91dHMNCnRoZW1zZWx2ZXMuDQoNClRoZSB0aGVvcnkgYWJvdXQgcG9r
aW5nIGl0IHRvbyBhZ2dyZXNzaXZlbHkgbWFraW5nIGl0IGZhbGwgb2ZmIHRoZSBidXMNCmRlZmlu
aXRlbHkgbWFrZXMgc2Vuc2UsIGJ1dCB0aGUgc3VjY2VzcyBvZiB0aGlzICJ1bml2ZXJzYWwgdGlt
ZW91dCINCmFwcHJvYWNoIHN1Z2dlc3RzIHRvIG1lIHRoYXQgdGhlIHRpbWVvdXRzIHRoZW1zZWx2
ZXMgYXJlIHRoZSByb290DQpwcm9ibGVtIHdpdGggdGhlIGZsYWtpbmVzcyB3ZSdyZSBzZWVpbmcg
aW4gcHJvZHVjdGlvbi4NCg0KVGhhbmtzLA0KQ2FsdmluDQogDQo+IEphbWVzDQo+IA0KPiAtLS0N
Cj4gDQo+IEZyb20gMjQ5ZDYwYTlmYWZhODYzODQzM2U1NDViNTBkYWI2OTg3MzQ2Y2IyNiBNb24g
U2VwIDE3IDAwOjAwOjAwIDIwMDENCj4gRnJvbTogSmFtZXMgQm90dG9tbGV5IDxKYW1lcy5Cb3R0
b21sZXlASGFuc2VuUGFydG5lcnNoaXAuY29tPg0KPiBEYXRlOiBXZWQsIDExIEp1bCAyMDE4IDEw
OjExOjE0IC0wNzAwDQo+IFN1YmplY3Q6IFtQQVRDSF0gdHBtLmg6IGluY3JlYXNlIHBvbGwgdGlt
aW5ncyB0byBmaXggdHBtX3RpcyByZWdyZXNzaW9uDQo+IA0KPiB0cG1fdGlzIHJlZ3Jlc3NlZCBy
ZWNlbnRseSB0byB0aGUgcG9pbnQgd2hlcmUgdGhlIFRQTSBiZWluZyBkcml2ZW4gYnkNCj4gaXQg
ZmFsbHMgb2ZmIHRoZSBidXMgYW5kIGNhbm5vdCBiZSBjb250YWN0ZWQgYWZ0ZXIgc29tZSBob3Vy
cyBvZiB1c2UuDQo+IFRoaXMgaXMgdGhlIGZhaWx1cmUgdHJhY2U6DQo+IA0KPiBqZWpiQGphcnZp
czp+PiBkbWVzZ3xncmVwIHRwbQ0KPiBbICAgIDMuMjgyNjA1XSB0cG1fdGlzIE1TRlQwMTAxOjAw
OiAyLjAgVFBNIChkZXZpY2UtaWQgMHhGRSwgcmV2LWlkIDIpDQo+IFsxNDU2Ni42MjY2MTRdIHRw
bSB0cG0wOiBPcGVyYXRpb24gVGltZWQgb3V0DQo+IFsxNDU2Ni42MjY2MjFdIHRwbSB0cG0wOiB0
cG0yX2xvYWRfY29udGV4dDogZmFpbGVkIHdpdGggYSBzeXN0ZW0gZXJyb3IgLTYyDQo+IFsxNDU2
OC42MjY2MDddIHRwbSB0cG0wOiB0cG1fdHJ5X3RyYW5zbWl0OiB0cG1fc2VuZDogZXJyb3IgLTYy
DQo+IFsxNDU3MC42MjY1OTRdIHRwbSB0cG0wOiB0cG1fdHJ5X3RyYW5zbWl0OiB0cG1fc2VuZDog
ZXJyb3IgLTYyDQo+IFsxNDU3MC42MjY2MDVdIHRwbSB0cG0wOiB0cG0yX2xvYWRfY29udGV4dDog
ZmFpbGVkIHdpdGggYSBzeXN0ZW0gZXJyb3IgLTYyDQo+IFsxNDU3Mi42MjY1MjZdIHRwbSB0cG0w
OiB0cG1fdHJ5X3RyYW5zbWl0OiB0cG1fc2VuZDogZXJyb3IgLTYyDQo+IFsxNDU3Ny43MTA0NDFd
IHRwbSB0cG0wOiB0cG1fdHJ5X3RyYW5zbWl0OiB0cG1fc2VuZDogZXJyb3IgLTYyDQo+IC4uLg0K
PiANCj4gVGhlIHByb2JsZW0gaXMgY2F1c2VkIGJ5IGEgY2hhbmdlIHRoYXQgY2F1c2VkIHVzIHRv
IHBva2UgdGhlIFRQTSBmYXINCj4gbW9yZSBvZnRlbiB0byBzZWUgaWYgaXQncyByZWFkeS4gIEFw
cGFyZW50bHkgc29tZXRoaW5nIGFib3V0IHRoZSBidXMNCj4gaXRzIG9uIGFuZCB0aGUgVFBNIG1l
YW5zIHRoYXQgaXQgY3Jhc2hlcyBvciBmYWxscyBvZmYgdGhlIGJ1cyBpZiB5b3UNCj4gcG9rZSBp
dCB0b28gb2Z0ZW4gYW5kIG9uY2UgdGhpcyBoYXBwZW5zLCBvbmx5IGEgcmVib290IHdpbGwgcmVj
b3Zlcg0KPiBpdC4NCj4gDQo+IFRoZSBmaXggSSd2ZSBjb21lIHVwIHdpdGggaXMgdG8gYWRqdXN0
IHRoZSB0aW1pbmdzIHNvIHRoZSBUUE0gbm8NCj4gbG9uZ2VyIGZhbGxzIG9mIHRoZSBidXMuICBP
YnZpb3VzbHksIHRoaXMgZml4IHdvcmtzIGZvciBteSBOdXZvdG9uDQo+IE5QQ1Q2eHh4IGJ1dCB0
aGF0J3MgdGhlIG9ubHkgVFBNIEkndmUgdGVzdGVkIGl0IHdpdGguDQo+IA0KPiBGaXhlczogNDI0
ZWFmOTEwYzMyIHRwbTogcmVkdWNlIHBvbGxpbmcgdGltZSB0byB1c2VjcyBmb3IgZXZlbiBmaW5l
ciBncmFudWxhcml0eQ0KPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBCb3R0b21sZXkgPEphbWVzLkJv
dHRvbWxleUBIYW5zZW5QYXJ0bmVyc2hpcC5jb20+DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jaGFyL3RwbS90cG0uaCBiL2RyaXZlcnMvY2hhci90cG0vdHBtLmgNCj4gaW5kZXggNGIxMDQy
NDVhZmVkLi5hNmM4MDZkOTg5NTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2hhci90cG0vdHBt
LmgNCj4gKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG0uaA0KPiBAQCAtNjQsOCArNjQsOCBAQCBl
bnVtIHRwbV90aW1lb3V0IHsNCj4gIAlUUE1fVElNRU9VVF9SRVRSWSA9IDEwMCwgLyogbXNlY3Mg
Ki8NCj4gIAlUUE1fVElNRU9VVF9SQU5HRV9VUyA9IDMwMCwJLyogdXNlY3MgKi8NCj4gIAlUUE1f
VElNRU9VVF9QT0xMID0gMSwJLyogbXNlY3MgKi8NCj4gLQlUUE1fVElNRU9VVF9VU0VDU19NSU4g
PSAxMDAsICAgICAgLyogdXNlY3MgKi8NCj4gLQlUUE1fVElNRU9VVF9VU0VDU19NQVggPSA1MDAg
ICAgICAvKiB1c2VjcyAqLw0KPiArCVRQTV9USU1FT1VUX1VTRUNTX01JTiA9IDc1MCwgICAgICAv
KiB1c2VjcyAqLw0KPiArCVRQTV9USU1FT1VUX1VTRUNTX01BWCA9IDEwMDAsICAgICAgLyogdXNl
Y3MgKi8NCj4gIH07DQo+ICANCj4gIC8qIFRQTSBhZGRyZXNzZXMgKi8NCg==
