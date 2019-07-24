Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACD9C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C252189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="baRvXfgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfGXR0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:26:15 -0400
Received: from mail-eopbgr820078.outbound.protection.outlook.com ([40.107.82.78]:61600
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387516AbfGXR0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:26:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWmmoW5TyYlLt1RBvQYYUPB4oLLnH91ex79rnwNswhf4Ij85bzTnHyjBDQfaRaehSjbL8BKVvGd2wzdyZc1wca0eTNdnvOBXbAUB9DjJ7Xq3z4cCYKM+j6pA+53fUzWIvFtPfD2nXZC6PG3ashM038DSJv+RpWMF+2Zdx4br0V3CFGSi9b4lf+eN22fuQhMnwN5Xf41oBedHHzX1HgEwukOzUoxf9ppOMjKKh/HICxXODtcS9vtA6KUgkQG7eGrFMdx2UOOv5GW+zJJrpCbmFh8HPDPyzHCMNzODoUOsJFpDbN/CyiXsQPlHT9C6xyti+jW0aPMaEBCFhWuZwPm1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmtHI5/ZLxQTRFvZAo+4Kv67STdPpDGpRGXU/yFl1zw=;
 b=BMhnbA3/2M8U2dsEkFzdibuHxPcBcBRX/VfUdTUH6KdWU1fiOpLs+giE9maIw37OEWjC6HOAK9i3CYqgFIDYv88CBBREDqSrUEwpK/PHW+E24N879q8fHWc+ki4oS9Ilrq38DdBhmANuj6E4Lrc3Z6iNpePDjeJ+FWrkJrPyzF9XL45yZL8ksT7tVJ/9VPWUE0KztlogZA7QdeFjiZF/F/o1BQdBxgmP0KeEG4AozUYIKeTihgYgdPJJx/Iht5dvIcuHKBsxKDgTmc0GOzQrJADfUVYq9zcsWQqi63/1gr3fOu25L2/ePoJ99g6s3KElU+pKXRXPpNIXGhIWC7KtuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=vmware.com;dmarc=pass action=none
 header.from=vmware.com;dkim=pass header.d=vmware.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmtHI5/ZLxQTRFvZAo+4Kv67STdPpDGpRGXU/yFl1zw=;
 b=baRvXfgdcJ8EY0FxOSkIbk9qacCm/V+Oa5Oid4nlPQpG3wdbsaNCcZThOTQ8dQg9XXdv4lcBE4WzdjRDgKK3aUP31HCHJHnuIJWMlPn+TFGfl39ftePrpoH/Wr7QTpvc6RViSQqCrs65ubXecGNIshwb8tUs6+sxom2dP1kJqwM=
Received: from DM5PR05MB3498.namprd05.prod.outlook.com (10.174.242.139) by
 DM5PR05MB3529.namprd05.prod.outlook.com (10.174.242.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.6; Wed, 24 Jul 2019 17:26:10 +0000
Received: from DM5PR05MB3498.namprd05.prod.outlook.com
 ([fe80::7468:9e6c:e02:ee0a]) by DM5PR05MB3498.namprd05.prod.outlook.com
 ([fe80::7468:9e6c:e02:ee0a%5]) with mapi id 15.20.2115.005; Wed, 24 Jul 2019
 17:26:10 +0000
From:   Matt Helsley <mhelsley@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 00/13] Cleanup recordmcount and begin objtool
 conversion
Thread-Topic: [PATCH v2 00/13] Cleanup recordmcount and begin objtool
 conversion
Thread-Index: AQHVIKQfTPMA34zVa0OsodzhmBp0sKbEQykAgAACrwCAFfepAIAACvsA
Date:   Wed, 24 Jul 2019 17:26:10 +0000
Message-ID: <5714C12C-D3D0-47F1-A301-908398B46F72@vmware.com>
References: <cover.1560285597.git.mhelsley@vmware.com>
 <20190710130924.16aee549@gandalf.local.home>
 <20190710171900.gzzitftdinkdx6ra@treble>
 <20190724124652.362a90d0@gandalf.local.home>
In-Reply-To: <20190724124652.362a90d0@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mhelsley@vmware.com; 
x-originating-ip: [73.25.163.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d26f648-cb92-43e6-01e4-08d7105c0534
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR05MB3529;
x-ms-traffictypediagnostic: DM5PR05MB3529:
x-microsoft-antispam-prvs: <DM5PR05MB3529D10AE591339221D6BACBA0C60@DM5PR05MB3529.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(199004)(189003)(478600001)(76116006)(6486002)(71190400001)(71200400001)(256004)(68736007)(14444005)(6512007)(229853002)(6246003)(6916009)(8676002)(6436002)(53936002)(4744005)(305945005)(8936002)(25786009)(7736002)(4326008)(5660300002)(33656002)(3846002)(54906003)(486006)(102836004)(186003)(11346002)(66066001)(81156014)(86362001)(316002)(81166006)(6116002)(36756003)(446003)(476003)(2616005)(2906002)(14454004)(66556008)(66476007)(64756008)(66446008)(6506007)(53546011)(99286004)(76176011)(91956017)(66946007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR05MB3529;H:DM5PR05MB3498.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NF0WINHEuT1ebyiOnXeDXiYYXLA3oBy1tx0U3dbZTAx7BESylwpTuiAsR+gwePenMIpD1qdWMdd8ycbjv55GlGalybYJbOPqlpCivBx9bOV7q0ZIaREynn45NR0e1ZA90Y9uTo1Yg/0hVuDisO1mk9i1oqahXqLgSYGw9U1X5dWFyoAE1k/aKGk/Jj0z0cYoG2+bTv5SBL8Tzyw3RYygE+nKqjkxlt1YMHXgsFrfeFejvBHEKh6IHc2o9PPP2YJWPD1+AhRDaIyOgNyRKrtpuuZc6sIfWp8WiP+OUex5qh8kciXRnGoKC8S2ioUu9PbAvhpxoONHJnWzUpWOHoEZvpkTl/EySydJdFywNWgkPjRLewYbjCsPqHbu6oe6VjEhpw+k5gGPdzasP1pdmOFSI0wKLHmsOvIklUjAhHzRjxc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56D2E01B47F11C44B7CA01D209BFCEF1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d26f648-cb92-43e6-01e4-08d7105c0534
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 17:26:10.5595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhelsley@vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR05MB3529
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSnVsIDI0LCAyMDE5LCBhdCA5OjQ2IEFNLCBTdGV2ZW4gUm9zdGVkdCA8cm9zdGVk
dEBnb29kbWlzLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIDEwIEp1bCAyMDE5IDEyOjE5OjAw
IC0wNTAwDQo+IEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUByZWRoYXQuY29tPiB3cm90ZToNCj4g
DQo+PiBPbiBXZWQsIEp1bCAxMCwgMjAxOSBhdCAwMTowOToyNFBNIC0wNDAwLCBTdGV2ZW4gUm9z
dGVkdCB3cm90ZToNCj4+PiANCj4+PiBKb3NoLA0KPj4+IA0KPj4+IENhbiB5b3UgaGF2ZSBhIGxv
b2sgYXQgdGhlc2U/IEkgY2FuIGFwcGx5IHRoZW0gaWYgeW91IHRoaW5rIHRoZXkgYXJlIE9LLiAg
DQo+PiANCj4+IFNvcnJ5IGZvciB0aGUgZGVsYXkuICBJIGRpZG4ndCBmb3JnZXQgYWJvdXQgaXQs
IGl0J3MganVzdCBiZWVuIGEgaGVjdGljDQo+PiBtb250aC4gIEkgcGxhbiB0byBnaXZlIGl0IGEg
cHJvcGVyIHJldmlldyBzb29uIChpbiB0aGUgbmV4dCB3ZWVrIG9yIHNvKS4NCj4+IA0KPiANCj4g
RnJpZW5kbHkgcmVtaW5kZXIgOy0pDQo+IA0KPiAtLSBTdGV2ZQ0KDQpKdXN0IHRob3VnaHQgSeKA
mWQgYWRkOg0KDQpJIHJlYmFzZWQgeWVzdGVyZGF5IGFuZCBub3RpY2VkIGEgZmV3IG1pbm9yIGNo
YW5nZXMgYXJlIG5lZWRlZCB0byByZXNvbHZlIGNvbmZsaWN0cyB3aXRoIG1haW5saW5lLiBJIHdp
bGwgc2VuZCBhIHYzIG91dCB0b2RheSB3aXRoIHRoZXNlIGNoYW5nZXM6DQoNCglyZW5hbWluZyBl
bGZfb3BlbiB0byBlbGZfcmVhZA0KDQoJc29tZSBrZXJuZWwgYnVpbGQgY2hhbmdlcyAoaW4gTWFr
ZWZpbGUuYnVpbGQpDQoNCkFsc28sIEnigJl2ZSBmaW5pc2hlZCByZW1vdmluZyBhbGwgb2YgdGhl
IG9sZCByZWNvcmRtY291bnQgRUxGIHdyYXBwZXIgY29kZS4gSSBjYW4gc2VuZCBhIGZvbGxvdy1v
biBSRkMgc2VyaWVzIGJ5IEZyaWRheS4NCg0KQ2hlZXJzLA0KICAgICAtTWF0dCBIZWxzbGV5
