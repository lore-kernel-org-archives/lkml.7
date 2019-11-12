Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC32AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981182067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="M3pNfLy3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bm+8L0IN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfKLUOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:14:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6554 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbfKLUOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:14:33 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xACKAUu4011078;
        Tue, 12 Nov 2019 12:13:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=fLx9m188qipqfStD3T57Lgjihg8o0hjev1Uk/5WArUE=;
 b=M3pNfLy35kUYLrZJzTxBaAduPEtPBfjgYncxYY2f/1JOiSgGfo/QGE78ZAIFprb73bVr
 +4zyoeP40fqPvJAwQWL73gJ5WxHZzLnsjigMHuhwD3ByvX2le/dDBSGi/0IwkjUfla5o
 LPtt0hNcblhBr71JkE+1nKpqywxlYtKuU28= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2w7prjbv7u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 12:13:56 -0800
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 12 Nov 2019 12:13:55 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 12 Nov 2019 12:13:54 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Nov 2019 12:13:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iM8lVYukDtZFVFcI0ZGtYilWNQu5a3LLG2h/L3j1AR6bS2C3umxZMrdtY9UD76dzVIo+XgosHt+8PbWfi/tA+jcU/I0TKgSzt1vAzIGLBSfhLG+aiugEOuyetQzg4d1Rdz4+QpqXOZsT7D3HoodOXeDewYIjEKIa6o0ETNp5XRe4vPBJQUTC+5laD8LYxijcFevv2sXvM9lSnHiOUpxqiUQR6AMNkkPgGWag4pTza67GksBwKLLTifZN68PGLDvfj4qimVcDChPYJkPCppK5qjnX7TGMPWdWpeunJoZEYRjf2qTr4uVP7CnFupPuVkUHq5ZtXLeI43qlRy0JW3HZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLx9m188qipqfStD3T57Lgjihg8o0hjev1Uk/5WArUE=;
 b=FCs5QSDbsj7WSIDetgg+Ua58p5lrS0CzqxE5d60tvVptbBMRI7lD/Q9jbbpNtO44nUBAF/Za4bOaNjAs6xubjMXv1CnWm58C35k2f9kfO54xJTvCB1hCAJTCRuAvA3D6zS2aMuu0OMH+QN9UKNGqQYUHClRqT9VXh6lgvIum1t1kCS6xj+H8RvhH8v5crpQPcORrSiBtfxgY8ii4gyDo69Dq2qNZNMSJNrUpHuTGw3il0dDM55X7ciTG6+RKNduTIbzy0RXicZnXtUSRkxrPWPRJBXcQgiaDFhwzA5P+3nKngJDSzySjYgA20TG3pNJpzvqttMe10U6B/tOL/2x45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLx9m188qipqfStD3T57Lgjihg8o0hjev1Uk/5WArUE=;
 b=bm+8L0INNQSgbMf/ymcqqB0wJcoM1XWjrnwbdh1HYNpU0qtPAjCssPYs8ZFXozpsn8nQsjE/6DpNr4SLhlJ+7rGZwleSlKd+4vtApSpB5w7xH7NKkJO/A5dd5ZzdZYh8Dy/NG+JbLAyclzZC4Rb5vYbALxD3tQSRdfXTjp5cC3Y=
Received: from BY5PR15MB3636.namprd15.prod.outlook.com (52.133.252.91) by
 BY5PR15MB3604.namprd15.prod.outlook.com (52.133.255.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 20:13:53 +0000
Received: from BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b]) by BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 20:13:53 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     "cminyard@mvista.com" <cminyard@mvista.com>
CC:     "minyard@acm.org" <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asmaa@mellanox.com" <asmaa@mellanox.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>
Subject: Re: [PATCH 1/2] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Topic: [PATCH 1/2] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Index: AQHVmQJfp1K9cdweJkCb8BSV+019/aeHeXcA///TrgCAAJJYgP//k8kA
Date:   Tue, 12 Nov 2019 20:13:53 +0000
Message-ID: <FD95DA64-F821-48EF-AB17-7DE62D73C620@fb.com>
References: <20191112023610.3644314-1-vijaykhemka@fb.com>
 <20191112123602.GD2882@minyard.net>
 <493C2E64-2E41-47FF-BDA6-6EA1DA758016@fb.com>
 <20191112184111.GA2938@minyard.net>
In-Reply-To: <20191112184111.GA2938@minyard.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::1:8011]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a7d4480-d2a7-487c-6820-08d767acd712
x-ms-traffictypediagnostic: BY5PR15MB3604:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB360483C8B91F4F0A9AD7F0CFDD770@BY5PR15MB3604.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(71200400001)(256004)(14444005)(36756003)(2351001)(25786009)(8676002)(8936002)(6436002)(4326008)(446003)(5640700003)(6512007)(6486002)(6116002)(2906002)(11346002)(316002)(81166006)(54906003)(71190400001)(99286004)(14454004)(5660300002)(1730700003)(2616005)(33656002)(229853002)(81156014)(486006)(476003)(46003)(2501003)(6506007)(76176011)(66946007)(53546011)(6916009)(86362001)(186003)(305945005)(478600001)(6246003)(76116006)(66556008)(66446008)(66476007)(64756008)(102836004)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR15MB3604;H:BY5PR15MB3636.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8HZvIPxXysK9M0JJ/ir4VHvATyFmpRxBP6IW5S0HIHgX4ou8+J7pYZAYY3O8GRLy4iFMxCkcrpK1Y6IIXgdAFiOIVOIxwovGrIp1PbY3kNr9Vz4PvxIW44jDyQm4Kp9WJ5EZRHStdF94LaIwYE0iOCywYzGQ9akc5ZhGxYv/ifMg7gTlMVbj2V1OE8mE6+fN2/SKq7YmyM3JHGbiqzgAPLTuIye8GbnubcDXZFeot5KUwwEIoBSZPUcmSSiP0Nn5O/CcEW2oAjOfwtYK0b9OIgGZYxJLGijD9vLjmWoV4n1gfj7BYUcG2pvVK0STbNyXD9yGgyzQdMhIiIqufq1Txbgc3RKEjco4ox5L4G1laslrpG/tuImfEupnvDDxh77qJrEFan11uN3p8jCVbkLXNUO+PwjQ6xOmqa9OXyF9jBWyAPfcCixS/AyVps9Otni1
Content-Type: text/plain; charset="utf-8"
Content-ID: <64536899D6E34D4B9683773ED0F3B731@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7d4480-d2a7-487c-6820-08d767acd712
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 20:13:53.5598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cR2OoUoY7d8nH9dWsmbeCqRmMQVvfv++q15U+mHq7VrAv+gdSn1K81h//xcEO5tVgWn5sNvEYXDNeG3+Yw3DEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3604
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-12_07:2019-11-11,2019-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911120171
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDExLzEyLzE5LCAxMDo0MSBBTSwgIkNvcmV5IE1pbnlhcmQiIDxjbWlueWFyZEBt
dmlzdGEuY29tPiB3cm90ZToNCg0KICAgIE9uIFR1ZSwgTm92IDEyLCAyMDE5IGF0IDA1OjU3OjI1
UE0gKzAwMDAsIFZpamF5IEtoZW1rYSB3cm90ZToNCiAgICA+IA0KICAgID4gDQogICAgPiBPbiAx
MS8xMi8xOSwgNDozNiBBTSwgIkNvcmV5IE1pbnlhcmQiIDx0Y21pbnlhcmRAZ21haWwuY29tIG9u
IGJlaGFsZiBvZiBtaW55YXJkQGFjbS5vcmc+IHdyb3RlOg0KICAgID4gDQogICAgPiAgICAgT24g
TW9uLCBOb3YgMTEsIDIwMTkgYXQgMDY6MzY6MDlQTSAtMDgwMCwgVmlqYXkgS2hlbWthIHdyb3Rl
Og0KICAgID4gICAgID4gTWFueSBJUE1CIGRldmljZXMgZG9lc24ndCBzdXBwb3J0IHNtYnVzIHBy
b3RvY29sIGFuZCBjdXJyZW50IGRyaXZlcg0KICAgID4gICAgID4gc3VwcG9ydCBvbmx5IHNtYnVz
IGRldmljZXMuIFNvIGFkZGVkIHN1cHBvcnQgZm9yIHJhdyBpMmMgcGFja2V0cy4NCiAgICA+ICAg
ICANCiAgICA+ICAgICBJIGhhdmVuJ3QgcmV2aWV3ZWQgdGhpcywgcmVhbGx5LCBiZWNhdXNlIEkg
aGF2ZSBhIG1vcmUgZ2VuZXJhbA0KICAgID4gICAgIGNvbmNlcm4uLi4NCiAgICA+ICAgICANCiAg
ICA+ICAgICBJcyBpdCBwb3NzaWJsZSB0byBub3QgZG8gdGhpcyB3aXRoIGEgY29uZmlnIGl0ZW0/
ICBDYW4geW91IGFkZCBzb21ldGhpbmcNCiAgICA+ICAgICB0byB0aGUgZGV2aWNlIHRyZWUgYW5k
L29yIHZpYSBhbiBpb2N0bCB0byBtYWtlIHRoaXMgZHluYW1pY2FsbHkNCiAgICA+ICAgICBjb25m
aWd1cmFibGU/ICBUaGF0J3MgbW9yZSBmbGV4aWJsZSAoaXQgY2FuIHN1cHBvcnQgbWl4ZWQgZGV2
aWNlcykgYW5kDQogICAgPiAgICAgaXMgZnJpZW5kbGllciB0byB1c2VycyAoZG9uJ3QgaGF2ZSB0
byBnZXQgdGhlIGNvbmZpZyByaWdodCkuDQogICAgPiBJIGFncmVlIHdpdGggeW91LCBJIHdhcyBh
bHNvIG5vdCBjb21mb3J0YWJsZSB1c2luZyBjb25maWcgYW5kIGNvdWxkbid0IGZpbmQgb3RoZXIg
DQogICAgPiBPcHRpb25zLCBJIHdpbGwgbG9vayBpbnRvIG1vcmUgb3B0aW9uIG5vdyBhbmQgdXBk
YXRlIHBhdGNoLg0KICAgIA0KICAgIElNSE8sIGRldmljZSB0cmVlIGlzIHRoZSByaWdodCB3YXkg
dG8gZG8gdGhpcy4gIFlvdSBzaG91bGQgYWxzbyBoYXZlIGENCiAgICBzeXNmcyBzZXR0aW5nIGZv
ciB0aGlzLCBJIHRoaW5rLg0KDQpJIHRoaW5rIGlvY3RsIGlzIGFsc28gYSBnb29kIG9wdGlvbiBh
bmQgY2FuIGNvbnRyb2wgZnJvbSBhcHBsaWNhdGlvbi4gSSBoYXZlIGFscmVhZHkgDQp3cm90ZSBp
b2N0bCAgYXBwcm9hY2guIFRlc3RpbmcgdGhlIHNhbWUgYW5kIHdpbGwgc2VuZCBuZXcgcGF0Y2gg
b25jZSB2ZXJpZmllZC4NCiAgICANCiAgICAtY29yZXkNCiAgICANCiAgICA+ICAgICANCiAgICA+
ICAgICBDb25maWcgaXRlbXMgZm9yIGFkZGluZyBuZXcgZnVuY3Rpb25hbGl0eSBhcmUgZ2VuZXJh
bGx5IG9rLiAgQ29uZmlnDQogICAgPiAgICAgaXRlbXMgZm9yIGNob29zaW5nIGJldHdlZW4gdHdv
IG11dHVhbGx5IGV4Y2x1c2l2ZSBjaG9pY2VzIGFyZQ0KICAgID4gICAgIGdlbmVyYWxseSBub3Qu
DQogICAgPiAgICAgDQogICAgPiAgICAgLWNvcmV5DQogICAgPiAgICAgDQogICAgPiAgICAgPiAN
CiAgICA+ICAgICA+IFNpZ25lZC1vZmYtYnk6IFZpamF5IEtoZW1rYSA8dmlqYXlraGVta2FAZmIu
Y29tPg0KICAgID4gICAgID4gLS0tDQogICAgPiAgICAgPiAgZHJpdmVycy9jaGFyL2lwbWkvS2Nv
bmZpZyAgICAgICAgfCAgNiArKysrKysNCiAgICA+ICAgICA+ICBkcml2ZXJzL2NoYXIvaXBtaS9p
cG1iX2Rldl9pbnQuYyB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KICAgID4g
ICAgID4gIDIgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQ0KICAgID4gICAgID4gDQog
ICAgPiAgICAgPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL2lwbWkvS2NvbmZpZyBiL2RyaXZl
cnMvY2hhci9pcG1pL0tjb25maWcNCiAgICA+ICAgICA+IGluZGV4IGE5Y2ZlNGMwNWU2NC4uZTUy
Njg0NDNiNDc4IDEwMDY0NA0KICAgID4gICAgID4gLS0tIGEvZHJpdmVycy9jaGFyL2lwbWkvS2Nv
bmZpZw0KICAgID4gICAgID4gKysrIGIvZHJpdmVycy9jaGFyL2lwbWkvS2NvbmZpZw0KICAgID4g
ICAgID4gQEAgLTEzOSwzICsxMzksOSBAQCBjb25maWcgSVBNQl9ERVZJQ0VfSU5URVJGQUNFDQog
ICAgPiAgICAgPiAgCSAgUHJvdmlkZXMgYSBkcml2ZXIgZm9yIGEgZGV2aWNlIChTYXRlbGxpdGUg
TUMpIHRvDQogICAgPiAgICAgPiAgCSAgcmVjZWl2ZSByZXF1ZXN0cyBhbmQgc2VuZCByZXNwb25z
ZXMgYmFjayB0byB0aGUgQk1DIHZpYQ0KICAgID4gICAgID4gIAkgIHRoZSBJUE1CIGludGVyZmFj
ZS4gVGhpcyBtb2R1bGUgcmVxdWlyZXMgSTJDIHN1cHBvcnQuDQogICAgPiAgICAgPiArDQogICAg
PiAgICAgPiArY29uZmlnIElQTUJfU01CVVNfRElTQUJMRQ0KICAgID4gICAgID4gKwlib29sICdE
aXNhYmxlIFNNQlVTIHByb3RvY29sIGZvciBzZW5kaW5nIHBhY2tldCB0byBJUE1CIGRldmljZScN
CiAgICA+ICAgICA+ICsJZGVwZW5kcyBvbiBJUE1CX0RFVklDRV9JTlRFUkZBQ0UNCiAgICA+ICAg
ICA+ICsJaGVscA0KICAgID4gICAgID4gKwkgIHByb3ZpZGVzIGZ1bmN0aW9uYWxpdHkgb2Ygc2Vu
ZGluZyByYXcgaTJjIHBhY2tldHMgdG8gSVBNQiBkZXZpY2UuDQogICAgPiAgICAgPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50LmMgYi9kcml2ZXJzL2NoYXIvaXBt
aS9pcG1iX2Rldl9pbnQuYw0KICAgID4gICAgID4gaW5kZXggYWUzYmZiYTI3NTI2Li4yNDE5Yjlh
OTI4YjIgMTAwNjQ0DQogICAgPiAgICAgPiAtLS0gYS9kcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rl
dl9pbnQuYw0KICAgID4gICAgID4gKysrIGIvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50
LmMNCiAgICA+ICAgICA+IEBAIC0xMTgsNiArMTE4LDEwIEBAIHN0YXRpYyBzc2l6ZV90IGlwbWJf
d3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0IGNoYXIgX191c2VyICpidWYsDQogICAgPiAg
ICAgPiAgCXN0cnVjdCBpcG1iX2RldiAqaXBtYl9kZXYgPSB0b19pcG1iX2RldihmaWxlKTsNCiAg
ICA+ICAgICA+ICAJdTggcnFfc2EsIG5ldGZfcnFfbHVuLCBtc2dfbGVuOw0KICAgID4gICAgID4g
IAl1bmlvbiBpMmNfc21idXNfZGF0YSBkYXRhOw0KICAgID4gICAgID4gKyNpZmRlZiBDT05GSUdf
SVBNQl9TTUJVU19ESVNBQkxFDQogICAgPiAgICAgPiArCXVuc2lnbmVkIGNoYXIgKmkyY19idWY7
DQogICAgPiAgICAgPiArCXN0cnVjdCBpMmNfbXNnIGkyY19tc2c7DQogICAgPiAgICAgPiArI2Vu
ZGlmDQogICAgPiAgICAgPiAgCXU4IG1zZ1tNQVhfTVNHX0xFTl07DQogICAgPiAgICAgPiAgCXNz
aXplX3QgcmV0Ow0KICAgID4gICAgID4gIA0KICAgID4gICAgID4gQEAgLTEzMyw2ICsxMzcsMzEg
QEAgc3RhdGljIHNzaXplX3QgaXBtYl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hh
ciBfX3VzZXIgKmJ1ZiwNCiAgICA+ICAgICA+ICAJcnFfc2EgPSBHRVRfN0JJVF9BRERSKG1zZ1tS
UV9TQV84QklUX0lEWF0pOw0KICAgID4gICAgID4gIAluZXRmX3JxX2x1biA9IG1zZ1tORVRGTl9M
VU5fSURYXTsNCiAgICA+ICAgICA+ICANCiAgICA+ICAgICA+ICsjaWZkZWYgQ09ORklHX0lQTUJf
U01CVVNfRElTQUJMRQ0KICAgID4gICAgID4gKwkvKg0KICAgID4gICAgID4gKwkgKiBzdWJ0cmFj
dCAxIGJ5dGUgKHJxX3NhKSBmcm9tIHRoZSBsZW5ndGggb2YgdGhlIG1zZyBwYXNzZWQgdG8NCiAg
ICA+ICAgICA+ICsJICogcmF3IGkyY190cmFuc2Zlcg0KICAgID4gICAgID4gKwkgKi8NCiAgICA+
ICAgICA+ICsJbXNnX2xlbiA9IG1zZ1tJUE1CX01TR19MRU5fSURYXSAtIDE7DQogICAgPiAgICAg
PiArDQogICAgPiAgICAgPiArCWkyY19idWYgPSBremFsbG9jKG1zZ19sZW4sIEdGUF9LRVJORUwp
Ow0KICAgID4gICAgID4gKwlpZiAoIWkyY19idWYpDQogICAgPiAgICAgPiArCQlyZXR1cm4gLUVG
QVVMVDsNCiAgICA+ICAgICA+ICsNCiAgICA+ICAgICA+ICsJLyogQ29weSBtZXNzYWdlIHRvIGJ1
ZmZlciBleGNlcHQgZmlyc3QgMiBieXRlcyAobGVuZ3RoIGFuZCBhZGRyZXNzKSAqLw0KICAgID4g
ICAgID4gKwltZW1jcHkoaTJjX2J1ZiwgbXNnKzIsIG1zZ19sZW4pOw0KICAgID4gICAgID4gKw0K
ICAgID4gICAgID4gKwlpMmNfbXNnLmFkZHIgPSBycV9zYTsNCiAgICA+ICAgICA+ICsJaTJjX21z
Zy5mbGFncyA9IGlwbWJfZGV2LT5jbGllbnQtPmZsYWdzICYNCiAgICA+ICAgICA+ICsJCQkoSTJD
X01fVEVOIHwgSTJDX0NMSUVOVF9QRUMgfCBJMkNfQ0xJRU5UX1NDQ0IpOw0KICAgID4gICAgID4g
KwlpMmNfbXNnLmxlbiA9IG1zZ19sZW47DQogICAgPiAgICAgPiArCWkyY19tc2cuYnVmID0gaTJj
X2J1ZjsNCiAgICA+ICAgICA+ICsNCiAgICA+ICAgICA+ICsJcmV0ID0gaTJjX3RyYW5zZmVyKGlw
bWJfZGV2LT5jbGllbnQtPmFkYXB0ZXIsICZpMmNfbXNnLCAxKTsNCiAgICA+ICAgICA+ICsJa2Zy
ZWUoaTJjX2J1Zik7DQogICAgPiAgICAgPiArDQogICAgPiAgICAgPiArCXJldHVybiAocmV0ID09
IDEpID8gY291bnQgOiByZXQ7DQogICAgPiAgICAgPiArI2Vsc2UNCiAgICA+ICAgICA+ICAJLyoN
CiAgICA+ICAgICA+ICAJICogc3VidHJhY3QgcnFfc2EgYW5kIG5ldGZfcnFfbHVuIGZyb20gdGhl
IGxlbmd0aCBvZiB0aGUgbXNnIHBhc3NlZCB0bw0KICAgID4gICAgID4gIAkgKiBpMmNfc21idXNf
eGZlcg0KICAgID4gICAgID4gQEAgLTE0OSw2ICsxNzgsNyBAQCBzdGF0aWMgc3NpemVfdCBpcG1i
X3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLCBjb25zdCBjaGFyIF9fdXNlciAqYnVmLA0KICAgID4g
ICAgID4gIAkJCSAgICAgSTJDX1NNQlVTX0JMT0NLX0RBVEEsICZkYXRhKTsNCiAgICA+ICAgICA+
ICANCiAgICA+ICAgICA+ICAJcmV0dXJuIHJldCA/IDogY291bnQ7DQogICAgPiAgICAgPiArI2Vu
ZGlmDQogICAgPiAgICAgPiAgfQ0KICAgID4gICAgID4gIA0KICAgID4gICAgID4gIHN0YXRpYyB1
bnNpZ25lZCBpbnQgaXBtYl9wb2xsKHN0cnVjdCBmaWxlICpmaWxlLCBwb2xsX3RhYmxlICp3YWl0
KQ0KICAgID4gICAgID4gLS0gDQogICAgPiAgICAgPiAyLjE3LjENCiAgICA+ICAgICA+IA0KICAg
ID4gICAgIA0KICAgID4gDQogICAgDQoNCg==
