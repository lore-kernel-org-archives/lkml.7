Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AD3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B82621929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fxUAPpRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406225AbfJYHFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:05:25 -0400
Received: from mail-eopbgr800073.outbound.protection.outlook.com ([40.107.80.73]:55024
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405856AbfJYHFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:05:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpDQ1WaM95kAF6CTLeeQUD1KGf9pxWR/gJEGeYlgtYikVm9f1LddTFxoN0dWSu0lVjnoC/Bo5SHAdrexsO9BNz1QTs3XUrGeHnS0EYc7FicJH6m/cTqnIHDLKJ+4uPLXWYK7kdT2Via+LO18t0hfe0DULkw9c7zrordbw3/Bo62YxR5SuzeYEFYEMU8DVED5sNCOcNhwsugjEIcXwAnNvqoEdzk+f7rrPW3cMYAstOqfaQYaO4zPN6T81PLQj3cPXVP+oVb5eQlo0h/HETkRfSBIs6et4TPjMGRefmBu3EZ3YCOhH4/YtHHbpsBx7QSVwl/fLUus8IM1E1+Sy9jFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMvCXJYahdqoK3nyTEmAhnpGmjZgy+i5kiNMK2fdUVE=;
 b=ZQpo1hDU4iT/VIAWQqtNqfy4l1poiitJZqf8e1Bnr5L9PD70xtj4a8OlN2mUlQ6pSrJ0eQheil0XOkObZB7gy1pk6YPoprA/vttv8XUmRD55wwjn16j6/f0st7tDCMh1NeLIfgD4PnKpJOFXJauSGrpf6J+Fth9g4wO1dr5TBbWoMizjYtSyKeIVUn5Alg1WWAX1HXcS3tIB1K9Ja2a1o0QRjtijjQeFiQoj0svTGUoMjrVcOyqCi5G8J0+HcprW7exqlu5cVEDpY2fUkAt6/jlvUxdoKbOjKRgEJe1Y/Kw4A8qzhq/xMMRileEpTit5ph/jSod9odc0TlVrhu+3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMvCXJYahdqoK3nyTEmAhnpGmjZgy+i5kiNMK2fdUVE=;
 b=fxUAPpRWoAj+ysA66rTxKYH9qAgc86C6oOojqE4fdODxP7LffshUOjmNgrvNI+Hr62JC8kjGfCr0G5VRY6qne5ENOHiHy259+8v/cPb5lByPrN92Pg+itJFzDf/j6O9B1cJ5eM3kw+dbNvt/HTRIaaCxi1MDfgBppAvnTXS/l/E=
Received: from DM6PR12MB3868.namprd12.prod.outlook.com (10.255.173.213) by
 DM6PR12MB2747.namprd12.prod.outlook.com (20.176.116.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 25 Oct 2019 07:05:21 +0000
Received: from DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1]) by DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1%4]) with mapi id 15.20.2387.021; Fri, 25 Oct 2019
 07:05:21 +0000
From:   vishnu <vravulap@amd.com>
To:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] ASoC: amd: Create multiple I2S platform device
 endpoints.
Thread-Topic: [PATCH 1/7] ASoC: amd: Create multiple I2S platform device
 endpoints.
Thread-Index: AQHVhffLV6dTyVw4dkCUUrYwEmzXIqdq+Z4A
Date:   Fri, 25 Oct 2019 07:05:20 +0000
Message-ID: <0e142f91-de3e-9a8c-3040-fc90a0c91f25@amd.com>
References: <1571432760-3008-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
In-Reply-To: <1571432760-3008-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::17) To DM6PR12MB3868.namprd12.prod.outlook.com
 (2603:10b6:5:1c8::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vishnuvardhanrao.Ravulapati@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.159.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 283fd0a8-f47c-44ab-691a-08d75919b2d8
x-ms-traffictypediagnostic: DM6PR12MB2747:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2747EAE5FC3445A21625F7ADE7650@DM6PR12MB2747.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(189003)(199004)(52116002)(102836004)(19627235002)(53546011)(71200400001)(386003)(6506007)(486006)(26005)(71190400001)(6862004)(36756003)(229853002)(8936002)(6512007)(81156014)(4326008)(6486002)(6246003)(6436002)(256004)(6636002)(478600001)(99286004)(66446008)(66556008)(76176011)(316002)(8676002)(31686004)(2906002)(64756008)(66476007)(31696002)(66946007)(7736002)(3846002)(186003)(54906003)(37006003)(11346002)(305945005)(2616005)(476003)(446003)(5660300002)(6116002)(66066001)(14454004)(81166006)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2747;H:DM6PR12MB3868.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XyHV719XnUShwH6dL69Mn0Z+Hah/iKkwNjkF47nYljNd9Snl8afLWpf54W7gwcHhQrQ34zH8Ju4Aq6xiY2fG2bU7GRAfJuQOCuF/ON5ehZBCvUygHQou+I72IS0ePX+tJLU5ypeLJWVjbeSJaIb0yWQPsIi8zY+g4pSHpNHBra61TD+beYg3X0FDtB0BO05qdqeZXenDFiHZzEUItmNUR/neX54S4ZuU3OuUVAW51l6qucZU8UunxKDbzcBpD4/96d8ffW7+1SwLGgtfDq9JytxvgwXcFvxuyiZe8vXAxQklBsTz0DVZ4Yb9bDU6U1uY0tIFd6+ZJUN4AVQyxJwP6YsdMfXEjA9bflxOzBMfis+kEvUcwb1KrKE0JBka5h5n+NIPokmFlWbzVXbNt9IbjiROmjHFrUDTMj8Er98Up0okocm+dfRKxlLEenKVZYgy
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC0620828CADDE428E619CA634DFCA6F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283fd0a8-f47c-44ab-691a-08d75919b2d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 07:05:20.8044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LAWZ041BwNIZjjJ8ywNJOEhkSwU4+uLpQA1i4ypjmzN7rgW+YTaNRrNkVXbv+CbNy/PmvuWSd2Vgd84NO+Sa6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2747
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywNCg0KQW55IHVwZGF0ZXMgb24gdGhpcyBwYXRjaC4NCg0KUmVnYXJkcywNClZpc2hu
dQ0KDQpPbiAxOS8xMC8xOSAyOjM1IEFNLCBSYXZ1bGFwYXRpIFZpc2hudSB2YXJkaGFuIHJhbyB3
cm90ZToNCj4gQ3JlYXRlcyBQbGF0Zm9ybSBEZXZpY2UgZW5kcG9pbnRzIGZvciBtdWx0aXBsZQ0K
PiBJMlMgaW5zdGFuY2VzOiBTUCBhbmQgIEJUIGVuZHBvaW50cyBkZXZpY2UuDQo+IFBhc3MgUENJ
IHJlc291cmNlcyBsaWtlIE1NSU8sIGlycSB0byB0aGUgcGxhdGZvcm0gZGV2aWNlcy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFJhdnVsYXBhdGkgVmlzaG51IHZhcmRoYW4gcmFvIDxWaXNobnV2YXJk
aGFucmFvLlJhdnVsYXBhdGlAYW1kLmNvbT4NCj4gLS0tDQo+ICAgc291bmQvc29jL2FtZC9yYXZl
bi9hY3AzeC5oICAgICB8ICA1ICsrKw0KPiAgIHNvdW5kL3NvYy9hbWQvcmF2ZW4vcGNpLWFjcDN4
LmMgfCA4MyArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiAgIDIg
ZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvc291bmQvc29jL2FtZC9yYXZlbi9hY3AzeC5oIGIvc291bmQvc29jL2FtZC9y
YXZlbi9hY3AzeC5oDQo+IGluZGV4IDRmMmNhZGQuLjJmMTVmZTEgMTAwNjQ0DQo+IC0tLSBhL3Nv
dW5kL3NvYy9hbWQvcmF2ZW4vYWNwM3guaA0KPiArKysgYi9zb3VuZC9zb2MvYW1kL3JhdmVuL2Fj
cDN4LmgNCj4gQEAgLTcsMTAgKzcsMTUgQEANCj4gICANCj4gICAjaW5jbHVkZSAiY2hpcF9vZmZz
ZXRfYnl0ZS5oIg0KPiAgIA0KPiArI2RlZmluZSBBQ1AzeF9ERVZTCQkzDQo+ICAgI2RlZmluZSBB
Q1AzeF9QSFlfQkFTRV9BRERSRVNTIDB4MTI0MDAwMA0KPiAgICNkZWZpbmUJQUNQM3hfSTJTX01P
REUJMA0KPiAgICNkZWZpbmUJQUNQM3hfUkVHX1NUQVJUCTB4MTI0MDAwMA0KPiAgICNkZWZpbmUJ
QUNQM3hfUkVHX0VORAkweDEyNTAyMDANCj4gKyNkZWZpbmUgQUNQM3hfSTJTVERNX1JFR19TVEFS
VAkweDEyNDI0MDANCj4gKyNkZWZpbmUgQUNQM3hfSTJTVERNX1JFR19FTkQJMHgxMjQyNDEwDQo+
ICsjZGVmaW5lIEFDUDN4X0JUX1RETV9SRUdfU1RBUlQJMHgxMjQyODAwDQo+ICsjZGVmaW5lIEFD
UDN4X0JUX1RETV9SRUdfRU5ECTB4MTI0MjgxMA0KPiAgICNkZWZpbmUgSTJTX01PREUJMHgwNA0K
PiAgICNkZWZpbmUJQlRfVFhfVEhSRVNIT0xEIDI2DQo+ICAgI2RlZmluZQlCVF9SWF9USFJFU0hP
TEQgMjUNCj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9hbWQvcmF2ZW4vcGNpLWFjcDN4LmMgYi9z
b3VuZC9zb2MvYW1kL3JhdmVuL3BjaS1hY3AzeC5jDQo+IGluZGV4IGZhY2VjMjQuLjdmNDM1YjMg
MTAwNjQ0DQo+IC0tLSBhL3NvdW5kL3NvYy9hbWQvcmF2ZW4vcGNpLWFjcDN4LmMNCj4gKysrIGIv
c291bmQvc29jL2FtZC9yYXZlbi9wY2ktYWNwM3guYw0KPiBAQCAtMTYsMTYgKzE2LDE2IEBAIHN0
cnVjdCBhY3AzeF9kZXZfZGF0YSB7DQo+ICAgCXZvaWQgX19pb21lbSAqYWNwM3hfYmFzZTsNCj4g
ICAJYm9vbCBhY3AzeF9hdWRpb19tb2RlOw0KPiAgIAlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4g
LQlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2Ow0KPiArCXN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXZbQUNQM3hfREVWU107DQo+ICAgfTsNCj4gICANCj4gICBzdGF0aWMgaW50IHNuZF9h
Y3AzeF9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGNpLA0KPiAgIAkJCSAgIGNvbnN0IHN0cnVjdCBw
Y2lfZGV2aWNlX2lkICpwY2lfaWQpDQo+ICAgew0KPiAgIAlpbnQgcmV0Ow0KPiAtCXUzMiBhZGRy
LCB2YWw7DQo+ICsJdTMyIGFkZHIsIHZhbCwgaTsNCj4gICAJc3RydWN0IGFjcDN4X2Rldl9kYXRh
ICphZGF0YTsNCj4gLQlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlX2luZm8gcGRldmluZm87DQo+ICsJ
c3RydWN0IHBsYXRmb3JtX2RldmljZV9pbmZvIHBkZXZpbmZvW0FDUDN4X0RFVlNdOw0KPiAgIAl1
bnNpZ25lZCBpbnQgaXJxZmxhZ3M7DQo+ICAgDQo+ICAgCWlmIChwY2lfZW5hYmxlX2RldmljZShw
Y2kpKSB7DQo+IEBAIC02OCw3ICs2OCw3IEBAIHN0YXRpYyBpbnQgc25kX2FjcDN4X3Byb2JlKHN0
cnVjdCBwY2lfZGV2ICpwY2ksDQo+ICAgCXN3aXRjaCAodmFsKSB7DQo+ICAgCWNhc2UgSTJTX01P
REU6DQo+ICAgCQlhZGF0YS0+cmVzID0gZGV2bV9remFsbG9jKCZwY2ktPmRldiwNCj4gLQkJCQkJ
ICBzaXplb2Yoc3RydWN0IHJlc291cmNlKSAqIDIsDQo+ICsJCQkJCSAgc2l6ZW9mKHN0cnVjdCBy
ZXNvdXJjZSkgKiA0LA0KPiAgIAkJCQkJICBHRlBfS0VSTkVMKTsNCj4gICAJCWlmICghYWRhdGEt
PnJlcykgew0KPiAgIAkJCXJldCA9IC1FTk9NRU07DQo+IEBAIC04MCwzOSArODAsNjEgQEAgc3Rh
dGljIGludCBzbmRfYWNwM3hfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBjaSwNCj4gICAJCWFkYXRh
LT5yZXNbMF0uc3RhcnQgPSBhZGRyOw0KPiAgIAkJYWRhdGEtPnJlc1swXS5lbmQgPSBhZGRyICsg
KEFDUDN4X1JFR19FTkQgLSBBQ1AzeF9SRUdfU1RBUlQpOw0KPiAgIA0KPiAtCQlhZGF0YS0+cmVz
WzFdLm5hbWUgPSAiYWNwM3hfaTJzX2lycSI7DQo+IC0JCWFkYXRhLT5yZXNbMV0uZmxhZ3MgPSBJ
T1JFU09VUkNFX0lSUTsNCj4gLQkJYWRhdGEtPnJlc1sxXS5zdGFydCA9IHBjaS0+aXJxOw0KPiAt
CQlhZGF0YS0+cmVzWzFdLmVuZCA9IHBjaS0+aXJxOw0KPiArCQlhZGF0YS0+cmVzWzFdLm5hbWUg
PSAiYWNwM3hfaTJzX3NwIjsNCj4gKwkJYWRhdGEtPnJlc1sxXS5mbGFncyA9IElPUkVTT1VSQ0Vf
TUVNOw0KPiArCQlhZGF0YS0+cmVzWzFdLnN0YXJ0ID0gYWRkciArIEFDUDN4X0kyU1RETV9SRUdf
U1RBUlQ7DQo+ICsJCWFkYXRhLT5yZXNbMV0uZW5kID0gYWRkciArIEFDUDN4X0kyU1RETV9SRUdf
RU5EOw0KPiArDQo+ICsJCWFkYXRhLT5yZXNbMl0ubmFtZSA9ICJhY3AzeF9pMnNfYnQiOw0KPiAr
CQlhZGF0YS0+cmVzWzJdLmZsYWdzID0gSU9SRVNPVVJDRV9NRU07DQo+ICsJCWFkYXRhLT5yZXNb
Ml0uc3RhcnQgPSBhZGRyICsgQUNQM3hfQlRfVERNX1JFR19TVEFSVDsNCj4gKwkJYWRhdGEtPnJl
c1syXS5lbmQgPSBhZGRyICsgQUNQM3hfQlRfVERNX1JFR19FTkQ7DQo+ICsNCj4gKwkJYWRhdGEt
PnJlc1szXS5uYW1lID0gImFjcDN4X2kyc19pcnEiOw0KPiArCQlhZGF0YS0+cmVzWzNdLmZsYWdz
ID0gSU9SRVNPVVJDRV9JUlE7DQo+ICsJCWFkYXRhLT5yZXNbM10uc3RhcnQgPSBwY2ktPmlycTsN
Cj4gKwkJYWRhdGEtPnJlc1szXS5lbmQgPSBhZGF0YS0+cmVzWzNdLnN0YXJ0Ow0KPiAgIA0KPiAg
IAkJYWRhdGEtPmFjcDN4X2F1ZGlvX21vZGUgPSBBQ1AzeF9JMlNfTU9ERTsNCj4gICANCj4gICAJ
CW1lbXNldCgmcGRldmluZm8sIDAsIHNpemVvZihwZGV2aW5mbykpOw0KPiAtCQlwZGV2aW5mby5u
YW1lID0gImFjcDN4X3J2X2kycyI7DQo+IC0JCXBkZXZpbmZvLmlkID0gMDsNCj4gLQkJcGRldmlu
Zm8ucGFyZW50ID0gJnBjaS0+ZGV2Ow0KPiAtCQlwZGV2aW5mby5udW1fcmVzID0gMjsNCj4gLQkJ
cGRldmluZm8ucmVzID0gYWRhdGEtPnJlczsNCj4gLQkJcGRldmluZm8uZGF0YSA9ICZpcnFmbGFn
czsNCj4gLQkJcGRldmluZm8uc2l6ZV9kYXRhID0gc2l6ZW9mKGlycWZsYWdzKTsNCj4gLQ0KPiAt
CQlhZGF0YS0+cGRldiA9IHBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcl9mdWxsKCZwZGV2aW5mbyk7
DQo+IC0JCWlmIChJU19FUlIoYWRhdGEtPnBkZXYpKSB7DQo+IC0JCQlkZXZfZXJyKCZwY2ktPmRl
diwgImNhbm5vdCByZWdpc3RlciAlcyBkZXZpY2VcbiIsDQo+IC0JCQkJcGRldmluZm8ubmFtZSk7
DQo+IC0JCQlyZXQgPSBQVFJfRVJSKGFkYXRhLT5wZGV2KTsNCj4gLQkJCWdvdG8gdW5tYXBfbW1p
bzsNCj4gKwkJcGRldmluZm9bMF0ubmFtZSA9ICJhY3AzeF9ydl9pMnNfZG1hIjsNCj4gKwkJcGRl
dmluZm9bMF0uaWQgPSAwOw0KPiArCQlwZGV2aW5mb1swXS5wYXJlbnQgPSAmcGNpLT5kZXY7DQo+
ICsJCXBkZXZpbmZvWzBdLm51bV9yZXMgPSA0Ow0KPiArCQlwZGV2aW5mb1swXS5yZXMgPSAmYWRh
dGEtPnJlc1swXTsNCj4gKwkJcGRldmluZm9bMF0uZGF0YSA9ICZpcnFmbGFnczsNCj4gKwkJcGRl
dmluZm9bMF0uc2l6ZV9kYXRhID0gc2l6ZW9mKGlycWZsYWdzKTsNCj4gKw0KPiArCQlwZGV2aW5m
b1sxXS5uYW1lID0gImFjcDN4X2kyc19wbGF5Y2FwIjsNCj4gKwkJcGRldmluZm9bMV0uaWQgPSAw
Ow0KPiArCQlwZGV2aW5mb1sxXS5wYXJlbnQgPSAmcGNpLT5kZXY7DQo+ICsJCXBkZXZpbmZvWzFd
Lm51bV9yZXMgPSAxOw0KPiArCQlwZGV2aW5mb1sxXS5yZXMgPSAmYWRhdGEtPnJlc1sxXTsNCj4g
Kw0KPiArCQlwZGV2aW5mb1syXS5uYW1lID0gImFjcDN4X2kyc19wbGF5Y2FwIjsNCj4gKwkJcGRl
dmluZm9bMl0uaWQgPSAxOw0KPiArCQlwZGV2aW5mb1syXS5wYXJlbnQgPSAmcGNpLT5kZXY7DQo+
ICsJCXBkZXZpbmZvWzJdLm51bV9yZXMgPSAxOw0KPiArCQlwZGV2aW5mb1syXS5yZXMgPSAmYWRh
dGEtPnJlc1syXTsNCj4gKwkJZm9yIChpID0gMDsgaSA8IEFDUDN4X0RFVlMgOyBpKyspIHsNCj4g
KwkJCWFkYXRhLT5wZGV2W2ldID0NCj4gKwkJCQlwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXJfZnVs
bCgmcGRldmluZm9baV0pOw0KPiArCQkJaWYgKGFkYXRhLT5wZGV2W2ldID09IE5VTEwpIHsNCj4g
KwkJCQlkZXZfZXJyKCZwY2ktPmRldiwgImNhbm5vdCByZWdpc3RlciAlcyBkZXZpY2VcbiIsDQo+
ICsJCQkJCXBkZXZpbmZvW2ldLm5hbWUpOw0KPiArCQkJCXJldCA9IC1FTk9ERVY7DQo+ICsJCQkJ
Z290byB1bm1hcF9tbWlvOw0KPiArCQkJfQ0KPiAgIAkJfQ0KPiAgIAkJYnJlYWs7DQo+IC0JZGVm
YXVsdDoNCj4gLQkJZGV2X2VycigmcGNpLT5kZXYsICJJbnZhbGlkIEFDUCBhdWRpbyBtb2RlIDog
JWRcbiIsIHZhbCk7DQo+IC0JCXJldCA9IC1FTk9ERVY7DQo+IC0JCWdvdG8gdW5tYXBfbW1pbzsN
Cj4gICAJfQ0KPiAgIAlyZXR1cm4gMDsNCj4gICANCj4gICB1bm1hcF9tbWlvOg0KPiAtCXBjaV9k
aXNhYmxlX21zaShwY2kpOw0KPiArCWZvciAoaSA9IDAgOyBpIDwgQUNQM3hfREVWUyA7IGkrKykN
Cj4gKwkJcGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIoYWRhdGEtPnBkZXZbaV0pOw0KPiArCWtm
cmVlKGFkYXRhLT5yZXMpOw0KPiAgIAlpb3VubWFwKGFkYXRhLT5hY3AzeF9iYXNlKTsNCj4gICBy
ZWxlYXNlX3JlZ2lvbnM6DQo+ICAgCXBjaV9yZWxlYXNlX3JlZ2lvbnMocGNpKTsNCj4gQEAgLTEy
NCw5ICsxNDYsMTMgQEAgc3RhdGljIGludCBzbmRfYWNwM3hfcHJvYmUoc3RydWN0IHBjaV9kZXYg
KnBjaSwNCj4gICANCj4gICBzdGF0aWMgdm9pZCBzbmRfYWNwM3hfcmVtb3ZlKHN0cnVjdCBwY2lf
ZGV2ICpwY2kpDQo+ICAgew0KPiArCWludCBpOw0KPiAgIAlzdHJ1Y3QgYWNwM3hfZGV2X2RhdGEg
KmFkYXRhID0gcGNpX2dldF9kcnZkYXRhKHBjaSk7DQo+ICAgDQo+IC0JcGxhdGZvcm1fZGV2aWNl
X3VucmVnaXN0ZXIoYWRhdGEtPnBkZXYpOw0KPiArCWlmIChhZGF0YS0+YWNwM3hfYXVkaW9fbW9k
ZSA9PSBBQ1AzeF9JMlNfTU9ERSkgew0KPiArCQlmb3IgKGkgPSAwIDsgaSA8ICBBQ1AzeF9ERVZT
IDsgaSsrKQ0KPiArCQkJcGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIoYWRhdGEtPnBkZXZbaV0p
Ow0KPiArCX0NCj4gICAJaW91bm1hcChhZGF0YS0+YWNwM3hfYmFzZSk7DQo+ICAgDQo+ICAgCXBj
aV9kaXNhYmxlX21zaShwY2kpOw0KPiBAQCAtMTUxLDYgKzE3Nyw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
cGNpX2RyaXZlciBhY3AzeF9kcml2ZXIgID0gew0KPiAgIA0KPiAgIG1vZHVsZV9wY2lfZHJpdmVy
KGFjcDN4X2RyaXZlcik7DQo+ICAgDQo+ICtNT0RVTEVfQVVUSE9SKCJWaXNobnV2YXJkaGFucmFv
LlJhdnVsYXBhdGlAYW1kLmNvbSIpOw0KPiAgIE1PRFVMRV9BVVRIT1IoIk1hcnV0aGkuQmF5eWF2
YXJhcHVAYW1kLmNvbSIpOw0KPiAgIE1PRFVMRV9ERVNDUklQVElPTigiQU1EIEFDUDN4IFBDSSBk
cml2ZXIiKTsNCj4gICBNT0RVTEVfTElDRU5TRSgiR1BMIHYyIik7DQo+IA0K
