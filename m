Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CE0C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2256D214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 06:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Uf0Pmto+";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AIhNVifY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfKTGui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 01:50:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36354 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725263AbfKTGui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 01:50:38 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xAK6llK4002377;
        Tue, 19 Nov 2019 22:50:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4eEP+vVBxjNweX65dgr7w/z1y6wUB8SL7/ktZzhI3Fs=;
 b=Uf0Pmto+juYDK2YBZ3i1AYFh4XpHvUZ/b+dp6RzuHTN+wsaXBTfqZ52cNwjPfoYo5jSQ
 M79UIOpEZxmXQYKjCdJ3rmdPQpD4OuwKgH0PzziKHWasCwA06pms15h2hYbMPd2XUu8W
 yK+V/afZ6DrbUueS51ZIv7hHCWWiB8k7kc8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2wchf74jf7-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 Nov 2019 22:50:17 -0800
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 19 Nov 2019 22:50:17 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 19 Nov 2019 22:50:16 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 19 Nov 2019 22:50:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJX5zHA5TtaopnbN9NYMwvx9Kuq/cw38rLwhvYUNku3ylOd+uT++BNUouHtq4wBrCzZzVHfvDJoe+vgQUJR6pnOaEmTngVu126RoP8f41GJNdwOM8IbQbfCuGpS1aZooNzZkI51HhYBcuatF75y3L0qmD4QdHbLlDNGzNl1Pqor0YtJdBSAikdH21SPwfnRuwLHB+HcB9aVoywK16NxS3ut+wbrgMoFDOM6mRCjb/0Lv7m5nLx2/C5hUcoG3Uw1v17qfgsZ9+Kyx51qmY1NhgSPDrAslTC3en4GVGSid9YbhTluCOD6PZijdCU8PNKkk9jj0GfnKLtKo9IVQNjQW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eEP+vVBxjNweX65dgr7w/z1y6wUB8SL7/ktZzhI3Fs=;
 b=SulToKCgx6Jmlft1K7/XxJZsO2EQXrHD1TFJL39q/MX9BELv0Z3R4+rVMsHK7fyycA3qamWgagOdwUgpuAMP8AcpO81pG42rNQuwx23PYTP4JJl5UfN5gzFD79z2lAkJUL/jiaopRn4J1SxM91SmLaBHoOffOMLS2++kaqNOYX6bJZkC9RTSn/tEHDuotwXskjM8VlfRvWfYE0ox/B4y55K13KTx8U3Ge47yD5G/jox7MMX8bF5tZJFjxuOkcBwjIrBJvvMk/7BuLPmP/vx2H+qL8cl6YlJM/y60piB/F7TokYPYIX70toshVGblFKPpzc/fmIUpt7a8g/06OBvn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eEP+vVBxjNweX65dgr7w/z1y6wUB8SL7/ktZzhI3Fs=;
 b=AIhNVifYrZBZWlYPf7lOcXZiaQup8LvGmu/NaKGBimlSl3WuAljuCnqhniFghJnPsr6NYR+VM09v8OdK9dt+DxV6P7AQ9i4YSKVX4XHuLL4VQ3AA342YFA93KgsEdppTbSM3Nt2fiNwfnLDVP4PE4mSAQyuhvve8OSf0WKdk1xM=
Received: from BY5PR15MB3636.namprd15.prod.outlook.com (52.133.252.91) by
 BY5PR15MB3652.namprd15.prod.outlook.com (52.133.253.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 06:50:15 +0000
Received: from BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b]) by BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b%4]) with mapi id 15.20.2474.015; Wed, 20 Nov 2019
 06:50:15 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        manikandan-e <manikandan.hcl.ers.epl@gmail.com>,
        Joel Stanley <joel@jms.id.au>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "manikandan.e@hcl.com" <manikandan.e@hcl.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Thread-Topic: [PATCH] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
Thread-Index: AQHVn2c0WXXLabyj70aXMmxos/evbqeTGJoA
Date:   Wed, 20 Nov 2019 06:50:15 +0000
Message-ID: <D34D3A2F-9CD5-4924-8407-F6EB0A4C66B5@fb.com>
References: <20191118123707.GA5560@cnn>
 <b2f503f0-0f13-46bc-a1be-c82a42b85797@www.fastmail.com>
In-Reply-To: <b2f503f0-0f13-46bc-a1be-c82a42b85797@www.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:647:4b00:fd70:18e2:66b5:5e3d:3d1a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e53f1a6-bcb1-4a04-d871-08d76d85e5fa
x-ms-traffictypediagnostic: BY5PR15MB3652:
x-microsoft-antispam-prvs: <BY5PR15MB3652525D87CD6309AF8283E2DD4F0@BY5PR15MB3652.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(136003)(346002)(376002)(47680400002)(199004)(189003)(71190400001)(316002)(71200400001)(6486002)(76176011)(110136005)(8936002)(6436002)(25786009)(6512007)(46003)(2616005)(66946007)(66446008)(64756008)(66556008)(66476007)(7736002)(14454004)(76116006)(6506007)(102836004)(6246003)(476003)(99286004)(186003)(86362001)(33656002)(2906002)(478600001)(446003)(5660300002)(11346002)(305945005)(54906003)(81156014)(81166006)(6116002)(8676002)(4326008)(256004)(14444005)(36756003)(486006)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR15MB3652;H:BY5PR15MB3636.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q6vFgSc4+hGNa4wSMPU8VYyowGqfjdPImRFOcF7/3JxDj/Dp+BrPSukuyyEWphkY4PjLkMmPPSH9aDzzNNc4NeD/w4aKjse1WX2PagDDVLEd1t263iXLuFslvYXFVcJQ8N/ZchMxqU5U6A06zmRfg5qL5i+ZZz3bQCN+d24LamqVJ4I3XU/YAUlYqb6hF+1Q7ZgL3KYMqnDmoPAARTqICjzVnFbtCIL3BMA1ikyNKiRgwZyeClPEAtXQnmEIjuBf3Jr8tYxEMES1bychQkgKsJ8rRTd3xQR9seAV1yCbUV93p8WTfD6E4Q+nNan/TK6pjhenRnR2U8y2ioNJqfo/fFr8tTsBIK++CrIzgi4irnCGUmKdP4fzYG1Wq2f4+Hf2z60mYko1ZqaKmz62waUPWDL2yfn6uQCx6kNjWslxV3d4kW5OiYKVIEmyYF4JPp7F
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA46A076608AC64F9AA4E00A07A061A0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e53f1a6-bcb1-4a04-d871-08d76d85e5fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 06:50:15.0625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cdr9CBYBheAtxmBHJTzh8Xl7510MIR4Wxv2LJmMHPU8C11MHhOhOcWEK9a+/M/rj0ou0TG8Usm5JHpxtEaySaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3652
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_01:2019-11-15,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1011 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911200060
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDExLzE5LzE5LCA5OjU2IFBNLCAiTGludXgtYXNwZWVkIG9uIGJlaGFsZiBvZiBB
bmRyZXcgSmVmZmVyeSIgPGxpbnV4LWFzcGVlZC1ib3VuY2VzK3ZpamF5a2hlbWthPWZiLmNvbUBs
aXN0cy5vemxhYnMub3JnIG9uIGJlaGFsZiBvZiBhbmRyZXdAYWouaWQuYXU+IHdyb3RlOg0KDQog
ICAgDQogICAgDQogICAgT24gTW9uLCAxOCBOb3YgMjAxOSwgYXQgMjM6MDcsIG1hbmlrYW5kYW4t
ZSB3cm90ZToNCiAgICA+IFRoZSBZb3NlbWl0ZSBWMiBpcyBhIGZhY2Vib29rIG11bHRpLW5vZGUg
c2VydmVyDQogICAgPiBwbGF0Zm9ybSB0aGF0IGhvc3QgZm91ciBPQ1Agc2VydmVyLiBUaGUgQk1D
DQogICAgPiBpbiB0aGUgWW9zZW1pdGUgVjIgcGxhdG9ybSBiYXNlZCBvbiBBU1QyNTAwIFNvQy4N
CiAgICA+IA0KICAgID4gVGhpcyBwYXRjaCBhZGRzIGxpbnV4IGRldmljZSB0cmVlIGVudHJ5IHJl
bGF0ZWQgdG8NCiAgICA+IFlvc2VtaXRlIFYyIHNwZWNpZmljIGRldmljZXMgY29ubmVjdGVkIHRv
IEJNQyBTb0MuDQogICAgPiANCiAgICA+IFNpZ25lZC1vZmYtYnk6IG1hbmlrYW5kYW4tZSA8bWFu
aWthbmRhbi5oY2wuZXJzLmVwbEBnbWFpbC5jb20+DQogICAgPiAtLS0NCiAgICA+ICAuLi4vYm9v
dC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9vay15b3NlbWl0ZXYyLmR0cyAgICB8IDE3MCArKysrKysr
KysrKysrKysrKysrKysNCiAgICA+ICAxIGZpbGUgY2hhbmdlZCwgMTcwIGluc2VydGlvbnMoKykN
CiAgICA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1m
YWNlYm9vay15b3NlbWl0ZXYyLmR0cw0KICAgID4gDQogICAgPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9vay15b3NlbWl0ZXYyLmR0cyANCiAgICA+IGIv
YXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9vay15b3NlbWl0ZXYyLmR0cw0KICAg
ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCiAgICA+IGluZGV4IDAwMDAwMDAuLjQ2YTI4NWENCiAg
ICA+IC0tLSAvZGV2L251bGwNCiAgICA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1i
bWMtZmFjZWJvb2steW9zZW1pdGV2Mi5kdHMNCiAgICA+IEBAIC0wLDAgKzEsMTcwIEBADQogICAg
PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQogICAgPiArLy8gQ29weXJp
Z2h0IChjKSAyMDE4IEZhY2Vib29rIEluYy4NCiAgICA+ICsvLyBBdXRob3I6DQogICAgPiArL2R0
cy12MS87DQogICAgPiArDQogICAgPiArI2luY2x1ZGUgImFzcGVlZC1nNS5kdHNpIg0KICAgID4g
KyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2FzcGVlZC1ncGlvLmg+DQogICAgPiArDQogICAg
PiArLyB7DQogICAgPiArCW1vZGVsID0gIkZhY2Vib29rIFlvc2VtaXRldjIgQk1DIjsNCiAgICA+
ICsJY29tcGF0aWJsZSA9ICJmYWNlYm9vayx5b3NlbWl0ZXYyLWJtYyIsICJhc3BlZWQsYXN0MjUw
MCI7DQogICAgPiArCWFsaWFzZXMgew0KICAgID4gKwkJc2VyaWFsMCA9ICZ1YXJ0MTsNCiAgICA+
ICsJCXNlcmlhbDQgPSAmdWFydDU7DQogICAgPiArCX07DQogICAgPiArCWNob3NlbiB7DQogICAg
PiArCQlzdGRvdXQtcGF0aCA9ICZ1YXJ0NTsNCiAgICA+ICsJCWJvb3RhcmdzID0gImNvbnNvbGU9
dHR5UzQsMTE1MjAwIGVhcmx5cHJpbnRrIjsNCiAgICA+ICsJfTsNCiAgICA+ICsNCiAgICA+ICsJ
bWVtb3J5QDgwMDAwMDAwIHsNCiAgICA+ICsJCXJlZyA9IDwweDgwMDAwMDAwIDB4MjAwMDAwMDA+
Ow0KICAgID4gKwl9Ow0KICAgID4gKw0KICAgID4gKwlpaW8taHdtb24gew0KICAgID4gKwkJLy8g
Vk9MQVRBR0UgU0VOU09SDQogICAgPiArCQljb21wYXRpYmxlID0gImlpby1od21vbiI7DQogICAg
PiArCQlpby1jaGFubmVscyA9IDwmYWRjIDA+ICwgPCZhZGMgMT4gLCA8JmFkYyAyPiAsICA8JmFk
YyAzPiAsDQogICAgPiArCQk8JmFkYyA0PiAsIDwmYWRjIDU+ICwgPCZhZGMgNj4gLCAgPCZhZGMg
Nz4gLA0KICAgID4gKwkJPCZhZGMgOD4gLCA8JmFkYyA5PiAsIDwmYWRjIDEwPiwgPCZhZGMgMTE+
ICwNCiAgICA+ICsJCTwmYWRjIDEyPiAsIDwmYWRjIDEzPiAsIDwmYWRjIDE0PiAsIDwmYWRjIDE1
PiA7DQogICAgPiArCX07DQogICAgPiArfTsNCiAgICA+ICsNCiAgICA+ICsmZm1jIHsNCiAgICA+
ICsJc3RhdHVzID0gIm9rYXkiOw0KICAgID4gKwlmbGFzaEAwIHsNCiAgICA+ICsJCXN0YXR1cyA9
ICJva2F5IjsNCiAgICA+ICsJCW0yNXAsZmFzdC1yZWFkOw0KICAgID4gKyNpbmNsdWRlICJvcGVu
Ym1jLWZsYXNoLWxheW91dC5kdHNpIg0KICAgID4gKwl9Ow0KICAgID4gK307DQogICAgPiArDQog
ICAgPiArJnNwaTEgew0KICAgID4gKwlzdGF0dXMgPSAib2theSI7DQogICAgPiArCXBpbmN0cmwt
bmFtZXMgPSAiZGVmYXVsdCI7DQogICAgPiArCXBpbmN0cmwtMCA9IDwmcGluY3RybF9zcGkxX2Rl
ZmF1bHQ+Ow0KICAgID4gKwlmbGFzaEAwIHsNCiAgICA+ICsJCXN0YXR1cyA9ICJva2F5IjsNCiAg
ICA+ICsJCW0yNXAsZmFzdC1yZWFkOw0KICAgID4gKwkJbGFiZWwgPSAicG5vciI7DQogICAgPiAr
CX07DQogICAgPiArfTsNCiAgICA+ICsNCiAgICA+ICsmbHBjX3Nub29wIHsNCiAgICA+ICsJc3Rh
dHVzID0gIm9rYXkiOw0KICAgID4gKwlzbm9vcC1wb3J0cyA9IDwweDgwPjsNCiAgICA+ICt9Ow0K
Tm8gbHBjIGluIFlvc2VtaXRlIHNvIHBsZWFzZSByZW1vdmUuDQoNCiAgICA+ICsNCiAgICA+ICsm
bHBjX2N0cmwgew0KICAgID4gKwkvLyBFbmFibGUgbHBjIGNsb2NrDQogICAgPiArCXN0YXR1cyA9
ICJva2F5IjsNClNhbWUgaGVyZSByZW1vdmUuDQogICAgDQogICAgU29tZXRoaW5nIEknbSBpbnRl
bmRpbmcgdG8gZml4IGluIHRoZSBkZXZpY2V0cmVlcyB1c2luZyBMUEMgaXMgdG8gaG9nDQogICAg
dGhlIHBpbnMgaW4gdGhlIHBpbmN0cmwgbm9kZS4gWW91IHNob3VsZCBjb25zaWRlciBkb2luZyB0
aGUgc2FtZSBoZXJlLg0KICAgIA0KICAgID4gK307DQogICAgPiArDQogICAgPiArJnZ1YXJ0IHsN
CiAgICA+ICsJLy8gVlVBUlQgSG9zdCBDb25zb2xlDQogICAgPiArCXN0YXR1cyA9ICJva2F5IjsN
CiAgICA+ICt9Ow0KTm8gVnVhcnQuDQoNCiAgICA+ICsNCiAgICA+ICsmdWFydDEgew0KICAgID4g
KwkvLyBIb3N0IENvbnNvbGUNCiAgICA+ICsJc3RhdHVzID0gIm9rYXkiOw0KICAgID4gKwlwaW5j
dHJsLW5hbWVzID0gImRlZmF1bHQiOw0KICAgID4gKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfdHhk
MV9kZWZhdWx0DQogICAgPiArCQkgICAgICZwaW5jdHJsX3J4ZDFfZGVmYXVsdD47DQogICAgPiAr
fTsNCiAgICA+ICsNCiAgICA+ICsmdWFydDIgew0KICAgID4gKwkvLyBTb0wgSG9zdCBDb25zb2xl
DQogICAgPiArCXN0YXR1cyA9ICJva2F5IjsNCg0KdWFydDEtNCBhcmUgYWxsIGFzc2lnbmVkIGZv
ciA0IG11bHRpcGxlIGhvc3RzIHNvIGRlZmluZSBhY2NvcmRpbmdseS4gIA0KICAgIA0KICAgIEFs
c28gbmVlZHMgcGluY3RybCBjb25maWd1cmF0aW9uLg0KICAgIA0KICAgID4gK307DQogICAgPiAr
DQogICAgPiArJnVhcnQzIHsNCiAgICA+ICsJLy8gU29MIEJNQyBDb25zb2xlDQogICAgPiArCXN0
YXR1cyA9ICJva2F5IjsNCiAgICANCiAgICBBZ2FpbiBuZWVkcyBwaW5jdHJsLg0KICAgIA0KICAg
ID4gK307DQogICAgPiArDQogICAgPiArJnVhcnQ1IHsNCiAgICA+ICsJLy8gQk1DIENvbnNvbGUN
CiAgICA+ICsJc3RhdHVzID0gIm9rYXkiOw0KICAgID4gK307DQogICAgPiArDQogICAgPiArJm1h
YzAgew0KICAgID4gKwlzdGF0dXMgPSAib2theSI7DQogICAgPiArDQogICAgPiArCXBpbmN0cmwt
bmFtZXMgPSAiZGVmYXVsdCI7DQogICAgPiArCXBpbmN0cmwtMCA9IDwmcGluY3RybF9ybWlpMV9k
ZWZhdWx0PjsNCiAgICA+ICsJdXNlLW5jc2k7DQogICAgPiArfTsNCiAgICA+ICsNCiAgICA+ICsm
YWRjIHsNCiAgICA+ICsJc3RhdHVzID0gIm9rYXkiOw0KICAgIA0KICAgIFN0cm9uZ2x5IHN1Z2dl
c3QgYWRkaW5nIHRoZSBwaW5jdHJsIHByb3BlcnRpZXMgaGVyZSB0byBlbnN1cmUNCiAgICBleGNs
dXNpdmUgYWNjZXNzIGZvciB0aGUgQURDIHBpbnMuDQogICAgDQogICAgT3RoZXJ3aXNlIGl0IGxv
b2tzIHJlYXNvbmFibGUuDQogICAgDQogICAgQW5kcmV3DQogICAgDQoNCg==
