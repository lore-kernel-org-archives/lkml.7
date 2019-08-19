Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DF3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133BE2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b="n/tjxsaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfHSQat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:30:49 -0400
Received: from mail-eopbgr140128.outbound.protection.outlook.com ([40.107.14.128]:1934
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726879AbfHSQas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:30:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gs21+URyzW/JEtXqQD24k5FKooK/iIhXJL4zxlfX1p2sAQrnPMDcaQSP2QhQZU/MX82vB6JNfOqVphd0Kwy1EmssYVMQ8BRBW/CVAjEPGEVnfCr08SEkENOAAFYAqB52pg7t4lL1iHV0Zj2IU4i1CmlWQNcvmaPlRoZi2kH51yTl2WqOjUTaJAsyvTGwydvZidwfzDXsNcfohYhRIGaa62FOVIppwjfMmWMlOqaYIqq7/s7CQg/D/rRGWXbXq/7i7O/dITWJRz7hRTqYwxRlnPPeoIQkrCnhB3CdzzkiRzD8QQNmQtgfe2A1Z+n31YNNukq2IqWkxclrCxXH0bB/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cp7xxCKrvtXnHJVZzfHCxwsJnjHUlqLGPwU2+8nbkF4=;
 b=ga94OJdlvMOhBWDXGyUmf6BMtd0UCMxRasRw5w5NNLfKpnxZTuPcQ/V8qdf0JK7aVhkKYQcmdxZ9yAU81fJkyDlpzyTjo5PDmq+yL6j2LbC3Si8dnuc4CSv1CSvuYtdg0Ez98q/N172R+DBjhbOBJGU6o3UL6ypw5AdoJbSPUE5gV993NbPoFtvulcOgVsBpgoMRUeUL3TegpDP8cVYBuT/DaEXvQKoFbM8jdfYc+A41J4SLty/yS+EjBK5H4ZhbKGzlaCSmE42lVpqskPI5lhMESbRUPnRHVfy8taVGYtpVY+HsCPKwtccobi1K0y3U7bVcicSSrKlcCk0NdMDwJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cp7xxCKrvtXnHJVZzfHCxwsJnjHUlqLGPwU2+8nbkF4=;
 b=n/tjxsaYiiBxQECkb1YxDFOkBSuzx0BXRW2okWH2u8wifS6kMTz2geV2Ucd1IFTON1imAjB42n2VOWvhaY04T54ymQIP2MMwJh8woVXURLD6ERv0LHLv+/ua15tIUitoelGUAE/uXwBkp7rfXntwEEXgQHEnQHNrQyscpfSScQo=
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com (10.175.22.139) by
 VI1PR0402MB3695.eurprd04.prod.outlook.com (52.134.15.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 16:30:42 +0000
Received: from VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::cd07:8767:22f6:28f5]) by VI1PR0402MB2717.eurprd04.prod.outlook.com
 ([fe80::cd07:8767:22f6:28f5%12]) with mapi id 15.20.2178.018; Mon, 19 Aug
 2019 16:30:42 +0000
From:   Stephen Douthit <stephend@silicom-usa.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: ahci: Lookup PCS register offset based on PCI device
 ID
Thread-Topic: [PATCH] ata: ahci: Lookup PCS register offset based on PCI
 device ID
Thread-Index: AQHVTidIVfq9W1HbR0i2bNtry39Joab0Aj2AgAN9ywCAADnOgIAAFmOAgAAEuYCAABfagIAAyLIAgAD1I4CAAROyAIAAGoqAgAAMi4CAAAaeAIAHzoiA
Date:   Mon, 19 Aug 2019 16:30:41 +0000
Message-ID: <f6399f3a-3899-2663-6667-e967eb43b156@silicom-usa.com>
References: <20190808202415.25166-1-stephend@silicom-usa.com>
 <20190810074317.GA18582@infradead.org>
 <abfa4b20-2916-d89a-f4d3-b27fca5906b2@silicom-usa.com>
 <CAPcyv4g+PdbisZd8=FpB5QiR_FCA2OQ9EqEF9yMAN=XWTYXY1Q@mail.gmail.com>
 <051cb164-19d5-9241-2941-0d866e565339@silicom-usa.com>
 <20190812180613.GA18377@infradead.org>
 <CAA9_cme3saBAJEyob3B1tX=t8keTodWJZMUd1j_v7vPMRU+aXA@mail.gmail.com>
 <20190813072954.GA23417@infradead.org>
 <CAPcyv4h5kCKVyCjomBUY27MJwheDZ8v87+a9K-2YCgyqRWR7eQ@mail.gmail.com>
 <c023a18c-8b70-dc59-3db8-51d3a6b23d3c@silicom-usa.com>
 <CAPcyv4jcaY04nu31oStLc-eCO-+T1iOpxARmAHvPS1jxKF9cQA@mail.gmail.com>
 <40ef7e71-2c87-9853-fcbd-1510b97647f0@silicom-usa.com>
 <CAPcyv4ivzdEKbVepxcyJMmDmb5zG4Zvw+3f0rVJ8FOErK+c27g@mail.gmail.com>
In-Reply-To: <CAPcyv4ivzdEKbVepxcyJMmDmb5zG4Zvw+3f0rVJ8FOErK+c27g@mail.gmail.com>
Reply-To: Stephen Douthit <stephend@silicom-usa.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN8PR04CA0042.namprd04.prod.outlook.com
 (2603:10b6:408:d4::16) To VI1PR0402MB2717.eurprd04.prod.outlook.com
 (2603:10a6:800:b4::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stephend@silicom-usa.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [96.82.2.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa55538a-e369-4fd3-8871-08d724c293d1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0402MB3695;
x-ms-traffictypediagnostic: VI1PR0402MB3695:
x-microsoft-antispam-prvs: <VI1PR0402MB3695F6D5371A3BDFF56D064994A80@VI1PR0402MB3695.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(346002)(39850400004)(396003)(189003)(199004)(99286004)(66946007)(186003)(305945005)(86362001)(71200400001)(71190400001)(316002)(6512007)(3450700001)(66066001)(486006)(2616005)(476003)(6436002)(11346002)(36756003)(81166006)(81156014)(8936002)(8676002)(54906003)(3846002)(4326008)(6116002)(446003)(76176011)(2906002)(6916009)(52116002)(31686004)(43066004)(25786009)(6246003)(478600001)(66556008)(66446008)(229853002)(53936002)(66476007)(64756008)(14454004)(31696002)(7736002)(14444005)(26005)(256004)(102836004)(5660300002)(6506007)(386003)(53546011)(6486002)(3714002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0402MB3695;H:VI1PR0402MB2717.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silicom-usa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iKGqqHA66+QDBbvqoEkF62Yy5eYp/RoGBtRCXwSjQwYtTEwNPw8FtpkPbuPuYcl67aEvNCUN4dBPK59l58VB0A0HjZFSOkMHSox44683MPM1xhXFSpq2kPl5dv4NXFigH8l6owRYwFPvCjToQFElpJsEIfAup9+s/52SvJRtqTJGXsKB77eG9e39OjX2ywF9zzYL/UPXWdOOdwDmZIojaIeREk1PRkQDIQ2MuMS3aQCe0OzsbjrdDjpPqIsI/h77YQXjJL9WpFOlwXnd2zWq4FAfN/hOjhxbbghAjzvGhJ3IccGnsmb28ccrzZLX3Ditves9NS4iC1joLA8yGt+Zn+oF1mpzMy4dMzT0Ky6o2pUTmqWn0AH1ung4L0ZZzECkRjtv2xDWn3ZXNpE7m4I/doPmvTmDhomNcEpE7Yt6lH8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6204DE540A57B443B53161EE94CD99CD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa55538a-e369-4fd3-8871-08d724c293d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 16:30:41.9936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKhmFpmtQiv/kWcJvd9dE5/5CrSZfGvnZAERWxEpMAWWI4+C8YECjFCcrjOLxVNPIkgT6odA+j0MxK5mjB1N3x041fGjLnSrr7RwuTAugI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3695
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xNC8xOSAxOjE3IFBNLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+PiBDYW4geW91IGdldCBz
b21lb25lIGZyb20gdGhlIGNvbnRyb2xsZXIgZGVzaWduIHRlYW0gdG8gZ2l2ZSB1cyBhIGNsZWFy
DQo+PiBhbnN3ZXIgb24gYSByZXZpc2lvbiB3aGVyZSB0aGlzIFBDUyBjaGFuZ2UgaGFwcGVuZWQ/
DQo+Pg0KPj4gSXQgd291bGQgYmUgbmljZSBpZiB3ZSBjb3VsZCBqdXN0IGNoZWNrIFBDSV9SRVZJ
U0lPTl9JRCBvciBzb21ldGhpbmcNCj4+IHNpbWlsYXIuDQo+IA0KPiBJIGRvbid0IHRoaW5rIHN1
Y2ggYSByZWxpYWJsZSBhc3NvY2lhdGlvbiB3aXRoIHJldi1pZCBleGlzdHMsIHRoZT4gaW50ZW50
IHdhcyB0aGF0IHRoZSBPUyBuZWVkIG5ldmVyIGNvbnNpZGVyIFBDUy4NCg0KQ2FuIHlvdSBwbGVh
c2UgYXNrIHRvIGNvbmZpcm0/ICBJdCB3b3VsZCBiZSBhIG11Y2ggc2ltcGxlciBjaGVjayBpZiBp
dA0KaXMgcG9zc2libGUuDQoNCj4gVGhlIHdheSBMaW51eCBpcyB1c2luZw0KPiBpdCBpcyBhbHJl
YWR5IGJyb2tlbiB3aXRoIHRoZSBhc3N1bXB0aW9uIHRoYXQgaXQgaXMgcGVyZm9ybWVkIGFmdGVy
DQo+IGV2ZXJ5IEhPU1RfQ1RMIGJhc2VkIHJlc2V0IHdoaWNoIG9ubHkgcmVzZXRzIG1taW8gc3Bh
Y2UuIEF0IG1vc3QgaXQNCj4gc2hvdWxkIG9ubHkgYmUgcmVxdWlyZWQgYXQgaW5pdGlhbCBQQ0kg
ZGlzY292ZXJ5IGlmZiBwbGF0Zm9ybSBmaXJtd2FyZQ0KPiBmYWlsZWQgdG8gcnVuLg0KDQpUaGlz
IGlzIGEgc2VwYXJhdGUgaXNzdWUuDQoNCkl0J3MgYnJva2VuIGluIHRoZSBzZW5zZSB0aGF0IHRo
ZSBjb2RlIGlzIGNhbGxlZCBtb3JlIG9mdGVuIHRoYXQgaXQNCm5lZWRzIHRvIGJlLCBidXQgcmVz
ZXQgaXNuJ3QgYSBob3QgcGF0aCwgYW5kIHRoZXJlIGFyZSBubyBzaWRlIGVmZmVjdHMNCnRvIGRv
aW5nIHRoaXMgbXVsdGlwbGUgdGltZXMgdGhhdCBJIGNhbiBzZWUuICBBbmQgYXMgeW91IHBvaW50
IG91dCwgbm8NCmJ1ZyByZXBvcnRzLCBzbyBwcmV0dHkgYmVuaWduIGFsbCB0aGluZ3MgY29uc2lk
ZXJlZC4NCg0KV2UgY291bGQgbW92ZSB0aGUgUENTIHF1aXJrIGNvZGUgdG8gYWhjaV9pbml0X29u
ZSgpIHRvIGFkZHJlc3MgdGhpcw0KY29uY2VybiBvbmNlIHRoZXJlJ3MgYWdyZWVtZW50IG9uIHdo
YXQgdGhlIGNyaXRlcmlhIGlzIHRvIHJ1bi9ub3QtcnVuDQp0aGlzIGNvZGUuDQoNCj4gVGhlcmUg
YXJlIG5vIGJ1ZyByZXBvcnRzIHdpdGggdGhlIGN1cnJlbnQNCj4gaW1wbGVtZW50YXRpb24gdGhh
dCBvbmx5IGF0dGVtcHRzIHRvIGVuYWJsZSBiaXRzIGJhc2VkIG9uIFBPUlRTX0lNUEwsDQo+IHNv
IEkgdGhpbmsgd2UgYXJlIGZpcm1lciBncm91bmQgdHJ5aW5nIHRvIGRyYXcgYSBsaW5lIHdoZXJl
IHRoZSBkcml2ZXINCj4ganVzdCBzdG9wcyB3b3JyeWluZyBhYm91dCBQQ1MgcmF0aGVyIHRoYW4g
dHJ5IHRvIGRldGVjdCB0aGUgbGF5b3V0Lg0KDQpTb21lb25lIGF0IEludGVsIGlzIGdvaW5nIHRv
IG5lZWQgdG8gZGVjaWRlIHdoZXJlL2hvdyB0byBkcmF3IHRoaXMgbGluZS4NCg==
