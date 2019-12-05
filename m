Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815CCC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FEA24656
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="APYtlSsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfLEPMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:12:47 -0500
Received: from mail-eopbgr690069.outbound.protection.outlook.com ([40.107.69.69]:51962
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbfLEPMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:12:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj5ECAfIfmLrPcOlZ+PQ5FPZCrs2GNuAcLRy12Mg7ENJQOHjWznYffGTLumtpxRbqtuTiX1kDB9P7hY5bTByPPawBUbY6znG40JhU7KMtyy2jZ8dABbK5sckj00NU1g3a/mpkhKMBFB84uolKqGv9qUW2+K41I8PT1rpuEOiQ0Ud/MyphVDl4bRbXGOj7XoE35igLKVBujUO3Nul83JzaNtwjwZC7A2PG2KMWmPPhEvi4x9vtp4c95yDfd61JELnvC2q+iE22axiGVR6Su57RzLOUrUnRQCTPCEmi4X2rc1lKs3M/NPcBBVonDi0dJNgXNrP+aph2Ee4QIGc7ERAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6rp2ItZ7oxsoBs25AUpknfJwPTft/0U4YSLixy+vEs=;
 b=W9Vnxc9eFA7NC+dEU36NgyP5+EvQkePAwZ/Z6k92aPBclY4QRjfSB9Uhae934mMolQC/ySdsPeA3QQA406dh1Q/9LOSIEtd41zv6MsludEwobo8lYSXbCSA98yPNyjMHP5d8RYy6dsR3hnfN+9VyzfsKV5Ql8uB0CSXHZL46Tay++dwt4YGB6acYtHVORWw9eeNFqtmOheKBmUymcdQehS1m9Ldo6WXCs73mlY/STXWnRzsFUdL7ijyLFHhWuD+dUz7dgmYvcJrUBs2hdohsBpRZ0FG4NjThFLkzTNF1qxDyZ1GxO3549vwf9uHPJZpqrzHr/s2Qg/wM+S741kcZUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6rp2ItZ7oxsoBs25AUpknfJwPTft/0U4YSLixy+vEs=;
 b=APYtlSsHR3u9DEsZZetVOvpibynI56D6U5UusLB1tRBy/hev7RoeRxLoD25Pyq9nN014vnKZsYzyo71m6gF4tvWYovdyZA6dQ2qiloItMmuS5+TaMrqTISojWgGJgQaed3lT73BY9iMBMX1gCKYrEevEWIg/6bzu50IYOMn/77s=
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB3755.namprd12.prod.outlook.com (10.255.172.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 15:12:21 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 15:12:21 +0000
From:   "Liu, Zhan" <Zhan.Liu@amd.com>
To:     "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "=dri-devel@lists.freedesktop.org" <=dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Berthe, Abdoulaye" <Abdoulaye.Berthe@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Cornij, Nikola" <Nikola.Cornij@amd.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        =?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: RE: [PATCH] drm: Add FEC registers for LT-tunable repeaters
Thread-Topic: [PATCH] drm: Add FEC registers for LT-tunable repeaters
Thread-Index: AQHVq3Q8llMGZNNWYk20ZjZMWEub66erpa/A
Date:   Thu, 5 Dec 2019 15:12:21 +0000
Message-ID: <DM6PR12MB3466044EF3A6E85160C3E6EF9E5C0@DM6PR12MB3466.namprd12.prod.outlook.com>
References: <20191205135856.232784-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20191205135856.232784-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c195e77-71c8-4e40-a9ba-08d779958705
x-ms-traffictypediagnostic: DM6PR12MB3755:|DM6PR12MB3755:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB375545CF6A1E10F8E5122A029E5C0@DM6PR12MB3755.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:130;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(13464003)(189003)(199004)(99286004)(2906002)(25786009)(54906003)(11346002)(110136005)(4326008)(74316002)(6506007)(76116006)(66476007)(102836004)(9686003)(81156014)(66446008)(64756008)(66556008)(229853002)(8676002)(81166006)(55016002)(186003)(316002)(26005)(53546011)(76176011)(66946007)(52536014)(8936002)(7696005)(33656002)(71200400001)(478600001)(305945005)(966005)(45080400002)(71190400001)(86362001)(5660300002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3755;H:DM6PR12MB3466.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ya+9BqxLodHd7ejsoywQ6xDi6IUsfrBbx9hgmnps4S9TCSFxWWlfOFwsuFL7LbgejsObQlH19ZzLWd1cW5Wp/EXMueVUZ21g+izCu3o0po/hWco6OopeUhBWQq0fS5U5h83jKOVWVV4+3gWdfro4xNy4qu6BKDbKpq0AmwXykq1OskZPmx9mhwxoMdTvLuaYI/vBopos4ZHiQGpOk0R42dKqhx1ByFXneFU53jxK/7pVH8+mVWk4fsRic5TSzlP42caiRsJH6V2g09WSuVqMdTXecmQplUx7etasY/KglTTReH0vJH2BnIjVDHDkmD9iEMgtdXW8uxMhhr/WscRdqKIf7gCBqW/CGuWbM12gUSmZPdOV7fdTmyjEjuQfnmp/M57M8ftML2DohpfgSngLWtLW4aQP4glCgmjYpNeDOtC6h7aZ/6qm/3AW5idoSu6CgE53jxKGNaIMCv4IpdKMuyXf/BuEwJC5uGE7WOI3gy6AKu6ZimDWx8YOURydcrq7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c195e77-71c8-4e40-a9ba-08d779958705
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 15:12:21.7788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjR8En72RiA/+hxpLqhQP6rpCSHycwUPygw4hsSFEZ1o4yXrs1IH2Z5vuuNdkEub
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdm
eC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+IFJvZHJpZ28g
U2lxdWVpcmENCj4gU2VudDogMjAxOS9EZWNlbWJlci8wNSwgVGh1cnNkYXkgODo1OSBBTQ0KPiBU
bzogPWRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogTGksIFN1
biBwZW5nIChMZW8pIDxTdW5wZW5nLkxpQGFtZC5jb20+OyBCZXJ0aGUsIEFiZG91bGF5ZQ0KPiA8
QWJkb3VsYXllLkJlcnRoZUBhbWQuY29tPjsgSmFuaSBOaWt1bGEgPGphbmkubmlrdWxhQGxpbnV4
LmludGVsLmNvbT47DQo+IENvcm5paiwgTmlrb2xhIDxOaWtvbGEuQ29ybmlqQGFtZC5jb20+OyBN
YW5hc2kgTmF2YXJlDQo+IDxtYW5hc2kuZC5uYXZhcmVAaW50ZWwuY29tPjsgV2VudGxhbmQsIEhh
cnJ5DQo+IDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPjsgVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5z
eXJqYWxhQGxpbnV4LmludGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm06IEFkZCBGRUMg
cmVnaXN0ZXJzIGZvciBMVC10dW5hYmxlIHJlcGVhdGVycw0KPiANCj4gRkVDIGlzIHN1cHBvcnRl
ZCBzaW5jZSBEUCAxLjQsIGFuZCBpdCB3YXMgZXhwYW5kZWQgZm9yIExULXR1bmFibGUgaW4gRFAg
MS40YS4NCj4gVGhpcyBjb21taXQgYWRkcyB0aGUgYWRkcmVzcyByZWdpc3RlcnMgZm9yDQo+IEZF
Q19FUlJPUl9DT1VOVF9QSFlfUkVQRUFURVIxIGFuZA0KPiBGRUNfQ0FQQUJJTElUWV9QSFlfUkVQ
RUFURVIxLg0KPiANCj4gQ2M6IEFiZG91bGF5ZSBCZXJ0aGUgPEFiZG91bGF5ZS5CZXJ0aGVAYW1k
LmNvbT4NCj4gQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPg0KPiBD
YzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+DQo+IENjOiBKYW5pIE5pa3VsYSA8amFuaS5u
aWt1bGFAbGludXguaW50ZWwuY29tPg0KPiBDYzogTWFuYXNpIE5hdmFyZSA8bWFuYXNpLmQubmF2
YXJlQGludGVsLmNvbT4NCj4gQ2M6IFZpbGxlIFN5cmrDpGzDpCA8dmlsbGUuc3lyamFsYUBsaW51
eC5pbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFiZG91bGF5ZSBCZXJ0aGUgPEFiZG91bGF5
ZS5CZXJ0aGVAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUm9kcmlnbyBTaXF1ZWlyYSA8Um9k
cmlnby5TaXF1ZWlyYUBhbWQuY29tPg0KDQpMb29rcyBnb29kIHRvIG1lLg0KUmV2aWV3ZWQtYnk6
IFpoYW4gTGl1IDx6aGFuLmxpdUBhbWQuY29tPg0KDQo+IC0tLQ0KPiAgaW5jbHVkZS9kcm0vZHJt
X2RwX2hlbHBlci5oIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2RybV9kcF9oZWxwZXIuaCBiL2luY2x1ZGUv
ZHJtL2RybV9kcF9oZWxwZXIuaA0KPiBpbmRleCA1MWVjYjUxMTJlZjguLmIyMDU3MDA5YWFiYyAx
MDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9kcm0vZHJtX2RwX2hlbHBlci5oDQo+ICsrKyBiL2luY2x1
ZGUvZHJtL2RybV9kcF9oZWxwZXIuaA0KPiBAQCAtMTA0Miw2ICsxMDQyLDggQEANCj4gICNkZWZp
bmUgRFBfU1lNQk9MX0VSUk9SX0NPVU5UX0xBTkUyX1BIWV9SRVBFQVRFUjENCj4gMHhmMDAzOSAv
KiAxLjMgKi8NCj4gICNkZWZpbmUgRFBfU1lNQk9MX0VSUk9SX0NPVU5UX0xBTkUzX1BIWV9SRVBF
QVRFUjENCj4gMHhmMDAzYiAvKiAxLjMgKi8NCj4gICNkZWZpbmUgRFBfRkVDX1NUQVRVU19QSFlf
UkVQRUFURVIxCQkJICAgIDB4ZjAyOTAgLyoNCj4gMS40ICovDQo+ICsjZGVmaW5lIERQX0ZFQ19F
UlJPUl9DT1VOVF9QSFlfUkVQRUFURVIxICAgICAgICAgICAgICAgICAgICAweGYwMjkxIC8qDQo+
IDEuNCAqLw0KPiArI2RlZmluZSBEUF9GRUNfQ0FQQUJJTElUWV9QSFlfUkVQRUFURVIxICAgICAg
ICAgICAgICAgICAgICAgMHhmMDI5NCAvKiAxLjRhDQo+ICovDQo+IA0KPiAgLyogUmVwZWF0ZXIg
bW9kZXMgKi8NCj4gICNkZWZpbmUgRFBfUEhZX1JFUEVBVEVSX01PREVfVFJBTlNQQVJFTlQJCSAg
ICAweDU1ICAgIC8qDQo+IDEuMyAqLw0KPiAtLQ0KPiAyLjI0LjANCj4gDQo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBs
aXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8vbmFtMTEuc2Fm
ZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLg0K
PiBmcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtDQo+IGdmeCZhbXA7
ZGF0YT0wMiU3QzAxJTdDemhhbi5saXUlNDBhbWQuY29tJTdDZmRiZjkyZGNmNzk0NDlkNDM0ZQ0K
PiAyMDhkNzc5OGI1ODZkJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdD
MCU3QzYNCj4gMzcxMTE1MTE3OTMxNzI5MTkmYW1wO3NkYXRhPVNYRGtnRXBJUW1Ua21mRkwwYlhT
QkZ3VnhkOXNTTVdrZQ0KPiBWMzU4ZmtrUVpZJTNEJmFtcDtyZXNlcnZlZD0wDQo=
