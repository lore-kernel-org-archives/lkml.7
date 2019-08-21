Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DE2C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DC322D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Eecgw/Mt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfHUIjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:39:16 -0400
Received: from mail-eopbgr770101.outbound.protection.outlook.com ([40.107.77.101]:60998
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726828AbfHUIjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:39:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiXK8SyxoPGRaYZJVsr0wnirqF1cgNSE2uBLMSi4GrW2B1B2AL+2DuWN4HTw9GmiuqIkZrjHwANsz6GDckS77nBLneYeRyv7FgeimC7dT6Sy7rx2d19uElTq0/dICD8sTulzx5wSQmAmPvwtwTGUXzQtwlzvY4XX/0d15ADuB+QxERZyhPJB32BoPCgNN2i1CP6vluYWSTLrciypvHnD6+WDvZTWZhd7jTloWMCUzBipS6GBio9CyUkhDPNhx8pxpIO7lCPlTyU2oMPYM92L76O8fP6Rv5poZd90ts3f++MyE/cyvoLngjYnSfXl054RTV1hcF2XYE+iKx5vvUfKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pt3xRo1s5AgWshkdjqj+EGuG9OtQAgQUJFw8J3oZ5fQ=;
 b=LAqiRa78QWhcHEjqi51YEkWhuidDFx+t4OLV3+t2hyRzDTFlBkcLkJVNtnK8Zmrh8SVvLdCubAtAOBQPuVe+SMMl1SJRqm3MlqUqIfzJ3OOzCJpDyTGZC8tzam9vzcrbr2Elyk4DRcwqWx/xI7atgt5v75NSMjOvUWevzSd3IakqbBSSPxLKk6F7c+oqaDkW9ijCYYaXpKF8C4zoSl/nohYyB0aPrrsM8roFhi+EeQzU2+Mo5hIHME9vK2+8uc9UGKz8ByVuMKQ/Hk6YqC3FeKfq68fxAGfEz/Gp32fDfecU4J41mD9jej4bDep8cNqJ1tca6OVk5rUq1y6IWxL1lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pt3xRo1s5AgWshkdjqj+EGuG9OtQAgQUJFw8J3oZ5fQ=;
 b=Eecgw/Mtt2t1ZQwQGK1YosPoJBIpwEtNxa3eKO8PthKMuJaNHgjLTe78pceWhcuAdEyFD5hLbzm4gP8dr4qY6jXqIoLEC/AFpPg48ST9Lc2eHI7XdTo/OTmc6rh1sKhIQzFl5eolLjwgn9KY5sDFYUi6el2ktBa2DiCpX09BeLI=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.11; Wed, 21 Aug 2019 08:39:09 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d%11]) with mapi id 15.20.2220.000; Wed, 21 Aug
 2019 08:39:09 +0000
From:   Long Li <longli@microsoft.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] nvme: complete request in work queue on CPU with
 flooded interrupts
Thread-Topic: [PATCH 3/3] nvme: complete request in work queue on CPU with
 flooded interrupts
Thread-Index: AQHVVx6V8EslWtuw80WR9kecrOlyh6cETI8AgAD8sjA=
Date:   Wed, 21 Aug 2019 08:39:09 +0000
Message-ID: <CY4PR21MB0741E77B05835E1192415943CEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <1566281669-48212-4-git-send-email-longli@linuxonhyperv.com>
 <2a30a07f-982c-c291-e263-0cf72ec61235@grimberg.me>
In-Reply-To: <2a30a07f-982c-c291-e263-0cf72ec61235@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:7:ede6:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 911d40a0-fc11-4484-6cef-08d72613091b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR21MB0149B168A6F5E252154D6FC7CEAA0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(51914003)(189003)(199004)(71200400001)(71190400001)(22452003)(46003)(55016002)(66476007)(14444005)(256004)(2201001)(7696005)(6306002)(2501003)(6116002)(186003)(476003)(9686003)(486006)(66556008)(2906002)(64756008)(66446008)(76116006)(66946007)(11346002)(446003)(6436002)(74316002)(76176011)(10090500001)(8936002)(5660300002)(305945005)(7736002)(110136005)(8990500004)(6506007)(316002)(102836004)(229853002)(478600001)(81156014)(81166006)(86362001)(8676002)(25786009)(99286004)(14454004)(6246003)(53936002)(52536014)(33656002)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0741.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5c79Vts2v57XjIBEzpMPM4p7nG9nMDBBtsOIIz3aImMjQYDt/5v+YB5BPHlD1FLh+jAl5pqw1M3OCexRxzxaVYdDIhhEYiAtwyAmcxzBMiByGZw6p1S2Vqa+GMHS1xQaBq0ntczu8v2h7bCyowyCp+7nBmhvkrxpZxAR48TLgcnVcTWZM5MO/vF+lv7+AxFrldKUkCAroDxNLcbblB4YlWtWUObhxsn6HotmOKrx333+4EZuPyuJ+LsusAWXpAeDV+If5ZxvK3zeUpcuWcr+FzX0pjIQPFVW4QLWYfJwnFNTbJ/kKCHuZgLy31DSiehmyXloMGHTNZYwu/XFIfVF9oIakE0FEevtQrp+lB2cZLoUMoCm9GS2f/VL+uWC5TJXzBpguUNwBRoS2ScKyCHl3jjWZJ/UZFIxSj+CPv6LtBg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 911d40a0-fc11-4484-6cef-08d72613091b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 08:39:09.3111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXkQczR/U450j0po/oNZiUkdRSWnDYX/fz9gp+fBKpa/4+ulRCUW4xWcoQpHhP2Dz/Gg8saDClvIqQDRnhn45A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+U3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIG52bWU6IGNvbXBsZXRlIHJlcXVlc3QgaW4gd29y
ayBxdWV1ZSBvbiBDUFUNCj4+PndpdGggZmxvb2RlZCBpbnRlcnJ1cHRzDQo+Pj4NCj4+Pg0KPj4+
PiBGcm9tOiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4+Pj4NCj4+Pj4gV2hlbiBh
IE5WTWUgaGFyZHdhcmUgcXVldWUgaXMgbWFwcGVkIHRvIHNldmVyYWwgQ1BVIHF1ZXVlcywgaXQg
aXMNCj4+Pj4gcG9zc2libGUgdGhhdCB0aGUgQ1BVIHRoaXMgaGFyZHdhcmUgcXVldWUgaXMgYm91
bmQgdG8gaXMgZmxvb2RlZCBieQ0KPj4+PiByZXR1cm5pbmcgSS9PIGZvciBvdGhlciBDUFVzLg0K
Pj4+Pg0KPj4+PiBGb3IgZXhhbXBsZSwgY29uc2lkZXIgdGhlIGZvbGxvd2luZyBzY2VuYXJpbzoN
Cj4+Pj4gMS4gQ1BVIDAsIDEsIDIgYW5kIDMgc2hhcmUgdGhlIHNhbWUgaGFyZHdhcmUgcXVldWUg
Mi4gdGhlIGhhcmR3YXJlDQo+Pj4+IHF1ZXVlIGludGVycnVwdHMgQ1BVIDAgZm9yIEkvTyByZXNw
b25zZSAzLiBwcm9jZXNzZXMgZnJvbSBDUFUgMSwgMiBhbmQNCj4+Pj4gMyBrZWVwIHNlbmRpbmcg
SS9Pcw0KPj4+Pg0KPj4+PiBDUFUgMCBtYXkgYmUgZmxvb2RlZCB3aXRoIGludGVycnVwdHMgZnJv
bSBOVk1lIGRldmljZSB0aGF0IGFyZSBJL08NCj4+Pj4gcmVzcG9uc2VzIGZvciBDUFUgMSwgMiBh
bmQgMy4gVW5kZXIgaGVhdnkgSS9PIGxvYWQsIGl0IGlzIHBvc3NpYmxlDQo+Pj4+IHRoYXQgQ1BV
IDAgc3BlbmRzIGFsbCB0aGUgdGltZSBzZXJ2aW5nIE5WTWUgYW5kIG90aGVyIHN5c3RlbQ0KPj4+
PiBpbnRlcnJ1cHRzLCBidXQgZG9lc24ndCBoYXZlIGEgY2hhbmNlIHRvIHJ1biBpbiBwcm9jZXNz
IGNvbnRleHQuDQo+Pj4+DQo+Pj4+IFRvIGZpeCB0aGlzLCBDUFUgMCBjYW4gc2NoZWR1bGUgYSB3
b3JrIHRvIGNvbXBsZXRlIHRoZSBJL08gcmVxdWVzdA0KPj4+PiB3aGVuIGl0IGRldGVjdHMgdGhl
IHNjaGVkdWxlciBpcyBub3QgbWFraW5nIHByb2dyZXNzLiBUaGlzIHNlcnZlcyBtdWx0aXBsZQ0K
Pj4+cHVycG9zZXM6DQo+Pj4+DQo+Pj4+IDEuIFRoaXMgQ1BVIGhhcyB0byBiZSBzY2hlZHVsZWQg
dG8gY29tcGxldGUgdGhlIHJlcXVlc3QuIFRoZSBvdGhlcg0KPj4+PiBDUFVzIGNhbid0IGlzc3Vl
IG1vcmUgSS9PcyB1bnRpbCBzb21lIHByZXZpb3VzIEkvT3MgYXJlIGNvbXBsZXRlZC4NCj4+Pj4g
VGhpcyBoZWxwcyB0aGlzIENQVSBnZXQgb3V0IG9mIE5WTWUgaW50ZXJydXB0cy4NCj4+Pj4NCj4+
Pj4gMi4gVGhpcyBhY3RzIGEgdGhyb3R0bGluZyBtZWNoYW5pc3VtIGZvciBOVk1lIGRldmljZXMs
IGluIHRoYXQgaXQgY2FuDQo+Pj4+IG5vdCBzdGFydmUgYSBDUFUgd2hpbGUgc2VydmljaW5nIEkv
T3MgZnJvbSBvdGhlciBDUFVzLg0KPj4+Pg0KPj4+PiAzLiBUaGlzIENQVSBjYW4gbWFrZSBwcm9n
cmVzcyBvbiBSQ1UgYW5kIG90aGVyIHdvcmsgaXRlbXMgb24gaXRzIHF1ZXVlLg0KPj4+DQo+Pj5U
aGUgcHJvYmxlbSBpcyBpbmRlZWQgcmVhbCwgYnV0IHRoaXMgaXMgdGhlIHdyb25nIGFwcHJvYWNo
IGluIG15IG1pbmQuDQo+Pj4NCj4+PldlIGFscmVhZHkgaGF2ZSBpcnFwb2xsIHdoaWNoIHRha2Vz
IGNhcmUgcHJvcGVyIGJ1ZGdldGluZyBwb2xsaW5nIGN5Y2xlcw0KPj4+YW5kIG5vdCBob2dnaW5n
IHRoZSBjcHUuDQo+Pj4NCj4+PkkndmUgc2VudCByZmMgZm9yIHRoaXMgcGFydGljdWxhciBwcm9i
bGVtIGJlZm9yZSBbMV0uIEF0IHRoZSB0aW1lIElJUkMsDQo+Pj5DaHJpc3RvcGggc3VnZ2VzdGVk
IHRoYXQgd2Ugd2lsbCBwb2xsIHRoZSBmaXJzdCBiYXRjaCBkaXJlY3RseSBmcm9tIHRoZSBpcnEN
Cj4+PmNvbnRleHQgYW5kIHJlYXAgdGhlIHJlc3QgaW4gaXJxcG9sbCBoYW5kbGVyLg0KDQpUaGFu
a3MgZm9yIHRoZSBwb2ludGVyLiBJIHdpbGwgdGVzdCBhbmQgcmVwb3J0IGJhY2suDQoNCj4+Pg0K
Pj4+WzFdOg0KPj4+aHR0cHM6Ly9uYW0wNi5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHAlM0ElMkYlMkZsaXN0cy4NCj4+PmluZnJhZGVhZC5vcmclMkZwaXBlcm1haWwl
MkZsaW51eC1udm1lJTJGMjAxNi0NCj4+Pk9jdG9iZXIlMkYwMDY0OTcuaHRtbCZhbXA7ZGF0YT0w
MiU3QzAxJTdDbG9uZ2xpJTQwbWljcm9zb2Z0LmNvbSUNCj4+PjdDMGViZjM2ZWZmMTVjNDE4MjEx
NjYwOGQ3MjU5NDhiOTMlN0M3MmY5ODhiZjg2ZjE0MWFmOTFhYjJkN2NkMDExZA0KPj4+YjQ3JTdD
MSU3QzAlN0M2MzcwMTkxOTIyNTQyNTAzNjEmYW1wO3NkYXRhPWZKJTJGa2M4SExTbWZ6YVkzQlkN
Cj4+PkU2NnpsWktENkZqY1hnTUpaelZHQ1ZxSSUyRlUlM0QmYW1wO3Jlc2VydmVkPTANCj4+Pg0K
Pj4+SG93IGFib3V0IHNvbWV0aGluZyBsaWtlIHRoaXMgaW5zdGVhZDoNCj4+Pi0tDQo+Pj5kaWZm
IC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMgYi9kcml2ZXJzL252bWUvaG9zdC9wY2ku
YyBpbmRleA0KPj4+NzExMjdhMzY2ZDNjLi44NGJmMTZkNzUxMDkgMTAwNjQ0DQo+Pj4tLS0gYS9k
cml2ZXJzL252bWUvaG9zdC9wY2kuYw0KPj4+KysrIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMN
Cj4+PkBAIC0yNCw2ICsyNCw3IEBADQo+Pj4gICNpbmNsdWRlIDxsaW51eC9pby02NC1ub25hdG9t
aWMtbG8taGkuaD4NCj4+PiAgI2luY2x1ZGUgPGxpbnV4L3NlZC1vcGFsLmg+DQo+Pj4gICNpbmNs
dWRlIDxsaW51eC9wY2ktcDJwZG1hLmg+DQo+Pj4rI2luY2x1ZGUgPGxpbnV4L2lycV9wb2xsLmg+
DQo+Pj4NCj4+PiAgI2luY2x1ZGUgInRyYWNlLmgiDQo+Pj4gICNpbmNsdWRlICJudm1lLmgiDQo+
Pj5AQCAtMzIsNiArMzMsNyBAQA0KPj4+ICAjZGVmaW5lIENRX1NJWkUocSkgICAgICgocSktPnFf
ZGVwdGggKiBzaXplb2Yoc3RydWN0IG52bWVfY29tcGxldGlvbikpDQo+Pj4NCj4+PiAgI2RlZmlu
ZSBTR0VTX1BFUl9QQUdFICAoUEFHRV9TSVpFIC8gc2l6ZW9mKHN0cnVjdCBudm1lX3NnbF9kZXNj
KSkNCj4+PisjZGVmaW5lIE5WTUVfUE9MTF9CVURHRVRfSVJRICAgMjU2DQo+Pj4NCj4+PiAgLyoN
Cj4+PiAgICogVGhlc2UgY2FuIGJlIGhpZ2hlciwgYnV0IHdlIG5lZWQgdG8gZW5zdXJlIHRoYXQg
YW55IGNvbW1hbmQgZG9lc24ndA0KPj4+QEAgLTE4OSw2ICsxOTEsNyBAQCBzdHJ1Y3QgbnZtZV9x
dWV1ZSB7DQo+Pj4gICAgICAgICB1MzIgKmRiYnVmX2NxX2RiOw0KPj4+ICAgICAgICAgdTMyICpk
YmJ1Zl9zcV9laTsNCj4+PiAgICAgICAgIHUzMiAqZGJidWZfY3FfZWk7DQo+Pj4rICAgICAgIHN0
cnVjdCBpcnFfcG9sbCBpb3A7DQo+Pj4gICAgICAgICBzdHJ1Y3QgY29tcGxldGlvbiBkZWxldGVf
ZG9uZTsNCj4+PiAgfTsNCj4+Pg0KPj4+QEAgLTEwMTUsNiArMTAxOCwyMyBAQCBzdGF0aWMgaW5s
aW5lIGludCBudm1lX3Byb2Nlc3NfY3Eoc3RydWN0DQo+Pj5udm1lX3F1ZXVlICpudm1lcSwgdTE2
ICpzdGFydCwNCj4+PiAgICAgICAgIHJldHVybiBmb3VuZDsNCj4+PiAgfQ0KPj4+DQo+Pj4rc3Rh
dGljIGludCBudm1lX2lycXBvbGxfaGFuZGxlcihzdHJ1Y3QgaXJxX3BvbGwgKmlvcCwgaW50IGJ1
ZGdldCkgew0KPj4+KyAgICAgICBzdHJ1Y3QgbnZtZV9xdWV1ZSAqbnZtZXEgPSBjb250YWluZXJf
b2YoaW9wLCBzdHJ1Y3QgbnZtZV9xdWV1ZSwNCj4+PmlvcCk7DQo+Pj4rICAgICAgIHN0cnVjdCBw
Y2lfZGV2ICpwZGV2ID0gdG9fcGNpX2Rldihudm1lcS0+ZGV2LT5kZXYpOw0KPj4+KyAgICAgICB1
MTYgc3RhcnQsIGVuZDsNCj4+PisgICAgICAgaW50IGNvbXBsZXRlZDsNCj4+PisNCj4+PisgICAg
ICAgY29tcGxldGVkID0gbnZtZV9wcm9jZXNzX2NxKG52bWVxLCAmc3RhcnQsICZlbmQsIGJ1ZGdl
dCk7DQo+Pj4rICAgICAgIG52bWVfY29tcGxldGVfY3Flcyhudm1lcSwgc3RhcnQsIGVuZCk7DQo+
Pj4rICAgICAgIGlmIChjb21wbGV0ZWQgPCBidWRnZXQpIHsNCj4+PisgICAgICAgICAgICAgICBp
cnFfcG9sbF9jb21wbGV0ZSgmbnZtZXEtPmlvcCk7DQo+Pj4rICAgICAgICAgICAgICAgZW5hYmxl
X2lycShwY2lfaXJxX3ZlY3RvcihwZGV2LCBudm1lcS0+Y3FfdmVjdG9yKSk7DQo+Pj4rICAgICAg
IH0NCj4+PisNCj4+PisgICAgICAgcmV0dXJuIGNvbXBsZXRlZDsNCj4+Pit9DQo+Pj4rDQo+Pj4g
IHN0YXRpYyBpcnFyZXR1cm5fdCBudm1lX2lycShpbnQgaXJxLCB2b2lkICpkYXRhKQ0KPj4+ICB7
DQo+Pj4gICAgICAgICBzdHJ1Y3QgbnZtZV9xdWV1ZSAqbnZtZXEgPSBkYXRhOyBAQCAtMTAyOCwx
MiArMTA0OCwxNiBAQCBzdGF0aWMNCj4+PmlycXJldHVybl90IG52bWVfaXJxKGludCBpcnEsIHZv
aWQgKmRhdGEpDQo+Pj4gICAgICAgICBybWIoKTsNCj4+PiAgICAgICAgIGlmIChudm1lcS0+Y3Ff
aGVhZCAhPSBudm1lcS0+bGFzdF9jcV9oZWFkKQ0KPj4+ICAgICAgICAgICAgICAgICByZXQgPSBJ
UlFfSEFORExFRDsNCj4+Pi0gICAgICAgbnZtZV9wcm9jZXNzX2NxKG52bWVxLCAmc3RhcnQsICZl
bmQsIC0xKTsNCj4+PisgICAgICAgbnZtZV9wcm9jZXNzX2NxKG52bWVxLCAmc3RhcnQsICZlbmQs
IE5WTUVfUE9MTF9CVURHRVRfSVJRKTsNCj4+PiAgICAgICAgIG52bWVxLT5sYXN0X2NxX2hlYWQg
PSBudm1lcS0+Y3FfaGVhZDsNCj4+PiAgICAgICAgIHdtYigpOw0KPj4+DQo+Pj4gICAgICAgICBp
ZiAoc3RhcnQgIT0gZW5kKSB7DQo+Pj4gICAgICAgICAgICAgICAgIG52bWVfY29tcGxldGVfY3Fl
cyhudm1lcSwgc3RhcnQsIGVuZCk7DQo+Pj4rICAgICAgICAgICAgICAgaWYgKG52bWVfY3FlX3Bl
bmRpbmcobnZtZXEpKSB7DQo+Pj4rICAgICAgICAgICAgICAgICAgICAgICBkaXNhYmxlX2lycV9u
b3N5bmMoaXJxKTsNCj4+PisgICAgICAgICAgICAgICAgICAgICAgIGlycV9wb2xsX3NjaGVkKCZu
dm1lcS0+aW9wKTsNCj4+PisgICAgICAgICAgICAgICB9DQo+Pj4gICAgICAgICAgICAgICAgIHJl
dHVybiBJUlFfSEFORExFRDsNCj4+PiAgICAgICAgIH0NCj4+Pg0KPj4+QEAgLTEzNDcsNiArMTM3
MSw3IEBAIHN0YXRpYyBlbnVtIGJsa19laF90aW1lcl9yZXR1cm4NCj4+Pm52bWVfdGltZW91dChz
dHJ1Y3QgcmVxdWVzdCAqcmVxLCBib29sIHJlc2VydmVkKQ0KPj4+DQo+Pj4gIHN0YXRpYyB2b2lk
IG52bWVfZnJlZV9xdWV1ZShzdHJ1Y3QgbnZtZV9xdWV1ZSAqbnZtZXEpDQo+Pj4gIHsNCj4+Pisg
ICAgICAgaXJxX3BvbGxfZGlzYWJsZSgmbnZtZXEtPmlvcCk7DQo+Pj4gICAgICAgICBkbWFfZnJl
ZV9jb2hlcmVudChudm1lcS0+ZGV2LT5kZXYsIENRX1NJWkUobnZtZXEpLA0KPj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKHZvaWQgKiludm1lcS0+Y3FlcywgbnZtZXEtPmNxX2Rt
YV9hZGRyKTsNCj4+PiAgICAgICAgIGlmICghbnZtZXEtPnNxX2NtZHMpDQo+Pj5AQCAtMTQ4MSw2
ICsxNTA2LDcgQEAgc3RhdGljIGludCBudm1lX2FsbG9jX3F1ZXVlKHN0cnVjdCBudm1lX2Rldg0K
Pj4+KmRldiwgaW50IHFpZCwgaW50IGRlcHRoKQ0KPj4+ICAgICAgICAgbnZtZXEtPmRldiA9IGRl
djsNCj4+PiAgICAgICAgIHNwaW5fbG9ja19pbml0KCZudm1lcS0+c3FfbG9jayk7DQo+Pj4gICAg
ICAgICBzcGluX2xvY2tfaW5pdCgmbnZtZXEtPmNxX3BvbGxfbG9jayk7DQo+Pj4rICAgICAgIGly
cV9wb2xsX2luaXQoJm52bWVxLT5pb3AsIE5WTUVfUE9MTF9CVURHRVRfSVJRLA0KPj4+bnZtZV9p
cnFwb2xsX2hhbmRsZXIpOw0KPj4+ICAgICAgICAgbnZtZXEtPmNxX2hlYWQgPSAwOw0KPj4+ICAg
ICAgICAgbnZtZXEtPmNxX3BoYXNlID0gMTsNCj4+PiAgICAgICAgIG52bWVxLT5xX2RiID0gJmRl
di0+ZGJzW3FpZCAqIDIgKiBkZXYtPmRiX3N0cmlkZV07DQo+Pj4tLQ0K
