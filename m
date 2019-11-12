Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EEAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC3F21872
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="F9+l4XxE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="OvhhLp4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfKLXTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:19:49 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4192 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726910AbfKLXTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:19:49 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xACN5f8W006905;
        Tue, 12 Nov 2019 15:19:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=3RPtls3wC8qmR4ZREgv0ktTSnlfe16/fvGizXg2ixx0=;
 b=F9+l4XxEJL8GIisOMhPk8mzA/2yRDq/sb3/LZhVQOSjjrpHmx9sL7zF/8GjxWKiCi4Cc
 cRGfY2b/0V3gt8IF68NOA2p+PgptIGS9twKB8R5RfOJO1ly9UmYQED+SIs2Ivpp0Zj5t
 MHFGySLsE8xsSbynbT5ogQxXxZXvIxwJ5Qo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w7prjcsm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Nov 2019 15:19:22 -0800
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 12 Nov 2019 15:19:21 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Nov 2019 15:19:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hW76GLe/XOf4XmdTpIpbVS/7uc+MXL4XNa8gF/kAmKkjNynbrwAz/u7MEt2ammXbfPT/yNVnpEsNJnp0yksAIINTT8tbIhVO3V5OxZl9+GG20n+9YjTuSQQMc292x8hGL44JV3UqMdms3ZkNi1MKFo8kZgqA1DeCZ1m9mPcy2HAn/LQHfpIWP7ak34Owshawcv5pqEZXU7HX4Qn1C6nJq8cvboYmLHSpbLN961eK10nGmKw+YuhWTjqYq1oxovvJl7+YvK75ndJ7p0Ltf519YhtQrph2vBo4zxM2sEsYVdayfbGSneS3zRJIu+R36jlG5Njj0sB439Pb2+FyrzLcAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RPtls3wC8qmR4ZREgv0ktTSnlfe16/fvGizXg2ixx0=;
 b=HGMQEmK/C14Z8lmV7TP4tVEvcYJUJ/pLGaYeIZkN/4n4nM5NvR+nwZHWd/YsEJA3Rnw2Jqdyt21o4QLtoOeUfKETeDi5jRI5UtdB5Fn8YvQyy8fhX1Z1yw8H9478EoMWS0BLfNabl/ZgTy6q66C8bWf1DVsUW/gVIOPU+NxDOzDk5OxKVe9GYWaUZJewbTZIfKocY/AkOEJPlqGetELbWd/UTPQVqnU9aeKjMGXitT1+V1VBS+mnYS2wi+L8tqEIJ2rIzy2bkQbo02x9p8RRj7QQs7TICPToMGjRo15aQNW7slfFR4yxSAgHKNQcAhZ3UDNNl5Ijd54pEIBG+bpKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RPtls3wC8qmR4ZREgv0ktTSnlfe16/fvGizXg2ixx0=;
 b=OvhhLp4Ve6C54/tJFYbpmp3zP20YOvVHltPdhOshv+RiCPSbRlvJsQ/TKcFOP4cP+AwQsCNGgme3sGYoiB02+mCGwk2UZD+aCs8tb0St/YOFuTS+Wsf3lehckMuLTjTNRjE/qEE1QqAL4N2nz+3IQXyE6Jn5eliQ+3p9eU87mto=
Received: from BY5PR15MB3636.namprd15.prod.outlook.com (52.133.252.91) by
 BY5PR15MB3619.namprd15.prod.outlook.com (52.133.253.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 23:19:20 +0000
Received: from BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b]) by BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b%4]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 23:19:20 +0000
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
Subject: Re: [PATCH 2/2] drivers: ipmi: Modify max length of IPMB packet
Thread-Topic: [PATCH 2/2] drivers: ipmi: Modify max length of IPMB packet
Thread-Index: AQHVmQJeBnbge6VCjUulKeqNucSkKaeHfQWA///xaoCAAI9UAIAAGvMA//+OYQA=
Date:   Tue, 12 Nov 2019 23:19:20 +0000
Message-ID: <2AD8C7AD-DBE2-4F95-9818-16720A5B7AFA@fb.com>
References: <20191112023610.3644314-1-vijaykhemka@fb.com>
 <20191112023610.3644314-2-vijaykhemka@fb.com>
 <20191112124845.GE2882@minyard.net>
 <7BC487D6-6ACA-46CE-A751-8367FEDEE647@fb.com>
 <20191112202932.GJ2882@minyard.net>
 <DB6PR0501MB27127CF534336BDEB5D005FFDA770@DB6PR0501MB2712.eurprd05.prod.outlook.com>
In-Reply-To: <DB6PR0501MB27127CF534336BDEB5D005FFDA770@DB6PR0501MB2712.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::1:8011]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83a82e6a-7091-471c-9f48-08d767c6bf5d
x-ms-traffictypediagnostic: BY5PR15MB3619:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB3619DB17552A97A223368CFFDD770@BY5PR15MB3619.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(396003)(136003)(346002)(199004)(189003)(13464003)(256004)(66556008)(91956017)(71200400001)(81156014)(25786009)(66946007)(81166006)(76116006)(8936002)(99286004)(71190400001)(8676002)(36756003)(110136005)(54906003)(64756008)(5660300002)(316002)(14444005)(66476007)(6246003)(66446008)(4326008)(86362001)(76176011)(53546011)(46003)(6116002)(229853002)(102836004)(6506007)(11346002)(446003)(14454004)(305945005)(6512007)(33656002)(7736002)(2501003)(2906002)(478600001)(186003)(6486002)(2616005)(486006)(6436002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR15MB3619;H:BY5PR15MB3636.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kNbTKsWCOvcZSzomkjA3rGxNwMWxQhwOoiHyXqc/UwQtXniRIBnXV+gl0IelVQqbLtK2LUtXvFOsnYFqGnlcoWFQH2thSyDGfnQMKfK1Bd/bIgzEyUOA2HVw3utYEFsZfdCRgv40MoYP2Ub+V0o4UA4t440putfWFwtM6KicMnZnuo/+w6PW0RHA57wAx2eHjf/OiC+WGLgThJinPLBIMwl19To0rWXc2aLcgb9TRMJGBIzv8Ok+Q+fRkAw7+zaLaU7USwu/I6cKsuDxDgVGe0hshlEJ+gQksJExOL3yiryjiLxxh+7yLjBu90q190j2YtN0cGx34UheoWSmOCkC3qCNKYRsq7gv9+dMPzHQXh7ndNsYbN3A43zCBvaAMPUHG9UZiCvZ99Scw2PefiEaG8mn0FalR1us9K8GhqBuSHuiklgj+SQydbrI+6A/3nAy
Content-Type: text/plain; charset="utf-8"
Content-ID: <86B3BE64B134B64B8607312E20FF3954@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a82e6a-7091-471c-9f48-08d767c6bf5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 23:19:20.6414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPJ7aYYNglIP7cMJo3a/Qi2oFkvc3S8+C8JFSL3zXiwySCaZGrOGvLqH+r31MihNIqCy1jq3Q2hK48tDqWm9qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3619
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-12_09:2019-11-11,2019-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911120199
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDExLzEyLzE5LCAyOjA2IFBNLCAiQXNtYWEgTW5lYmhpIiA8QXNtYWFAbWVsbGFu
b3guY29tPiB3cm90ZToNCg0KICAgIEFsc28sIGxldCBtZSBjbGFyaWZ5IG9uZSB0aGluZy4gSXQg
ZG9lc24ndCBtYXR0ZXIgaG93IGJpZyB0aGUgcmVzcG9uc2UgaXMuIEluIG15IHRlc3RpbmcsIEkg
YWxzbyBoYWQgc29tZSByZXNwb25zZXMgdGhhdCBhcmUgb3ZlciAxMjggYnl0ZXMsIGFuZCB0aGlz
IGRyaXZlciBzdGlsbCB3b3Jrcy4gSXQgaXMgdGhlIHVzZXIgc3BhY2UgcHJvZ3JhbSB3aGljaCBk
ZXRlcm1pbmVzIHRoZSBsYXN0IGJ5dGVzIHJlY2VpdmVkLiBUaGUgMTI4IGJ5dGVzIGlzIHRoZSBt
YXggbnVtYmVyIG9mIGJ5dGVzIGhhbmRsZWQgYnkgeW91ciBpMmMvc21idXMgZHJpdmVyIGF0IGVh
Y2ggaTJjIHRyYW5zYWN0aW9uLiBNeSBpMmMgZHJpdmVyIGNhbiBvbmx5IHRyYW5zbWl0IDEyOCBi
eXRlcyBhdCBhIHRpbWUuIFNvIGp1c3QgbGlrZSBDb3JleSBwb2ludGVkIG91dCwgaXQgd291bGQg
YmUgYmV0dGVyIHRvIHBhc3MgdGhpcyB0aHJvdWdoIEFDUEkvZGV2aWNlIHRyZWUuDQoNCkluIGNh
c2Ugb2Ygc21idXMgdHJhbnNmZXIgaXQgd2lsbCB3b3JrIGJ1dCBpZiB5b3UgYXJlIGRvaW5nIGRp
cmVjdCBpMmNfYmxvY2sgd2hlcmUgeW91IGRvbid0IA0KZnJhZ21lbnQgYW5kIHRyYW5zZmVyIGNv
bXBsZXRlIGJsb2NrLiBJIGFtIGRvaW5nIHdlbGwgd2l0aCBteSB0ZXN0aW5nLiBJIGhhdmUgc2Vu
dCB2MiBmb3IgDQpmaXJzdCBwYXRjaCB1c2luZyBpb2N0bC4gQW5kIHZlcmlmaWVkIHRoZSBzYW1l
LiBJdCB3b3JrcyBwZXJmZWN0bHkgZmluZS4NCiAgICANCiAgICAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KICAgIEZyb206IENvcmV5IE1pbnlhcmQgPHRjbWlueWFyZEBnbWFpbC5jb20+IE9u
IEJlaGFsZiBPZiBDb3JleSBNaW55YXJkDQogICAgU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTIs
IDIwMTkgMzozMCBQTQ0KICAgIFRvOiBWaWpheSBLaGVta2EgPHZpamF5a2hlbWthQGZiLmNvbT4N
CiAgICBDYzogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT47IEdyZWcgS3JvYWgtSGFydG1h
biA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBvcGVuaXBtaS1kZXZlbG9wZXJAbGlzdHMu
c291cmNlZm9yZ2UubmV0OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBjbWlueWFyZEBt
dmlzdGEuY29tOyBBc21hYSBNbmViaGkgPEFzbWFhQG1lbGxhbm94LmNvbT47IGpvZWxAam1zLmlk
LmF1OyBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZzsgU2FpIERhc2FyaSA8c2Rhc2FyaUBm
Yi5jb20+DQogICAgU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRyaXZlcnM6IGlwbWk6IE1vZGlm
eSBtYXggbGVuZ3RoIG9mIElQTUIgcGFja2V0DQogICAgDQogICAgT24gVHVlLCBOb3YgMTIsIDIw
MTkgYXQgMDc6NTY6MzRQTSArMDAwMCwgVmlqYXkgS2hlbWthIHdyb3RlOg0KICAgID4gDQogICAg
PiANCiAgICA+IE9uIDExLzEyLzE5LCA0OjQ4IEFNLCAiQ29yZXkgTWlueWFyZCIgPHRjbWlueWFy
ZEBnbWFpbC5jb20gb24gYmVoYWxmIG9mIG1pbnlhcmRAYWNtLm9yZz4gd3JvdGU6DQogICAgPiAN
CiAgICA+ICAgICBPbiBNb24sIE5vdiAxMSwgMjAxOSBhdCAwNjozNjoxMFBNIC0wODAwLCBWaWph
eSBLaGVta2Egd3JvdGU6DQogICAgPiAgICAgPiBBcyBwZXIgSVBNQiBzcGVjaWZpY2F0aW9uLCBt
YXhpbXVtIHBhY2tldCBzaXplIHN1cHBvcnRlZCBpcyAyNTUsDQogICAgPiAgICAgPiBtb2RpZmll
ZCBNYXggbGVuZ3RoIHRvIDI0MCBmcm9tIDEyOCB0byBhY2NvbW1vZGF0ZSBtb3JlIGRhdGEuDQog
ICAgPiAgICAgDQogICAgPiAgICAgSSBjb3VsZG4ndCBmaW5kIHRoaXMgaW4gdGhlIElQTUIgc3Bl
Y2lmaWNhdGlvbi4NCiAgICA+ICAgICANCiAgICA+ICAgICBJSVJDLCB0aGUgbWF4aW11bSBvbiBJ
MkMgaXMgMzIgYnl0cywgYW5kIHRhYmxlIDYtOSBpbiB0aGUgSVBNSSBzcGVjLA0KICAgID4gICAg
IHVuZGVyICJJUE1CIE91dHB1dCIgc3RhdGVzOiBUaGUgSVBNQiBzdGFuZGFyZCBtZXNzYWdlIGxl
bmd0aCBpcw0KICAgID4gICAgIHNwZWNpZmllZCBhcyAzMiBieXRlcywgbWF4aW11bSwgaW5jbHVk
aW5nIHNsYXZlIGFkZHJlc3MuDQogICAgPiANCiAgICA+IFdlIGFyZSB1c2luZyBJUE1JIE9FTSBt
ZXNzYWdlcyBhbmQgb3VyIHJlc3BvbnNlIHNpemUgaXMgYXJvdW5kIDE1MCANCiAgICA+IGJ5dGVz
IEZvciBzb21lIG9mIHJlc3BvbnNlcy4gVGhhdCdzIHdoeSBJIGhhZCBzZXQgaXQgdG8gMjQwIGJ5
dGVzLg0KICAgIA0KICAgIEhtbS4gIFdlbGwsIHRoYXQgaXMgYSBwcmV0dHkgc2lnbmlmaWNhbnQg
dmlvbGF0aW9uIG9mIHRoZSBzcGVjLCBidXQgdGhlcmUncyBub3RoaW5nIGhhcmQgaW4gdGhlIHBy
b3RvY29sIHRoYXQgcHJvaGliaXRzIGl0LCBJIGd1ZXNzLg0KICAgIA0KICAgIElmIEFzbWFhIGlz
IG9rIHdpdGggdGhpcywgSSdtIG9rIHdpdGggaXQsIHRvby4NCiAgICANCiAgICAtY29yZXkNCiAg
ICANCiAgICA+ICAgICANCiAgICA+ICAgICBJJ20gbm90IHN1cmUgd2hlcmUgMTI4IGNhbWUgZnJv
bSwgYnV0IG1heWJlIGl0IHNob3VsZCBiZSByZWR1Y2VkIHRvIDMxLg0KICAgID4gICAgIA0KICAg
ID4gICAgIC1jb3JleQ0KICAgID4gICAgIA0KICAgID4gICAgID4gDQogICAgPiAgICAgPiBTaWdu
ZWQtb2ZmLWJ5OiBWaWpheSBLaGVta2EgPHZpamF5a2hlbWthQGZiLmNvbT4NCiAgICA+ICAgICA+
IC0tLQ0KICAgID4gICAgID4gIGRyaXZlcnMvY2hhci9pcG1pL2lwbWJfZGV2X2ludC5jIHwgMiAr
LQ0KICAgID4gICAgID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KICAgID4gICAgID4gDQogICAgPiAgICAgPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFy
L2lwbWkvaXBtYl9kZXZfaW50LmMgYi9kcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYw0K
ICAgID4gICAgID4gaW5kZXggMjQxOWI5YTkyOGIyLi43ZjkxOThiYmNlOTYgMTAwNjQ0DQogICAg
PiAgICAgPiAtLS0gYS9kcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYw0KICAgID4gICAg
ID4gKysrIGIvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9kZXZfaW50LmMNCiAgICA+ICAgICA+IEBA
IC0xOSw3ICsxOSw3IEBADQogICAgPiAgICAgPiAgI2luY2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+
DQogICAgPiAgICAgPiAgI2luY2x1ZGUgPGxpbnV4L3dhaXQuaD4NCiAgICA+ICAgICA+ICANCiAg
ICA+ICAgICA+IC0jZGVmaW5lIE1BWF9NU0dfTEVOCQkxMjgNCiAgICA+ICAgICA+ICsjZGVmaW5l
IE1BWF9NU0dfTEVOCQkyNDANCiAgICA+ICAgICA+ICAjZGVmaW5lIElQTUJfUkVRVUVTVF9MRU5f
TUlOCTcNCiAgICA+ICAgICA+ICAjZGVmaW5lIE5FVEZOX1JTUF9CSVRfTUFTSwkweDQNCiAgICA+
ICAgICA+ICAjZGVmaW5lIFJFUVVFU1RfUVVFVUVfTUFYX0xFTgkyNTYNCiAgICA+ICAgICA+IC0t
IA0KICAgID4gICAgID4gMi4xNy4xDQogICAgPiAgICAgPg0KICAgID4gICAgIA0KICAgID4gDQog
ICAgDQoNCg==
