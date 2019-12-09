Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE2FC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2E02068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pxeQmvsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfLIOCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:02:19 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:7886 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLIOCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575900138; x=1607436138;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+i/b4CFSEFHJeiq4trv8xtJuqigVv7Z2IWBdQyD0XN8=;
  b=pxeQmvsd6fFlCSgLzx8k9O2cHbz4WvTrqWVct4kt56nzxTMuYzeaMfJb
   AQiHNuSYJD3fKhjX9UOWo9Jso/iRXv52bQt9ElKLOw9VRaBdTuUpSH8pM
   Z5tm5XpDvjP1WMcXIV/SDCrIIMMoT4YnsI9/YRDZUGEnDUb+W1JCVDKkt
   8=;
IronPort-SDR: ZtjWxqRUb6zVEKInpl8mlFv42ZyzVIRguM0rDek4yp66JehlC7VoQgT6RqBV2588FDLhStBdC5
 3qfwaWE0MNzw==
X-IronPort-AV: E=Sophos;i="5.69,294,1571702400"; 
   d="scan'208";a="4027420"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 09 Dec 2019 14:01:47 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id 4569AA22B3;
        Mon,  9 Dec 2019 14:01:44 +0000 (UTC)
Received: from EX13D32EUC002.ant.amazon.com (10.43.164.94) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 14:01:44 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC002.ant.amazon.com (10.43.164.94) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 14:01:44 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Mon, 9 Dec 2019 14:01:43 +0000
From:   "Durrant, Paul" <pdurrant@amazon.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
CC:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>
Subject: RE: [PATCH 4/4] xen-blkback: support dynamic unbind/bind
Thread-Topic: [PATCH 4/4] xen-blkback: support dynamic unbind/bind
Thread-Index: AQHVq3SGozEa3lNeXkCoixgttFczb6ex2l+AgAAA6dA=
Date:   Mon, 9 Dec 2019 14:01:43 +0000
Message-ID: <158cb2845bec457fa54c6dfbd5a9efac@EX13D32EUC003.ant.amazon.com>
References: <20191205140123.3817-1-pdurrant@amazon.com>
 <20191205140123.3817-5-pdurrant@amazon.com>
 <bbf958af-d435-3a56-1e91-e068125a9ce7@suse.com>
In-Reply-To: <bbf958af-d435-3a56-1e91-e068125a9ce7@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.211]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKw7xyZ2VuIEdyb8OfIDxqZ3Jv
c3NAc3VzZS5jb20+DQo+IFNlbnQ6IDA5IERlY2VtYmVyIDIwMTkgMTM6NTgNCj4gVG86IER1cnJh
bnQsIFBhdWwgPHBkdXJyYW50QGFtYXpvbi5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiB4ZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcNCj4gQ2M6IEtvbnJhZCBSemVz
enV0ZWsgV2lsayA8a29ucmFkLndpbGtAb3JhY2xlLmNvbT47IFJvZ2VyIFBhdSBNb25uw6kNCj4g
PHJvZ2VyLnBhdUBjaXRyaXguY29tPjsgSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPjsgQm9y
aXMgT3N0cm92c2t5DQo+IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT47IFN0ZWZhbm8gU3Rh
YmVsbGluaSA8c3N0YWJlbGxpbmlAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCA0
LzRdIHhlbi1ibGtiYWNrOiBzdXBwb3J0IGR5bmFtaWMgdW5iaW5kL2JpbmQNCj4gDQo+IE9uIDA1
LjEyLjE5IDE1OjAxLCBQYXVsIER1cnJhbnQgd3JvdGU6DQo+ID4gQnkgc2ltcGx5IHJlLWF0dGFj
aGluZyB0byBzaGFyZWQgcmluZ3MgZHVyaW5nIGNvbm5lY3RfcmluZygpIHJhdGhlciB0aGFuDQo+
ID4gYXNzdW1pbmcgdGhleSBhcmUgZnJlc2hseSBhbGxvY2F0ZWQgKGkuZSBhc3N1bWluZyB0aGUg
Y291bnRlcnMgYXJlIHplcm8pDQo+ID4gaXQgaXMgcG9zc2libGUgZm9yIHZiZCBpbnN0YW5jZXMg
dG8gYmUgdW5ib3VuZCBhbmQgcmUtYm91bmQgZnJvbSBhbmQgdG8NCj4gPiAocmVzcGVjdGl2ZWx5
KSBhIHJ1bm5pbmcgZ3Vlc3QuDQo+ID4NCj4gPiBUaGlzIGhhcyBiZWVuIHRlc3RlZCBieSBydW5u
aW5nOg0KPiA+DQo+ID4gd2hpbGUgdHJ1ZTsgZG8gZGQgaWY9L2Rldi91cmFuZG9tIG9mPXRlc3Qu
aW1nIGJzPTFNIGNvdW50PTEwMjQ7IGRvbmUNCj4gPg0KPiA+IGluIGEgUFYgZ3Vlc3Qgd2hpbHN0
IHJ1bm5pbmc6DQo+ID4NCj4gPiB3aGlsZSB0cnVlOw0KPiA+ICAgIGRvIGVjaG8gdmJkLSRET01J
RC0kVkJEID51bmJpbmQ7DQo+ID4gICAgZWNobyB1bmJvdW5kOw0KPiA+ICAgIHNsZWVwIDU7DQo+
ID4gICAgZWNobyB2YmQtJERPTUlELSRWQkQgPmJpbmQ7DQo+ID4gICAgZWNobyBib3VuZDsNCj4g
PiAgICBzbGVlcCAzOw0KPiA+ICAgIGRvbmUNCj4gPg0KPiA+IGluIGRvbTAgZnJvbSAvc3lzL2J1
cy94ZW4tYmFja2VuZC9kcml2ZXJzL3ZiZCB0byBjb250aW51b3VzbHkgdW5iaW5kIGFuZA0KPiA+
IHJlLWJpbmQgaXRzIHN5c3RlbSBkaXNrIGltYWdlLg0KPiANCj4gQ291bGQgeW91IGRvIHRoZSBz
YW1lIHRlc3Qgd2l0aCBtaXhlZCByZWFkcy93cml0ZXMgYW5kIHZlcmlmaWNhdGlvbiBvZg0KPiB0
aGUgcmVhZC93cml0dGVuIGRhdGEsIHBsZWFzZT8gQSB3cml0ZS1vbmx5IHRlc3QgaXMgbm90IF90
aGF0Xw0KPiBjb252aW5jaW5nIHJlZ2FyZGluZyBjb3JyZWN0bmVzcy4gSXQgb25seSBwcm92ZXMg
dGhlIGd1ZXN0IGlzIG5vdA0KPiBjcmFzaGluZy4NCg0KU3VyZS4gSSdsbCBmaW5kIHNvbWV0aGlu
ZyB0aGF0IHdpbGwgdmVyaWZ5IGNvbnRlbnQuDQoNCj4gDQo+IEknbSBmaW5lIHdpdGggdGhlIGdl
bmVyYWwgYXBwcm9hY2gsIHRob3VnaC4NCj4gDQoNCkNvb2wsIHRoYW5rcywNCg0KICBQYXVsDQoN
Cj4gDQo+IEp1ZXJnZW4NCg==
