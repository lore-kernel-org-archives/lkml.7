Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAF6C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74652214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rFCnVZ7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfKGQal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:30:41 -0500
Received: from mail-eopbgr730044.outbound.protection.outlook.com ([40.107.73.44]:35922
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729451AbfKGQal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:30:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALkXvKk82UeIUkQi26Euzcz1OF+aHIATwg/RE7YgO1PHiKDVf26JyNkQ10IlRaP9alTGRiFUVFj7orm2N9WDBOLcP/36YP5BiI7Iu8IqQvgb4p2PPP11+xsHMby0vPMn9rHo3OfrFM3Rzaxp+oz7d6g3VZ+oYEAaPAKL5TjvkaUAziU0tKuYrCGrTc7VUuGuiZ9gQAt9AFAlCF+Q4irpUWY1dJiaYjLGvGhROpZS8X2NveMrOIQONFKf1kz9Cy+rakufWJyQRv7iHWLNKtCmPg+tNkxxBOSU17wOh3FjZOrxeN6+15HWhFGus95H8TZ563LSzYeTSeNsl3WJ5D90cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2J05OH90Y+8n8UuYvFPLMZipv1l+MlZLwCH4uk1uuw=;
 b=EwZeWiWdq6HK7SRzwZkO+yCar+uNaduPBiMTOV614b3wmzTC6at/WJ8d/P72XIqZSPRc6ndU21vjqvIZ1RknOOdkG15/zi49dQ+UcEr2AxuqywB5A4b8hDUe4RVWTZu+Uagh8WZSygT1DwXyZlph5Mk1rgwEewmj+4SHXvl7wo28J4vkVXOwaLI+Vlv7w5qCiPRdWayPX5SEvXTde+OsQWjaYFWsRBdUQJtlWEuRjoq93YNk4AKzy/fMJa0yI2R2s23YJ3D+3jckCqBUt71XelFlCvvwk1q/ZDXlBNcAw3HphrvXEu3I+PsgCbbHMVQzWYEPeK8ANMUOZNvsvQQEpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2J05OH90Y+8n8UuYvFPLMZipv1l+MlZLwCH4uk1uuw=;
 b=rFCnVZ7u5kxX9VF7KQdHa8O0yG4kcAww+YO43f1hb+tW+sJCeNKsEQEPOFDI80Ibbar7FkqkZyC1/nQMG0pJA9pGJQcpxw/zRIZzOhdYDplo+Yx+3lXbSkcEfEWoesBNjbu0xSuGBorWOrwXcvoXi0Lo0cYSclGKnydltvntuvQ=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.230.25) by
 CH2PR02MB6230.namprd02.prod.outlook.com (52.132.228.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 16:30:37 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a%7]) with mapi id 15.20.2430.023; Thu, 7 Nov 2019
 16:30:36 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 2/2] misc: xilinx_sdfec: Combine three condition checks
 into one statement in xsdfec_add_ldpc()
Thread-Topic: [PATCH 2/2] misc: xilinx_sdfec: Combine three condition checks
 into one statement in xsdfec_add_ldpc()
Thread-Index: AQHVlAq/6xOFapUQ4keqOaNDjO/0Tad/6O5w
Date:   Thu, 7 Nov 2019 16:30:36 +0000
Message-ID: <CH2PR02MB635990244270C49D0716FB43CB780@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <af1ff373-56c0-ca49-36dd-15666d183c95@web.de>
 <b927be91-a380-1bba-2b10-f0ca49c477b5@web.de>
In-Reply-To: <b927be91-a380-1bba-2b10-f0ca49c477b5@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a6a9cf4-9fce-420b-e27c-08d7639fd1f3
x-ms-traffictypediagnostic: CH2PR02MB6230:|CH2PR02MB6230:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB623014A9478B3FE92F748C78CB780@CH2PR02MB6230.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(13464003)(199004)(189003)(33656002)(476003)(3846002)(316002)(14444005)(102836004)(186003)(99286004)(14454004)(256004)(66066001)(8676002)(6436002)(66446008)(66476007)(6246003)(2906002)(66556008)(229853002)(64756008)(25786009)(52536014)(71190400001)(71200400001)(76176011)(66946007)(110136005)(6116002)(76116006)(9686003)(2501003)(8936002)(26005)(55016002)(74316002)(6506007)(53546011)(446003)(6636002)(486006)(81156014)(478600001)(4326008)(5660300002)(81166006)(86362001)(7696005)(54906003)(11346002)(305945005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6230;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vPWyRDP1BcO7Vfmcla1SESpB4lQ22hymyO00fGbHT4IMs+D8qg/M4mjbnX2z3phc94DPGjky7jZo9dqlCkzoU4hV4hMSSzewhYQPA5pyEXK0ixuZ3jlrXz5EdstuLvheTBsUIsnvr+5IfdYNmvfN3n3Sqe+5b7wynVGliRo9hjKj35VxgVjKiuJFyNWYzSEYN1EmcvnTGHsG8PKFa84BRbOHHtFPHJ0iubQBV9RdOtFOT0rq8M2s7v2JwruYoij3nQhDJBxEvSjMXSCyiZD7RgiZGzulV+jJCp/CJiF8R3Ykrwt21KIlKBT31op/D1x6rbDCDH8MhjaP7KSlkcmxa3CtWXo36KWPqEntxN5KKOpVyniiCOnWuOV05x5GUdRy591M8afKaJNngS1caTnFrgSj4GP8O2zh0Lq7yg2TP5Th99ICYi0usPng6pEEXDYM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6a9cf4-9fce-420b-e27c-08d7639fd1f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 16:30:36.8916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kcPuJ91LC9+Pe7PNSbVQo2kc3F0QIRZZTgXsjU/oN41Rlc+BLuDXFrdaU+PnRW5VNbqJ+Qeee+f8FwfYhtKT5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBNYXJrdXMsDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBN
YXJrdXMgRWxmcmluZyBbbWFpbHRvOk1hcmt1cy5FbGZyaW5nQHdlYi5kZV0NCj4gU2VudDogVHVl
c2RheSA1IE5vdmVtYmVyIDIwMTkgMTg6NTYNCj4gVG86IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT47IERlcmVrIEtpZXJu
YW4gPGRraWVybmFuQHhpbGlueC5jb20+OyBEcmFnYW4gQ3ZldGljDQo+IDxkcmFnYW5jQHhpbGlu
eC5jb20+OyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsg
TWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+DQo+IENjOiBMS01MIDxsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnPjsga2VybmVsLWphbml0b3JzQHZnZXIua2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBbUEFUQ0ggMi8yXSBtaXNjOiB4aWxpbnhfc2RmZWM6IENvbWJpbmUgdGhyZWUgY29u
ZGl0aW9uIGNoZWNrcyBpbnRvIG9uZSBzdGF0ZW1lbnQgaW4geHNkZmVjX2FkZF9sZHBjKCkNCj4g
DQo+IEZyb206IE1hcmt1cyBFbGZyaW5nIDxlbGZyaW5nQHVzZXJzLnNvdXJjZWZvcmdlLm5ldD4N
Cj4gRGF0ZTogVHVlLCA1IE5vdiAyMDE5IDE5OjMyOjI1ICswMTAwDQo+IA0KPiBUaGUgc2FtZSBy
ZXR1cm4gY29kZSB3YXMgc2V0IGFmdGVyIHRocmVlIGNvbmRpdGlvbiBjaGVja3MuDQo+IFRodXMg
dXNlIGEgc2luZ2xlIHN0YXRlbWVudCBpbnN0ZWFkLg0KPiANCj4gRml4ZXM6IDIwZWM2MjhlODAw
N2VjNzVjMmY4ODRlMDAwMDRmMzllYWI2Mjg5YjUgKCJtaXNjOiB4aWxpbnhfc2RmZWM6IEFkZCBh
YmlsaXR5IHRvIGNvbmZpZ3VyZSBMRFBDIikNCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEVsZnJp
bmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0Pg0KPiAtLS0NCj4gIGRyaXZlcnMvbWlz
Yy94aWxpbnhfc2RmZWMuYyB8IDE2ICsrKystLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbWlzYy94aWxpbnhfc2RmZWMuYyBiL2RyaXZlcnMvbWlzYy94aWxpbnhfc2RmZWMuYw0K
PiBpbmRleCBhNjIyZmNmNDk1NGEuLjMyMmQ1YzZlNmQxMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9taXNjL3hpbGlueF9zZGZlYy5jDQo+ICsrKyBiL2RyaXZlcnMvbWlzYy94aWxpbnhfc2RmZWMu
Yw0KPiBAQCAtNjUzLDE4ICs2NTMsMTAgQEAgc3RhdGljIGludCB4c2RmZWNfYWRkX2xkcGMoc3Ry
dWN0IHhzZGZlY19kZXYgKnhzZGZlYywgdm9pZCBfX3VzZXIgKmFyZykNCj4gIAlpZiAoSVNfRVJS
KGxkcGMpKQ0KPiAgCQlyZXR1cm4gUFRSX0VSUihsZHBjKTsNCj4gDQo+IC0JaWYgKHhzZGZlYy0+
Y29uZmlnLmNvZGUgPT0gWFNERkVDX1RVUkJPX0NPREUpIHsNCj4gLQkJcmV0ID0gLUVJTzsNCj4g
LQkJZ290byBlcnJfb3V0Ow0KPiAtCX0NCj4gLQ0KPiAtCS8qIFZlcmlmeSBEZXZpY2UgaGFzIG5v
dCBzdGFydGVkICovDQo+IC0JaWYgKHhzZGZlYy0+c3RhdGUgPT0gWFNERkVDX1NUQVJURUQpIHsN
Cj4gLQkJcmV0ID0gLUVJTzsNCj4gLQkJZ290byBlcnJfb3V0Ow0KPiAtCX0NCj4gLQ0KPiAtCWlm
ICh4c2RmZWMtPmNvbmZpZy5jb2RlX3dyX3Byb3RlY3QpIHsNCj4gKwlpZiAoeHNkZmVjLT5jb25m
aWcuY29kZSA9PSBYU0RGRUNfVFVSQk9fQ09ERSB8fA0KPiArCSAgICAvKiBWZXJpZnkgZGV2aWNl
IGhhcyBub3Qgc3RhcnRlZCAqLw0KPiArCSAgICB4c2RmZWMtPnN0YXRlID09IFhTREZFQ19TVEFS
VEVEIHx8DQo+ICsJICAgIHhzZGZlYy0+Y29uZmlnLmNvZGVfd3JfcHJvdGVjdCkgew0KPiAgCQly
ZXQgPSAtRUlPOw0KPiAgCQlnb3RvIGVycl9vdXQ7DQo+ICAJfQ0KDQphcHByb3ZlZA0KDQo+IC0t
DQo+IDIuMjQuMA0KDQo=
