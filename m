Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C86C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CBE206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="LiLoMCqQ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dVqjZegI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKNWQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 17:16:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19700 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726818AbfKNWQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 17:16:55 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAEMF7tq004405;
        Thu, 14 Nov 2019 14:16:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=EEBptaLJiM8yAp+7PLiI2EglrvCFGl33/GAPhe4CrN8=;
 b=LiLoMCqQZrk06iQlMF4rpbJfZN4Yibcz6vjw7ZqU28+W6RKFTbWwH8+OCQ1P4B2dMq7C
 +V0xZz8fLUPWfrZ1XGwDtF9Vn0I12GwQb3t56VTH9VCrgLMzfbL8gK3BXMVin20CguUY
 fvRn7fDRecyxSLtr+Aq5mi9jA/shNH3qBzY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w8n9s9qbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Nov 2019 14:16:23 -0800
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 14 Nov 2019 14:16:22 -0800
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 14 Nov 2019 14:16:21 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 14 Nov 2019 14:16:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUJfiWi3fihSJo8pdf5tI0B3VsFH+Fj9mMZDTSFXyQavS/2bxxtL3v9wUi3YxW/jN4VLzMMwTzMQjO7x/X9UjyOhA6s1QMRWUhK/4IzfsQRFBo7QzdEUvdBeqTUKuUqKLjfMkoFeHl6JvZzhv5MlfI7BdCKvNdqdd0cs77GOXMN5KgbcldfaODoegR8cVcBubBDZRXC1idYScU5fW/IZeRqN4VlmTqiNFRXfQBG+RGv53rmnruxdiLQ49LtAKKhmkNSkkXQnYvVojvzHnMUrUUehybupGnCGNc64hTmib81Q3DdKhrICybksICYlNMlm1tjmdV4NUAXPVrlh8Xeahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEBptaLJiM8yAp+7PLiI2EglrvCFGl33/GAPhe4CrN8=;
 b=YaUqMcCkzswCIz7hQ59mnlV/ml+qrWeDOAAMjx/9nL11J9FvSa91V6ConC2eMt83DqukVPKXMYW4IQCwaXZFIK8jbbXB5hjhGgSgAsCW6bAw3RB3W3lSh3Kv64TeOoTuLITjiLzQh9xC3m8HY4azZlFeEYsAd/BKYMmz3BBq2xCxBQpVhIPFmLbfo8w6FVqz8j4VHVh1rbVPxL/OdR3UH5srtVTHzmGDm6QlXZwxd7xjR23f8Huf171BO7E2tVVy2mbsMyworZlAoenbkH9Mt5zWSgv8WsedvtF7JPntVUMTbecRSKoYKfvKP8l4V49VAqasHDR6ZatFfk+DdW4g+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEBptaLJiM8yAp+7PLiI2EglrvCFGl33/GAPhe4CrN8=;
 b=dVqjZegIGB3He4RFNgnPdruujbvO5P7VKBXRg2Oz0riUkcEA11fnmbXfcLEQLZcO7ReWacLT1gyomPAXkLgo5ELChT5XHsDD4JNVP55LbMCod13Tu3qXFBhOEnFlnQulaXztW5LKFSZuCh94/3WEMtpVMQ3EAbvZ99DQLyk92Rs=
Received: from BY5PR15MB3636.namprd15.prod.outlook.com (52.133.252.91) by
 BY5PR15MB3555.namprd15.prod.outlook.com (52.133.252.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Thu, 14 Nov 2019 22:16:21 +0000
Received: from BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b]) by BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b%4]) with mapi id 15.20.2430.027; Thu, 14 Nov 2019
 22:16:20 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Asmaa Mnebhi <Asmaa@mellanox.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>
CC:     "cminyard@mvista.com" <cminyard@mvista.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>
Subject: Re: [PATCH v5] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Topic: [PATCH v5] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Index: AQHVmx5doD7b/6WCX0CwGAsHT/phqKeLMjgA//+DtwA=
Date:   Thu, 14 Nov 2019 22:16:20 +0000
Message-ID: <10DAB69C-D4F3-4472-935E-07FAD90B8EF6@fb.com>
References: <20191114185359.2832107-1-vijaykhemka@fb.com>
 <DB6PR0501MB2712B06FB162520F90EF1F4DDA710@DB6PR0501MB2712.eurprd05.prod.outlook.com>
In-Reply-To: <DB6PR0501MB2712B06FB162520F90EF1F4DDA710@DB6PR0501MB2712.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::2860]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab442893-e024-472c-e011-08d769504734
x-ms-traffictypediagnostic: BY5PR15MB3555:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB35554D237B3EA9FF52B98E29DD710@BY5PR15MB3555.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(136003)(396003)(13464003)(199004)(189003)(8936002)(86362001)(6512007)(6436002)(102836004)(76176011)(6506007)(53546011)(6486002)(305945005)(2501003)(71200400001)(256004)(14444005)(2906002)(7736002)(91956017)(76116006)(71190400001)(7416002)(6116002)(476003)(486006)(33656002)(36756003)(4326008)(446003)(11346002)(186003)(2616005)(46003)(6246003)(316002)(110136005)(81156014)(229853002)(25786009)(66476007)(64756008)(54906003)(66556008)(99286004)(66446008)(66946007)(8676002)(478600001)(5660300002)(81166006)(2201001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR15MB3555;H:BY5PR15MB3636.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EivU2vRX/Eq14eE/thVDXUN1jNeN8NuZlbulXUU/fwnWlk6YVxf7ayvNf2iH0j6kiTToF7mM8ENoRd+qcUKbnj5xg2wT301YWeH9wvJxYfRMSUDE+aNA4o2/YpxWGl7qxqzzjykd1MCMyqPee8Bic10BWCId9dnF7AE+Qi4wuUq6uCVWEm6MCBJwgOWQEy4LEVaMjZa+bMHcrW1OC/IBwR3jwnEQTb/cM5YXalATrzVRYnfGjW66m/DEqm/cSR+YTSjIeQDMSzzPuRwJeOJHk6Ote6mfDDStSF9EnzrlKRFZdRXM8Y0VD4Vvp306Ce1p/9BeYs5P4uu+8pTH6aFjK9ftovLVIMZcYRT/iI8cxytJDo1dBhBkfon4SXbbi+sZ6+5JwBjKJADyoN5XQeBGs0fh/86Enb5bujFR4FVql/z+a6j5zM8Z4Kld5jd/AMNf
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAB8C27A91057C4FB365F9CAEE8C4A32@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ab442893-e024-472c-e011-08d769504734
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 22:16:20.8102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1/+Lw8Ry2x0YmP0SytXovC9aSq7SYp/Vi1xqywhB8xuOhZE+x5nMgjGapO3vLNJF1Dfdk39hF0k4hVMV07sWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3555
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-14_05:2019-11-14,2019-11-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 mlxscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911140179
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3VyZSBJIHdpbGwgdXBkYXRlIGNvbW1pdCBtZXNzYWdlDQoNCu+7v09uIDExLzE0LzE5LCAxOjQx
IFBNLCAiQXNtYWEgTW5lYmhpIiA8QXNtYWFAbWVsbGFub3guY29tPiB3cm90ZToNCg0KICAgIA0K
ICAgIC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQogICAgRnJvbTogVmlqYXkgS2hlbWthIDx2
aWpheWtoZW1rYUBmYi5jb20+IA0KICAgIFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxNCwgMjAx
OSAxOjU0IFBNDQogICAgVG86IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+OyBDb3Jl
eSBNaW55YXJkIDxtaW55YXJkQGFjbS5vcmc+OyBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRl
PjsgR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IGxpbnV4
LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG9wZW5p
cG1pLWRldmVsb3BlckBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQNCiAgICBDYzogdmlqYXlraGVta2FA
ZmIuY29tOyBjbWlueWFyZEBtdmlzdGEuY29tOyBBc21hYSBNbmViaGkgPEFzbWFhQG1lbGxhbm94
LmNvbT47IGpvZWxAam1zLmlkLmF1OyBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZzsgc2Rh
c2FyaUBmYi5jb20NCiAgICBTdWJqZWN0OiBbUEFUQ0ggdjVdIGRyaXZlcnM6IGlwbWk6IFN1cHBv
cnQgcmF3IGkyYyBwYWNrZXQgaW4gSVBNQg0KICAgIA0KICAgIE1hbnkgSVBNQiBkZXZpY2VzIGRv
ZXNuJ3Qgc3VwcG9ydCBzbWJ1cyBwcm90b2NvbCBhbmQgY3VycmVudCBkcml2ZXIgc3VwcG9ydCBv
bmx5IHNtYnVzIGRldmljZXMuIEFkZGVkIHN1cHBvcnQgZm9yIHJhdyBpMmMgcGFja2V0cy4NCiAg
ICANCiAgICBVc2VyIGNhbiBkZWZpbmUgaTJjLXByb3RvY29sIGluIGRldmljZSB0cmVlIHRvIHVz
ZSBpMmMgcmF3IHRyYW5zZmVyLg0KICAgIA0KICAgIEFzbWFhID4+IEl0IHdvdWxkIGJlIGdvb2Qg
aWYgeW91IGNhbiByZXBocmFzZSB0aGUgYWJvdmUgZGVzY3JpcHRpb24gYXMgZm9sbG93czoNCiAg
ICAiVGhlIGlwbWJfZGV2X2ludCBkcml2ZXIgb25seSBzdXBwb3J0cyB0aGUgc21idXMgcHJvdG9j
b2wgYXQgdGhlIG1vbWVudC4gQWRkIHN1cHBvcnQgZm9yIHRoZSBpMmMgcHJvdG9jb2wgYXMgd2Vs
bC4gVGhlcmUgd2lsbCBiZSBhIHZhcmlhYmxlIHBhc3NlZCBieSB0aGUgZGV2aWNlIHRyZWUgb3Ig
QUNQSSB0YWJsZSB3aGljaCBkZXRlcm1pbmVzIHdoZXRoZXIgdGhlIHByb3RvY29sIGlzIGkyYyBv
ciBzbWJ1cy4iDQogICAgDQogICAgT3IgYXQgbGVhc3QgZml4IHRoZSBmb2xsb3dpbmc6IA0KICAg
ICJNYW55IElQTUIgZGV2aWNlcyBkb2Vzbid0IiAtPiAiTWFueSBJUE1CIGRldmljZXMgZG9uJ3Qi
DQogICAgImN1cnJlbnQgZHJpdmVyIHN1cHBvcnQiIC0+ICJjdXJyZW50IGRyaXZlciBzdXBwb3J0
cyINCiAgICANCiAgICBCZXNpZGVzIG15IGFib3ZlIGNvbW1lbnQ6DQogICAgUmV2aWV3ZWQtYnk6
IEFzbWFhIE1uZWJoaSA8YXNtYWFAbWVsbGFub3guY29tPg0KICAgIA0KICAgIFNpZ25lZC1vZmYt
Ynk6IFZpamF5IEtoZW1rYSA8dmlqYXlraGVta2FAZmIuY29tPg0KICAgIC0tLQ0KICAgICBEb2N1
bWVudGF0aW9uL0lQTUIudHh0ICAgICAgICAgICB8ICA0ICsrKysNCiAgICAgZHJpdmVycy9jaGFy
L2lwbWkvaXBtYl9kZXZfaW50LmMgfCAyOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
ICAgICAyIGZpbGVzIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykNCiAgICANCiAgICBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9JUE1CLnR4dCBiL0RvY3VtZW50YXRpb24vSVBNQi50eHQgaW5k
ZXggYTZlZDhiNjhiZDBmLi43YTAyM2JlZmY5NzYgMTAwNjQ0DQogICAgLS0tIGEvRG9jdW1lbnRh
dGlvbi9JUE1CLnR4dA0KICAgICsrKyBiL0RvY3VtZW50YXRpb24vSVBNQi50eHQNCiAgICBAQCAt
NzEsOSArNzEsMTMgQEAgYikgRXhhbXBsZSBmb3IgZGV2aWNlIHRyZWU6DQogICAgICAgICAgICAg
IGlwbWJAMTAgew0KICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiaXBtYi1kZXYi
Ow0KICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDEwPjsNCiAgICArICAgICAgICAgICAg
ICAgICBpMmMtcHJvdG9jb2w7DQogICAgICAgICAgICAgIH07DQogICAgIH07DQogICAgIA0KICAg
ICtJZiB4bWl0IG9mIGRhdGEgdG8gYmUgZG9uZSB1c2luZyByYXcgaTJjIGJsb2NrIHZzIHNtYnVz
IHRoZW4gDQogICAgKyJpMmMtcHJvdG9jb2wiIG5lZWRzIHRvIGJlIGRlZmluZWQgYXMgYWJvdmUu
DQogICAgKw0KICAgICAyKSBNYW51YWxseSBmcm9tIExpbnV4Og0KICAgICBtb2Rwcm9iZSBpcG1i
LWRldi1pbnQNCiAgICAgDQogICAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9pcG1pL2lwbWJf
ZGV2X2ludC5jIGIvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50LmMNCiAgICBpbmRleCBh
ZTNiZmJhMjc1MjYuLjY4YTI1NGMwZGQ5MiAxMDA2NDQNCiAgICAtLS0gYS9kcml2ZXJzL2NoYXIv
aXBtaS9pcG1iX2Rldl9pbnQuYw0KICAgICsrKyBiL2RyaXZlcnMvY2hhci9pcG1pL2lwbWJfZGV2
X2ludC5jDQogICAgQEAgLTYzLDYgKzYzLDcgQEAgc3RydWN0IGlwbWJfZGV2IHsNCiAgICAgCXNw
aW5sb2NrX3QgbG9jazsNCiAgICAgCXdhaXRfcXVldWVfaGVhZF90IHdhaXRfcXVldWU7DQogICAg
IAlzdHJ1Y3QgbXV0ZXggZmlsZV9tdXRleDsNCiAgICArCWJvb2wgaXNfaTJjX3Byb3RvY29sOw0K
ICAgICB9Ow0KICAgICANCiAgICAgc3RhdGljIGlubGluZSBzdHJ1Y3QgaXBtYl9kZXYgKnRvX2lw
bWJfZGV2KHN0cnVjdCBmaWxlICpmaWxlKSBAQCAtMTEyLDYgKzExMywyNSBAQCBzdGF0aWMgc3Np
emVfdCBpcG1iX3JlYWQoc3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191c2VyICpidWYsIHNpemVf
dCBjb3VudCwNCiAgICAgCXJldHVybiByZXQgPCAwID8gcmV0IDogY291bnQ7DQogICAgIH0NCiAg
ICAgDQogICAgK3N0YXRpYyBpbnQgaXBtYl9pMmNfd3JpdGUoc3RydWN0IGkyY19jbGllbnQgKmNs
aWVudCwgdTggKm1zZywgdTggYWRkcikgDQogICAgK3sNCiAgICArCXN0cnVjdCBpMmNfbXNnIGky
Y19tc2c7DQogICAgKw0KICAgICsJLyoNCiAgICArCSAqIHN1YnRyYWN0IDEgYnl0ZSAocnFfc2Ep
IGZyb20gdGhlIGxlbmd0aCBvZiB0aGUgbXNnIHBhc3NlZCB0bw0KICAgICsJICogcmF3IGkyY190
cmFuc2Zlcg0KICAgICsJICovDQogICAgKwlpMmNfbXNnLmxlbiA9IG1zZ1tJUE1CX01TR19MRU5f
SURYXSAtIDE7DQogICAgKw0KICAgICsJLyogQXNzaWduIG1lc3NhZ2UgdG8gYnVmZmVyIGV4Y2Vw
dCBmaXJzdCAyIGJ5dGVzIChsZW5ndGggYW5kIGFkZHJlc3MpICovDQogICAgKwlpMmNfbXNnLmJ1
ZiA9IG1zZyArIDI7DQogICAgKw0KICAgICsJaTJjX21zZy5hZGRyID0gYWRkcjsNCiAgICArCWky
Y19tc2cuZmxhZ3MgPSBjbGllbnQtPmZsYWdzICYgSTJDX0NMSUVOVF9QRUM7DQogICAgKw0KICAg
ICsJcmV0dXJuIGkyY190cmFuc2ZlcihjbGllbnQtPmFkYXB0ZXIsICZpMmNfbXNnLCAxKTsgfQ0K
ICAgICsNCiAgICAgc3RhdGljIHNzaXplX3QgaXBtYl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwg
Y29uc3QgY2hhciBfX3VzZXIgKmJ1ZiwNCiAgICAgCQkJc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBw
b3MpDQogICAgIHsNCiAgICBAQCAtMTMzLDYgKzE1MywxMiBAQCBzdGF0aWMgc3NpemVfdCBpcG1i
X3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLCBjb25zdCBjaGFyIF9fdXNlciAqYnVmLA0KICAgICAJ
cnFfc2EgPSBHRVRfN0JJVF9BRERSKG1zZ1tSUV9TQV84QklUX0lEWF0pOw0KICAgICAJbmV0Zl9y
cV9sdW4gPSBtc2dbTkVURk5fTFVOX0lEWF07DQogICAgIA0KICAgICsJLyogQ2hlY2sgaTJjIGJs
b2NrIHRyYW5zZmVyIHZzIHNtYnVzICovDQogICAgKwlpZiAoaXBtYl9kZXYtPmlzX2kyY19wcm90
b2NvbCkgew0KICAgICsJCXJldCA9IGlwbWJfaTJjX3dyaXRlKGlwbWJfZGV2LT5jbGllbnQsIG1z
ZywgcnFfc2EpOw0KICAgICsJCXJldHVybiAocmV0ID09IDEpID8gY291bnQgOiByZXQ7DQogICAg
Kwl9DQogICAgKw0KICAgICAJLyoNCiAgICAgCSAqIHN1YnRyYWN0IHJxX3NhIGFuZCBuZXRmX3Jx
X2x1biBmcm9tIHRoZSBsZW5ndGggb2YgdGhlIG1zZyBwYXNzZWQgdG8NCiAgICAgCSAqIGkyY19z
bWJ1c194ZmVyDQogICAgQEAgLTMwMiw2ICszMjgsOSBAQCBzdGF0aWMgaW50IGlwbWJfcHJvYmUo
c3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCiAgICAgCWlmIChyZXQpDQogICAgIAkJcmV0dXJu
IHJldDsNCiAgICAgDQogICAgKwlpcG1iX2Rldi0+aXNfaTJjX3Byb3RvY29sDQogICAgKwkJPSBk
ZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKCZjbGllbnQtPmRldiwgImkyYy1wcm90b2NvbCIpOw0K
ICAgICsNCiAgICAgCWlwbWJfZGV2LT5jbGllbnQgPSBjbGllbnQ7DQogICAgIAlpMmNfc2V0X2Ns
aWVudGRhdGEoY2xpZW50LCBpcG1iX2Rldik7DQogICAgIAlyZXQgPSBpMmNfc2xhdmVfcmVnaXN0
ZXIoY2xpZW50LCBpcG1iX3NsYXZlX2NiKTsNCiAgICAtLQ0KICAgIDIuMTcuMQ0KICAgIA0KICAg
IA0KDQo=
