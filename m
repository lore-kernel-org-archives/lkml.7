Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C865DC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CF92087E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="J4UiKBbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfIKKoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:44:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:11196 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727093AbfIKKoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:44:13 -0400
X-Greylist: delayed 815 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 06:44:12 EDT
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8BAADk3001591;
        Wed, 11 Sep 2019 03:30:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=TXHvhFiL3qeRqE5TEuGnqsQS7wyZFtDeE2AU+Jzsycw=;
 b=J4UiKBbeDrx2lAXZVLig4gXWKaUWOkTo1K+CVVdogw6Ay5UbwKp9P/3Np6K1GjlKRM9J
 X0gCDh5V4WzCOskS4y2lXrY4JQHByi9fBmcYrJiuEiZGrHouVTcPl64/+frOWv2shFRH
 NeYYFJUcRZysoG9pv+IDp9ttv+SJqdnUi6yGAjR/z9axbbyQoZmdmnkZPy6oVSiPqklW
 ZvwNulXO8DoNOkvP+bO0TbxbfMm8eWLpntsR9sD3NAAGE4QjvgEJKex/rGYzhAG3ZnoS
 yxpRNJZ3y9kl637NC4AT3mF8bst15UA7HMyUazAD14wBQ3ShHSpTRo/Pdhrq6JO+chdk Cw== 
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2054.outbound.protection.outlook.com [104.47.42.54])
        by mx0b-002c1b01.pphosted.com with ESMTP id 2uva3883a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 03:30:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INMIgihpua3n3WDq9RbKLmMCNV4pDVXLjMp5FvvQkuI6Cdm5s54s1xotap7y5ktiBlL1LvAkd91mim0RVg6B75q8M7kYBdGzC0OnzVGl4ofIOxyKY3Ek3a/ANkdafQncVqnRUXjBgzMVyTn6Cxl3Dw14K/KhWlAUGL8xerjnAlX7zYT6vMnF+Vowv6N3G5ZGd/AZ+oHSEYIunGSfaXjnY7sslZHRB8cy/zb+zCfMhougz5bXTvyeRpsnnUCwkala5vbjaC+DiNX5JQ0PrUenY1x3UiNYET2N4U1x3/DZsqVTBwPjj/iBjH8Ya1YQl3F5kTQajoaVLaKd8n/fujWFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXHvhFiL3qeRqE5TEuGnqsQS7wyZFtDeE2AU+Jzsycw=;
 b=N3ERpGvEXO5CpY824vd8ofUWjQWVS74LFU4HDdbaIx/EPVcJ6SSp8ZDq+6A9cpMSpNWe02DuEYz7QaGKH2yzra+jotpU69+9wNOLWpWlACNZyCkEhMzAjKDeiih4d3CQ/EihtOyVbw1+/GNYrG55lecsiNpn639xz49KHGdCJP0As3+w2Ur5FRr0byNg82VTOHJpRGo1Qn+93ScFM5ZOUxBoMYst+B7aybkn+lkPKAvDoxZvDF4xKsgs0+4ZJThag8nCbSuFpVJOD4gr2ABl+mNHdiE/JVoEmDK6k6848u/Iyt8SWX39ppFjFr2SQx1y+hg5MbjmFDv3VINZD8xN6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CY4PR0201MB3588.namprd02.prod.outlook.com (52.132.98.38) by
 CY4PR0201MB3524.namprd02.prod.outlook.com (52.132.103.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.20; Wed, 11 Sep 2019 10:30:28 +0000
Received: from CY4PR0201MB3588.namprd02.prod.outlook.com
 ([fe80::5598:9f2e:9d39:c737]) by CY4PR0201MB3588.namprd02.prod.outlook.com
 ([fe80::5598:9f2e:9d39:c737%6]) with mapi id 15.20.2199.027; Wed, 11 Sep 2019
 10:30:28 +0000
From:   Florian Schmidt <florian.schmidt@nutanix.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH 0/2] trace-vmscan-postprocess: fix parsing and output
Thread-Topic: [PATCH 0/2] trace-vmscan-postprocess: fix parsing and output
Thread-Index: AQHVYki0ihj6YyCnoUGe1njuFVT2kacb/gWAgApVPYA=
Date:   Wed, 11 Sep 2019 10:30:28 +0000
Message-ID: <e1ada037-da07-9513-23fc-9a1f90881b80@nutanix.com>
References: <20190903111342.17731-1-florian.schmidt@nutanix.com>
 <20190904204241.y6c335djr3bwm6xo@ca-dmjordan1.us.oracle.com>
In-Reply-To: <20190904204241.y6c335djr3bwm6xo@ca-dmjordan1.us.oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27)
 To CY4PR0201MB3588.namprd02.prod.outlook.com (2603:10b6:910:8b::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6376f1cb-19e8-4557-2c1b-08d736a3109e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR0201MB3524;
x-ms-traffictypediagnostic: CY4PR0201MB3524:
x-microsoft-antispam-prvs: <CY4PR0201MB3524A28D53D5153285BD4B17F7B10@CY4PR0201MB3524.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(366004)(39860400002)(54094003)(199004)(189003)(51914003)(5660300002)(2906002)(6916009)(26005)(81166006)(81156014)(8676002)(54906003)(66946007)(2616005)(36756003)(11346002)(53936002)(478600001)(476003)(6436002)(256004)(14444005)(71190400001)(71200400001)(31696002)(53546011)(316002)(52116002)(6512007)(102836004)(305945005)(76176011)(99286004)(6116002)(3846002)(66556008)(66446008)(66476007)(446003)(64756008)(86362001)(7736002)(386003)(6506007)(6246003)(186003)(31686004)(6486002)(8936002)(229853002)(14454004)(44832011)(486006)(25786009)(4326008)(66066001)(64030200001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR0201MB3524;H:CY4PR0201MB3588.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H4F3ZKrlAhUxjceflbfbvwN1jrRUJA03J5xaX1KcO5OSUKEBTQV9/UxeoSjdtbc/nl6TLjarsz22a64qb2upOgiKj1DPN6ZZO8hvMG9833U9t5RoGu2hLBFH/cSODEtl4DDrOkJ/0nKcs5DHbx0r8jwJZohHS86iq5WmnIHkuW8IBeOoaghJi1GslBkQLv/Prxom4r+nfS2gnWrsH0qrsrqLkSJLilnhcAHahn6gooHw6P3yvd2TNFzgfVdyS3hJSg1ggu6ihZWRkgySrPF/5HIb0PRxe/maCPj62Xe2I+dM8ljqK9gA4uXQq1+D5LgZXCUA5iORv/+1TnygT769VvZGUqzr7zjFz+tYTiybeEw7fc7jiFO85oTVYCrzmMKYXnfgOKbqZsnyAWeCBg+xxIbCopXSrK+/k0cIP15hWy8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B8A290A70A97441888B716DC9EA53AF@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6376f1cb-19e8-4557-2c1b-08d736a3109e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 10:30:28.4214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H40C1HlhzTppnfAT3Reda7OpKKRDf93SeFK31eWlU9yCYRA5NSDIHZq3OsTBfd61O42XDxGPKwpUvF2k85ypshbs8gvZeDigTIuGr/NGgsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3524
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-11_07:2019-09-11,2019-09-11 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQpPbiAwNC8wOS8yMDE5IDIxOjQyLCBEYW5pZWwgSm9yZGFuIHdyb3RlOg0K
Pj4gSW4gYWRkaXRpb24sIHRoZSB0YWJsZXMgdGhhdCBhcmUgcHJpbnRlZCBieSB0aGUgc2NyaXB0
IHdlcmUgbm90IHByb3Blcmx5DQo+PiBhbGlnbmVkIGFueSBtb3JlLCBzbyBwYXRjaCAyIGZpeGVz
IHRoZSBzcGFjaW5nLg0KPiANCj4gTml0LCBub3QgZm9yIFBhZ2VzIFNjYW5uZWQuICBXaXRoIHlv
dXIgc2VyaWVzIEkgZ2V0DQo+IA0KPiBLc3dhcGQgICAgICAgICAgS3N3YXBkICAgICAgT3JkZXIg
ICAgICBQYWdlcyAgICAgUGFnZXMgICAgUGFnZXMgICAgUGFnZXMNCj4gSW5zdGFuY2UgICAgICAg
V2FrZXVwcyAgUmUtd2FrZXVwICAgIFNjYW5uZWQgICAgUmNsbWVkICBTeW5jLUlPIEFTeW5jLUlP
DQo+IGtzd2FwZDAtMTc1ICAgICAgICAgIDEgICAgICAgICAgMCAgICAyNTM2OTQgICAgIDI1MzY5
MSAgICAgICAgMyAgIDEyOTg5NiAgICAgICAgICAgICAgIHdha2UtMD0xDQoNCldob29wcywgeW91
J3JlIHJpZ2h0LCBJJ2xsIGZpeCB0aGF0IGluIHYyLg0KDQoNCj4gSSB3b25kZXIgaWYgd2Ugc2hv
dWxkbid0IGp1c3QgZ2V0IHJpZCBvZiB0aGUgd2hvbGUgc2NyaXB0LCBpdCdzIGhhcmQgdG8NCj4g
cmVtZW1iZXIgdG8ga2VlcCBpbiBzeW5jIHdpdGggdm1zY2FuIGNoYW5nZXMgYW5kIEkgY2FuJ3Qg
dGhpbmsgb2YgYSB3YXkgdG8NCj4gcmVtZWR5IHRoYXQgc2hvcnQgb2YgaGF2aW5nIG1tIHJlZ3Jl
c3Npb24gdGVzdHMgdGhhdCBydW4gdGhpcy4gIEJ1dCB5b3VyDQo+IHBhdGNoZXMgYXJlIGFuIGlt
cHJvdmVtZW50IGZvciBub3cuDQoNClRoYXQncyBkZWZpbml0ZWx5IG9uZSBwb3NzaWJpbGl0eS4g
SWYgaGlzdG9yeSBoYXMgc2hvd24gdGhhdCB0aGVzZSBicmVhayANCmFuZCBhcmVuJ3QgcHJvcGVy
bHkga2VwdCBpbiBsaW5lLCB0aGV5IGNvdWxkIGdvLiBBbHRlcm5hdGl2ZWx5LCBhcyANCllhZmFu
ZyBzdWdnZXN0ZWQsIGludGVncmF0aW5nIHRoZW0gaW50byB0aGUgcGVyZiB0ZXN0IHN1aXRlIG1p
Z2h0IGhlbHAgDQp3aXRoIHRoZSBpc3N1ZXMuDQoNCkknbGwgaWdub3JlIHRoYXQgcG9pbnQgZm9y
IG5vdyB0aG91Z2ggYW5kIGp1c3Qgc2VuZCBhIHYyIGZvciB0aGlzIHBhdGNoIA0Kc2VyaWVzLg0K
DQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjaywNCkZsb3JpYW4NCg==
