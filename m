Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D57C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F65A217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="V8Cxki9w";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="TTIPLoia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbfKFR6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:58:48 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52108 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726963AbfKFR6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:58:48 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA6HtWil025985;
        Wed, 6 Nov 2019 09:58:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=I2ZXfR0ynkJ/HjJNbo9RptDc/F7F1DuoM6d5E0mAZ5k=;
 b=V8Cxki9wCVGbbmbBNn2x8b1NNmv6ycuqPBEBjj/Pa7njCUwdMzITaZAFE7zXsxZErug6
 cGizgq2BCe8AHgw1GUtEhRrIPp3jHEFGcRm/x0Jxqj9O7DkJvsRjb/it9k/QkSRLLPSF
 IqNBH9hc76EzOQX247i14aaXbYq0fJ/M91k= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2w41ue0de8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 09:58:17 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 6 Nov 2019 09:58:17 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 6 Nov 2019 09:58:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiYrgxZ916L0FKShCdUWj4c2BR9pf+kjY7RPR5HT1o6x82MLk6zUTzuO8yrpdJXx0M11WIREeabcACKHw4dxvYN5z3ry1P9c0UYu9EkpzI4djeGc9ZqW8I6EDTdioRYYbkSKxVTcoBz+GSLH16u7LOC1spx+8LF5qwWUvR0Z6IyUD3h38/mSs3FGDKyJMUM3DRAWigNI/c7xtdeJijreG8cuop/8aMbSMktEfc81BVN18a/EfXoXWOjBt1L7bS+KbSi1cvUtWU/1kATouS8YSZpQKlDBCH0p3ze0mkjm1R05XGQglqX2aVLlYVek7CoXVA0EuWh3kQGOOyRrTI9WAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2ZXfR0ynkJ/HjJNbo9RptDc/F7F1DuoM6d5E0mAZ5k=;
 b=iIFyNS13JlokHwKe7QB5PoN+Gg5u4CyyFtIarI0GzdCLkh529oXKNnIkLyj0JK8tEYlvQoJIMvuClm0/H45XeC9k5UzGBOI2gUrTRNNSC1AoAKbQ2fsnjZ0axRzLvwMC97OW61seNAMKf7k+lvs66TcdcY32S/6u3XiOCIzKFnPQ2Q2HEc7DYWLkrT8+sNU6PNWYbHZKZpzCb8v6pVtm6qzpHoers1waud2y3cPFgsW/aHp0QKtA6TARVNsQbuZMGRp7Ttq6dz8a48an/ujLbDTVaUEzHxuBIddCw0XG6ygm68Wr7ONHnFpeAnx7lDwnkphp4HuDmgZOLzeZeMHYPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2ZXfR0ynkJ/HjJNbo9RptDc/F7F1DuoM6d5E0mAZ5k=;
 b=TTIPLoia05N/YT41OxFjFMCcFWAmnpNguE6vzSCp7jcFqw4oB44hd03x10VyMQWsisDXq5JkdubTkfDBKsDgcWrd7IiKICzgm8kCQ+ByzF0QrV0pwycBz7A7EQ54sdDdGidPmiqdRYsI0QvU4LdnCC0pyjkVaVj5aecuYxkyql0=
Received: from BY5PR15MB3636.namprd15.prod.outlook.com (52.133.252.91) by
 BY5PR15MB3682.namprd15.prod.outlook.com (52.133.253.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 17:58:15 +0000
Received: from BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b]) by BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b%4]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 17:58:15 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Asmaa Mnebhi <Asmaa@mellanox.com>,
        "minyard@acm.org" <minyard@acm.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cminyard@mvista.com" <cminyard@mvista.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>
Subject: Re: [PATCH] drivers: ipmi: Support for both IPMB Req and Resp
Thread-Topic: [PATCH] drivers: ipmi: Support for both IPMB Req and Resp
Thread-Index: AQHVlBIxmnW6XN3w/UGGMK9IULGPI6d9URQA///fowCAAQ0tgP//q2AA
Date:   Wed, 6 Nov 2019 17:58:15 +0000
Message-ID: <E2EAF8D1-1C16-4468-A34E-5DC3E0CE5224@fb.com>
References: <20191105194732.1521963-1-vijaykhemka@fb.com>
 <20191106005332.GA2754@minyard.net>
 <63FB7A84-EF61-45CA-9CA7-9564F28B5D42@fb.com>
 <DB6PR0501MB2712BEF34969BF377E71B691DA790@DB6PR0501MB2712.eurprd05.prod.outlook.com>
In-Reply-To: <DB6PR0501MB2712BEF34969BF377E71B691DA790@DB6PR0501MB2712.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::2:11f6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bfe6752-1410-4ce6-9f61-08d762e2e5bc
x-ms-traffictypediagnostic: BY5PR15MB3682:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB3682722881FE27386830DCF8DD790@BY5PR15MB3682.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(346002)(376002)(13464003)(189003)(199004)(64756008)(6506007)(7736002)(2501003)(256004)(476003)(2906002)(36756003)(11346002)(102836004)(54906003)(6512007)(316002)(6246003)(66556008)(6436002)(14444005)(71200400001)(71190400001)(14454004)(2616005)(6486002)(4326008)(66446008)(186003)(8676002)(25786009)(478600001)(53546011)(81166006)(446003)(46003)(86362001)(5660300002)(8936002)(305945005)(6116002)(66476007)(76116006)(110136005)(486006)(99286004)(33656002)(81156014)(229853002)(66946007)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR15MB3682;H:BY5PR15MB3636.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R/xiLKZNGlnCrUNyvG+HCCAgnzDKTCS3Zsvj6a8jxU8i0uHWXAOJ+pRuNEw+a9FwHCW03cTCg/W4fzNBiE0rXXy35BRmSxAZQnEzZX4StPtPLlaxlQRw+vCLIFn4CEfkq9hwTNuIB3nzR57BU+69N3//zZDh6zZU72KgxL6KPFVxBYmVGZq5HvrRMIa8jvyuBJcQFXZy8bVixZmvxLZfb3yhM/XglMqxlE4j53PNp1jqpTVn9GH8KeTAN5rmh9+abFd9R91Q7XqyJAQvC5vdDFhIka4oab1NOFeEVTs7Nmy4ng7xiHQISLMjbS9VbuyZSPWH8R3metlAYdPsijacWxu4a7zPTUgSU/GNwEwRN6aB52VsZEMO40BRxkYmAYLKcLH3lNZJLqFo7dnELI7iXsq/ZDGKp5Ail16p3OzqXiNuhC08nXUZQT2DwG9wiQAH
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF8E3AAD3C2D60429E2D2CD0F3A356BC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfe6752-1410-4ce6-9f61-08d762e2e5bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 17:58:15.0790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tLvE5IuKH7jq1J99HoXcvM3Rb2ZHaJQx2TS33HviZzj16/cdr0iwk0YKqKlSsfz2h9HAm6IhmR2DoxmVe5s3eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3682
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_06:2019-11-06,2019-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 mlxscore=0 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911060174
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIEFzbWFhLA0KSSB3aWxsIGhhdmUgdjIgc29vbi4NCg0KUmVnYXJkcw0KLVZpamF5DQoN
Cu+7v09uIDExLzYvMTksIDc6MDEgQU0sICJBc21hYSBNbmViaGkiIDxBc21hYUBtZWxsYW5veC5j
b20+IHdyb3RlOg0KDQogICAgDQogICAgDQogICAgLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CiAgICBGcm9tOiBWaWpheSBLaGVta2EgPHZpamF5a2hlbWthQGZiLmNvbT4gDQogICAgU2VudDog
V2VkbmVzZGF5LCBOb3ZlbWJlciA2LCAyMDE5IDE6NTggQU0NCiAgICBUbzogbWlueWFyZEBhY20u
b3JnDQogICAgQ2M6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBHcmVnIEtyb2FoLUhh
cnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgb3BlbmlwbWktZGV2ZWxvcGVyQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldDsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgY21pbnlh
cmRAbXZpc3RhLmNvbTsgQXNtYWEgTW5lYmhpIDxBc21hYUBtZWxsYW5veC5jb20+OyBqb2VsQGpt
cy5pZC5hdTsgbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7IFNhaSBEYXNhcmkgPHNkYXNh
cmlAZmIuY29tPg0KICAgIFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRyaXZlcnM6IGlwbWk6IFN1cHBv
cnQgZm9yIGJvdGggSVBNQiBSZXEgYW5kIFJlc3ANCiAgICANCiAgICANCiAgICANCiAgICBPbiAx
MS81LzE5LCA0OjU0IFBNLCAiQ29yZXkgTWlueWFyZCIgPHRjbWlueWFyZEBnbWFpbC5jb20gb24g
YmVoYWxmIG9mIG1pbnlhcmRAYWNtLm9yZz4gd3JvdGU6DQogICAgDQogICAgICAgIE9uIFR1ZSwg
Tm92IDA1LCAyMDE5IGF0IDExOjQ3OjMxQU0gLTA4MDAsIFZpamF5IEtoZW1rYSB3cm90ZToNCiAg
ICAgICAgPiBSZW1vdmVkIGNoZWNrIGZvciByZXF1ZXN0IG9yIHJlc3BvbnNlIGluIElQTUIgcGFj
a2V0cyBjb21pbmcgZnJvbQ0KICAgICAgICA+IGRldmljZSBhcyB3ZWxsIGFzIGZyb20gaG9zdC4g
Tm93IGl0IHN1cHBvcnRzIGJvdGggd2F5IGNvbW11bmljYXRpb24NCiAgICAgICAgPiB0byBkZXZp
Y2UgdmlhIElQTUIuIEJvdGggcmVxdWVzdCBhbmQgcmVzcG9uc2Ugd2lsbCBiZSBwYXNzZWQgdG8N
CiAgICAgICAgPiBhcHBsaWNhdGlvbi4NCiAgICAgICAgPiANCiAgICAgICAgPiBTaWduZWQtb2Zm
LWJ5OiBWaWpheSBLaGVta2EgPHZpamF5a2hlbWthQGZiLmNvbT4NCiAgICAgICAgPiAtLS0NCiAg
ICAgICAgPiAgZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50LmMgfCAyOSArLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KICAgICAgICA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDI4IGRlbGV0aW9ucygtKQ0KICAgICAgICA+IA0KICAgICAgICA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYyBiL2RyaXZlcnMvY2hhci9pcG1pL2lw
bWJfZGV2X2ludC5jDQogICAgICAgID4gaW5kZXggMjg1ZTBiOGY5YTk3Li43MjAxZmRiNTMzZDgg
MTAwNjQ0DQogICAgICAgID4gLS0tIGEvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50LmMN
CiAgICAgICAgPiArKysgYi9kcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYw0KICAgICAg
ICA+IEBAIC0xMzMsOSArMTMzLDYgQEAgc3RhdGljIHNzaXplX3QgaXBtYl93cml0ZShzdHJ1Y3Qg
ZmlsZSAqZmlsZSwgY29uc3QgY2hhciBfX3VzZXIgKmJ1ZiwNCiAgICAgICAgPiAgCXJxX3NhID0g
R0VUXzdCSVRfQUREUihtc2dbUlFfU0FfOEJJVF9JRFhdKTsNCiAgICAgICAgPiAgCW5ldGZfcnFf
bHVuID0gbXNnW05FVEZOX0xVTl9JRFhdOw0KICAgICAgICA+ICANCiAgICAgICAgPiAtCWlmICgh
KG5ldGZfcnFfbHVuICYgTkVURk5fUlNQX0JJVF9NQVNLKSkNCiAgICAgICAgPiAtCQlyZXR1cm4g
LUVJTlZBTDsNCiAgICAgICAgPiAtDQogICAgICAgID4gIAkvKg0KICAgICAgICA+ICAJICogc3Vi
dHJhY3QgcnFfc2EgYW5kIG5ldGZfcnFfbHVuIGZyb20gdGhlIGxlbmd0aCBvZiB0aGUgbXNnIHBh
c3NlZCB0bw0KICAgICAgICA+ICAJICogaTJjX3NtYnVzX3hmZXINCiAgICAgICAgPiBAQCAtMjAz
LDI4ICsyMDAsNiBAQCBzdGF0aWMgdTggaXBtYl92ZXJpZnlfY2hlY2tzdW0xKHN0cnVjdCBpcG1i
X2RldiAqaXBtYl9kZXYsIHU4IHJzX3NhKQ0KICAgICAgICA+ICAJCWlwbWJfZGV2LT5yZXF1ZXN0
LmNoZWNrc3VtMSk7DQogICAgICAgID4gIH0NCiAgICAgICAgPiAgDQogICAgICAgID4gLXN0YXRp
YyBib29sIGlzX2lwbWJfcmVxdWVzdChzdHJ1Y3QgaXBtYl9kZXYgKmlwbWJfZGV2LCB1OCByc19z
YSkNCiAgICAgICAgPiAtew0KICAgICAgICA+IC0JaWYgKGlwbWJfZGV2LT5tc2dfaWR4ID49IElQ
TUJfUkVRVUVTVF9MRU5fTUlOKSB7DQogICAgICAgID4gLQkJaWYgKGlwbWJfdmVyaWZ5X2NoZWNr
c3VtMShpcG1iX2RldiwgcnNfc2EpKQ0KICAgICAgICA+IC0JCQlyZXR1cm4gZmFsc2U7DQogICAg
ICAgIA0KICAgICAgICBZb3Ugc3RpbGwgbmVlZCB0byBjaGVjayB0aGUgbWVzc2FnZSBsZW5ndGgg
YW5kIGNoZWNrc3VtLCB5b3UganVzdCBuZWVkDQogICAgICAgIHRvIGlnbm9yZSB0aGUgcmVxL3Jl
c3AgYml0Lg0KICAgIFllcyB5b3UgYXJlIHJpZ2h0LCBJIHdhcyBsb29raW5nIGZvciBjaGVja3N1
bSBjb2RlIGFmdGVyIHJlbW92aW5nIGl0IF9fLiBJIHdpbGwgbW9kaWZ5IGl0Lg0KICAgIA0KICAg
IEJlc2lkZXMgQ29yZXkncyBjb21tZW50LCBsb29rcyBnb29kIHRvIG1lLiBUaGUgbG9naWMgc2hv
dWxkIGJlIHNvbWV0aGluZyBsaWtlIHRoaXM6DQogICAgc3RhdGljIGJvb2wgaXNfaXBtYl9tc2co
c3RydWN0IGlwbWJfZGV2ICppcG1iX2RldiwgdTggcnNfc2EpDQogICAgIHsNCiAgICAgICAgICAg
ICBpZiAoaXBtYl9kZXYtPm1zZ19pZHggPj0gSVBNQl9SRVFVRVNUX0xFTl9NSU4pIHsNCiAgICAg
ICAgICAgICAgICAgICAgIGlmIChpcG1iX3ZlcmlmeV9jaGVja3N1bTEoaXBtYl9kZXYsIHJzX3Nh
KSkNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KICAgICAgICAg
ICAgIH0gZWxzZSB7DQogICAgICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQogICAgICAg
ICAgICAgfQ0KICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KICAgIH0NCiAgICAgICAgDQogICAg
ICAgIC1jb3JleQ0KICAgICAgICANCiAgICAgICAgPiAtDQogICAgICAgID4gLQkJLyoNCiAgICAg
ICAgPiAtCQkgKiBDaGVjayB3aGV0aGVyIHRoaXMgaXMgYW4gSVBNQiByZXF1ZXN0IG9yDQogICAg
ICAgID4gLQkJICogcmVzcG9uc2UuDQogICAgICAgID4gLQkJICogVGhlIDYgTVNCIG9mIG5ldGZu
X3JzX2x1biBhcmUgZGVkaWNhdGVkIHRvIHRoZSBuZXRmbg0KICAgICAgICA+IC0JCSAqIHdoaWxl
IHRoZSByZW1haW5pbmcgYml0cyBhcmUgZGVkaWNhdGVkIHRvIHRoZSBsdW4uDQogICAgICAgID4g
LQkJICogSWYgdGhlIExTQiBvZiB0aGUgbmV0Zm4gaXMgY2xlYXJlZCwgaXQgaXMgYXNzb2NpYXRl
ZA0KICAgICAgICA+IC0JCSAqIHdpdGggYW4gSVBNQiByZXF1ZXN0Lg0KICAgICAgICA+IC0JCSAq
IElmIHRoZSBMU0Igb2YgdGhlIG5ldGZuIGlzIHNldCwgaXQgaXMgYXNzb2NpYXRlZCB3aXRoDQog
ICAgICAgID4gLQkJICogYW4gSVBNQiByZXNwb25zZS4NCiAgICAgICAgPiAtCQkgKi8NCiAgICAg
ICAgPiAtCQlpZiAoIShpcG1iX2Rldi0+cmVxdWVzdC5uZXRmbl9yc19sdW4gJiBORVRGTl9SU1Bf
QklUX01BU0spKQ0KICAgICAgICA+IC0JCQlyZXR1cm4gdHJ1ZTsNCiAgICAgICAgPiAtCX0NCiAg
ICAgICAgPiAtCXJldHVybiBmYWxzZTsNCiAgICAgICAgPiAtfQ0KICAgICAgICA+IC0NCiAgICAg
ICAgPiAgLyoNCiAgICAgICAgPiAgICogVGhlIElQTUIgcHJvdG9jb2wgb25seSBzdXBwb3J0cyBJ
MkMgV3JpdGVzIHNvIHRoZXJlIGlzIG5vIG5lZWQNCiAgICAgICAgPiAgICogdG8gc3VwcG9ydCBJ
MkNfU0xBVkVfUkVBRCogZXZlbnRzLg0KICAgICAgICA+IEBAIC0yNzMsOSArMjQ4LDcgQEAgc3Rh
dGljIGludCBpcG1iX3NsYXZlX2NiKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsDQogICAgICAg
ID4gIA0KICAgICAgICA+ICAJY2FzZSBJMkNfU0xBVkVfU1RPUDoNCiAgICAgICAgPiAgCQlpcG1i
X2Rldi0+cmVxdWVzdC5sZW4gPSBpcG1iX2Rldi0+bXNnX2lkeDsNCiAgICAgICAgPiAtDQogICAg
ICAgID4gLQkJaWYgKGlzX2lwbWJfcmVxdWVzdChpcG1iX2RldiwgR0VUXzhCSVRfQUREUihjbGll
bnQtPmFkZHIpKSkNCiAgICAgICAgPiAtCQkJaXBtYl9oYW5kbGVfcmVxdWVzdChpcG1iX2Rldik7
DQogICAgICAgID4gKwkJaXBtYl9oYW5kbGVfcmVxdWVzdChpcG1iX2Rldik7DQogICAgDQogICAg
S2VlcCB0aGlzIGxpbmUuDQogICAgICAgID4gIAkJYnJlYWs7DQogICAgICAgID4gIA0KICAgICAg
ICA+ICAJZGVmYXVsdDoNCiAgICAgICAgPiAtLSANCiAgICAgICAgPiAyLjE3LjENCiAgICAgICAg
PiANCiAgICAgICAgDQogICAgDQogICAgDQoNCg==
