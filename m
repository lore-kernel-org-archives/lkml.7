Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52661CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220DD21734
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g7KOJ1NM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfJ3MdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 08:33:16 -0400
Received: from mail-eopbgr720040.outbound.protection.outlook.com ([40.107.72.40]:51760
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbfJ3MdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:33:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHAY7breFizVbxY/xiAmTGNA/f9xlkBJzFj4swz1gnfH0OMCKxJeFz8CzuaWYuie4NDxROi8IVkuJRDPjhvfkNWrrdXrMIA8dqOPjnvcZ51AmKEYlQaMWuQTsukZSaFpl/tt/gWYjyWrih+3g2TakA7qN3yqh29ZM1F6yTUxpSZtTcvyz+LWq4BA0M6I2PTqirmLUQ9cV0WGvlItkEaM89MeeqPiF9Nio5Kg85CvBl5M5GXbZ9nAJVMAaPH8ffD2eWufwGAV7aP2i0JC2CLMvMDqc9CsGa/dC124KrJPVVrtIVVUURVUnswU0UvL4/FwTUM2Rk8Auciu4v9e8oUKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyCASmsmlHb3b2+IFdVg1ifMpBpMMhfkaATEpR5uK3c=;
 b=UTjMKwqsAaA4H6v5NRPKZJNXZi07HNS1ANU5wsPac1rqjsjEGDfPsrKdKmcSKgTGZlctIOrQ5oh1v45gtfEJ9eg5R5OY0Zzj0ZyT8QImX81ZlvlEphlaVz/0ir8cSrP1wsUqEQ8a36zm9r74DoR7GZf2cMASto8oqxD0+zSfVywZ9XSP7GfNVjBkf6ZS5hiBgYGGOwrU0lIH8gTXE2WZCYYDUnJLbg6UlK1M9nsw/A/bq1dh7lhnO5beevmQzJ7ao4+tjHiwq0XLhT7lVtXcq2rJPUMzfssJkpVXidzRzPBGJCe5rfuj5IVTwff6nH91yiElE66wUeHavoOkgVk/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyCASmsmlHb3b2+IFdVg1ifMpBpMMhfkaATEpR5uK3c=;
 b=g7KOJ1NMU24AyEKYqqqyc2zptDUlmYhsUfhRVLss6+mBWk/l8P67JgjD79DmPPl4Q/njSbat1hFbml0jpkzLzV3AupPjkOQf0kIh1NS1RHoSTYZNmtuoJdHg2bDs8x5yY3lkkAUc26wVapFMwtZkR3Cq4WoLSvsGBP7HiVqgBDg=
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3173.namprd12.prod.outlook.com (20.179.94.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Wed, 30 Oct 2019 12:33:12 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f950:f7be:9139:7c26%7]) with mapi id 15.20.2408.018; Wed, 30 Oct 2019
 12:33:12 +0000
From:   "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>
CC:     "Li, Roman" <Roman.Li@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH -next] drm/amd/display: Add a conversion function for
 transmitter and phy_id enums
Thread-Topic: [PATCH -next] drm/amd/display: Add a conversion function for
 transmitter and phy_id enums
Thread-Index: AQHVjufqOqphme+ZcUWQhKhHM4f606dzHo4A
Date:   Wed, 30 Oct 2019 12:33:11 +0000
Message-ID: <b8a9f49e-b788-82b8-ead3-0ae6fba7e8fa@amd.com>
References: <20191030060411.21168-1-natechancellor@gmail.com>
In-Reply-To: <20191030060411.21168-1-natechancellor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::26)
 To BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 03e27e70-34e0-4e69-26a6-08d75d3553c6
x-ms-traffictypediagnostic: BYAPR12MB3173:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB31734B2EC1A0AC147EC7CC83EC600@BYAPR12MB3173.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(229853002)(316002)(6506007)(386003)(102836004)(71190400001)(2906002)(36756003)(71200400001)(26005)(5660300002)(4001150100001)(4326008)(53546011)(6636002)(14444005)(6246003)(256004)(76176011)(110136005)(186003)(6116002)(6306002)(6512007)(52116002)(6436002)(6486002)(54906003)(99286004)(3846002)(66476007)(25786009)(81156014)(446003)(81166006)(66946007)(64756008)(66446008)(66556008)(8676002)(966005)(86362001)(31696002)(486006)(478600001)(2616005)(7736002)(66066001)(31686004)(8936002)(305945005)(11346002)(476003)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3173;H:BYAPR12MB3560.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tPyQI4EcVgJitIJYXaKdPnGO86ps6beD1+ZNc00rh8+jnqGV85gXUlWs2p3rHkKt2ZnCXc93GB48E6xla34mCDULlkzvSxxURnFU9VcIXsvVJ1UkSqy4WKzV7+EYqkV0f8nWuLulXQCy5c7LIR09QhYtJDV0eMUNZP2i+ZCaEaNwUot8GCEUjQXuLI3pyEjSWrekDANIo2GqhNGk4z9q96EVd2GMu5o6rnwH5uEHyTd/RIYLL+DyyCULhV+G3HTFy9xEGSfYo6I4vs/OOr2XDQCieFOQJFqWWIYiY1j6p9oqid8WB8psI9SMC9ags1ZSeC3E+72rlhAqdBQHH+Cusm3AFXmZDrpOhV65HTJunIeXTo2lDWLCF5t1z3SbkMY2JLwOwXgwvcY9CG19g/GbyFXfgEV9BKhIIy8VeFIW1BnCmCibIbXSA5kGBmGhb4IJ34irxuLMXY5wJAd4fHzbVLM8gIjUUx9M4GIluqa4B/I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C94A34E747B3348870EDD8EC50ECBB8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e27e70-34e0-4e69-26a6-08d75d3553c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 12:33:11.9397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zl4n7EuSeM5mR9q3UO0EoCn8zSZHWzq/HLhlYN/IbGvglB8v26EQSSkdbQa3wzxvtixw1aIvpCWhR9qFQhoSJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0xMC0zMCAyOjA0IGEubS4sIE5hdGhhbiBDaGFuY2VsbG9yIHdyb3RlOg0KPiBDbGFu
ZyB3YXJuczoNCj4gDQo+IC4uL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkv
ZGMvY29yZS9kY19saW5rLmM6MjUyMDo0MjoNCj4gZXJyb3I6IGltcGxpY2l0IGNvbnZlcnNpb24g
ZnJvbSBlbnVtZXJhdGlvbiB0eXBlICdlbnVtIHRyYW5zbWl0dGVyJyB0bw0KPiBkaWZmZXJlbnQg
ZW51bWVyYXRpb24gdHlwZSAnZW51bSBwaHlzaWNhbF9waHlfaWQnDQo+IFstV2Vycm9yLC1XZW51
bS1jb252ZXJzaW9uXQ0KPiAgICAgICAgICBwc3JfY29udGV4dC0+c211UGh5SWQgPSBsaW5rLT5s
aW5rX2VuYy0+dHJhbnNtaXR0ZXI7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+
IH5+fn5+fn5+fn5+fn5+fn5efn5+fn5+fn5+fg0KPiAxIGVycm9yIGdlbmVyYXRlZC4NCj4gDQo+
IEFzIHRoZSBjb21tZW50IGFib3ZlIHRoaXMgYXNzaWdubWVudCBzdGF0ZXMsIHRoaXMgaXMgaW50
ZW50aW9uYWwuIFRvDQo+IG1hdGNoIHByZXZpb3VzIHdhcm5pbmdzIG9mIHRoaXMgbmF0dXJlLCBh
ZGQgYSBjb252ZXJzaW9uIGZ1bmN0aW9uIHRoYXQNCj4gZXhwbGljaXRseSBjb252ZXJ0cyBiZXR3
ZWVuIHRoZSBlbnVtcyBhbmQgd2FybnMgd2hlbiB0aGVyZSBpcyBhDQo+IG1pc21hdGNoLg0KPiAN
Cj4gU2VlIGNvbW1pdCA4MjhjZmEyOTA5M2YgKCJkcm0vYW1kZ3B1OiBGaXggYW1kZ3B1IHJhcyB0
byB0YSBlbnVtcw0KPiBjb252ZXJzaW9uIikgYW5kIGNvbW1pdCBkOWVjNWNmZDVhMmUgKCJkcm0v
YW1kL2Rpc3BsYXk6IFVzZSBzd2l0Y2ggdGFibGUNCj4gZm9yIGRjX3RvX3NtdV9jbG9ja190eXBl
IikgZm9yIHByZXZpb3VzIGV4YW1wbGVzIG9mIHRoaXMuDQo+IA0KPiBGaXhlczogZTBkMDhhNDBh
NjNiICgiZHJtL2FtZC9kaXNwbGF5OiBBZGQgZGVidWdmcyBlbnRyeSBmb3IgcmVhZGluZyBwc3Ig
c3RhdGUiKQ0KPiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vQ2xhbmdCdWlsdExpbnV4L2xpbnV4
L2lzc3Vlcy83NTgNCj4gU2lnbmVkLW9mZi1ieTogTmF0aGFuIENoYW5jZWxsb3IgPG5hdGVjaGFu
Y2VsbG9yQGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5p
Y2hvbGFzLmthemxhdXNrYXNAYW1kLmNvbT4NCg0KV2l0aCB0aGUgc21hbGwgbml0cGljayB0aGF0
IG1heWJlIHRoZSBkZWZhdWx0IGNhc2Ugc2hvdWxkIGJlIA0KUEhZTERfVU5LTk9XTiwgYnV0IHdl
bGwgZ2V0IHRoZSB3YXJuaW5nIGlmIHRoYXQgaGFwcGVucyBhbnl3YXkuDQoNCk5pY2hvbGFzIEth
emxhdXNrYXMNCg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29y
ZS9kY19saW5rLmMgfCAzOCArKysrKysrKysrKysrKysrKystDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDM3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMNCj4gaW5kZXggN2IxODA4N2JlNTg1Li4z
OGRmZTQ2MGUxM2IgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9jb3JlL2RjX2xpbmsuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Y29yZS9kY19saW5rLmMNCj4gQEAgLTI0NDcsNiArMjQ0Nyw0MSBAQCBib29sIGRjX2xpbmtfZ2V0
X3Bzcl9zdGF0ZShjb25zdCBzdHJ1Y3QgZGNfbGluayAqbGluaywgdWludDMyX3QgKnBzcl9zdGF0
ZSkNCj4gICAJcmV0dXJuIHRydWU7DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGljIGlubGluZSBlbnVt
IHBoeXNpY2FsX3BoeV9pZA0KPiArdHJhbnNtaXR0ZXJfdG9fcGh5X2lkKGVudW0gdHJhbnNtaXR0
ZXIgdHJhbnNtaXR0ZXJfdmFsdWUpDQo+ICt7DQo+ICsJc3dpdGNoICh0cmFuc21pdHRlcl92YWx1
ZSkgew0KPiArCWNhc2UgVFJBTlNNSVRURVJfVU5JUEhZX0E6DQo+ICsJCXJldHVybiBQSFlMRF8w
Ow0KPiArCWNhc2UgVFJBTlNNSVRURVJfVU5JUEhZX0I6DQo+ICsJCXJldHVybiBQSFlMRF8xOw0K
PiArCWNhc2UgVFJBTlNNSVRURVJfVU5JUEhZX0M6DQo+ICsJCXJldHVybiBQSFlMRF8yOw0KPiAr
CWNhc2UgVFJBTlNNSVRURVJfVU5JUEhZX0Q6DQo+ICsJCXJldHVybiBQSFlMRF8zOw0KPiArCWNh
c2UgVFJBTlNNSVRURVJfVU5JUEhZX0U6DQo+ICsJCXJldHVybiBQSFlMRF80Ow0KPiArCWNhc2Ug
VFJBTlNNSVRURVJfVU5JUEhZX0Y6DQo+ICsJCXJldHVybiBQSFlMRF81Ow0KPiArCWNhc2UgVFJB
TlNNSVRURVJfTlVUTUVHX0NSVDoNCj4gKwkJcmV0dXJuIFBIWUxEXzY7DQo+ICsJY2FzZSBUUkFO
U01JVFRFUl9UUkFWSVNfQ1JUOg0KPiArCQlyZXR1cm4gUEhZTERfNzsNCj4gKwljYXNlIFRSQU5T
TUlUVEVSX1RSQVZJU19MQ0Q6DQo+ICsJCXJldHVybiBQSFlMRF84Ow0KPiArCWNhc2UgVFJBTlNN
SVRURVJfVU5JUEhZX0c6DQo+ICsJCXJldHVybiBQSFlMRF85Ow0KPiArCWNhc2UgVFJBTlNNSVRU
RVJfQ09VTlQ6DQo+ICsJCXJldHVybiBQSFlMRF9DT1VOVDsNCj4gKwljYXNlIFRSQU5TTUlUVEVS
X1VOS05PV046DQo+ICsJCXJldHVybiBQSFlMRF9VTktOT1dOOw0KPiArCWRlZmF1bHQ6DQo+ICsJ
CVdBUk5fT05DRSgxLCAiVW5rbm93biB0cmFuc21pdHRlciB2YWx1ZSAlZFxuIiwNCj4gKwkJCSAg
dHJhbnNtaXR0ZXJfdmFsdWUpOw0KPiArCQlyZXR1cm4gUEhZTERfMDsNCj4gKwl9DQo+ICt9DQo+
ICsNCj4gICBib29sIGRjX2xpbmtfc2V0dXBfcHNyKHN0cnVjdCBkY19saW5rICpsaW5rLA0KPiAg
IAkJY29uc3Qgc3RydWN0IGRjX3N0cmVhbV9zdGF0ZSAqc3RyZWFtLCBzdHJ1Y3QgcHNyX2NvbmZp
ZyAqcHNyX2NvbmZpZywNCj4gICAJCXN0cnVjdCBwc3JfY29udGV4dCAqcHNyX2NvbnRleHQpDQo+
IEBAIC0yNTE3LDcgKzI1NTIsOCBAQCBib29sIGRjX2xpbmtfc2V0dXBfcHNyKHN0cnVjdCBkY19s
aW5rICpsaW5rLA0KPiAgIAkvKiBIYXJkY29kZWQgZm9yIG5vdy4gIENhbiBiZSBQY2llIG9yIFVu
aXBoeSAob3IgVW5rbm93bikqLw0KPiAgIAlwc3JfY29udGV4dC0+cGh5VHlwZSA9IFBIWV9UWVBF
X1VOSVBIWTsNCj4gICAJLypQaHlJZCBpcyBhc3NvY2lhdGVkIHdpdGggdGhlIHRyYW5zbWl0dGVy
IGlkKi8NCj4gLQlwc3JfY29udGV4dC0+c211UGh5SWQgPSBsaW5rLT5saW5rX2VuYy0+dHJhbnNt
aXR0ZXI7DQo+ICsJcHNyX2NvbnRleHQtPnNtdVBoeUlkID0NCj4gKwkJdHJhbnNtaXR0ZXJfdG9f
cGh5X2lkKGxpbmstPmxpbmtfZW5jLT50cmFuc21pdHRlcik7DQo+ICAgDQo+ICAgCXBzcl9jb250
ZXh0LT5jcnRjVGltaW5nVmVydGljYWxUb3RhbCA9IHN0cmVhbS0+dGltaW5nLnZfdG90YWw7DQo+
ICAgCXBzcl9jb250ZXh0LT52c3luY1JhdGVIeiA9IGRpdjY0X3U2NChkaXY2NF91NjQoKHN0cmVh
bS0+DQo+IA0KDQo=
