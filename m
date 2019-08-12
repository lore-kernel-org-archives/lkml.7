Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48863C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA6C206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="VlxjHpdC";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="PhLUvIAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfHLLLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:11:45 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:62638 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727235AbfHLLLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:11:44 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7CB8Q07009782;
        Mon, 12 Aug 2019 04:10:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=tvxFkIwL2EJwmkmdjXRr9MBqQcj7tbd20rKN56q/EkA=;
 b=VlxjHpdCxKy2072NKi3pIdMQPYanqtQxubuKYaBtTGE2TapNBMVkFrVRFNrn8KGlJz2v
 SU9Y5UVkI0mwj/imvfy5Owmr5P3H3tPWwcRn9pBeQdfOi9nGb5Uup+0um0UNHWnTnMOh
 cAqB5J55VOF9CPmpR3J3v7B270QiObBctYztk9hl1Xk9UMQPykUnlv13Gjkh7+sQc0w5
 cVvlRfPPXcvJMqJVnZRFlyDENoM9b0eZ6k7o00aciyFzYSW16EgwdNr/F2txbTlefZXL
 AGAdBchS20kh+q3lX/Pw8WtAZ27rKnlKaArxAQkVzxj1farRSSm2cynoQiYAUoAdknA9 EQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2051.outbound.protection.outlook.com [104.47.44.51])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2u9tfs5e30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 04:10:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdpe6dUjdRoA0qvT1ufUYGTG6N4tFDlJceua1LZHuF2nC5KgWWTpvBKbMLOEXCN9nrRYOvuBhJeSOeE5WTVrON6ozQXaYagjkyMcRExVMf4cwGjxzLSFvgU1WBFWStsoJXulXxD2NjcKC0ZxYhkVw84s30d9eNUhayz5jiposM2JzauKttLC/wsfowkpI/22IIJUzDzvHVnBBjiV3Any9mxOK7Zo9+arn0Mh8YnsYaX4u9Hxw76cCL2Lf5t7HCjeXJlsvfsvRAvgMUG6F7uJQjSBxBh32xa9HqV6/DEsP66omj/Pcyd6BDK1Lpj+EO+MYTdstOZ/32oKMdFGPVhJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvxFkIwL2EJwmkmdjXRr9MBqQcj7tbd20rKN56q/EkA=;
 b=dgZ7oE9nSj2MkSXA2LHfHyukZmv+jS3atQNoUxhPFGBXfhYPi7BkL0ziQ6SccAJJQkM7d2qTqeInhDnfabElIRf4hCFpjSCLJAJBcz70H33S+RF8a2U7ofVECxWE55dNeKnpWRWWiqMTNKojOw5R4DnuTqJnTTjkLzZLTj33h0ErJKjbWnsFayBlOOxwFuPhHdGgRisieWBaGCUtXzEJdczjvE+B75lcV943xw716W6ELt2api4lt2F/70/0qQEjK6tKJMKntAWIqToaX4aw6mi7ywyWvQo5FUIJoJRLSRPZgDPyhmw2hJ76OpwPQpGtFnIdvbg8kpTQ3bDq8U2ytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvxFkIwL2EJwmkmdjXRr9MBqQcj7tbd20rKN56q/EkA=;
 b=PhLUvIAQR0mMZFMJcPZJevX8uZkv81VOl6c1aGNCA3PaeVDw/qOKVoRiB5Q5TzxKbMr6/+BkpwYj5MfKXBa/88a2XhFHSlfP/elNfKr8qztrtB1nvJ2bXfnBcaYSzkqLNS1V07K+m4iSXrciiGQYKFGLuayYQnwn+xojoU022ME=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5990.namprd07.prod.outlook.com (20.179.92.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Mon, 12 Aug 2019 11:10:28 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::98f2:1592:6dff:63e%7]) with mapi id 15.20.2136.022; Mon, 12 Aug 2019
 11:10:28 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
Subject: RE: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Topic: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Thread-Index: AQHVP/LMLOdqGz4qV0qb+zFnj54Ok6bvscSAgAYO39CAAap0AIAABbSQ
Date:   Mon, 12 Aug 2019 11:10:28 +0000
Message-ID: <BYAPR07MB470958966C67A72C856A156DDDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <1563733939-21214-6-git-send-email-pawell@cadence.com>
 <88742d5b-ee10-cf4e-6724-58e7bdd19cb9@ti.com>
 <BYAPR07MB47090BCA728600F0C2F4E129DDD00@BYAPR07MB4709.namprd07.prod.outlook.com>
 <c5c52dae-21c8-340a-cbca-5f269dabb890@ti.com>
In-Reply-To: <c5c52dae-21c8-340a-cbca-5f269dabb890@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctODdlYTQ3NzUtYmNmMS0xMWU5LTg3NDUtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDg3ZWE0Nzc2LWJjZjEtMTFlOS04NzQ1LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iOTk0NSIgdD0iMTMyMTAwODE3MTc1NDk3NDg0IiBoPSJ6Z2dBRU0ydTFvWWtPVmFHTWw4RTRQdGEyZjQ9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [158.140.1.28]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1597632-f3cf-4faa-f1c6-08d71f15aeca
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR07MB5990;
x-ms-traffictypediagnostic: BYAPR07MB5990:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB599042615C6D5EC34A05DC67DDD30@BYAPR07MB5990.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(36092001)(189003)(199004)(52536014)(26005)(9686003)(7696005)(5660300002)(76176011)(478600001)(99286004)(6506007)(53546011)(53936002)(102836004)(316002)(4326008)(71200400001)(71190400001)(25786009)(2501003)(6246003)(110136005)(305945005)(74316002)(81156014)(81166006)(54906003)(486006)(55016002)(14454004)(6436002)(14444005)(6116002)(3846002)(256004)(2906002)(229853002)(476003)(446003)(8676002)(66066001)(186003)(76116006)(33656002)(66446008)(64756008)(66476007)(11346002)(66556008)(86362001)(66946007)(8936002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5990;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LfxH9+oU0xl4xmCT0Ok+G0rwTd/Uv14ZtmsQ8hbFc0s5xpIxJ/KJ/c7S+ZoguS0u62Ewm7z1xQyIvI2sH1/zRa3iaV9leD7JZ0JbeglbG+zQy94N0ujKHA7A/IpAFixD6plCmDJpqbMmt1OyRKUuFTewAEf4lUJ0S/jVCoAbF4jZPPIJvI2vivPQ/4BOCEnBkly5ZcHD5siXqg1RWRhmC74ttfT2OupJhTRSCUbzE9ElFVPjQCGBWYKg7wn0k1NrZgNTP8JpSAdZ10HpCiwn2X0SSY5pCcwzbP/Uhd5+A7Ye70NmMjWs6n/OkvEvVW/vJHU9+gnVtsWEq8N/u6Bqpa5y6yLtuWrEYZCfSojWwJi0NqAScf6Sb1WF25pZqFzGcwEQwspgSwlbIPd2yfLMyTE45S9qXQqmY3lwK+zOf8Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1597632-f3cf-4faa-f1c6-08d71f15aeca
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 11:10:28.1585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pawell@global.cadence.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5990
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf.smktg.jp include:_spf.salesforce.com
 include:mktomail.com include:spf-0014ca01.pphosted.com
 include:spf.protection.outlook.com include:auth.msgapp.com
 include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pg0KPk9uIDExLzA4LzIwMTkgMTQ6NTksIFBhd2VsIExhc3pjemFrIHdyb3RlOg0KPj4gSGksDQo+
Pg0KPj4+DQo+Pj4gT24gMjEvMDcvMjAxOSAyMTozMiwgUGF3ZWwgTGFzemN6YWsgd3JvdGU6DQo+
Pj4+IFRoaXMgcGF0Y2ggaW50cm9kdWNlIG5ldyBDYWRlbmNlIFVTQlNTIERSRCBkcml2ZXIgdG8g
TGludXgga2VybmVsLg0KPj4+Pg0KPj4+PiBUaGUgQ2FkZW5jZSBVU0JTUyBEUkQgQ29udHJvbGxl
ciBpcyBhIGhpZ2hseSBjb25maWd1cmFibGUgSVAgQ29yZSB3aGljaA0KPj4+PiBjYW4gYmUgaW5z
dGFudGlhdGVkIGFzIER1YWwtUm9sZSBEZXZpY2UgKERSRCksIFBlcmlwaGVyYWwgT25seSBhbmQN
Cj4+Pj4gSG9zdCBPbmx5IChYSENJKWNvbmZpZ3VyYXRpb25zLg0KPj4+Pg0KPj4+PiBUaGUgY3Vy
cmVudCBkcml2ZXIgaGFzIGJlZW4gdmFsaWRhdGVkIHdpdGggRlBHQSBwbGF0Zm9ybS4gV2UgaGF2
ZQ0KPj4+PiBzdXBwb3J0IGZvciBQQ0llIGJ1cywgd2hpY2ggaXMgdXNlZCBvbiBGUEdBIHByb3Rv
dHlwaW5nLg0KPj4+Pg0KPj4+PiBUaGUgaG9zdCBzaWRlIG9mIFVTQlNTLURSRCBjb250cm9sbGVy
IGlzIGNvbXBsaWFudCB3aXRoIFhIQ0kNCj4+Pj4gc3BlY2lmaWNhdGlvbiwgc28gaXQgd29ya3Mg
d2l0aCBzdGFuZGFyZCBYSENJIExpbnV4IGRyaXZlci4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1i
eTogUGF3ZWwgTGFzemN6YWsgPHBhd2VsbEBjYWRlbmNlLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICBk
cml2ZXJzL3VzYi9LY29uZmlnICAgICAgICAgICAgICAgIHwgICAgMiArDQo+Pj4+ICBkcml2ZXJz
L3VzYi9NYWtlZmlsZSAgICAgICAgICAgICAgIHwgICAgMiArDQo+Pj4+ICBkcml2ZXJzL3VzYi9j
ZG5zMy9LY29uZmlnICAgICAgICAgIHwgICA0NiArDQo+Pj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9N
YWtlZmlsZSAgICAgICAgIHwgICAxNyArDQo+Pj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9jZG5zMy1w
Y2ktd3JhcC5jIHwgIDIwMyArKysNCj4+Pj4gIGRyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYyAgICAg
ICAgICAgfCAgNTU0ICsrKysrKysNCj4+Pj4gIGRyaXZlcnMvdXNiL2NkbnMzL2NvcmUuaCAgICAg
ICAgICAgfCAgMTA5ICsrDQo+Pj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9kZWJ1Zy5oICAgICAgICAg
IHwgIDE3MSArKw0KPj4+PiAgZHJpdmVycy91c2IvY2RuczMvZGVidWdmcy5jICAgICAgICB8ICAg
ODcgKysNCj4+Pj4gIGRyaXZlcnMvdXNiL2NkbnMzL2RyZC5jICAgICAgICAgICAgfCAgMzkwICsr
KysrDQo+Pj4+ICBkcml2ZXJzL3VzYi9jZG5zMy9kcmQuaCAgICAgICAgICAgIHwgIDE2NiArKw0K
Pj4+PiAgZHJpdmVycy91c2IvY2RuczMvZXAwLmMgICAgICAgICAgICB8ICA5MTQgKysrKysrKysr
KysNCj4+Pj4gIGRyaXZlcnMvdXNiL2NkbnMzL2dhZGdldC1leHBvcnQuaCAgfCAgIDI4ICsNCj4+
Pj4gIGRyaXZlcnMvdXNiL2NkbnMzL2dhZGdldC5jICAgICAgICAgfCAyMzM4ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4+Pj4gIGRyaXZlcnMvdXNiL2NkbnMzL2dhZGdldC5oICAgICAg
ICAgfCAxMzIxICsrKysrKysrKysrKysrKysNCj4+Pj4gIGRyaXZlcnMvdXNiL2NkbnMzL2hvc3Qt
ZXhwb3J0LmggICAgfCAgIDI4ICsNCj4+Pj4gIGRyaXZlcnMvdXNiL2NkbnMzL2hvc3QuYyAgICAg
ICAgICAgfCAgIDcxICsNCj4+Pj4gIGRyaXZlcnMvdXNiL2NkbnMzL3RyYWNlLmMgICAgICAgICAg
fCAgIDExICsNCj4+Pj4gIGRyaXZlcnMvdXNiL2NkbnMzL3RyYWNlLmggICAgICAgICAgfCAgNDkz
ICsrKysrKw0KPj4+PiAgMTkgZmlsZXMgY2hhbmdlZCwgNjk1MSBpbnNlcnRpb25zKCspDQo+Pj4+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvY2RuczMvS2NvbmZpZw0KPj4+PiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL01ha2VmaWxlDQo+Pj4+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy91c2IvY2RuczMvY2RuczMtcGNpLXdyYXAuYw0KPj4+PiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYw0KPj4+PiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL2NvcmUuaA0KPj4+PiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvdXNiL2NkbnMzL2RlYnVnLmgNCj4+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL3VzYi9jZG5zMy9kZWJ1Z2ZzLmMNCj4+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL3VzYi9jZG5zMy9kcmQuYw0KPj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNi
L2NkbnMzL2RyZC5oDQo+Pj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvY2RuczMv
ZXAwLmMNCj4+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3VzYi9jZG5zMy9nYWRnZXQt
ZXhwb3J0LmgNCj4+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3VzYi9jZG5zMy9nYWRn
ZXQuYw0KPj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL2dhZGdldC5o
DQo+Pj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvY2RuczMvaG9zdC1leHBvcnQu
aA0KPj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL2hvc3QuYw0KPj4+
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdXNiL2NkbnMzL3RyYWNlLmMNCj4+Pj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3VzYi9jZG5zMy90cmFjZS5oDQo+Pj4+DQo+DQo+PHNu
aXA+DQo+DQo+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NkbnMzL2dhZGdldC5j
IGIvZHJpdmVycy91c2IvY2RuczMvZ2FkZ2V0LmMNCj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi4yOTFmMDhiZTU2ZmUNCj4+Pj4gLS0tIC9kZXYvbnVs
bA0KPj4+PiArKysgYi9kcml2ZXJzL3VzYi9jZG5zMy9nYWRnZXQuYw0KPj4+PiBAQCAtMCwwICsx
LDIzMzggQEANCj4+Pj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+Pj4+
ICsvKg0KPj4+PiArICogQ2FkZW5jZSBVU0JTUyBEUkQgRHJpdmVyIC0gZ2FkZ2V0IHNpZGUuDQo+
Pj4+ICsgKg0KPj4+PiArICogQ29weXJpZ2h0IChDKSAyMDE4LTIwMTkgQ2FkZW5jZSBEZXNpZ24g
U3lzdGVtcy4NCj4+Pj4gKyAqIENvcHlyaWdodCAoQykgMjAxNy0yMDE4IE5YUA0KPj4+PiArICoN
Cj4+Pj4gKyAqIEF1dGhvcnM6IFBhd2VsIEpleiA8cGplekBjYWRlbmNlLmNvbT4sDQo+Pj4+ICsg
KiAgICAgICAgICBQYXdlbCBMYXN6Y3phayA8cGF3ZWxsQGNhZGVuY2UuY29tPg0KPj4+PiArICog
ICAgICAgICAgUGV0ZXIgQ2hlbiA8cGV0ZXIuY2hlbkBueHAuY29tPg0KPj4+PiArICovDQo+Pj4+
ICsNCj4+Pg0KPj4+IDxzbmlwPg0KPj4+DQo+Pj4+ICsvKioNCj4+Pj4gKyAqIGNkbnMzX2Rldmlj
ZV9pcnFfaGFuZGxlci0gaW50ZXJydXB0IGhhbmRsZXIgZm9yIGRldmljZSBwYXJ0IG9mIGNvbnRy
b2xsZXINCj4+Pj4gKyAqDQo+Pj4+ICsgKiBAaXJxOiBpcnEgbnVtYmVyIGZvciBjZG5zMyBjb3Jl
IGRldmljZQ0KPj4+PiArICogQGRhdGE6IHN0cnVjdHVyZSBvZiBjZG5zMw0KPj4+PiArICoNCj4+
Pj4gKyAqIFJldHVybnMgSVJRX0hBTkRMRUQgb3IgSVJRX05PTkUNCj4+Pj4gKyAqLw0KPj4+PiAr
c3RhdGljIGlycXJldHVybl90IGNkbnMzX2RldmljZV9pcnFfaGFuZGxlcihpbnQgaXJxLCB2b2lk
ICpkYXRhKQ0KPj4+PiArew0KPj4+PiArCXN0cnVjdCBjZG5zM19kZXZpY2UgKnByaXZfZGV2Ow0K
Pj4+PiArCXN0cnVjdCBjZG5zMyAqY2RucyA9IGRhdGE7DQo+Pj4+ICsJaXJxcmV0dXJuX3QgcmV0
ID0gSVJRX05PTkU7DQo+Pj4+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4+Pj4gKwl1MzIgcmVn
Ow0KPj4+PiArDQo+Pj4+ICsJcHJpdl9kZXYgPSBjZG5zLT5nYWRnZXRfZGV2Ow0KPj4+PiArCXNw
aW5fbG9ja19pcnFzYXZlKCZwcml2X2Rldi0+bG9jaywgZmxhZ3MpOw0KPj4+PiArDQo+Pj4+ICsJ
LyogY2hlY2sgVVNCIGRldmljZSBpbnRlcnJ1cHQgKi8NCj4+Pj4gKwlyZWcgPSByZWFkbCgmcHJp
dl9kZXYtPnJlZ3MtPnVzYl9pc3RzKTsNCj4+Pj4gKw0KPj4+PiArCWlmIChyZWcpIHsNCj4+Pj4g
KwkJd3JpdGVsKHJlZywgJnByaXZfZGV2LT5yZWdzLT51c2JfaXN0cyk7DQo+Pj4NCj4+PiBEbyB3
ZSBuZWVkIHRvIG1hc2sgZGV2aWNlIGludGVycnVwdHMgdGlsbCB0aHJlYWQgaGFuZGxlciBoYXMg
ZG9uZSBwcm9jZXNzaW5nDQo+Pj4gY3VycmVudCBzZXQgb2YgZXZlbnRzPw0KPj4NCj4+IFllcywg
d2UgbmVlZCBkbyB0aGlzIHRvIGF2b2lkIHJhaXNpbmcgdGhlIG5leHQgdGhlIHNhbWUgaW50ZXJy
dXB0cy4NCj4+IElmIHdlIHJldHVybiBiYWNrIGZyb20gaGFyZCBpcnEgaGFuZGxlciB3aXRob3V0
IGNsZWFyaW5nIHJlcG9ydGVkIGludGVycnVwdHMsDQo+PiB0aGVuIHN5c3RlbSByZXBvcnQgdGhl
bSBhZ2Fpbi4gVGhlIHNvbHV0aW9uIGZvciB0aGlzIGlzIHRvIHVzZSBJUlFGX09ORVNIT1QNCj4+
IGZsYWcgZHVyaW5nIHJlZ2lzdGVyaW5nIGludGVycnVwdCwgYnV0IEkgY2FuJ3QgdXNlIHRoaXMg
ZmxhZw0KPj4gYmVjYXVzZSBJIGhhdmUgc2hhcmVkIGludGVycnVwdCBsaW5lIHdpdGggb3RoZXIg
Y29tcG9uZW50Lg0KPj4NCj4+IEluIHRoaXMgdmVyc2lvbiB0aGVzZSAodXNiX2lzdHMpIGludGVy
cnVwdHMgYXJlIGhhbmRsZWQgaW4gaGFyZCBpcnEsIGJ1dCBpbiBuZXh0IHZlcnNpb24NCj4+IHdp
bGwgYmUgbW92ZWQgdG8gdGhyZWFkIGhhbmRsZXIuDQo+Pg0KPj4+PiArCQljZG5zM19jaGVja191
c2JfaW50ZXJydXB0X3Byb2NlZWQocHJpdl9kZXYsIHJlZyk7DQo+Pj4+ICsJCXJldCA9IElSUV9I
QU5ETEVEOw0KPj4+PiArCX0NCj4+Pj4gKw0KPj4+PiArCS8qIGNoZWNrIGVuZHBvaW50IGludGVy
cnVwdCAqLw0KPj4+PiArCXJlZyA9IHJlYWRsKCZwcml2X2Rldi0+cmVncy0+ZXBfaXN0cyk7DQo+
Pj4+ICsNCj4+Pj4gKwlpZiAocmVnKSB7DQo+Pj4+ICsJCXByaXZfZGV2LT5zaGFkb3dfZXBfZW4g
fD0gcmVnOw0KPj4+PiArCQlyZWcgPSB+cmVnICYgcmVhZGwoJnByaXZfZGV2LT5yZWdzLT5lcF9p
ZW4pOw0KPj4+PiArCQkvKiBtYXNrIGRlZmVycmVkIGludGVycnVwdC4gKi8NCj4+Pj4gKwkJd3Jp
dGVsKHJlZywgJnByaXZfZGV2LT5yZWdzLT5lcF9pZW4pOw0KPj4+PiArCQlyZXQgPSBJUlFfV0FL
RV9USFJFQUQ7DQo+Pj4+ICsJfQ0KPj4+PiArDQo+Pj4+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmcHJpdl9kZXYtPmxvY2ssIGZsYWdzKTsNCj4+Pj4gKwlyZXR1cm4gcmV0Ow0KPj4+PiArfQ0K
Pj4+PiArDQo+Pj4NCj4+PiA8c25pcD4NCj4+Pg0KPj4+PiArDQo+Pj4+ICtzdGF0aWMgaW50IGNk
bnMzX2dhZGdldF9zdGFydChzdHJ1Y3QgY2RuczMgKmNkbnMpDQo+Pj4+ICt7DQo+Pj4+ICsJc3Ry
dWN0IGNkbnMzX2RldmljZSAqcHJpdl9kZXY7DQo+Pj4+ICsJdTMyIG1heF9zcGVlZDsNCj4+Pj4g
KwlpbnQgcmV0Ow0KPj4+PiArDQo+Pj4+ICsJcHJpdl9kZXYgPSBremFsbG9jKHNpemVvZigqcHJp
dl9kZXYpLCBHRlBfS0VSTkVMKTsNCj4+Pj4gKwlpZiAoIXByaXZfZGV2KQ0KPj4+PiArCQlyZXR1
cm4gLUVOT01FTTsNCj4+Pj4gKw0KPj4+PiArCWNkbnMtPmdhZGdldF9kZXYgPSBwcml2X2RldjsN
Cj4+Pj4gKwlwcml2X2Rldi0+c3lzZGV2ID0gY2Rucy0+ZGV2Ow0KPj4+PiArCXByaXZfZGV2LT5k
ZXYgPSBjZG5zLT5kZXY7DQo+Pj4+ICsJcHJpdl9kZXYtPnJlZ3MgPSBjZG5zLT5kZXZfcmVnczsN
Cj4+Pj4gKw0KPj4+PiArCWRldmljZV9wcm9wZXJ0eV9yZWFkX3UxNihwcml2X2Rldi0+ZGV2LCAi
Y2Rucyxvbi1jaGlwLWJ1ZmYtc2l6ZSIsDQo+Pj4+ICsJCQkJICZwcml2X2Rldi0+b25jaGlwX2J1
ZmZlcnMpOw0KPj4+PiArDQo+Pj4+ICsJaWYgKHByaXZfZGV2LT5vbmNoaXBfYnVmZmVycyA8PSAg
MCkgew0KPj4+PiArCQl1MzIgcmVnID0gcmVhZGwoJnByaXZfZGV2LT5yZWdzLT51c2JfY2FwMik7
DQo+Pj4+ICsNCj4+Pj4gKwkJcHJpdl9kZXYtPm9uY2hpcF9idWZmZXJzID0gVVNCX0NBUDJfQUNU
VUFMX01FTV9TSVpFKHJlZyk7DQo+Pj4+ICsJfQ0KPj4+PiArDQo+Pj4+ICsJaWYgKCFwcml2X2Rl
di0+b25jaGlwX2J1ZmZlcnMpDQo+Pj4+ICsJCXByaXZfZGV2LT5vbmNoaXBfYnVmZmVycyA9IDI1
NjsNCj4+Pj4gKw0KPj4+PiArCW1heF9zcGVlZCA9IHVzYl9nZXRfbWF4aW11bV9zcGVlZChjZG5z
LT5kZXYpOw0KPj4+PiArDQo+Pj4+ICsJLyogQ2hlY2sgdGhlIG1heGltdW1fc3BlZWQgcGFyYW1l
dGVyICovDQo+Pj4+ICsJc3dpdGNoIChtYXhfc3BlZWQpIHsNCj4+Pj4gKwljYXNlIFVTQl9TUEVF
RF9GVUxMOg0KPj4+DQo+Pj4gSW4gdGhpcyBjYXNlIHdlIG5lZWQgdG8gbGltaXQgY29udHJvbGxl
ciBtYXggc3BlZWQgdG8gZnVsbC1zcGVlZCBhcyBzeXN0ZW0NCj4+PiBpbnRlZ3JhdG9yIHdvdWxk
IGV4cGVjdCB0aGF0LiBlLmcuIGluIERUIG5vZGUsIG1heGltdW0tc3BlZWQgPSAiZnVsbC1zcGVl
ZCI7DQo+Pj4NCj4+PiBJIHN1cHBvc2Ugd2UgbmVlZCB0byBzZXQgdGhlIGZvcmNlIEZ1bGwtc3Bl
ZWQgYml0IGhlcmU/DQo+Pj4NCj4+Pj4gKwljYXNlIFVTQl9TUEVFRF9ISUdIOg0KPj4+DQo+Pj4g
SGVyZSB3ZSBuZWVkIHRvIHJlc3RyaWN0IGRldmljZSBjb250cm9sbGVyIG1heC1zcGVlZCB0byBo
aWdoLXNwZWVkLg0KPj4+DQo+Pg0KPj4gV2h5IHN5c3RlbSBpbnRlZ3JhdG9yIHdvdWxkIGxpbWl0
IHRoZSBzcGVlZCBvZiBjb250cm9sbGVyPw0KPg0KPlRvIHNhdmUgY29zdD8gRm9yIG1hbnkgdXNl
IGNhc2VzLCBoaWdoLXNwZWVkIGlzIG1vcmUgdGhlbiBzdWZmaWNpZW50Lg0KPg0KDQpJIHRoaW5r
IEkga25vdyB3aGF0IHlvdSBtZWFuLiANCg0KSSd2ZSBhZGQgc3VjaCBmdW5jdGlvbmFsaXR5IHRv
IG5leHQgdmVyc2lvbi4NCiAgDQoNCj4+IEZvciBkZWJ1Z2dpbmcgcHVycG9zZSBpdCdzICBvaywg
YnV0IGluIHByb2R1Y3Rpb24gc3lzdGVtIGl0J3MgYmV0dGVyDQo+PiB0byB1c2UgaGlnaGVyIHNw
ZWVkLg0KPj4gRG8gd2UgcmVsYXkgbmVlZCBzdWNoIGZ1bmN0aW9uYWxpdHkgPw0KPg0KPk1vc3Rs
eSBmb3IgdGVzdGluZyBwdXJwb3NlLiBJIGNhbiBqdXN0IGNoYW5nZSB0aGUgRFQgbm9kZSdzIHNw
ZWVkIHByb3BlcnR5DQo+dG8gdGhlIGxvd2VyIHNwZWVkIHRvIGxpbWl0IHRoZSBjb250cm9sbGVy
IHRvIHRoYXQgc3BlZWQuDQo+DQo+SWYgd2UgY2FuIGFjaGlldmUgdGhhdCB3aXRoIGEgZmV3IGxp
bmVzIG9mIGNvZGUsIHdoeSBub3Qgc3VwcG9ydCBpdD8NCj4NCj4+DQo+Pj4+ICsJY2FzZSBVU0Jf
U1BFRURfU1VQRVI6DQo+Pj4+ICsJCWJyZWFrOw0KPj4+PiArCWRlZmF1bHQ6DQo+Pj4+ICsJCWRl
dl9lcnIoY2Rucy0+ZGV2LCAiaW52YWxpZCBtYXhpbXVtX3NwZWVkIHBhcmFtZXRlciAlZFxuIiwN
Cj4+Pj4gKwkJCW1heF9zcGVlZCk7DQo+Pj4+ICsJCS8qIGZhbGwgdGhyb3VnaCAqLw0KPj4+PiAr
CWNhc2UgVVNCX1NQRUVEX1VOS05PV046DQo+Pj4+ICsJCS8qIGRlZmF1bHQgdG8gc3VwZXJzcGVl
ZCAqLw0KPj4+PiArCQltYXhfc3BlZWQgPSBVU0JfU1BFRURfU1VQRVI7DQo+Pj4+ICsJCWJyZWFr
Ow0KPj4+PiArCX0NCj4+Pj4gKw0KPj4+PiArCS8qIGZpbGwgZ2FkZ2V0IGZpZWxkcyAqLw0KPj4+
PiArCXByaXZfZGV2LT5nYWRnZXQubWF4X3NwZWVkID0gbWF4X3NwZWVkOw0KPj4+PiArCXByaXZf
ZGV2LT5nYWRnZXQuc3BlZWQgPSBVU0JfU1BFRURfVU5LTk9XTjsNCj4+Pj4gKwlwcml2X2Rldi0+
Z2FkZ2V0Lm9wcyA9ICZjZG5zM19nYWRnZXRfb3BzOw0KPj4+PiArCXByaXZfZGV2LT5nYWRnZXQu
bmFtZSA9ICJ1c2Itc3MtZ2FkZ2V0IjsNCj4+Pj4gKwlwcml2X2Rldi0+Z2FkZ2V0LnNnX3N1cHBv
cnRlZCA9IDE7DQo+Pj4+ICsNCj4+Pj4gKwlzcGluX2xvY2tfaW5pdCgmcHJpdl9kZXYtPmxvY2sp
Ow0KPj4+PiArCUlOSVRfV09SSygmcHJpdl9kZXYtPnBlbmRpbmdfc3RhdHVzX3dxLA0KPj4+PiAr
CQkgIGNkbnMzX3BlbmRpbmdfc2V0dXBfc3RhdHVzX2hhbmRsZXIpOw0KPj4+PiArDQo+Pj4+ICsJ
LyogaW5pdGlhbGl6ZSBlbmRwb2ludCBjb250YWluZXIgKi8NCj4+Pj4gKwlJTklUX0xJU1RfSEVB
RCgmcHJpdl9kZXYtPmdhZGdldC5lcF9saXN0KTsNCj4+Pj4gKwlJTklUX0xJU1RfSEVBRCgmcHJp
dl9kZXYtPmFsaWduZWRfYnVmX2xpc3QpOw0KPj4+PiArDQo+Pj4+ICsJcmV0ID0gY2RuczNfaW5p
dF9lcHMocHJpdl9kZXYpOw0KPj4+PiArCWlmIChyZXQpIHsNCj4+Pj4gKwkJZGV2X2Vycihwcml2
X2Rldi0+ZGV2LCAiRmFpbGVkIHRvIGNyZWF0ZSBlbmRwb2ludHNcbiIpOw0KPj4+PiArCQlnb3Rv
IGVycjE7DQo+Pj4+ICsJfQ0KPj4+PiArDQo+Pj4+ICsJLyogYWxsb2NhdGUgbWVtb3J5IGZvciBz
ZXR1cCBwYWNrZXQgYnVmZmVyICovDQo+Pj4+ICsJcHJpdl9kZXYtPnNldHVwX2J1ZiA9IGRtYV9h
bGxvY19jb2hlcmVudChwcml2X2Rldi0+c3lzZGV2LCA4LA0KPj4+PiArCQkJCQkJICZwcml2X2Rl
di0+c2V0dXBfZG1hLCBHRlBfRE1BKTsNCj4+Pj4gKwlpZiAoIXByaXZfZGV2LT5zZXR1cF9idWYp
IHsNCj4+Pj4gKwkJcmV0ID0gLUVOT01FTTsNCj4+Pj4gKwkJZ290byBlcnIyOw0KPj4+PiArCX0N
Cj4+Pj4gKw0KPj4+PiArCXByaXZfZGV2LT5kZXZfdmVyID0gcmVhZGwoJnByaXZfZGV2LT5yZWdz
LT51c2JfY2FwNik7DQo+Pj4+ICsNCj4+Pj4gKwlkZXZfZGJnKHByaXZfZGV2LT5kZXYsICJEZXZp
Y2UgQ29udHJvbGxlciB2ZXJzaW9uOiAlMDh4XG4iLA0KPj4+PiArCQlyZWFkbCgmcHJpdl9kZXYt
PnJlZ3MtPnVzYl9jYXA2KSk7DQo+Pj4+ICsJZGV2X2RiZyhwcml2X2Rldi0+ZGV2LCAiVVNCIENh
cGFiaWxpdGllczo6ICUwOHhcbiIsDQo+Pj4+ICsJCXJlYWRsKCZwcml2X2Rldi0+cmVncy0+dXNi
X2NhcDEpKTsNCj4+Pj4gKwlkZXZfZGJnKHByaXZfZGV2LT5kZXYsICJPbi1DaGlwIG1lbW9yeSBj
bmZpZ3VyYXRpb246ICUwOHhcbiIsDQo+Pj4+ICsJCXJlYWRsKCZwcml2X2Rldi0+cmVncy0+dXNi
X2NhcDIpKTsNCj4+Pj4gKw0KPj4+PiArCXByaXZfZGV2LT5kZXZfdmVyID0gR0VUX0RFVl9CQVNF
X1ZFUlNJT04ocHJpdl9kZXYtPmRldl92ZXIpOw0KPj4+PiArDQo+Pj4+ICsJcHJpdl9kZXYtPnps
cF9idWYgPSBremFsbG9jKENETlMzX0VQX1pMUF9CVUZfU0laRSwgR0ZQX0tFUk5FTCk7DQo+Pj4+
ICsJaWYgKCFwcml2X2Rldi0+emxwX2J1Zikgew0KPj4+PiArCQlyZXQgPSAtRU5PTUVNOw0KPj4+
PiArCQlnb3RvIGVycjM7DQo+Pj4+ICsJfQ0KPj4+PiArDQo+Pj4+ICsJLyogYWRkIFVTQiBnYWRn
ZXQgZGV2aWNlICovDQo+Pj4+ICsJcmV0ID0gdXNiX2FkZF9nYWRnZXRfdWRjKHByaXZfZGV2LT5k
ZXYsICZwcml2X2Rldi0+Z2FkZ2V0KTsNCj4+Pj4gKwlpZiAocmV0IDwgMCkgew0KPj4+PiArCQlk
ZXZfZXJyKHByaXZfZGV2LT5kZXYsDQo+Pj4+ICsJCQkiRmFpbGVkIHRvIHJlZ2lzdGVyIFVTQiBk
ZXZpY2UgY29udHJvbGxlclxuIik7DQo+Pj4+ICsJCWdvdG8gZXJyNDsNCj4+Pj4gKwl9DQo+Pj4+
ICsNCj4+Pj4gKwlyZXR1cm4gMDsNCj4+Pj4gK2VycjQ6DQo+Pj4+ICsJa2ZyZWUocHJpdl9kZXYt
PnpscF9idWYpOw0KPj4+PiArZXJyMzoNCj4+Pj4gKwlkbWFfZnJlZV9jb2hlcmVudChwcml2X2Rl
di0+c3lzZGV2LCA4LCBwcml2X2Rldi0+c2V0dXBfYnVmLA0KPj4+PiArCQkJICBwcml2X2Rldi0+
c2V0dXBfZG1hKTsNCj4+Pj4gK2VycjI6DQo+Pj4+ICsJY2RuczNfZnJlZV9hbGxfZXBzKHByaXZf
ZGV2KTsNCj4+Pj4gK2VycjE6DQo+Pj4+ICsJY2Rucy0+Z2FkZ2V0X2RldiA9IE5VTEw7DQo+Pj4+
ICsJcmV0dXJuIHJldDsNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+DQo+DQotLQ0KcGF3ZWxsIA0K
